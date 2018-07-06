#include <eosiolib/eosio.hpp>
#include <eosiolib/asset.hpp>
#include "dacproposals.hpp"
#include <typeinfo>

#include <string>

using namespace eosio;
using namespace std;

// @abi table proposals
struct proposal {
    uint64_t id;

    EOSLIB_SERIALIZE(proposal, (id))
};

// @abi table propvotes
struct proposalvote {
    uint64_t propid;
    name voter;
    uint8_t vote; // enum
    string commenthash;

    uint64_t primary_key() const { return propid; }

    EOSLIB_SERIALIZE(proposalvote, (propid)(voter)(vote)(commenthash))
};

// @abi table votes
struct vote {
    name voter;
    name proxy;
    asset stake;

    account_name primary_key()const { return voter; }

    EOSLIB_SERIALIZE(vote, (voter)(stake)(proxy))
};

class dacproposals : public contract {

private:


public:

    dacproposals(account_name self)
            : contract(self) {}

    void
    createprop(name cand, string title, string summary, string desc, uint8_t duedate, name arbitrator, asset payamount,
               uint64_t parentid, uint8_t recurring, uint8_t complete) {
        print("createprop...");
    }

    void voteprop(name cand, uint8_t proposal, uint8_t vote) {
        print("voteprop...");
    }

    void newperiod(name privaccount) {
        print("newperiod...");
    }

    void claim(name worker, uint64_t proposalid) {
        print("claim...");
    }

    void cancel(name worker, uint64_t proposalid) {
        print("cancel...");
    }
};

EOSIO_ABI(dacproposals, (createprop)(voteprop)(newperiod)(claim)(cancel))
