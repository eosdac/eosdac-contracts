#include "stakevote.hpp"
#include <cmath>

void stakevote::stakeobsv(const vector<account_stake_delta> &stake_deltas, const name dac_id) {
    auto       err                = Err{"stakevote::stakeobsv"};
    const auto dac                = dacdir::dac_for_id(dac_id);
    const auto token_contract     = dac.symbol.get_contract();
    const auto custodian_contract = dac.account_for_type_maybe(dacdir::CUSTODIAN);

    require_auth(token_contract);

    const auto config         = config_item::get_current_configs(get_self(), dac_id);
    const auto token_config   = stake_config::get_current_configs(token_contract, dac_id);
    const auto max_stake_time = S{token_config.max_stake_time}.to<double>("stakeobsv max_stake_time");

    // Forward all the stake notifications to allow custodian contract to forbid unstaking for a custodian
    if (custodian_contract) {
        action(permission_level{get_self(), "notify"_n}, *custodian_contract, "stakeobsv"_n,
            make_tuple(stake_deltas, dac_id))
            .send();
    }

    auto weight_deltas = vector<account_weight_delta>{};
    auto weights       = weight_table{get_self(), dac_id.value};

    for (const auto &asd : stake_deltas) {
        // Destructured variables cannot be captured by reference in a lambda. That's why we are forced to use std::tie
        int64_t weight_delta;
        int64_t weight_quorum_delta;
        std::tie(weight_delta, weight_quorum_delta) = calculate_weight_and_quorum_deltas(asd.account, dac_id);

        weight_deltas.push_back({asd.account, weight_delta, weight_quorum_delta});

        auto vw_itr = weights.find(asd.account.value);
        upsert(weights, vw_itr, get_self(), [&](auto &v) {
            v.voter = asd.account;
            v.weight =
                S<uint64_t>{v.weight}.add_signed_to_unsigned(weight_delta, "add_signed_to_unsigned weight_delta");
            v.weight_quorum = S<uint64_t>{v.weight_quorum}.add_signed_to_unsigned(
                weight_quorum_delta, "add_signed_to_unsigned weight_delta_quorum");
        });

        if (vw_itr->weight == 0) {
            weights.erase(vw_itr);
        }
    }

    // Send weightobsv to update the vote weights, update weights table
    if (custodian_contract) {
        action(permission_level{get_self(), "notify"_n}, *custodian_contract, "weightobsv"_n,
            make_tuple(weight_deltas, dac_id))
            .send();
    }
}

void stakevote::balanceobsv(const vector<account_balance_delta> &balance_deltas, const name dac_id) {
    const auto dac            = dacdir::dac_for_id(dac_id);
    const auto token_contract = dac.symbol.get_contract();

    require_auth(token_contract);

    // ignore
}

void stakevote::updateconfig(config_item &new_config, const name dac_id) {
    const auto dac = dacdir::dac_for_id(dac_id);
#ifdef IS_DEV
    // This will be enabled later in prod instead of get_self() to allow DAO's to control this config.
    require_auth(dac.owner);
#else
    require_auth(get_self());
#endif
    check(new_config.time_multiplier > 0, "ERR::STAKE_MULTI_NOT_GT_ZERO::time_multiplier must be greater than zero");
    const auto existing_config = config_item::get_current_or_default_configs(get_self(), dac_id);

#ifndef IS_DEV
    check(new_config.time_multiplier > existing_config.time_multiplier,
        "ERR::STAKE_MULTI_NOT_INCREASED::new time_multiplier must be greater than the existing configuration. existing_config.time_multiplier: %s new_config.time_multiplier: %s",
        existing_config.time_multiplier, new_config.time_multiplier);
#endif

    new_config.save(get_self(), dac_id, get_self());
}

#if defined(DEBUG) || defined(IS_DEV)

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

/**
 * @brief Calculate the vote weight and vote quorum of an account based on the current stake, time multiplier, unstake
 * delay, and max stake time.
 *
 * @param account
 * @param dac_id
 * @return returns a std::pair of [weight_delta, weight_quorum_delta].
 */
