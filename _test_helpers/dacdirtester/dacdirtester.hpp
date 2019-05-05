#include <eosio/eosio.hpp>

using namespace eosio;

class dacdirtester : public contract {

public:
    dacdirtester( name s, name code, datastream<const char*> ds )
        :contract(s,code,ds){}

    ACTION assdacscope(name dac_name, uint8_t scope_type);

};
