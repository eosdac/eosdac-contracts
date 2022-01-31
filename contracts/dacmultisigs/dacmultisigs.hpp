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
#define MSIG_CONTRACT "msigworlds"
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

    using proposals_table = multi_index<"proposals"_n, storedproposal>;

  public:
    using contract::contract;

    ACTION proposed(name proposer, name proposal_name, string metadata, name dac_id);

    ACTION approved(name proposer, name proposal_name, name approver, name dac_id);

    ACTION unapproved(name proposer, name proposal_name, name unapprover, name dac_id);

    ACTION cancelled(name proposer, name proposal_name, name canceler, name dac_id);

    ACTION executed(name proposer, name proposal_name, name executer, name dac_id);

    ACTION clean(name proposer, name proposal_name, name dac_id);

  private:
    checksum256 get_trx_id() {
        const auto     size   = transaction_size();
        char          *buffer = (char *)malloc(size);
        const uint32_t read   = read_transaction(buffer, size);
        check(size == read, "ERR::READ_TRANSACTION_FAILED::read_transaction failed");

        return sha256(buffer, read);
    }
};
