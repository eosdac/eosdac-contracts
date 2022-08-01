#include "../../contract-shared-headers/dacdirectory_shared.hpp"
using namespace eosdac;

ACTION daccustodian::updateconfige(dacglobals &new_config, const name &dac_id) {

    dacdir::dac dacForScope = dacdir::dac_for_id(dac_id);
    auto        owner       = dacForScope.owner;
    require_auth(owner);
    check(new_config.get_numelected() <= 67,
        "ERR::UPDATECONFIG_INVALID_NUM_ELECTED::The number of elected custodians must be <= 67");
    check(new_config.get_maxvotes() <= new_config.get_numelected(),
        "ERR::UPDATECONFIG_INVALID_MAX_VOTES::The number of max votes must be less than the number of elected candidates.");

    // No technical reason for this other than keeping some sanity in the settings
    check(new_config.get_periodlength() <= 3 * 365 * 24 * 60 * 60,
        "ERR::UPDATECONFIG_PERIOD_LENGTH::The period length cannot be longer than 3 years.");

    check(new_config.get_initial_vote_quorum_percent() < 100,
        "ERR::UPDATECONFIG_INVALID_INITIAL_VOTE_QUORUM_PERCENT::The initial vote quorum percent must be less than 100 and most likely a lot less than 100 to be achievable for the DAC.");

    check(new_config.get_vote_quorum_percent() < 100,
        "ERR::UPDATECONFIG_INVALID_VOTE_QUORUM_PERCENT::The vote quorum percent must be less than 100 and most likely a lot less than 100 to be achievable for the DAC.");

    check(new_config.get_auth_threshold_high() < new_config.get_numelected(),
        "ERR::UPDATECONFIG_INVALID_AUTH_HIGH_TO_NUM_ELECTED::The auth threshold can never be satisfied with a value greater than the number of elected custodians");
    check(new_config.get_auth_threshold_mid() <= new_config.get_auth_threshold_high(),
        "ERR::UPDATECONFIG_INVALID_AUTH_HIGH_TO_MID_AUTH::The mid auth threshold cannot be greater than the high auth threshold.");
    check(new_config.get_auth_threshold_low() <= new_config.get_auth_threshold_mid(),
        "ERR::UPDATECONFIG_INVALID_AUTH_MID_TO_LOW_AUTH::The low auth threshold cannot be greater than the mid auth threshold.");

    if (new_config.get_should_pay_via_service_provider()) {
        check(dacForScope.account_for_type_maybe(dacdir::SERVICE).has_value(),
            "ERR::UPDATECONFIG_NO_SERVICE_ACCOUNT should_pay_via_service_provider is true, but no SERVICE account is set.");
    }
    new_config.save(get_self(), dac_id);
    print("Succesfully updated the daccustodian config for: ", dac_id);
}
