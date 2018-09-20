
/**
 * This action is used to update the bio for a candidate.
 *
 * ### Assertions:
 * - The `cand` account performing the action is authorised to do so.
 * - The `cand` has agreed to the latest constitution and member terms.
 * - The `cand` is currently in the candidates table.
 * - The string in the bio field is less than 256 chartacers.
 * @param cand - The account id for the candidate nominating.
 * @param bio - A string of bio data that will be passed through the contract.
 *
 *
 * ### Post Condition:
Nothing from this action is stored on the blockchain. It is only intended to ensure authentication of changing the bio which will be stored off chain.
 */
void daccustodian::updatebio(name cand, string bio) {

    require_auth(cand);
    get_valid_member(cand);

    const auto &reg_candidate = registered_candidates.get(cand, "Candidate is not already registered.");
    eosio_assert(bio.size() < 256, "The bio should be less than 256 characters.");
}

void daccustodian::updatereqpay(name cand, asset requestedpay) {

    require_auth(cand);
    get_valid_member(cand);
    eosio_assert(requestedpay.amount < 4500000, "Requested pay amount limit of 250 token for a candidate was exceeded.");
    const auto &reg_candidate = registered_candidates.get(cand, "Candidate is not already registered.");

    registered_candidates.modify(reg_candidate, cand, [&](candidate &c) {
        c.requestedpay = requestedpay;
    });
}