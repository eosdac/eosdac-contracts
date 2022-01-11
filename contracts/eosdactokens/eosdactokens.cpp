#include "eosdactokens.hpp"

#include <algorithm>

namespace eosdac {
    eosdactokens::eosdactokens(name s, name code, datastream<const char *> ds) : contract(s, code, ds) {}

    void eosdactokens::create(name issuer, asset maximum_supply, bool transfer_locked) {

        require_auth(get_self());

        auto sym = maximum_supply.symbol;
        check(sym.is_valid(), "ERR::CREATE_INVALID_SYMBOL::invalid symbol name");
        check(maximum_supply.is_valid(), "ERR::CREATE_INVALID_SUPPLY::invalid supply");
        check(maximum_supply.amount > 0, "ERR::CREATE_MAX_SUPPLY_MUST_BE_POSITIVE::max-supply must be positive");

        stats statstable(_self, sym.code().raw());
        auto  existing = statstable.find(sym.code().raw());
        check(existing == statstable.end(), "ERR::CREATE_EXISITNG_SYMBOL::token with symbol already exists");

        statstable.emplace(_self, [&](auto &s) {
            s.supply.symbol   = maximum_supply.symbol;
            s.max_supply      = maximum_supply;
            s.issuer          = issuer;
            s.transfer_locked = transfer_locked;
        });
    }

    void eosdactokens::issue(name to, asset quantity, string memo) {
        auto sym = quantity.symbol;
        check(sym.is_valid(), "ERR::ISSUE_INVALID_SYMBOL::invalid symbol name");
        auto  sym_name = sym.code().raw();
        stats statstable(_self, sym_name);
        auto  existing = statstable.find(sym_name);
        check(existing != statstable.end(),
            "ERR::ISSUE_NON_EXISTING_SYMBOL::token with symbol does not exist, create token before issue");
        const auto &st = *existing;
        check(to == st.issuer, "ERR:ISSUE_INVALID_RECIPIENT tokens can only be issued to issuer account");

        require_auth(st.issuer);
        check(quantity.is_valid(), "ERR::ISSUE_INVALID_QUANTITY::invalid quantity");
        check(quantity.amount > 0, "ERR::ISSUE_NON_POSITIVE::must issue positive quantity");

        check(quantity.symbol == st.supply.symbol, "ERR::ISSUE_INVALID_PRECISION::symbol precision mismatch");
        check(quantity.amount <= st.max_supply.amount - st.supply.amount,
            "ERR::ISSUE_QTY_EXCEED_SUPPLY::quantity exceeds available supply");

        statstable.modify(st, same_payer, [&](auto &s) {
            s.supply += quantity;
        });

        add_balance(st.issuer, quantity, st.issuer);
    }

    void eosdactokens::burn(name from, asset quantity) {
        print("burn");
        require_auth(from);

        auto        sym = quantity.symbol.code();
        stats       statstable(_self, sym.raw());
        const auto &st =
            statstable.get(sym.raw(), "ERR::BURN_UNKNOWN_SYMBOL::Attempting to burn a token unknown to this contract");
        check(!st.transfer_locked,
            "ERR::BURN_LOCKED_TOKEN::Burn tokens on transferLocked token. The issuer must `unlock` first.");
        require_recipient(from);

        check(quantity.is_valid(), "ERR::BURN_INVALID_QTY_::invalid quantity");
        check(quantity.amount > 0, "ERR::BURN_NON_POSITIVE_QTY_::must burn positive quantity");
        check(quantity.symbol == st.supply.symbol, "ERR::BURN_SYMBOL_MISMATCH::symbol precision mismatch");

        sub_balance(from, quantity);

        // Send to notify of balance change
        dacdir::dac                   dac = dacdir::dac_for_symbol(extended_symbol{quantity.symbol, get_self()});
        vector<account_balance_delta> account_weights;
        account_weights.push_back(account_balance_delta{from, quantity * -1});

        send_balance_notification(account_weights, dac);

        statstable.modify(st, name{}, [&](currency_stats &s) {
            s.supply -= quantity;
        });
    }

