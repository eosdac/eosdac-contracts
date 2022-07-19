#pragma once
#include "common_utilities.hpp"
#include "config.hpp"
#include "safemath.hpp"

namespace eosdac {

#include <eosio/eosio.hpp>
#include <eosio/multi_index.hpp>
#include <math.h>

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
} // namespace eosdac
