
void daccustodian::updateconfig(
        asset lockupasset,
        uint8_t maxvotes,
        uint8_t numelected,
        uint32_t periodlength,
        name authaccount,
        name tokenholder,
        uint32_t initial_vote_quorum_percent,
        uint32_t vote_quorum_percent,
        uint8_t auth_threshold_high,
        uint8_t auth_threshold_mid,
        uint8_t auth_threshold_low,
        uint32_t lockup_release_time_delay,
        asset requested_pay_max
) {

    require_auth(configs().authaccount);

    eosio_assert(auth_threshold_high < numelected,
                 "ERR::UPDATECONFIG_INVALID_AUTH_HIGH_TO_NUM_ELECTED::The auth threshold can never be satisfied with a value greater than the number of elected custodians");
    eosio_assert(auth_threshold_mid <= auth_threshold_high,
                 "ERR::UPDATECONFIG_INVALID_AUTH_HIGH_TO_MID_AUTH::The mid auth threshold cannot be greater than the high auth threshold.");
    eosio_assert(auth_threshold_low <= auth_threshold_mid,
                 "ERR::UPDATECONFIG_INVALID_AUTH_MID_TO_LOW_AUTH::The low auth threshold cannot be greater than the mid auth threshold.");

    contr_config newconfig{
            lockupasset,
            maxvotes,
            numelected,
            periodlength,
            authaccount,
            tokenholder,
            initial_vote_quorum_percent,
            vote_quorum_percent,
            auth_threshold_high,
            auth_threshold_mid,
            auth_threshold_low,
            lockup_release_time_delay,
            requested_pay_max};
    config_singleton.set(newconfig, _self);
}
