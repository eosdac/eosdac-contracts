
/**
 * This action is used to update the bio for a candidate.
 *
 * ### Assertions:
 * - The `cand` account performing the action is authorised to do so.
 * - The string in the bio field is less than 256 characters.
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

/**
 * This action is used to update the requested pay for a candidate.
 *
 * ### Assertions:
 * - The `cand` account performing the action is authorised to do so.
 * - The candidate is currently registered as a candidate.
 * - The requestedpay is not more than the requested pay amount.
 * @param cand - The account id for the candidate nominating.
 * @param requestedpay - A string representing the asset they would like to be paid as custodian.
 *
 *
 * ### Post Condition:
 * The requested pay for the candidate should be updated to the new asset.
 */
void daccustodian::updatereqpay(name cand, asset requestedpay) {

    require_auth(cand);
    get_valid_member(cand);
    eosio_assert(requestedpay < configs().requested_pay_max, "Requested pay amount limit for a candidate was exceeded.");
    const auto &reg_candidate = registered_candidates.get(cand, "Candidate is not already registered.");

    registered_candidates.modify(reg_candidate, cand, [&](candidate &c) {
        c.requestedpay = requestedpay;
    });
}