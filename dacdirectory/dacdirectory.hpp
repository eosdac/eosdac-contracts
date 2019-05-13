#pragma once

#include <eosio/eosio.hpp>
#include <eosio/multi_index.hpp>
#include <eosio/symbol.hpp>
#include "../_contract-shared-headers/dacdirectory_shared.hpp"

using namespace eosio;
using namespace std;

namespace dacdir {
    CONTRACT dacdirectory : public contract {
    public:
        dacdirectory( name self, name first_receiver, datastream<const char*> ds );

        ACTION regdac( name owner, name dac_name, symbol dac_symbol, string title, map<uint8_t, string> refs,  map<uint8_t, eosio::name> accounts, map<uint8_t, eosio::name> scopes );
        ACTION unregdac( name dac_name );
        ACTION regaccount( name dac_name, name account, uint8_t type, optional<eosio::name> scope );
        ACTION unregaccount( name dac_name, uint8_t type );
        ACTION regref( name dac_name, string value, uint8_t type );
        ACTION unregref( name dac_name, uint8_t type );
        ACTION setowner( name dac_name, name new_owner );

    protected:
        dac_table      _dacs;
    };
}