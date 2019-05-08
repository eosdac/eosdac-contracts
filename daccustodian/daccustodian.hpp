#include <eosio/eosio.hpp>
#include <eosio/multi_index.hpp>
#include <eosio/singleton.hpp>
#include <eosio/time.hpp>

#include "external_types.hpp"
#include "../_contract-shared-headers/eosdactokens_types.hpp"
#include "../_contract-shared-headers/daccustodian_types.hpp"

#define _STRINGIZE(x) #x
#define STRINGIZE(x) _STRINGIZE(x)

#ifdef TOKENCONTRACT
#define TOKEN_CONTRACT STRINGIZE(TOKENCONTRACT)
#endif

#ifndef TOKEN_CONTRACT
#define TOKEN_CONTRACT "eosdactokens"
#endif

#ifndef TRANSFER_DELAY
#define TRANSFER_DELAY 60*60
#endif

const name ONE_PERMISSION = "one"_n;
const name LOW_PERMISSION = "low"_n;
const name MEDIUM_PERMISSION = "med"_n;
const name HIGH_PERMISSION = "high"_n;

using namespace eosio;
using namespace std;

struct [[eosio::table("config"), eosio::contract("daccustodian")]] contr_config {
//    The amount of assets that are locked up by each candidate applying for election.
    asset lockupasset;
//    The maximum number of votes that each member can make for a candidate.
    uint8_t maxvotes = 5;
//    Number of custodians to be elected for each election count.
    uint8_t numelected = 3;
//    Length of a period in seconds.
//     - used for pay calculations if an eary election is called and to trigger deferred `newperiod` calls.
    uint32_t periodlength = 7 * 24 * 60 * 60;
    // account to have active auth set with all all custodians on the newperiod.
    name authaccount = name{0};

    // The contract that holds the fund for the DAC. This is used as the source for custodian pay.
    name tokenholder = "eosdacthedac"_n;

    // The contract that will act as the service provider account for the dac. This is used as the source for custodian pay.
    name serviceprovider;

    // The contract will direct all payments via the service provider.
    bool should_pay_via_service_provider;

    // Amount of token value in votes required to trigger the initial set of custodians
    uint32_t initial_vote_quorum_percent;

    // Amount of token value in votes required to trigger the allow a new set of custodians to be set after the initial threshold has been achieved.
    uint32_t vote_quorum_percent;

    // required number of custodians required to approve different levels of authenticated actions.
    uint8_t auth_threshold_high;
    uint8_t auth_threshold_mid;
    uint8_t auth_threshold_low;

    // The time before locked up stake can be released back to the candidate using the unstake action
    uint32_t lockup_release_time_delay;

    asset requested_pay_max;
};

typedef singleton<"config"_n, contr_config> configscontainer;

struct [[eosio::table("state"), eosio::contract("daccustodian")]] contr_state {
    time_point_sec lastperiodtime = time_point_sec(0);
    int64_t total_weight_of_votes = 0;
    int64_t total_votes_on_candidates = 0;
    uint32_t number_active_candidates = 0;
    bool met_initial_votes_threshold = false;

    EOSLIB_SERIALIZE(contr_state, (lastperiodtime)
            (total_weight_of_votes)
            (total_votes_on_candidates)
            (number_active_candidates)
            (met_initial_votes_threshold)
    )
};

typedef singleton<"state"_n, contr_state> statecontainer;

// Utility to combine ids to help with indexing.
uint128_t combine_ids(const uint8_t &boolvalue, const uint64_t &longValue) {
    return (uint128_t{boolvalue} << 8) | longValue;
}

struct [[eosio::table("candidates"), eosio::contract("daccustodian")]] candidate {
    name candidate_name;
    asset requestedpay;
    asset locked_tokens;
    uint64_t total_votes;
    uint8_t is_active;
    time_point_sec custodian_end_time_stamp;

    uint64_t primary_key() const { return candidate_name.value; }

    uint64_t by_number_votes() const { return static_cast<uint64_t>(total_votes); }

    uint64_t by_votes_rank() const { return static_cast<uint64_t>(UINT64_MAX - total_votes); }

    uint64_t by_requested_pay() const { return static_cast<uint64_t>(requestedpay.amount); }
};

