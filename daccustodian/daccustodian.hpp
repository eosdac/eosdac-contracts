#include <eosio/eosio.hpp>
#include <eosio/multi_index.hpp>
#include <eosio/singleton.hpp>
#include <eosio/time.hpp>
#include <eosio/permission.hpp>

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

    struct [[eosio::table("candperms"), eosio::contract("daccustodian")]] candperm {
        name cand;
        name permission;

    uint64_t primary_key() const { return cand.value; }
    };

    typedef multi_index<"candperms"_n, candperm> candperms_table;

    class daccustodian : public contract {

    public:

        daccustodian( name s, name code, datastream<const char*> ds )
            :contract(s,code,ds) {}

        ACTION updateconfig(contr_config newconfig);
        ACTION updateconfige(contr_config newconfig, name dac_id);
        ACTION capturestake(name from,
                            asset quantity,
                            name dac_id);
        ACTION transferobsv(name from,
                            name to,
                            asset quantity,
                            name dac_id);
        ACTION nominatecand(name cand, eosio::asset requestedpay);
        ACTION nominatecane(name cand, eosio::asset requestedpay, name dac_id);
        ACTION withdrawcand(name cand);
        ACTION withdrawcane(name cand, name dac_id);
        ACTION firecand(name cand, bool lockupStake);
        ACTION firecande(name cand, bool lockupStake, name dac_id);
        ACTION resigncust(name cust);
        ACTION resigncuste(name cust, name dac_id);
        ACTION firecust(name cust);
        ACTION firecuste(name cust, name dac_id);
        ACTION updatebio(name cand, std::string bio);
        ACTION updatebioe(name cand, std::string bio, name dac_id);

        [[eosio::action]]
        inline void stprofile(name cand, std::string profile, name dac_id) { require_auth(cand); };

        [[eosio::action]]
        inline void stprofileuns(name cand, std::string profile) { require_auth(cand); };
        ACTION updatereqpay(name cand, eosio::asset requestedpay);
        ACTION updatereqpae(name cand, eosio::asset requestedpay, name dac_id);
        ACTION votecust(name voter, std::vector<name> newvotes);
        ACTION votecuste(name voter, std::vector<name> newvotes, name dac_id);
    //    void voteproxy(name voter, name proxy);
        ACTION newperiod(std::string message);
        ACTION newperiode(std::string message, name dac_id);
        ACTION claimpay(uint64_t payid);
        ACTION claimpaye(uint64_t payid, name dac_id);
        ACTION unstake(name cand);
        ACTION unstakee(name cand, name dac_id);
        /**
     * This action is used to register a custom permission that will be used in the multisig instead of active.
     *
     * ### Assertions:
     * - The account supplied to cand exists and is a registered candidate
     * - The permission supplied exists as a permission on the account
     *
     * @param cand - The account id for the candidate setting a custom permission.
     * @param permission - The permission name to use.
     *
     *
     * ### Post Condition:
     * The candidate will have a record entered into the database indicating the custom permission to use.
     */
        ACTION setperm(name cand, name permission, name dac_id);

        
    // ACTION migrate();
        
    private: // Private helper methods used by other actions.

        void updateVoteWeight(name custodian, int64_t weight, name internal_dac_id);
        void updateVoteWeights(const vector<name> &votes, int64_t vote_weight, name internal_dac_id, contr_state &currentState);
        void modifyVoteWeights(name voter, vector<name> oldVotes, vector<name> newVotes, name internal_dac_id);
        void assertPeriodTime(contr_config &configs, contr_state &currentState);
        void distributePay(name internal_dac_id);
        void distributeMeanPay(name internal_dac_id);
        void setCustodianAuths(name internal_dac_id);
        void removeCustodian(name cust, name internal_dac_id);
        void removeCandidate(name cust, bool lockupStake, name internal_dac_id);
        void allocateCustodians(bool early_election, name internal_dac_id);
        bool permissionExists(name account, name permission);
        bool _check_transaction_authorization(const char* trx_data,     uint32_t trx_size,
                                                const char* pubkeys_data, uint32_t pubkeys_size,
                                                const char* perms_data,   uint32_t perms_size);
                                                
        permission_level getCandidatePermission(name account, name internal_dac_id);
    };
};
