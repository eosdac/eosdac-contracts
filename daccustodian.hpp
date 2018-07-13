#include <eosiolib/eosio.hpp>
#include <eosiolib/multi_index.hpp>
#include <eosiolib/eosio.hpp>

using namespace eosio;
using namespace std;

// This is a reference to the member struct as used in the eosdactoken contract.
// @abi table members
struct member {
    name sender;
    /// Hash of agreed terms
    string agreedterms;

    name primary_key() const { return sender; }

    EOSLIB_SERIALIZE(member, (sender)(agreedterms))
};

struct account {
    asset    balance;

    uint64_t primary_key()const { return balance.symbol.name(); }
};

typedef multi_index<N(members), member> regmembers;
typedef eosio::multi_index<N(accounts), account> accounts;

