#include <eosiolib/eosio.hpp>
#include <eosiolib/multi_index.hpp>

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

// @abi table configs
struct contr_config {
//    The amount of assets that are locked up by each candidate applying for election.
    asset lockupasset;
//    The maximum number of votes that each member can make for a candidate.
    uint8_t maxvotes = 5;
//    Number of custodians to be elected for each election count.
    uint8_t numelected = 3;
//    Length of a period in seconds.
//     - used for pay calculations if an eary election is called and to trigger deferred `newperiod` calls.
    uint32_t periodlength = 7 * 24 * 60 * 60;
    //The eosdac compatible token contract this contract should call to for member reg info
    name tokencontr;
    // account to have active auth set with all all custodians on the newperiod.
    account_name authaccount = string_to_name("dacauthority");

    // Amount of token value in votes required to trigger the initial set of custodians
    uint32_t initial_vote_quorum_percent;

    // Amount of token value in votes required to trigger the allow a new set of custodians to be set after the initial threshold has been achieved.
    uint32_t vote_quorum_percent;

    // required number of custodians required to approve different levels of authenticated actions.
    uint8_t auth_threshold_high;
    uint8_t auth_threshold_mid;
    uint8_t auth_threshold_low;

    EOSLIB_SERIALIZE(contr_config,
                     (lockupasset)
                             (maxvotes)
                             (numelected)
                             (periodlength)
                             (tokencontr)

                             (authaccount)

                             (initial_vote_quorum_percent)
                             (vote_quorum_percent)

                             (auth_threshold_high)
                             (auth_threshold_mid)
                             (auth_threshold_low)
    )
};

typedef singleton<N(config), contr_config> configscontainer;

struct contr_state {
    uint32_t lastperiodtime = 0;
    uint64_t total_votes = 0;
    bool met_initial_votes_threshold = false;

    EOSLIB_SERIALIZE(contr_state, (lastperiodtime)(total_votes)(met_initial_votes_threshold))
};

typedef singleton<N(state), contr_state> statecontainer;

// Uitility to combine ids to help with indexing.
uint128_t combine_ids(const uint8_t &boolvalue, const uint64_t &longValue) {
    return (uint128_t{boolvalue} << 8) | longValue;
}

struct candidate {
    name candidate_name;
    string bio;
    // Active requested pay used for display in pending elections.
    asset requestedpay;
    asset locked_tokens;
    uint64_t total_votes;

    account_name primary_key() const { return static_cast<uint64_t>(candidate_name); }

    uint64_t by_number_votes() const { return static_cast<uint64_t>(total_votes); }

    uint64_t by_votes_rank() const { return static_cast<uint64_t>(UINT64_MAX - total_votes); }

    uint64_t by_pending_pay() const { return static_cast<uint64_t>(requestedpay.amount); }

    EOSLIB_SERIALIZE(candidate,
                     (candidate_name)(bio)(requestedpay)(locked_tokens)(total_votes))
};

typedef multi_index<N(candidates), candidate,
        indexed_by<N(bycandidate), const_mem_fun<candidate, account_name, &candidate::primary_key> >,
        indexed_by<N(byvotes), const_mem_fun<candidate, uint64_t, &candidate::by_number_votes> >,
        indexed_by<N(byvotesrank), const_mem_fun<candidate, uint64_t, &candidate::by_votes_rank> >,
        indexed_by<N(bypendingpay), const_mem_fun<candidate, uint64_t, &candidate::by_pending_pay> >
> candidates_table;

struct custodian {
    name cust_name;
    string bio;
    // Active requested pay used for payment calculations.
    asset requestedpay;
    uint64_t total_votes;

    name primary_key() const { return cust_name; }

    uint64_t by_votes_rank() const { return static_cast<uint64_t>(UINT64_MAX - total_votes); }

    uint64_t by_requested_pay() const { return static_cast<uint64_t>(requestedpay.amount); }

