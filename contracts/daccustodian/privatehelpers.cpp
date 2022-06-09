
using namespace eosdac;

void daccustodian::updateVoteWeight(name custodian, const std::optional<time_point_sec> vote_time_stamp, int64_t weight,
    name dac_id, bool from_voting) {

    if (weight == 0) {
        print("\n Vote has no weight - No need to continue.");
        return;
    }
    candidates_table registered_candidates(_self, dac_id.value);

    auto candItr = registered_candidates.find(custodian.value);
    if (candItr == registered_candidates.end()) {
        eosio::print("Candidate not found while updating from a transfer: ", custodian);
        return; // trying to avoid throwing errors from here since it's unrelated to a transfer action.?!?!?!?!
    }

    if (weight < 0) {
        check((candItr->total_votes + weight) < candItr->total_votes, "Underflow in updateVoteWeight");
    } else {
        check((candItr->total_votes + weight) >= candItr->total_votes, "Overflow in updateVoteWeight");
    }

    registered_candidates.modify(candItr, same_payer, [&](auto &c) {
        if (weight > 0) {
            c.total_votes += weight;
        }
#ifdef VOTE_DECAY_STAGE_2
        if (vote_time_stamp) {
            if (c.total_votes == 0) {
                check(weight >= 0, "c.total_votes == 0 called with weight: %s dac_id: %s c.total_votes: %s", weight,
                    dac_id, c.total_votes);
                // TODO: What to do if c.total_votes is zero to prevent division by zero?
                c.avg_vote_time_stamp = time_point_sec(0);
            } else {
                c.avg_vote_time_stamp =
                    calculate_avg_vote_time_stamp(c.avg_vote_time_stamp, *vote_time_stamp, weight, c.total_votes);
            }
        } else {
            check(false, "vote_time_stamp is null: %s  weight: %s total_votes: %s", weight, c.total_votes);
        }
#endif
        if (weight < 0) {
            c.total_votes += weight;
        }
    });
}

time_point_sec daccustodian::calculate_avg_vote_time_stamp(const time_point_sec vote_time_before,
    const time_point_sec vote_time_stamp, const int64_t weight, const uint64_t total_votes) {
    check(total_votes != 0, "division by zero, total_votes is 0");
    const auto delta_seconds =
        (int128_t(vote_time_stamp.sec_since_epoch()) - int128_t(vote_time_before.sec_since_epoch())) *
        int128_t(weight) / int128_t(total_votes);
    const auto max_amount = std::numeric_limits<int64_t>::max();
    check(delta_seconds <= max_amount, "multiplication overflow");
    check(delta_seconds >= -max_amount, "multiplication underflow");
    auto new_seconds = int128_t(vote_time_before.sec_since_epoch()) + delta_seconds;
    print(fmt(
        "time since last vote: %s delta_seconds: %s new_seconds: %s vote_time_stamp.sec_since_epoch(): %s vote_time_before.sec_since_epoch(): %s weight: %s total_votes: %s",
        now().sec_since_epoch() - vote_time_stamp.sec_since_epoch(), int64_t(delta_seconds), int64_t(new_seconds),
        vote_time_stamp.sec_since_epoch(), vote_time_before.sec_since_epoch(), weight, total_votes));

    check(new_seconds <= std::numeric_limits<uint32_t>::max(), "new_seconds does not fit into a uint32_t");
    const auto retval = time_point_sec{uint32_t(new_seconds)};
    check(retval <= now(),
        "avg_vote_time_stamp is in the future: %s vote_time_before: %s vote_time_stamp: %s weight: %s total_votes: %s percentage: %s",
        retval, vote_time_before, vote_time_stamp, weight, total_votes, 100 * double(weight) / double(total_votes));

    return retval;
}

void daccustodian::updateVoteWeights(const vector<name> &votes, const std::optional<time_point_sec> vote_time_stamp,
    int64_t vote_weight, name dac_id, bool from_voting) {

    for (const auto &cust : votes) {
        updateVoteWeight(cust, vote_time_stamp, vote_weight, dac_id);
    }

    int16_t vote_delta = votes.size() * vote_weight;

    if (vote_delta != 0) {
        auto       currentState              = contr_state2::get_current_state(get_self(), dac_id);
        const auto total_votes_on_candidates = currentState.get_total_votes_on_candidates();
        currentState.set_total_votes_on_candidates(total_votes_on_candidates + vote_delta);
        currentState.save(get_self(), dac_id);
    }
}