    void eosdactokens::unlock(asset unlock) {
        check(unlock.symbol.is_valid(), "ERR::UNLOCK_INVALID_SYMBOL::invalid symbol name");
        auto  sym_name = unlock.symbol.code().raw();
        stats statstable(_self, sym_name);
        auto  token = statstable.find(sym_name);
        check(token != statstable.end(),
            "ERR::UNLOCK_NON_EXISTING_SYMBOL::token with symbol does not exist, create token before unlock");
        const auto &st = *token;
        require_auth(st.issuer);

        statstable.modify(st, name{}, [&](auto &s) {
            s.transfer_locked = false;
        });
    }

    void eosdactokens::transfer(name from, name to, asset quantity, string memo) {
        check(from != to, "ERR::TRANSFER_TO_SELF::cannot transfer to self");
        require_auth(from);
        check(is_account(to), "ERR::TRANSFER_NONEXISTING_DESTN::to account does not exist");

        auto        sym = quantity.symbol.code();
        stats       statstable(_self, sym.raw());
        const auto &st = statstable.get(sym.raw());

        if (st.transfer_locked) {
            check(has_auth(st.issuer), "Transfer is locked, need issuer permission");
        }

        require_recipient(from, to);

        dacdir::dac dac = dacdir::dac_for_symbol(extended_symbol{quantity.symbol, get_self()});

        // Send to notify of balance change
        vector<account_balance_delta> account_weights;
        account_weights.push_back(account_balance_delta{from, quantity * -1});
        account_weights.push_back(account_balance_delta{to, quantity});

        send_balance_notification(account_weights, dac);

        check(quantity.is_valid(), "ERR::TRANSFER_INVALID_QTY::invalid quantity");
        check(quantity.amount > 0, "ERR::TRANSFER_NON_POSITIVE_QTY::must transfer positive quantity");
        check(quantity.symbol == st.supply.symbol, "ERR::TRANSFER_SYMBOL_MISMATCH::symbol precision mismatch");
        check(memo.size() <= 256, "ERR::TRANSFER_MEMO_TOO_LONG::memo has more than 256 bytes");

        // Check transfer doesnt exceed stake
        stake_config stakeconfig = stake_config::get_current_configs(get_self(), dac.dac_id);
        if (stakeconfig.enabled) {
            asset liquid = eosdac::get_liquid(from, get_self(), quantity.symbol);

            check(
                quantity <= liquid, "ERR::BALANCE_STAKED::Attempt to transfer more than liquid balance, unstake first");
        }

        auto payer = has_auth(to) ? to : from;

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
        auto     to = to_acnts.find(value.symbol.code().raw());
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

        dacdir::dac dac          = dacdir::dac_for_id(dac_id);
        eosio::name auth_account = dac.account_for_type(dacdir::AUTH);
        require_auth(auth_account);

        // sample IPFS: QmXjkFQjnD8i8ntmwehoAHBfJEApETx8ebScyVzAHqgjpD
        check(!terms.empty(), "ERR::NEWMEMTERMS_EMPTY_TERMS::Member terms cannot be empty.");
        check(terms.length() <= 256,
            "ERR::NEWMEMTERMS_TERMS_TOO_LONG::Member terms document url should be less than 256 characters long.");

        check(!hash.empty(), "ERR::NEWMEMTERMS_EMPTY_HASH::Member terms document hash cannot be empty.");
        check(hash.length() <= 32,
            "ERR::NEWMEMTERMS_HASH_TOO_LONG::Member terms document hash should be less than 32 characters long.");

        memterms memberterms(_self, dac_id.value);

        // guard against duplicate of latest
        if (memberterms.begin() != memberterms.end()) {
            auto last = --memberterms.end();
            check(!(terms == last->terms && hash == last->hash),
                "ERR::NEWMEMTERMS_DUPLICATE_TERMS::Next member terms cannot be duplicate of the latest.");
        }

        uint64_t next_version = (memberterms.begin() == memberterms.end() ? 0 : (--memberterms.end())->version) + 1;

        memberterms.emplace(auth_account, [&](termsinfo &termsinfo) {
            termsinfo.terms   = terms;
            termsinfo.hash    = hash;
            termsinfo.version = next_version;
        });
    }