typedef multi_index<"candidates"_n, candidate,
        indexed_by<"bycandidate"_n, const_mem_fun<candidate, uint64_t, &candidate::primary_key> >,
        indexed_by<"byvotes"_n, const_mem_fun<candidate, uint64_t, &candidate::by_number_votes> >,
        indexed_by<"byvotesrank"_n, const_mem_fun<candidate, uint64_t, &candidate::by_votes_rank> >,
        indexed_by<"byreqpay"_n, const_mem_fun<candidate, uint64_t, &candidate::by_requested_pay> >
> candidates_table;

struct [[eosio::table("votes"), eosio::contract("daccustodian")]] vote {
    name voter;
    name proxy;
    std::vector<name> candidates;

    uint64_t primary_key() const { return voter.value; }

    uint64_t by_proxy() const { return proxy.value; }
};

typedef eosio::multi_index<"votes"_n, vote,
        indexed_by<"byproxy"_n, const_mem_fun<vote, uint64_t, &vote::by_proxy> >
> votes_table;

struct [[eosio::table("pendingpay"), eosio::contract("daccustodian")]] pay {
    uint64_t key;
    name receiver;
    asset quantity;
    string memo;

    uint64_t primary_key() const { return key; }
    uint64_t byreceiver() const { return receiver.value; }
};

typedef multi_index<"pendingpay"_n, pay,
        indexed_by<"byreceiver"_n, const_mem_fun<pay, uint64_t, &pay::byreceiver> >
> pending_pay_table;

struct [[eosio::table("pendingstake"), eosio::contract("daccustodian")]] tempstake {
    name sender;
    asset quantity;
    string memo;

    uint64_t primary_key() const { return sender.value; }
};

typedef multi_index<"pendingstake"_n, tempstake> pendingstake_table_t;


class daccustodian : public contract {

private: // Variables used throughout the other actions.
    configscontainer config_singleton;
    statecontainer contract_state;
    candidates_table registered_candidates;
    votes_table votes_cast_by_members;
    pending_pay_table pending_pay;

    contr_state _currentState;

public:

    daccustodian( name s, name code, datastream<const char*> ds )
        :contract(s,code,ds),
            registered_candidates(_self, _self.value),
            votes_cast_by_members(_self, _self.value),
            pending_pay(_self, _self.value),
            config_singleton(_self, _self.value),
            contract_state(_self, _self.value) {

        _currentState = contract_state.get_or_default(contr_state());
    }

    ~daccustodian() {
        contract_state.set(_currentState, _self); // This should not run during a contract_state migration since it will prevent changing the schema with data saved between runs.
    }

    ACTION updateconfig(contr_config newconfig);

    /** Action to listen to from the associated token contract to ensure registering should be allowed.
 *
 * @param from The account to observe as the source of funds for a transfer
 * @param to The account to observe as the destination of funds for a transfer
 * @param quantity
 * @param memo A string to attach to a transaction. For staking this string should match the name of the running contract eg "dacelections". Otherwise it will be regarded only as a generic transfer to the account.
 * This action is intended only to observe transfers that are run by the associated token contract for the purpose of tracking the moving weights of votes if either the `from` or `to` in the transfer have active votes. It is not included in the ABI to prevent it from being called from outside the chain.
 */
    void transfer(name from,
                  name to,
                  asset quantity,
                  string memo);


    /**
 * This action is used to nominate a candidate for custodian elections.
 * It must be authorised by the candidate and the candidate must be an active member of the dac, having agreed to the latest constitution.
 * The candidate must have transferred a quantity of tokens (determined by a config setting - `lockupasset`) to the contract for staking before this action is executed. This could have been from a recent transfer with the contract name in the memo or from a previous time when this account had nominated, as long as the candidate had never `unstake`d those tokens.
 * ### Assertions:
 * - The account performing the action is authorised.
 * - The candidate is not already a nominated candidate.
 * - The requested pay amount is not more than the config max amount
 * - The requested pay symbol type is the same from config max amount ( The contract supports only one token symbol for payment)
 * - The candidate is currently a member or has agreed to the latest constitution.
 * - The candidate has transferred sufficient funds for staking if they are a new candidate.
 * - The candidate has enough staked if they are re-nominating as a candidate and the required stake has changed since they last nominated.
 * @param cand - The account id for the candidate nominating.
 * @param requestedpay - The amount of pay the candidate would like to receive if they are elected as a custodian. This amount must not exceed the maximum allowed amount of the contract config parameter (`requested_pay_max`) and the symbol must also match.
 *
 *
 * ### Post Condition:
 * The candidate should be present in the candidates table and be set to active. If they are a returning candidate they should be set to active again. The `locked_tokens` value should reflect the total of the tokens they have transferred to the contract for staking. The number of active candidates in the contract will incremented.
 */
    ACTION nominatecand(name cand, eosio::asset requestedpay);

