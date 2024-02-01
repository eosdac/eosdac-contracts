#include "dacproposals.hpp"
#include "../dacescrow/dacescrow.hpp"
#include <algorithm>
#include <eosio/action.hpp>
#include <eosio/eosio.hpp>
#include <eosio/time.hpp>
#include <eosio/transaction.hpp>
#include <typeinfo>

#include "../../contract-shared-headers/dacdirectory_shared.hpp"
#include "../../contract-shared-headers/eosdactokens_shared.hpp"

namespace eosdac {

    ACTION dacproposals::createprop(name proposer, string title, string summary, name arbiter,
        extended_asset proposal_pay, extended_asset arbiter_pay, string content_hash, name id, uint16_t category,
        uint32_t job_duration, name dac_id) {
        require_auth(proposer);
        assertValidMember(proposer, dac_id);
        proposal_table proposals(get_self(), dac_id.value);

        check(proposer != arbiter, "You cannot nominate yourself as the arbiter for a proposal.");

        check(proposals.find(id.value) == proposals.end(),
            "ERR::CREATEPROP_DUPLICATE_ID::A Proposal with the id already exists. Try again with a different id.");

        check(title.length() > 3, "ERR::CREATEPROP_SHORT_TITLE::Title length is too short.");
        check(summary.length() > 3, "ERR::CREATEPROP_SHORT_SUMMARY::Summary length is too short.");
        check(proposal_pay.quantity.symbol.is_valid(), "ERR::CREATEPROP_INVALID_SYMBOL::Invalid pay amount symbol.");
        check(proposal_pay.quantity.amount > 0,
            "ERR::CREATEPROP_INVALID_proposal_pay::Invalid pay amount. Must be greater than 0.");
        check(is_account(arbiter), "ERR::CREATEPROP_INVALID_arbiter::Invalid arbiter.");

        auto dac            = dacdir::dac_for_id(dac_id);
        auto funding_source = dac.account_for_type(dacdir::SPENDINGS);
        auto auth           = dac.owner;
        check(arbiter != auth && arbiter != funding_source, "arbiter must be a third party");
        auto current_configs = configs{get_self(), dac_id};

        uint32_t approval_duration = current_configs.get_approval_duration();

        proposals.emplace(proposer, [&](proposal &p) {
            p.proposal_id  = id;
            p.proposer     = proposer;
            p.arbiter      = arbiter;
            p.content_hash = content_hash;
            p.proposal_pay = proposal_pay;
            p.arbiter_pay  = arbiter_pay;
            p.state        = STATE_PENDING_APPROVAL;
            p.category     = category;
            p.job_duration = job_duration;
            p.expiry       = time_point_sec(current_time_point().sec_since_epoch()) + approval_duration;
        });
    }

    ACTION dacproposals::voteprop(name custodian, name proposal_id, name vote, name dac_id) {
        switch (VoteTypePublic{vote.value}) {
        case vote_approve:
            _voteprop(custodian, proposal_id, VOTE_PROP_APPROVE, dac_id);
            break;
        case vote_deny:
            _voteprop(custodian, proposal_id, VOTE_PROP_DENY, dac_id);
            break;
        case vote_abstain:
            _voteprop(custodian, proposal_id, ""_n, dac_id);
            break;
        default:
            check(false, "voteprop called with invalid vote type %s. Allowed %s or %s", vote, VOTE_APPROVE, VOTE_DENY);
        }
    }

    ACTION dacproposals::votepropfin(name custodian, name proposal_id, name vote, name dac_id) {
        switch (VoteTypePublic{vote.value}) {
        case vote_approve:
            _voteprop(custodian, proposal_id, VOTE_FINAL_APPROVE, dac_id);
            break;
        case vote_deny:
            _voteprop(custodian, proposal_id, VOTE_FINAL_DENY, dac_id);
            break;
        case vote_abstain:
            _voteprop(custodian, proposal_id, ""_n, dac_id);
            break;
        default:
            check(
                false, "votepropfin called with invalid vote type %s. Allowed %s or %s", vote, VOTE_APPROVE, VOTE_DENY);
        }
    }

