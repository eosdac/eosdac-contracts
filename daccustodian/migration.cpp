
#include "../_contract-shared-headers/migration_helpers.hpp"
using namespace eosdac;

ACTION daccustodian::migrate(uint16_t batch_size) {

    //    uint64_t total_migrated = 0;
    // print("Migrating: ", batch_size, "\n");

    // { // candidates_table
    //     candidates_table source(get_self(), get_self().value);
    //     candidates_table destination(get_self(), NEW_SCOPE.value);

    //     name begin_account = name(0);
    //     auto source_itrr = source.begin();
    //     auto last_destination = destination.end();
    //     if (destination.begin() != destination.end()){
    //         begin_account = (--last_destination)->candidate_name;
    //         source_itrr = source.find(begin_account.value);
    //     }

    //     uint16_t batch_counter = 0, total_migrated = 0;
    //     while (batch_counter < batch_size && source_itrr != source.end()) {
    //         if (destination.find(source_itrr->primary_key()) == destination.end()) {
    //             destination.emplace(get_self(), [&](candidate &dest){
    //                 dest.candidate_name = source_itrr->candidate_name;
    //                 dest.requestedpay = source_itrr->requestedpay;
    //                 dest.locked_tokens = source_itrr->locked_tokens;
    //                 dest.total_votes = source_itrr->total_votes;
    //                 dest.is_active = source_itrr->is_active;
    //                 dest.custodian_end_time_stamp = source_itrr->custodian_end_time_stamp;
    //             });
    //             ++total_migrated;
    //         }
    //         ++batch_counter;
    //         ++source_itrr;
    //     }
    //     print("candidates table migrated: ", total_migrated, "\n");
    // }

    // { // custodians_table
    //     custodians_table source(get_self(), get_self().value);
    //     custodians_table destination(get_self(), NEW_SCOPE.value);

    //     name begin_account = name(0);
    //     auto source_itrr = source.begin();
    //     auto last_destination = destination.end();

    //     if (destination.begin() != destination.end()){
    //         begin_account = (--last_destination)->cust_name;
    //         source_itrr = source.find(begin_account.value);
    //     }

    //     uint16_t batch_counter = 0, total_migrated = 0;
    //     while (batch_counter < batch_size && source_itrr != source.end()) {
    //         if (destination.find(source_itrr->primary_key()) == destination.end()) {
    //             destination.emplace(get_self(), [&](custodian &dest){
    //                 dest.cust_name = source_itrr->cust_name;
    //                 dest.requestedpay = source_itrr->requestedpay;
    //                 dest.total_votes = source_itrr->total_votes;
    //             });
    //             ++total_migrated;
    //         }
    //         ++source_itrr;
    //         ++batch_counter;
    //     }

    //     print("custodians table migrated: ", total_migrated, "\n");
    // }

    // { // state
    //     statecontainer source(get_self(), get_self().value);
    //     statecontainer destination(get_self(), NEW_SCOPE.value);
    //     if (source.exists()) {
    //         destination.set(source.get(), get_self());
    //     }
    // }

    // { // votes
    //     votes_table source(get_self(), get_self().value);
    //     votes_table destination(get_self(), NEW_SCOPE.value);

    //     name begin_account = name(0);
    //     auto source_itrr = source.begin();
    //     auto last_destination = destination.end();

    //     if (destination.begin() != destination.end()){
    //         begin_account = (--last_destination)->voter;
    //         source_itrr = source.find(begin_account.value);
    //     }

    //     uint16_t batch_counter = 0, total_migrated = 0;
    //     while (batch_counter < batch_size && source_itrr != source.end()) {
    //         if (destination.find(source_itrr->primary_key()) == destination.end()) {
    //             destination.emplace(get_self(), [&](vote &dest){
    //                 dest.voter = source_itrr->voter;
    //                 dest.proxy = source_itrr->proxy;
    //                 dest.candidates = source_itrr->candidates;
    //             });
    //             ++total_migrated;
    //         }
    //         ++source_itrr;
    //         ++batch_counter;
    //     }
    //     print("votes_table table migrated: ", total_migrated, "\n");
    // }
}

ACTION daccustodian::clearold(uint16_t batch_size) {
    // require_auth(_self);
    // cleanTable<votes_table>(_self, _self.value, batch_size);
    // cleanTable<custodians_table>(_self, _self.value, batch_size);
    // cleanTable<candidates_table>(_self, _self.value, batch_size);

    // old_configscontainer old_config_container = old_configscontainer(get_self(), get_self().value);
    // old_config_container.remove();

    // statecontainer source(get_self(), get_self().value);
    // source.remove();
}

// void daccustodian::migrate() {

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

// Copy back to the original table with the new schema - Enable this for the second step *after* modifying the original
object's schema before copying back to the original table location.

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
// }
