
contr_config daccustodian::configs() {
    contr_config conf = config_singleton.get_or_default(contr_config());
    config_singleton.set(conf, _self);
    return conf;
}

void daccustodian::assertValidMember(name member) {
    name tokenContract = name(TOKEN_CONTRACT);
    regmembers reg_members(tokenContract, tokenContract.value);
    memterms memberterms(tokenContract, tokenContract.value);

    const auto &regmem = reg_members.get(member.value, "ERR::GENERAL_REG_MEMBER_NOT_FOUND::Account is not registered with members.");
    check((regmem.agreedterms != 0), "ERR::GENERAL_MEMBER_HAS_NOT_AGREED_TO_ANY_TERMS::Account has not agreed to any terms");
    auto latest_member_terms = (--memberterms.end());
    check(latest_member_terms->version == regmem.agreedterms, "ERR::GENERAL_MEMBER_HAS_NOT_AGREED_TO_LATEST_TERMS::Agreed terms isn't the latest.");
}

void daccustodian::updateVoteWeight(name custodian, int64_t weight) {
    if (weight == 0) {
        print("\n Vote has no weight - No need to continue.");
    }

    auto candItr = registered_candidates.find(custodian.value);
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

    uint64_t asset_name = configs().lockupasset.symbol.code().raw();

    accounts accountstable(name(TOKEN_CONTRACT), voter.value);
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
