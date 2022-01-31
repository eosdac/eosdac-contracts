#include <eosio/multi_index.hpp>

using namespace eosio;

enum PropState { PENDING = 0, EXECUTED = 1, CANCELLED = 2 };

struct [[eosio::table("proposals"), eosio::contract("msigworlds")]] proposal {
    name                               proposal_name;
    name                               proposer;
    std::vector<char>                  packed_transaction;
    std::optional<time_point>          earliest_exec_time;
    time_point_sec                     modified_date;
    uint8_t                            state = PropState::PENDING;
    std::map<std::string, std::string> metadata;

    uint64_t primary_key() const { return proposal_name.value; }
    uint64_t by_propser() const { return proposer.value; }
    uint64_t by_mod_date() const { return modified_date.utc_seconds; }
};
typedef eosio::multi_index<"proposals"_n, proposal,
    indexed_by<"proposer"_n, const_mem_fun<proposal, uint64_t, &proposal::by_propser>>,
    indexed_by<"moddata"_n, const_mem_fun<proposal, uint64_t, &proposal::by_mod_date>>>
    msig_proposals_table;