    void dacproposals::_voteprop(name custodian, name proposal_id, name vote, name dac_id) {
        require_auth(custodian);

        auto auth_account = dacdir::dac_for_id(dac_id).owner;
        require_auth(auth_account);

        assertValidMember(custodian, dac_id);

        auto proposals = proposal_table{_self, dac_id.value};

        const proposal &prop =
            proposals.get(proposal_id.value, "ERR::VOTEPROP_PROPOSAL_NOT_FOUND::Proposal not found.﻿");
        switch (ProposalState{prop.state.value}) {
        case ProposalStatePending_approval:
        case ProposalStateHas_enough_approvals_votes:
            check(prop.has_not_expired(), "ERR::PROPOSAL_EXPIRED::Proposal has expired.");
            check(vote == VOTE_PROP_APPROVE || vote == VOTE_PROP_DENY,
                "ERR::VOTEPROP_INVALID_VOTE::Invalid vote for the current proposal state.");
            break;
        case ProposalStatePending_finalize:
        case ProposalStateHas_enough_finalize_votes:
            check(vote == VOTE_FINAL_APPROVE || vote == VOTE_FINAL_DENY,
                "ERR::VOTEPROP_INVALID_VOTE::Invalid vote for the current proposal state.");
            break;
        default:
            check(false, "ERR::VOTEPROP_INVALID_PROPOSAL_STATE::Invalid proposal state to accept votes.");
        }

        proposal_vote_table prop_votes(_self, dac_id.value);
        auto                by_prop_and_voter = prop_votes.get_index<"propandvoter"_n>();
        uint128_t           joint_id          = combine_ids(proposal_id.value, custodian.value);
        auto                vote_idx          = by_prop_and_voter.find(joint_id);
        if (vote_idx == by_prop_and_voter.end()) {
            prop_votes.emplace(_self, [&](proposalvote &v) {
                v.vote_id     = prop_votes.available_primary_key();
                v.proposal_id = proposal_id;
                v.voter       = custodian;
                v.vote        = vote;
                v.delegatee   = nullopt;
            });
        } else {
            by_prop_and_voter.modify(vote_idx, _self, [&](proposalvote &v) {
                v.vote      = vote;
                v.delegatee = nullopt;
            });
        }

        updpropvotes(proposal_id, dac_id);
    }

    ACTION dacproposals::delegatevote(name custodian, name proposal_id, name delegatee_custodian, name dac_id) {
        require_auth(custodian);
        auto auth_account = dacdir::dac_for_id(dac_id).owner;
        require_auth(auth_account);

        assertValidMember(custodian, dac_id);
        check(custodian != delegatee_custodian, "ERR::DELEGATEVOTE_DELEGATE_SELF::Cannot delegate voting to yourself.");

        proposal_table proposals(_self, dac_id.value);

        const proposal &prop = proposals.get(proposal_id.value, "ERR::PROPOSAL_NOT_FOUND::Proposal not found.");
        check(prop.has_not_expired(), "ERR::PROPOSAL_EXPIRED::Proposal has expired.");

        proposal_vote_table prop_votes(_self, dac_id.value);
        auto                by_prop_and_voter = prop_votes.get_index<"propandvoter"_n>();
        uint128_t           joint_id          = combine_ids(proposal_id.value, custodian.value);
        auto                vote_idx          = by_prop_and_voter.find(joint_id);
        if (vote_idx == by_prop_and_voter.end()) {
            prop_votes.emplace(_self, [&](proposalvote &v) {
                v.vote_id     = prop_votes.available_primary_key();
                v.proposal_id = proposal_id;
                v.voter       = custodian;
                v.vote        = nullopt;
                v.delegatee   = delegatee_custodian;
            });
        } else {
            by_prop_and_voter.modify(vote_idx, _self, [&](proposalvote &v) {
                v.vote      = nullopt;
                v.delegatee = delegatee_custodian;
            });
        }

        updpropvotes(proposal_id, dac_id);
    }

