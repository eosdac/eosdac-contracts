#include "stakevote.hpp"
#include <cmath>

void stakevote::stakeobsv(vector<account_stake_delta> stake_deltas, name dac_id) {
    auto dac                = dacdir::dac_for_id(dac_id);
    auto token_contract     = dac.symbol.get_contract();
    auto custodian_contract = dac.account_for_type(dacdir::CUSTODIAN);

    require_auth(token_contract);

    auto config = config_item::get_current_configs(get_self(), get_self());

    // Forward all the stake notifications to allow custodian contract to forbid unstaking for a custodian
    action(
        permission_level{get_self(), "notify"_n}, custodian_contract, "stakeobsv"_n, make_tuple(stake_deltas, dac_id))
        .send();

    // Send weightobsv to update the vote weights, update weights table
    vector<account_weight_delta> weight_deltas;
    weight_table                 weights(get_self(), dac_id.value);

    for (auto asd : stake_deltas) {
        int64_t weight_delta = asd.stake_delta.amount * asd.unstake_delay * (config.time_multiplier / pow(10, 8));

        auto vw_itr = weights.find(asd.account.value);
        if (vw_itr != weights.end()) {
            weights.modify(vw_itr, same_payer, [&](auto &v) {
                v.weight += weight_delta;
            });
        } else {
            weights.emplace(get_self(), [&](auto &v) {
                v.voter  = asd.account;
                v.weight = weight_delta;
            });
        }

        weight_deltas.push_back({asd.account, weight_delta});
    }

    action(
        permission_level{get_self(), "notify"_n}, custodian_contract, "weightobsv"_n, make_tuple(weight_deltas, dac_id))
        .send();
}

void stakevote::balanceobsv(vector<account_balance_delta> balance_deltas, name dac_id) {
    auto dac            = dacdir::dac_for_id(dac_id);
    auto token_contract = dac.symbol.get_contract();

    require_auth(token_contract);

    // ignore
}

void stakevote::updateconfig(config_item new_config, name dac_id) {
    auto dac          = dacdir::dac_for_id(dac_id);
    auto auth_account = dac.account_for_type(dacdir::AUTH);

    require_auth(auth_account);

    new_config.save(get_self(), get_self(), get_self());
}
