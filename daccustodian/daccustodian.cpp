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
#include "privatehelpers.cpp"
#include "newperiod_components.cpp"
#include "pay_handling.cpp"
#include "external_observable_actions.cpp"
#include "config.cpp"
#include "paycpu.cpp"
#include "migration.cpp"

#ifdef DEBUG
#include "debug.cpp"
#endif

using namespace eosio;
using namespace std;
