#include "../../contract-shared-headers/dacdirectory_shared.hpp"
#include <eosio/system.hpp>

using namespace eosdac;

ACTION daccustodian::nominatecane(const name &cand, const asset &requestedpay, const name &dac_id) {
    require_auth(cand);
    assertValidMember(cand, dac_id);
    auto globals = dacglobals::current(get_self(), dac_id);

    check(requestedpay.amount >= 0, "ERR::UPDATEREQPAY_UNDER_ZERO::Requested pay amount must not be negative.");
    // This implicitly asserts that the symbol of requestedpay matches the globals.max pay.
    check(requestedpay <= globals.get_requested_pay_max().quantity,
        "ERR::NOMINATECAND_PAY_LIMIT_EXCEEDED::Requested pay limit for a candidate was exceeded.");

    validateMinStake(cand, dac_id);

    const auto number_active_candidates = globals.get_number_active_candidates();
    globals.set_number_active_candidates(number_active_candidates + 1);
    globals.save(get_self(), dac_id);

    candidates_table registered_candidates(get_self(), dac_id.value);

    auto reg_candidate = registered_candidates.find(cand.value);
    if (reg_candidate != registered_candidates.end()) {
        check(!reg_candidate->is_active,
            "ERR::NOMINATECAND_ALREADY_REGISTERED::Candidate is already registered and active.");
        registered_candidates.modify(reg_candidate, cand, [&](candidate &c) {
            c.is_active    = 1;
            c.requestedpay = requestedpay;
        });
    } else {
        extended_asset required_stake = globals.get_lockupasset();

        // locked_tokens is now ignored, staking is done in the token contract
        auto zero_tokens   = required_stake.quantity;
        zero_tokens.amount = 0;
        registered_candidates.emplace(cand, [&](candidate &c) {
            c.candidate_name = cand;
            c.requestedpay   = requestedpay;
            c.locked_tokens  = zero_tokens;
            c.total_votes    = 0;
            c.is_active      = 1;
        });
    }
}

ACTION daccustodian::withdrawcane(const name &cand, const name &dac_id) {
    require_auth(cand);
    removeCandidate(cand, false, dac_id);
}

ACTION daccustodian::firecand(const name &cand, const bool lockupStake, const name &dac_id) {
    auto dac = dacdir::dac_for_id(dac_id);
    require_auth(dac.owner);
    removeCandidate(cand, lockupStake, dac_id);
}

ACTION daccustodian::resigncust(const name &cust, const name &dac_id) {
    require_auth(cust);
    removeCustodian(cust, dac_id);
}

ACTION daccustodian::firecust(const name &cust, const name &dac_id) {
    auto dac = dacdir::dac_for_id(dac_id);
    require_auth(dac.owner);
    removeCustodian(cust, dac_id);
}

ACTION daccustodian::setperm(const name &cand, const name &permission, const name &dac_id) {
    require_auth(cand);
    assertValidMember(cand, dac_id);

    bool perm_exists = permissionExists(cand, permission);

    check(perm_exists, "ERR::PERMISSION_NOT_EXIST::Permission does not exist");
    candidates_table registered_candidates(_self, dac_id.value);

    registered_candidates.get(cand.value, "ERR::UNSTAKE_CAND_NOT_REGISTERED::Candidate is not already registered.");

    candperms_table cand_perms(_self, dac_id.value);
    auto            existing = cand_perms.find(cand.value);

    if (existing == cand_perms.end()) {
        cand_perms.emplace(cand, [&](candperm &c) {
            c.cand       = cand;
            c.permission = permission;
        });
    } else if (permission == "active"_n) {
        cand_perms.erase(existing);
    } else {
        cand_perms.modify(existing, same_payer, [&](candperm &c) {
            c.permission = permission;
        });
    }
}

ACTION daccustodian::appointcust(const vector<name> &custs, const name &dac_id) {
    dacdir::dac dac          = dacdir::dac_for_id(dac_id);
    name        auth_account = dac.owner;
    require_auth(auth_account);

    const auto       globals = dacglobals::current(get_self(), dac_id);
    custodians_table custodians(_self, dac_id.value);
    check(custodians.begin() == custodians.end(), "ERR:CUSTODIANS_NOT_EMPTY::Custodians table is not empty");
    candidates_table candidates(_self, dac_id.value);

    extended_asset lockup   = globals.get_lockupasset();
    extended_asset req_pay  = globals.get_requested_pay_max();
    lockup.quantity.amount  = 0;
    req_pay.quantity.amount = 0;

    for (auto cust : custs) {
        auto cand = candidates.find(cust.value);
        if (cand == candidates.end()) {
            candidates.emplace(auth_account, [&](candidate &c) {
                c.candidate_name = cust;
                c.requestedpay   = req_pay.quantity;
                c.locked_tokens  = lockup.quantity;
                c.total_votes    = 0;
                c.is_active      = 1;
            });
        }

        custodians.emplace(auth_account, [&](custodian &c) {
            c.cust_name    = cust;
            c.requestedpay = req_pay.quantity;
            c.total_votes  = 0;
        });
    }
}

