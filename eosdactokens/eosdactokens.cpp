#include "eosdactokens.hpp"
#include "../_contract-shared-headers/daccustodian_shared.hpp"
#include "../_contract-shared-headers/dacdirectory_shared.hpp"

#include <algorithm>

namespace eosdac {
    eosdactokens::eosdactokens( name s, name code, datastream<const char*> ds )
    :contract(s,code,ds) {}

    void eosdactokens::create(name issuer,
                             asset maximum_supply,
                             bool transfer_locked) {

        auto sym = maximum_supply.symbol;
        check(sym.is_valid(), "ERR::CREATE_INVALID_SYMBOL::invalid symbol name");
        check(maximum_supply.is_valid(), "ERR::CREATE_INVALID_SUPPLY::invalid supply");
        check(maximum_supply.amount > 0, "ERR::CREATE_MAX_SUPPLY_MUST_BE_POSITIVE::max-supply must be positive");

        stats statstable(_self, sym.code().raw());
        auto existing = statstable.find(sym.code().raw());
        check(existing == statstable.end(), "ERR::CREATE_EXISITNG_SYMBOL::token with symbol already exists");

        statstable.emplace(_self, [&](auto &s) {
            s.supply.symbol = maximum_supply.symbol;
            s.max_supply = maximum_supply;
            s.issuer = issuer;
            s.transfer_locked = transfer_locked;
        });
    }

    void eosdactokens::issue(name to, asset quantity, string memo) {
        auto sym = quantity.symbol;
        check(sym.is_valid(), "ERR::ISSUE_INVALID_SYMBOL::invalid symbol name");
        auto sym_name = sym.code().raw();
        stats statstable(_self, sym_name);
        auto existing = statstable.find(sym_name);
        check(existing != statstable.end(), "ERR::ISSUE_NON_EXISTING_SYMBOL::token with symbol does not exist, create token before issue");
        const auto &st = *existing;

        require_auth(st.issuer);
        check(quantity.is_valid(), "ERR::ISSUE_INVALID_QUANTITY::invalid quantity");
        check(quantity.amount > 0, "ERR::ISSUE_NON_POSITIVE::must issue positive quantity");

        check(quantity.symbol == st.supply.symbol, "ERR::ISSUE_INVALID_PRECISION::symbol precision mismatch");
        check(quantity.amount <= st.max_supply.amount - st.supply.amount, "ERR::ISSUE_QTY_EXCEED_SUPPLY::quantity exceeds available supply");

        statstable.modify(st, same_payer, [&](auto &s) {
            s.supply += quantity;
        });

        add_balance(st.issuer, quantity, st.issuer);

        if (to != st.issuer) {
            SEND_INLINE_ACTION(*this, transfer, {st.issuer, "active"_n}, {st.issuer, to, quantity, memo});
        }
    }

    void eosdactokens::burn(name from, asset quantity) {
        print("burn");
        require_auth(from);

        auto sym = quantity.symbol.code();
        stats statstable(_self, sym.raw());
        const auto &st = statstable.get(sym.raw(), "ERR::BURN_UNKNOWN_SYMBOL::Attempting to burn a token unknown to this contract");
        check(!st.transfer_locked, "ERR::BURN_LOCKED_TOKEN::Burn tokens on transferLocked token. The issuer must `unlock` first.");
        require_recipient(from);

        check(quantity.is_valid(), "ERR::BURN_INVALID_QTY_::invalid quantity");
        check(quantity.amount > 0, "ERR::BURN_NON_POSITIVE_QTY_::must burn positive quantity");
        check(quantity.symbol == st.supply.symbol, "ERR::BURN_SYMBOL_MISMATCH::symbol precision mismatch");

        sub_balance(from, quantity);

        statstable.modify(st, name{}, [&](currency_stats &s) {
            s.supply -= quantity;
        });
    }

