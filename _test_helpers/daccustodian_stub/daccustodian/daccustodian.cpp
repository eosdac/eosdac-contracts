#include <eosio/eosio.hpp>
#include <eosio/transaction.hpp>
// #include <eosio/public_key.hpp>
#include "daccustodian.hpp"

using namespace eosio;
using namespace std;

void daccustodian::updatecust(std::vector<name> custodians) {
   //Fill up custodians
   custodians_table cust_table(_self, _self.value);
    for (auto it = custodians.begin(); it != custodians.end(); it++) {
       cust_table.emplace(_self,[&](custodian &c){
          c.cust_name = *it;
          c.requestedpay = asset{350000, eosio::symbol("EOS", 4)};
          c.total_votes = 123455;
       });
    }
}

#define EOSIO_ABI_EX(TYPE, MEMBERS) \
extern "C" { \
   void apply( uint64_t receiver, uint64_t code, uint64_t action ) { \
      if( action == "onerror"_n.value) { \
         /* onerror is only valid if it is for the "eosio" code account and authorized by "eosio"'s "active permission */ \
         check(code == "eosio"_n.value, "onerror action's are only valid from the \"eosio\" system account"); \
      } \
      auto self = receiver; \
      if( (code == self  && action != "transfer"_n.value) ) { \
         switch( action ) { \
            EOSIO_DISPATCH_HELPER( TYPE, MEMBERS ) \
         } \
         /* does not allow destructor of thiscontract to run: eosio_exit(0); */ \
      } \
   } \
}

EOSIO_ABI_EX(daccustodian,
             (updatecust)
)
