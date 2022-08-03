#include <eosio/asset.hpp>
#include <eosio/eosio.hpp>

struct currency_stats {
    eosio::asset supply;
    eosio::asset max_supply;
    eosio::name  issuer;
    bool         transfer_locked = false;

    uint64_t primary_key() const { return supply.symbol.code().raw(); }
};

using stats = eosio::multi_index<"stat"_n, currency_stats>;

// Authority Structs
namespace eosiosystem {

    struct key_weight {
        eosio::public_key key;
        uint16_t          weight;
    };

    struct permission_level_weight {
        eosio::permission_level permission;
        uint16_t                weight;

        friend constexpr bool operator<(const permission_level_weight &a, const permission_level_weight &b) {
            return a.permission.actor < b.permission.actor;
        }
    };

    struct wait_weight {
        uint32_t wait_sec;
        uint16_t weight;
    };

    struct authority {

        uint32_t                             threshold;
        std::vector<key_weight>              keys;
        std::vector<permission_level_weight> accounts;
        std::vector<wait_weight>             waits;
    };
} // namespace eosiosystem
