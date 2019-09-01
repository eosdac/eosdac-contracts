#include "../_contract-shared-headers/migration_helpers.hpp"

// void daccustodian::distributePay(name dac_id) {
//     custodians_table custodians(_self, dac_id.value);
//     pending_pay_table pending_pay(_self, dac_id.value);

//     //Find the median pay using a temporary vector to hold the requestedpay amounts.
//     std::vector<asset> reqpays;
//     for (auto cust: custodians) {
//         reqpays.push_back(cust.requestedpay);
//     }

//     // Using nth_element to just sort for the entry we need for the median value.
//     size_t mid = reqpays.size() / 2;
//     std::nth_element(reqpays.begin(), reqpays.begin() + mid, reqpays.end());

//     asset medianAsset = reqpays[mid];

//     if (medianAsset.amount > 0) {
//         for (auto cust: custodians) {
//             pending_pay.emplace(_self, [&](pay &p) {
//                 p.key = pending_pay.available_primary_key();
//                 p.receiver = cust.cust_name;
//                 p.quantity = medianAsset;
//                 p.memo = "Custodian pay. Thank you.";
//             });
//         } 
//     }

//     print("distribute pay");
// }

void daccustodian::distributeMeanPay(name dac_id) {
    custodians_table custodians(get_self(), dac_id.value);
    pending_pay_table pending_pay(get_self(), dac_id.value);
    contr_config configs = contr_config::get_current_configs(get_self(), dac_id);
    name auth_account = dacdir::dac_for_id(dac_id).account_for_type(dacdir::AUTH);

    //Find the mean pay using a temporary vector to hold the requestedpay amounts.
    extended_asset total = configs.requested_pay_max - configs.requested_pay_max;
    int64_t count = 0;
    for (auto cust: custodians) {
        if (total.get_extended_symbol().get_symbol() == cust.requestedpay.symbol) {
            total += extended_asset(cust.requestedpay, total.contract);
            count += 1;
        }
    }

    print("count during mean pay: ", count, " total: ", total);

    asset meanAsset = count == 0 ? total.quantity : total.quantity / count;

    print("mean asset for pay: ", meanAsset);

    auto pendingPayReceiverSymbolIndex = pending_pay.get_index<"receiversym"_n>();

    if (meanAsset.amount > 0) {
        for (auto cust: custodians) {
            print("\nLooping through custodians : ", cust.cust_name);

            checksum256 idx = pay::getIndex(cust.cust_name, total.get_extended_symbol());
            print("\ncreated a joint index : ", idx);
            auto itrr = pendingPayReceiverSymbolIndex.find(idx);
            if (itrr != pendingPayReceiverSymbolIndex.end() && itrr->receiver == cust.cust_name && itrr->quantity.get_extended_symbol() == total.get_extended_symbol() && itrr->due_date == time_point_sec{0})
            {
                pendingPayReceiverSymbolIndex.modify(itrr, same_payer, [&](pay &p) {
                    print("\nAdding to existing amount with : ", extended_asset(meanAsset, total.contract));

                    p.quantity += extended_asset(meanAsset, total.contract);
                });
            } else {
                print("\n Creating pending pay amount with : ", extended_asset(meanAsset, total.contract));

                pending_pay.emplace(auth_account, [&](pay &p) {
                    p.key = pending_pay.available_primary_key();
                    p.receiver = cust.cust_name;
                    p.quantity = extended_asset(meanAsset, total.contract);
                    p.due_date = time_point_sec{0};
                });
            }
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

void daccustodian::allocateCustodians(bool early_election, name dac_id) {

    eosio::print("Configure custodians for the next period.");

    custodians_table custodians(get_self(), dac_id.value);
    candidates_table registered_candidates(get_self(), dac_id.value);
    contr_config configs = contr_config::get_current_configs(get_self(), dac_id);
    name auth_account = dacdir::dac_for_id(dac_id).account_for_type(dacdir::AUTH);
    
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

void daccustodian::setCustodianAuths(name dac_id) {

    custodians_table custodians(get_self(), dac_id.value);
    contr_config current_config = contr_config::get_current_configs(get_self(), dac_id);

    auto dac = dacdir::dac_for_id(dac_id);
    
    name accountToChange = dac.account_for_type(dacdir::AUTH);

    vector<eosiosystem::permission_level_weight> accounts;
    
    print("setting auths for custodians\n\n");

    for (auto it = custodians.begin(); it != custodians.end(); it++) {
        eosiosystem::permission_level_weight account{
                .permission = getCandidatePermission(it->cust_name, dac_id),
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
    check(false, "This action is deprecated call `newperiode` instead.");
}

void daccustodian::newperiode(string message, name dac_id) {
    name auth_account = dacdir::dac_for_id(dac_id).account_for_type(dacdir::AUTH);

    eosio::action(
            eosio::permission_level{ auth_account, "owner"_n },
            get_self(), "runnewperiod"_n,
            make_tuple(message, dac_id)
    ).send();
}

void daccustodian::runnewperiod(string message, name dac_id) {

    contr_config configs = contr_config::get_current_configs(get_self(), dac_id);
    contr_state currentState = contr_state::get_current_state(get_self(), dac_id);
    assertPeriodTime(configs, currentState);

    dacdir::dac found_dac = dacdir::dac_for_id(dac_id);


    // Get the token supply of the lockup asset token (eg. EOSDAC)
    auto tokenStats = stats(
            found_dac.symbol.get_contract(),
            found_dac.symbol.get_symbol().code().raw()
    ).begin();
    eosio::print("\n\nstats: ", tokenStats->supply, " contract: ", found_dac.symbol.get_contract(), " symbol: ", found_dac.symbol.get_symbol());
    uint64_t token_current_supply = tokenStats->supply.amount;

    double percent_of_current_voter_engagement =
            double(currentState.total_weight_of_votes) / double(token_current_supply) * 100.0;

    eosio::print("\n\nToken current supply as decimal units: ", token_current_supply, " total votes so far: ", currentState.total_weight_of_votes);
    eosio::print("\n\nNeed inital engagement of: ", configs.initial_vote_quorum_percent, "% to start the DAC.");
    eosio::print("\n\nToken supply: ", token_current_supply * 0.0001, " total votes so far: ", currentState.total_weight_of_votes * 0.0001);
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
    distributeMeanPay(dac_id);

    // Set custodians for the next period.
    allocateCustodians(false, dac_id);

    // Set the auths on the dacauthority account
    setCustodianAuths(dac_id);

    currentState.lastperiodtime = current_block_time();
    currentState.save(get_self(), dac_id);


//        Schedule the the next election cycle at the end of the period.
//        transaction nextTrans{};
//        nextTrans.actions.emplace_back(permission_level(_self,N(active)), _self, N(newperiod), std::make_tuple("", false));
//        nextTrans.delay_sec = configs().periodlength;
//        nextTrans.send(N(newperiod), false);
}
