
using namespace eosdac;

void daccustodian::updatebio(name cand, string bio) {
    updatebioe(cand, bio, get_self());
}

void daccustodian::updatebioe(name cand, string bio, name dac_id) {

    require_auth(cand);
    assertValidMember(cand, dac_id);
    candidates_table registered_candidates(_self, dac_id.value);

    const auto &reg_candidate = registered_candidates.get(cand.value, "ERR::UPDATEBIO_NOT_CURRENT_REG_CANDIDATE::Candidate is not already registered.");
    check(bio.size() < 256, "ERR::UPDATEBIO_BIO_SIZE_TOO_LONG::The bio should be less than 256 characters.");
}

void daccustodian::updatereqpay(name cand, asset requestedpay) {
    updatereqpae(cand, requestedpay, get_self());
}

void daccustodian::updatereqpae(name cand, asset requestedpay, name dac_id) {

    require_auth(cand);
    assertValidMember(cand, dac_id);
    
    candidates_table registered_candidates(_self, dac_id.value);

    check(requestedpay.amount >= 0, "ERR::UPDATEREQPAY_UNDER_ZERO::Requested pay amount must not be negative.");
    check(requestedpay <= contr_config::get_current_configs(_self, dac_id).requested_pay_max, "ERR::UPDATEREQPAY_EXCESS_MAX_PAY::Requested pay amount limit for a candidate was exceeded.");
    const auto &reg_candidate = registered_candidates.get(cand.value, "ERR::UPDATEREQPAY_NOT_CURRENT_REG_CANDIDATE::Candidate is not already registered.");

    registered_candidates.modify(reg_candidate, cand, [&](candidate &c) {
        c.requestedpay = requestedpay;
    });
}