// private methods for the above actions

void daccustodian::validateMinStake(name account, name dac_id) {
    const auto globals        = dacglobals::current(get_self(), dac_id);
    const auto required_stake = globals.get_lockupasset();

    if (required_stake.quantity.amount > 0) {
        const auto staked = eosdac::get_staked(account, required_stake.contract, required_stake.quantity.symbol);

        check(staked >= required_stake.quantity,
            "ERR::VALIDATEMINSTAKE_NOT_ENOUGH::Not staked enough. You staked %s, but need to stake at least %s", staked,
            required_stake.quantity);

        const auto delay     = staketime_info::get_delay(get_self(), dac_id, account);
        const auto min_delay = globals.get_lockup_release_time_delay();
        check(delay >= min_delay, "ERR::VALIDATEMINSTAKE_NOT_LONG_ENOUGH::Staketime must be at least %s but is %s",
            min_delay, delay);
    }
}

void daccustodian::removeCustodian(name cust, name dac_id) {

    custodians_table custodians(_self, dac_id.value);
    auto             elected = custodians.find(cust.value);
    check(elected != custodians.end(),
        "ERR::REMOVECUSTODIAN_NOT_CURRENT_CUSTODIAN::The entered account name is not for a current custodian.");

    eosio::print("Remove custodian from the custodians table.");
    custodians.erase(elected);

    // Remove the candidate from being eligible for the next election period.
    removeCandidate(cust, true, dac_id);

    // Allocate the next set of candidates to only fill the gap for the missing slot.
    allocateCustodians(true, dac_id);

    // Update the auths to give control to the new set of custodians.
    setMsigAuths(dac_id);
}

void daccustodian::removeCandidate(name cand, bool lockupStake, name dac_id) {
    auto globals = dacglobals::current(get_self(), dac_id);

    const auto number_active_candidates = globals.get_number_active_candidates();
    globals.set_number_active_candidates(number_active_candidates - 1);
    globals.save(_self, dac_id);

    candidates_table registered_candidates(_self, dac_id.value);
    candperms_table  cand_perms(_self, dac_id.value);

    const auto &reg_candidate = registered_candidates.get(
        cand.value, "ERR::REMOVECANDIDATE_NOT_CURRENT_CANDIDATE::Candidate is not already registered.");

    // remove entry for candperms
    auto perm = cand_perms.find(cand.value);
    if (perm != cand_perms.end()) {
        cand_perms.erase(perm);
    }

    eosio::print("Remove from nominated candidate by setting them to inactive.");
    // Set the is_active flag to false instead of deleting in order to retain votes if they return to he dac.
    registered_candidates.modify(reg_candidate, same_payer, [&](candidate &c) {
        c.is_active = 0;
    });
}

ACTION daccustodian::regproxy(const name &proxy_member, const name &dac_id) {
    require_auth(proxy_member);
    assertValidMember(proxy_member, dac_id);

    proxies_table proxies(get_self(), dac_id.value);

    auto found_proxy = proxies.find(proxy_member.value);
    check(found_proxy == proxies.end(), "ERR::REGPROXY_ALREADY_REGISTERED::User is already registered as a proxy.");
    proxies.emplace(proxy_member, [&](proxy &p) {
        p.proxy        = proxy_member;
        p.total_weight = 0;
    });
}

ACTION daccustodian::unregproxy(const name &proxy_member, const name &dac_id) {
    require_auth(proxy_member);

    proxies_table proxies(get_self(), dac_id.value);

    auto found_proxy = proxies.find(proxy_member.value);
    check(found_proxy != proxies.end(), "ERR::UNREGPROXY_NOT_REGISTERED::User is not registered as a proxy.");

    if (found_proxy->total_weight != 0) {
        // Remove proxied vote weight for the proxy
        votes_table votes_cast_by_members(_self, dac_id.value);
        auto        existingVote = votes_cast_by_members.find(proxy_member.value);
        if (existingVote != votes_cast_by_members.end()) {
            modifyVoteWeights({name{}, found_proxy->total_weight, found_proxy->total_weight}, existingVote->candidates,
                existingVote->vote_time_stamp, {}, dac_id, false);
        }
    }

    proxies.erase(found_proxy);
}
