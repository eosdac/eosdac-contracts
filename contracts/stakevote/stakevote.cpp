#include "stakevote.hpp"
#include <cmath>

void stakevote::stakeobsv(vector<account_stake_delta> stake_deltas, name dac_id) {
    auto       dac                = dacdir::dac_for_id(dac_id);
    auto       token_contract     = dac.symbol.get_contract();
    const auto custodian_contract = dac.account_for_type_maybe(dacdir::CUSTODIAN);

    require_auth(token_contract);

    auto config = config_item::get_current_configs(get_self(), dac_id);

    // Forward all the stake notifications to allow custodian contract to forbid unstaking for a custodian
    if (custodian_contract) {
        action(permission_level{get_self(), "notify"_n}, *custodian_contract, "stakeobsv"_n,
            make_tuple(stake_deltas, dac_id))
            .send();
    }

    // Send weightobsv to update the vote weights, update weights table
    vector<account_weight_delta> weight_deltas;
    weight_table                 weights(get_self(), dac_id.value);

    for (auto asd : stake_deltas) {
        int64_t weight_delta = S{asd.stake_delta.amount} * S<int64_t>{asd.unstake_delay};
        auto    vw_itr       = weights.find(asd.account.value);
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

    if (custodian_contract) {
        action(permission_level{get_self(), "notify"_n}, *custodian_contract, "weightobsv"_n,
            make_tuple(weight_deltas, dac_id))
            .send();
    }
}

void stakevote::balanceobsv(vector<account_balance_delta> balance_deltas, name dac_id) {
    auto dac            = dacdir::dac_for_id(dac_id);
    auto token_contract = dac.symbol.get_contract();

    require_auth(token_contract);

    // ignore
}

void stakevote::updateconfig(config_item new_config, name dac_id) {
    auto dac          = dacdir::dac_for_id(dac_id);
    auto auth_account = dac.owner;

    require_auth(auth_account);

    new_config.save(get_self(), dac_id, get_self());
}

// Only needed temporarily for dev/testing and migration of the current planets to stake weighted voting
// Start - - - - -v
void stakevote::clearweights(uint16_t batch_size, name dac_id) {
    require_auth(get_self());
    weight_table weights(get_self(), dac_id.value);

    auto row     = weights.begin();
    auto counter = batch_size;
    while (row != weights.end() && counter > 0) {
        row = weights.erase(row);
        counter--;
    }
}

void stakevote::collectwts(uint16_t batch_size, uint32_t unstake_time, name dac_id) {
    require_auth(get_self());
    weight_table weights(get_self(), dac_id.value);
    stakes_table stakes("token.worlds"_n, dac_id.value);
    auto         config = config_item::get_current_configs(get_self(), dac_id);

    auto lastWeight = weights.end();
    if (lastWeight != weights.begin()) {
        lastWeight--;
    }
    check(stakes.begin() != stakes.end(), "No stakes found.");

    auto stake = lastWeight != weights.end() ? stakes.find((lastWeight->voter).value) : stakes.begin();

    auto counter = 0;
    while (stake != stakes.end() && counter < batch_size) {
        auto vw_itr = weights.find((stake->account).value);
        if (vw_itr == weights.end()) {
            int64_t weight_delta = (stake->stake).amount * unstake_time * (config.time_multiplier / pow(10, 8));
            weights.emplace(get_self(), [&](auto &v) {
                v.voter  = stake->account;
                v.weight = weight_delta;
            });
        }

        stake++;
        counter++;
    }
}
// End - - - - -^
