#include <limits.h>
#include <eosio/eosio.hpp>
#include <eosio/multi_index.hpp>
#include <eosio/singleton.hpp>
#include <eosio/print.hpp>
#include <eosio/asset.hpp>
#include <eosio/symbol.hpp>
#include <eosio/action.hpp>
#include <eosio/transaction.hpp>
#include <eosio/binary_extension.hpp>
#include <eosio/permission.hpp>

#include "../_contract-shared-headers/eosdactokens_shared.hpp"
#include "../_contract-shared-headers/dacdirectory_shared.hpp"
#include "../_contract-shared-headers/daccustodian_shared.hpp"

#define SYSTEM_MSIG_CONTRACT "eosiomsigold"

using namespace eosio;
using namespace eosdac;
using namespace std;

CONTRACT referendum : public contract {

    public:

struct contr_config;
typedef eosio::singleton<"config2"_n, contr_config> configscontainer;

struct [[eosio::table("config2"), eosio::contract("daccustodian")]] contr_config {
    //    The amount of assets that are locked up by each candidate applying for election.
    eosio::extended_asset lockupasset;
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

    eosio::extended_asset requested_pay_max;

    static contr_config get_current_configs(eosio::name account, eosio::name scope) {
        return configscontainer(account, scope.value).get_or_default(contr_config());
    }

    void save(eosio::name account, eosio::name scope, eosio::name payer = same_payer) {
        configscontainer(account, scope.value).set(*this, payer);
    }
};


        enum vote_choice: uint8_t {
            VOTE_REMOVE = 0,
            VOTE_YES = 1,
            VOTE_NO = 2,
            VOTE_ABSTAIN = 3,
            VOTE_INVALID = 4
        };
        enum vote_type: uint8_t {
            TYPE_BINDING = 0,
            TYPE_SEMI_BINDING = 1,
            TYPE_OPINION = 2,
            TYPE_INVALID = 3
        };
        enum count_type: uint8_t {
            COUNT_TOKEN = 0,
            COUNT_ACCOUNT = 1,
            COUNT_INVALID = 2
        };
        enum referendum_status: uint8_t {
            STATUS_OPEN = 0,
            STATUS_PASSING = 1,
            STATUS_EXPIRED = 2,
            STATUS_ATTENTION = 3,
            STATUS_INVALID = 4
        };


        struct account_stake_delta {
            name  account;
            asset stake_delta;
        };


        struct config_item;
        typedef eosio::singleton<"config"_n, config_item> config_container;
        struct [[eosio::table("config"), eosio::contract("referendum")]] config_item {
            // Key for all the maps is vote_type
            map<uint8_t, extended_asset> fee;
            map<uint8_t, uint16_t> pass; // Percentage with 2 decimal places, eg. 1001 == 10.01%
            map<uint8_t, uint64_t> quorum_token; // Sum of currency units, yes no and abstain votes
            map<uint8_t, uint64_t> quorum_account; // Sum of accounts, yes no and abstain votes
            map<uint8_t, uint8_t> allow_per_account_voting;

            static config_item get_current_configs(eosio::name account, eosio::name scope) {
                return config_container(account, scope.value).get_or_default(config_item());
            }

            void save(eosio::name account, eosio::name scope, eosio::name payer = same_payer) {
                config_container(account, scope.value).set(*this, payer);
            }
        };


        struct [[eosio::table("referenda"), eosio::contract("referendum")]] referendum_data {
            uint64_t                    referendum_id;
            name                        proposer;
            uint8_t                     type;
            uint8_t                     voting_type; // 0 = token, 1 = account
            uint8_t                     status;
            string                      title;
            checksum256                 content_ref;
            std::map<uint8_t, uint64_t> token_votes; // <vote, count>
            std::map<uint8_t, uint64_t> account_votes;
            time_point_sec              expires;
            vector<action>              acts;

            uint64_t primary_key() const { return referendum_id; }
            uint64_t by_proposer() const { return proposer.value; }
        };
        /* Have to use EOSLIB_SERIALIZE to work around problems with boost deserialization */
        EOSLIB_SERIALIZE(referendum_data, (referendum_id) (proposer) (type) (voting_type) (status)
                                          (title) (content_ref) (token_votes) (account_votes) (expires) (acts));
        typedef eosio::multi_index<"referenda"_n, referendum_data,
                indexed_by<"byproposer"_n, const_mem_fun<referendum_data, uint64_t, &referendum_data::by_proposer> >
        > referenda_table;




        struct [[eosio::table("votes"), eosio::contract("referendum")]] vote_info {
            name                        voter;
            std::map<uint64_t, uint8_t> votes; // <referendum_id, vote>

            uint64_t primary_key() const { return voter.value; }
        };
        typedef eosio::multi_index<"votes"_n, vote_info > votes_table;



        struct [[eosio::table("deposits"), eosio::contract("referendum")]] deposit_info {
            name           account;
            extended_asset deposit;

            uint64_t primary_key() const { return account.value; }
            uint128_t by_sym() const { return (uint128_t{deposit.contract.value} << 64) | deposit.get_extended_symbol().get_symbol().raw(); };
        };
        typedef eosio::multi_index<"deposits"_n, deposit_info,
                indexed_by<"bysym"_n, const_mem_fun<deposit_info, uint128_t, &deposit_info::by_sym> >
        > deposits_table;



        /*
         * TODO : replace with the native function once cdt 1.7.0 is released
         *
         * https://github.com/EOSIO/eosio.contracts/pull/257
         */
        bool
        _check_transaction_authorization( const char* trx_data,     uint32_t trx_size,
                                                        const char* pubkeys_data, uint32_t pubkeys_size,
                                                        const char* perms_data,   uint32_t perms_size ) {
            auto res = internal_use_do_not_use::check_transaction_authorization( trx_data, trx_size, pubkeys_data, pubkeys_size, perms_data, perms_size );

            return (res > 0);
        }
        bool hasAuth(vector<action> acts);
        uint8_t calculateStatus(uint64_t referendum_id, name dac_id);
        void proposeMsig(referendum_data ref, name dac_id);
        uint64_t nextID(checksum256 trxid);


    public:
        using contract::contract;
        referendum(eosio::name receiver, eosio::name code, datastream<const char*> ds):contract(receiver, code, ds) {}

        // Actions
        ACTION updateconfig(config_item config, name dac_id);

        ACTION propose(name proposer, uint8_t type, uint8_t voting_type, string title, string content, name dac_id, vector<action> acts);
        ACTION cancel(uint64_t referendum_id, name dac_id);
        ACTION vote(name voter, uint64_t referendum_id, uint8_t vote, name dac_id); // vote: 0=no vote (remove), 1=yes, 2=no, 3=abstain
        ACTION exec(uint64_t referendum_id, name dac_id);  // Exec the action if type is binding or semi-binding
        ACTION clean(name account, name dac_id);
        ACTION refund(name account);
        ACTION updatestatus(uint64_t referendum_id, name dac_id);

        // Observation of stake deltas
        ACTION stakeobsv(vector<account_stake_delta> stake_deltas, name dac_id);

        // Notify transfers for payment of fees
        [[eosio::on_notify("*::transfer")]]
        void receive(name from, name to, asset quantity, string memo);

};
