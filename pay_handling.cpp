
void daccustodian::claimpay(name claimer, uint64_t payid) {
    require_auth(claimer);

    const pay &payClaim = pending_pay.get(payid, "Invalid pay claim id.");

    eosio_assert(claimer == payClaim.receiver, "Pay can only be claimed by the intended receiver");

    if (payClaim.quantity.symbol == configs().requested_pay_max.symbol) {
        action(permission_level{_self, N(active)},
               N(eosio.token), N(transfer),
               std::make_tuple(_self, payClaim.receiver, payClaim.quantity, payClaim.memo)
        ).send();
    } else {
        action(permission_level{_self, N(active)},
               configs().tokencontr, N(transfer),
               std::make_tuple(_self, payClaim.receiver, payClaim.quantity, payClaim.memo)
        ).send();
    }

    pending_pay.erase(payClaim);
}

void daccustodian::paypending(string message) {
    require_auth(_self);
    auto payidx = pending_pay.begin();
    eosio_assert(payidx != pending_pay.end(), "pending pay is empty");

    while (payidx != pending_pay.end()/* TODO: Add AND batch condition here to avoid long transaction errors */) {
        if (payidx->quantity.symbol == configs().requested_pay_max.symbol) {
            action(permission_level{_self, N(active)},
                   N(eosio.token), N(transfer),
                   std::make_tuple(_self, payidx->receiver, payidx->quantity, payidx->memo)
            ).send();
        } else {
            action(permission_level{_self, N(active)},
                   configs().tokencontr, N(transfer),
                   std::make_tuple(_self, payidx->receiver, payidx->quantity, payidx->memo)
            ).send();
        }

        payidx = pending_pay.erase(payidx);
    }

    if (payidx != pending_pay.end()) {

        //        Schedule the the next pending pay batch into a separate transaction.
        transaction nextPendingPayBatch{};
        nextPendingPayBatch.actions.emplace_back(
                permission_level(_self, N(active)),
                _self, N(paypending),
                std::make_tuple("DAC Payment delayed batch transaction.")
        );
        nextPendingPayBatch.delay_sec = 1;
        nextPendingPayBatch.send(N(paypending), false);
    }
}