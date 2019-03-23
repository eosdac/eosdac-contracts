#include <eosiolib/eosio.hpp>
#include <eosiolib/action.hpp>
#include "dacproposals.hpp"
#include <eosiolib/time.hpp>
#include <typeinfo>

#include <string>

using namespace eosio;
using namespace std;

    ACTION dacproposals::createprop(name proposer, string title, string summary, name arbitrator, extended_asset pay_amount, string content_hash, uint64_t id, name dac_scope){
        require_auth(proposer);
        assertValidMember(proposer);
        eosio_assert(proposals.find(id) == proposals.end(), "A Proposal with the id already exists. Try again with a different id.");

        eosio_assert(title.length() > 3, "Title length is too short.");
        eosio_assert(summary.length() > 3, "Summary length is too short.");
        // eosio_assert(content_hash.length() == 32, "Invalid content hash.");
        eosio_assert(pay_amount.quantity.symbol.is_valid(), "Invalid pay amount symbol.");
        eosio_assert(pay_amount.quantity.amount > 0, "Invalid pay amount. Must be greater than 0.");
        eosio_assert(is_account(arbitrator), "Invalid arbitrator.");

        proposals.emplace(proposer, [&](proposal &p) {
            p.key = id;
            p.proposer = proposer;
            p.arbitrator = arbitrator;
            p.content_hash = content_hash;
            p.pay_amount = pay_amount;
            p.state = pending_approval;
            p.expiry = time_point_sec(now()) + current_configs().approval_expiry;   
        });
    }

    ACTION dacproposals::voteprop(name custodian, uint64_t proposal_id, uint8_t vote) {
        require_auth(custodian);
        require_auth(current_configs().authority_account);
        assertValidMember(custodian);

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

    ACTION dacproposals::arbapprove(name arbitrator, uint64_t proposal_id) {
        require_auth(arbitrator);
        const proposal& prop = proposals.get(proposal_id, "Proposal not found.");
        clearprop(prop);
    }

    ACTION dacproposals::startwork(uint64_t proposal_id){

        const proposal& prop = proposals.get(proposal_id, "Proposal not found.");

        eosio_assert(prop.state == pending_approval, "Proposal is not in the pending approval state therefore cannot start work.");
        
        time_point_sec time_now = time_point_sec(now());
        if (prop.has_expired(time_now)) {
            print_f("The proposal with proposal_id: % has expired and will now be removed.", proposal_id);
            clearprop(prop);
            return;
        }
        
        require_auth(prop.proposer);
        assertValidMember(prop.proposer);

        custodians_table custodians("daccustodian"_n, "daccustodian"_n.value);

        std::set<eosio::name> current_custodians;

        for(custodian cust: custodians) {
            current_custodians.insert(cust.cust_name);
        }

        auto by_voters = prop_votes.get_index<"proposal"_n>();
        auto vote_idx = by_voters.find(proposal_id);
        int16_t approved_count = 0;
        while(vote_idx != by_voters.end()) {
            if (vote_idx->vote == proposal_approve && 
                current_custodians.find(vote_idx->voter) != current_custodians.end()) {
                    approved_count++;
            }
            vote_idx++;
        }
        eosio_assert(approved_count >= current_configs().proposal_threshold, "Insufficient votes on worker proposal");
        proposals.modify(prop, prop.proposer, [&](proposal &p){
            p.state = work_in_progress;
        });

        // print("Transfer funds to escrow account");
        string memo = prop.proposer.to_string() + ":" + to_string(proposal_id) + ":" + prop.content_hash;

        auto inittuple = make_tuple(current_configs().treasury_account, prop.proposer, prop.arbitrator, time_now + current_configs().escrow_expiry, memo, std::optional<uint64_t>(proposal_id));

        eosio::action(
                eosio::permission_level{current_configs().treasury_account , "active"_n },
                current_configs().service_account, "init"_n,
                inittuple
        ).send();

        eosio::action(
                eosio::permission_level{current_configs().treasury_account , "xfer"_n },
                prop.pay_amount.contract, "transfer"_n,
                make_tuple(current_configs().treasury_account, current_configs().service_account, prop.pay_amount.quantity, "payment for wp: " + to_string(proposal_id))
        ).send();
    }

    ACTION dacproposals::completework(uint64_t proposal_id){

        const proposal& prop = proposals.get(proposal_id, "Proposal not found.");

        require_auth(prop.proposer);
        assertValidMember(prop.proposer);
        eosio_assert(prop.state == work_in_progress, "Worker proposal can only be completed from work_in_progress state");

        proposals.modify(prop, prop.proposer, [&](proposal &p){
            p.state = pending_claim;
        });
    }

    ACTION dacproposals::claim(uint64_t proposal_id) {
        const proposal& prop = proposals.get(proposal_id, "Proposal not found.");
        require_auth(prop.proposer);
        assertValidMember(prop.proposer);

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
            transferfunds(prop);
        } 
    }

    ACTION dacproposals::cancel(uint64_t proposal_id){
        const proposal& prop = proposals.get(proposal_id, "Proposal not found.");
        require_auth(prop.proposer);
        assertValidMember(prop.proposer);
        clearprop(prop);
    }

    ACTION dacproposals::comment(name commenter, uint64_t proposal_id, string comment, string comment_category) {
        require_auth(commenter);
        assertValidMember(commenter);
        const proposal& prop = proposals.get(proposal_id, "Proposal not found.");
        if (!has_auth(prop.proposer)) {
            require_auth(current_configs().authority_account);
        }
    }

    ACTION dacproposals::updateconfig(config new_config) {
        if (current_configs().authority_account == name{0}) {
            require_auth(_self);
        } else {
            require_auth(current_configs().authority_account);
        }

        configs.set(new_config, _self);
    }

//    Private methods
    void dacproposals::transferfunds(const proposal &prop) {
        eosio::action(
                eosio::permission_level{current_configs().treasury_account, "active"_n },
                current_configs().service_account, "approveext"_n,
                make_tuple( prop.key, current_configs().treasury_account)
            ).send();

        clearprop(prop);
    }

    void dacproposals::clearprop(const proposal& proposal){
        // require_auth(proposal.proposer);
        // assertValidMember(proposal.proposer);

        // Remove all the votes associated with that proposal.
        auto by_voters = prop_votes.get_index<"proposal"_n>();
        auto itr = by_voters.find(proposal.key);
        while(itr != by_voters.end()) {
            print(itr->voter);
            itr = by_voters.erase(itr);
        }

        proposals.erase(proposal);
    }

    void dacproposals::assertValidMember(name member) {
    name member_terms_account = current_configs().member_terms_account;
    regmembers reg_members(member_terms_account, member_terms_account.value);
    memterms memberterms(member_terms_account, member_terms_account.value);

    const auto &regmem = reg_members.get(member.value, "ERR::GENERAL_REG_MEMBER_NOT_FOUND::Account is not registered with members.");
    eosio_assert((regmem.agreedterms != 0), "ERR::GENERAL_MEMBER_HAS_NOT_AGREED_TO_ANY_TERMS::Account has not agreed to any terms");
    auto latest_member_terms = (--memberterms.end());
    eosio_assert(latest_member_terms->version == regmem.agreedterms, "ERR::GENERAL_MEMBER_HAS_NOT_AGREED_TO_LATEST_TERMS::Agreed terms isn't the latest.");
}

EOSIO_DISPATCH(dacproposals,
                (createprop)
                (startwork)
                (completework)
                (voteprop)
                (claim)
                (cancel)
                (comment)
                (updateconfig)
        )
