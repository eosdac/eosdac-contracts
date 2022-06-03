
#ifdef VOTE_DECAY_STAGE_1
// migrates from candidates to candidates2
// after deployment of contract built with VOTE_DECAY_STAGE_1, run this
ACTION daccustodian::migration1(const name dac_id, const uint8_t batch_size) {
    auto    candidates1 = candidates_table{get_self(), dac_id.value};
    auto    candidates2 = candidates2_table{get_self(), dac_id.value};
    auto    itr1        = candidates1.begin();
    uint8_t i           = 0;
    while (itr1 != candidates1.end() && i++ < batch_size) {
        candidates2.emplace(get_self(), [&](auto &c2) {
            c2.candidate_name           = itr1->candidate_name;
            c2.requestedpay             = itr1->requestedpay;
            c2.locked_tokens            = itr1->locked_tokens;
            c2.total_votes              = itr1->total_votes;
            c2.is_active                = itr1->is_active;
            c2.custodian_end_time_stamp = itr1->custodian_end_time_stamp;
        });
        itr1 = candidates1.erase(itr1);
    }
}
#endif

#ifdef VOTE_DECAY_STAGE_2
// migrates from candidates2 back to candidates
// after deployment of contract built with VOTE_DECAY_STAGE_2, run this
ACTION daccustodian::migration2(const name dac_id, const uint8_t batch_size) {
    auto    candidates1 = candidates_table{get_self(), dac_id.value};
    auto    candidates2 = candidates2_table{get_self(), dac_id.value};
    auto    itr2        = candidates2.begin();
    uint8_t i           = 0;
    while (itr2 != candidates2.end() && i++ < batch_size) {
        candidates1.emplace(get_self(), [&](auto &c1) {
            c1.candidate_name           = itr2->candidate_name;
            c1.requestedpay             = itr2->requestedpay;
            c1.locked_tokens            = itr2->locked_tokens;
            c1.total_votes              = itr2->total_votes;
            c1.is_active                = itr2->is_active;
            c1.custodian_end_time_stamp = itr2->custodian_end_time_stamp;
            c1.avg_vote_time_stamp      = time_point_sec(0);
        });
        itr2 = candidates2.erase(itr2);
    }
}
#endif