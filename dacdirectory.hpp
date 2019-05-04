#pragma once

#include <eosio/eosio.hpp>
#include <eosio/multi_index.hpp>
#include <eosio/symbol.hpp>

using namespace eosio;
using namespace std;

CONTRACT dacdirectory : public contract {
public:
    dacdirectory( name self, name first_receiver, datastream<const char*> ds );

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

    TABLE dac {
        name         owner;
        name         dac_name;
        string       title;
        symbol       symbol;
        map<uint8_t, string>  refs;
        map<uint8_t, eosio::name>  accounts;

        uint64_t primary_key() const { return dac_name.value; }
        uint64_t by_owner() const { return owner.value; }
    };

    typedef multi_index< "dacs"_n,  dac,
                        indexed_by<"byowner"_n, const_mem_fun<dac, uint64_t, &dac::by_owner> > > dac_table;

    ACTION regdac( name owner, name dac_name, symbol dac_symbol, string title, map<uint8_t, string> refs,  map<uint8_t, eosio::name> accounts );
    ACTION unregdac( name dac_name );
    ACTION regaccount( name dac_name, name account, uint8_t type );
    ACTION unregaccount( name dac_name, uint8_t type );
    ACTION setowner( name dac_name, name new_owner );

protected:
    dac_table      _dacs;
};