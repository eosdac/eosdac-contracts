

void daccustodian::regcandidate(name cand, string bio, asset requestedpay) {

    require_auth(cand);
    get_valid_member(cand);
    eosio_assert(requestedpay.amount < 4500000, "Requested pay amount limit of 250 token for a candidate was exceeded.");
    eosio_assert(bio.size() < 256, "The bio should be less than 256 characters.");

    account_name tokencontract = configs().tokencontr;
    _currentState.number_active_candidates++;

    auto reg_candidate = registered_candidates.find(cand);
    eosio_assert(reg_candidate == registered_candidates.end() || !reg_candidate->is_active,
                 "Candidate is already registered and active.");
    eosio_assert(requestedpay.symbol == PAYMENT_TOKEN, "Incorrect payment token for the current configuration");

    pendingstake_table_t pendingstake(_self, _self);
    auto pending = pendingstake.find(cand);
    eosio_assert(pending != pendingstake.end(),
                 "A registering member must first stake tokens as set by the contract's config.");
    int64_t shortfall = configs().lockupasset.amount - pending->quantity.amount;
    if (shortfall > 0) {
        print("The amount staked is insufficient by: ", shortfall, " tokens.");
        eosio_assert(false, "");
    }
    if (reg_candidate != registered_candidates.end()) {

        registered_candidates.modify(reg_candidate, cand, [&](auto &c) {
            c.locked_tokens = pending->quantity;
            c.is_active = 1;
            c.requestedpay = requestedpay;
            c.bio = bio;
        });
    } else {
        registered_candidates.emplace(cand, [&](candidate &c) {
            c.candidate_name = cand;
            c.bio = bio;
            c.requestedpay = requestedpay;
            c.locked_tokens = pending->quantity;
            c.total_votes = 0;
            c.is_active = 1;
        });
    }

    pendingstake.erase(pending);
}

void daccustodian::unregcand(name cand) {

    require_auth(cand);
    _currentState.number_active_candidates--;

    custodians_table custodians(_self, _self);

    const auto &reg_candidate = registered_candidates.get(cand, "Candidate is not already registered.");

    // Send back the locked up tokens
    action(permission_level{_self, N(active)},
           configs().tokencontr, N(transfer),
           std::make_tuple(_self, cand, reg_candidate.locked_tokens,
                           std::string("Returning locked up stake. Thank you."))
    ).send();

    // Set the is_active flag to false instead of deleting in order to retain votes.
    // Also set the locked tokens to false so they need to be added when/if returning.
    registered_candidates.modify(reg_candidate, cand, [&](candidate &c) {
        c.is_active = 0;
        c.locked_tokens = asset(0, configs().lockupasset.symbol);
    });

    auto elected = custodians.find(cand);
    if (elected != custodians.end()) {
        custodians.erase(elected);
        eosio::print("Remove candidate from the custodians.");

        // Select a new set of auths
        allocatecust(true);
        setauths();
    }
}