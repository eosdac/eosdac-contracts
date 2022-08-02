#pragma once

#include <eosio/eosio.hpp>
#include <eosio/multi_index.hpp>
#include <eosio/permission.hpp>
#include <eosio/singleton.hpp>
#include <eosio/time.hpp>

#include "../../contract-shared-headers/common_utilities.hpp"
#include "../../contract-shared-headers/config.hpp"
#include "../../contract-shared-headers/daccustodian_shared.hpp"
#include "../../contract-shared-headers/eosdactokens_shared.hpp"
#include "../../contract-shared-headers/safemath.hpp"
#include "external_types.hpp"

using namespace std;

/**
 * simple getter/setter
 **/
#define PROPERTY(type, name)                                                                                           \
    type get_##name() const {                                                                                          \
        return get<type>(state_keys::name);                                                                            \
    }                                                                                                                  \
    void set_##name(const type value) {                                                                                \
        set(state_keys::name, value);                                                                                  \
    }

/**
 * A slightly more complicated getter/setter macro that allows optional values.
 * If value is not set, it returns a null optional. To unset a previously set
 * value, it has an unset function.
 * Since our variant can only hold certain number types, we sometimes need to
 * convert our desired type to a storage_type. Before storing, it will convert
 * the value to the storage_type and before returning, the getter will
 * automatically convert back to type.
 **/
#define PROPERTY_OPTIONAL_TYPECASTING(type, storage_type, name)                                                        \
    std::optional<type> get_##name() const {                                                                           \
        return get_maybe<storage_type>(state_keys::name);                                                              \
    }                                                                                                                  \
    void set_##name(const type value) {                                                                                \
        set(state_keys::name, storage_type(value));                                                                    \
    }                                                                                                                  \
    void unset_##name() {                                                                                              \
        const auto search = data.find(state_keys::name);                                                               \
        check(search != data.end(), "Cannot unset " #name ", no value set");                                           \
        data.erase(state_keys::name);                                                                                  \
    }

/**
 * simple getter/setter
 **/
#define PROPERTY2(type, name)                                                                                          \
    type get_##name() const {                                                                                          \
        return get<type>(#name);                                                                                       \
    }                                                                                                                  \
    auto set_##name(const type &value) {                                                                               \
        return set(#name, value);                                                                                      \
    }

/**
 * A slightly more complicated getter/setter macro that allows optional values.
 * If value is not set, it returns a null optional. To unset a previously set
 * value, it has an unset function.
 * Since our variant can only hold certain number types, we sometimes need to
 * convert our desired type to a storage_type. Before storing, it will convert
 * the value to the storage_type and before returning, the getter will
 * automatically convert back to type.
 **/
