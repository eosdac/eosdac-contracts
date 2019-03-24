#include "dacdirectory.hpp"

using namespace eosio;
using namespace std;

dacdirectory::dacdirectory( eosio::name self, eosio::name first_receiver, eosio::datastream<const char*> ds )
        :contract( self, first_receiver, ds )
        ,_dacs( get_self(), get_self().value )
        ,_accounts( get_self(), get_self().value )
{}

void dacdirectory::regdac( name owner, name name, string title, vector<ref> refs ) {
    require_auth(owner);

    auto existing = _dacs.find(name.value);

    if (existing == _dacs.end()){
        _dacs.emplace(owner, [&](dac& i) {
            i.owner = owner;
            i.name = name;
            i.title = title;
            i.refs = refs;
        });
    }
    else {
        require_auth(existing->owner);

        _dacs.modify(existing, same_payer, [&](dac& i) {
            i.name = name;
            i.title = title;
            i.refs = refs;
        });
    }
}
void dacdirectory::unregdac( name dac_name ) {

    auto dac = _dacs.find(dac_name.value);
    check(dac != _dacs.end(), "DAC not found in directory");

    require_auth(dac->owner);

    auto dac_account = _accounts.find(dac_name.value);
    if (dac_account != _accounts.end()){
        _accounts.erase(dac_account);
    }

    _dacs.erase(dac);
}


void dacdirectory::regaccount( name dac_name, name account, uint8_t type ){

    check(is_account(account), "Invalid or non-existent account supplied");

    auto dac = _dacs.find(dac_name.value);
    check(dac != _dacs.end(), "DAC not found in directory");

    require_auth(dac->owner);

    bool modified = false;
    auto dac_account = _accounts.find(dac_name.value);

    if (dac_account != _accounts.end()){
        vector<act> accounts = dac_account->accounts;
        accounts.emplace_back(act{account, type});

        _accounts.modify(dac_account, same_payer, [&](dacaccount& a) {
            a.accounts = accounts;
        });
    }
    else {
        vector<act> accounts;
        accounts.emplace_back(act{account, type});

        _accounts.emplace(dac->owner, [&](dacaccount& a) {
            a.dac = dac_name;
            a.accounts = accounts;
        });
    }
}

void dacdirectory::unregaccount( name dac_name, name account ){

    auto dac = _dacs.find(dac_name.value);
    check(dac != _dacs.end(), "DAC not found in directory");

    require_auth(dac->owner);

    auto dac_account = _accounts.find(dac_name.value);
    check(dac_account != _accounts.end(), "Accounts entry not found");

    vector<act> accounts = dac_account->accounts;
    vector<act> new_accounts;

    while (!accounts.empty()){
        act a = accounts.back();
        if (a.name != account){
            new_accounts.emplace_back(a);
        }
        accounts.pop_back();
    }

    _accounts.modify(dac_account, same_payer, [&](dacaccount& a) {
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