    void eosdactokens::unlock(asset unlock) {
        check(unlock.symbol.is_valid(), "ERR::UNLOCK_INVALID_SYMBOL::invalid symbol name");
        auto sym_name = unlock.symbol.code().raw();
        stats statstable(_self, sym_name);
        auto token = statstable.find(sym_name);
        check(token != statstable.end(), "ERR::UNLOCK_NON_EXISTING_SYMBOL::token with symbol does not exist, create token before unlock");
        const auto &st = *token;
        require_auth(st.issuer);

        statstable.modify(st, name{}, [&](auto &s) {
            s.transfer_locked = false;
        });
    }

    void eosdactokens::transfer(name from,
                               name to,
                               asset quantity,
                               string memo) {
        check(from != to, "ERR::TRANSFER_TO_SELF::cannot transfer to self");
        require_auth(from);
        check(is_account(to), "ERR::TRANSFER_NONEXISTING_DESTN::to account does not exist");

        auto sym = quantity.symbol.code();
        stats statstable(_self, sym.raw());
        const auto &st = statstable.get(sym.raw());

        if (st.transfer_locked) {
            require_auth(st.issuer);
        }
        
        require_recipient(from, to);

        dacdir::dac dac = dacdir::dac_for_symbol(quantity.symbol);
        eosio::name custodian_contract = dac.account_for_type(dacdir::CUSTO DIAN);

        if (is_account(custodian_contract)) {
            if (to == custodian_contract) {        
                eosio::action(
                    eosio::permission_level{ get_self(), "active"_n },
                    custodian_contract, "capturestake"_n,
                    make_tuple(from, quantity, dac.dac_name)
                ).send();

                print("notifying staking transaction.");

            } else {
                //Send to notify of transfer
                eosio::action(
                    eosio::permission_level{ get_self(), "active"_n },
                    custodian_contract, "transferobsv"_n,
                    make_tuple(from, to, quantity, dac.dac_name)
                ).send();

                print("notifying transfer transaction.");
            }
        }

        check(quantity.is_valid(), "ERR::TRANSFER_INVALID_QTY::invalid quantity");
        check(quantity.amount > 0, "ERR::TRANSFER_NON_POSITIVE_QTY::must transfer positive quantity");
        check(quantity.symbol == st.supply.symbol, "ERR::TRANSFER_SYMBOL_MISMATCH::symbol precision mismatch");
        check(memo.size() <= 256, "ERR::TRANSFER_MEMO_TOO_LONG::memo has more than 256 bytes");

        auto payer = has_auth( to ) ? to : from;

        sub_balance(from, quantity);
        add_balance(to, quantity, payer);
    }

    void eosdactokens::sub_balance(name owner, asset value) {
        accounts from_acnts(_self, owner.value);

        const auto &from = from_acnts.get(value.symbol.code().raw());
        check(from.balance.amount >= value.amount, "ERR::TRANSFER_OVERDRAWN::overdrawn balance");

        from_acnts.modify(from, owner, [&](auto &a) {
            a.balance -= value;
        });
    }

    void eosdactokens::add_balance(name owner, asset value, name ram_payer) {
        accounts to_acnts(_self, owner.value);
        auto to = to_acnts.find(value.symbol.code().raw());
        if (to == to_acnts.end()) {
            to_acnts.emplace(ram_payer, [&](auto &a) {
                a.balance = value;
            });
        } else {
            to_acnts.modify(to, same_payer, [&](auto &a) {
                a.balance += value;
            });
        }
    }

    void eosdactokens::newmemtermse(string terms, string hash, name dac_id) {

        dacdir::dac dac = dacdir::dac_for_id(dac_id);
        eosio::name auth_account = dac.account_for_type(dacdir::AUTH);
        require_auth(auth_account);

        // sample IPFS: QmXjkFQjnD8i8ntmwehoAHBfJEApETx8ebScyVzAHqgjpD
        check(!terms.empty(), "ERR::NEWMEMTERMS_EMPTY_TERMS::Member terms cannot be empty.");
        check(terms.length() <= 256, "ERR::NEWMEMTERMS_TERMS_TOO_LONG::Member terms document url should be less than 256 characters long.");

        check(!hash.empty(), "ERR::NEWMEMTERMS_EMPTY_HASH::Member terms document hash cannot be empty.");
        check(hash.length() <= 32, "ERR::NEWMEMTERMS_HASH_TOO_LONG::Member terms document hash should be less than 32 characters long.");

        memterms memberterms(_self, dac_id.value);

        // guard against duplicate of latest
        if (memberterms.begin() != memberterms.end()) {
            auto last = --memberterms.end();
            check(!(terms == last->terms && hash == last->hash),
                         "ERR::NEWMEMTERMS_DUPLICATE_TERMS::Next member terms cannot be duplicate of the latest.");
        }

        uint64_t next_version = (memberterms.begin() == memberterms.end() ? 0 : (--memberterms.end())->version) + 1;

        memberterms.emplace(auth_account, [&](termsinfo &termsinfo) {
            termsinfo.terms = terms;
            termsinfo.hash = hash;
            termsinfo.version = next_version;
        });
    }

