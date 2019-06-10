//
// Created by Dallas Johnson on 23/10/2018.
//
#include <eosio/action.hpp>
#include <eosio/transaction.hpp>

#include "external_types.hpp"
#include "dacmultisigs.hpp"
#include "../_contract-shared-headers/dacdirectory_shared.hpp"

using namespace eosdac;

void dacmultisigs::proposed( name proposer, name proposal_name, string metadata, name dac_scope ) {
    auto auth_account = dacdir::dac_for_id(dac_scope).account_for_type(dacdir::AUTH);
    require_auth(auth_account);
    require_auth( proposer );

    msig_proposals_table msig_proposals(name(MSIG_CONTRACT), proposer.value);
    msig_proposals.get(proposal_name.value, "ERR::PROPOSAL_NOT_FOUND_MSIG::Proposal not found in eosio.msig");

    auto size = transaction_size();
    char* buffer = (char*)( 512 < size ? malloc(size) : alloca(size) );
    uint32_t read = read_transaction( buffer, size );
    check( size == read, "ERR::READ_TRANSACTION_FAILED::read_transaction failed");

    checksum256 trx_id = sha256(buffer, read);

    proposals_table proposals(_self, dac_scope.value);

    proposals.emplace(proposer, [&](storedproposal &p) {
        p.proposalname = proposal_name;
        p.proposer = proposer;
        p.transactionid = trx_id;
        p.modifieddate = time_point_sec(eosio::current_time_point());
;
    });
}

void dacmultisigs::approved( name proposer, name proposal_name, name approver, name dac_scope ){
    auto auth_account = dacdir::dac_for_id(dac_scope).account_for_type(dacdir::AUTH);
    require_auth(auth_account);
    require_auth( approver );

    msig_proposals_table msig_proposals(name(MSIG_CONTRACT), proposer.value);
    msig_proposals.get(proposal_name.value, "ERR::PROPOSAL_NOT_FOUND_MSIG::Proposal not found in eosio.msig");

    proposals_table proposals(_self, dac_scope.value);
    auto& proposal = proposals.get(proposal_name.value, "ERR::PROPOSAL_NOT_FOUND::Proposal not found");
    proposals.modify(proposal, same_payer, [&](storedproposal &p) {
        p.modifieddate = time_point_sec(eosio::current_time_point());
    });
}

void dacmultisigs::unapproved( name proposer, name proposal_name, name unapprover, name dac_scope ){
    auto auth_account = dacdir::dac_for_id(dac_scope).account_for_type(dacdir::AUTH);
    require_auth(auth_account);
    require_auth( unapprover );

    msig_proposals_table msig_proposals(name(MSIG_CONTRACT), proposer.value);
    msig_proposals.get(proposal_name.value, "ERR::PROPOSAL_NOT_FOUND_MSIG::Proposal not found in eosio.msig");

    proposals_table proposals(_self, dac_scope.value);
    auto& proposal = proposals.get(proposal_name.value, "ERR::PROPOSAL_NOT_FOUND::Proposal not found");
    proposals.modify(proposal, same_payer, [&](storedproposal &p) {
        p.modifieddate = time_point_sec(eosio::current_time_point());
    });
}

void dacmultisigs::cancelled( name proposer, name proposal_name, name canceler, name dac_scope ){
        auto auth_account = dacdir::dac_for_id(dac_scope).account_for_type(dacdir::AUTH);
        require_auth(auth_account);
        require_auth( canceler );

    msig_proposals_table msig_proposals(name(MSIG_CONTRACT), proposer.value);
    auto prop = msig_proposals.find(proposal_name.value);
    check(prop == msig_proposals.end(), "ERR::PROPOSAL_EXISTS::The proposal still exists in eosio.msig");

    proposals_table proposals(_self, dac_scope.value);
    auto& proposal_to_erase = proposals.get(proposal_name.value, "ERR::PROPOSAL_NOT_FOUND::Proposal not found");
    proposals.erase(proposal_to_erase);
}

void dacmultisigs::executed( name proposer, name proposal_name, name executer, name dac_scope ) {
        auto auth_account = dacdir::dac_for_id(dac_scope).account_for_type(dacdir::AUTH);
        require_auth(auth_account);
        require_auth( executer );

    msig_proposals_table msig_proposals(name(MSIG_CONTRACT), proposer.value);
    auto prop = msig_proposals.find(proposal_name.value);
    check(prop == msig_proposals.end(), "ERR::PROPOSAL_EXISTS::The proposal still exists in eosio.msig");

    proposals_table proposals(_self, dac_scope.value);
    auto& proposal_to_erase = proposals.get(proposal_name.value, "ERR::PROPOSAL_NOT_FOUND::Proposal not found");
    proposals.erase(proposal_to_erase);
}

void dacmultisigs::clean( name proposer, name proposal_name, name dac_scope ) {
    auto auth_account = dacdir::dac_for_id(dac_scope).account_for_type(dacdir::AUTH);
    require_auth(auth_account);

    time_point_sec dtnow =  time_point_sec(eosio::current_time_point());
    uint32_t two_weeks = 60 * 60 * 24 * 14;

    proposals_table proposals(_self, dac_scope.value);
    auto& proposal = proposals.get(proposal_name.value, "ERR::PROPOSAL_NOT_FOUND::Proposal not found");

    check(dtnow > (proposal.modifieddate + two_weeks), "ERR::PROPOSAL_STILL_ACTIVE::This proposal is still active");

    proposals.erase(proposal);
}
