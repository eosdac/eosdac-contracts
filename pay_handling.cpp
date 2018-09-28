
void daccustodian::claimpay(uint64_t payid) {

    const pay &payClaim = pending_pay.get(payid, "Invalid pay claim id.");

    require_auth(payClaim.receiver);

    if (payClaim.quantity.symbol == configs().requested_pay_max.symbol) {
        action(permission_level{configs().tokenholder, N(active)},
               N(eosio.token), N(transfer),
               std::make_tuple(configs().tokenholder, payClaim.receiver, payClaim.quantity, payClaim.memo)
        ).send();
    } else {
        action(permission_level{configs().tokenholder, N(active)},
               eosio::string_to_name(TOKEN_CONTRACT), N(transfer),
               std::make_tuple(configs().tokenholder, payClaim.receiver, payClaim.quantity, payClaim.memo)
        ).send();
    }

    pending_pay.erase(payClaim);
}
