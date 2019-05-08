#include <eosio/eosio.hpp>
#include <eosio/multi_index.hpp>

struct [[eosio::table("custodians"), eosio::contract("daccustodian")]] custodian {
    name cust_name;
    asset requestedpay;
    uint64_t total_votes;

    uint64_t primary_key() const { return cust_name.value; }

    uint64_t by_votes_rank() const { return static_cast<uint64_t>(UINT64_MAX - total_votes); }

    uint64_t by_requested_pay() const { return static_cast<uint64_t>(requestedpay.amount); }

    EOSLIB_SERIALIZE(custodian,
                     (cust_name)(requestedpay)(total_votes))
};

typedef multi_index<"custodians"_n, custodian,
        indexed_by<"byvotesrank"_n, const_mem_fun<custodian, uint64_t, &custodian::by_votes_rank> >,
        indexed_by<"byreqpay"_n, const_mem_fun<custodian, uint64_t, &custodian::by_requested_pay> >
> custodians_table;
