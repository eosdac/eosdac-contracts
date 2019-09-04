#pragma once

#include <eosio/asset.hpp>
#include <eosio/eosio.hpp>
#include <eosio/multi_index.hpp>
#include <eosio/transaction.hpp>
#include <eosio/singleton.hpp>

using namespace eosio;
using namespace std;

#include "../_contract-shared-headers/daccustodian_shared.hpp"
#include "../_contract-shared-headers/dacdirectory_shared.hpp"
#include "../_contract-shared-headers/eosdactokens_shared.hpp"
#include "../_contract-shared-headers/migration_helpers.hpp"

namespace eosiosystem {
    class system_contract;
}

namespace eosdac {


    CONTRACT eosdactokens : public contract {
    public:

        using contract::contract;
        eosdactokens( name s, name code, datastream<const char*> ds );

        struct stake_config;

        ACTION create(name issuer, asset maximum_supply, bool transfer_locked);
        ACTION issue(name to, asset quantity, string memo);
        ACTION unlock(asset unlock);
        ACTION burn(name from, asset quantity);
        ACTION transfer(name from, name to, asset quantity, string memo);
        ACTION newmemtermse(string terms, string hash, name dac_id);
        ACTION newmemterms(string terms, string hash);
        ACTION memberrege(name sender, string agreedterms, name dac_id);
        ACTION memberreg(name sender, string agreedterms);
        ACTION memberunrege(name sender, name dac_id);
        ACTION memberunreg(name sender);
        ACTION updatetermse(uint64_t termsid, string terms, name dac_id);
        ACTION updateterms(uint64_t termsid, string terms);
        ACTION close(name owner, const symbol& symbol);

        // staking
        ACTION stake(name account, asset quantity);
        ACTION unstake(name account, asset quantity);
        ACTION staketime(name account, uint32_t unstake_time, symbol token_symbol);
        ACTION stakeconfig(stake_config config, symbol token_symbol);
        ACTION refund(uint64_t unstake_id, symbol token_symbol);
        ACTION cancel(uint64_t unstake_id, symbol token_symbol);

        ACTION migrate(uint16_t batch);
        ACTION clearold(uint16_t batch_size);




        TABLE stake_info {
            name  account;
            asset stake;

            uint64_t primary_key() const { return account.value; }
        };
        typedef multi_index<"stakes"_n, stake_info> stakes_table;

        TABLE unstake_info {
                uint64_t       key;
                name           account;
                asset          stake;
                time_point_sec release_time;

                uint64_t primary_key() const { return key; }
                uint64_t by_account() const { return account.value; }
        };
        typedef multi_index<"unstakes"_n, unstake_info,
                indexed_by<"byaccount"_n, const_mem_fun<unstake_info, uint64_t, &unstake_info::by_account> >
        > unstakes_table;

        TABLE staketime_info {
                name           account;
                uint32_t       delay;

                uint64_t primary_key() const { return account.value; }
        };
        typedef multi_index<"staketime"_n, staketime_info > staketimes_table;

        typedef eosio::singleton<"stakeconfig"_n, stake_config> stateconfig_container;
        struct [[eosio::table("stakeconfig"), eosio::contract("eosdactokens")]] stake_config {
            bool     enabled = false;
            uint32_t min_stake_time = uint32_t(60 * 60 * 24 * 3);
            uint32_t max_stake_time = uint32_t(60 * 60 * 24 * 30 * 9);

            static stake_config get_current_configs(eosio::name account, eosio::name scope) {
                return stateconfig_container(account, scope.value).get_or_default(stake_config());
            }

            void save(eosio::name account, eosio::name scope, eosio::name payer = same_payer) {
                stateconfig_container(account, scope.value).set(*this, payer);
            }
        };


        TABLE member {
            name sender;
            // agreed terms version
            uint64_t agreedtermsversion;

            uint64_t primary_key() const { return sender.value; }
        };

        typedef multi_index<"members"_n, member> regmembers;

        TABLE termsinfo {
            string terms;
            string hash;
            uint64_t version;

            termsinfo() : terms(""), hash(""), version(0) {}

            termsinfo(string _terms, string _hash, uint64_t _version)
                    : terms(_terms), hash(_hash), version(_version) {}

            uint64_t primary_key() const { return version; }
            uint64_t by_latest_version() const { return UINT64_MAX - version; }

          EOSLIB_SERIALIZE(termsinfo, (terms)(hash)(version))
        };

        typedef multi_index<"memberterms"_n, termsinfo,
                indexed_by<"bylatestver"_n, const_mem_fun<termsinfo, uint64_t, &termsinfo::by_latest_version> >
        > memterms;

        friend eosiosystem::system_contract;

//        inline asset get_supply(symbol_code sym) const;
//        inline asset get_balance(name owner, symbol_code sym) const;

    public:

        TABLE account {
            asset balance;

            uint64_t primary_key() const { return balance.symbol.code().raw(); }
        };

        TABLE currency_stats {
            asset supply;
            asset max_supply;
            name issuer;
            bool transfer_locked = false;

            uint64_t primary_key() const { return supply.symbol.code().raw(); }
        };

        typedef eosio::multi_index<"accounts"_n, account> accounts;
        typedef eosio::multi_index<"stat"_n, currency_stats> stats;

        void sub_balance(name owner, asset value);
        void add_balance(name owner, asset value, name payer);
        void sub_stake(name owner, asset value, name dac_id);
        void add_stake(name owner, asset value, name dac_id);

        void send_stake_notification(name account, asset stake, dacdir::dac dac_inst);
        void send_balance_notification(vector<account_balance_delta> account_weights, dacdir::dac dac_inst);

    };

}
