#include "dacdirtester.hpp"
#include "../../dacdirectory_shared.hpp"

using namespace eosio;
using namespace std;

void dacdirtester::assdacscope(name dac_name, uint8_t scope_type) {
   dac_table dacs("dacdirectory"_n, "dacdirectory"_n.value);
   auto dac = dacs.get(dac_name.value, "dac could not be found");

   print("found scope: ", dac.safe_scope_for_key(scope_type));
}
