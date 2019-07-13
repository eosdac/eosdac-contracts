#include <eosio/system.hpp>
#include "../_contract-shared-headers/dacdirectory_shared.hpp"
#include "../_contract-shared-headers/migration_helpers.hpp"

void daccustodian::nominatecand(name cand, asset requestedpay) {
    nominatecane(cand, requestedpay, get_self());
}

void daccustodian::nominatecane(name cand, asset requestedpay, name dac_id) {
    require_auth(cand);
    assertValidMember(cand, dac_id);
    contr_state currentState = contr_state::get_current_state(_self, dac_id);
    contr_config configs = contr_config::get_current_configs(_self, dac_id);

    check(requestedpay.amount >= 0, "ERR::UPDATEREQPAY_UNDER_ZERO::Requested pay amount must not be negative.");
    // This implicitly asserts that the symbol of requestedpay matches the configs.max pay.
    check(requestedpay <= configs.requested_pay_max.quantity,
                 "ERR::NOMINATECAND_PAY_LIMIT_EXCEEDED::Requested pay limit for a candidate was exceeded.");

    currentState.number_active_candidates++;
    currentState.save(_self, dac_id);

    pendingstake_table_t pendingstake(_self, dac_id.value);
    auto pending = pendingstake.find(cand.value);

    candidates_table registered_candidates(_self, dac_id.value);

    auto reg_candidate = registered_candidates.find(cand.value);
    if (reg_candidate != registered_candidates.end()) {
        check(!reg_candidate->is_active, "ERR::NOMINATECAND_ALREADY_REGISTERED::Candidate is already registered and active.");
        registered_candidates.modify(reg_candidate, cand, [&](candidate &c) {
            c.is_active = 1;
            c.requestedpay = requestedpay;

            if (pending != pendingstake.end()) {
                c.locked_tokens += pending->quantity;
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

        //Temp block for migrations to new scope
        if (dac_id == get_self()) {
            candidates_table registered_candidates(_self, NEW_SCOPE.value);

            auto reg_candidate = registered_candidates.find(cand.value);
            if (reg_candidate != registered_candidates.end()) {
                check(!reg_candidate->is_active, "ERR::NOMINATECAND_ALREADY_REGISTERED::Candidate is already registered and active.");
                registered_candidates.modify(reg_candidate, cand, [&](candidate &c) {
                    c.is_active = 1;
                    c.requestedpay = requestedpay;

                    if (pending != pendingstake.end()) {
                        c.locked_tokens += pending->quantity;
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
            }
        }
        //end Temp block

        pendingstake.erase(pending);
    }
}

void daccustodian::withdrawcand(name cand) {
    withdrawcane(cand, get_self());
}

void daccustodian::withdrawcane(name cand, name dac_id) {
    require_auth(cand);
    removeCandidate(cand, false, dac_id);
}

void daccustodian::firecand(name cand, bool lockupStake) {
    firecande(cand, lockupStake, get_self());
}

void daccustodian::firecande(name cand, bool lockupStake, name dac_id) {
    auto dac = dacdir::dac_for_id(dac_id);
    require_auth(dac.account_for_type(dacdir::AUTH));
    removeCandidate(cand, lockupStake, dac_id);
}

void daccustodian::unstake(name cand) {
    unstakee(cand, get_self());
}

void daccustodian::unstakee(name cand, name dac_id) {
    
    dacdir::dac found_dac = dacdir::dac_for_id(dac_id);
    name token_account = found_dac.symbol.get_contract();
    candidates_table registered_candidates(_self, dac_id.value);
    const auto &reg_candidate = registered_candidates.get(cand.value, "ERR::UNSTAKE_CAND_NOT_REGISTERED::Candidate is not already registered.");
    check(!reg_candidate.is_active, "ERR::UNSTAKE_CANNOT_UNSTAKE_FROM_ACTIVE_CAND::Cannot unstake tokens for an active candidate. Call withdrawcand first.");

    check(reg_candidate.custodian_end_time_stamp < time_point_sec(eosio::current_time_point()), "ERR::UNSTAKE_CANNOT_UNSTAKE_UNDER_TIME_LOCK::Cannot unstake tokens before they are unlocked from the time delay.");

    registered_candidates.modify(reg_candidate, cand, [&](candidate &c) {
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

        c.locked_tokens = asset(0, contr_config::get_current_configs(_self, dac_id).lockupasset.symbol);
    });

    //Temp block for migrations to new scope
    if (dac_id == get_self()) {
        candidates_table registered_candidates(_self, NEW_SCOPE.value);
        const auto &reg_candidate = registered_candidates.get(cand.value, "ERR::UNSTAKE_CAND_NOT_REGISTERED::Candidate is not already registered.");
        check(!reg_candidate.is_active, "ERR::UNSTAKE_CANNOT_UNSTAKE_FROM_ACTIVE_CAND::Cannot unstake tokens for an active candidate. Call withdrawcand first.");

        check(reg_candidate.custodian_end_time_stamp < time_point_sec(eosio::current_time_point()), "ERR::UNSTAKE_CANNOT_UNSTAKE_UNDER_TIME_LOCK::Cannot unstake tokens before they are unlocked from the time delay.");

        registered_candidates.modify(reg_candidate, cand, [&](candidate &c) {

            c.locked_tokens = asset(0, contr_config::get_current_configs(_self, dac_id).lockupasset.symbol);
        });
    }
    //end Temp block
}

void daccustodian::resigncust(name cust) {
    resigncuste(cust, get_self());
}

void daccustodian::resigncuste(name cust, name dac_id) {
    require_auth(cust);
    removeCustodian(cust, dac_id);
}

void daccustodian::firecust(name cust) {
    firecuste(cust, get_self());
}

void daccustodian::firecuste(name cust, name dac_id) {
    auto dac = dacdir::dac_for_id(dac_id);
    require_auth(dac.account_for_type(dacdir::AUTH));
    removeCustodian(cust, dac_id);
}


void daccustodian::setperm(name cand, name permission, name dac_id) {
    require_auth(cand);
    assertValidMember(cand, dac_id);

    bool perm_exists = permissionExists(cand, permission);

    check(perm_exists, "ERR::PERMISSION_NOT_EXIST::Permission does not exist");
    candidates_table registered_candidates(_self, dac_id.value);

    registered_candidates.get(cand.value, "ERR::UNSTAKE_CAND_NOT_REGISTERED::Candidate is not already registered.");

    candperms_table cand_perms(_self, dac_id.value);
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

void daccustodian::removeCustodian(name cust, name dac_id) {

    custodians_table custodians(_self, dac_id.value);
    auto elected = custodians.find(cust.value);
    check(elected != custodians.end(), "ERR::REMOVECUSTODIAN_NOT_CURRENT_CUSTODIAN::The entered account name is not for a current custodian.");

    eosio::print("Remove custodian from the custodians table.");
    custodians.erase(elected);

    //Temp block for migrations to new scope
    if (dac_id == get_self()) {
        custodians_table custodians(_self, NEW_SCOPE.value);
        auto elected = custodians.find(cust.value);
        custodians.erase(elected);
    }
    //end Temp block

    // Remove the candidate from being eligible for the next election period.
    removeCandidate(cust, true, dac_id);

    // Allocate the next set of candidates to only fill the gap for the missing slot.
    allocateCustodians(true, dac_id);

    // Update the auths to give control to the new set of custodians.
    setCustodianAuths(dac_id);
}

void daccustodian::removeCandidate(name cand, bool lockupStake, name dac_id) {
    contr_state currentState = contr_state::get_current_state(_self, dac_id);
    contr_config configs = contr_config::get_current_configs(_self, dac_id);

    currentState.number_active_candidates--;
    currentState.save(_self, dac_id);

    candidates_table registered_candidates(_self, dac_id.value);
    candperms_table cand_perms(_self, dac_id.value);

    const auto &reg_candidate = registered_candidates.get(cand.value, "ERR::REMOVECANDIDATE_NOT_CURRENT_CANDIDATE::Candidate is not already registered.");

    // remove entry for candperms
    auto perm = cand_perms.find(cand.value);
    if (perm != cand_perms.end()){
        cand_perms.erase(perm);
    }

    auto end_time_stamp = eosio::current_time_point() + time_point_sec(configs.lockup_release_time_delay);

    eosio::print("Remove from nominated candidate by setting them to inactive.");
    // Set the is_active flag to false instead of deleting in order to retain votes if they return to he dac.
    registered_candidates.modify(reg_candidate, same_payer, [&](candidate &c) {
        c.is_active = 0;
        if (lockupStake) {
            eosio::print("Lockup stake for release delay.");
            c.custodian_end_time_stamp = end_time_stamp;
        }
    });

    //Temp block for migrations to new scope
    if (dac_id == get_self()) {
            contr_state currentState = contr_state::get_current_state(_self, NEW_SCOPE);
            currentState.number_active_candidates--;
            currentState.save(_self, get_self());

            candidates_table registered_candidates(_self, NEW_SCOPE.value);

            const auto &reg_candidate = registered_candidates.get(cand.value, "ERR::REMOVECANDIDATE_NOT_CURRENT_CANDIDATE::Candidate is not already registered.");

            // Set the is_active flag to false instead of deleting in order to retain votes if they return to he dac.
            registered_candidates.modify(reg_candidate, same_payer, [&](candidate &c) {
                c.is_active = 0;
                if (lockupStake) {
                    c.custodian_end_time_stamp = end_time_stamp;
                }
            });
    }
    //end Temp block
}
