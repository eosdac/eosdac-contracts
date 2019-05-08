#include <eosio/eosio.hpp>
#include <eosio/multi_index.hpp>
#include <eosio/eosio.hpp>
#include <eosio/transaction.hpp>
#include <eosio/fixed_bytes.hpp>
#include <eosio/time.hpp>

#include <eosio/crypto.hpp>

using namespace eosio;
using namespace std;

class [[eosio::contract("dacmultisigs")]] dacmultisigs : public contract {

    private:

        struct [[eosio::table]] storedproposal {
            name proposalname;
            checksum256 transactionid;
            time_point_sec modifieddate;

            uint64_t primary_key() const { return proposalname.value; }
        };
        
        typedef multi_index<"proposals"_n, storedproposal> proposals_table;

    public:

        using contract::contract;

        ACTION proposed(name proposer, name proposal_name, string metadata);

        ACTION approved( name proposer, name proposal_name, name approver );

        ACTION unapproved( name proposer, name proposal_name, name unapprover );

        ACTION cancelled( name proposer, name proposal_name, name canceler );

        ACTION executed( name proposer, name proposal_name, name executer );

        ACTION clean( name proposer, name proposal_name );
};
