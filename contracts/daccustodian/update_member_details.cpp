using namespace eosdac;

ACTION daccustodian::updatebio(const name &cand, const string &bio, const name &dac_id) {
    require_auth(cand);
    assertValidMember(cand, dac_id);
    candidates_table registered_candidates(_self, dac_id.value);

    const auto &reg_candidate = registered_candidates.get(
        cand.value, "ERR::UPDATEBIO_NOT_CURRENT_REG_CANDIDATE::Candidate is not already registered.");
    check(bio.size() < 256, "ERR::UPDATEBIO_BIO_SIZE_TOO_LONG::The bio should be less than 256 characters.");
}

ACTION daccustodian::flagcandprof(
    const name &cand, const std::string &reason, const name &reporter, const bool block, const name &dac_id) {
    static auto flag_reporters = vector<eosio::name>{"ameet.worlds"_n, "aliensupport"_n};
    require_auth(reporter);
    check(std::find(flag_reporters.begin(), flag_reporters.end(), reporter) != flag_reporters.end(),
        "Not Authorised to flag or unflag candates");
}

ACTION daccustodian::updatereqpay(const name &cand, const asset &requestedpay, const name &dac_id) {
    require_auth(cand);
    assertValidMember(cand, dac_id);

    candidates_table registered_candidates(_self, dac_id.value);

    check(requestedpay.amount >= 0, "ERR::UPDATEREQPAY_UNDER_ZERO::Requested pay amount must not be negative.");
    check(requestedpay <= dacglobals{get_self(), dac_id}.get_requested_pay_max().quantity,
        "ERR::UPDATEREQPAY_EXCESS_MAX_PAY::Requested pay amount limit for a candidate was exceeded.");
    const auto &reg_candidate = registered_candidates.get(
        cand.value, "ERR::UPDATEREQPAY_NOT_CURRENT_REG_CANDIDATE::Candidate is not already registered.");

    registered_candidates.modify(reg_candidate, cand, [&](candidate &c) {
        c.requestedpay = requestedpay;
    });
}