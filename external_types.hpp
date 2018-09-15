#include <eosiolib/eosio.hpp>

using namespace eosio;
using namespace std;

struct currency_stats {
    asset supply;
    asset max_supply;
    account_name issuer;
    bool transfer_locked = false;

    uint64_t primary_key() const { return supply.symbol.name(); }
};

typedef eosio::multi_index<N(stat), currency_stats> stats;


// This is a reference to the member struct as used in the eosdactoken contract.
// @abi table members
struct member {
    name sender;
    /// Hash of agreed terms
    uint64_t agreedterms;

    name primary_key() const { return sender; }

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

typedef multi_index<N(memberterms), termsinfo> memterms;

struct account {
    asset balance;

    uint64_t primary_key() const { return balance.symbol.name(); }
};

typedef multi_index<N(members), member> regmembers;
typedef eosio::multi_index<N(accounts), account> accounts;

//Authority Structs
namespace eosiosystem {

    struct key_weight {
        eosio::public_key key;
        weight_type weight;

        // explicit serialization macro is not necessary, used here only to improve compilation time
        EOSLIB_SERIALIZE(key_weight, (key)(weight))
    };

    struct permission_level_weight {
        permission_level permission;
        weight_type weight;

        // explicit serialization macro is not necessary, used here only to improve compilation time
        EOSLIB_SERIALIZE(permission_level_weight, (permission)(weight))
    };

    struct wait_weight {
        uint32_t wait_sec;
        weight_type weight;

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
