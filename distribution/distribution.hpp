#include <eosio/eosio.hpp>
#include <eosio/multi_index.hpp>
#include <eosio/print.hpp>
#include <eosio/asset.hpp>
#include <eosio/symbol.hpp>

using namespace eosio;
using namespace std;

CONTRACT distribution : public contract {
    public:
        using contract::contract;
        distribution(eosio::name receiver, eosio::name code, datastream<const char*> ds):contract(receiver, code, ds) {}

        struct dropdata {
            name receiver;
            asset amount;
        };

        enum distri_types: uint8_t {
            CLAIMABLE = 0,
            SENDABLE = 1,
            INVALID = 2
        };

         ACTION regdistri(name distri_id, name dac_id, name owner, name approver_account, extended_asset total_amount, uint8_t distri_type, string memo);
         ACTION deldistrconf(name distri_id);
         ACTION approve(name distri_id);

         ACTION populate(name distri_id, vector <dropdata> data, bool allow_modify);
         ACTION empty(name distri_id, uint8_t batch_size);
         ACTION sendtokens(name distri_id, uint8_t batch_size);
         ACTION claim(name distri_id, name receiver);

    private:

        //table to hold distribution configs/state
        TABLE districonf {

            name distri_id;
            name dac_id;
            name owner;
            bool approved; //default false
            uint8_t distri_type;
            name approver_account;
            extended_asset total_amount;
            asset total_sent;//update by each claim/sendtokens
            string memo;

            uint64_t primary_key() const { return distri_id.value; }
            uint64_t by_dac_id() const { return dac_id.value; }
            uint64_t by_owner() const { return owner.value; }
        };
        typedef eosio::multi_index<"districonfs"_n, districonf,
                eosio::indexed_by<"bydacid"_n, eosio::const_mem_fun<districonf, uint64_t, &districonf::by_dac_id>>,
                eosio::indexed_by<"byowner"_n, eosio::const_mem_fun<districonf, uint64_t, &districonf::by_owner>>
        > districonf_table;

        //scoped table by distri_id
        TABLE distri {
            name receiver;
            asset amount;
            uint64_t primary_key() const { return receiver.value; }
        };

        typedef eosio::multi_index<"distris"_n, distri> distri_table;

};
