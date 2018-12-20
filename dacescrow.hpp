#include <eosiolib/eosio.hpp>

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

typedef multi_index<"escrows"_n, escrow_info, indexed_by<"bysender"_n, const_mem_fun<escrow_info, uint64_t, &escrow_info::by_sender> > > escrows_table;

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

        [[eosio::action]]
        ACTION init(name sender, name receiver, name arb, time_point_sec expires, string memo);

        [[eosio::action]]
        ACTION transfer(name from, name to, asset quantity, string memo);

        [[eosio::action]]
        ACTION approve(uint64_t key, name approver);

        [[eosio::action]]
        ACTION unapprove(uint64_t key, name unapprover);

        [[eosio::action]]
        ACTION claim(uint64_t key);

        [[eosio::action]]
        ACTION refund(uint64_t key);

        [[eosio::action]]
        ACTION cancel(uint64_t key);

        [[eosio::action]]
        ACTION clean();

    };
}
