#pragma once

#include <eosio/eosio.hpp>
#include <eosio/multi_index.hpp>

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

    struct ref {
        int8_t  type;
        string  data;
    };

    TABLE dac {
        name         owner;
        name         name;
        string       title;
        vector<ref>  refs;

        uint64_t primary_key()const { return name.value; }
        uint64_t by_owner()const { return owner.value; }

        EOSLIB_SERIALIZE( dac, (owner)(name)(title)(refs) )
    };

    struct act {
        name    name;
        uint8_t type;
    };

    TABLE dacaccount {
        name             dac;
        std::vector<act> accounts;

        uint64_t primary_key()const { return dac.value; }

        EOSLIB_SERIALIZE( dacaccount, (dac)(accounts) )
    };

    typedef multi_index< "dacs"_n,  dac,
                        indexed_by<"byowner"_n, const_mem_fun<dac, uint64_t, &dac::by_owner> > > dac_table;
    typedef multi_index< "accounts"_n,  dacaccount > accounts_table;



    ACTION regdac( name owner, name name, string title, vector<ref> refs );
    ACTION unregdac( name dac_name );
    ACTION regaccount( name dac_name, name account, uint8_t type );
    ACTION unregaccount( name dac_name, name account );
    ACTION setowner( name dac_name, name new_owner );

protected:
    dac_table      _dacs;
    accounts_table _accounts;
};