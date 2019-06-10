#include <eosio/eosio.hpp>
#include <eosio/asset.hpp>
#include <eosio/time.hpp>
#include <optional>
#include "dacescrow_shared.hpp"

using namespace eosio;
using namespace std;

namespace eosdac {
    class dacescrow : public contract {

    private:
        escrows_table escrows;
        name sending_code;

    public:

        dacescrow(name s, name code, datastream<const char *> ds)
                : contract(s, code, ds),
                  escrows(_self, _self.value) {
            sending_code = name{code};
        }

        ~dacescrow();

        /**
         * Escrow contract
         */

        ACTION init(name sender, name receiver, name arb, time_point_sec expires, string memo, uint64_t ext_reference, std::optional<uint16_t> arb_payment);

        ACTION transfer(name from, name to, asset quantity, string memo);

        ACTION approve(uint64_t key, name approver);

        ACTION disapprove(uint64_t key, name disapprover);

        ACTION refund(uint64_t key);

        ACTION cancel(uint64_t key);

        ACTION clean();

    };
};
