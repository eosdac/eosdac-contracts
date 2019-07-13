#include "dacdirtester.hpp"
#include "../../_contract-shared-headers/dacdirectory_shared.hpp"

using namespace eosio;
using namespace std;
using namespace eosdac;

    ACTION dacdirtester::assertdacid(name dac_name, uint8_t id) {
      auto account = dacdir::dac_for_id(dac_name).account_for_type(id);
      print("found dac with account: ", account);
      check(account != name{}, "No account found for the given id.");
    }


    ACTION dacdirtester::assertdacsym(eosio::extended_symbol sym, uint8_t id) {
      auto account = dacdir::dac_for_symbol(sym).account_for_type(id);
      print("found dac with symbol: ", account);
      check(account != name{}, "No account found for the given id.");
    }
