#include <eosio/eosio.hpp>
#include <eosio/multi_index.hpp>
#include <eosio/singleton.hpp>

#include "../_contract-shared-headers/dacdirectory_shared.hpp"
#include "../_contract-shared-headers/eosdactokens_shared.hpp"

using namespace eosio;
using namespace eosdac;
using namespace std;

CONTRACT stakevote : public contract {
  public:
    using contract::contract;

    struct config_item;
    typedef eosio::singleton<"config"_n, config_item> config_container;
    struct [[eosio::table("config"), eosio::contract("stakevote")]] config_item {
        // time multiplier is measured in 10^-8 1 == 0.00000001
        uint16_t time_multiplier = (uint16_t)100000000;

        static config_item get_current_configs(eosio::name account, eosio::name scope) {
            return config_container(account, scope.value).get_or_default(config_item());
        }

        void save(eosio::name account, eosio::name scope, eosio::name payer = same_payer) {
            config_container(account, scope.value).set(*this, payer);
        }
    };

    struct [[eosio::table("weights"), eosio::contract("stakevote")]] vote_weight {
        eosio::name voter;
        uint64_t    weight;

        uint64_t primary_key() const { return voter.value; }
    };
    typedef eosio::multi_index<"weights"_n, vote_weight> weight_table;

    ACTION stakeobsv(vector<account_stake_delta> stake_deltas, name dac_id);
    ACTION balanceobsv(vector<account_balance_delta> balance_deltas, name dac_id);
    ACTION updateconfig(config_item new_config, name dac_id);
};