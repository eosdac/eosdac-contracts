
contr_config daccustodian::configs() {
    contr_config conf = config_singleton.get_or_default(contr_config());
    config_singleton.set(conf, _self);
    return conf;
}

member daccustodian::get_valid_member(name member) {
    account_name tokenContract = eosio::string_to_name(TOKEN_CONTRACT);
    regmembers reg_members(tokenContract, tokenContract);
    memterms memberterms(tokenContract, tokenContract);

    const auto &regmem = reg_members.get(member, "Account is not registered with members");
    eosio_assert((regmem.agreedterms != 0), "Account has not agreed to any terms");
    auto latest_member_terms = (--memberterms.end());
    eosio_assert(latest_member_terms->version == regmem.agreedterms, "Agreed terms isn't the latest.");
    return regmem;
}

void daccustodian::updateVoteWeight(name custodian, int64_t weight) {
    if (weight == 0) {
        print("\n Vote has no weight - No need to contrinue.");
    }

    auto candItr = registered_candidates.find(custodian);
    if (candItr == registered_candidates.end()) {
        eosio::print("Candidate not found while updating from a transfer: ", custodian);
        return; // trying to avoid throwing errors from here since it's unrelated to a transfer action.?!?!?!?!
    }

    registered_candidates.modify(candItr, custodian, [&](auto &c) {
        c.total_votes += weight;
        eosio::print("\nchanging vote weight: ", custodian, " by ", weight);
    });
}

void daccustodian::updateVoteWeights(const vector<name> &votes, int64_t vote_weight) {
    for (const auto &cust : votes) {
        updateVoteWeight(cust, vote_weight);
    }

    _currentState.total_votes_on_candidates += votes.size() * vote_weight;
}

void daccustodian::modifyVoteWeights(name voter, vector<name> oldVotes, vector<name> newVotes) {
    // This could be optimised with set diffing to avoid remove then add for unchanged votes. - later
    eosio::print("Modify vote weights: ", voter, "\n");

    uint64_t asset_name = configs().lockupasset.symbol.name();

    accounts accountstable(eosio::string_to_name(TOKEN_CONTRACT), voter);
    const auto ac = accountstable.find(asset_name);
    if (ac == accountstable.end()) {
        print("Voter has no balance therefore no need to update vote weights");
        return;
    }

    int64_t vote_weight = ac->balance.amount;

    // New voter -> Add the tokens to the total weight.
    if (oldVotes.size() == 0)
        _currentState.total_weight_of_votes += vote_weight;

    // Leaving voter -> Remove the tokens to the total weight.
    if (newVotes.size() == 0)
        _currentState.total_weight_of_votes -= vote_weight;

    updateVoteWeights(oldVotes, -vote_weight);
    updateVoteWeights(newVotes, vote_weight);
}