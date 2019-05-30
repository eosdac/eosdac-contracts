#include <eosio/eosio.hpp>
#include <eosio/asset.hpp>

struct currency_stats {
    eosio::asset supply;
    eosio::asset max_supply;
    eosio::name issuer;
    bool transfer_locked = false;

    uint64_t primary_key() const { return supply.symbol.code().raw(); }
};

typedef eosio::multi_index<"stat"_n, currency_stats> stats;

//Authority Structs
namespace eosiosystem {

    struct key_weight {
        eosio::public_key key;
        uint16_t weight;
    };

    struct permission_level_weight {
        eosio::permission_level permission;
        uint16_t weight;
    };

    struct wait_weight {
        uint32_t wait_sec;
        uint16_t weight;
    };

    struct authority {

        uint32_t threshold;
        std::vector<key_weight> keys;
        std::vector<permission_level_weight> accounts;
        std::vector<wait_weight> waits;
    };
}
