#include <eosio/eosio.hpp>
#include <eosio/multi_index.hpp>
#include <eosio/singleton.hpp>
#include <eosio/time.hpp>

#include "external_types.hpp"
#include "../_contract-shared-headers/eosdactokens_shared.hpp"
#include "../_contract-shared-headers/daccustodian_shared.hpp"
#include "../_contract-shared-headers/common_utilities.hpp"

namespace eosdac {

    const eosio::name ONE_PERMISSION = "one"_n;
    const eosio::name LOW_PERMISSION = "low"_n;
    const eosio::name MEDIUM_PERMISSION = "med"_n;
    const eosio::name HIGH_PERMISSION = "high"_n;

#ifndef TRANSFER_DELAY
#define TRANSFER_DELAY 60*60
#endif
    struct contr_config;
    typedef eosio::singleton<"config"_n, contr_config> configscontainer;

    struct [[eosio::table("config"), eosio::contract("daccustodian")]] contr_config {
    //    The amount of assets that are locked up by each candidate applying for election.
        eosio::asset lockupasset;
    //    The maximum number of votes that each member can make for a candidate.
        uint8_t maxvotes = 5;
    //    Number of custodians to be elected for each election count.
        uint8_t numelected = 3;
    //    Length of a period in seconds.
    //     - used for pay calculations if an eary election is called and to trigger deferred `newperiod` calls.
        uint32_t periodlength = 7 * 24 * 60 * 60;
        // account to have active auth set with all all custodians on the newperiod.
        // name authaccount = name{0};

        // The contract that holds the fund for the DAC. This is used as the source for custodian pay.
        // name tokenholder = "eosdacthedac"_n;

        // The contract that will act as the service provider account for the dac. This is used as the source for custodian pay.
        // name serviceprovider;

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

        eosio::asset requested_pay_max;

        static contr_config get_current_configs(eosio::name account, eosio::name scope) {
            return configscontainer(account, scope.value).get_or_default(contr_config());
        }
        
        void save(eosio::name account, eosio::name scope, eosio::name payer = same_payer) {
            configscontainer(account, scope.value).set(*this, payer);
        }
    };

    struct contr_state;
    typedef eosio::singleton<"state"_n, contr_state> statecontainer;

    struct [[eosio::table("state"), eosio::contract("daccustodian")]] contr_state {
        eosio::time_point_sec lastperiodtime = time_point_sec(0);
        int64_t total_weight_of_votes = 0;
        int64_t total_votes_on_candidates = 0;
        uint32_t number_active_candidates = 0;
        bool met_initial_votes_threshold = false;

        // EOSLIB_SERIALIZE(contr_state, 
        //         (lastperiodtime)
        //         (total_weight_of_votes)
        //         (total_votes_on_candidates)
        //         (number_active_candidates)
        //         (met_initial_votes_threshold)
        // )

        static contr_state get_current_state(eosio::name account, eosio::name scope) {
            return statecontainer(account, scope.value).get_or_default(contr_state());
        }
        
        void save(eosio::name account, eosio::name scope, eosio::name payer = same_payer) {
            statecontainer(account, scope.value).set(*this, payer);
        }
    };

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
        string memo; //deprecated - but needs mifgrations to get rid of it.

        uint64_t primary_key() const { return sender.value; }
    };

    typedef multi_index<"pendingstake"_n, tempstake> pendingstake_table_t;

    class daccustodian : public contract {

    public:

        daccustodian( name s, name code, datastream<const char*> ds )
            :contract(s,code,ds) {}

        ACTION updateconfig(contr_config newconfig, name dac_scope);
        ACTION capturestake(name from,
                            asset quantity,
                            name dac_scope);
        ACTION transferobsv(name from,
                            name to,
                            asset quantity,
                            name scope);
        ACTION nominatecand(name cand, eosio::asset requestedpay, name dac_scope);
        ACTION withdrawcand(name cand, name dac_scope);
        ACTION firecand(name cand, bool lockupStake, name dac_scope);
        ACTION resigncust(name cust, name dac_scope);
        ACTION firecust(name cust, name dac_scope);
        ACTION updatebio(name cand, std::string bio, name dac_scope);

        [[eosio::action]]
        inline void stprofile(name cand, std::string profile, name dac_scope) { require_auth(cand); };

        [[eosio::action]]
        inline void stprofileuns(name cand, std::string profile) { require_auth(cand); };
        ACTION updatereqpay(name cand, eosio::asset requestedpay, name dac_scope);
        ACTION votecust(name voter, std::vector<name> newvotes, name dac_scope);
    //    void voteproxy(name voter, name proxy);
        ACTION newperiod(std::string message, name dac_scope);
        ACTION claimpay(uint64_t payid, name dac_scope);
        ACTION unstake(name cand, name dac_scope);
        
        // ACTION migrate();
        
    private: // Private helper methods used by other actions.

        void updateVoteWeight(name custodian, int64_t weight, name internal_dac_scope);
        void updateVoteWeights(const vector<name> &votes, int64_t vote_weight, name internal_dac_scope, contr_state &currentState);
        void modifyVoteWeights(name voter, vector<name> oldVotes, vector<name> newVotes, name internal_dac_scope);
        void assertPeriodTime(contr_config &configs, contr_state &currentState);
        void distributePay(name internal_dac_scope);
        void distributeMeanPay(name internal_dac_scope);
        void setCustodianAuths(name internal_dac_scope);
        void removeCustodian(name cust, name internal_dac_scope);
        void removeCandidate(name cust, bool lockupStake, name internal_dac_scope);
        void allocateCustodians(bool early_election, name internal_dac_scope);
    };
}