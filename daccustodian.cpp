#include <eosio/eosio.hpp>
#include <eosio/singleton.hpp>
#include <eosio/asset.hpp>
#include <eosio/transaction.hpp>

#include <eosio/multi_index.hpp>
#include <eosio/crypto.hpp>
#include <string>
#include "daccustodian.hpp"

#include "update_member_details.cpp"
#include "registering.cpp"
#include "voting.cpp"
#ifdef MIGRATE
#include "migration.cpp"
#endif
#include "privatehelpers.cpp"
#include "newperiod_components.cpp"
#include "pay_handling.cpp"
#include "external_observable_actions.cpp"
#include "config.cpp"

using namespace eosio;
using namespace std;

#define EOSIO_ABI_EX(TYPE, MEMBERS) \
extern "C" { \
   void apply( uint64_t receiver, uint64_t code, uint64_t action ) { \
      if( action == "onerror"_n.value) { \
         /* onerror is only valid if it is for the "eosio" code account and authorized by "eosio"'s "active permission */ \
         check(code == "eosio"_n.value, "onerror action's are only valid from the \"eosio\" system account"); \
      } \
      auto self = receiver; \
      if( (code == self  && action != "transfer"_n.value) || (code == name(TOKEN_CONTRACT).value && action == "transfer"_n.value) ) { \
         switch( action ) { \
            EOSIO_DISPATCH_HELPER( TYPE, MEMBERS ) \
         } \
         /* does not allow destructor of thiscontract to run: eosio_exit(0); */ \
      } \
   } \
}

EOSIO_ABI_EX(daccustodian,
             (updateconfig)
             (nominatecand)(withdrawcand)(firecand)(resigncust)(firecust)(unstake)
             (updatebio)(updatereqpay)
             (votecust)/*(voteproxy)*/
             (newperiod)
             (claimpay)
             (transfer)
             (stprofile)(stprofileuns)
#ifdef MIGRATE
             (migrate)
#endif
)
