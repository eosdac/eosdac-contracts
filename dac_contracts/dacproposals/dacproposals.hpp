#include <eosio/asset.hpp>
#include <eosio/eosio.hpp>
#include <eosio/ignore.hpp>
#include <eosio/singleton.hpp>
#include <eosio/time.hpp>

#include "../../contract-shared-headers/daccustodian_shared.hpp"
#include "../../contract-shared-headers/dacdirectory_shared.hpp"
#include "../../contract-shared-headers/eosdactokens_shared.hpp"

using namespace eosio;
using namespace std;

#define TRANSFER_EXPIRATION 30 * 24 * 60 * 60
#define TRANSFER_DELAY 30

namespace eosdac {

    CONTRACT dacproposals : public contract {

        enum VoteType {
            none = 0,
            // a vote type to indicate a custodian's approval of a worker proposal.
            proposal_approve,
            // a vote type to indicate a custodian's denial of a worker proposal.
            proposal_deny,
            // a vote type to indicate a custodian's acceptance of a worker proposal as completed.
            finalize_approve,
            // a vote type to indicate a custodian's rejection of a worker proposal as completed.
            finalize_deny
        };

        enum ProposalState {
            ProposalStatePending_approval = 0,
            ProposalStateWork_in_progress,
            ProposalStatePending_finalize,
            ProposalStateHas_enough_approvals_votes,
            ProposalStateHas_enough_finalize_votes,
            ProposalStateExpired,
            ProposalStateInDispute,
        };

      public:
        TABLE proposal {
            name           proposal_id;
            name           proposer;
            name           arbitrator;
            string         content_hash;
            extended_asset proposal_pay;
            extended_asset arbitrator_pay;
            uint8_t        state;
            time_point_sec expiry;
            uint32_t       job_duration; // job duration in seconds
            uint16_t       category;

            uint64_t primary_key() const { return proposal_id.value; }
            uint64_t proposer_key() const { return proposer.value; }
            uint64_t arbitrator_key() const { return arbitrator.value; }
            uint64_t category_key() const { return uint64_t(category); }

            bool has_not_expired() const {
                time_point_sec time_now = time_point_sec(current_time_point().sec_since_epoch());
                return time_now < expiry;
            }
        };

        typedef eosio::multi_index<"proposals"_n, proposal,
            eosio::indexed_by<"proposer"_n, eosio::const_mem_fun<proposal, uint64_t, &proposal::proposer_key>>,
            eosio::indexed_by<"arbitrator"_n, eosio::const_mem_fun<proposal, uint64_t, &proposal::arbitrator_key>>,
            eosio::indexed_by<"category"_n, eosio::const_mem_fun<proposal, uint64_t, &proposal::category_key>>>
            proposal_table;

        TABLE config {
            uint16_t proposal_threshold = 4;
            uint16_t finalize_threshold = 1;
            uint32_t approval_duration  = 30 * 24 * 60 * 60;
            uint32_t transfer_delay     = 60 * 60;
        };

        typedef eosio::singleton<"config"_n, config> configs_table;

        dacproposals(name receiver, name code, datastream<const char *> ds) : contract(receiver, code, ds) {}

        ACTION createprop(name proposer, string title, string summary, name arbitrator, extended_asset proposal_pay,
            extended_asset arbitrator_pay, string content_hash, name id, uint16_t category, uint32_t job_duration,
            name dac_id);
        ACTION voteprop(name custodian, name proposal_id, uint8_t vote, name dac_id);
        ACTION delegatevote(name custodian, name proposal_id, name delegatee_custodian, name dac_id);
        ACTION delegatecat(name custodian, uint64_t category, name delegatee_custodian, name dac_id);
        ACTION undelegateca(name custodian, uint64_t category, name dac_id);
        ACTION arbapprove(name arbitrator, name proposal_id, name dac_id);
        ACTION arbdeny(name arbitrator, name proposal_id, name dac_id);
        ACTION startwork(name proposal_id, name dac_id);
        /**
         * @brief This action is called from a collection of deferred actions which creates the escrow, it will only
         * update status. It will fail if the escrow already exists so a worker can call start work many times if the
         * first fails. This is ony intended to be called as a deferred inline action from this contract therefore will
         * fail without `get_self()` auth.
         *
         * @param proposal_id the ID for the proposal
         * @param dac_id the Dac ID associated with the DAC that this proposa relates to.
         */
        ACTION runstartwork(name proposal_id, name dac_id);
        using runstartwork_action = action_wrapper<"runstartwork"_n, &dacproposals::runstartwork>;

        ACTION completework(name proposal_id, name dac_id);
        ACTION finalize(name proposal_id, name dac_id);
        ACTION cancelprop(name proposal_id, name dac_id);
        ACTION cancelwip(name proposal_id, name dac_id);
        ACTION dispute(name proposal_id, name dac_id);
        ACTION comment(name commenter, name proposal_id, string comment, string comment_category, name dac_id);
        ACTION updateconfig(config new_config, name dac_id);
        ACTION clearconfig(name dac_id);
        ACTION clearexpprop(name proposal_id, name dac_id);
        ACTION updpropvotes(name proposal_id, name dac_id);
        ACTION updallprops(name dac_id);

      private:
        void    clearprop(const proposal &proposal, name dac_id);
        void    transferfunds(const proposal &prop, name dac_id);
        void    check_start(name proposal_id, name dac_id);
        int16_t count_votes(proposal prop, VoteType vote_type, name dac_id);
        void    arbitrator_rule_on_proposal(name arbitrator, name proposal_id, name dac_id);

        TABLE proposalvote {
            uint64_t           vote_id;
            name               voter;
            optional<name>     proposal_id;
            optional<uint64_t> category_id;
            optional<uint8_t>  vote;
            optional<name>     delegatee;
            optional<string>   comment_hash;

            uint64_t primary_key() const { return vote_id; }
            uint64_t voter_key() const { return voter.value; }

            uint64_t  proposal_key() const { return proposal_id.value_or(name{0}).value; }
            uint64_t  category_key() const { return category_id.value_or(UINT64_MAX); }
            uint128_t get_prop_and_voter() const {
                return combine_ids(proposal_id.value_or(name{0}).value, voter.value);
            }
            uint128_t get_category_and_voter() const {
                return combine_ids(category_id.value_or(UINT64_MAX), voter.value);
            }

            EOSLIB_SERIALIZE(proposalvote, (vote_id)(voter)(proposal_id)(category_id)(vote)(delegatee)(comment_hash))
        };

        typedef eosio::multi_index<"propvotes"_n, proposalvote,
            indexed_by<"voter"_n, eosio::const_mem_fun<proposalvote, uint64_t, &proposalvote::voter_key>>,
            indexed_by<"proposal"_n, eosio::const_mem_fun<proposalvote, uint64_t, &proposalvote::proposal_key>>,
            indexed_by<"category"_n, eosio::const_mem_fun<proposalvote, uint64_t, &proposalvote::category_key>>,
            indexed_by<"propandvoter"_n,
                eosio::const_mem_fun<proposalvote, uint128_t, &proposalvote::get_prop_and_voter>>,
            indexed_by<"catandvoter"_n,
                eosio::const_mem_fun<proposalvote, uint128_t, &proposalvote::get_category_and_voter>>>
            proposal_vote_table;

        config current_configs(name dac_id) {
            configs_table configs(_self, dac_id.value);
            config        conf = configs.get_or_default(config());
            configs.set(conf, _self);
            return conf;
        }
    };
} // namespace eosdac
