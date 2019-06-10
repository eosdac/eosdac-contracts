#include <eosio/system.hpp>
#include "../_contract-shared-headers/dacdirectory_shared.hpp"

void daccustodian::nominatecand(name cand, asset requestedpay, name dac_scope) {
    require_auth(cand);
    assertValidMember(cand, dac_scope);
    contr_state currentState = contr_state::get_current_state(_self, dac_scope);
    contr_config configs = contr_config::get_current_configs(_self, dac_scope);

    check(requestedpay.amount >= 0, "ERR::UPDATEREQPAY_UNDER_ZERO::Requested pay amount must not be negative.");
    // This implicitly asserts that the symbol of requestedpay matches the configs.max pay.
    check(requestedpay <= configs.requested_pay_max,
                 "ERR::NOMINATECAND_PAY_LIMIT_EXCEEDED::Requested pay limit for a candidate was exceeded.");

    currentState.number_active_candidates++;
    currentState.save(_self, dac_scope);

    pendingstake_table_t pendingstake(_self, dac_scope.value);
    auto pending = pendingstake.find(cand.value);

    candidates_table registered_candidates(_self, dac_scope.value);

    auto reg_candidate = registered_candidates.find(cand.value);
    if (reg_candidate != registered_candidates.end()) {
        check(!reg_candidate->is_active, "ERR::NOMINATECAND_ALREADY_REGISTERED::Candidate is already registered and active.");
        registered_candidates.modify(reg_candidate, cand, [&](candidate &c) {
            c.is_active = 1;
            c.requestedpay = requestedpay;

            if (pending != pendingstake.end()) {
                c.locked_tokens += pending->quantity;
                pendingstake.erase(pending);
            }
            check(c.locked_tokens >= configs.lockupasset, "ERR::NOMINATECAND_INSUFFICIENT_FUNDS_TO_STAKE::Insufficient funds have been staked.");
        });
    } else {
        check(pending != pendingstake.end() &&
                     pending->quantity >= configs.lockupasset,
                     "ERR::NOMINATECAND_STAKING_FUNDS_INCOMPLETE::A registering candidate must transfer sufficient tokens to the contract for staking.");

        registered_candidates.emplace(cand, [&](candidate &c) {
            c.candidate_name = cand;
            c.requestedpay = requestedpay;
            c.locked_tokens = pending->quantity;
            c.total_votes = 0;
            c.is_active = 1;
        });
        pendingstake.erase(pending);
    }
}

void daccustodian::withdrawcand(name cand, name dac_scope) {
    require_auth(cand);
    removeCandidate(cand, false, dac_scope);
}

void daccustodian::firecand(name cand, bool lockupStake, name dac_scope) {
    auto dac = dacdir::dac_for_id(dac_scope);
    require_auth(dac.account_for_type(dacdir::AUTH));
    removeCandidate(cand, lockupStake, dac_scope);
}

void daccustodian::unstake(name cand, name dac_scope) {
    
    dacdir::dac found_dac = dacdir::dac_for_id(dac_scope);
    name token_account = found_dac.account_for_type(dacdir::TOKEN);
    candidates_table registered_candidates(_self, dac_scope.value);
    const auto &reg_candidate = registered_candidates.get(cand.value, "ERR::UNSTAKE_CAND_NOT_REGISTERED::Candidate is not already registered.");
    check(!reg_candidate.is_active, "ERR::UNSTAKE_CANNOT_UNSTAKE_FROM_ACTIVE_CAND::Cannot unstake tokens for an active candidate. Call withdrawcand first.");

    check(reg_candidate.custodian_end_time_stamp < time_point_sec(eosio::current_time_point()), "ERR::UNSTAKE_CANNOT_UNSTAKE_UNDER_TIME_LOCK::Cannot unstake tokens before they are unlocked from the time delay.");

    registered_candidates.modify(reg_candidate, cand, [&](candidate &c) {
        // Ensure the candidate's tokens are not locked up for a time delay period.
        // Send back the locked up tokens
        transaction deferredTrans{};

        deferredTrans.actions.emplace_back(
        action(permission_level{_self, "xfer"_n},
               token_account,
               "transfer"_n,
               make_tuple(_self, cand, c.locked_tokens,
                          string("Returning locked up stake. Thank you."))
        )
        );

        deferredTrans.delay_sec = TRANSFER_DELAY;
        deferredTrans.send(cand.value, _self);

        c.locked_tokens = asset(0, contr_config::get_current_configs(_self, dac_scope).lockupasset.symbol);
    });
}

