
void daccustodian::resetvotes(const name &voter, const name &dac_id) {
    require_auth(get_self());

    votes_table votes_cast_by_members(_self, dac_id.value);
    auto        existingVote = votes_cast_by_members.find(voter.value);

    check(existingVote != votes_cast_by_members.end(), "No votes");
}

void daccustodian::collectvotes(const name &dac_id) {
    require_auth(get_self());

    votes_table votes_cast_by_members(_self, dac_id.value);
    auto        vote_ittr = votes_cast_by_members.begin();

    while (vote_ittr != votes_cast_by_members.end()) {
        update_number_of_votes({}, vote_ittr->candidates, dac_id);
        const auto [vote_weight, vote_weight_quorum] = get_vote_weight(vote_ittr->voter, dac_id);
        modifyVoteWeights({vote_ittr->voter, vote_weight, vote_weight_quorum}, {}, {}, vote_ittr->candidates,
            vote_ittr->vote_time_stamp, dac_id, true);
    }
}

void daccustodian::resetstate(const name &dac_id) {
    require_auth(get_self());
    auto currentState = dacglobals{get_self(), dac_id};

    currentState.set_total_weight_of_votes(0);
    currentState.set_total_votes_on_candidates(0);
    currentState.set_number_active_candidates(0);
    currentState.set_met_initial_votes_threshold(false);
}

void daccustodian::resetcands(const name &dac_id) {
    require_auth(get_self());

    candidates_table candidates(_self, dac_id.value);
    auto             cand = candidates.begin();

    while (cand != candidates.end()) {
        candidates.modify(cand, same_payer, [&](candidate &c) {
            c.total_vote_power = 0;
            c.number_voters    = 0;
            // c.is_active           = 0;
            c.avg_vote_time_stamp = eosio::time_point_sec();
            c.update_index();
        });

        cand++;
    }
}

void daccustodian::clearcands(const name &dac_id) {
    require_auth(get_self());

    candidates_table candidates(_self, dac_id.value);
    auto             cand = candidates.begin();

    while (cand != candidates.end()) {
        cand = candidates.erase(cand);
    }
}
