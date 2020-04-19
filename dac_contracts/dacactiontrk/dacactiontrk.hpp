#include <eosio/eosio.hpp>
#include <eosio/multi_index.hpp>
#include <eosio/singleton.hpp>

#include "../../contract-shared-headers/dacdirectory_shared.hpp"

using namespace eosio;
using namespace eosdac;
using namespace std;

namespace eosdac {

    CONTRACT dacactiontrk : public contract {
      public:
        using contract::contract;

        struct config_item;
        typedef eosio::singleton<"config"_n, config_item> config_container;
        struct [[eosio::table("config"), eosio::contract("dacactiontrk")]] config_item {
            uint16_t startingScore;
            uint16_t newperiodAdjustment;
            uint8_t  numberOmittedPeriods;

            static config_item get_current_configs(eosio::name account, eosio::name scope) {
                return config_container(account, scope.value).get_or_default(config_item());
            }

            void save(eosio::name account, eosio::name scope, eosio::name payer = same_payer) {
                config_container(account, scope.value).set(*this, payer);
            }
        };

        struct [[eosio::table("scores"), eosio::contract("dacactiontrk")]] custodian_score {
            eosio::name custodian;
            uint32_t    score;
            uint8_t     periods_omitted;

            uint64_t primary_key() const { return custodian.value; }
            uint64_t by_periods_omitted() const { return periods_omitted; }
        };
        typedef eosio::multi_index<"scores"_n, custodian_score,
            eosio::indexed_by<"omitted"_n,
                eosio::const_mem_fun<custodian_score, uint64_t, &custodian_score::by_periods_omitted>>>
            scores_table;

        ACTION trackevent(name custodian, uint8_t score, name dacId);
        using trackevent_action = action_wrapper<"trackevent"_n, &dacactiontrk::trackevent>;

        ACTION periodend(vector<name> currentCustodians, name dacId);
        using periodend_action = action_wrapper<"periodend"_n, &dacactiontrk::periodend>;

        ACTION periodstart(vector<name> newCustodians, name dacId);
        using periodstart_action = action_wrapper<"periodstart"_n, &dacactiontrk::periodstart>;

        ACTION updateconfig(config_item new_config, name dacId);
    };
}; // namespace eosdac