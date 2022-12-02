

ACTION daccustodian::migrate1(const name dac_id) {
    auto custodians  = custodians_table{get_self(), dac_id.value};
    auto custodians2 = custodians2_table{get_self(), dac_id.value};
    auto itr         = custodians.begin();
    while (itr != custodians.end()) {
        custodians2.emplace(get_self(), [&](auto &c) {
            c.cust_name        = itr->cust_name;
            c.requestedpay     = itr->requestedpay;
            c.total_vote_power = itr->total_vote_power;
        });
        itr = custodians.erase(itr);
    }
}
#ifdef MIGRATION_STAGE_2
ACTION daccustodian::migrate2(const name dac_id) {
    auto custodians   = custodians_table{get_self(), dac_id.value};
    auto custodians2  = custodians2_table{get_self(), dac_id.value};
    auto itr          = custodians2.begin();
    auto old_cust_itr = custodians.begin();
    while (old_cust_itr != custodians.end()) {
        old_cust_itr = custodians.erase(old_cust_itr);
    }

    while (itr != custodians2.end()) {
        custodians.emplace(get_self(), [&](auto &c) {
            c.cust_name        = itr->cust_name;
            c.requestedpay     = itr->requestedpay;
            c.total_vote_power = itr->total_vote_power;
        });
        itr = custodians2.erase(itr);
    }
}
#endif
