#include <eosio/asset.hpp>
#include <eosio/eosio.hpp>
#include <eosio/time.hpp>
#include <optional>

using namespace eosio;
using namespace std;

struct [[eosio::table("escrows"), eosio::contract("dacescrow")]] escrow_info {
    name           key;
    name           sender;
    name           receiver;
    name           arb;
    extended_asset receiver_pay;
    extended_asset arbitrator_pay;
    string         memo;
    time_point_sec expires;
    bool           disputed;

    uint64_t primary_key() const { return key.value; }

    uint64_t by_sender() const { return sender.value; }
};

typedef multi_index<"escrows"_n, escrow_info,
    indexed_by<"bysender"_n, const_mem_fun<escrow_info, uint64_t, &escrow_info::by_sender>>>
    escrows_table;
