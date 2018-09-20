

/**
 * This action is used to nominate a candidate for custodian elections.
 * It must be authorised by the candidate and the candidate must be an active member of the dac, having agreed to the latest constitution.
 * The candidate must have transferred a quantity of tokens (determined by a config setting - `lockupasset`) to the contract for staking before this action is executed. This could have been from a recent transfer with the contract name in the memo or from a previous time when this account had nominated, as long as the candidate had never `unstake`d those tokens.
 * ### Assertions:
 * - The account performing the action is authorised.
 * - The candidate is not already a nominated candidate.
 * - The requested pay amount is not more than the config max amount
 * - The requested pay symbol type is the same from config max amount ( The contract supports only one token symbol for payment)
 * - The candidate is currently a member or has agreed to the latest constitution.
 * - The candidate has transferred sufficient funds for staking if they are a new candidate.
 * - The candidate has enough staked if they are re-nominating as a candidate and the required stake has changed since they last nominated.
 * @param cand - The account id for the candidate nominating.
 * @param requestedpay - The amount of pay the candidate would like to receive if they are elected as a custodian. This amount must not exceed the maximum allowed amount of the contract config parameter (`requested_pay_max`) and the symbol must also match.
 *
 *
 * ### Post Condition:
 * The candidate should be present in the candidates table and be set to active. If they are a returning candidate they should be set to active again. The `locked_tokens` value should reflect the total of the tokens they have transferred to the contract for staking. The number of active candidates in the contract will incremented.
 */
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

/**
 * This action is used to withdraw a candidate from being active for custodian elections.
 *
 * ### Assertions:
 * - The account performing the action is authorised.
 * - The candidate is already a nominated candidate.
 * @param cand - The account id for the candidate nominating.
 *
 *
 * ### Post Condition:
 * The candidate should still be present in the candidates table and be set to inactive. If the were recently an elected custodian there may be a time delay on when they can unstake their tokens from the contract. If not they will be able to unstake their tokens immediately using the unstake action.
 */
void daccustodian::withdrawcand(name cand) {
    require_auth(cand);
    removecand(cand, false);
}

/**
 * This action is used to remove a candidate from being a candidate for custodian elections.
 *
 * ### Assertions:
 * - The action is authorised by the mid level permission the auth account for the contract.
 * - The candidate is already a nominated candidate.
 * @param cand - The account id for the candidate nominating.
 * @param lockupStake - if true the stake will be locked up for a time period as set by the contract config - `lockup_release_time_delay`
 *
 *
 * ### Post Condition:
 * The candidate should still be present in the candidates table and be set to inactive. If the `lockupstake` parameter is true the stake will be locked until the time delay has passed. If not the candidate will be able to unstake their tokens immediately using the unstake action to have them returned.
 */
void daccustodian::firecand(name cand, bool lockupStake) {
    require_auth2(configs().authaccount, configs().auth_threshold_mid);
    removecand(cand, lockupStake);
}

/**
 * This action is used to unstake a candidates tokens and have them transferred to their account.
 *
 * ### Assertions:
 * - The candidate was a nominated candidate at some point in the passed.
 * - The candidate is not already a nominated candidate.
 * - The tokens held under candidate's account are not currently locked in a time delay.
 *
 * @param cand - The account id for the candidate nominating.
 *
 *
 * ### Post Condition:
 * The candidate should still be present in the candidates table and should be still set to inactive. The candidates tokens will be transferred back to their account and their `locked_tokens` value will be reduced to 0.
 */
void daccustodian::unstake(name cand) {
    const auto &reg_candidate = registered_candidates.get(cand, "Candidate is not already registered.");
    eosio_assert(!reg_candidate.is_active, "Cannot unstake tokens for an active candidate. Call withdrawcand first.");

    eosio_assert(reg_candidate.custodian_end_time_stamp < now(), "Cannot unstake tokens before they are unlocked from the time delay.");

    registered_candidates.modify(reg_candidate, cand, [&](candidate &c) {
        // Ensure the candidate's tokens are not locked up for a time delay period.
        // Send back the locked up tokens
        action(permission_level{_self, N(active)},
               eosio::string_to_name(TOKEN_CONTRACT), N(transfer),
               make_tuple(_self, cand, c.locked_tokens,
                          string("Returning locked up stake. Thank you."))
        ).send();
        c.locked_tokens = asset(0, configs().lockupasset.symbol);
    });
}

/**
 * This action is used to resign as a custodian.
 *
 * ### Assertions:
 * - The `cust` account performing the action is authorised to do so.
 * - The `cust` account is currently an elected custodian.
 * @param cust - The account id for the candidate nominating.
 *
 *
 * ### Post Condition:
 * The custodian will be removed from the active custodians and should still be present in the candidates table but will be set to inactive. Their staked tokens will be locked up for the time delay added from the moment this action was called so they will not able to unstake until that time has passed. A replacement custodian will selected from the candidates to fill the missing place (based on vote ranking) then the auths for the controlling dac auth account will be set for the custodian board.
 */
void daccustodian::resigncust(name cust) {
    require_auth(cust);
    removecust(cust);
}

/**
 * This action is used to remove a custodian.
 *
 * ### Assertions:
 * - The action is authorised by the mid level of the auth account (currently elected custodian board).
 * - The `cust` account is currently an elected custodian.
 * @param cand - The account id for the candidate nominating.
 *
 *
 * ### Post Condition:
 * The custodian will be removed from the active custodians and should still be present in the candidates table but will be set to inactive. Their staked tokens will be locked up for the time delay added from the moment this action was called so they will not able to unstake until that time has passed. A replacement custodian will selected from the candidates to fill the missing place (based on vote ranking) then the auths for the controlling dac auth account will be set for the custodian board.
 */
void daccustodian::firecust(name cust) {
    require_auth2(configs().authaccount, configs().auth_threshold_mid);
    removecust(cust);
}

// private methods for the above actions

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




