#include "../_contract-shared-headers/dacdirectory_shared.hpp"

void daccustodian::updateconfig(contr_config new_config) {
    check(false, "This action is deprecated call `updateconfige` instead.");
}

void daccustodian::updateconfige(contr_config new_config, name dac_id) {

    dacdir::dac dacForScope  = dacdir::dac_for_id(dac_id);
    auto        auth_account = dacForScope.account_for_type(dacdir::AUTH);
    require_auth(auth_account);

    check(new_config.auth_threshold_high < new_config.numelected,
        "ERR::UPDATECONFIG_INVALID_AUTH_HIGH_TO_NUM_ELECTED::The auth threshold can never be satisfied with a value greater than the number of elected custodians");
    check(new_config.auth_threshold_mid <= new_config.auth_threshold_high,
        "ERR::UPDATECONFIG_INVALID_AUTH_HIGH_TO_MID_AUTH::The mid auth threshold cannot be greater than the high auth threshold.");
    check(new_config.auth_threshold_low <= new_config.auth_threshold_mid,
        "ERR::UPDATECONFIG_INVALID_AUTH_MID_TO_LOW_AUTH::The low auth threshold cannot be greater than the mid auth threshold.");

    configscontainer config_singleton(_self, dac_id.value);
    config_singleton.set(new_config, auth_account);

    contr_state currentState = contr_state::get_current_state(_self, dac_id);
    currentState.save(_self, dac_id, auth_account);
    print("Succesfully updated the daccustodian config for: ", dac_id);
}