    EOSLIB_SERIALIZE(custodian,
                     (cust_name)(bio)(requestedpay)(total_votes))
};


typedef multi_index<N(custodians), custodian,
        indexed_by<N(byvotesrank), const_mem_fun<custodian, uint64_t, &custodian::by_votes_rank> >,
        indexed_by<N(byreqpay), const_mem_fun<custodian, uint64_t, &custodian::by_requested_pay> >
> custodians_table;

// @abi table votes
struct vote {
    name voter;
    name proxy;
    int64_t weight;
    vector<name> candidates;

    account_name primary_key() const { return static_cast<uint64_t>(voter); }

    account_name by_proxy() const { return static_cast<uint64_t>(proxy); }

    EOSLIB_SERIALIZE(vote, (voter)(proxy)(weight)(candidates))
};

typedef eosio::multi_index<N(votes), vote,
        indexed_by<N(byproxy), const_mem_fun<vote, account_name, &vote::by_proxy> >
> votes_table;

// @abi table pendingpay
struct pay {
    uint64_t key;
    name receiver;
    asset quantity;
    string memo;

    account_name primary_key() const { return key; }

    EOSLIB_SERIALIZE(pay, (key)(receiver)(quantity)(memo))
};

typedef multi_index<N(pendingpay), pay> pending_pay_table;

// @abi table pendingstake
struct tempstake {
    account_name sender;
    asset quantity;
    string memo;

    account_name primary_key() const { return sender; }

    EOSLIB_SERIALIZE(tempstake, (sender)(quantity)(memo))
};

typedef multi_index<N(pendingstake), tempstake> pendingstake_table_t;

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

class daccustodian : public contract {

private: // Variables used throughout the other actions.
    configscontainer config_singleton;
    statecontainer contract_state;
    candidates_table registered_candidates;
    votes_table votes_cast_by_members;
    pending_pay_table pending_pay;

    symbol_type PAYMENT_TOKEN = eosio::symbol_type(eosio::string_to_symbol(4, "EOS"));

    contr_state _currentState;

public:

    daccustodian(account_name self) : contract(self),
                                      registered_candidates(_self, _self),
                                      votes_cast_by_members(_self, _self),
                                      pending_pay(_self, _self),
                                      config_singleton(_self, _self),
                                      contract_state(_self, _self) {

        _currentState = contract_state.get_or_default(contr_state());
    }

    ~daccustodian() {
        contract_state.set(_currentState, _self);
    }


    void updateconfig(
            asset lockupasset,
            uint8_t maxvotes,
            uint8_t numelected,
            uint32_t periodlength,
            name tokcontr,
            name authaccount,
            uint32_t initial_vote_quorum_percent,
            uint32_t vote_quorum_percent,
            uint8_t auth_threshold_high,
            uint8_t auth_threshold_mid,
            uint8_t auth_threshold_low
    );

    void transfer(name from,
                  name to,
                  asset quantity,
                  string memo);

    void regcandidate(name cand, string bio, asset requestedpay);

    void unregcand(name cand);

    void updatebio(name cand, string bio);

    void updatereqpay(name cand, asset requestedpay);

    void votecust(name voter, vector<name> newvotes);

    void voteproxy(name voter, name proxy);

    void newperiod(string message, bool earlyelect);

    void paypending(string message);

private: // Private helper methods used by other actions.

    contr_config configs();

    member get_valid_member(name member);

    bool isCustodian(candidate account);

    void updateVoteWeight(name custodian, int64_t weight);

    void updateVoteWeights(const vector<name> &votes, int64_t vote_weight);

    void modifyVoteWeights(name voter, vector<name> oldVotes, vector<name> newVotes);

public: // Exposed publicy for debugging only.

    void distpay(bool earlyelect);

    void clearvotes();

    void tallyvotes();

    void configperiod(bool early_election);

    void setauths();

    void migrate(name cand);

};