    ACTION dacproposals::delegatecat(name custodian, uint64_t category, name delegatee_custodian, name dac_id) {
        require_auth(custodian);
        auto auth_account = dacdir::dac_for_id(dac_id).owner;
        require_auth(auth_account);
        assertValidMember(custodian, dac_id);
        check(custodian != delegatee_custodian, "ERR::DELEGATEVOTE_DELEGATE_SELF::Cannot delegate voting to yourself.");

        proposal_vote_table prop_votes(_self, dac_id.value);

        auto      by_cat_and_voter = prop_votes.get_index<"catandvoter"_n>();
        uint128_t joint_id         = combine_ids(category, custodian.value);
        auto      vote_idx         = by_cat_and_voter.find(joint_id);
        if (vote_idx == by_cat_and_voter.end()) {
            prop_votes.emplace(_self, [&](proposalvote &v) {
                v.vote_id     = prop_votes.available_primary_key();
                v.category_id = category;
                v.voter       = custodian;
                v.delegatee   = delegatee_custodian;
            });
        } else {
            by_cat_and_voter.modify(vote_idx, _self, [&](proposalvote &v) {
                v.delegatee = delegatee_custodian;
            });
        }
    }

    ACTION dacproposals::undelegateca(name custodian, uint64_t category, name dac_id) {
        require_auth(custodian);

        proposal_vote_table prop_votes(_self, dac_id.value);
        auto                by_cat_and_voter = prop_votes.get_index<"catandvoter"_n>();

        uint128_t joint_id = combine_ids(category, custodian.value);
        auto      vote_idx = by_cat_and_voter.find(joint_id);
        check(vote_idx != by_cat_and_voter.end(),
            "ERR::UNDELEGATECA_NO_EXISTING_VOTE::Cannot undelegate category vote with pre-existing vote.");
        by_cat_and_voter.erase(vote_idx);
    }

    ACTION dacproposals::arbdeny(name arbiter, name proposal_id, name dac_id) {
        arbiter_rule_on_proposal(arbiter, proposal_id, dac_id);
    }

    ACTION dacproposals::arbapprove(name arbiter, name proposal_id, name dac_id) {
        arbiter_rule_on_proposal(arbiter, proposal_id, dac_id);
    }

    ACTION dacproposals::arbagree(name arbiter, name proposal_id, name dac_id) {
        require_auth(arbiter);

        auto proposals = proposal_table{get_self(), dac_id.value};

        const proposal &prop = proposals.get(proposal_id.value, "ERR::PROPOSAL_NOT_FOUND::Proposal not found.");

        check(prop.arbiter == arbiter, "ERR::INCORRECT_ABITER::You are not the arbiter for this proposal");

        check(prop.state == STATE_PENDING_APPROVAL || prop.state == STATE_HAS_ENOUGH_APP_VOTES,
            "ERR::ARBAGREE_WRONG_STATE::Proposal is not in the pending approval state therefore cannot be agreed to by the arbiter.");

        proposals.modify(prop, same_payer, [&](auto &p) {
            p.arbiter_agreed = true;
        });
    }