void daccustodian::resigncust(name cust, name dac_scope) {
    require_auth(cust);
    removeCustodian(cust, dac_scope);
}

void daccustodian::firecust(name cust, name dac_scope) {
    auto dac = dacdir::dac_for_id(dac_scope);
    require_auth(dac.account_for_type(dacdir::AUTH));
    removeCustodian(cust, dac_scope);
}


void daccustodian::setperm(name cand, name permission, name dac_scope) {
    require_auth(cand);
    assertValidMember(cand, dac_scope);

    bool perm_exists = permissionExists(cand, permission);

    check(perm_exists, "ERR::PERMISSION_NOT_EXIST::Permission does not exist");
    candidates_table registered_candidates(_self, dac_scope.value);

    registered_candidates.get(cand.value, "ERR::UNSTAKE_CAND_NOT_REGISTERED::Candidate is not already registered.");

    candperms_table cand_perms(_self, dac_scope.value);
    auto existing = cand_perms.find(cand.value);

    if (existing == cand_perms.end()){
        cand_perms.emplace(cand, [&](candperm &c) {
            c.cand = cand;
            c.permission = permission;
        });
    }
    else if (permission == "active"_n){
        cand_perms.erase(existing);
    }
    else {
        cand_perms.modify(existing, same_payer, [&](candperm &c) {
            c.permission = permission;
        });
    }
}

// private methods for the above actions

void daccustodian::removeCustodian(name cust, name dac_scope) {

    custodians_table custodians(_self, dac_scope.value);
    auto elected = custodians.find(cust.value);
    check(elected != custodians.end(), "ERR::REMOVECUSTODIAN_NOT_CURRENT_CUSTODIAN::The entered account name is not for a current custodian.");

    eosio::print("Remove custodian from the custodians table.");
    custodians.erase(elected);

    // Remove the candidate from being eligible for the next election period.
    removeCandidate(cust, true, dac_scope);

    // Allocate the next set of candidates to only fill the gap for the missing slot.
    allocateCustodians(true, dac_scope);

    // Update the auths to give control to the new set of custodians.
    setCustodianAuths(dac_scope);
}

void daccustodian::removeCandidate(name cand, bool lockupStake, name dac_scope) {
    contr_state currentState = contr_state::get_current_state(_self, dac_scope);
    contr_config configs = contr_config::get_current_configs(_self, dac_scope);

    currentState.number_active_candidates--;
    currentState.save(_self, dac_scope);

    candidates_table registered_candidates(_self, dac_scope.value);
    candperms_table cand_perms(_self, dac_scope.value);

    const auto &reg_candidate = registered_candidates.get(cand.value, "ERR::REMOVECANDIDATE_NOT_CURRENT_CANDIDATE::Candidate is not already registered.");

    // remove entry for candperms
    auto perm = cand_perms.find(cand.value);
    if (perm != cand_perms.end()){
        cand_perms.erase(perm);
    }

    eosio::print("Remove from nominated candidate by setting them to inactive.");
    // Set the is_active flag to false instead of deleting in order to retain votes if they return to he dac.
    registered_candidates.modify(reg_candidate, same_payer, [&](candidate &c) {
        c.is_active = 0;
        if (lockupStake) {
            eosio::print("Lockup stake for release delay.");
            c.custodian_end_time_stamp = eosio::current_time_point() + time_point_sec(configs.lockup_release_time_delay);
        }
    });
}
