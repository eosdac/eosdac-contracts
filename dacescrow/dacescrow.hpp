#include "dacescrow_shared.hpp"
#include <eosio/asset.hpp>
#include <eosio/eosio.hpp>
#include <eosio/time.hpp>
#include <optional>

using namespace eosio;
using namespace std;

namespace eosdac {
    class dacescrow : public contract {

      private:
        escrows_table escrows;
        name          sending_code;

      public:
        dacescrow(name s, name code, datastream<const char *> ds) : contract(s, code, ds), escrows(_self, _self.value) {
            sending_code = name{code};
        }

        ~dacescrow();

        /**
         * Escrow contract
         */

        ACTION init(name sender, name receiver, name arb, time_point_sec expires, string memo, name ext_reference,
            std::optional<uint16_t> arb_payment);

        ACTION transfer(name from, name to, asset quantity, string memo);

        ACTION approve(name key, name approver);

        ACTION disapprove(name key, name disapprover);

        ACTION refund(name key);

        ACTION cancel(name key);

        ACTION clean();
    };
}; // namespace eosdac
