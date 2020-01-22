// #include "../_contract-shared-headers/migration_helpers.hpp"

void daccustodian::updateVoteWeight(name custodian, int64_t weight, name dac_id) {
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
    c.total_votes += weight;
    eosio::print("\nchanging vote weight: ", custodian, " by ", weight);
  });
}

void daccustodian::updateVoteWeights(const vector<name> &votes, int64_t vote_weight, name dac_id) {

  for (const auto &cust : votes) {
    updateVoteWeight(cust, vote_weight, dac_id);
  }

  int16_t vote_delta = votes.size() * vote_weight;

  if (vote_delta != 0) {
    contr_state currentState = contr_state::get_current_state(get_self(), dac_id);
    currentState.total_votes_on_candidates += vote_delta;
    currentState.save(get_self(), dac_id);
  }
}

int64_t daccustodian::get_vote_weight(name voter, name dac_id) {

  dacdir::dac found_dac = dacdir::dac_for_id(dac_id);

  name vote_contract = found_dac.account_for_type(dacdir::VOTE_WEIGHT);
  extended_symbol token_symbol = found_dac.symbol;

  if (vote_contract) {
    weights weights_table(vote_contract, dac_id.value);
    auto weight_itr = weights_table.find(voter.value);
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
}

void daccustodian::modifyVoteWeights(int64_t vote_weight, vector<name> oldVotes, vector<name> newVotes, name dac_id) {
  // This could be optimised with set diffing to avoid remove then add for unchanged votes. - later

  if (vote_weight == 0) {
    print("Voter has no weight therefore no need to update vote weights");
    return;
  }
  contr_state currentState = contr_state::get_current_state(get_self(), dac_id);

  // New voter -> Add the tokens to the total weight.
  if (vote_weight > 0) {
    check((currentState.total_weight_of_votes + vote_weight) >= currentState.total_weight_of_votes,
        "Overflow in total_weight_of_votes");
  } else {
    check((currentState.total_weight_of_votes + vote_weight) <= currentState.total_weight_of_votes,
        "Underflow in total_weight_of_votes");
  }

  if (oldVotes.size() == 0)
    currentState.total_weight_of_votes += vote_weight;

  // Leaving voter -> Remove the tokens to the total weight.
  if (newVotes.size() == 0)
    currentState.total_weight_of_votes -= vote_weight;

  currentState.save(get_self(), dac_id);

  updateVoteWeights(oldVotes, -vote_weight, dac_id);
  updateVoteWeights(newVotes, vote_weight, dac_id);
}

permission_level daccustodian::getCandidatePermission(name account, name dac_id) {

  candperms_table cand_perms(_self, dac_id.value);
  auto perm = cand_perms.find(account.value);
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
  transaction trx;
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
