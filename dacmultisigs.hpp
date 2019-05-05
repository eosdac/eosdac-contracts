#include <eosiolib/eosio.hpp>
#include <eosiolib/multi_index.hpp>
#include <eosiolib/eosio.hpp>
#include <eosiolib/transaction.hpp>
#include <eosiolib/fixed_bytes.hpp>

using namespace eosio;
using namespace std;


CONTRACT dacmultisigs : public contract {

    private:

        TABLE storedproposal {
            name proposalname;
            checksum256 transactionid;
            uint32_t modifieddate;

            uint64_t primary_key() const { return proposalname.value; }

            EOSLIB_SERIALIZE(
                storedproposal,
                    (proposalname)
                    (transactionid)
                    (modifieddate)
            )
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