std::pair<int64_t, int64_t> stakevote::calculate_weight_and_quorum_deltas(const name account, const name dac_id) {
    const auto dac             = dacdir::dac_for_id(dac_id);
    const auto token_contract  = dac.symbol.get_contract();
    const auto stakes          = stakes_table{token_contract, dac_id.value};
    const auto config          = config_item::get_current_configs(get_self(), dac_id);
    const auto token_config    = stake_config::get_current_configs(token_contract, dac_id);
    const auto max_stake_time  = S{token_config.max_stake_time}.to<double>();
    const auto time_multiplier = S{config.time_multiplier}.to<double>();

    const auto stakes_itr = stakes.find(account.value);

    const auto new_weight_quorum = stakes_itr != stakes.end() ? S{(stakes_itr->stake).amount} : S{int64_t{}};

    // calculate new weight and weight_quorum
    const auto stake_amount  = new_weight_quorum.to<double>();
    const auto unstake_delay = S{staketime_info::get_delay(token_contract, dac_id, stakes_itr->account)}.to<double>();
    const auto new_weight    = stake_amount * (S{1.0} + unstake_delay * time_multiplier / max_stake_time);

    // calculate deltas
    const auto weights           = weight_table{get_self(), dac_id.value};
    const auto weight_itr        = weights.find(account.value);
    const auto old_weight        = S{weight_itr != weights.end() ? weight_itr->weight : uint64_t{}};
    const auto old_weight_quorum = S{weight_itr != weights.end() ? weight_itr->weight_quorum : uint64_t{}};

    const auto weight_delta        = new_weight.to<int64_t>() - old_weight.to<int64_t>();
    const auto weight_quorum_delta = new_weight_quorum - old_weight_quorum.to<int64_t>();

    return {weight_delta, weight_quorum_delta};
}

void stakevote::collectwts(uint16_t batch_size, name dac_id, bool assert) {
    require_auth(get_self());
    auto       weights        = weight_table{get_self(), dac_id.value};
    const auto stakes         = stakes_table{"token.worlds"_n, dac_id.value};
    const auto config         = config_item::get_current_configs(get_self(), dac_id);
    const auto dac            = dacdir::dac_for_id(dac_id);
    const auto token_contract = dac.symbol.get_contract();
    const auto token_config   = stake_config::get_current_configs(token_contract, dac_id);
    const auto max_stake_time = S{token_config.max_stake_time}.to<double>();
    // const auto min_stake_time  = S{token_config.min_stake_time}.to<double>();
    const auto time_multiplier = S{config.time_multiplier}.to<double>();

    auto lastWeight = weights.end();
    if (lastWeight != weights.begin()) {
        lastWeight--;
    }
    check(stakes.begin() != stakes.end(), "No stakes found for dac %s.", dac_id);

    auto stake   = lastWeight != weights.end() ? stakes.find((lastWeight->voter).value) : stakes.begin();
    auto counter = 0;
    while (stake != stakes.end() && counter < batch_size) {
        const auto unstake_delay = S{staketime_info::get_delay("token.worlds"_n, dac_id, stake->account)}.to<double>();

        const auto vw_itr              = weights.find((stake->account).value);
        const auto weight_delta_quorum = S{(stake->stake).amount}.to<uint64_t>();

        const auto stake_delta    = S{(stake->stake).amount}.to<double>();
        const auto weight_delta_s = stake_delta * (S{1.0} + unstake_delay * time_multiplier / max_stake_time);
        const auto weight_delta   = weight_delta_s.to<uint64_t>();

        if (vw_itr == weights.end()) {
            if (assert) {
                ::check(false, "Voter %s has no vote_weight but should be '%s' ", weight_delta);
            }
            weights.emplace(get_self(), [&](auto &v) {
                v.voter         = stake->account;
                v.weight        = weight_delta;
                v.weight_quorum = weight_delta_quorum;
            });
        } else {
            weights.modify(vw_itr, same_payer, [&](auto &v) {
                if (assert) {
                    check(v.weight == weight_delta,
                        "Voter %s has v.weight = %s but should be %s stake_delta: %s unstake_delay: %s time_multiplier: %s max_stake_time: %s",
                        v.voter, v.weight, weight_delta, stake_delta, unstake_delay, time_multiplier, max_stake_time);
                }
                v.weight        = weight_delta;
                v.weight_quorum = weight_delta_quorum;
            });
        }

        stake++;
        counter++;
    }
}
#endif