#include <eosio/eosio.hpp>
#include <eosio/multi_index.hpp>
#include <eosio/singleton.hpp>
#include <eosio/time.hpp>
#include <eosio/action.hpp>
#include <eosio/transaction.hpp>

#include "../_contract-shared-headers/daccustodian_shared.hpp"
#include "../_contract-shared-headers/dacdirectory_shared.hpp"

using namespace eosio;
using namespace std;


namespace eosdac {
    CONTRACT standbypay: public contract {
        private:

            struct [[eosio::table("pendingpay")]] pay {
                uint64_t       key;
                name           receiver;
                extended_asset quantity;
                string         memo;

                uint64_t primary_key() const { return key; }
                uint64_t byreceiver() const { return receiver.value; }
            };

            typedef multi_index<"pendingpay"_n, pay,
                    indexed_by<"byreceiver"_n, const_mem_fun<pay, uint64_t, &pay::byreceiver> >
            > pending_pay_table;


            void checkAuth(name dac_id);
            void distributeStandbyPay(vector<name> standbys, dacdir::dac dac, name dac_id);

        public:
            using contract::contract;

            ACTION newperiod(newperiod_notify nn, name dac_id);
            ACTION claimpay(uint64_t payid, name dac_id);
            ACTION removepay(uint64_t payid, name dac_id);
            ACTION rejectpay(uint64_t payid, name dac_id);
    };
}

