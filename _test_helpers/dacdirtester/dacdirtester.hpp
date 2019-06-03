#include <eosio/eosio.hpp>
#include <eosio/symbol.hpp>

class dacdirtester : public eosio::contract {

public:
    dacdirtester( eosio::name s, eosio::name code, eosio::datastream<const char*> ds )
        :contract(s,code,ds){}

    ACTION assertdacid(eosio::name dac_name, uint8_t id);
    ACTION assertdacsym(eosio::symbol sym, uint8_t id);
};
