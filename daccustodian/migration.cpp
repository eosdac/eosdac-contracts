


template <typename T>
void cleanTable(uint64_t code, uint64_t account){
    T db(code, account);
    while(db.begin() != db.end()){
        auto itr = --db.end();
        db.erase(itr);
    }
}

void daccustodian::migrate() {

//    contr_config2 oldconf = configs();

//    contr_config newconfig{
//            oldconf.lockupasset,
//            oldconf.maxvotes,
//            oldconf.numelected,
//            oldconf.periodlength,
//            oldconf.authaccount,
//            oldconf.tokenholder,
//            oldconf.tokenholder,
//            true,
//            oldconf.initial_vote_quorum_percent,
//            oldconf.vote_quorum_percent,
//            oldconf.auth_threshold_high,
//            oldconf.auth_threshold_mid,
//            oldconf.auth_threshold_low,
//            oldconf.lockup_release_time_delay,
//            oldconf.requested_pay_max};
//
//    config_singleton.set(newconfig, _self);


// Remove the old configs so the schema can be changed.
//    configscontainer2 configs(_self, _self);
//    configs.remove();

//    contract_state.remove();
//    _currentState = contr_state{};

//    cleanTable<candidates_table>(_self, _self.value);
//    cleanTable<custodians_table>(_self, _self.value);
//    cleanTable<votes_table>(_self, _self.value);
//    cleanTable<pending_pay_table>(_self, _self.value);

    /*
    //Copy to a holding table - Enable this for the first step

        candidates_table oldcands(_self, _self.value);
        candidates_table2 holding_table(_self, _self.value);
        auto it = oldcands.begin();
        while (it != oldcands.end()) {
            holding_table.emplace(_self, [&](candidate2 &c) {
                c.candidate_name = it->candidate_name;
                c.bio = it->bio;
                c.requestedpay = it->requestedpay;
                c.pendreqpay = it->pendreqpay;
                c.locked_tokens = it->locked_tokens;
                c.total_votes = it->total_votes;
            });
            it = oldcands.erase(it);
        }

    // Copy back to the original table with the new schema - Enable this for the second step *after* modifying the original object's schema before copying back to the original table location.

        candidates_table2 holding_table(_self, _self.value);
        candidates_table oldcands(_self, _self.value);
        auto it = holding_table.begin();
        while (it != holding_table.end()) {
            oldcands.emplace(_self, [&](candidate &c) {
                c.candidate_name = it->candidate_name;
                c.bio = it->bio;
                c.requestedpay = it->requestedpay;
                c.locked_tokens = it->locked_tokens;
                c.total_votes = it->total_votes;
            });
            it = holding_table.erase(it);
        }
        */
}
