#include <eosio/eosio.hpp>
#include <eosio/fixed_bytes.hpp>
#include <eosio/multi_index.hpp>
#include <eosio/time.hpp>
#include <eosio/transaction.hpp>

#include <eosio/crypto.hpp>

#define _STRINGIZE(x) #x
#define STRINGIZE(x) _STRINGIZE(x)

#ifdef MSIGCONTRACT
#define MSIG_CONTRACT STRINGIZE(MSIGCONTRACT)
#endif
#ifndef MSIG_CONTRACT
#define MSIG_CONTRACT "eosio.msig"
#endif

using namespace eosio;
using namespace std;

CONTRACT dacmultisigs : public contract {
  private:
    TABLE storedproposal {
        name           proposalname;
        name           proposer;
        checksum256    transactionid;
        time_point_sec modifieddate;

        uint64_t primary_key() const { return proposalname.value; }
    };

    typedef multi_index<"proposals"_n, storedproposal> proposals_table;

  public:
    using contract::contract;

    ACTION proposed(name proposer, name proposal_name, string metadata);
    ACTION proposede(name proposer, name proposal_name, string metadata, name dac_id);

    ACTION approved(name proposer, name proposal_name, name approver);
    ACTION approvede(name proposer, name proposal_name, name approver, name dac_id);

    ACTION unapproved(name proposer, name proposal_name, name unapprover);
    ACTION unapprovede(name proposer, name proposal_name, name unapprover, name dac_id);

    ACTION cancelled(name proposer, name proposal_name, name canceler);
    ACTION cancellede(name proposer, name proposal_name, name canceler, name dac_id);

    ACTION executed(name proposer, name proposal_name, name executer);
    ACTION executede(name proposer, name proposal_name, name executer, name dac_id);

    ACTION clean(name proposer, name proposal_name);
    ACTION cleane(name proposer, name proposal_name, name dac_id);
};