    /**
 * This action is used to withdraw a candidate from being active for custodian elections.
 *
 * ### Assertions:
 * - The account performing the action is authorised.
 * - The candidate is already a nominated candidate.
 * @param cand - The account id for the candidate nominating.
 *
 *
 * ### Post Condition:
 * The candidate should still be present in the candidates table and be set to inactive. If the were recently an elected custodian there may be a time delay on when they can unstake their tokens from the contract. If not they will be able to unstake their tokens immediately using the unstake action.
 */
    ACTION withdrawcand(name cand);

    /**
 * This action is used to remove a candidate from being a candidate for custodian elections.
 *
 * ### Assertions:
 * - The action is authorised by the mid level permission the auth account for the contract.
 * - The candidate is already a nominated candidate.
 * @param cand - The account id for the candidate nominating.
 * @param lockupStake - if true the stake will be locked up for a time period as set by the contract config - `lockup_release_time_delay`
 *
 *
 * ### Post Condition:
 * The candidate should still be present in the candidates table and be set to inactive. If the `lockupstake` parameter is true the stake will be locked until the time delay has passed. If not the candidate will be able to unstake their tokens immediately using the unstake action to have them returned.
 */
    ACTION firecand(name cand, bool lockupStake);

    /**
 * This action is used to resign as a custodian.
 *
 * ### Assertions:
 * - The `cust` account performing the action is authorised to do so.
 * - The `cust` account is currently an elected custodian.
 * @param cust - The account id for the candidate nominating.
 *
 *
 * ### Post Condition:
 * The custodian will be removed from the active custodians and should still be present in the candidates table but will be set to inactive. Their staked tokens will be locked up for the time delay added from the moment this action was called so they will not able to unstake until that time has passed. A replacement custodian will selected from the candidates to fill the missing place (based on vote ranking) then the auths for the controlling dac auth account will be set for the custodian board.
 */
    ACTION resigncust(name cust);

    /**
 * This action is used to remove a custodian.
 *
 * ### Assertions:
 * - The action is authorised by the mid level of the auth account (currently elected custodian board).
 * - The `cust` account is currently an elected custodian.
 * @param cust - The account id for the candidate nominating.
 *
 *
 * ### Post Condition:
 * The custodian will be removed from the active custodians and should still be present in the candidates table but will be set to inactive. Their staked tokens will be locked up for the time delay added from the moment this action was called so they will not able to unstake until that time has passed. A replacement custodian will selected from the candidates to fill the missing place (based on vote ranking) then the auths for the controlling dac auth account will be set for the custodian board.
 */
    ACTION firecust(name cust);

    /**
 * This action is used to update the bio for a candidate.
 *
 * ### Assertions:
 * - The `cand` account performing the action is authorised to do so.
 * - The string in the bio field is less than 256 characters.
 * @param cand - The account id for the candidate nominating.
 * @param bio - A string of bio data that will be passed through the contract.
 *
 *
 * ### Post Condition:
Nothing from this action is stored on the blockchain. It is only intended to ensure authentication of changing the bio which will be stored off chain.
 */
    ACTION updatebio(name cand, std::string bio);

    [[eosio::action]]
    inline void stprofile(name cand, std::string profile) { require_auth(cand); };

    [[eosio::action]]
    inline void stprofileuns(name cand, std::string profile) { require_auth(cand); };

    /**
 * This action is used to update the requested pay for a candidate.
 *
 * ### Assertions:
 * - The `cand` account performing the action is authorised to do so.
 * - The candidate is currently registered as a candidate.
 * - The requestedpay is not more than the requested pay amount.
 * @param cand - The account id for the candidate nominating.
 * @param requestedpay - A string representing the asset they would like to be paid as custodian.
 *
 *
 * ### Post Condition:
 * The requested pay for the candidate should be updated to the new asset.
 */
    ACTION updatereqpay(name cand, eosio::asset requestedpay);

