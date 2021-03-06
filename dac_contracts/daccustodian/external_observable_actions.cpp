
#include "../../contract-shared-headers/dacdirectory_shared.hpp"
#include "../../contract-shared-headers/migration_helpers.hpp"
using namespace eosdac;

void daccustodian::balanceobsv(vector<account_balance_delta> account_balance_deltas, name dac_id) {
    auto                         dac       = dacdir::dac_for_id(dac_id);
    auto                         dacSymbol = dac.symbol.get_symbol();
    vector<account_weight_delta> weightDeltas;
    for (account_balance_delta balanceDelta : account_balance_deltas) {
        check(dacSymbol == balanceDelta.balance_delta.symbol,
            "ERR::INCORRECT_SYMBOL_DELTA::Incorrect symbol in balance_delta");
        weightDeltas.push_back({balanceDelta.account, balanceDelta.balance_delta.amount});
    }

    weightobsv(weightDeltas, dac_id);
}

void daccustodian::weightobsv(vector<account_weight_delta> account_weight_deltas, name dac_id) {
    auto dac            = dacdir::dac_for_id(dac_id);
    auto token_contract = dac.symbol.get_contract();

    auto router_account = dac.account_for_type(dacdir::VOTE_WEIGHT);

    check(has_auth(token_contract) || has_auth(router_account),
        "Must have auth of token or router contract to call weightobsv");

    votes_table votes_cast_by_members(get_self(), dac_id.value);

    for (account_weight_delta awd : account_weight_deltas) {
        auto existingVote = votes_cast_by_members.find(awd.account.value);
        if (existingVote != votes_cast_by_members.end()) {
            if (existingVote->proxy.value != 0) {
                modifyProxiesWeight(awd.weight_delta, name{}, existingVote->proxy, dac_id);
            } else {
                modifyVoteWeights(awd.weight_delta, {}, existingVote->candidates, dac_id);
            }
        }
    }
}

void daccustodian::stakeobsv(vector<account_stake_delta> account_stake_deltas, name dac_id) {
    auto dac            = dacdir::dac_for_id(dac_id);
    auto token_contract = dac.symbol.get_contract();

    auto router_account = dac.account_for_type(dacdir::VOTE_WEIGHT);

    check(has_auth(token_contract) || has_auth(router_account),
        "Must have auth of token or router contract to call stakeobsv");

    // check if the custodian is allowed to unstake beyond the minimum
    for (auto asd : account_stake_deltas) {
        if (asd.stake_delta.amount < 0) { // unstaking
            validateUnstakeAmount(get_self(), asd.account, -asd.stake_delta, dac_id);
        }
    }
}

void daccustodian::validateUnstakeAmount(name code, name cand, asset unstake_amount, name dac_id) {
    // Will assert if adc_id not found
    check(unstake_amount.amount > 0, "ERR::NEGATIVE_UNSTAKE::Unstake amount must be positive");
    auto dac            = dacdir::dac_for_id(dac_id);
    auto token_contract = dac.symbol.get_contract();

    candidates_table registered_candidates(code, dac_id.value);
    auto             reg_candidate = registered_candidates.find(cand.value);
    if (reg_candidate != registered_candidates.end()) {
        extended_asset lockup_asset  = contr_config::get_current_configs(code, dac_id).lockupasset;
        auto           current_stake = eosdac::get_staked(cand, token_contract, unstake_amount.symbol);

        print(" Current stake : ", current_stake, ", Unstake amount : ", unstake_amount);
        check(!reg_candidate->is_active,
            "ERR::CANNOT_UNSTAKE_REGISTERED::Cannot unstake because you are registered as a candidate, use withdrawcane to unregister.");

        if (reg_candidate->custodian_end_time_stamp > time_point_sec(eosio::current_time_point())) {
            // Still under restrictions
            check(current_stake >= lockup_asset.quantity,
                "ERR::CANNOT_UNSTAKE::Cannot unstake because stake is locked by the custodian agreement");
        }
    }
}
