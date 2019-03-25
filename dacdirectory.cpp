#include "dacdirectory.hpp"

using namespace eosio;
using namespace std;

dacdirectory::dacdirectory( eosio::name self, eosio::name first_receiver, eosio::datastream<const char*> ds )
        :contract( self, first_receiver, ds )
        ,_dacs( get_self(), get_self().value )
{}

void dacdirectory::regdac( name owner, name name, symbol dac_symbol, string title, vector<ref> refs,  vector<dacdirectory::act> accounts ) {
    require_auth(owner);

    auto existing = _dacs.find(name.value);

    if (existing == _dacs.end()){
        _dacs.emplace(owner, [&](dac& d) {
            d.owner = owner;
            d.name = name;
            d.symbol = dac_symbol;
            d.title = title;
            d.refs = refs;
            d.accounts = accounts;
        });
    }
    else {
        require_auth(existing->owner);

        _dacs.modify(existing, same_payer, [&](dac& d) {
            d.name = name;
            d.symbol = dac_symbol;
            d.title = title;
            d.refs = refs;
            d.accounts = accounts;
        });
    }
}
void dacdirectory::unregdac( name dac_name ) {

    auto dac = _dacs.find(dac_name.value);
    check(dac != _dacs.end(), "DAC not found in directory");

    require_auth(dac->owner);

    _dacs.erase(dac);
}


void dacdirectory::regaccount( name dac_name, name account, uint8_t type ){

    check(is_account(account), "Invalid or non-existent account supplied");

    auto dac_inst = _dacs.find(dac_name.value);
    check(dac_inst != _dacs.end(), "DAC not found in directory");

    require_auth(dac_inst->owner);

    vector<act> accounts = dac_inst->accounts;
    accounts.emplace_back(act{account, type});

    _dacs.modify(dac_inst, same_payer, [&](dac& d) {
        d.accounts = accounts;
    });

}

void dacdirectory::unregaccount( name dac_name, name account ){

    auto dac_inst = _dacs.find(dac_name.value);
    check(dac_inst != _dacs.end(), "DAC not found in directory");

    require_auth(dac_inst->owner);

    vector<act> accounts = dac_inst->accounts;
    vector<act> new_accounts;

    while (!accounts.empty()){
        act a = accounts.back();
        if (a.name != account){
            new_accounts.emplace_back(a);
        }
        accounts.pop_back();
    }

    _dacs.modify(dac_inst, same_payer, [&](dac& a) {
        a.accounts = new_accounts;
    });
}


void dacdirectory::setowner( name dac_name, name new_owner ){

    auto existing_dac = _dacs.find(dac_name.value);
    check(existing_dac != _dacs.end(), "DAC not found in directory");

    require_auth(existing_dac->owner);
    require_auth(new_owner);

    _dacs.modify(existing_dac, new_owner, [&](dac& d) {
        d.owner = new_owner;
    });
}
