#include <eosio/asset.hpp>
#include <eosio/eosio.hpp>
#include <eosio/singleton.hpp>
#include <eosio/transaction.hpp>

#include "../../contract-shared-headers/daccustodian_shared.hpp"
#include <eosio/crypto.hpp>
#include <eosio/multi_index.hpp>
#include <string>

#include "config.cpp"
#include "external_observable_actions.cpp"
#include "newperiod_components.cpp"
#include "pay_handling.cpp"
#include "paycpu.cpp"
#include "privatehelpers.cpp"
#include "registering.cpp"
#include "update_member_details.cpp"
#include "voting.cpp"

#ifdef DEBUG
#include "debug.cpp"
#endif

#include "migration.cpp"

using namespace eosio;
using namespace std;