    ACTION dacproposals::startwork(name proposal_id, name dac_id) {

        auto        proposals = proposal_table{get_self(), dac_id.value};
        const auto &prop      = proposals.get(proposal_id.value, "ERR::PROPOSAL_NOT_FOUND::Proposal not found.");

        require_auth(prop.proposer);
        check_proposal_can_start(proposal_id, dac_id);
        check(
            prop.arbiter_agreed, "ERR::STARTWORK_NO_ARBITER_AGREEMENT::Arbiter has not agreed to be on the proposal.");

        assertValidMember(prop.proposer, dac_id);

        string memo = prop.proposer.to_string() + ":" + proposal_id.to_string() + ":" + prop.content_hash;

        time_point_sec time_now = time_point_sec(current_time_point().sec_since_epoch());

        const auto funding_source = dacdir::dac_for_id(dac_id).account_for_type(dacdir::SPENDINGS);
        const auto escrow         = dacdir::dac_for_id(dac_id).account_for_type(dacdir::ESCROW);

        check(is_account(funding_source), "ERR::FUNDING_SOURCE_ACCOUNT_NOT_FOUND::Funding account not found");
        check(is_account(escrow), "ERR::ESCROW_ACCOUNT_NOT_FOUND::Escrow account not found");

        proposals.modify(prop, same_payer, [&](auto &p) {
            p.state = STATE_IN_PROGRESS;
        });

        dacescrow::init_action{escrow, {funding_source, "active"_n}}
            .to_action(funding_source, prop.proposer, prop.arbiter, time_now + (prop.job_duration * 2), memo,
                proposal_id, dac_id)
            .send();

        action(eosio::permission_level{funding_source, "active"_n}, prop.proposal_pay.contract, "transfer"_n,
            make_tuple(funding_source, escrow, prop.proposal_pay.quantity,
                "rec:" + proposal_id.to_string() + ":" + dac_id.to_string()))
            .send();

        action(eosio::permission_level{funding_source, "active"_n}, prop.arbiter_pay.contract, "transfer"_n,
            make_tuple(funding_source, escrow, prop.arbiter_pay.quantity,
                "arb:" + proposal_id.to_string() + ":" + dac_id.to_string()))
            .send();
    }

    ACTION dacproposals::completework(name proposal_id, name dac_id) {

        proposal_table proposals(_self, dac_id.value);

        const proposal &prop = proposals.get(proposal_id.value, "ERR::PROPOSAL_NOT_FOUND::Proposal not found.");

        require_auth(prop.proposer);
        assertValidMember(prop.proposer, dac_id);
        check(prop.state == STATE_IN_PROGRESS,
            "ERR::COMPLETEWORK_WRONG_STATE::Worker proposal can only be completed from work_in_progress state");

        proposals.modify(prop, prop.proposer, [&](proposal &p) {
            p.state = STATE_PENDING_FINALIZE;
        });
    }

    ACTION dacproposals::finalize(name proposal_id, name dac_id) {

        proposal_table proposals(_self, dac_id.value);

        const proposal &prop = proposals.get(proposal_id.value, "ERR::PROPOSAL_NOT_FOUND::Proposal not found.");

        check(prop.state == STATE_PENDING_FINALIZE || prop.state == STATE_HAS_ENOUGH_FIN_VOTES,
            "ERR::FINALIZE_WRONG_STATE::Proposal is not in the pending_finalize state therefore cannot be finalized.");

        int16_t approved_count = count_votes(prop, finalize_approve, dac_id);

        print_f("Worker proposal % for finalizing with: % votes\n", proposal_id.value, approved_count);
        auto current_configs = configs{get_self(), dac_id};

        check(approved_count >= current_configs.get_finalize_threshold(),
            "ERR::FINALIZE_INSUFFICIENT_VOTES::Insufficient votes on worker proposal to be finalized.");

        transferfunds(prop, dac_id);
    }

