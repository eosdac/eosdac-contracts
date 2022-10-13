
using namespace eosdac;

void daccustodian::updateVoteWeight(
    name custodian, const time_point_sec vote_time_stamp, int64_t weight, name dac_id, bool from_voting) {

    if (weight == 0) {
        print("Vote has no weight - No need to continue. ");
        return;
    }
    candidates_table registered_candidates(_self, dac_id.value);

    auto candItr = registered_candidates.find(custodian.value);
    if (candItr == registered_candidates.end()) {
        eosio::print("Candidate not found while updating from a transfer: ", custodian);
        return; // trying to avoid throwing errors from here since it's unrelated to a transfer action.?!?!?!?!
    }
    registered_candidates.modify(candItr, same_payer, [&](auto &c) {
        c.total_vote_power = S<uint64_t>{c.total_vote_power}.to<int64_t>() + S{weight};
        if (from_voting) {
            if (c.total_vote_power == 0) {
                c.avg_vote_time_stamp = time_point_sec(0);
            } else {
                c.avg_vote_time_stamp =
                    calculate_avg_vote_time_stamp(c.avg_vote_time_stamp, vote_time_stamp, weight, c.total_vote_power);
                check(c.avg_vote_time_stamp <= now(), "avg_vote_time_stamp pushed into the future: %s",
                    c.avg_vote_time_stamp);
            }
        }
        c.update_index();
    });
}

time_point_sec daccustodian::calculate_avg_vote_time_stamp(const time_point_sec vote_time_before,
    const time_point_sec vote_time_stamp, const int64_t weight, const uint64_t total_votes) {

    const auto initial     = S{vote_time_before.sec_since_epoch()}.to<int128_t>();
    const auto current     = S{vote_time_stamp.sec_since_epoch()}.to<int128_t>();
    const auto time_delta  = (current - initial).abs();
    const auto new_seconds = initial + time_delta * S{weight}.to<int128_t>() / S{total_votes}.to<int128_t>();

    return time_point_sec{new_seconds.to<uint32_t>()};
}

void daccustodian::updateVoteWeights(const vector<name> &votes, const time_point_sec vote_time_stamp,
    int64_t vote_weight, name dac_id, bool from_voting) {

    for (const auto &cust : votes) {
        updateVoteWeight(cust, vote_time_stamp, vote_weight, dac_id, from_voting);
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
    const std::optional<time_point_sec> &oldVoteTimestamp, const vector<name> &newVotes, const name dac_id,
    const bool from_voting) {
    // This could be optimised with set diffing to avoid remove then add for unchanged votes. - later

    if (awd.weight_delta == 0) {
        print("Voter has no weight therefore no need to update vote weights");
        return;
    }
    auto globals = dacglobals::current(get_self(), dac_id);

    // New voter -> Add the tokens to the total weight.
    auto total_weight_of_votes            = S{globals.get_total_weight_of_votes()};
    auto total_stake_time_weight_of_votes = globals.get_total_votes_on_candidates();

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

    globals.save(get_self(), dac_id);

    if (oldVoteTimestamp.has_value()) {
        updateVoteWeights(oldVotes, *oldVoteTimestamp, -awd.weight_delta, dac_id, from_voting);
    }
    updateVoteWeights(newVotes, now(), awd.weight_delta, dac_id, from_voting);
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
