#include <eosiolib/transaction.hpp>

void daccustodian::claimpay(uint64_t payid) {

    const pay &payClaim = pending_pay.get(payid, "Invalid pay claim id.");

    require_auth(payClaim.receiver);

    transaction deferredTrans{};

    if (payClaim.quantity.symbol == configs().requested_pay_max.symbol) {

        deferredTrans.actions.emplace_back(
        action(permission_level{configs().tokenholder, N(xfer)},
               N(eosio.token), N(transfer),
               std::make_tuple(configs().tokenholder, payClaim.receiver, payClaim.quantity, payClaim.memo)
        ));
    } else {
        deferredTrans.actions.emplace_back(
                action(permission_level{configs().tokenholder, N(xfer)},
               eosio::string_to_name(TOKEN_CONTRACT), N(transfer),
               std::make_tuple(configs().tokenholder, payClaim.receiver, payClaim.quantity, payClaim.memo)
        ));
    }

    deferredTrans.delay_sec = 30;
    deferredTrans.send(payid, _self);

    pending_pay.erase(payClaim);
}
