
void daccustodian::resetvotes(const name &voter, const name &dac_id) {
    require_auth(get_self());

    votes_table votes_cast_by_members(_self, dac_id.value);
    auto        existingVote = votes_cast_by_members.find(voter.value);

    check(existingVote != votes_cast_by_members.end(), "No votes");

    votes_cast_by_members.erase(existingVote);
}

void daccustodian::resetstate(const name &dac_id) {
    require_auth(get_self());
    auto currentState = contr_state2::get_current_state(get_self(), dac_id);

    currentState.set_total_weight_of_votes(0);
    currentState.set_total_votes_on_candidates(0);
    currentState.set_number_active_candidates(0);
    currentState.set_met_initial_votes_threshold(false);
    currentState.save(get_self(), dac_id);
}

void daccustodian::resetcands(const name &dac_id) {
    require_auth(get_self());

    candidates_table candidates(_self, dac_id.value);
    auto             cand = candidates.begin();

    while (cand != candidates.end()) {
        candidates.modify(cand, same_payer, [&](candidate &c) {
            c.total_vote_power    = 0;
            c.number_voters       = 0;
            c.avg_vote_time_stamp = eosio::time_point_sec();
            c.update_index();
        });

        cand++;
    }
}
