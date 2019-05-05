
void daccustodian::updateconfig(contr_config new_config) {

    if (configs().authaccount == name{0}) {
        require_auth(_self);
    } else {
        require_auth(configs().authaccount);
    }

    check(new_config.auth_threshold_high < new_config.numelected,
                 "ERR::UPDATECONFIG_INVALID_AUTH_HIGH_TO_NUM_ELECTED::The auth threshold can never be satisfied with a value greater than the number of elected custodians");
    check(new_config.auth_threshold_mid <= new_config.auth_threshold_high,
                 "ERR::UPDATECONFIG_INVALID_AUTH_HIGH_TO_MID_AUTH::The mid auth threshold cannot be greater than the high auth threshold.");
    check(new_config.auth_threshold_low <= new_config.auth_threshold_mid,
                 "ERR::UPDATECONFIG_INVALID_AUTH_MID_TO_LOW_AUTH::The low auth threshold cannot be greater than the mid auth threshold.");

    config_singleton.set(new_config, _self);
}
