#include <eosiolib/eosio.hpp>
#include <eosiolib/action.hpp>
#include "dacproposals.hpp"
#include <eosiolib/time.hpp>
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
            p.key = _currentState.last_proposal_id++;
            p.proposer = proposer;
            p.arbitrator = arbitrator;
            p.content_hash = content_hash;
            p.pay_amount = pay_amount;
            p.state = pending_approval;
        });
    }

    ACTION dacproposals::voteprop(name custodian, uint64_t proposal_id, uint8_t vote) {
        require_auth(custodian);
        require_auth(current_configs().authority_account);

        const proposal& prop = proposals.get(proposal_id, "Proposal not found.");
        switch (prop.state) {
            case pending_approval:
                eosio_assert(vote == proposal_approve || vote == proposal_deny, "Invalid vote for the current proposal state.");
                break;
            case pending_claim:
                eosio_assert(vote == claim_approve || vote == claim_deny, "Invalid vote for the current proposal state.");
                break;
            default:
                eosio_assert(false, "Invalid proposal state to accept votes.");
        }

        auto by_prop_and_voter = prop_votes.get_index<"propandvoter"_n>();
        uint128_t joint_id = dacproposals::combine_ids(proposal_id, custodian.value);
        auto vote_idx = by_prop_and_voter.find(joint_id);
        if (vote_idx == by_prop_and_voter.end()) {
            prop_votes.emplace(_self, [&](proposalvote &v) {
                v.vote_id = prop_votes.available_primary_key();
                v.proposal_id = proposal_id;
                v.voter = custodian;
                v.vote = vote;
            });
        } else {
            by_prop_and_voter.modify(vote_idx, _self, [&](proposalvote &v) {
                v.vote = vote;
            });
        }
    }

    ACTION dacproposals::startwork(uint64_t proposal_id){

        const proposal& prop = proposals.get(proposal_id, "Proposal not found.");

        require_auth(prop.proposer);

        eosio_assert(prop.state == pending_approval, "Proposal is not in the pending approval state therefore cannot start work.");

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
        proposals.modify(prop, prop.proposer, [&](proposal &p){
            p.state = work_in_progress;
        });

        print("Transfer funds to escrow account");
        time_point_sec time_now = time_point_sec(now());
        string memo = prop.proposer.to_string() + ":" + to_string(proposal_id) + ":" + prop.content_hash;

        auto inittuple = make_tuple( _self, prop.proposer, prop.arbitrator, time_now + current_configs().escrow_expiry, memo, std::optional<uint64_t>(proposal_id));

        eosio::action(
                eosio::permission_level{_self , "active"_n },
                current_configs().service_account, "init"_n,
                inittuple
        ).send();

        eosio::action(
                eosio::permission_level{_self , "active"_n },
                "eosio.token"_n, "transfer"_n,
                make_tuple( _self, current_configs().service_account, prop.pay_amount, "payment for wp: " + to_string(proposal_id))
        ).send();
    }

    ACTION dacproposals::completework(uint64_t proposal_id){

        const proposal& prop = proposals.get(proposal_id, "Proposal not found.");

        require_auth(prop.proposer);

        proposals.modify(prop, prop.proposer, [&](proposal &p){
            p.state = pending_claim;
        });
    }

    ACTION dacproposals::claim(uint64_t proposal_id){
        const proposal& prop = proposals.get(proposal_id, "Proposal not found.");
        require_auth(prop.proposer);

        eosio_assert(prop.state == pending_claim, "Proposal is not in the pending_claim state therefore cannot be claimed for payment.");
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

        if (percent_approval >= current_configs().claim_approval_threshold_percent) {
            print("Transfer funds from escrow account to proposer.");

            eosio::action(
                    eosio::permission_level{_self , "active"_n },
                    current_configs().service_account, "approveext"_n,
                    make_tuple( proposal_id, _self)
            ).send();

            clearprop(prop);
        } else {
            proposals.modify(prop, prop.proposer, [&](proposal &p){
                p.state = claim_denied;
            });
        }
    }

    ACTION dacproposals::cancel(uint64_t proposal_id){
        const proposal& prop = proposals.get(proposal_id, "Proposal not found.");
        clearprop(prop);
    }

    ACTION dacproposals::updateconfig(configtype new_config) {
        require_auth(current_configs().authority_account);
        configs.set(new_config, _self);
    }

//    Private methods

    void dacproposals::clearprop(const proposal& proposal){
        require_auth(proposal.proposer);

        // Remove all the votes associated with that proposal.
        auto by_voters = prop_votes.get_index<"proposal"_n>();
        auto itr = by_voters.find(proposal.key);
        while(itr != by_voters.end()) {
            print(itr->voter);
            itr = by_voters.erase(itr);
        }

        proposals.erase(proposal);
    }


EOSIO_DISPATCH(dacproposals,
                (createprop)
                (startwork)
                (completework)
                (voteprop)
                (claim)
                (cancel)
                (updateconfig)
        )
