using namespace eosdac;

void daccustodian::distributeMeanPay(name dac_id) {
    custodians_table  custodians(get_self(), dac_id.value);
    pending_pay_table pending_pay(get_self(), dac_id.value);
    contr_config      configs = contr_config::get_current_configs(get_self(), dac_id);
    name              owner   = dacdir::dac_for_id(dac_id).owner;

    // Find the mean pay using a temporary vector to hold the requestedpay amounts.
    extended_asset total = configs.requested_pay_max - configs.requested_pay_max;
    int64_t        count = 0;
    for (auto cust : custodians) {
        if (total.get_extended_symbol().get_symbol() == cust.requestedpay.symbol) {
            if (cust.requestedpay.amount <= configs.requested_pay_max.quantity.amount) {
                total += extended_asset(cust.requestedpay, total.contract);
            }
            count += 1;
        }
    }

    print("count during mean pay: ", count, " total: ", total);

    asset meanAsset = count == 0 ? total.quantity : total.quantity / count;

    print("mean asset for pay: ", meanAsset);

    auto pendingPayReceiverSymbolIndex = pending_pay.get_index<"receiversym"_n>();

    if (meanAsset.amount > 0) {
        for (auto cust : custodians) {
            print("\nLooping through custodians : ", cust.cust_name);

            checksum256 idx = pay::getIndex(cust.cust_name, total.get_extended_symbol());
            print("\ncreated a joint index : ", idx);
            auto itrr = pendingPayReceiverSymbolIndex.find(idx);
            if (itrr != pendingPayReceiverSymbolIndex.end() && itrr->receiver == cust.cust_name &&
                itrr->quantity.get_extended_symbol() == total.get_extended_symbol()) {
                pendingPayReceiverSymbolIndex.modify(itrr, same_payer, [&](pay &p) {
                    print("\nAdding to existing amount with : ", extended_asset(meanAsset, total.contract));
                    p.quantity += extended_asset(meanAsset, total.contract);
                });
            } else {
                print("\n Creating pending pay amount with : ", extended_asset(meanAsset, total.contract));

                pending_pay.emplace(owner, [&](pay &p) {
                    p.key      = pending_pay.available_primary_key();
                    p.receiver = cust.cust_name;
                    p.quantity = extended_asset(meanAsset, total.contract);
                });
            }
        }
    }

    print("distribute mean pay");
}

void daccustodian::assertPeriodTime(contr_config &configs, contr_state2 &currentState) {
    time_point_sec timestamp        = time_point_sec(eosio::current_time_point());
    uint32_t       periodBlockCount = (timestamp - currentState.lastperiodtime.sec_since_epoch()).sec_since_epoch();
    check(periodBlockCount > configs.periodlength,
        "ERR::NEWPERIOD_EARLY::New period is being called too soon. Period length is %s periodBlockCount: %s",
        configs.periodlength, periodBlockCount);
}

void daccustodian::allocateCustodians(bool early_election, name dac_id) {

    eosio::print("Configure custodians for the next period.");

    custodians_table custodians(get_self(), dac_id.value);
    candidates_table registered_candidates(get_self(), dac_id.value);
    contr_config     configs      = contr_config::get_current_configs(get_self(), dac_id);
    name             auth_account = dacdir::dac_for_id(dac_id).owner;

    auto byvotes  = registered_candidates.get_index<"byvotesrank"_n>();
    auto cand_itr = byvotes.begin();

    int32_t electcount            = configs.numelected;
    uint8_t currentCustodianCount = 0;

    if (!early_election) {
        eosio::print("Empty the custodians table to get a full set of new custodians based on the current votes.");
        auto cust_itr = custodians.begin();
        while (cust_itr != custodians.end()) {
            const auto &reg_candidate = registered_candidates.get(cust_itr->cust_name.value,
                "ERR::NEWPERIOD_EXPECTED_CAND_NOT_FOUND::Corrupt data: Trying to set a lockup delay on candidate leaving office.");
            registered_candidates.modify(reg_candidate, same_payer, [&](candidate &c) {
                eosio::print("Lockup stake for release delay.");
                c.custodian_end_time_stamp =
                    time_point_sec(current_time_point().sec_since_epoch() + configs.lockup_release_time_delay);
            });
            cust_itr = custodians.erase(cust_itr);
        }
    }

    eosio::print("Select only enough candidates to fill the gaps.");
    for (auto itr = custodians.begin(); itr != custodians.end(); itr++) {
        ++currentCustodianCount;
    }

    while (currentCustodianCount < electcount) {
        check(cand_itr != byvotes.end() && cand_itr->total_votes > 0,
            "ERR::NEWPERIOD_NOT_ENOUGH_CANDIDATES::There are not enough eligible candidates to run new period without causing potential lock out permission structures for this DAC.");

        //  If the candidate is inactive or is already a custodian skip to the next one.
        if (!cand_itr->is_active || custodians.find(cand_itr->candidate_name.value) != custodians.end()) {
            cand_itr++;
        } else {
            custodians.emplace(auth_account, [&](custodian &c) {
                c.cust_name    = cand_itr->candidate_name;
                c.requestedpay = cand_itr->requestedpay;
                c.total_votes  = cand_itr->total_votes;
            });

            byvotes.modify(cand_itr, same_payer, [&](candidate &c) {
                eosio::print("Lockup stake for release delay.");
                c.custodian_end_time_stamp = time_point_sec(current_time_point()) + configs.lockup_release_time_delay;
            });

            currentCustodianCount++;
            cand_itr++;
        }
    }
}

