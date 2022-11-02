#pragma once

#include <eosio/binary_extension.hpp>
#include <eosio/eosio.hpp>
#include <eosio/ignore.hpp>
#include <eosio/singleton.hpp>
#include <eosio/transaction.hpp>

#include "../../contract-shared-headers/daccustodian_shared.hpp"
#include "../../contract-shared-headers/dacdirectory_shared.hpp"
#include "../../contract-shared-headers/eosdactokens_shared.hpp"

using namespace eosio;

enum PropState { PENDING = 0, EXECUTED = 1, CANCELLED = 2 };

struct [[eosio::table("proposals"), eosio::contract("msigworlds")]] proposal {
    uint64_t                           id;
    name                               proposal_name;
    name                               proposer;
    std::vector<char>                  packed_transaction;
    std::optional<time_point>          earliest_exec_time;
    time_point_sec                     modified_date;
    uint8_t                            state = PropState::PENDING;
    std::map<std::string, std::string> metadata;

    uint64_t primary_key() const {
        return proposal_name.value;
    }
    uint64_t by_propser() const {
        return proposer.value;
    }
    uint64_t by_mod_date() const {
        return modified_date.utc_seconds;
    }
};
typedef eosio::multi_index<"proposals"_n, proposal,
    indexed_by<"proposer"_n, const_mem_fun<proposal, uint64_t, &proposal::by_propser>>,
    indexed_by<"moddata"_n, const_mem_fun<proposal, uint64_t, &proposal::by_mod_date>>>
    proposals;

struct approval {
    permission_level level;
    time_point       time;

    friend bool operator==(const approval &a, const approval &b) {
        // approvals are considered equal if their levels match, regardless of time
        return a.level == b.level;
    }
};

struct [[eosio::table("approvals"), eosio::contract("msigworlds")]] approvals_info {
    name proposal_name;
    // requested approval doesn't need to contain time, but we want requested approval
    // to be of exact the same size as provided approval, in this case approve/unapprove
    // doesn't change serialized data size. So, we use the same type.
    std::vector<approval> requested_approvals;
    std::vector<approval> provided_approvals;

    uint64_t primary_key() const {
        return proposal_name.value;
    }
};
typedef eosio::multi_index<"approvals"_n, approvals_info> approvals;

struct [[eosio::table("invals"), eosio::contract("msigworlds")]] invalidation {
    name       account;
    time_point last_invalidation_time;

    uint64_t primary_key() const {
        return account.value;
    }
};
typedef eosio::multi_index<"invals"_n, invalidation> invalidations;

struct [[eosio::table("blockedactns"), eosio::contract("msigworlds")]] blocked_action {
    uint64_t id;
    name     account;
    name     action;

    uint64_t primary_key() const {
        return id;
    }
    uint128_t contract_and_actions() const {
        return (uint128_t)account.value << 64 | action.value;
    }
};
typedef eosio::multi_index<"blockedactns"_n, blocked_action,
    indexed_by<"contractns"_n, const_mem_fun<blocked_action, uint128_t, &blocked_action::contract_and_actions>>>
    blocked_actions;

TABLE serial {
    uint64_t id = 0;
};
using serial_singleton = eosio::singleton<"serial"_n, serial>;

/**
 * The `eosio.msig` system contract allows for creation of proposed transactions which require authorization from a
 * list of accounts, approval of the proposed transactions by those accounts required to approve it, and finally, it
 * also allows the execution of the approved transactions on the blockchain.
 *
 * In short, the workflow to propose, review, approve and then executed a transaction it can be described by the
 * following:
 * - first you create a transaction json file,
 * - then you submit this proposal to the `eosio.msig` contract, and you also insert the account permissions
 * required to approve this proposal into the command that submits the proposal to the blockchain,
 * - the proposal then gets stored on the blockchain by the `eosio.msig` contract, and is accessible for review and
 * approval to those accounts required to approve it,
 * - after each of the appointed accounts required to approve the proposed transactions reviews and approves it, you
 * can execute the proposed transaction. The `eosio.msig` contract will execute it automatically, but not before
 * validating that the transaction has not expired, it is not cancelled, and it has been signed by all the
 * permissions in the initial proposal's required permission list.
 */

class [[eosio::contract("msigworlds")]] multisig : public eosio::contract {
  public:
    using contract::contract;

    /**
     * Propose action, creates a proposal containing one transaction.
     * Allows an account `proposer` to make a proposal `proposal_name` which has `requested`
     * permission levels expected to approve the proposal, and if approved by all expected
     * permission levels then `trx` transaction can we executed by this proposal.
     * The `proposer` account is authorized and the `trx` transaction is verified if it was
     * authorized by the provided keys and permissions, and if the proposal name doesn’t
     * already exist; if all validations pass the `proposal_name` and `trx` trasanction are
     * saved in the proposals table and the `requested` permission levels to the
     * approvals table (for the `proposer` context). Storage changes are billed to `proposer`.
     *
     * @param proposer - The account proposing a transaction
     * @param proposal_name - The name of the proposal (should be unique for proposer)
     * @param requested - Permission levels expected to approve the proposal
     * @param trx - Proposed transaction
     */
    ACTION propose(name proposer, name proposal_name, std::vector<permission_level> requested, name dac_id,
        std::map<std::string, std::string> metadata, eosio::ignore<transaction> trx);
    /**
     * Approve action approves an existing proposal. Allows an account, the owner of `level` permission, to approve
     * a proposal `proposal_name` proposed by `proposer`. If the proposal's requested approval list contains the
     * `level` permission then the `level` permission is moved from internal `requested_approvals` list to internal
     * `provided_approvals` list of the proposal, thus persisting the approval for the `proposal_name` proposal.
     * Storage changes are billed to `proposer`.
     *
     * @param proposer - The account proposing a transaction
     * @param proposal_name - The name of the proposal (should be unique for proposer)
     * @param level - Permission level approving the transaction
     * @param proposal_hash - Transaction's checksum
     */
    ACTION approve(
        name proposal_name, permission_level level, name dac_id, const std::optional<eosio::checksum256> proposal_hash);
    /**
     * Unapprove action revokes an existing proposal. This action is the reverse of the `approve` action: if all
     * validations pass the `level` permission is erased from internal `provided_approvals` and added to the
     * internal `requested_approvals` list, and thus un-approve or revoke the proposal.
     *
     * @param proposal_name - The name of the proposal (should be an existing proposal)
     * @param level - Permission level revoking approval for proposal
     * @param dac_id - The name of the dac
     */
    ACTION unapprove(name proposal_name, permission_level level, name dac_id);

