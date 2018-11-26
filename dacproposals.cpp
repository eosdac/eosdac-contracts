#include <eosiolib/eosio.hpp>
#include "dacproposals.hpp"
#include <typeinfo>

#include <string>

using namespace eosio;
using namespace std;

    ACTION dacproposals::createprop(name proposer, string title, string summary, string desc, name arbitrator, asset payamount, string contenthash){

    }

    ACTION dacproposals::voteprop(name custodian, uint32_t proposal, uint8_t vote){

    }

    ACTION dacproposals::claim(name worker, uint64_t proposalid){

    }

    ACTION dacproposals::cancel(name
worker,
uint64_t proposalid
){

}

EOSIO_DISPATCH(dacproposals,
                (createprop)
                (voteprop)
                (claim)
                (cancel)
        )
