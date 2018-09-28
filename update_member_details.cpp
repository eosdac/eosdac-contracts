
void daccustodian::updatebio(name cand, string bio) {

    require_auth(cand);
    getValidMember(cand);

    const auto &reg_candidate = registered_candidates.get(cand, "Candidate is not already registered.");
    eosio_assert(bio.size() < 256, "The bio should be less than 256 characters.");
}

void daccustodian::updatereqpay(name cand, asset requestedpay) {

    require_auth(cand);
    getValidMember(cand);
    eosio_assert(requestedpay < configs().requested_pay_max, "Requested pay amount limit for a candidate was exceeded.");
    const auto &reg_candidate = registered_candidates.get(cand, "Candidate is not already registered.");

    registered_candidates.modify(reg_candidate, cand, [&](candidate &c) {
        c.requestedpay = requestedpay;
    });
}