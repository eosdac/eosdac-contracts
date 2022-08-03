
#include "../../contract-shared-headers/dacdirectory_shared.hpp"
using namespace eosdac;

ACTION daccustodian::balanceobsv(const vector<account_balance_delta> &account_balance_deltas, const name &dac_id) {
    auto                         dac       = dacdir::dac_for_id(dac_id);
    auto                         dacSymbol = dac.symbol.get_symbol();
    vector<account_weight_delta> weightDeltas;
    for (account_balance_delta balanceDelta : account_balance_deltas) {
        check(dacSymbol == balanceDelta.balance_delta.symbol,
            "ERR::INCORRECT_SYMBOL_DELTA::Incorrect symbol in balance_delta");
        weightDeltas.push_back(
            {balanceDelta.account, balanceDelta.balance_delta.amount, balanceDelta.balance_delta.amount});
    }

    weightobsv(weightDeltas, dac_id);
}

ACTION daccustodian::weightobsv(const vector<account_weight_delta> &account_weight_deltas, const name &dac_id) {
    auto dac            = dacdir::dac_for_id(dac_id);
    auto token_contract = dac.symbol.get_contract();

    const auto router_account = dac.account_for_type_maybe(dacdir::VOTE_WEIGHT);

    check(has_auth(token_contract) || (router_account && has_auth(*router_account)),
        "Must have auth of token or router contract to call weightobsv");

    votes_table votes_cast_by_members(get_self(), dac_id.value);

    for (account_weight_delta awd : account_weight_deltas) {
        auto existingVote = votes_cast_by_members.find(awd.account.value);
        if (existingVote != votes_cast_by_members.end()) {
            if (existingVote->proxy.value != 0) {
                modifyProxiesWeight(awd.weight_delta, name{}, existingVote->proxy, dac_id, false);
            } else {
                modifyVoteWeights(awd, {}, existingVote->vote_time_stamp, existingVote->candidates, dac_id, false);
            }
        }
    }
}

ACTION daccustodian::stakeobsv(const vector<account_stake_delta> &account_stake_deltas, const name &dac_id) {
    auto dac            = dacdir::dac_for_id(dac_id);
    auto token_contract = dac.symbol.get_contract();

    const auto router_account = dac.account_for_type_maybe(dacdir::VOTE_WEIGHT);

    check(has_auth(token_contract) || (router_account && has_auth(*router_account)),
        "Must have auth of token or router contract to call stakeobsv");

    // check if the custodian is allowed to unstake beyond the minimum
    std::map<name, asset> accounts_to_stake_amounts = {};
    for (auto asd : account_stake_deltas) {

        if (accounts_to_stake_amounts.find(asd.account) != accounts_to_stake_amounts.end()) {
            accounts_to_stake_amounts[asd.account] += asd.stake_delta;
        } else {
            accounts_to_stake_amounts[asd.account] = asd.stake_delta;
        }
    }

    for (const auto &[account, net_stake_asset] : accounts_to_stake_amounts) {
        if (net_stake_asset.amount < 0) { // unstaking
            validateUnstakeAmount(get_self(), account, -net_stake_asset, dac_id);
        }
    }
}

void daccustodian::validateUnstakeAmount(
    const name &code, const name &cand, const asset &unstake_amount, const name &dac_id) {
    // Will assert if adc_id not found
    check(unstake_amount.amount > 0, "ERR::NEGATIVE_UNSTAKE::Unstake amount must be positive");
    auto dac            = dacdir::dac_for_id(dac_id);
    auto token_contract = dac.symbol.get_contract();

    candidates_table registered_candidates(code, dac_id.value);
    auto             reg_candidate = registered_candidates.find(cand.value);
    if (reg_candidate != registered_candidates.end()) {
        extended_asset lockup_asset  = dacglobals::current(code, dac_id).get_lockupasset();
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
