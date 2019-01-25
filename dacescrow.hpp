#include <eosiolib/eosio.hpp>
#include <eosiolib/asset.hpp>
#include <eosiolib/time.hpp>

using namespace eosio;
using namespace std;

struct [[eosio::table("escrows"), eosio::contract("dacescrow")]] escrow_info {
    uint64_t        key;
    name            sender;
    name            receiver;
    name            arb;
    vector<name>    approvals;
    asset           amount;
    string          memo;
    time_point_sec  expires;

    uint64_t        primary_key() const { return key; }

    uint64_t        by_sender() const { return sender.value; }
};

typedef multi_index<"escrows"_n, escrow_info,
indexed_by<"bysender"_n, const_mem_fun<escrow_info, uint64_t, &escrow_info::by_sender> >
        > escrows_table;

namespace eosdac {
    class dacescrow : public contract {

    private:
        escrows_table escrows;

    public:

        dacescrow( name s, name code, datastream<const char*> ds )
            :contract(s,code,ds),
                escrows(_self, _self.value) {}

        ~dacescrow();

        /**
         * Escrow contract
         */

        ACTION init(name sender, name receiver, name arb, time_point_sec expires, string memo);

        ACTION transfer(name from, name to, asset quantity, string memo);

        ACTION approve(uint64_t key, name approver);

        ACTION unapprove(uint64_t key, name unapprover);

        ACTION claim(uint64_t key);

        ACTION refund(uint64_t key);

        ACTION cancel(uint64_t key);

        ACTION clean();
    };
}
