#pragma once

namespace eosdac {

#include <eosio/eosio.hpp>
#include <eosio/multi_index.hpp>

    struct [[eosio::table("custodians"), eosio::contract("daccustodian")]] custodian {
        eosio::name  cust_name;
        eosio::asset requestedpay;
        uint64_t     total_votes;

        uint64_t primary_key() const {
            return cust_name.value;
        }

        uint64_t by_votes_rank() const {
            return static_cast<uint64_t>(UINT64_MAX - total_votes);
        }

        uint64_t by_requested_pay() const {
            return static_cast<uint64_t>(requestedpay.amount);
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

        uint64_t primary_key() const {
            return candidate_name.value;
        }
        uint64_t by_number_votes() const {
            return static_cast<uint64_t>(total_votes);
        }
        uint64_t by_votes_rank() const {
            return static_cast<uint64_t>(UINT64_MAX - total_votes);
        }
        uint64_t by_requested_pay() const {
            return static_cast<uint64_t>(requestedpay.amount);
        }
    };

    using candidates_table = eosio::multi_index<"candidates"_n, candidate,
        eosio::indexed_by<"bycandidate"_n, eosio::const_mem_fun<candidate, uint64_t, &candidate::primary_key>>,
        eosio::indexed_by<"byvotes"_n, eosio::const_mem_fun<candidate, uint64_t, &candidate::by_number_votes>>,
        eosio::indexed_by<"byvotesrank"_n, eosio::const_mem_fun<candidate, uint64_t, &candidate::by_votes_rank>>,
        eosio::indexed_by<"byreqpay"_n, eosio::const_mem_fun<candidate, uint64_t, &candidate::by_requested_pay>>>;

    struct [[eosio::table]] vote_weight {
        eosio::name voter;
        uint64_t    weight;

        uint64_t primary_key() const {
            return voter.value;
        }
    };
    using weights = eosio::multi_index<"weights"_n, vote_weight>;
} // namespace eosdac