    void eosdactokens::memberrege(name sender, string agreedterms, name dac_id) {
        // agreedterms is expected to be the member terms document hash
        require_auth(sender);
        
        memterms memberterms(_self, dac_id.value);

        check(memberterms.begin() != memberterms.end(), "ERR::MEMBERREG_NO_VALID_TERMS::No valid member terms found.");

        auto latest_member_terms = (--memberterms.end());
        check(latest_member_terms->hash == agreedterms, "ERR::MEMBERREG_NOT_LATEST_TERMS::Agreed terms isn't the latest.");
        regmembers registeredgmembers = regmembers(_self, dac_id.value);

        auto existingMember = registeredgmembers.find(sender.value);
        if (existingMember != registeredgmembers.end()) {
            registeredgmembers.modify(existingMember, sender, [&](member &mem) {
                mem.agreedtermsversion = latest_member_terms->version;
            });
        } else {
            registeredgmembers.emplace(sender, [&](member &mem) {
                mem.sender = sender;
                mem.agreedtermsversion = latest_member_terms->version;
            });
        }
    }

    void eosdactokens::updatetermse(uint64_t termsid, string terms, name dac_id) {
        
        dacdir::dac dac = dacdir::dac_for_id(dac_id);
        eosio::name auth_account = dac.account_for_type(dacdir::AUTH);
        require_auth(auth_account);

        check(terms.length() <= 256, "ERR::UPDATEMEMTERMS_TERMS_TOO_LONG::Member terms document url should be less than 256 characters long.");

        memterms memberterms(_self, dac_id.value);

        auto existingterms = memberterms.find(termsid);
        check(existingterms != memberterms.end(), "ERR::UPDATETERMS_NO_EXISTING_TERMS::Existing terms not found for the given ID");

        memberterms.modify(existingterms, same_payer, [&](termsinfo &t) {
            t.terms = terms;
        });
    }

    void eosdactokens::memberunrege(name sender, name dac_id) {
        require_auth(sender);

        dacdir::dac dac = dacdir::dac_for_id(dac_id);
        eosio::name custodian_account = dac.account_for_type(dacdir::CUSTODIAN);

        candidates_table candidatesTable = candidates_table(custodian_account, dac_id.value);
        auto candidateidx = candidatesTable.find(sender.value);
        if (candidateidx != candidatesTable.end()) {
            print("checking for sender account");

            check(candidateidx->is_active != 1,
                            "ERR::MEMBERUNREG_ACTIVE_CANDIDATE::An active candidate must resign their nomination as candidate before being able to unregister from the members.");
        }

        regmembers registeredgmembers = regmembers(_self, dac_id.value);

        auto regMember = registeredgmembers.find(sender.value);
        check(regMember != registeredgmembers.end(), "ERR::MEMBERUNREG_MEMBER_NOT_REGISTERED::Member is not registered.");
        registeredgmembers.erase(regMember);
    }

    void eosdactokens::close(name owner, const symbol& symbol) {
        require_auth( owner );
        accounts acnts( _self, owner.value );
        auto it = acnts.find( symbol.code().raw() );
        check( it != acnts.end(), "ERR::CLOSE_NON_EXISTING_BALANCE::Balance row already deleted or never existed. Action won't have any effect." );
        check( it->balance.amount == 0, "ERR::CLOSE_NON_ZERO_BALANCE::Cannot close because the balance is not zero." );
        acnts.erase( it );
    }
}
