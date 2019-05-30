
void daccustodian::updateVoteWeight(name custodian, int64_t weight, name dac_scope) {
    if (weight == 0) {
        print("\n Vote has no weight - No need to continue.");
        return;
    }
    candidates_table registered_candidates(_self, dac_scope.value);

    auto candItr = registered_candidates.find(custodian.value);
    if (candItr == registered_candidates.end()) {
        eosio::print("Candidate not found while updating from a transfer: ", custodian);
        return; // trying to avoid throwing errors from here since it's unrelated to a transfer action.?!?!?!?!
    }

    registered_candidates.modify(candItr, same_payer, [&](auto &c) {
        c.total_votes += weight;
        eosio::print("\nchanging vote weight: ", custodian, " by ", weight);
    });
}

void daccustodian::updateVoteWeights(const vector<name> &votes, int64_t vote_weight, name dac_scope, contr_state &currentState) {

    for (const auto &cust : votes) {
        updateVoteWeight(cust, vote_weight, dac_scope);
    }

    currentState.total_votes_on_candidates += votes.size() * vote_weight;
}

void daccustodian::modifyVoteWeights(name voter, vector<name> oldVotes, vector<name> newVotes, name dac_scope) {
    // This could be optimised with set diffing to avoid remove then add for unchanged votes. - later
    eosio::print("Modify vote weights: ", voter, "\n");

    dacdir::dac found_dac = dacdir::dac_for_id(dac_scope);
    contr_config configs = contr_config::get_current_configs(_self, dac_scope);

    uint64_t asset_name = configs.lockupasset.symbol.code().raw();

    accounts accountstable(found_dac.account_for_type(dacdir::TOKEN), voter.value);

    const auto ac = accountstable.find(asset_name);
    if (ac == accountstable.end()) {
        print("Voter has no balance therefore no need to update vote weights");
        return;
    }
    int64_t vote_weight = ac->balance.amount;
    contr_state currentState = contr_state::get_current_state(_self, dac_scope);

    // New voter -> Add the tokens to the total weight.
    if (oldVotes.size() == 0)
        currentState.total_weight_of_votes += vote_weight;

    // Leaving voter -> Remove the tokens to the total weight.
    if (newVotes.size() == 0)
        currentState.total_weight_of_votes -= vote_weight;

    updateVoteWeights(oldVotes, -vote_weight, dac_scope, currentState);
    updateVoteWeights(newVotes, vote_weight, dac_scope, currentState);
    currentState.save(_self, dac_scope);
}
