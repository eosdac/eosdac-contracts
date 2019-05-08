#include <eosio/multi_index.hpp>

using namespace eosio;

struct msig_proposal {
   name                            proposal_name;
   std::vector<char>               packed_transaction;

   uint64_t primary_key()const { return proposal_name.value; }
};

typedef multi_index< "proposal"_n, msig_proposal > msig_proposals_table;
