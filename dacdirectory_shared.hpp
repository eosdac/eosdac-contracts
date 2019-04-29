#pragma once

#include <eosio/eosio.hpp>
#include <eosio/multi_index.hpp>
#include <eosio/symbol.hpp>

using namespace eosio;
using namespace std;

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

struct [[eosio::table("dacs"), eosio::contract("dacdirectory")]] dac {
    name         owner;
    name         dac_name;
    string       title;
    symbol       symbol;
    map<uint8_t, string>  refs;
    map<uint8_t, eosio::name>  accounts;
    map<uint8_t, uint64_t>  scopes;

    uint64_t scope_for_key(uint8_t key) {
        return scopes[key] ? scopes[key] : dac_name.value;
    }

    uint64_t primary_key() const { return dac_name.value; }
    uint64_t by_owner() const { return owner.value; }
};

typedef multi_index< "dacs"_n,  dac,
                    indexed_by<"byowner"_n, const_mem_fun<dac, uint64_t, &dac::by_owner> > > dac_table;