#include <eosio/eosio.hpp>
#include <eosio/multi_index.hpp>
#include <eosio/singleton.hpp>

#include "../../contract-shared-headers/dacdirectory_shared.hpp"
#include "../../contract-shared-headers/eosdactokens_shared.hpp"
#include "../../contract-shared-headers/safemath.hpp"

using namespace eosio;
using namespace eosdac;
using namespace std;

static constexpr int64_t time_divisor{100000000};

CONTRACT stakevote : public contract {
  public:
    using contract::contract;

    struct config_item;
    using config_container = eosio::singleton<"config"_n, config_item>;
    struct [[eosio::table("config"), eosio::contract("stakevote")]] config_item {
        // time multiplier is measured in 10^-8 1 == 0.00000001
        int64_t time_multiplier = 100000000;

        static config_item get_current_configs(eosio::name account, eosio::name scope) {
            check(config_container(account, scope.value).exists(), "Stake config not set.");
            return config_container(account, scope.value).get();
        }

        void save(eosio::name account, eosio::name scope, eosio::name payer = same_payer) {
            config_container(account, scope.value).set(*this, payer);
        }
    };

    struct [[eosio::table("weights"), eosio::contract("stakevote")]] vote_weight {
        eosio::name voter;
        uint64_t    weight;

        uint64_t primary_key() const {
            return voter.value;
        }
    };
    using weight_table = eosio::multi_index<"weights"_n, vote_weight>;

    ACTION stakeobsv(vector<account_stake_delta> stake_deltas, name dac_id);
    ACTION balanceobsv(vector<account_balance_delta> balance_deltas, name dac_id);
    ACTION updateconfig(config_item new_config, name dac_id);

    ACTION clearweights(uint16_t batch_size, name dac_id);
    ACTION collectwts(uint16_t batch_size, uint32_t unstake_time, name dac_id);

    struct [[eosio::table("stakes"), eosio::contract("eosdactokens")]] stake_info {
        name  account;
        asset stake;

        uint64_t primary_key() const {
            return account.value;
        }
    };
    using stakes_table = multi_index<"stakes"_n, stake_info>;
};