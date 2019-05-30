#ifndef DACDIRECTORY_SHARED_H
#define DACDIRECTORY_SHARED_H

#include <eosio/eosio.hpp>
#include <eosio/multi_index.hpp>
#include <eosio/symbol.hpp>

namespace eosdac {

    namespace dacdir {

        enum account_type: uint8_t {
            AUTH = 0,
            TREASURY = 1,
            CUSTODIAN = 2,
            MSIGS = 3,
            TOKEN = 4,
            SERVICE = 5,
            PROPOSALS = 6,
            ESCROW = 7,
            EXTERNAL = 254,
            OTHER = 255
        };

        enum dac_state_type: uint8_t {
            dac_state_typeINACTIVE = 0,
            dac_state_typeACTIVE = 1
        };

        struct [[eosio::table("dacs"), eosio::contract("dacdirectory")]] dac {
            eosio::name         owner;
            eosio::name         dac_name;
            std::string         title;
            eosio::symbol       symbol;
            std::map<uint8_t, std::string> refs;
            std::map<uint8_t, eosio::name> accounts;
            uint8_t      dac_state;

            eosio::name account_for_type( uint8_t type) const {
                eosio::print("\ngetting account for type: ", type,"\n");
                return accounts.at(type);
            }

            uint64_t primary_key() const { return dac_name.value; }
            uint64_t by_owner() const { return owner.value; }
            uint64_t by_symbol() const { return symbol.raw(); }
        };

        typedef eosio::multi_index< "dacs"_n,  dac,
                                    eosio::indexed_by<"byowner"_n, eosio::const_mem_fun<dac, uint64_t, &dac::by_owner>>,
                                    eosio::indexed_by<"bysymbol"_n, eosio::const_mem_fun<dac, uint64_t, &dac::by_symbol>>
                                    > dac_table;


        const dac dac_for_id(eosio::name id) {
            dac_table dactable = dac_table("dacdirectory"_n, "dacdirectory"_n.value);
            return dactable.get(id.value, "dac with dac_name not found");
        }

        const dac dac_for_symbol(eosio::symbol sym) {
            dac_table dactable = dac_table("dacdirectory"_n, "dacdirectory"_n.value);
            auto index = dactable.get_index<"bysymbol"_n>();
            auto dac_idx = index.find(sym.raw());
            print("\ndac_for_symbol: ", sym, "\n"); 
            eosio::check(dac_idx != index.end() && dac_idx->symbol == sym, "dac not found for the given symbol");
            return *dac_idx;
        }
    }
}

#endif