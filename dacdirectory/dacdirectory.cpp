#include "dacdirectory.hpp"

using namespace eosio;
using namespace std;
namespace dacdir {
    
    dacdirectory::dacdirectory( eosio::name self, eosio::name first_receiver, eosio::datastream<const char*> ds )
            :contract( self, first_receiver, ds )
            ,_dacs( get_self(), get_self().value )
    {}

    void dacdirectory::regdac( eosio::name owner, eosio::name dac_name, symbol dac_symbol, string title, map<uint8_t, string> refs,  map<uint8_t, eosio::name> accounts,  map<uint8_t, eosio::name> scopes ) {
        require_auth(owner);

        auto existing = _dacs.find(dac_name.value);

        if (existing == _dacs.end()){
            _dacs.emplace(owner, [&](dac& d) {
                d.owner = owner;
                d.dac_name = dac_name;
                d.symbol = dac_symbol;
                d.title = title;
                d.refs = refs;
                d.accounts = accounts;
                d.scopes = scopes;
            });
        }
        else {
            require_auth(existing->owner);

            _dacs.modify(existing, same_payer, [&](dac& d) {
                d.dac_name = dac_name;
                d.symbol = dac_symbol;
                d.title = title;
                d.refs = refs;
                d.accounts = accounts;
                d.scopes = scopes;
            });
        }
    }

    void dacdirectory::unregdac( name dac_name ) {

        auto dac = _dacs.find(dac_name.value);
        check(dac != _dacs.end(), "DAC not found in directory");

        require_auth(dac->owner);

        _dacs.erase(dac);
    }

    void dacdirectory::regaccount( name dac_name, name account, uint8_t type, optional<eosio::name> scope){

        check(is_account(account), "Invalid or non-existent account supplied");

        auto dac_inst = _dacs.find(dac_name.value);
        check(dac_inst != _dacs.end(), "DAC not found in directory");

        require_auth(dac_inst->owner);

        _dacs.modify(dac_inst, same_payer, [&](dac& d) {
            d.accounts[type] = account;
            if (scope && scope.value() != name{0} ) {
                d.scopes[type] = scope.value();
            }
        });
    }

    void dacdirectory::unregaccount( name dac_name, uint8_t type ){

        auto dac_inst = _dacs.find(dac_name.value);
        check(dac_inst != _dacs.end(), "DAC not found in directory");

        require_auth(dac_inst->owner);

        _dacs.modify(dac_inst, same_payer, [&](dac& a) {
            a.accounts.erase(type);
            a.scopes.erase(type);
        });
    }

    void dacdirectory::regref( name dac_name, string value, uint8_t type ){

        auto dac_inst = _dacs.find(dac_name.value);
        check(dac_inst != _dacs.end(), "DAC not found in directory");

        require_auth(dac_inst->owner);

        _dacs.modify(dac_inst, same_payer, [&](dac& d) {
            d.refs[type] = value;
        });
    }

    void dacdirectory::unregref( name dac_name, uint8_t type ){

        auto dac_inst = _dacs.find(dac_name.value);
        check(dac_inst != _dacs.end(), "DAC not found in directory");

        require_auth(dac_inst->owner);

        _dacs.modify(dac_inst, same_payer, [&](dac& d) {
            d.refs.erase(type);
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
} // dacdir