    void eosdactokens::memberrege(name sender, string agreedterms, name dac_id) {
        // agreedterms is expected to be the member terms document hash
        require_auth(sender);

        memterms memberterms(_self, dac_id.value);

        check(memberterms.begin() != memberterms.end(), "ERR::MEMBERREG_NO_VALID_TERMS::No valid member terms found.");

        auto latest_member_terms = (--memberterms.end());
        check(latest_member_terms->hash == agreedterms,
            "ERR::MEMBERREG_NOT_LATEST_TERMS::Agreed terms isn't the latest.");
        regmembers registeredgmembers = regmembers(_self, dac_id.value);

        auto existingMember = registeredgmembers.find(sender.value);
        if (existingMember != registeredgmembers.end()) {
            registeredgmembers.modify(existingMember, sender, [&](member &mem) {
                mem.agreedtermsversion = latest_member_terms->version;
            });
        } else {
            registeredgmembers.emplace(sender, [&](member &mem) {
                mem.sender             = sender;
                mem.agreedtermsversion = latest_member_terms->version;
            });
        }
    }

    void eosdactokens::updatetermse(uint64_t termsid, string terms, name dac_id) {

        dacdir::dac dac          = dacdir::dac_for_id(dac_id);
        eosio::name auth_account = dac.account_for_type(dacdir::AUTH);
        require_auth(auth_account);

        check(terms.length() <= 256,
            "ERR::UPDATEMEMTERMS_TERMS_TOO_LONG::Member terms document url should be less than 256 characters long.");

        memterms memberterms(_self, dac_id.value);

        auto existingterms = memberterms.find(termsid);
        check(existingterms != memberterms.end(),
            "ERR::UPDATETERMS_NO_EXISTING_TERMS::Existing terms not found for the given ID");

        memberterms.modify(existingterms, same_payer, [&](termsinfo &t) {
            t.terms = terms;
        });
    }

    void eosdactokens::memberunrege(name sender, name dac_id) {
        require_auth(sender);

        dacdir::dac dac               = dacdir::dac_for_id(dac_id);
        eosio::name custodian_account = dac.account_for_type(dacdir::CUSTODIAN);

        candidates_table candidatesTable = candidates_table(custodian_account, dac_id.value);
        auto             candidateidx    = candidatesTable.find(sender.value);
        if (candidateidx != candidatesTable.end()) {
            print("checking for sender account");

            check(candidateidx->is_active != 1,
                "ERR::MEMBERUNREG_ACTIVE_CANDIDATE::An active candidate must resign their nomination as candidate before being able to unregister from the members.");
        }

        regmembers registeredgmembers = regmembers(_self, dac_id.value);

        auto regMember = registeredgmembers.find(sender.value);
        check(
            regMember != registeredgmembers.end(), "ERR::MEMBERUNREG_MEMBER_NOT_REGISTERED::Member is not registered.");
        registeredgmembers.erase(regMember);
    }

    void eosdactokens::close(name owner, const symbol &symbol) {
        require_auth(owner);
        accounts acnts(_self, owner.value);
        auto     it = acnts.find(symbol.code().raw());
        check(it != acnts.end(),
            "ERR::CLOSE_NON_EXISTING_BALANCE::Balance row already deleted or never existed. Action won't have any effect.");
        check(it->balance.amount == 0, "ERR::CLOSE_NON_ZERO_BALANCE::Cannot close because the balance is not zero.");
        acnts.erase(it);
    }

    // Staking functions