vector<eosiosystem::permission_level_weight> daccustodian::get_perm_level_weights(
    const custodians_table &custodians, const name &dac_id) {
    auto accounts = vector<eosiosystem::permission_level_weight>{};

    for (const auto &cust : custodians) {
        accounts.push_back({
            .permission = getCandidatePermission(cust.cust_name, dac_id),
            .weight     = 1,
        });
    }
    return accounts;
}

void daccustodian::add_auth_to_account(const name &accountToChange, const uint8_t threshold, const name &permission,
    const name &parent, vector<eosiosystem::permission_level_weight> weights, const bool msig) {
    if (msig) {
        weights.push_back({
            .permission = permission_level{MSIG_CONTRACT, "active"_n},
            .weight     = threshold,
        });
        // weights must be sorted to prevent invalid authorization error
        std::sort(weights.begin(), weights.end());
    }

    const auto auth = eosiosystem::authority{.threshold = threshold, .keys = {}, .accounts = weights};
    action(permission_level{accountToChange, "owner"_n}, "eosio"_n, "updateauth"_n,
        std::make_tuple(accountToChange, permission, parent, auth))
        .send();
}

void daccustodian::add_all_auths(const name            &accountToChange,
    const vector<eosiosystem::permission_level_weight> &weights, const name &dac_id, const bool msig) {
    const auto current_config = contr_config::get_current_configs(get_self(), dac_id);

    add_auth_to_account(
        accountToChange, current_config.auth_threshold_high, HIGH_PERMISSION, "active"_n, weights, msig);

    add_auth_to_account(
        accountToChange, current_config.auth_threshold_mid, MEDIUM_PERMISSION, HIGH_PERMISSION, weights, msig);

    add_auth_to_account(
        accountToChange, current_config.auth_threshold_low, LOW_PERMISSION, MEDIUM_PERMISSION, weights, msig);

    add_auth_to_account(accountToChange, 1, ONE_PERMISSION, LOW_PERMISSION, weights, msig);
}

void daccustodian::setMsigAuths(name dac_id) {
    const auto custodians           = custodians_table{get_self(), dac_id.value};
    const auto dac                  = dacdir::dac_for_id(dac_id);
    const auto current_config       = contr_config::get_current_configs(get_self(), dac_id);
    const auto accountToChangeMaybe = dac.account_for_type_maybe(dacdir::MSIGOWNED);
    if (!accountToChangeMaybe) {
        return;
    }
    const auto accountToChange = *accountToChangeMaybe;

    auto weights = get_perm_level_weights(custodians, dac_id);

    add_all_auths(accountToChange, weights, dac_id, true);
}

void daccustodian::setCustodianAuths(name dac_id) {
    const auto custodians = custodians_table{get_self(), dac_id.value};
    const auto dac        = dacdir::dac_for_id(dac_id);
    const auto weights    = get_perm_level_weights(custodians, dac_id);

    add_all_auths(dac.owner, weights, dac_id);
}

asset balance_for_type(const dacdir::dac &dac, const dacdir::account_type type) {
    const auto account = dac.account_for_type(type);
    return eosdac::get_balance_graceful(account, TLM_TOKEN_CONTRACT, TLM_SYM);
}

ACTION daccustodian::claimbudget(const name &dac_id) {
    auto state = contr_state2::get_current_state(get_self(), dac_id);
    check(state.get<time_point_sec>(state_keys::lastclaimbudgettime) < state.lastperiodtime,
        "Claimbudget can only be called once per period");
    const auto dac              = dacdir::dac_for_id(dac_id);
    const auto treasury_account = dac.account_for_type(dacdir::TREASURY);

    const auto spendings_account = dac.account_for_type_maybe(dacdir::SPENDINGS);
    const auto auth_account      = dac.owner;
    if (!spendings_account && !auth_account) {
        return;
    }
    const auto recipient = spendings_account ? *spendings_account : auth_account;

    const auto auth_balance     = eosdac::get_balance_graceful(auth_account, TLM_TOKEN_CONTRACT, TLM_SYM);
    const auto treasury_balance = balance_for_type(dac, dacdir::TREASURY);

    const auto nftcache = dacdir::nftcache_table{DACDIRECTORY_CONTRACT, dac.dac_id.value};
    const auto index    = nftcache.get_index<"valdesc"_n>();

    const auto index_key = dacdir::nftcache::template_and_value_key_ascending(BUDGET_SCHEMA, 0);
    auto       itr       = index.lower_bound(index_key);
    check(
        itr != index.end() && itr->schema_name == BUDGET_SCHEMA, "Dac with ID %s does not own any budget NFTs", dac_id);

    // we need to convert this to int64_t so we can use the * operator on asset further down
    const auto p = int64_t(itr->value);

    // percentage value is scaled by 100, so to calculate percent we need to divide by (100 * 100 == 10000)
    const auto amount = std::min(treasury_balance, auth_balance - treasury_balance * p / 10000);
    if (amount.amount > 0) {
        action(permission_level{treasury_account, "xfer"_n}, TLM_TOKEN_CONTRACT, "transfer"_n,
            make_tuple(treasury_account, recipient, amount, "period budget"s))
            .send();
    }

    state.set(state_keys::lastclaimbudgettime, time_point_sec(current_time_point()));
    state.save(get_self(), dac_id);
}