    ACTION dacproposals::cancelprop(name proposal_id, name dac_id) {

        auto escrow = dacdir::dac_for_id(dac_id).account_for_type(dacdir::ESCROW);
        check(is_account(escrow), "ERR::ESCROW_ACCOUNT_NOT_FOUND::Escrow account not found");

        proposal_table  proposals(_self, dac_id.value);
        const proposal &prop = proposals.get(proposal_id.value, "ERR::PROPOSAL_NOT_FOUND::Proposal not found.");
        require_auth(prop.proposer);
        check(prop.state == STATE_PENDING_APPROVAL || prop.state == STATE_HAS_ENOUGH_APP_VOTES,
            "ERR::CANCELPROP_WRONG_STATE::Worker proposal is in the wrong state to be cancelled with cancelprop. Try cancelwip.");

        escrows_table escrows = escrows_table(escrow, dac_id.value);
        auto          esc_itr = escrows.find(proposal_id.value);
        check(esc_itr == escrows.end(),
            "ERR::ESCROW_ACTIVE::There should not be an escrow for a proposal. Call cancelwip instead.");

        assertValidMember(prop.proposer, dac_id);
        clearprop(prop, dac_id);
    }

    ACTION dacproposals::cancelwip(name proposal_id, name dac_id) {

        proposal_table  proposals(_self, dac_id.value);
        const proposal &prop = proposals.get(proposal_id.value, "ERR::PROPOSAL_NOT_FOUND::Proposal not found.");
        require_auth(prop.proposer);
        check(prop.state == STATE_IN_PROGRESS || prop.state == STATE_PENDING_FINALIZE,
            "ERR::CANCELWIP_WRONG_STATE::Worker proposal is in the wrong state to be cancelled with cancelwip. Try cancelprop.");

        auto escrow = dacdir::dac_for_id(dac_id).account_for_type(dacdir::ESCROW);
        check(is_account(escrow), "ERR::ESCROW_ACCOUNT_NOT_FOUND::Escrow account not found");
        escrows_table escrows = escrows_table(escrow, dac_id.value);
        auto          esc_itr = escrows.find(proposal_id.value);
        check(esc_itr != escrows.end(),
            "ERR::ESCROW_ACTIVE::There should be an escrow for a proposal for this action. Call cancelprop instead.");

        assertValidMember(prop.proposer, dac_id);
        clearprop(prop, dac_id);
    }

    ACTION dacproposals::dispute(name proposal_id, name dac_id) {
        // The escrow should be locked first in a Transaction.
        auto escrow = dacdir::dac_for_id(dac_id).account_for_type(dacdir::ESCROW);
        check(is_account(escrow), "ERR::ESCROW_ACCOUNT_NOT_FOUND::Escrow account not found");
        escrows_table escrows = escrows_table(escrow, dac_id.value);
        auto          esc_itr = escrows.find(proposal_id.value);
        check(esc_itr != escrows.end(),
            "ERR::ESCROW_ACTIVE::There should be an escrow for a proposal for this action. Call cancelprop instead.");
        check(esc_itr->disputed,
            "ERR::ESCROW_NOT_LOCKED::The escrow should be locked before disputing - best done within the same transaction.");

        proposal_table proposals(_self, dac_id.value);

        const proposal &prop = proposals.get(proposal_id.value, "ERR::PROPOSAL_NOT_FOUND::Proposal not found.");

        require_auth(prop.proposer);
        assertValidMember(prop.proposer, dac_id);
        check(prop.state == STATE_PENDING_FINALIZE,
            "ERR::DISPUTE_WRONG_STATE::Worker proposal can only be disputed from Pending_finalize state");

        proposals.modify(prop, prop.proposer, [&](proposal &p) {
            p.state = STATE_DISPUTED;
        });
    }

    ACTION
    dacproposals::comment(name commenter, name proposal_id, string comment, string comment_category, name dac_id) {
        require_auth(commenter);
        assertValidMember(commenter, dac_id);

        proposal_table proposals(_self, dac_id.value);

        const proposal &prop = proposals.get(proposal_id.value, "ERR::PROPOSAL_NOT_FOUND::Proposal not found.");
        if (!has_auth(prop.proposer)) {
            auto auth_account = dacdir::dac_for_id(dac_id).owner;
            require_auth(auth_account);
        }
    }

