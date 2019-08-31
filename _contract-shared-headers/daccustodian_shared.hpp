#ifndef DACCUSTODIAN_SHARED_H
#define DACCUSTODIAN_SHARED_H

#include <eosio/eosio.hpp>
#include <eosio/multi_index.hpp>
#include <eosio/time.hpp>
#include <eosio/asset.hpp>


namespace eosdac {


    struct newperiod_notify {
        std::string                msg;
        eosio::time_point_sec last_time;
        eosio::time_point_sec current_time;
    };
    struct vote_notify {
        eosio::name         voter;
        std::vector<eosio::name> new_votes;
        std::vector<eosio::name> old_votes;
    };

    struct [[eosio::table("notifys"), eosio::contract("daccustodian")]] notify_item {
        uint64_t          key;      // unique identifier
        eosio::name       type;     // The action received (newperiod, vote etc)
        eosio::name       contract; // the contract to notify
        eosio::name       action;   // the action to notify

        uint64_t primary_key() const { return key; }

        uint64_t by_type() const { return action.value; }
    };

    typedef eosio::multi_index<"notifys"_n, notify_item,
            eosio::indexed_by<"bytype"_n, eosio::const_mem_fun<notify_item, uint64_t, &notify_item::by_type> >
    > notifys_table;



    struct contr_config;
    typedef eosio::singleton<"config2"_n, contr_config> configscontainer;

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

        // Amount of token value in votes required to trigger the allow a new set of custodians to be set after the initial threshold has been achieved.
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

        void save(eosio::name account, eosio::name scope, eosio::name payer = eosio::same_payer) {
            configscontainer(account, scope.value).set(*this, payer);
        }
    };


    struct [[eosio::table("custodians"), eosio::contract("daccustodian")]] custodian {
        eosio::name cust_name;
        eosio::asset requestedpay;
        uint64_t total_votes;

        uint64_t primary_key() const { return cust_name.value; }

        uint64_t by_votes_rank() const { return static_cast<uint64_t>(UINT64_MAX - total_votes); }

        uint64_t by_requested_pay() const { return static_cast<uint64_t>(requestedpay.amount); }
    };

    typedef eosio::multi_index<"custodians"_n, custodian,
            eosio::indexed_by<"byvotesrank"_n, eosio::const_mem_fun<custodian, uint64_t, &custodian::by_votes_rank> >,
            eosio::indexed_by<"byreqpay"_n, eosio::const_mem_fun<custodian, uint64_t, &custodian::by_requested_pay> >
    > custodians_table;

    struct [[eosio::table("candidates"), eosio::contract("daccustodian")]] candidate {
        eosio::name candidate_name;
        eosio::asset requestedpay;
        eosio::asset locked_tokens;
        uint64_t total_votes;
        uint8_t is_active;
        eosio::time_point_sec custodian_end_time_stamp;

        uint64_t primary_key() const { return candidate_name.value; }
        uint64_t by_number_votes() const { return static_cast<uint64_t>(total_votes); }
        uint64_t by_votes_rank() const { return static_cast<uint64_t>(UINT64_MAX - total_votes); }
        uint64_t by_requested_pay() const { return static_cast<uint64_t>(requestedpay.amount); }
    };

    typedef eosio::multi_index<"candidates"_n, candidate,
            eosio::indexed_by<"bycandidate"_n, eosio::const_mem_fun<candidate, uint64_t, &candidate::primary_key> >,
            eosio::indexed_by<"byvotes"_n, eosio::const_mem_fun<candidate, uint64_t, &candidate::by_number_votes> >,
            eosio::indexed_by<"byvotesrank"_n, eosio::const_mem_fun<candidate, uint64_t, &candidate::by_votes_rank> >,
            eosio::indexed_by<"byreqpay"_n, eosio::const_mem_fun<candidate, uint64_t, &candidate::by_requested_pay> >
    > candidates_table;
}

#endif