ACTION daccustodian::migratestate(const name &dac_id) {
    check(!statecontainer2(get_self(), dac_id.value).exists(), "Already migrated dac %s", dac_id);
    auto new_state = contr_state2::get_current_state(get_self(), dac_id);
    new_state.save(get_self(), dac_id);
}

ACTION daccustodian::newperiod(const string &message, const name &dac_id) {
    /* This is a housekeeping method, it can be called by anyone by design */
    const auto sender = dacdir::dac_for_id(dac_id).owner;
    eosio::action(eosio::permission_level{sender, "owner"_n}, get_self(), "runnewperiod"_n, make_tuple(message, dac_id))
        .send();
}

ACTION daccustodian::runnewperiod(const string &message, const name &dac_id) {
    /* This is a housekeeping method, it can be called by anyone by design */
    contr_config configs      = contr_config::get_current_configs(get_self(), dac_id);
    auto         currentState = contr_state2::get_current_state(get_self(), dac_id);
    assertPeriodTime(configs, currentState);

    dacdir::dac found_dac          = dacdir::dac_for_id(dac_id);
    const auto  activation_account = found_dac.account_for_type_maybe(dacdir::ACTIVATION);

    if (activation_account) {
        print("\n\nSending notification to ", *activation_account, "::assertunlock");

        action(permission_level{*activation_account, "notify"_n}, *activation_account, "assertunlock"_n,
            std::make_tuple(dac_id))
            .send();
    } else {
        // Get the token supply of the lockup asset token (eg. EOSDAC)
        auto statsTable = stats(found_dac.symbol.get_contract(), found_dac.symbol.get_symbol().code().raw());
        auto tokenStats = statsTable.begin();
        check(tokenStats != statsTable.end(), "ERR::STATS_NOT_FOUND::Stats table not found");
        print("\n\nstats: ", tokenStats->supply, " contract: ", found_dac.symbol.get_contract(),
            " symbol: ", found_dac.symbol.get_symbol());

        uint64_t token_current_supply = tokenStats->supply.amount;

        double percent_of_current_voter_engagement =
            double(currentState.get<int64_t>(state_keys::total_weight_of_votes)) / double(token_current_supply) * 100.0;

        print("\n\nToken current supply as decimal units: ", token_current_supply,
            " total votes so far: ", currentState.get<int64_t>(state_keys::total_weight_of_votes));
        print("\n\nNeed inital engagement of: ", configs.initial_vote_quorum_percent, "% to start the DAC.");
        print("\n\nToken supply: ", token_current_supply * 0.0001,
            " total votes so far: ", currentState.get<int64_t>(state_keys::total_weight_of_votes) * 0.0001);
        print("\n\nNeed initial engagement of: ", configs.initial_vote_quorum_percent, "% to start the DAC.");
        print("\n\nNeed ongoing engagement of: ", configs.vote_quorum_percent,
            "% to allow new periods to trigger after initial activation.");
        print("\n\nPercent of current voter engagement: ", percent_of_current_voter_engagement, "\n\n");

        check(currentState.get<bool>(state_keys::met_initial_votes_threshold) == true ||
                  percent_of_current_voter_engagement > configs.initial_vote_quorum_percent,
            "ERR::NEWPERIOD_VOTER_ENGAGEMENT_LOW_ACTIVATE::Voter engagement %s is insufficient to activate the DAC (%s required).",
            percent_of_current_voter_engagement, configs.initial_vote_quorum_percent);

        check(percent_of_current_voter_engagement > configs.vote_quorum_percent,
            "ERR::NEWPERIOD_VOTER_ENGAGEMENT_LOW_PROCESS::Voter engagement is insufficient to process a new period");
    }

    currentState.set(state_keys::met_initial_votes_threshold, true);

    // Distribute Pay is called before allocateCustodians is called to ensure custodians are paid for the just passed
    // period. This also implies custodians should not be paid the first time this is called.
    // Distribute pay to the current custodians.
    distributeMeanPay(dac_id);

    // Set custodians for the next period.
    allocateCustodians(false, dac_id);

    // Set the auths on the dacauthority account
    setCustodianAuths(dac_id);
    setMsigAuths(dac_id);

    currentState.lastperiodtime = current_block_time();
    currentState.save(get_self(), dac_id);
}
