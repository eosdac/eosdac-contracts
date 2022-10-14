#include "../../contract-shared-headers/dacdirectory_shared.hpp"
using namespace eosdac;

ACTION daccustodian::updateconfige(const contr_config &new_config, const name &dac_id) {

    dacdir::dac dacForScope = dacdir::dac_for_id(dac_id);
#ifdef IS_DEV
    // This will be enabled later in prod instead of get_self() to allow DAO's to control this config.
    require_auth(dacForScope.owner);
#else
    require_auth(get_self());
#endif

    check(new_config.numelected <= 67,
        "ERR::UPDATECONFIG_INVALID_NUM_ELECTED::The number of elected custodians must be <= 67");
    check(new_config.maxvotes <= new_config.numelected,
        "ERR::UPDATECONFIG_INVALID_MAX_VOTES::The number of max votes must be less than the number of elected candidates.");

    // No technical reason for this other than keeping some sanity in the settings
    check(new_config.periodlength <= 3 * 365 * 24 * 60 * 60,
        "ERR::UPDATECONFIG_PERIOD_LENGTH::The period length cannot be longer than 3 years.");

    check(new_config.initial_vote_quorum_percent < 100,
        "ERR::UPDATECONFIG_INVALID_INITIAL_VOTE_QUORUM_PERCENT::The initial vote quorum percent must be less than 100 and most likely a lot less than 100 to be achievable for the DAC.");

    check(new_config.token_supply_theshold > 1000 * 10000,
        "ERR::UPDATECONFIG_INVALID_INITIAL_TOKEN_THRESHOLD::token_supply_theshold amount must be at least 1000 tokens (1000 * 10000).");

    check(new_config.vote_quorum_percent < 100,
        "ERR::UPDATECONFIG_INVALID_VOTE_QUORUM_PERCENT::The vote quorum percent must be less than 100 and most likely a lot less than 100 to be achievable for the DAC.");

    check(new_config.auth_threshold_high < new_config.numelected,
        "ERR::UPDATECONFIG_INVALID_AUTH_HIGH_TO_NUM_ELECTED::The auth threshold can never be satisfied with a value greater than the number of elected custodians");
    check(new_config.auth_threshold_mid <= new_config.auth_threshold_high,
        "ERR::UPDATECONFIG_INVALID_AUTH_HIGH_TO_MID_AUTH::The mid auth threshold cannot be greater than the high auth threshold.");
    check(new_config.auth_threshold_low <= new_config.auth_threshold_mid,
        "ERR::UPDATECONFIG_INVALID_AUTH_MID_TO_LOW_AUTH::The low auth threshold cannot be greater than the mid auth threshold.");

    if (new_config.should_pay_via_service_provider) {
        check(dacForScope.account_for_type_maybe(dacdir::SERVICE).has_value(),
            "ERR::UPDATECONFIG_NO_SERVICE_ACCOUNT should_pay_via_service_provider is true, but no SERVICE account is set.");
    }

    check(new_config.lockupasset.quantity.symbol == dacForScope.symbol.get_symbol(),
        "Symbol mismatch dac symbol is %s but symbol given is %s", dacForScope.symbol.get_symbol(),
        new_config.lockupasset.quantity.symbol);

    auto globals = dacglobals::current(get_self(), dac_id);

    globals.set_lockupasset(new_config.lockupasset);
    globals.set_maxvotes(new_config.maxvotes);
    globals.set_numelected(new_config.numelected);
    globals.set_periodlength(new_config.periodlength);
    globals.set_should_pay_via_service_provider(new_config.should_pay_via_service_provider);
    globals.set_initial_vote_quorum_percent(new_config.initial_vote_quorum_percent);
    globals.set_vote_quorum_percent(new_config.vote_quorum_percent);
    globals.set_auth_threshold_high(new_config.auth_threshold_high);
    globals.set_auth_threshold_mid(new_config.auth_threshold_mid);
    globals.set_auth_threshold_low(new_config.auth_threshold_low);
    globals.set_lockup_release_time_delay(new_config.lockup_release_time_delay);
    globals.set_requested_pay_max(new_config.requested_pay_max);
    globals.set_token_supply_theshold(new_config.token_supply_theshold);

    globals.save(get_self(), dac_id);
    print("Succesfully updated the daccustodian config for: ", dac_id);
}