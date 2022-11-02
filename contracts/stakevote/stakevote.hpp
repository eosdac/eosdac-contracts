#include <eosio/eosio.hpp>
#include <eosio/multi_index.hpp>
#include <eosio/singleton.hpp>

#include "../../contract-shared-headers/dacdirectory_shared.hpp"
#include "../../contract-shared-headers/eosdactokens_shared.hpp"
#include "../../contract-shared-headers/safemath/safemath.hpp"

using namespace eosio;
using namespace eosdac;
using namespace std;

CONTRACT stakevote : public contract {
  public:
    using contract::contract;

    struct [[eosio::table("config"), eosio::contract("stakevote")]] config_item {
        int64_t            time_multiplier;
        static config_item get_current_configs(eosio::name account, eosio::name scope) {
            check(config_container(account, scope.value).exists(), "Stake config not set.");
            return config_container(account, scope.value).get();
        }

        static config_item get_current_or_default_configs(eosio::name account, eosio::name scope) {
            return config_container(account, scope.value).get_or_default();
        }

        void save(eosio::name account, eosio::name scope, eosio::name payer = same_payer) {
            config_container(account, scope.value).set(*this, payer);
        }
    };
    using config_container = eosio::singleton<"config"_n, config_item>;

    struct [[eosio::table("weights"), eosio::contract("stakevote")]] vote_weight {
        eosio::name voter;
        uint64_t    weight;
        uint64_t    weight_quorum;

        uint64_t primary_key() const {
            return voter.value;
        }
    };
    using weight_table = eosio::multi_index<"weights"_n, vote_weight>;

    ACTION stakeobsv(const vector<account_stake_delta> &stake_deltas, const name dac_id);
    ACTION balanceobsv(const vector<account_balance_delta> &balance_deltas, const name dac_id);
    ACTION updateconfig(config_item & new_config, const name dac_id);

#if defined(DEBUG) || defined(IS_DEV)
    ACTION clearweights(uint16_t batch_size, name dac_id);
    ACTION collectwts(uint16_t batch_size, name dac_id, bool assert);
#endif

    bool would_turn_negative(const name voter, S<double> weight_delta, uint64_t weight) {
        SErr::set("would_turn_negative: voter: %s weight: %s - weight_delta: %s", voter, weight, weight_delta);
        const auto new_weight = S<uint64_t>{weight}.to<int64_t>() - weight_delta.abs().to<int64_t>();
        SErr::set("");
        check(new_weight >= int64_t{0},
            "ERR:INVALID_WEIGHT_DELTA_UPDATE: %s Trying to subtract weight_delta %s from %s new_weight: %s", voter,
            weight_delta.to<int64_t>(), weight, new_weight);
        return new_weight < int64_t{0};
    }

    struct [[eosio::table("stakes"), eosio::contract("eosdactokens")]] stake_info {
        name  account;
        asset stake;

        uint64_t primary_key() const {
            return account.value;
        }
    };
    using stakes_table = multi_index<"stakes"_n, stake_info>;
};