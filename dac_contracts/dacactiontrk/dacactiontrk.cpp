#include "dacactiontrk.hpp"

ACTION dacactiontrk::trackevent(name custodian_name, uint8_t score, name dacId) {
    require_auth("dacauth"_n);
    scores_table scores(get_self(), dacId.value);

    auto custodian = scores.find(custodian_name.value);
    scores.modify(custodian, same_payer, [&](auto &cust) {
        cust.score += score;
    });
}

ACTION dacactiontrk::periodend(vector<name> currentCustodians, name dacId) {
    require_auth("dacauth"_n);
    scores_table scores(get_self(), dacId.value);

    auto config = config_item::get_current_configs(get_self(), dacId);

    for (name custodian_name : currentCustodians) {
        auto custodian = scores.find(custodian_name.value);
        scores.modify(custodian, same_payer, [&](custodian_score &cust) {
            if (cust.score <= config.newperiodAdjustment) {
                cust.score = 0;
            } else {
                cust.score -= config.newperiodAdjustment;
            }
        });
    }

    auto omittedIdx = scores.get_index<"omitted"_n>();

    auto omittedIttr = omittedIdx.find(1);

    while (omittedIttr != omittedIdx.end()) {
        if (omittedIttr->periods_omitted == 1) {
            // If there is only one period left to be omitted remove the custodian to either free up the RAM if they
            // have gone or let them start with a clean slate.
            omittedIttr = omittedIdx.erase(omittedIttr);
        } else {
            omittedIdx.modify(omittedIttr, same_payer, [&](custodian_score &cust) {
                cust.periods_omitted -= 1;
            });
            omittedIttr++;
        }
    }
}

ACTION dacactiontrk::periodstart(vector<name> newCustodians, name dacId) {
    require_auth("dacauth"_n);
    scores_table scores(get_self(), dacId.value);

    auto config = config_item::get_current_configs(get_self(), dacId);

    for (name custodian_name : newCustodians) {
        auto custodian = scores.find(custodian_name.value);
        if (custodian == scores.end()) {
            scores.emplace(get_self(), [&](custodian_score &cust_score) {
                cust_score.custodian       = custodian_name;
                cust_score.score           = config.startingScore;
                cust_score.periods_omitted = 0;
            });
        }
    }
}

ACTION dacactiontrk::updateconfig(config_item new_config, name dacId) {
    dacdir::dac dacForScope  = dacdir::dac_for_id(dacId);
    auto        auth_account = dacForScope.account_for_type(dacdir::AUTH);
    require_auth(auth_account);

    config_container config_singleton(get_self(), dacId.value);
    config_singleton.set(new_config, auth_account);

    config_item currentState = config_item::get_current_configs(_self, dacId);
    currentState.save(_self, dacId, auth_account);
}