#define PROPERTY_OPTIONAL_TYPECASTING2(type, storage_type, name)                                                       \
    std::optional<type> maybe_get_##name() const {                                                                     \
        return get_maybe<storage_type>(#name);                                                                         \
    }                                                                                                                  \
    void set_##name(const type &value) {                                                                               \
        set(#name, static_cast<storage_type>(value));                                                                  \
    }                                                                                                                  \
    void unset_##name() {                                                                                              \
        const auto search = data.find(#name);                                                                          \
        check(search != data.end(), "Cannot unset " #name ", no value set");                                           \
        data.erase(#name);                                                                                             \
    }

namespace eosdac {

    static constexpr eosio::name ONE_PERMISSION    = "one"_n;
    static constexpr eosio::name LOW_PERMISSION    = "low"_n;
    static constexpr eosio::name MEDIUM_PERMISSION = "med"_n;
    static constexpr eosio::name HIGH_PERMISSION   = "high"_n;

#ifndef TRANSFER_DELAY
#define TRANSFER_DELAY 60 * 60
#endif
    struct [[eosio::table("custodians"), eosio::contract("daccustodian")]] custodian {
        eosio::name  cust_name;
        eosio::asset requestedpay;
        uint64_t     total_votes;

        uint64_t primary_key() const {
            return cust_name.value;
        }

        uint64_t by_votes_rank() const {
            return UINT64_MAX - total_votes;
        }

        uint64_t by_requested_pay() const {
            return S{requestedpay.amount}.to<uint64_t>();
        }
    };

    using custodians_table = eosio::multi_index<"custodians"_n, custodian,
        eosio::indexed_by<"byvotesrank"_n, eosio::const_mem_fun<custodian, uint64_t, &custodian::by_votes_rank>>,
        eosio::indexed_by<"byreqpay"_n, eosio::const_mem_fun<custodian, uint64_t, &custodian::by_requested_pay>>>;

    struct [[eosio::table("candidates"), eosio::contract("daccustodian")]] candidate {
        eosio::name           candidate_name;
        eosio::asset          requestedpay;
        eosio::asset          locked_tokens;
        uint64_t              total_votes;
        uint8_t               is_active;
        eosio::time_point_sec custodian_end_time_stamp;
        eosio::time_point_sec avg_vote_time_stamp;

        uint64_t by_decayed_votes() const {
            // log(0) is -infinity, so we always add 1. This does not change the order of the index.
            const auto log_arg = S{total_votes} + S{1ull};
            const auto log     = log2(log_arg.to<double>());
            const auto x =
                S{log} + S{avg_vote_time_stamp.sec_since_epoch()}.to<double>() / S{SECONDS_TO_DOUBLE}.to<double>();
            check(x >= double{}, "by_decayed_votes x must be >= 0 before uint64_t conversion");
            const auto x_rounded_down = narrow_cast<uint64_t>(x);
            return S{UINT64_MAX} - S{x_rounded_down};
        }
        uint64_t primary_key() const {
            return candidate_name.value;
        }
        uint64_t by_number_votes() const {
            return total_votes;
        }
        uint64_t by_votes_rank() const {
            return S{UINT64_MAX} - S{total_votes};
        }
        uint64_t by_requested_pay() const {
            return S{requestedpay.amount}.to<uint64_t>();
        }
    };

    using candidates_table = eosio::multi_index<"candidates"_n, candidate,
        eosio::indexed_by<"bycandidate"_n, eosio::const_mem_fun<candidate, uint64_t, &candidate::primary_key>>,
        eosio::indexed_by<"byvotes"_n, eosio::const_mem_fun<candidate, uint64_t, &candidate::by_number_votes>>,
        eosio::indexed_by<"byvotesrank"_n, eosio::const_mem_fun<candidate, uint64_t, &candidate::by_votes_rank>>,
        eosio::indexed_by<"byreqpay"_n, eosio::const_mem_fun<candidate, uint64_t, &candidate::by_requested_pay>>,
        eosio::indexed_by<"bydecayed"_n, eosio::const_mem_fun<candidate, uint64_t, &candidate::by_decayed_votes>>>;

    struct [[eosio::table]] vote_weight {
        eosio::name voter;
        uint64_t    weight;
        uint64_t    weight_quorum;

        uint64_t primary_key() const {
            return voter.value;
        }
    };
    using weights = eosio::multi_index<"weights"_n, vote_weight>;

    struct contr_config;
    using configscontainer = eosio::singleton<"config2"_n, contr_config>;

    struct [[eosio::table("config2"), eosio::contract("daccustodian")]] contr_config {
        //    The amount of assets that are locked up by each candidate applying for election.
        eosio::extended_asset lockupasset;
        //    The maximum number of votes that each member can make for a candidate.
        uint8_t maxvotes = 5;
        //    Number of custodians to be elected for each election count.
        uint8_t numelected = 3;
        //    Length of a period in seconds.
        //     - used for pay calculations if an eary election is called and to trigger deferred `newperiod` calls.
        uint32_t periodlength = 7 * 24 * 60 * 60;

        // The contract will direct all payments via the service provider.
        bool should_pay_via_service_provider;

        // Amount of token value in votes required to trigger the initial set of custodians
        uint32_t initial_vote_quorum_percent;

        // Amount of token value in votes required to trigger the allow a new set of custodians to be set after the
        // initial threshold has been achieved.
        uint32_t vote_quorum_percent;

        // required number of custodians required to approve different levels of authenticated actions.
        uint8_t auth_threshold_high;
        uint8_t auth_threshold_mid;
        uint8_t auth_threshold_low;

        // The time before locked up stake can be released back to the candidate using the unstake action
        uint32_t lockup_release_time_delay;

        eosio::extended_asset requested_pay_max;

        static contr_config get_current_configs(eosio::name account, eosio::name scope) {
            return configscontainer(account, scope.value).get_or_default(contr_config());
        }

        void save(eosio::name account, eosio::name scope, eosio::name payer = same_payer) {
            configscontainer(account, scope.value).set(*this, payer);
        }
    };

    struct contr_state2;
    using statecontainer2 = eosio::singleton<"state2"_n, contr_state2>;

    enum state_keys : uint8_t {
        total_weight_of_votes       = 1,
        total_votes_on_candidates   = 2,
        number_active_candidates    = 3,
        met_initial_votes_threshold = 4,
        lastclaimbudgettime         = 5,
        budget_percentage           = 6
    };
    using state_value_variant =
        std::variant<uint32_t, uint64_t, int64_t, bool, std::vector<int64_t>, name, std::string, eosio::time_point_sec>;

    struct [[eosio::table("state2"), eosio::contract("daccustodian")]] contr_state2 {
        eosio::time_point_sec                  lastperiodtime = time_point_sec(0);
        std::map<uint8_t, state_value_variant> data           = {
            {state_keys::total_weight_of_votes, int64_t(0)},
            {state_keys::total_votes_on_candidates, int64_t(0)},
            {state_keys::number_active_candidates, uint32_t(0)},
            {state_keys::met_initial_votes_threshold, false},
            {state_keys::lastclaimbudgettime, time_point_sec(0)},
        };

        static contr_state2 get_current_state(const eosio::name account, const eosio::name scope) {
            return statecontainer2(account, scope.value).get_or_default(contr_state2{});
        }

        void save(const eosio::name account, const eosio::name scope) {
            statecontainer2(account, scope.value).set(*this, account);
        }

        void set(const state_keys key, const state_value_variant &value) {
            data[key] = value;
        }

        template <typename T>
        T get(const state_keys key) const {
            const auto search = data.find(key);
            check(search != data.end(), "Key %s not found in state data", std::to_string(key));
            return std::get<T>(search->second);
        }

        template <typename T>
        std::optional<T> get_maybe(const state_keys key) const {
            const auto search = data.find(key);
            if (search != data.end()) {
                return std::get<T>(search->second);
            } else {
                return {};
            }
        }

        /**
         * What follows are type-safe getters/setters for polymorphic map values
         **/

        PROPERTY_OPTIONAL_TYPECASTING(uint16_t, uint32_t, budget_percentage);
        PROPERTY(time_point_sec, lastclaimbudgettime);
        PROPERTY(int64_t, total_weight_of_votes);
        PROPERTY(bool, met_initial_votes_threshold);
        PROPERTY(uint32_t, number_active_candidates);
        PROPERTY(int64_t, total_votes_on_candidates);
    };

    struct [[eosio::table("votes"), eosio::contract("daccustodian")]] vote {
        name                  voter;
        name                  proxy;
        std::vector<name>     candidates;
        eosio::time_point_sec vote_time_stamp;

        uint64_t primary_key() const {
            return voter.value;
        }

        uint64_t by_proxy() const {
            return proxy.value;
        }
    };

    using votes_table =
        eosio::multi_index<"votes"_n, vote, indexed_by<"byproxy"_n, const_mem_fun<vote, uint64_t, &vote::by_proxy>>>;

    struct [[eosio::table("proxies"), eosio::contract("daccustodian")]] proxy {
        name    proxy;
        int64_t total_weight;

        uint64_t primary_key() const {
            return proxy.value;
        }
    };

    using proxies_table = eosio::multi_index<"proxies"_n, proxy>;

    struct [[eosio::table("pendingpay"), eosio::contract("daccustodian")]] pay {
        uint64_t       key;
        name           receiver;
        extended_asset quantity;

        static checksum256 getIndex(const name &receiver, const extended_symbol &symbol) {
            return combine_ids(receiver.value, symbol.get_contract().value, symbol.get_symbol().code().raw(), 0);
        }

        uint64_t primary_key() const {
            return key;
        }
        uint64_t byreceiver() const {
            return receiver.value;
        }
        checksum256 byreceiver_and_symbol() const {
            return getIndex(receiver, quantity.get_extended_symbol());
        }

        EOSLIB_SERIALIZE(pay, (key)(receiver)(quantity))
    };

    using pending_pay_table =
        multi_index<"pendingpay"_n, pay, indexed_by<"byreceiver"_n, const_mem_fun<pay, uint64_t, &pay::byreceiver>>,
            indexed_by<"receiversym"_n, const_mem_fun<pay, checksum256, &pay::byreceiver_and_symbol>>>;

    struct [[eosio::table("candperms"), eosio::contract("daccustodian")]] candperm {
        name cand;
        name permission;

        uint64_t primary_key() const {
            return cand.value;
        }
    };

    using candperms_table = multi_index<"candperms"_n, candperm>;

    using state_value_variant2 =
        std::variant<int8_t, uint8_t, int32_t, uint32_t, int64_t, uint64_t, int128_t, uint128_t, bool,
            std::vector<int64_t>, eosio::name, std::string, eosio::time_point_sec, eosio::asset, eosio::extended_asset>;

    struct dacglobals;
    using dacglobals_singleton = eosio::singleton<"dacglobals"_n, dacglobals>;
    struct [[eosio::table("dacglobals"), eosio::contract("daccustodian")]] dacglobals {
      private:
        auto set(std::string && key, const state_value_variant2 &value) {
            return data.insert_or_assign(std::forward<std::string>(key), value);
        }

        template <typename T>
        T get(const std::string &key) const {
            const auto search = data.find(key);
            check(search != data.end(), "Key %s not found in dacglobals data", key);
            return std::get<T>(search->second);
        }

        template <typename T>
        std::optional<T> get_maybe(const std::string &key) const {
            const auto search = data.find(key);
            if (search != data.end()) {
                return std::get<T>(search->second);
            } else {
                return {};
            }
        }

      public:
        std::map<std::string, state_value_variant2> data = {};

        static dacglobals current(const eosio::name account, const eosio::name scope) {
            return dacglobals_singleton(account, scope.value).get_or_default(get_migrated_state(account, scope));
        }

        void save(const eosio::name account, const eosio::name scope) {
            dacglobals_singleton(account, scope.value).set(*this, account);
            configscontainer(account, scope.value).remove();
            statecontainer2(account, scope.value).remove();
        }
        /**
         * What follows are type-safe getters/setters for polymorphic map values
         **/

        PROPERTY_OPTIONAL_TYPECASTING2(uint16_t, uint32_t, budget_percentage);
        PROPERTY2(time_point_sec, lastclaimbudgettime);
        PROPERTY2(int64_t, total_weight_of_votes);
        PROPERTY2(bool, met_initial_votes_threshold);
        PROPERTY2(uint32_t, number_active_candidates);
        PROPERTY2(int64_t, total_votes_on_candidates);
        PROPERTY2(eosio::time_point_sec, lastperiodtime);

        // from config2
        PROPERTY2(eosio::extended_asset, lockupasset);
        PROPERTY2(uint8_t, maxvotes);
        PROPERTY2(uint8_t, numelected);
        PROPERTY2(uint32_t, periodlength);
        PROPERTY2(bool, should_pay_via_service_provider);
        PROPERTY2(uint32_t, initial_vote_quorum_percent);
        PROPERTY2(uint32_t, vote_quorum_percent);
        PROPERTY2(uint8_t, auth_threshold_high);
        PROPERTY2(uint8_t, auth_threshold_mid);
        PROPERTY2(uint8_t, auth_threshold_low);
        PROPERTY2(uint32_t, lockup_release_time_delay);
        PROPERTY2(eosio::extended_asset, requested_pay_max);

        static dacglobals get_migrated_state(const eosio::name account, const eosio::name dac_id) {
            auto new_state = dacglobals{};

            // migrate from state2
            const auto state_2 = contr_state2::get_current_state(account, dac_id);
            const auto p       = state_2.get_budget_percentage();
            if (p) {
                new_state.set_budget_percentage(*p);
            }
            new_state.set_lastclaimbudgettime(state_2.get_lastclaimbudgettime());
            new_state.set_total_weight_of_votes(state_2.get_total_weight_of_votes());
            new_state.set_met_initial_votes_threshold(state_2.get_met_initial_votes_threshold());
            new_state.set_number_active_candidates(state_2.get_number_active_candidates());
            new_state.set_total_votes_on_candidates(state_2.get_total_votes_on_candidates());
            new_state.set_lastperiodtime(state_2.lastperiodtime);

            // migrate from config2
            const auto config_2 = contr_config::get_current_configs(account, dac_id);
            new_state.set_lockupasset(config_2.lockupasset);
            new_state.set_maxvotes(config_2.maxvotes);
            new_state.set_numelected(config_2.numelected);
            new_state.set_periodlength(config_2.periodlength);
            new_state.set_should_pay_via_service_provider(config_2.should_pay_via_service_provider);
            new_state.set_initial_vote_quorum_percent(config_2.initial_vote_quorum_percent);
            new_state.set_vote_quorum_percent(config_2.vote_quorum_percent);
            new_state.set_auth_threshold_high(config_2.auth_threshold_high);
            new_state.set_auth_threshold_mid(config_2.auth_threshold_mid);
            new_state.set_auth_threshold_low(config_2.auth_threshold_low);
            new_state.set_lockup_release_time_delay(config_2.lockup_release_time_delay);
            new_state.set_requested_pay_max(config_2.requested_pay_max);

            return new_state;
        }
    };

    class daccustodian : public contract {

      public:
        daccustodian(name s, name code, datastream<const char *> ds) : contract(s, code, ds) {}

        ACTION updateconfige(const contr_config &new_config, const name &dac_id);
        // ACTION transferobsv(name from, name to, asset quantity, name dac_id);
        ACTION balanceobsv(const vector<account_balance_delta> &account_balance_deltas, const name &dac_id);
        ACTION stakeobsv(const vector<account_stake_delta> &account_stake_deltas, const name &dac_id);
        ACTION weightobsv(const vector<account_weight_delta> &account_weight_deltas, const name &dac_id);

        ACTION nominatecane(const name &cand, const eosio::asset &requestedpay, const name &dac_id);
        ACTION withdrawcane(const name &cand, const name &dac_id);
        ACTION firecand(const name &cand, const bool lockupStake, const name &dac_id);
        ACTION resigncust(const name &cust, const name &dac_id);
        ACTION firecust(const name &cust, const name &dac_id);
        ACTION appointcust(const vector<name> &cust, const name &dac_id);
        ACTION updatebio(const name &cand, const std::string &bio, const name &dac_id);

        [[eosio::action]] inline void stprofile(const name &cand, const std::string &profile, const name &dac_id) {
            require_auth(cand);
        };

        [[eosio::action]] inline void stprofileuns(const name &cand, const std::string &profile) {
            require_auth(cand);
        };
        ACTION updatereqpay(const name &cand, const eosio::asset &requestedpay, const name &dac_id);
        ACTION votecust(const name &voter, const std::vector<name> &newvotes, const name &dac_id);
        ACTION voteproxy(const name &voter, const name &proxy, const name &dac_id);
        ACTION regproxy(const name &proxy, const name &dac_id);
        ACTION unregproxy(const name &proxy, const name &dac_id);
        ACTION newperiod(const std::string &message, const name &dac_id);
        ACTION runnewperiod(const std::string &message, const name &dac_id);
        ACTION claimpay(const uint64_t payid, const name &dac_id);
        ACTION removecuspay(const uint64_t payid, const name &dac_id);
        ACTION rejectcuspay(const uint64_t payid, const name &dac_id);
        ACTION paycpu(const name &dac_id);
        ACTION claimbudget(const name &dac_id);
        ACTION migratestate(const name &dac_id);
        ACTION setbudget(const name &dac_id, const uint16_t percentage);
        ACTION unsetbudget(const name &dac_id);
#ifdef DEBUG
        ACTION resetvotes(const name &voter, const name &dac_id);
        ACTION resetcands(const name &dac_id);
        ACTION resetstate(const name &dac_id);

#endif

#ifdef IS_DEV
        ACTION fillstate(const name &dac_id);
#endif
        /**
         * This action is used to register a custom permission that will be used in the multisig instead of active.
         *
         * ### Assertions:
         * - The account supplied to cand exists and is a registered candidate
         * - The permission supplied exists as a permission on the account
         *
         * @param cand - The account id for the candidate setting a custom permission.
         * @param permission - The permission name to use.
         *
         *
         * ### Post Condition:
         * The candidate will have a record entered into the database indicating the custom permission to use.
         */
        ACTION setperm(const name &cand, const name &permission, const name &dac_id);

      private: // Private helper methods used by other actions.
        void updateVoteWeight(
            name custodian, const time_point_sec vote_time_stamp, int64_t weight, name dac_id, bool from_voting);
        void updateVoteWeights(const vector<name> &votes, const time_point_sec vote_time_stamp, int64_t vote_weight,
            name internal_dac_id, bool from_voting);
        std::pair<int64_t, int64_t> get_vote_weight(name voter, name dac_id);
        void                        modifyVoteWeights(const account_weight_delta &awd, const vector<name> &oldVotes,
                                   const std::optional<time_point_sec> &oldVoteTimestamp, const vector<name> &newVotes, const name dac_id,
                                   const bool from_voting);
        void modifyProxiesWeight(int64_t vote_weight, name oldProxy, name newProxy, name dac_id, bool from_voting);
        void assertPeriodTime(const dacglobals &globals);
        void distributeMeanPay(name internal_dac_id);
        vector<eosiosystem::permission_level_weight> get_perm_level_weights(
            const custodians_table &custodians, const name &dac_id);
        void add_all_auths(const name &accountToChange, const vector<eosiosystem::permission_level_weight> &weights,
            const name &dac_id, const bool msig = false);
        void add_all_auths_msig(
            const name &accountToChange, vector<eosiosystem::permission_level_weight> &weights, const name &dac_id);
        void add_auth_to_account(const name &accountToChange, const uint8_t threshold, const name &permission,
            const name &parent, vector<eosiosystem::permission_level_weight> weights, const bool msig = false);
        void setMsigAuths(name dac_id);
        void transferCustodianBudget(const dacdir::dac &dac);
        void removeCustodian(name cust, name internal_dac_id);
        void removeCandidate(name cust, bool lockupStake, name internal_dac_id);
        void allocateCustodians(bool early_election, name internal_dac_id);
        bool permissionExists(name account, name permission);
        bool _check_transaction_authorization(const char *trx_data, uint32_t trx_size, const char *pubkeys_data,
            uint32_t pubkeys_size, const char *perms_data, uint32_t perms_size);

        permission_level getCandidatePermission(name account, name internal_dac_id);
        void             validateUnstake(name code, name cand, name dac_id);
        void validateUnstakeAmount(const name &code, const name &cand, const asset &unstake_amount, const name &dac_id);
        void validateMinStake(name account, name dac_id);
        uint16_t       get_budget_percentage(const name &dac_id, const dacglobals &globals);
        time_point_sec calculate_avg_vote_time_stamp(const time_point_sec vote_time_before,
            const time_point_sec vote_time_stamp, const int64_t weight, const uint64_t total_votes);
    };
}; // namespace eosdac
