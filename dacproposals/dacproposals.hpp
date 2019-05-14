#include <eosio/eosio.hpp>
#include <eosio/asset.hpp>
#include <eosio/singleton.hpp>
#include <eosio/time.hpp>

#include "../_contract-shared-headers/dacdirectory_shared.hpp"
#include "../_contract-shared-headers/eosdactokens_types.hpp"
#include "../_contract-shared-headers/daccustodian_types.hpp"

using namespace eosio;
using namespace std;

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
        ProposalStateExpired
    };

    public:

    TABLE proposal {
            uint64_t key;
            name proposer;
            name arbitrator;
            string content_hash;
            extended_asset pay_amount;
            uint8_t state;
            time_point_sec expiry;
            uint16_t category;

            uint64_t primary_key() const { return key; }
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
            eosio::indexed_by<"category"_n, eosio::const_mem_fun<proposal, uint64_t, &proposal::category_key>>
    > proposal_table;

    TABLE config {
            uint16_t proposal_threshold = 4;
            uint16_t finalize_threshold = 1;
            uint32_t escrow_expiry = 30 * 24 * 60 * 60;
            uint32_t approval_expiry = 30 * 24 * 60 * 60;
    };

    typedef eosio::singleton<"config"_n, config> configs_table;


    dacproposals( name receiver, name code, datastream<const char*> ds )
         : contract(receiver, code, ds) {}

    ACTION createprop(name proposer, string title, string summary, name arbitrator, extended_asset pay_amount, string content_hash, uint64_t id, uint16_t category, name dac_scope);
    ACTION voteprop(name custodian, uint64_t proposal_id, uint8_t vote, name dac_scope);
    ACTION delegatevote(name custodian, uint64_t proposal_id, name delegatee_custodian, name dac_scope);
    ACTION delegatecat(name custodian, uint64_t category, name delegatee_custodian, name dac_scope);
    ACTION undelegateca(name custodian, uint64_t category, name dac_scope);
    ACTION arbapprove(name arbitrator, uint64_t proposal_id, name dac_scope);
    ACTION startwork(uint64_t proposal_id, name dac_scope);
    ACTION completework(uint64_t proposal_id, name dac_scope);
    ACTION finalize(uint64_t proposal_id, name dac_scope);
    ACTION cancel(uint64_t proposal_id, name dac_scope);
    ACTION comment(name commenter, uint64_t proposal_id, string comment, string comment_category, name dac_scope);
    ACTION updateconfig(config new_config, name dac_scope);
    ACTION clearexpprop(uint64_t proposal_id, name dac_scope);
    ACTION updpropvotes(uint64_t proposal_id, name dac_scope);
    ACTION updallprops(name dac_scope);


private:

    void clearprop(const proposal& proposal, name dac_scope);
    void transferfunds(const proposal &prop, name dac_scope);
    int16_t count_votes(proposal prop, VoteType vote_type, name dac_scope);
    void assertValidMember(name member, name dac_scope);

TABLE proposalvote {
        uint64_t vote_id;
        name voter;
        optional<uint64_t> proposal_id;
        optional<uint64_t> category_id;
        optional<uint8_t> vote;
        optional<name> delegatee;
        optional<string> comment_hash;

        uint64_t primary_key() const { return vote_id; }
        uint64_t voter_key() const { return voter.value; }

        uint64_t proposal_key() const { return proposal_id.value_or(UINT64_MAX); }
        uint64_t category_key() const { return category_id.value_or(UINT64_MAX); }
        uint128_t get_prop_and_voter() const { return combine_ids(proposal_id.value_or(UINT64_MAX), voter.value); }
        uint128_t get_category_and_voter() const { return combine_ids(category_id.value_or(UINT64_MAX), voter.value); }

        EOSLIB_SERIALIZE(proposalvote, (vote_id)(voter)(proposal_id)(category_id)(vote)(delegatee)(comment_hash))

    };

    typedef eosio::multi_index<"propvotes"_n, proposalvote,
    indexed_by<"voter"_n, eosio::const_mem_fun<proposalvote, uint64_t, &proposalvote::voter_key>>,
    indexed_by<"proposal"_n, eosio::const_mem_fun<proposalvote, uint64_t, &proposalvote::proposal_key>>,
    indexed_by<"category"_n, eosio::const_mem_fun<proposalvote, uint64_t, &proposalvote::category_key>>,
    indexed_by<"propandvoter"_n, eosio::const_mem_fun<proposalvote, uint128_t, &proposalvote::get_prop_and_voter>>,
    indexed_by<"catandvoter"_n, eosio::const_mem_fun<proposalvote, uint128_t, &proposalvote::get_category_and_voter>>
    > proposal_vote_table;

    static const uint128_t combine_ids(const uint64_t &x, const uint64_t &y) {
        return (uint128_t{x} << 64) | y;
    }

    config current_configs(name dac_scope) {
        configs_table configs(_self, dac_scope.value);
        config conf = configs.get_or_default(config());
        configs.set(conf, _self);
        return conf;
    }
};