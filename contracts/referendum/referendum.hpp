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
#include "../../contract-shared-headers/contracts-common/safemath.hpp"
#include "../../contract-shared-headers/daccustodian_shared.hpp"
#include "../../contract-shared-headers/dacdirectory_shared.hpp"
#include "../../contract-shared-headers/eosdactokens_shared.hpp"

// WARNING : Do not use ENABLE_BINDING_VOTE if this will be a shared contract (ie RESTRICT_DAC should be set if
// ENABLE_BINDING_VOTE==1)
// #ifndef ENABLE_BINDING_VOTE
// #define ENABLE_BINDING_VOTE 1
// #endif
// Remove this to enable multiple dacs
// #define RESTRICT_DAC "eos.dac"

using namespace eosio;
using namespace eosdac;
using namespace std;

static constexpr eosio::name VOTE_PROP_REMOVE{"remove"};
static constexpr eosio::name VOTE_PROP_YES{"yes"};
static constexpr eosio::name VOTE_PROP_NO{"no"};
static constexpr eosio::name VOTE_PROP_ABSTAIN{"abstain"};

static constexpr eosio::name REFERENDUM_BINDING{"binding"};
static constexpr eosio::name REFERENDUM_SEMI{"semibinding"};
static constexpr eosio::name REFERENDUM_OPINION{"opinion"};

static constexpr eosio::name COUNT_TYPE_TOKEN{"token"};
static constexpr eosio::name COUNT_TYPE_ACCOUNT{"account"};

static constexpr eosio::name REFERENDUM_STATUS_OPEN{"open"};
static constexpr eosio::name REFERENDUM_STATUS_PASSING{"passing"};
static constexpr eosio::name REFERENDUM_STATUS_FAILING{"failing"};
static constexpr eosio::name REFERENDUM_STATUS_QUORUM_UNMET{"quorum.unmet"};

CONTRACT referendum : public contract {

  public:
    struct [[eosio::table("candperms"), eosio::contract("daccustodian")]] candperm {
        name cand;
        name permission;

        uint64_t primary_key() const {
            return cand.value;
        }
    };

    using candperms_table = multi_index<"candperms"_n, candperm>;

    // End custodian structs

    enum vote_choice : uint64_t {
        VOTE_REMOVE  = VOTE_PROP_REMOVE.value,
        VOTE_YES     = VOTE_PROP_YES.value,
        VOTE_NO      = VOTE_PROP_NO.value,
        VOTE_ABSTAIN = VOTE_PROP_ABSTAIN.value,
    };

    enum referendum_type : uint64_t {
        TYPE_BINDING      = REFERENDUM_BINDING.value,
        TYPE_SEMI_BINDING = REFERENDUM_SEMI.value,
        TYPE_OPINION      = REFERENDUM_OPINION.value,
    };
    enum count_type : uint64_t {
        COUNT_TOKEN   = COUNT_TYPE_TOKEN.value,
        COUNT_ACCOUNT = COUNT_TYPE_ACCOUNT.value,
    };

    enum referendum_status : uint64_t {
        STATUS_OPEN           = REFERENDUM_STATUS_OPEN.value,
        STATUS_PASSING        = REFERENDUM_STATUS_PASSING.value,
        STATUS_FAILING        = REFERENDUM_STATUS_FAILING.value,
        STATUS_QUORUM_NOT_MET = REFERENDUM_STATUS_QUORUM_UNMET.value,
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
        // Key for all the maps is referendum_type
        map<name, extended_asset> fee;
        map<name, uint16_t>       pass;           // Percentage with 2 decimal places, eg. 1001 == 10.01%
        map<name, uint64_t>       quorum_token;   // Sum of currency units, yes no and abstain votes
        map<name, uint64_t>       quorum_account; // Sum of accounts, yes no and abstain votes
        map<name, bool>           allow_per_account_voting;
        map<name, bool>           allow_vote_type;

        static config_item get_current_configs(eosio::name account, eosio::name scope) {
            return config_container(account, scope.value).get_or_default(config_item());
        }

        void save(eosio::name account, eosio::name scope, eosio::name payer = same_payer) {
            config_container(account, scope.value).set(*this, payer);
        }
    };

    struct [[eosio::table("referendums"), eosio::contract("referendum")]] referendum_data {
        name                     referendum_id;
        name                     proposer;
        name                     type;
        name                     voting_type;
        name                     status;
        string                   title;
        checksum256              content_ref;
        std::map<name, uint64_t> token_votes; // <vote, count>
        std::map<name, uint64_t> account_votes;
        time_point_sec           expires;
        vector<action>           acts;

        uint64_t primary_key() const {
            return referendum_id.value;
        }
        uint64_t by_proposer() const {
            return proposer.value;
        }

        std::pair<uint64_t, std::map<name, uint64_t>> quorum_votes(
            const name contract, const name dac_id, const config_item &config) const {
            switch (count_type(voting_type.value)) {
            case COUNT_TOKEN:
                return {config.quorum_token.at(type), token_votes};
            case COUNT_ACCOUNT:
                return {config.quorum_account.at(type), account_votes};
            }
        }

        referendum_status get_status(const name contract, const name dac_id) const {
            const auto config          = config_item::get_current_configs(contract, dac_id);
            const auto [quorum, votes] = quorum_votes(contract, dac_id, config);
            const auto current_yes     = votes.at(VOTE_PROP_YES);
            const auto current_no      = votes.at(VOTE_PROP_NO);
            const auto current_abstain = votes.at(VOTE_PROP_ABSTAIN);
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
        name                 voter;
        std::map<name, name> votes; // <referendum_id, vote>

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

    bool hasAuth(vector<action> acts, name required_auth_account);
    void proposeMsig(referendum_data ref, name dac_id);
    void checkDAC(name dac_id);

  public:
    using contract::contract;
    referendum(eosio::name receiver, eosio::name code, datastream<const char *> ds) : contract(receiver, code, ds) {}

    // Actions
    ACTION updateconfig(config_item config, name dac_id);

    ACTION propose(name proposer, name referendum_id, name type, name voting_type_name, string title, string content,
        name dac_id, vector<action> acts);
    ACTION cancel(name referendum_id, name dac_id);
    ACTION vote(
        name voter, name referendum_id, name vote, name dac_id); // vote: 0=no vote (remove), 1=yes, 2=no, 3=abstain
    ACTION exec(name referendum_id, name dac_id);                // Exec the action if type is binding or semi-binding
    ACTION clean(name account, name dac_id);
    ACTION refund(name account);
    ACTION updatestatus(name referendum_id, name dac_id);
    ACTION clearconfig(name dac_id);

    ACTION publresult(referendum_data ref);

    // Observation of stake deltas
    ACTION stakeobsv(vector<account_stake_delta> stake_deltas, name dac_id);

    // Notify transfers for payment of fees
    [[eosio::on_notify("*::transfer")]] void receive(name from, name to, asset quantity, string memo);
};
