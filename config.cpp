
void daccustodian::updateconfig(
        asset lockupasset,
        uint8_t maxvotes,
        uint8_t numelected,
        uint32_t periodlength,
        name tokcontr,
        name authaccount,
        uint32_t initial_vote_quorum_percent,
        uint32_t vote_quorum_percent,
        uint8_t auth_threshold_high,
        uint8_t auth_threshold_mid,
        uint8_t auth_threshold_low
) {

    require_auth(_self);

    // If the registered candidates is not empty prevent a change to the lockup asset symbol.
    if (configs().lockupasset.amount != 0 && registered_candidates.begin() != registered_candidates.end()) {
        eosio_assert(lockupasset.symbol == configs().lockupasset.symbol,
                     "The provided asset cannot be changed while there are registered candidates due to current staking in the old asset.");
    }

    eosio_assert(auth_threshold_high < numelected,
                 "The auth threshold can never be satisfied with a value greater than the number of elected custodians");

    contr_config newconfig{
            lockupasset,
            maxvotes,
            numelected,
            periodlength,
            tokcontr,
            authaccount,
            initial_vote_quorum_percent,
            vote_quorum_percent,
            auth_threshold_high,
            auth_threshold_mid,
            auth_threshold_low};
    config_singleton.set(newconfig, _self);
}