    void eosdactokens::xferstake(name from, name to, asset quantity, string memo) {
        require_auth(from);
        dacdir::dac dac                = dacdir::dac_for_symbol(extended_symbol{quantity.symbol, get_self()});
        eosio::name custodian_contract = dac.account_for_type(dacdir::CUSTODIAN);

        stake_config config = stake_config::get_current_configs(get_self(), dac.dac_id);
        check(config.enabled, "ERR::STAKING_NOT_ENABLED::Staking is not enabled for this token");

        check(quantity.is_valid(), "ERR::STAKE_INVALID_QTY::Invalid quantity supplied");
        check(quantity.amount > 0, "ERR::STAKE_NON_POSITIVE_QTY::Stake amount must be greater than 0");

        asset liquid = eosdac::get_liquid(from, get_self(), quantity.symbol);

        print("Liquid balance ", liquid, "\n");

        check(liquid >= quantity, "ERR::STAKE_MORE_LIQUID::Attempting to stake more than your liquid balance");

        sub_balance(from, quantity);
        add_balance(to, quantity, from);
        add_stake(to, quantity, dac.dac_id, from);

        // notify of stake delta
        send_stake_notification(to, quantity, dac);
    }

    void eosdactokens::stake(name account, asset quantity) {
        require_auth(account);
        dacdir::dac dac                = dacdir::dac_for_symbol(extended_symbol{quantity.symbol, get_self()});

        stake_config config = stake_config::get_current_configs(get_self(), dac.dac_id);
        check(config.enabled, "ERR::STAKING_NOT_ENABLED::Staking is not enabled for this token");

        check(quantity.is_valid(), "ERR::STAKE_INVALID_QTY::Invalid quantity supplied");
        check(quantity.amount > 0, "ERR::STAKE_NON_POSITIVE_QTY::Stake amount must be greater than 0");

        asset liquid = eosdac::get_liquid(account, get_self(), quantity.symbol);

        check(liquid >= quantity, "ERR::STAKE_MORE_LIQUID::Attempting to stake more than your liquid balance");

        add_stake(account, quantity, dac.dac_id, account);

        // notify of stake delta
        send_stake_notification(account, quantity, dac);
    }

    void eosdactokens::unstake(name account, asset quantity) {
        require_auth(account);

        dacdir::dac    dac = dacdir::dac_for_symbol(extended_symbol{quantity.symbol, get_self()});
        stakes_table   stakes(get_self(), dac.dac_id.value);
        unstakes_table unstakes(get_self(), dac.dac_id.value);
        stake_config   config = stake_config::get_current_configs(get_self(), dac.dac_id);

        check(config.enabled, "ERR::STAKING_NOT_ENABLED::Staking is not enabled for this token");
        check(quantity.is_valid(), "ERR::STAKE_INVALID_QTY::Invalid quantity supplied");
        check(quantity.amount > 0, "ERR::UNSTAKE_NON_POSITIVE_QTY::Unstake amount must be greater than 0");

        auto existing_stake = stakes.find(account.value);
        check(existing_stake != stakes.end(), "ERR:NO_STAKE_FOUND::No stake found");
        check(existing_stake->stake >= quantity, "ERR::UNSTAKE_OVER::Quantity to unstake is more than staked amount");

        uint32_t         unstake_delay = config.min_stake_time;
        staketimes_table staketimes(get_self(), dac.dac_id.value);
        auto             existing_staketime = staketimes.find(account.value);
        if (existing_staketime != staketimes.end()) {
            unstake_delay = existing_staketime->delay;
        }
        uint32_t release_time = current_time_point().sec_since_epoch() + unstake_delay;

        uint64_t next_id = unstakes.available_primary_key();
        unstakes.emplace(account, [&](unstake_info &u) {
            u.key          = next_id;
            u.account      = account;
            u.stake        = quantity;
            u.release_time = time_point_sec(release_time);
        });

        // notify of stake delta
        send_stake_notification(account, -quantity, dac);

        // Remove from stake
        sub_stake(account, quantity, dac.dac_id);

        // deferred transaction to refund
        transaction trx;
        trx.actions.push_back(action(
            permission_level{get_self(), "notify"_n}, get_self(), "refund"_n, make_tuple(next_id, quantity.symbol)));
        trx.delay_sec = unstake_delay;
        trx.send(uint128_t(next_id) << 64 | time_point_sec(current_time_point()).sec_since_epoch(), get_self());
    }

