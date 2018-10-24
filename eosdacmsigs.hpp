#include <eosiolib/eosio.hpp>
#include <eosiolib/multi_index.hpp>
#include <eosiolib/eosio.hpp>

using namespace eosio;
using namespace std;

// @abi table proposals
struct [[eosio::table]] proposal {
    uint64_t proposalid;
    std::string transactionid;
    eosio::name proposer;
    name proposalname;

    uint64_t primary_key() const { return proposalid; }
    eosio::name by_proposer() const { return proposer; }

    EOSLIB_SERIALIZE(proposal, (proposalid)(transactionid)(proposer)(proposalname)
    )
};

typedef multi_index<N(proposals), proposal
//        indexed_by < N(byproposer), const_mem_fun < proposal, eosio::name, &proposal::by_proposer> >
>
proposals_table;

class eosdacmsigs : public contract {

private:

public:

    eosdacmsigs(account_name self) : contract(self) {}

    [[eosio::action]]
    void stproposal(string transactionid, name proposer, name proposalname);

//    void voteprop(name custodian, uint32_t proposal, uint8_t vote);
//    void claim(name worker, uint64_t proposalid);
//    void cancel(name worker, uint64_t proposalid);
};
