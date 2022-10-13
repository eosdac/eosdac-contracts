#include <eosio/eosio.hpp>

using namespace eosio;

namespace alienworlds {

    CONTRACT newperiodctl : public contract {
      public:
        newperiodctl(name self, name code, datastream<const char *> ds) : contract(self, code, ds) {}

        ACTION assertunlock(const name dac_id) {
            require_auth(get_self());
        };
    };

} // namespace alienworlds