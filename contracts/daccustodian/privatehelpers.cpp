
using namespace eosdac;

void daccustodian::updateVoteWeight(name voter, name custodian, const time_point_sec vote_time_stamp, int64_t weight,
    name dac_id, bool from_voting, const vector<name> &votes) {
    auto err = Err{"daccustodian::updateVoteWeight"};

    candidates_table registered_candidates(_self, dac_id.value);

    auto candItr = registered_candidates.find(custodian.value);
    if (candItr == registered_candidates.end()) {
        eosio::print("Candidate not found while updating from a transfer: ", custodian);
        return; // trying to avoid throwing errors from here since it's unrelated to a transfer action.?!?!?!?!
    }
    registered_candidates.modify(candItr, same_payer, [&](auto &c) {
        auto err = Err("daccustodian::updateVoteWeight c.total_vote_power: %s weight: %s", c.total_vote_power, weight);

        const auto new_vote_power = S<uint64_t>{c.total_vote_power}.to<int64_t>() + S{weight};
        if (new_vote_power < int64_t{}) {
            ::check(new_vote_power > int64_t{-5}, "ERR:INVALID_VOTE_POWER::new_vote_power is %s", new_vote_power);
            c.total_vote_power = 0;
        } else {
            c.total_vote_power = new_vote_power.to<uint64_t>();
        }

        auto       votes_cast_by_members = votes_table{_self, dac_id.value};
        const auto existingVote          = votes_cast_by_members.find(voter.value);

        auto delta = calc_avg_vote_time_delta(c.avg_vote_time_stamp, vote_time_stamp, weight, c.total_vote_power);

        if (weight < 0) {
            // removing vote, reduce total vote power by the amount added when adding vote
            check(existingVote != votes_cast_by_members.end(),
                "ERR::VOTE_NOT_FOUND::Vote not found for voter %s. Weight: %s", voter, weight);
            check(false, "user is removing vote c.avg_vote_time_stamp: %s existingVote->avg_vote_time_delta: %s",
                c.avg_vote_time_stamp, existingVote->avg_vote_time_delta);
            c.avg_vote_time_stamp -= existingVote->avg_vote_time_delta;
            votes_cast_by_members.erase(existingVote);
        } else {
            // adding vote, calculate new average vote time stamp and save delta for later
            c.avg_vote_time_stamp += delta;
            if (from_voting) {
                // if this is called from a voting action, we need to insert/update the vote in the vote table
                upsert(votes_cast_by_members, voter.value, voter, [&](vote &v) {
                    v.voter           = voter;
                    v.candidates      = votes;
                    v.vote_time_stamp = now();
                    v.vote_count++;
                    v.avg_vote_time_delta = delta;
                });
            } else {
                // if this is called from a weight change, we must only update the delta
                votes_cast_by_members.modify(existingVote, same_payer, [&](auto &v) {
                    v.avg_vote_time_delta = delta;
                });
            }
        }

        check(c.avg_vote_time_stamp <= now(), "avg_vote_time_stamp pushed into the future: %s", c.avg_vote_time_stamp);

        c.update_index();
    });
}

time_point_sec daccustodian::calc_avg_vote_time_delta(const time_point_sec vote_time_before,
    const time_point_sec vote_time_stamp, const int64_t weight, const uint64_t total_votes) {
    auto err = Err{"daccustodian::calculate_avg_vote_time_stamp"};

    if (total_votes == 0) {
        return time_point_sec(0);
    }

    const auto initial    = S{vote_time_before.sec_since_epoch()}.to<int128_t>();
    const auto current    = S{vote_time_stamp.sec_since_epoch()}.to<int128_t>();
    const auto time_delta = (current - initial);
    const auto delta      = time_delta * S{weight}.to<int128_t>() / S{total_votes}.to<int128_t>();

    return time_point_sec{delta.to<uint32_t>()};
}

void daccustodian::updateVoteWeights(const name voter, const vector<name> &votes, const time_point_sec vote_time_stamp,
    int64_t vote_weight, name dac_id, bool from_voting) {

    for (const auto &cust : votes) {
        updateVoteWeight(voter, cust, vote_time_stamp, vote_weight, dac_id, from_voting, votes);
    }
}

std::pair<int64_t, int64_t> daccustodian::get_vote_weight(name voter, name dac_id) {

    dacdir::dac found_dac = dacdir::dac_for_id(dac_id);

    const auto      vote_contract = found_dac.account_for_type_maybe(dacdir::VOTE_WEIGHT);
    extended_symbol token_symbol  = found_dac.symbol;

    if (vote_contract) {
        weights weights_table(*vote_contract, dac_id.value);
        auto    weight_itr = weights_table.find(voter.value);
        if (weight_itr != weights_table.end()) {
            return {weight_itr->weight, weight_itr->weight_quorum};
        }
    } else {
        accounts accountstable(token_symbol.get_contract(), voter.value);

        const auto ac = accountstable.find(token_symbol.get_symbol().code().raw());
        if (ac != accountstable.end()) {
            return {ac->balance.amount, ac->balance.amount};
        }
    }

    return {0, 0};
}

void daccustodian::modifyVoteWeights(const account_weight_delta &awd, const vector<name> &oldVotes,
    const std::optional<time_point_sec> &oldVoteTimestamp, const vector<name> &newVotes, time_point_sec new_time_stamp,
    const name dac_id, const bool from_voting) {
    auto err = Err{"daccustodian::modifyVoteWeights"};
    // This could be optimised with set diffing to avoid remove then add for unchanged votes. - later

    auto globals = dacglobals{get_self(), dac_id};

    // New voter -> Add the tokens to the total weight.
    auto total_weight_of_votes            = S{globals.get_total_weight_of_votes()};
    auto total_stake_time_weight_of_votes = S{globals.get_total_votes_on_candidates()};

    if (oldVotes.size() == 0) {
        total_weight_of_votes += S{awd.weight_delta_quorum};
        total_stake_time_weight_of_votes += S{awd.weight_delta};
    }

    // Leaving voter -> Remove the tokens to the total weight.
    if (newVotes.size() == 0) {
        total_weight_of_votes -= S{awd.weight_delta_quorum};
        total_stake_time_weight_of_votes -= S{awd.weight_delta};
    }

    globals.set_total_weight_of_votes(total_weight_of_votes);
    globals.set_total_votes_on_candidates(total_stake_time_weight_of_votes);

    if (oldVoteTimestamp.has_value()) {
        updateVoteWeights(awd.account, oldVotes, *oldVoteTimestamp, -awd.weight_delta, dac_id, from_voting);
    }
    updateVoteWeights(awd.account, newVotes, new_time_stamp, awd.weight_delta, dac_id, from_voting);
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
