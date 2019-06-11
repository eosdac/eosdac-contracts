#include <eosio/transaction.hpp>

void daccustodian::claimpay(uint64_t payid) {
    claimpaye(payid, get_self());
}

void daccustodian::claimpaye(uint64_t payid, name dac_id) {
    pending_pay_table pending_pay(_self, dac_id.value);
    
    dacdir::dac found_dac = dacdir::dac_for_id(dac_id);

    contr_config configs = contr_config::get_current_configs(_self, dac_id);
    const pay &payClaim = pending_pay.get(payid, "ERR::CLAIMPAY_INVALID_CLAIM_ID::Invalid pay claim id.");
    assertValidMember(payClaim.receiver, dac_id);

    require_auth(payClaim.receiver);

    transaction deferredTrans{};
    
    name payment_destination;
    string memo;

    auto dac = dacdir::dac_for_id(dac_id);
    name service_account = dac.account_for_type(dacdir::SERVICE);
    name token_holder = dac.account_for_type(dacdir::TREASURY);

    if (configs.should_pay_via_service_provider) {
        memo = payClaim.receiver.to_string() + ":" + payClaim.memo + ":" + to_string(payid);;
        print("constructed memo for the service contract: " + memo);
        payment_destination = service_account;
    } else {
        memo = payClaim.memo + ":" + to_string(payid);;
        print("constructed memo for the receiver contract: " + memo);
        payment_destination = payClaim.receiver;
    }

    if (payClaim.quantity.symbol == configs.requested_pay_max.symbol) {

        deferredTrans.actions.emplace_back(
                action(permission_level{token_holder, "xfer"_n},
                       "eosio.token"_n, "transfer"_n,
                       std::make_tuple(token_holder, payment_destination, payClaim.quantity, memo)
                ));
    } else {
        deferredTrans.actions.emplace_back(
                action(permission_level{token_holder, "xfer"_n},
                        found_dac.account_for_type(dacdir::TOKEN),
                        "transfer"_n,
                        std::make_tuple(token_holder, payment_destination, payClaim.quantity, memo)
                ));
    }

    deferredTrans.delay_sec = TRANSFER_DELAY;
    deferredTrans.send(uint128_t(payid) << 64 | time_point_sec(current_time_point()).sec_since_epoch() , _self);

    pending_pay.erase(payClaim);
}
