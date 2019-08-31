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
