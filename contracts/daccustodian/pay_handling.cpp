#include <eosio/transaction.hpp>
using namespace eosdac;

ACTION daccustodian::claimpay(const uint64_t payid, const name &dac_id) {
    auto        pending_pay = pending_pay_table{get_self(), dac_id.value};
    const auto  dac         = dacdir::dac_for_id(dac_id);
    const auto  configs     = contr_config::get_current_configs(get_self(), dac_id);
    const auto &payClaim    = pending_pay.get(payid, "ERR::CLAIMPAY_INVALID_CLAIM_ID::Invalid pay claim id.");

    assertValidMember(payClaim.receiver, dac_id);
    require_auth(payClaim.receiver);

    name       payment_destination;
    string     memo;
    const auto memo_message = "Custodian Pay. Thank you."s;

    if (configs.should_pay_via_service_provider) {
        const auto service_account = dac.account_for_type(dacdir::SERVICE);
        memo                       = payClaim.receiver.to_string() + ":" + memo_message + ":" + to_string(payid);
        print("constructed memo for the service contract: " + memo);
        payment_destination = service_account;
    } else {
        memo = memo_message + ":" + to_string(payid);
        ;
        print("constructed memo for the receiver contract: " + memo);
        payment_destination = payClaim.receiver;
    }

    const auto token_holder = dac.account_for_type(dacdir::TREASURY);
    action(permission_level{token_holder, "xfer"_n}, configs.requested_pay_max.contract, "transfer"_n,
        std::make_tuple(token_holder, payment_destination, payClaim.quantity.quantity, memo))
        .send();

    pending_pay.erase(payClaim);
}

ACTION daccustodian::removecuspay(const uint64_t payid, const name &dac_id) {
    require_auth(get_self());

    pending_pay_table pending_pay(get_self(), dac_id.value);
    const pay        &payClaim = pending_pay.get(payid, "ERR::CLAIMPAY_INVALID_CLAIM_ID::Invalid pay claim id.");

    pending_pay.erase(payClaim);
}

ACTION daccustodian::rejectcuspay(const uint64_t payid, const name &dac_id) {
    pending_pay_table pending_pay(get_self(), dac_id.value);
    const pay        &payClaim = pending_pay.get(payid, "ERR::CLAIMPAY_INVALID_CLAIM_ID::Invalid pay claim id.");
    assertValidMember(payClaim.receiver, dac_id);

    require_auth(payClaim.receiver);

    pending_pay.erase(payClaim);
}