    ACTION dacproposals::updateconfig(config new_config, name dac_id) {

        auto auth_account = dacdir::dac_for_id(dac_id).owner;
        require_auth(auth_account);
        auto current_configs = configs{get_self(), dac_id};
        current_configs.set_proposal_threshold(new_config.proposal_threshold);
        current_configs.set_finalize_threshold(new_config.finalize_threshold);
        current_configs.set_approval_duration(new_config.approval_duration);
    }

    // ACTION dacproposals::clearconfig(name dac_id) {
    //     auto auth_account = dacdir::dac_for_id(dac_id).owner;
    //     require_auth(auth_account);

    //     configs_table configs(_self, dac_id.value);
    //     if (configs.exists()) {
    //         configs.remove();
    //     }
    // }

    ACTION dacproposals::clearexpprop(name proposal_id, name dac_id) {
        proposal_table  proposals(_self, dac_id.value);
        const proposal &prop = proposals.get(proposal_id.value, "ERR::PROPOSAL_NOT_FOUND::Proposal not found.");

        auto          escrow  = dacdir::dac_for_id(dac_id).account_for_type(dacdir::ESCROW);
        escrows_table escrows = escrows_table(escrow, dac_id.value);

        check(is_account(escrow), "ERR::ESCROW_ACCOUNT_NOT_FOUND::Escrow account not found");
        auto esc_itr = escrows.find(proposal_id.value);
        // If there is an escrow then the proposal should be expired before it can be cleared.
        if (esc_itr != escrows.end()) {

            check(!prop.has_not_expired(),
                "ERR::PROPOSAL_NOT_EXPIRED::The proposal has not expired so cannot be cleared yet.");
        }
        clearprop(prop, dac_id);
    }

    ACTION dacproposals::updpropvotes(name proposal_id, name dac_id) {
        proposal_table proposals(_self, dac_id.value);

        const proposal &prop = proposals.get(proposal_id.value, "ERR::PROPOSAL_NOT_FOUND::Proposal not found.");

        int16_t       approved_count;
        ProposalState newPropState;

        switch (ProposalState{prop.state.value}) {
        case ProposalStatePending_approval:
        case ProposalStateHas_enough_approvals_votes:
            if (!prop.has_not_expired()) {
                newPropState = ProposalStateExpired;
            } else {
                approved_count = count_votes(prop, proposal_approve, dac_id);
                newPropState   = (approved_count >= configs(get_self(), dac_id).get_proposal_threshold())
                                     ? ProposalStateHas_enough_approvals_votes
                                     : ProposalStatePending_approval;
            }
            break;
        case ProposalStatePending_finalize:
        case ProposalStateHas_enough_finalize_votes:
            approved_count = count_votes(prop, finalize_approve, dac_id);
            newPropState   = (approved_count >= configs(get_self(), dac_id).get_finalize_threshold())
                                 ? ProposalStateHas_enough_finalize_votes
                                 : ProposalStatePending_finalize;
            break;
        case ProposalStateExpired:
        case ProposalStateInDispute:
        case ProposalStateWork_in_progress:
            check(false, "ERR::UPDPROPVOTES_WRONG_STATE::Cannot update votes for this proposal state");
        }
        if (prop.state != name{newPropState}) {
            proposals.modify(prop, prop.proposer, [&](proposal &p) {
                p.state = name{newPropState};
            });
        }
    }

    void dacproposals::transferfunds(const proposal &prop, name dac_id) {
        proposal_table proposals(_self, dac_id.value);
        auto           funding_source = dacdir::dac_for_id(dac_id).account_for_type(dacdir::SPENDINGS);
        auto           escrow         = dacdir::dac_for_id(dac_id).account_for_type(dacdir::ESCROW);

        eosio::action(eosio::permission_level{funding_source, "active"_n}, escrow, "approve"_n,
            make_tuple(prop.proposal_id.value, funding_source, dac_id))
            .send();

        clearprop(prop, dac_id);
    }