    /**
* This action is to facilitate voting for candidates to become custodians of the DAC. Each member will be able to vote a configurable number of custodians set by the contract configuration. When a voter calls this action either a new vote will be recorded or the existing vote for that voter will be modified. If an empty array of candidates is passed to the action an existing vote for that voter will be removed.
*
* ### Assertions:
* - The voter account performing the action is authorised to do so.
* - The voter account performing has agreed to the latest member terms for the DAC.
* - The number of candidates in the newvotes vector is not greater than the number of allowed votes per voter as set by the contract config.
* - Ensure there are no duplicate candidates in the voting vector.
* - Ensure all the candidates in the vector are registered and active candidates.
* @param voter - The account id for the voter account.
* @param newvotes - A vector of account ids for the candidate that the voter is voting for.
*
* ### Post Condition:
* An active vote record for the voter will have been created or modified to reflect the newvotes. Each of the candidates will have their total_votes amount updated to reflect the delta in voter's token balance. Eg. If a voter has 1000 tokens and votes for 5 candidates, each of those candidates will have their total_votes value increased by 1000. Then if they change their votes to now vote 2 different candidates while keeping the other 3 the same there would be a change of -1000 for 2 old candidates +1000 for 2 new candidates and the other 3 will remain unchanged.
*/
    ACTION votecust(name voter, std::vector<name> newvotes);

//    void voteproxy(name voter, name proxy);


/**
 * This action is to be run to end and begin each period in the DAC life cycle.
 * It performs multiple tasks for the DAC including:
 * - Allocate custodians from the candidates tables based on those with most votes at the moment this action is run.
 * -- This action removes and selects a full set of custodians each time it is successfully run selected from the candidates with the most votes weight. If there are not enough eligible candidates to satisfy the DAC config numbers the action adds the highest voted candidates as custodians as long their votes weight is greater than 0. At this time the held stake for the departing custodians is set to have a time delayed lockup to prevent the funds releasing too soon after each custodian has been in office.
 * - Distribute pay for the existing custodians based on the configs into the pendingpay table so it can be claimed by individual candidates.
 * -- The pay is distributed as determined by the median pay of the currently elected custodians. Therefore all elected custodians receive the same pay amount.
 * - Set the DAC auths for the intended controlling accounts based on the configs thresholds with the newly elected custodians.
 * This action asserts unless the following conditions have been met:
 * - The action cannot be called multiple times within the period since the last time it was previously run successfully. This minimum time between allowed calls is configured by the period length parameter in contract configs.
 * - To run for the first time a minimum threshold of voter engragement must be satisfied. This is configured by the `initial_vote_quorum_percent` field in the contract config with the percentage calculated from the amount of registered votes cast by voters against the max supply of tokens for DAC's primary currency.
 * - After the initial vote quorum percent has been reached subsequent calls to this action will require a minimum of `vote_quorum_percent` to vote for the votes to be considered sufficient to trigger a new period with new custodians.
 * @param message - a string that be used to log a message in the chain history logs. It serves no function in the contract logic.
 */
    ACTION newperiod(std::string message);

    /**
 * This action is to claim pay as a custodian.
 *
 * ### Assertions:
 * - The caller to the action account performing the action is authorised to do so.
 * - The payid is for a valid pay record in the pending pay table.
 * - The callas account is the same as the intended destination account for the pay record.
 * @param payid - The id for the pay record to claim from the pending pay table.
 *
 * ### Post Condition:
 * The quantity owed to the custodian as referred to by the pay record is transferred to the claimer and then the pay record is removed from the pending pay table.
 */
    ACTION claimpay(uint64_t payid);

    /**
 * This action is used to unstake a candidates tokens and have them transferred to their account.
 *
 * ### Assertions:
 * - The candidate was a nominated candidate at some point in the passed.
 * - The candidate is not already a nominated candidate.
 * - The tokens held under candidate's account are not currently locked in a time delay.
 *
 * @param cand - The account id for the candidate nominating.
 *
 *
 * ### Post Condition:
 * The candidate should still be present in the candidates table and should be still set to inactive. The candidates tokens will be transferred back to their account and their `locked_tokens` value will be reduced to 0.
 */
    ACTION unstake(name cand);


private: // Private helper methods used by other actions.

    contr_config configs();

    void assertValidMember(name member);

    void updateVoteWeight(name custodian, int64_t weight);

    void updateVoteWeights(const vector<name> &votes, int64_t vote_weight);

    void modifyVoteWeights(name voter, vector<name> oldVotes, vector<name> newVotes);

    void assertPeriodTime();

    void distributePay();
    
    void distributeMeanPay();

    void setCustodianAuths();

    void removeCustodian(name cust);

    void removeCandidate(name cust, bool lockupStake);

    void allocateCustodians(bool early_election);


//#define MIGRATE

#ifdef MIGRATE
public: // Exposed publicy for development only.
    void migrate();
#endif

};