    void eosdactokens::staketime(name account, uint32_t unstake_time, symbol token_symbol) {
        require_auth(account);

        dacdir::dac  dac    = dacdir::dac_for_symbol(extended_symbol{token_symbol, get_self()});
        stake_config config = stake_config::get_current_configs(get_self(), dac.dac_id);
        check(config.enabled, "ERR::STAKING_NOT_ENABLED::Staking is not enabled for this token");
        staketimes_table staketimes(get_self(), dac.dac_id.value);
        stakes_table     stakes(get_self(), dac.dac_id.value);
        unstakes_table   unstakes(get_self(), dac.dac_id.value);
        auto             unstakes_idx = unstakes.get_index<"byaccount"_n>();

        check(unstake_time <= config.max_stake_time, "ERR::TIME_GREATER_MAX::Unstake time is greater than the maximum");
        check(unstake_time >= config.min_stake_time, "ERR::TIME_LESS_MIN::Unstake time is less than the minimum");

        auto existing_stake   = stakes.find(account.value);
        auto existing_unstake = unstakes_idx.find(account.value);
        auto existing_time    = staketimes.find(account.value);
        if ((existing_stake != stakes.end() || existing_unstake != unstakes_idx.end()) &&
            existing_time != staketimes.end()) {
            check(existing_time->delay <= unstake_time,
                "ERR::CANNOT_REDUCE_STAKE_TIME::You cannot reduce the stake time if you have tokens staked or in the process of unstaking");
        }

        uint32_t current_unstake_time = config.min_stake_time;
        if (existing_time == staketimes.end()) {
            staketimes.emplace(account, [&](staketime_info &s) {
                s.account = account;
                s.delay   = unstake_time;
            });
        } else {
            current_unstake_time = existing_time->delay;
            staketimes.modify(*existing_time, account, [&](staketime_info &s) {
                s.delay = unstake_time;
            });
        }

        // send notification for unstake at current delay and then stake with new delay
        name  custodian_contract = dac.account_for_type(dacdir::CUSTODIAN);
        name  vote_contract      = dac.account_for_type(dacdir::VOTE_WEIGHT);
        name  notify_contract    = (vote_contract) ? vote_contract : custodian_contract;
        asset current_stake      = eosdac::get_staked(account, get_self(), token_symbol);

        vector<account_stake_delta> stake_deltas_sub = {{account, -current_stake, current_unstake_time}};
        action(permission_level{get_self(), "notify"_n}, notify_contract, "stakeobsv"_n,
            make_tuple(stake_deltas_sub, dac.dac_id))
            .send();

        vector<account_stake_delta> stake_deltas_add = {{account, current_stake, unstake_time}};
        action(permission_level{get_self(), "notify"_n}, notify_contract, "stakeobsv"_n,
            make_tuple(stake_deltas_add, dac.dac_id))
            .send();
    }

    void eosdactokens::stakeconfig(stake_config config, symbol token_symbol) {
        dacdir::dac dac          = dacdir::dac_for_symbol(extended_symbol{token_symbol, get_self()});
        eosio::name auth_account = dac.account_for_type(dacdir::AUTH);
        require_auth(auth_account);

        config.save(get_self(), dac.dac_id, get_self());
    }

    void eosdactokens::refund(uint64_t unstake_id, symbol token_symbol) {
        dacdir::dac    dac = dacdir::dac_for_symbol(extended_symbol{token_symbol, get_self()});
        unstakes_table unstakes(get_self(), dac.dac_id.value);
        stakes_table   stakes(get_self(), dac.dac_id.value);

        auto us = unstakes.find(unstake_id);
        check(us != unstakes.end(), "ERR::UNSTAKE_NOT_FOUND::Unstake not found");

        uint32_t time_now = current_time_point().sec_since_epoch();
        check(time_now >= us->release_time.sec_since_epoch(), "ERR::REFUND_NOT_DUE::Refund is not due yet");

        // just removing the unstake will change the liquid balance, stake was removed at time of unstake
        unstakes.erase(us);
    }

