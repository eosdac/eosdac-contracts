
void daccustodian::distributePay(name dac_scope) {
    custodians_table custodians(_self, dac_scope.value);
    pending_pay_table pending_pay(_self, dac_scope.value);

    //Find the median pay using a temporary vector to hold the requestedpay amounts.
    std::vector<asset> reqpays;
    for (auto cust: custodians) {
        reqpays.push_back(cust.requestedpay);
    }

    // Using nth_element to just sort for the entry we need for the median value.
    size_t mid = reqpays.size() / 2;
    std::nth_element(reqpays.begin(), reqpays.begin() + mid, reqpays.end());

    asset medianAsset = reqpays[mid];

    if (medianAsset.amount > 0) {
        for (auto cust: custodians) {
            pending_pay.emplace(_self, [&](pay &p) {
                p.key = pending_pay.available_primary_key();
                p.receiver = cust.cust_name;
                p.quantity = medianAsset;
                p.memo = "Custodian pay. Thank you.";
            });
        } 
    }

    print("distribute pay");
}

void daccustodian::distributeMeanPay(name dac_scope) {
    custodians_table custodians(_self, dac_scope.value);
    pending_pay_table pending_pay(_self, dac_scope.value);
    contr_config configs = contr_config::get_current_configs(_self, dac_scope);

    //Find the mean pay using a temporary vector to hold the requestedpay amounts.
    asset total = asset{0, configs.requested_pay_max.symbol};
    int64_t count = 0;
    for (auto cust: custodians) {
        total += cust.requestedpay;
        count += 1;
        // print_f("cust % with amount %\n", cust.cust_name, cust.requestedpay);
    }

    asset meanAsset = count == 0 ? total : total / count;

    // print_f("Calclulated mean is: %", meanAsset);
    if (meanAsset.amount > 0) {
        for (auto cust: custodians) {
            pending_pay.emplace(_self, [&](pay &p) {
                p.key = pending_pay.available_primary_key();
                p.receiver = cust.cust_name;
                p.quantity = meanAsset;
                p.memo = "Custodian pay. Thank you.";
            });
        }
    }

    print("distribute mean pay");
}

void daccustodian::assertPeriodTime(contr_config &configs, contr_state &currentState) {
    time_point_sec timestamp = time_point_sec(eosio::current_time_point());
    uint32_t periodBlockCount = (timestamp - currentState.lastperiodtime.sec_since_epoch()).sec_since_epoch();
    check(periodBlockCount > configs.periodlength,
                 "ERR::NEWPERIOD_EARLY::New period is being called too soon. Wait until the period has completed.");
}

