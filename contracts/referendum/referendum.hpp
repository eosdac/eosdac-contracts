#include <eosio/action.hpp>
#include <eosio/asset.hpp>
#include <eosio/binary_extension.hpp>
#include <eosio/eosio.hpp>
#include <eosio/multi_index.hpp>
#include <eosio/permission.hpp>
#include <eosio/print.hpp>
#include <eosio/singleton.hpp>
#include <eosio/symbol.hpp>
#include <eosio/transaction.hpp>
#include <limits.h>
#include <numeric>

#include "../../contract-shared-headers/config.hpp"
#include "../../contract-shared-headers/daccustodian_shared.hpp"
#include "../../contract-shared-headers/dacdirectory_shared.hpp"
#include "../../contract-shared-headers/eosdactokens_shared.hpp"
#include "../../contract-shared-headers/safemath.hpp"

// WARNING : Do not use ENABLE_BINDING_VOTE if this will be a shared contract (ie RESTRICT_DAC should be set if
// ENABLE_BINDING_VOTE==1)
//#ifndef ENABLE_BINDING_VOTE
//#define ENABLE_BINDING_VOTE 1
//#endif
// Remove this to enable multiple dacs
//#define RESTRICT_DAC "eos.dac"

using namespace eosio;
using namespace eosdac;
using namespace std;