    /**
     * Can be used by the custodian to signal that they have seen the proposal
     * and deliberately chose not to approve it. If it has been approved before,
     * the proposal will automatically be unapproved.
     *
     * @param proposal_name - The name of the proposal (should be an existing proposal)
     * @param level - Permission level revoking approval for proposal
     * @param dac_id - The name of the dac
     */
    ACTION deny(name proposal_name, permission_level level, name dac_id);

    /**
     * Cancel action cancels an existing proposal.
     *
     * @param proposer - The account proposing a transaction
     * @param proposal_name - The name of the proposal (should be an existing proposal)
     * @param canceler - The account cancelling the proposal (only the proposer can cancel an unexpired transaction,
     * and the canceler has to be different than the proposer)
     *
     * Allows the `canceler` account to cancel the `proposal_name` proposal, created by a `proposer`,
     * only after time has expired on the proposed transaction. It removes corresponding entries from
     * internal proptable and from approval (or old approvals) tables as well.
     */
    ACTION cancel(name proposal_name, name canceler, name dac_id);
    /**
     * Exec action allows an `executer` account to execute a proposal.
     *
     * Preconditions:
     * - `executer` has authorization,
     * - `proposal_name` is found in the proposals table,
     * - all requested approvals are received,
     * - proposed transaction is not expired,
     * - and approval accounts are not found in invalidations table.
     *
     * If all preconditions are met the transaction is executed as a deferred transaction,
     * and the proposal is erased from the proposals table.
     *
     * @param proposer - The account proposing a transaction
     * @param proposal_name - The name of the proposal (should be an existing proposal)
     * @param executer - The account executing the transaction
     */
    ACTION exec(name proposal_name, name executer, name dac_id);

    /**
     * @brief Checks the current auth condition of the MSIG proposal before trying to execute the transaction. In all
     * cases an error will be thrown to prevent writing to the blockchain but the error trace will signal if the
     * transaction is authorised yet.
     *
     * @param proposal_name
     * @param dac_id
     */
    ACTION checkauth(name proposal_name, name dac_id);

    /**
     * @brief cleanup action cleans up the table entries for msigs after are completed. Keeping the records in the
     * tables after execution/cancellation rather than deleting facilitates querying the contract to check on msigs
     * that have either completed or cancled without needing offchain dbs.
     *
     * @param proposal_name unique propasal name scoped within a dac
     * @param dac_id scope parameter useful to group MSIGS for each dac
     * @return ACTION
     */
    ACTION cleanup(name proposal_name, name dac_id);

    /**
     * Invalidate action allows an `account` to invalidate itself, that is, its name is added to
     * the invalidations table and this table will be cross referenced when exec is performed.
     *
     * @param account - The account invalidating the transaction
     */
    ACTION
    invalidate(name account, name dac_id);

    ACTION blockaction(name account, name action, name dac_id);

    using propose_action    = eosio::action_wrapper<"propose"_n, &multisig::propose>;
    using approve_action    = eosio::action_wrapper<"approve"_n, &multisig::approve>;
    using unapprove_action  = eosio::action_wrapper<"unapprove"_n, &multisig::unapprove>;
    using cancel_action     = eosio::action_wrapper<"cancel"_n, &multisig::cancel>;
    using exec_action       = eosio::action_wrapper<"exec"_n, &multisig::exec>;
    using invalidate_action = eosio::action_wrapper<"invalidate"_n, &multisig::invalidate>;

  private:
    uint64_t next_id(name dac_id);
    void     _unapprove(name proposal_name, permission_level level, name dac_id, bool throw_if_not_previously_approved);

    void assertValidMember(const name proposer, const name dac_id) {
        const auto dac                 = eosdac::dacdir::dac_for_id(dac_id);
        const auto referendum_contract = dac.account_for_type_maybe(eosdac::dacdir::REFERENDUM);

        if (referendum_contract) {
            if (proposer != *referendum_contract) {
                eosdac::assertValidMember(proposer, dac_id);
            }
        } else {
            eosdac::assertValidMember(proposer, dac_id);
        }
    }

    void assertValidCustodian(const name proposer, const name dac_id) {
        const auto dac                = eosdac::dacdir::dac_for_id(dac_id);
        const auto custodian_contract = dac.account_for_type_maybe(eosdac::dacdir::CUSTODIAN);
        if (custodian_contract) {
            const auto custodians   = eosdac::custodians_table{*custodian_contract, dac_id.value};
            const auto is_custodian = custodians.find(proposer.value) != custodians.end();
            check(is_custodian, "ERR::MUST_BE_CUSTODIAN:: %s must be active custodian.", proposer);
        }
    }
};
