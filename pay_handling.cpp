#include <eosio/transaction.hpp>

void daccustodian::claimpay(uint64_t payid) {

    const pay &payClaim = pending_pay.get(payid, "ERR::CLAIMPAY_INVALID_CLAIM_ID::Invalid pay claim id.");
    assertValidMember(payClaim.receiver);

    require_auth(payClaim.receiver);

    transaction deferredTrans{};

    string memo = payClaim.receiver.to_string() + ":" + payClaim.memo + ":" + to_string(payid);;

    print("constructed memo for the service contract: " + memo);

    name serviceAccount = configs().serviceprovider;

    if (payClaim.quantity.symbol == configs().requested_pay_max.symbol) {

        deferredTrans.actions.emplace_back(
                action(permission_level{configs().tokenholder, "xfer"_n},
                       "eosio.token"_n, "transfer"_n,
                       std::make_tuple(configs().tokenholder, serviceAccount, payClaim.quantity, memo)
                ));
    } else {
        deferredTrans.actions.emplace_back(
                action(permission_level{configs().tokenholder, "xfer"_n},
                       name(TOKEN_CONTRACT), "transfer"_n,
                       std::make_tuple(configs().tokenholder, serviceAccount, payClaim.quantity, memo)
                ));
    }

    deferredTrans.delay_sec = TRANSFER_DELAY;
    deferredTrans.send(uint128_t(payid) << 64 | time_point_sec(current_time_point()).sec_since_epoch() , _self);

    pending_pay.erase(payClaim);
}
