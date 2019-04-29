
void daccustodian::updatebio(name cand, string bio) {

    require_auth(cand);
    assertValidMember(cand);

    const auto &reg_candidate = registered_candidates.get(cand.value, "ERR::UPDATEBIO_NOT_CURRENT_REG_CANDIDATE::Candidate is not already registered.");
    check(bio.size() < 256, "ERR::UPDATEBIO_BIO_SIZE_TOO_LONG::The bio should be less than 256 characters.");
}

void daccustodian::updatereqpay(name cand, asset requestedpay) {

    require_auth(cand);
    assertValidMember(cand);
    check(requestedpay.amount >= 0, "ERR::UPDATEREQPAY_UNDER_ZERO::Requested pay amount must not be negative.");
    check(requestedpay <= configs().requested_pay_max, "ERR::UPDATEREQPAY_EXCESS_MAX_PAY::Requested pay amount limit for a candidate was exceeded.");
    const auto &reg_candidate = registered_candidates.get(cand.value, "ERR::UPDATEREQPAY_NOT_CURRENT_REG_CANDIDATE::Candidate is not already registered.");

    registered_candidates.modify(reg_candidate, cand, [&](candidate &c) {
        c.requestedpay = requestedpay;
    });
}
    