int64_t daccustodian::get_vote_weight(name voter, name dac_id) {

    dacdir::dac found_dac = dacdir::dac_for_id(dac_id);

    const auto      vote_contract = found_dac.account_for_type_maybe(dacdir::VOTE_WEIGHT);
    extended_symbol token_symbol  = found_dac.symbol;

    if (vote_contract) {
        weights weights_table(*vote_contract, dac_id.value);
        auto    weight_itr = weights_table.find(voter.value);
        if (weight_itr != weights_table.end()) {
            return weight_itr->weight;
        }
    } else {
        accounts accountstable(token_symbol.get_contract(), voter.value);

        const auto ac = accountstable.find(token_symbol.get_symbol().code().raw());
        if (ac != accountstable.end()) {
            return ac->balance.amount;
        }
    }

    return 0;
}

void daccustodian::modifyVoteWeights(int64_t vote_weight, vector<name> oldVotes,
    std::optional<time_point_sec> oldVoteTimestamp, vector<name> newVotes, name dac_id, bool from_voting) {
    // This could be optimised with set diffing to avoid remove then add for unchanged votes. - later

    if (vote_weight == 0) {
        print("Voter has no weight therefore no need to update vote weights");
        return;
    }
    auto currentState = contr_state2::get_current_state(get_self(), dac_id);

    // New voter -> Add the tokens to the total weight.
    auto total_weight_of_votes = currentState.get_total_weight_of_votes();
    if (vote_weight > 0) {
        check((total_weight_of_votes + vote_weight) >= total_weight_of_votes, "Overflow in total_weight_of_votes");
    } else {
        check((total_weight_of_votes + vote_weight) <= total_weight_of_votes, "Underflow in total_weight_of_votes");
    }

    if (oldVotes.size() == 0)
        total_weight_of_votes += vote_weight;

    // Leaving voter -> Remove the tokens to the total weight.
    if (newVotes.size() == 0)
        total_weight_of_votes -= vote_weight;

    currentState.set_total_weight_of_votes(total_weight_of_votes);
    currentState.save(get_self(), dac_id);

    updateVoteWeights(oldVotes, oldVoteTimestamp, -vote_weight, dac_id, from_voting);
    updateVoteWeights(newVotes, now(), vote_weight, dac_id, from_voting);
}

permission_level daccustodian::getCandidatePermission(name account, name dac_id) {

    candperms_table cand_perms(_self, dac_id.value);
    auto            perm = cand_perms.find(account.value);
    if (perm == cand_perms.end()) {
        return permission_level{account, "active"_n};
    } else {
        if (permissionExists(account, perm->permission)) {
            return permission_level{account, perm->permission};
        } else {
            return permission_level{account, "active"_n};
        }
    }
}

/*
 * TODO : replace with the native function once cdt 1.7.0 is released
 *
 * https://github.com/EOSIO/eosio.contracts/pull/257
 */
bool daccustodian::_check_transaction_authorization(const char *trx_data, uint32_t trx_size, const char *pubkeys_data,
    uint32_t pubkeys_size, const char *perms_data, uint32_t perms_size) {
    auto res = internal_use_do_not_use::check_transaction_authorization(
        trx_data, trx_size, pubkeys_data, pubkeys_size, perms_data, perms_size);

    return (res > 0);
}

/*
 * Check if a permission exists, the transaction attempts to create or modify a permission with the name of the
 * permission we are checking, *but parent of owner*.  If the permission exists (under active) then updateauth will
 * assert with an error about not being able to change the parent of the existing permission, permission checks will
 * pass.
 *
 * If the permission does NOT exist then updateauth will require auth of the parent permission (owner), but we only test
 * against active.  Auth checks will fail and the function will return false.
 *
 * This can be removed if https://github.com/EOSIO/eos/issues/6657 is fixed
 */
bool daccustodian::permissionExists(name account, name permission) {
    transaction            trx;
    eosiosystem::authority authority{.threshold = {}, .keys = {}, .accounts = {}};
    trx.actions.push_back(action(permission_level{account, "active"_n}, "eosio"_n, "updateauth"_n,
        std::make_tuple(account, permission, "owner"_n, authority)));

    auto packed_trx = pack(trx);

    auto check_perms = std::vector<permission_level>();
    check_perms.push_back(permission_level{account, "active"_n});

    auto packed_perms = pack(check_perms);

    bool res = _check_transaction_authorization(
        packed_trx.data(), packed_trx.size(), (const char *)0, 0, packed_perms.data(), packed_perms.size());

    return res;
}