    void eosdactokens::cancel(uint64_t unstake_id, symbol token_symbol) {
        dacdir::dac    dac = dacdir::dac_for_symbol(extended_symbol{token_symbol, get_self()});
        unstakes_table unstakes(get_self(), dac.dac_id.value);

        auto us = unstakes.find(unstake_id);
        check(us != unstakes.end(), "ERR::UNSTAKE_NOT_FOUND::Unstake not found");

        require_auth(us->account);

        // Add stake back and delete the unstake so the liquid balance is correct
        add_stake(us->account, us->stake, dac.dac_id, us->account);

        send_stake_notification(us->account, us->stake, dac);

        unstakes.erase(us);
    }

    void eosdactokens::sub_stake(name account, asset value, name dac_id) {
        stakes_table stakes(get_self(), dac_id.value);
        auto         existing_stake = stakes.find(account.value);
        check(existing_stake != stakes.end(), "ERR::NO_STAKE_OBJECT::No stake found when attempting to subtract stake");

        if (existing_stake->stake == value) {
            stakes.erase(existing_stake);
        } else {
            stakes.modify(*existing_stake, account, [&](stake_info &s) {
                s.stake -= value;
            });
        }
    }

    void eosdactokens::add_stake(name account, asset value, name dac_id, name ram_payer) {
        stakes_table stakes(get_self(), dac_id.value);
        auto         existing_stake = stakes.find(account.value);

        if (existing_stake != stakes.end()) {
            stakes.modify(*existing_stake, same_payer, [&](stake_info &s) {
                s.stake += value;
            });
        } else {
            stakes.emplace(ram_payer, [&](stake_info &s) {
                s.account = account;
                s.stake   = value;
            });
        }
    }

    void eosdactokens::send_stake_notification(name account, asset stake, dacdir::dac dac_inst) {
        const auto custodian_contract  = dac_inst.account_for_type_maybe(dacdir::CUSTODIAN);
        const auto vote_contract       = dac_inst.account_for_type_maybe(dacdir::VOTE_WEIGHT);
        const auto referendum_contract = dac_inst.account_for_type_maybe(dacdir::REFERENDUM);
        name notify_contract     = (vote_contract) ? *vote_contract : *custodian_contract;
        stake_config     config        = stake_config::get_current_configs(get_self(), dac_inst.dac_id);
        uint32_t         unstake_delay = config.min_stake_time;
        staketimes_table staketimes(get_self(), dac_inst.dac_id.value);
        auto             existing_staketime = staketimes.find(account.value);
        
        if (existing_staketime != staketimes.end()) {
            unstake_delay = existing_staketime->delay;
        }

        vector<account_stake_delta> stake_deltas = {{account, stake, unstake_delay}};
        action(permission_level{get_self(), "notify"_n}, notify_contract, "stakeobsv"_n,
            make_tuple(stake_deltas, dac_inst.dac_id))
            .send();
        
        if (referendum_contract && is_account(*referendum_contract)) {
            action(permission_level{get_self(), "notify"_n}, *referendum_contract, "stakeobsv"_n,
                make_tuple(stake_deltas, dac_inst.dac_id))
                .send();
        }
    }

    void eosdactokens::send_balance_notification(vector<account_balance_delta> account_weights, dacdir::dac dac_inst) {

        const auto custodian_contract = dac_inst.account_for_type_maybe(dacdir::CUSTODIAN);
        const auto vote_contract      = dac_inst.account_for_type_maybe(dacdir::VOTE_WEIGHT);
        
        eosio::name balance_obsv_contract;
        if(vote_contract && is_account(*vote_contract)) {
          balance_obsv_contract = *vote_contract;
        } else {
          check(custodian_contract.has_value(), "Neither vote_contract nor custodian_contract set");
          balance_obsv_contract = *custodian_contract;
        }
        

        eosio::action(eosio::permission_level{get_self(), "notify"_n}, balance_obsv_contract, "balanceobsv"_n,
            make_tuple(account_weights, dac_inst.dac_id))
            .send();

        print("notifying balance change to ", balance_obsv_contract, "::balanceobsv");
    }
} // namespace eosdac
