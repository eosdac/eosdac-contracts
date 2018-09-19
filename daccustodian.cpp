#include <eosiolib/eosio.hpp>
#include <eosiolib/singleton.hpp>
#include <eosiolib/asset.hpp>
#include <eosiolib/transaction.hpp>

#include <eosiolib/multi_index.hpp>
#include <eosiolib/public_key.hpp>
#include <string>
#include "daccustodian.hpp"

#include "update_member_details.cpp"
#include "registering.cpp"
#include "voting.cpp"
#include "migration.cpp"
#include "privatehelpers.cpp"
#include "newperiod_components.cpp"
#include "pay_handling.cpp"
#include "external_observable_actions.cpp"
#include "config.cpp"

using namespace eosio;
using namespace std;
using eosio::print;

void daccustodian::newperiod(string message) {

    assert_period_time();

    contr_config config = configs();

    // Get the max supply of the lockup asset token (eg. EOSDAC)
    auto tokenStats = stats(eosio::string_to_name(TOKEN_CONTRACT), config.lockupasset.symbol).begin();
    uint64_t max_supply = tokenStats->max_supply.amount;

    double percent_of_current_voter_engagement =
            double(_currentState.total_weight_of_votes) / double(max_supply) * 100.0;

    eosio::print("\n\nToken max supply: ", max_supply, " total votes so far: ", _currentState.total_weight_of_votes);
    eosio::print("\n\nNeed inital engagement of: ", config.initial_vote_quorum_percent, "% to start the DAC.");
    eosio::print("\n\nNeed ongoing engagement of: ", config.vote_quorum_percent,
                 "% to allow new periods to trigger after initial activation.");
    eosio::print("\n\nPercent of current voter engagement: ", percent_of_current_voter_engagement);

    eosio_assert(_currentState.met_initial_votes_threshold == true ||
                 percent_of_current_voter_engagement > config.initial_vote_quorum_percent,
                 "Voter engagement is insufficient to activate the DAC.");
    _currentState.met_initial_votes_threshold = true;

    eosio_assert(percent_of_current_voter_engagement > config.vote_quorum_percent,
                 "Voter engagement is insufficient to process a new period");


    // Set custodians for the next period.
    allocatecust(false);

    // Distribute pay to the current custodians.
    distributePay();

    // Set the auths on the dacauthority account
    setauths();

//        Schedule the the next election cycle at the end of the period.
//        transaction nextTrans{};
//        nextTrans.actions.emplace_back(permission_level(_self,N(active)), _self, N(newperiod), std::make_tuple("", false));
//        nextTrans.delay_sec = configs().periodlength;
//        nextTrans.send(N(newperiod), false);
}

#define EOSIO_ABI_EX(TYPE, MEMBERS) \
extern "C" { \
   void apply( uint64_t receiver, uint64_t code, uint64_t action ) { \
      if( action == N(onerror)) { \
         /* onerror is only valid if it is for the "eosio" code account and authorized by "eosio"'s "active permission */ \
         eosio_assert(code == N(eosio), "onerror action's are only valid from the \"eosio\" system account"); \
      } \
      auto self = receiver; \
      if( code == self || code == eosio::string_to_name(TOKEN_CONTRACT) ) { \
         TYPE thiscontract( self ); \
         switch( action ) { \
            EOSIO_API( TYPE, MEMBERS ) \
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
             (paypending)(claimpay)
             (transfer)
             (allocatecust)
             (stprofile)(stprofileuns)
             (migrate)

)