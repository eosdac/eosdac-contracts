#include <eosio/eosio.hpp>
#include <eosio/asset.hpp>

using namespace std;
using namespace eosio;

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