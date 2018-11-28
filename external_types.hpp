#include <eosiolib/eosio.hpp>
#include <eosiolib/asset.hpp>

using namespace eosio;
using namespace std;

struct currency_stats {
    eosio::asset supply;
    eosio::asset max_supply;
    name issuer;
    bool transfer_locked = false;

    uint64_t primary_key() const { return supply.symbol.code().raw(); }
};

typedef eosio::multi_index<"stat"_n, currency_stats> stats;


// This is a reference to the member struct as used in the eosdactoken contract.
// @abi table members
struct member {
    name sender;
    /// Hash of agreed terms
    uint64_t agreedterms;

    uint64_t primary_key() const { return sender.value; }

    EOSLIB_SERIALIZE(member, (sender)(agreedterms))
};

// This is a reference to the termsinfo struct as used in the eosdactoken contract.
struct termsinfo {
    string terms;
    string hash;
    uint64_t version;

    uint64_t primary_key() const { return version; }

    EOSLIB_SERIALIZE(termsinfo, (terms)(hash)(version))
};

typedef multi_index<"memberterms"_n, termsinfo> memterms;

struct account {
    asset balance;

    uint64_t primary_key() const { return balance.symbol.code().raw(); }
};

typedef multi_index<"members"_n, member> regmembers;
typedef eosio::multi_index<"accounts"_n, account> accounts;

//Authority Structs
namespace eosiosystem {

    struct key_weight {
        eosio::public_key key;
        uint16_t weight;

        // explicit serialization macro is not necessary, used here only to improve compilation time
        EOSLIB_SERIALIZE(key_weight, (key)(weight))
    };

    struct permission_level_weight {
        permission_level permission;
        uint16_t weight;

        // explicit serialization macro is not necessary, used here only to improve compilation time
        EOSLIB_SERIALIZE(permission_level_weight, (permission)(weight))
    };

    struct wait_weight {
        uint32_t wait_sec;
        uint16_t weight;

        // explicit serialization macro is not necessary, used here only to improve compilation time
        EOSLIB_SERIALIZE(wait_weight, (wait_sec)(weight))
    };

    struct authority {

        uint32_t threshold;
        vector<key_weight> keys;
        vector<permission_level_weight> accounts;
        vector<wait_weight> waits;

        EOSLIB_SERIALIZE(authority, (threshold)(keys)(accounts)(waits))
    };
}
