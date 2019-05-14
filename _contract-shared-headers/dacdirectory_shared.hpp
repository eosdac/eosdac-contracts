#pragma once

#include <eosio/eosio.hpp>
#include <eosio/multi_index.hpp>
#include <eosio/symbol.hpp>

using namespace eosio;
using namespace std;

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

    struct AccountAndScope {
        eosio::name account_name;
        eosio::name dac_scope;
    };

    struct [[eosio::table("dacs"), eosio::contract("dacdirectory")]] dac {
        name         owner;
        name         dac_name;
        string       title;
        symbol       symbol;
        map<uint8_t, string> refs;
        map<uint8_t, eosio::name> accounts;
        map<uint8_t, eosio::name> scopes;
        uint8_t      dac_state;

         eosio::name safe_scope_for_key(uint8_t key) const {
            return (scopes.find(key) != scopes.end()) ? scopes.at(key) : dac_name; 
        }

         AccountAndScope account_and_scope( uint8_t type) const {
            return AccountAndScope{accounts.at(type), safe_scope_for_key(type) };
        }

        uint64_t primary_key() const { return dac_name.value; }
        uint64_t by_owner() const { return owner.value; }
    };

    typedef multi_index< "dacs"_n,  dac,
                        indexed_by<"byowner"_n, const_mem_fun<dac, uint64_t, &dac::by_owner>>
                        > dac_table;


    const dac dac_for_id(name id) {
        dac_table dactable = dac_table("dacdirectory"_n, "dacdirectory"_n.value);
        return dactable.get(id.value, "dac with dac_name not found");
    }
}