#include <eosiolib/eosio.hpp>
#include <eosiolib/multi_index.hpp>
#include <eosiolib/eosio.hpp>

using namespace eosio;
using namespace std;

// @abi table proposals
struct storedproposal {
    account_name proposalname;
    checksum256 transactionid;

    uint64_t primary_key() const { return proposalname; }

    EOSLIB_SERIALIZE(storedproposal, (proposalname)(transactionid)
    )
};

typedef multi_index<N(proposals), storedproposal> proposals_table;

class dacmultisigs : public contract {

private:

public:

    dacmultisigs(account_name self) : contract(self) {}

    void stproposal(account_name proposer, name proposalname, string metadata);

    void stinproposal();

    void approve( account_name proposer, name proposal_name, permission_level level );

    void unapprove( account_name proposer, name proposal_name, permission_level level );

    void cancel( account_name proposer, name proposal_name, account_name canceler );

    void exec( account_name proposer, name proposal_name, account_name executer );
};