CONTRACT referendum : public contract {

  public:
    struct contr_config;
    using configscontainer = eosio::singleton<"config2"_n, contr_config>;

    struct [[eosio::table("config2"), eosio::contract("daccustodian")]] contr_config {
        eosio::extended_asset lockupasset;
        uint8_t               maxvotes     = 5;
        uint8_t               numelected   = 3;
        uint32_t              periodlength = 7 * 24 * 60 * 60;
        bool                  should_pay_via_service_provider;
        uint32_t              initial_vote_quorum_percent;
        uint32_t              vote_quorum_percent;
        uint8_t               auth_threshold_high;
        uint8_t               auth_threshold_mid;
        uint8_t               auth_threshold_low;
        uint32_t              lockup_release_time_delay;
        eosio::extended_asset requested_pay_max;

        static contr_config get_current_configs(eosio::name account, eosio::name scope) {
            return configscontainer(account, scope.value).get_or_default(contr_config());
        }

        void save(eosio::name account, eosio::name scope, eosio::name payer = same_payer) {
            configscontainer(account, scope.value).set(*this, payer);
        }
    };

    struct [[eosio::table("candperms"), eosio::contract("daccustodian")]] candperm {
        name cand;
        name permission;

        uint64_t primary_key() const {
            return cand.value;
        }
    };

    using candperms_table = multi_index<"candperms"_n, candperm>;

    // End custodian structs

    enum vote_choice : uint8_t { VOTE_REMOVE = 0, VOTE_YES = 1, VOTE_NO = 2, VOTE_ABSTAIN = 3, VOTE_INVALID = 4 };
    enum vote_type : uint8_t { TYPE_BINDING = 0, TYPE_SEMI_BINDING = 1, TYPE_OPINION = 2, TYPE_INVALID = 3 };
    enum count_type : uint8_t { COUNT_TOKEN = 0, COUNT_ACCOUNT = 1, COUNT_INVALID = 2 };
    enum referendum_status : uint8_t {
        STATUS_OPEN           = 0,
        STATUS_PASSING        = 1,
        STATUS_FAILING        = 2,
        STATUS_QUORUM_NOT_MET = 3,
        STATUS_INVALID        = 4
    };

    struct account_stake_delta {
        name     account;
        asset    stake_delta;
        uint32_t unstake_delay;
    };

    struct config_item;
    using config_container = eosio::singleton<"config"_n, config_item>;
    struct [[eosio::table("config"), eosio::contract("referendum")]] config_item {
        uint32_t duration;
        // Key for all the maps is vote_type
        map<uint8_t, extended_asset> fee;
        map<uint8_t, uint16_t>       pass;           // Percentage with 2 decimal places, eg. 1001 == 10.01%
        map<uint8_t, uint64_t>       quorum_token;   // Sum of currency units, yes no and abstain votes
        map<uint8_t, uint64_t>       quorum_account; // Sum of accounts, yes no and abstain votes
        map<uint8_t, uint8_t>        allow_per_account_voting;
        map<uint8_t, uint8_t>        allow_vote_type;

        static config_item get_current_configs(eosio::name account, eosio::name scope) {
            return config_container(account, scope.value).get_or_default(config_item());
        }

        void save(eosio::name account, eosio::name scope, eosio::name payer = same_payer) {
            config_container(account, scope.value).set(*this, payer);
        }
    };

    struct [[eosio::table("referendums"), eosio::contract("referendum")]] referendum_data {
        name                        referendum_id;
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

        uint64_t primary_key() const {
            return referendum_id.value;
        }
        uint64_t by_proposer() const {
            return proposer.value;
        }

        std::pair<uint64_t, std::map<uint8_t, uint64_t>> quorum_votes(
            const name contract, const name dac_id, const config_item &config) const {
            if (voting_type == count_type::COUNT_TOKEN) {
                return {config.quorum_token.at(type), token_votes};
            } else {
                return {config.quorum_account.at(type), account_votes};
            }
        }

        referendum_status get_status(const name contract, const name dac_id) const {
            const auto config          = config_item::get_current_configs(contract, dac_id);
            const auto [quorum, votes] = quorum_votes(contract, dac_id, config);
            const auto current_yes     = votes.at(VOTE_YES);
            const auto current_no      = votes.at(VOTE_NO);
            const auto current_abstain = votes.at(VOTE_ABSTAIN);
            const auto current_all     = S{current_yes} + S{current_no} + S{current_abstain};
            const auto pass_rate       = config.pass.at(type); // integer with 2 decimals
            const auto time_now        = current_time_point().sec_since_epoch();
            const auto total =
                std::accumulate(votes.begin(), votes.end(), S{uint64_t{}}, [](const auto acc, const auto &x) {
                    return acc + S{x.second};
                });
            if (time_now >= expires.sec_since_epoch()) {
                return STATUS_OPEN;
            }

            if (total < quorum) {
                return STATUS_QUORUM_NOT_MET;
            }

            // quorum has been reached, check we have passed
            const auto yes_percentage_s = (S{current_yes}.to<double>() / current_all.to<double>()) *
                                          S{10000.0}; // multiply by 10000 to get integer with 2
            const auto yes_percentage = narrow_cast<uint64_t>(yes_percentage_s);
            return yes_percentage >= pass_rate ? STATUS_PASSING : STATUS_FAILING;
        }
    };

    using referenda_table = eosio::multi_index<"referendums"_n, referendum_data,
        indexed_by<"byproposer"_n, const_mem_fun<referendum_data, uint64_t, &referendum_data::by_proposer>>>;

    struct [[eosio::table("votes"), eosio::contract("referendum")]] vote_info {
        name                    voter;
        std::map<name, uint8_t> votes; // <referendum_id, vote>

        uint64_t primary_key() const {
            return voter.value;
        }
    };
    using votes_table = eosio::multi_index<"votes"_n, vote_info>;

    struct [[eosio::table("deposits"), eosio::contract("referendum")]] deposit_info {
        name           account;
        extended_asset deposit;

        uint64_t primary_key() const {
            return account.value;
        }
        uint128_t by_sym() const {
            return (uint128_t{deposit.contract.value} << 64) | deposit.get_extended_symbol().get_symbol().raw();
        };
    };
    using deposits_table = eosio::multi_index<"deposits"_n, deposit_info,
        indexed_by<"bysym"_n, const_mem_fun<deposit_info, uint128_t, &deposit_info::by_sym>>>;

    /*
     * TODO : replace with the native function once cdt 1.7.0 is released
     *
     * https://github.com/EOSIO/eosio.contracts/pull/257
     */
    bool _check_transaction_authorization(const char *trx_data, uint32_t trx_size, const char *pubkeys_data,
        uint32_t pubkeys_size, const char *perms_data, uint32_t perms_size) {
        auto res = internal_use_do_not_use::check_transaction_authorization(
            trx_data, trx_size, pubkeys_data, pubkeys_size, perms_data, perms_size);

        return (res > 0);
    }
    bool hasAuth(vector<action> acts);
    void proposeMsig(referendum_data ref, name dac_id);
    void checkDAC(name dac_id);

  public:
    using contract::contract;
    referendum(eosio::name receiver, eosio::name code, datastream<const char *> ds) : contract(receiver, code, ds) {}

    // Actions
    ACTION updateconfig(config_item config, name dac_id);

    ACTION propose(name proposer, name referendum_id, uint8_t type, uint8_t voting_type, string title, string content,
        name dac_id, vector<action> acts);
    ACTION cancel(name referendum_id, name dac_id);
    ACTION vote(
        name voter, name referendum_id, uint8_t vote, name dac_id); // vote: 0=no vote (remove), 1=yes, 2=no, 3=abstain
    ACTION exec(name referendum_id, name dac_id); // Exec the action if type is binding or semi-binding
    ACTION clean(name account, name dac_id);
    ACTION refund(name account);
    ACTION updatestatus(name referendum_id, name dac_id);
    ACTION clearconfig(name dac_id);

    // Observation of stake deltas
    ACTION stakeobsv(vector<account_stake_delta> stake_deltas, name dac_id);

    // Notify transfers for payment of fees
    [[eosio::on_notify("*::transfer")]] void receive(name from, name to, asset quantity, string memo);
};