void daccustodian::allocateCustodians(bool early_election, name dac_scope) {

    eosio::print("Configure custodians for the next period.");

    custodians_table custodians(_self, dac_scope.value);
    candidates_table registered_candidates(_self, dac_scope.value);
    contr_config configs = contr_config::get_current_configs(_self, dac_scope);
    name auth_account = dacdir::dac_for_id(dac_scope).account_for_type(dacdir::AUTH);
    
    auto byvotes = registered_candidates.get_index<"byvotesrank"_n>();
    auto cand_itr = byvotes.begin();

    int32_t electcount = configs.numelected;
    uint8_t currentCustodianCount = 0;

    if (!early_election) {
        eosio::print("Empty the custodians table to get a full set of new custodians based on the current votes.");
        auto cust_itr = custodians.begin();
        while (cust_itr != custodians.end()) {
            const auto &reg_candidate = registered_candidates.get(cust_itr->cust_name.value, "ERR::NEWPERIOD_EXPECTED_CAND_NOT_FOUND::Corrupt data: Trying to set a lockup delay on candidate leaving office.");
            registered_candidates.modify(reg_candidate, same_payer, [&](candidate &c) {
                eosio::print("Lockup stake for release delay.");
                c.custodian_end_time_stamp = time_point_sec(current_time_point().sec_since_epoch() + configs.lockup_release_time_delay);
            });
            cust_itr = custodians.erase(cust_itr);
        }
    }

    eosio::print("Select only enough candidates to fill the gaps.");
    for (auto itr = custodians.begin(); itr != custodians.end(); itr++) { ++currentCustodianCount; }

    while (currentCustodianCount < electcount) {
        if (cand_itr == byvotes.end() || cand_itr->total_votes == 0) {
            eosio::print("The pool of eligible candidates has been exhausted");
            return;
        }

        //  If the candidate is inactive or is already a custodian skip to the next one.
        if (!cand_itr->is_active || custodians.find(cand_itr->candidate_name.value) != custodians.end()) {
            cand_itr++;
        } else {
            custodians.emplace(auth_account, [&](custodian &c) {
                c.cust_name = cand_itr->candidate_name;
                c.requestedpay = cand_itr->requestedpay;
                c.total_votes = cand_itr->total_votes;
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

void daccustodian::setCustodianAuths(name dac_scope) {

    custodians_table custodians(_self, dac_scope.value);
    contr_config current_config = contr_config::get_current_configs(_self, dac_scope);

    auto dac = dacdir::dac_for_id(dac_scope);
    
    name accountToChange = dac.account_for_type(dacdir::AUTH);

    vector<eosiosystem::permission_level_weight> accounts;
    
    print("setting auths for custodians\n\n");

    for (auto it = custodians.begin(); it != custodians.end(); it++) {
        eosiosystem::permission_level_weight account{
                .permission = getCandidatePermission(it->cust_name, dac_scope), //eosio::permission_level(it->cust_name, "active"_n),
                .weight = (uint16_t) 1,
        };
        accounts.push_back(account);
    }

    eosiosystem::authority high_contract_authority{
            .threshold = current_config.auth_threshold_high,
            .keys = {},
            .accounts = accounts
    };
    print("About to set the first one in auths for custodians\n\n");

    action(permission_level{accountToChange, "owner"_n},
           "eosio"_n, "updateauth"_n,
           std::make_tuple(
                   accountToChange,
                   HIGH_PERMISSION,
                   "active"_n,
                   high_contract_authority))
            .send();
    
    print("After setting the first one in auths for custodians\n\n");

    eosiosystem::authority medium_contract_authority{
            .threshold = current_config.auth_threshold_mid,
            .keys = {},
            .accounts = accounts
    };

    action(permission_level{accountToChange, "owner"_n},
            "eosio"_n, "updateauth"_n,
           std::make_tuple(
                   accountToChange,
                   MEDIUM_PERMISSION,
                   "high"_n,
                   medium_contract_authority))
            .send();

    eosiosystem::authority low_contract_authority{
            .threshold = current_config.auth_threshold_low,
            .keys = {},
            .accounts = accounts
    };

    action(permission_level{accountToChange, "owner"_n},
            "eosio"_n, "updateauth"_n,
           std::make_tuple(
                   accountToChange,
                   LOW_PERMISSION,
                   "med"_n,
                   low_contract_authority))
            .send();

    eosiosystem::authority one_contract_authority{
            .threshold = 1,
            .keys = {},
            .accounts = accounts
    };

    action(permission_level{accountToChange, "owner"_n},
            "eosio"_n, "updateauth"_n,
           std::make_tuple(
                   accountToChange,
                   ONE_PERMISSION,
                   "low"_n,
                   one_contract_authority))
            .send();
            print("Got to the end of setting permissions.");
}

void daccustodian::newperiod(string message) {
    newperiode(message, get_self());
}

void daccustodian::newperiode(string message, name dac_scope) {

    contr_config configs = contr_config::get_current_configs(_self, dac_scope);
    contr_state currentState = contr_state::get_current_state(_self, dac_scope);
    assertPeriodTime(configs, currentState);

    dacdir::dac found_dac = dacdir::dac_for_id(dac_scope);


    // Get the max supply of the lockup asset token (eg. EOSDAC)
    auto tokenStats = stats(
                            found_dac.account_for_type(dacdir::TOKEN), 
                            found_dac.symbol.code().raw()
                            ).begin();
    uint64_t max_supply = tokenStats->supply.amount;

    double percent_of_current_voter_engagement =
            double(currentState.total_weight_of_votes) / double(max_supply) * 100.0;

    eosio::print("\n\nToken max supply: ", max_supply, " total votes so far: ", currentState.total_weight_of_votes);
    eosio::print("\n\nNeed inital engagement of: ", configs.initial_vote_quorum_percent, "% to start the DAC.");
    eosio::print("\n\nToken supply: ", max_supply * 0.0001, " total votes so far: ", currentState.total_weight_of_votes * 0.0001);
    eosio::print("\n\nNeed initial engagement of: ", configs.initial_vote_quorum_percent, "% to start the DAC.");
    eosio::print("\n\nNeed ongoing engagement of: ", configs.vote_quorum_percent,
                 "% to allow new periods to trigger after initial activation.");
    eosio::print("\n\nPercent of current voter engagement: ", percent_of_current_voter_engagement, "\n\n");

    check(currentState.met_initial_votes_threshold == true ||
                 percent_of_current_voter_engagement > configs.initial_vote_quorum_percent,
                 "ERR::NEWPERIOD_VOTER_ENGAGEMENT_LOW_ACTIVATE::Voter engagement is insufficient to activate the DAC.");
    currentState.met_initial_votes_threshold = true;

    check(percent_of_current_voter_engagement > configs.vote_quorum_percent,
                 "ERR::NEWPERIOD_VOTER_ENGAGEMENT_LOW_PROCESS::Voter engagement is insufficient to process a new period");

    // Distribute pay to the current custodians.
    distributeMeanPay(dac_scope);

    // Set custodians for the next period.
    allocateCustodians(false, dac_scope);

    // Set the auths on the dacauthority account
    setCustodianAuths(dac_scope);

    currentState.lastperiodtime = current_block_time();
    currentState.save(_self, dac_scope);


//        Schedule the the next election cycle at the end of the period.
//        transaction nextTrans{};
//        nextTrans.actions.emplace_back(permission_level(_self,N(active)), _self, N(newperiod), std::make_tuple("", false));
//        nextTrans.delay_sec = configs().periodlength;
//        nextTrans.send(N(newperiod), false);
}
