void daccustodian::updatebio(name cand, string bio) {

    require_auth(cand);
    get_valid_member(cand);

    const auto &reg_candidate = registered_candidates.get(cand, "Candidate is not already registered.");
    eosio_assert(bio.size() < 256, "The bio should be less than 256 characters.");

    registered_candidates.modify(reg_candidate, cand, [&](candidate &c) {
        c.bio = bio;
    });
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