    void dacproposals::clearprop(const proposal &proposal, name dac_id) {

        proposal_table proposals(_self, dac_id.value);
        auto           prop_to_erase = proposals.find(proposal.proposal_id.value);

        check(prop_to_erase != proposals.end(), "ERR::PROPOSAL_NOT_FOUND::Proposal not found");

        // Remove all the votes associated with that proposal.
        proposal_vote_table prop_votes(_self, dac_id.value);
        auto                by_proposal = prop_votes.get_index<"proposal"_n>();
        auto                itr         = by_proposal.lower_bound(proposal.proposal_id.value);
        auto                end_itr     = by_proposal.upper_bound(proposal.proposal_id.value);
        while (itr != end_itr && itr != by_proposal.end() && itr->proposal_id == proposal.proposal_id) {
            itr = by_proposal.erase(itr);
        }

        proposals.erase(prop_to_erase);
    }

    int16_t dacproposals::count_votes(proposal prop, VoteType vote_type, name dac_id) {
        auto custodian_data_src = dacdir::dac_for_id(dac_id).account_for_type(dacdir::CUSTODIAN);

        print("count votes with account:: ", custodian_data_src, " scope:: ", dac_id);

        custodians_table      custodians(custodian_data_src, dac_id.value);
        std::set<eosio::name> current_custodians;
        // Needed for the category vote fallback to avoid duplicate votes.
        std::set<eosio::name> voted_custodians;
        for (custodian cust : custodians) {
            current_custodians.insert(cust.cust_name);
        }
        print_f("\ncurrent custodians: ");
        for (auto name : current_custodians) {
            print(name, ", ");
        }

        // Find the delegated and direct votes for the current proposal
        proposal_vote_table             prop_votes(_self, dac_id.value);
        auto                            by_voters = prop_votes.get_index<"proposal"_n>();
        std::map<eosio::name, uint16_t> delegated_proposal_votes;
        std::set<eosio::name>           approval_proposal_votes;

        auto direct_vote_itr = by_voters.find(prop.proposal_id.value);

        // Iterate through all votes on proposal
        while (direct_vote_itr != by_voters.end() && direct_vote_itr->proposal_id == prop.proposal_id) {
            // Check if the voter is a current custodian
            if (current_custodians.find(direct_vote_itr->voter) != current_custodians.end()) {
                voted_custodians.insert(direct_vote_itr->voter);
                // Assign vote to either a direct approved vote or a delegated vote.
                if (direct_vote_itr->delegatee) {
                    delegated_proposal_votes[direct_vote_itr->delegatee.value()]++;
                } else if (direct_vote_itr->vote && direct_vote_itr->vote.value() == name{vote_type}) {
                    approval_proposal_votes.insert(direct_vote_itr->voter);
                }
                direct_vote_itr++;
            } else {
                direct_vote_itr = by_voters.erase(direct_vote_itr);
            }
        }

        print_f("\n direct approval_proposal_votes: ");
        for (auto name : approval_proposal_votes) {
            print(name, ", ");
        }

        print_f("\ndelegated_proposal_vote weight: ");
        for (pair<const eosio::name, unsigned short> entry : delegated_proposal_votes) {
            print("(name: ", entry.first, " with added weight: ", entry.second, "), ");
        }

        // Find matching category votes for the current custodians

        // Find the difference between current custodians and the ones that have already voted to avoid double votes.
        std::vector<name> nonvoting_custodians(current_custodians.size());
        auto              end_itr = std::set_difference(current_custodians.begin(), current_custodians.end(),
                         voted_custodians.begin(), voted_custodians.end(), nonvoting_custodians.begin());

        nonvoting_custodians.resize(end_itr - nonvoting_custodians.begin());

        print_f("\ncustodians that have not yet voted: ");

        for (auto name : nonvoting_custodians) {
            print(name, ", ");
        }

        // Collect category votes from custodians that have not yet voted into a map.
        auto by_category = prop_votes.get_index<"catandvoter"_n>();

        std::map<eosio::name, uint16_t> category_delegate_votes;

        for (auto custodian : nonvoting_custodians) {
            uint128_t joint_id = combine_ids(prop.category, custodian.value);
            auto      vote_idx = by_category.find(joint_id);
            if (vote_idx != by_category.end() && vote_idx->category_id && vote_idx->delegatee &&
                vote_idx->voter == custodian) {
                category_delegate_votes[vote_idx->delegatee.value()]++;
            }
        }

        print("\nCategory votes delegated from custodians that have not yet voted for this proposal: ");
        print("\n( based on the proposal having category: ", prop.category, " )");
        print("\n( Total should not exceed the number of non voting custodians from the previous step. )\n");
        for (auto entry : category_delegate_votes) {
            print("(name: ", entry.first, " vote: ", entry.second, "), ");
        }

        // Tally all the direct + delegated proposal + delegated category vote values
        print("\n Tally votes:\n");
        auto approved_count = S{0}.to<int16_t>();
        for (auto approval : approval_proposal_votes) {
            const auto addedPropWeight     = delegated_proposal_votes[approval];
            const auto addedCategoryWeight = category_delegate_votes[approval];
            const auto weight_to_add =
                S{1}.to<int16_t>() + S{addedPropWeight}.to<int16_t>() + S{addedCategoryWeight}.to<int16_t>();
            print("\n\n Approver: ", approval,
                "   1 "
                "\n + delegated for proposal: ",
                addedPropWeight, "\n + delegated for category: ", addedCategoryWeight);
            approved_count += weight_to_add;
        }
        return approved_count;
    }

