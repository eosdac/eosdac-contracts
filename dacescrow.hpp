#include <eosiolib/eosio.hpp>
#include <eosiolib/asset.hpp>
#include <eosiolib/time.hpp>
#include <optional>

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
    uint64_t        external_reference;

    uint64_t        primary_key() const { return key; }
    uint64_t        by_external_ref() const { return external_reference; }

    uint64_t        by_sender() const { return sender.value; }
};

typedef multi_index<"escrows"_n, escrow_info,
        indexed_by<"bysender"_n, const_mem_fun<escrow_info, uint64_t, &escrow_info::by_sender> >,
        indexed_by<"byextref"_n, const_mem_fun<escrow_info, uint64_t, &escrow_info::by_external_ref> >
        > escrows_table;

namespace eosdac {
    class dacescrow : public contract {

    private:
        escrows_table escrows;

    public:

        dacescrow(name s, name code, datastream<const char *> ds)
                : contract(s, code, ds),
                  escrows(_self, _self.value) {}

        ~dacescrow();

        /**
         * Escrow contract
         */

        ACTION init(name sender, name receiver, name arb, time_point_sec expires, string memo, std::optional<uint64_t> ext_reference = NULL);

        ACTION transfer(name from, name to, asset quantity, string memo);

        ACTION approve(uint64_t key, name approver);

        ACTION unapprove(uint64_t key, name unapprover);

        ACTION claim(uint64_t key);

        ACTION refund(uint64_t key);

        ACTION cancel(uint64_t key);

        // Actions using the external reference key

        ACTION approveext(uint64_t ext_key, name approver);

        ACTION unapproveext(uint64_t ext_key, name unapprover);

        ACTION claimext(uint64_t ext_key);

        ACTION refundext(uint64_t ext_key);

        ACTION cancelext(uint64_t ext_key);

        ACTION clean();

    private:
        std::optional<uint64_t> key_for_external_key(std::optional<uint64_t> ext_key);
    };
};
