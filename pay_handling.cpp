
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
               eosio::string_to_name(TOKEN_CONTRACT), N(transfer),
               std::make_tuple(_self, payClaim.receiver, payClaim.quantity, payClaim.memo)
        ).send();
    }

    pending_pay.erase(payClaim);
}
