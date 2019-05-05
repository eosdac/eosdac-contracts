#include "dacdirtester.hpp"
#include "../../dacdirectory_shared.hpp"

using namespace eosio;
using namespace std;

void dacdirtester::assdacscope(name dac_name, uint8_t scope_type) {
   auto account_and_scope = dacdir::dac_for_id(dac_name).account_and_scope(scope_type);

   print("found scope: ", account_and_scope.dac_scope);
}
