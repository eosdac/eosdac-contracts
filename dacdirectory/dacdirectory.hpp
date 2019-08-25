#pragma once

#include <eosio/eosio.hpp>
#include <eosio/multi_index.hpp>
#include <eosio/symbol.hpp>
#include "../_contract-shared-headers/dacdirectory_shared.hpp"

using namespace eosio;
using namespace std;

namespace eosdac {
    namespace dacdir {
        CONTRACT dacdirectory : public contract {
        public:
            dacdirectory( name self, name first_receiver, datastream<const char*> ds );

            ACTION regdac( name owner, name dac_id, extended_symbol dac_symbol, string title, map<uint8_t, string> refs,  map<uint8_t, eosio::name> accounts );
            ACTION unregdac( name dac_id );
            ACTION regaccount( name dac_id, name account, uint8_t type );
            ACTION unregaccount( name dac_id, uint8_t type );
            ACTION regref( name dac_id, string value, uint8_t type );
            ACTION unregref( name dac_id, uint8_t type );
            ACTION setowner( name dac_id, name new_owner );
            ACTION setstatus( name dac_id, uint8_t value );

        protected:
            dac_table      _dacs;
        };
    }
}