    void dacproposals::check_proposal_can_start(name proposal_id, name dac_id) {
        proposal_table proposals(_self, dac_id.value);

        const proposal &prop = proposals.get(proposal_id.value, "ERR::PROPOSAL_NOT_FOUND::Proposal not found.");

        check(prop.state == STATE_PENDING_APPROVAL || prop.state == STATE_HAS_ENOUGH_APP_VOTES,
            "ERR::STARTWORK_WRONG_STATE::Proposal is not in the pending approval state therefore cannot start work.");
        check(prop.has_not_expired(), "ERR::PROPOSAL_EXPIRED::Proposal has expired.");

        int16_t approved_count = count_votes(prop, proposal_approve, dac_id);

        print_f("Worker proposal % to start work with: % votes\n", proposal_id.value, approved_count);

        auto proposal_threshold = configs(get_self(), dac_id).get_proposal_threshold();
        check(approved_count >= proposal_threshold,
            "ERR::STARTWORK_INSUFFICIENT_VOTES::Insufficient votes on worker proposal. Has %s but needs %s.",
            approved_count, proposal_threshold);
    }

    void dacproposals::arbiter_rule_on_proposal(name arbiter, name proposal_id, name dac_id) {
        require_auth(arbiter);
        proposal_table proposals(_self, dac_id.value);

        const proposal &prop = proposals.get(proposal_id.value, "ERR::PROPOSAL_NOT_FOUND::Proposal not found.");
        check(prop.arbiter == arbiter, "ERR::NOT_arbiter::You are not the arbiter for this proposal");

        auto escrow = dacdir::dac_for_id(dac_id).account_for_type(dacdir::ESCROW);
        check(is_account(escrow), "ERR::ESCROW_ACCOUNT_NOT_FOUND::Escrow account not found");

        escrows_table escrows = escrows_table(escrow, dac_id.value);
        auto          esc_itr = escrows.find(proposal_id.value);
        check(esc_itr == escrows.end(),
            "ERR::ESCROW_STILL_ACTIVE::Escrow is still active in escrow contract. It should have been either approved or dissapproved before calling this action.");

        check(prop.state == STATE_DISPUTED,
            "ERR::PROP_NOT_IN_DISPUTE_STATE::A proposal can only be denied by an arbiter when in dispute state.");

        clearprop(prop, dac_id);
    }
} // namespace eosdac