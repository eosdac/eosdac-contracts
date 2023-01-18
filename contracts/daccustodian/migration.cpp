
ACTION daccustodian::migrate1(const name dac_id) {
    auto candidates  = candidates_table{get_self(), dac_id.value};
    auto candidates2 = candidates2_table{get_self(), dac_id.value};
    auto itr         = candidates.begin();
    while (itr != candidates.end()) {
        candidates2.emplace(get_self(), [&](auto &c) {
            c.candidate_name      = itr->candidate_name;
            c.requestedpay        = itr->requestedpay;
            c.rank                = itr->rank;
            c.gap_filler          = itr->gap_filler;
            c.total_vote_power    = itr->total_vote_power;
            c.is_active           = itr->is_active;
            c.number_voters       = itr->number_voters;
            c.avg_vote_time_stamp = itr->avg_vote_time_stamp;
        });
        itr = candidates.erase(itr);
    }
}

#ifndef MIGRATION_STAGE_1
ACTION daccustodian::migrate2(const name dac_id) {
    auto candidates  = candidates_table{get_self(), dac_id.value};
    auto candidates2 = candidates2_table{get_self(), dac_id.value};
    auto itr         = candidates2.begin();
    while (itr != candidates2.end()) {
        candidates.emplace(get_self(), [&](auto &c) {
            c.candidate_name      = itr->candidate_name;
            c.requestedpay        = itr->requestedpay;
            c.rank                = itr->rank;
            c.gap_filler          = itr->gap_filler;
            c.total_vote_power    = itr->total_vote_power;
            c.is_active           = itr->is_active;
            c.number_voters       = itr->number_voters;
            c.avg_vote_time_stamp = itr->avg_vote_time_stamp;
        });
        itr = candidates2.erase(itr);
    }
}
#endif