

void daccustodian::nominatecand(name cand, asset requestedpay) {
    require_auth(cand);
    get_valid_member(cand);

    // This implicitly asserts that the symbol of requestedpay matches the configs.max pay.
    eosio_assert(requestedpay < configs().requested_pay_max,
                 "Requested pay limit for a candidate was exceeded.");

    _currentState.number_active_candidates++;

    pendingstake_table_t pendingstake(_self, _self);
    auto pending = pendingstake.find(cand);

    auto reg_candidate = registered_candidates.find(cand);
    if (reg_candidate != registered_candidates.end()) {
        eosio_assert(!reg_candidate->is_active, "Candidate is already registered and active.");
        registered_candidates.modify(reg_candidate, cand, [&](candidate &c) {
            c.is_active = 1;
            c.requestedpay = requestedpay;

            if (pending != pendingstake.end()) {
                c.locked_tokens += pending->quantity;
                pendingstake.erase(pending);
            }
            eosio_assert(c.locked_tokens >= configs().lockupasset, "Insufficient funds have been staked.");
        });
    } else {
        eosio_assert(pending != pendingstake.end() &&
                     pending->quantity >= configs().lockupasset,
                     "A registering candidate must transfer sufficient tokens to the contract for staking.");

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

void daccustodian::withdrawcand(name cand) {
    require_auth(cand);
    removecand(cand, false);
}

void daccustodian::firecand(name cand, bool lockupStake) {
    require_auth2(configs().authaccount, configs().auth_threshold_high);
    removecand(cand, lockupStake);
}

void daccustodian::unstake(const name &cand) {
    const auto &reg_candidate = registered_candidates.get(cand, "Candidate is not already registered.");
    eosio_assert(!reg_candidate.is_active, "Cannot unstake tokens for an active candidate. Call withdrawcand first.");

    registered_candidates.modify(reg_candidate, cand, [&](candidate &c) {
        // Ensure the candidate's tokens are not locked up for a time delay period.
        if (c.custodian_end_time_stamp < now()) {
            // Send back the locked up tokens
            action(permission_level{_self, N(active)},
                   configs().tokencontr, N(transfer),
                   make_tuple(_self, cand, c.locked_tokens,
                              string("Returning locked up stake. Thank you."))
            ).send();
            c.locked_tokens = asset(0, configs().lockupasset.symbol);
        }
    });
}

void daccustodian::resigncust(name cust) {
    require_auth(cust);
    removecust(cust);
}

void daccustodian::firecust(name cust) {
    require_auth2(configs().authaccount, configs().auth_threshold_high);
    removecust(cust);
}

void daccustodian::removecust(name cust) {

    custodians_table custodians(_self, _self);
    auto elected = custodians.find(cust);
    eosio_assert(elected != custodians.end(), "The entered account name is not for a current custodian.");

    eosio::print("Remove custodian from the custodians table.");
    custodians.erase(elected);

    // Remove the candidate from being eligible for the next election period.
    removecand(cust, true);

    // Allocate the next set of candidates to only fill the gap for the missing slot.
    allocatecust(true);

    // Update the auths to give control to the new set of custodians.
    setauths();
}

void daccustodian::removecand(name cand, bool lockupStake) {
    _currentState.number_active_candidates--;

    const auto &reg_candidate = registered_candidates.get(cand, "Candidate is not already registered.");

    eosio::print("Remove from nominated candidate by setting them to inactive.");
    // Set the is_active flag to false instead of deleting in order to retain votes if they return to he dac.
    registered_candidates.modify(reg_candidate, cand, [&](candidate &c) {
        c.is_active = 0;
        if (lockupStake) {
            eosio::print("Lockup stake for release delay.");
            c.custodian_end_time_stamp = now() + configs().lockup_release_time_delay;
        }
    });
}




