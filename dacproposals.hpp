#include <eosiolib/multi_index.hpp>
#include <eosiolib/eosio.hpp>
#include <eosiolib/asset.hpp> 

using namespace eosio;
using namespace std;

CONTRACT dacproposals : public contract {

public:

    dacproposals( name receiver, name code, datastream<const char*> ds )
         : contract(receiver, code, ds), proposals(receiver, receiver.value) {}

    ACTION createprop(name proposer, string title, string summary, string desc, name arbitrator, asset payamount, string contenthash);
    ACTION voteprop(name custodian, uint32_t proposal, uint8_t vote);
    ACTION claim(name worker, uint64_t proposalid);
    ACTION cancel(name worker, uint64_t proposalid);

private:

    TABLE proposal {
    uint32_t propid;
    name proposer;
    name arbitrator;
    string contenthash; 
    asset payamount;

        uint64_t primary_key() const { return propid; }
        uint64_t proposer_key() const { return proposer.value; }

};

typedef eosio::multi_index<"proposals"_n, indexed_by<"proposer"_n, eosio::const_mem_fun<proposal, uint64_t, &proposal::proposer_key>>> proposal_table;

proposal_table proposals;


TABLE proposalvote {
    uint64_t propid;
    name voter;
    uint8_t vote; // enum
    string commenthash;

    uint64_t primary_key() const { return propid; }
};

TABLE vote {
    name voter;
    name proxy;
    asset stake;

    name primary_key()const { return voter; }
};

};
