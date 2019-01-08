#include <eosiolib/eosio.hpp>
#include "dacproposals.hpp"
#include <typeinfo>

#include <string>

using namespace eosio;
using namespace std;

    ACTION dacproposals::createprop(name proposer, string title, string summary, name arbitrator, asset pay_amount, string content_hash){
        require_auth(proposer);

        eosio_assert(title.length() > 3, "Title length is too short.");
        eosio_assert(summary.length() > 3, "Summary length is too short.");
        eosio_assert(content_hash.length() == 32, "Invalid content hash.");

        proposals.emplace(proposer, [&](proposal &p) {
            p.key = proposals.available_primary_key();
            p.proposer = proposer;
            p.arbitrator = arbitrator;
            p.content_hash = content_hash;
            p.pay_amount = pay_amount;
            p.state = pending_approval;
        });
    }

    ACTION dacproposals::voteprop(name custodian, uint64_t proposal_id, uint8_t vote){
        require_auth(custodian);
        
        const proposal& prop = proposals.get(proposal_id, "Proposal not found.");
        switch (prop.state) {
            case pending_approval:
                eosio_assert(vote == proposal_approve || vote == proposal_deny, "Invalid vote for the current proposal state.");
                break;
            case work_in_progress:
                eosio_assert(vote == claim_approve || vote == claim_deny, "Invalid vote for the current proposal state.");
                break;
            default:
                eosio_assert(false, "Invalid proposal state to accept votes.");
        }

        auto by_prop_and_voter = prop_votes.get_index<"propandvoter"_n>();
        uint128_t joint_id = dacproposals::combine_ids(proposal_id, custodian.value);
        auto vote_idx = by_prop_and_voter.find(joint_id);
        if (vote_idx == by_prop_and_voter.end()) {
            prop_votes.emplace(custodian, [&](proposalvote &v) {
                v.vote_id = prop_votes.available_primary_key();
                v.proposal_id = proposal_id;
                v.voter = custodian;
                v.vote = vote;
            });
        } else {
            by_prop_and_voter.modify(vote_idx, custodian, [&](proposalvote &v) {
                v.vote = vote;
            });
        }
    }

    ACTION dacproposals::startwork(name proposer, uint64_t proposal_id){

        require_auth(proposer);

        const proposal& prop = proposals.get(proposal_id, "Proposal not found.");
        eosio_assert(prop.state == pending_approval,"Proposal is not in the pending approval state therefore cannot start work.");
        auto by_voters = prop_votes.get_index<"proposal"_n>();
        auto vote_idx = by_voters.find(proposal_id);
        int16_t approved_count = 0;
        int16_t deny_count = 0;
        while(vote_idx != by_voters.end()) {
            if (vote_idx->vote == proposal_approve) {
                approved_count++;
            }
            if (vote_idx->vote == proposal_deny) {
                deny_count++;
            }
            vote_idx++;
        }
        eosio_assert(approved_count + deny_count >= current_configs().proposal_threshold, "Insufficient votes on worker proposal");
        double percent_approval = double(approved_count) / double(approved_count + deny_count) * 100.0;
        eosio_assert(percent_approval >= current_configs().proposal_approval_threshold_percent, "Vote approval threshold not met.");
        proposals.modify(prop, proposer, [&](proposal &p){
            p.state = work_in_progress;
        });
        //TODO: Transfer funds to escrow account
        print("Transfer funds to escrow account");
    }

    ACTION dacproposals::claim(name proposer, uint64_t proposal_id){
        require_auth(proposer);
        const proposal& prop = proposals.get(proposal_id, "Proposal not found.");
        eosio_assert(prop.state == work_in_progress,"Proposal is not in the work-in-progress state therefore cannot be claimed as complete.");
        auto by_voters = prop_votes.get_index<"proposal"_n>();
        auto vote_idx = by_voters.find(proposal_id);
        int16_t approved_count = 0;
        int16_t deny_count = 0;
        while(vote_idx != by_voters.end()) {
            if (vote_idx->vote == claim_approve) {
                approved_count++;
}
            if (vote_idx->vote == claim_deny) {
                deny_count++;
}
            vote_idx++;
        }
        eosio_assert(approved_count + deny_count >= current_configs().claim_threshold, "Insufficient votes on worker proposal to approve or deny claim.");
        double percent_approval = double(approved_count) / double(approved_count + deny_count) * 100.0;
        eosio_assert(percent_approval >= current_configs().claim_approval_threshold_percent, "Claim approval threshold not met.");

        proposals.modify(prop, proposer, [&](proposal &p){
            if (percent_approval >= current_configs().claim_approval_threshold_percent) {
                p.state = claim_approved;
                //TODO: Transfer funds from escrow account
                print("Transfer funds from escrow account to proposer.");
            } else {
                p.state = claim_denied;
            }
        });
    }

    ACTION dacproposals::cancel(name proposer, uint64_t proposal_id){
        require_auth(proposer);
        
        auto &proposal = proposals.get(proposal_id, "Proposal not found.");
        proposals.erase(proposal);

        auto by_voters = prop_votes.get_index<"voter"_n>();
        auto vote_idx = by_voters.find(proposal_id);
        while (vote_idx != by_voters.end()) {
            by_voters.erase(vote_idx);
        }
    }

    ACTION dacproposals::updateconfig(configtype new_config) {
        require_auth("dacauthority"_n);
        configs.set(new_config, _self);
    }


EOSIO_DISPATCH(dacproposals,
                (createprop)
                (startwork)
                (voteprop)
                (claim)
                (cancel)
                (updateconfig)
        )
