//
// Created by Dallas Johnson on 23/10/2018.
//
#include <eosiolib/action.hpp>
#include <eosiolib/permission.hpp>
#include <eosiolib/transaction.hpp>
#include <eosiolib/crypto.h>
#include <eosiolib/system.h>

#include "external_types.hpp"
#include "dacmultisigs.hpp"

void dacmultisigs::proposed( name proposer, name proposal_name, string metadata ) {
    require_auth( "dacauthority"_n );
    require_auth( proposer );

    msig_proposals_table msig_proposals("eosio.msig"_n, proposer.value);
    auto i = msig_proposals.get(proposal_name.value, "ERR::PROPOSAL_NOT_FOUND_MSIG::Proposal not found in eosio.msig");

    auto size = transaction_size();
    char* buffer = (char*)( 512 < size ? malloc(size) : alloca(size) );
    uint32_t read = read_transaction( buffer, size );
    eosio_assert( size == read, "ERR::READ_TRANSACTION_FAILED::read_transaction failed");

    capi_checksum256 ALIGNED(trx_id);
    sha256(buffer, read, &trx_id);

    proposals_table proposals(_self, proposer.value);

    proposals.emplace(_self, [&](storedproposal &p) {
        p.proposalname = proposal_name;
        p.transactionid = trx_id;
        p.modifieddate = now();
    });
}

void dacmultisigs::approved( name proposer, name proposal_name, name approver ){
    require_auth(approver);
    require_auth( "dacauthority"_n );

    msig_proposals_table msig_proposals("eosio.msig"_n, proposer.value);
    msig_proposals.get(proposal_name.value, "ERR::PROPOSAL_NOT_FOUND_MSIG::Proposal not found in eosio.msig");

    proposals_table proposals(_self, proposer.value);
    auto& proposal = proposals.get(proposal_name.value, "ERR::PROPOSAL_NOT_FOUND::Proposal not found");
    proposals.modify(proposal, _self, [&](storedproposal &p) {
        p.modifieddate = now();
    });
}

void dacmultisigs::unapproved( name proposer, name proposal_name, name unapprover ){
    require_auth(unapprover);
    require_auth( "dacauthority"_n );

    msig_proposals_table msig_proposals("eosio.msig"_n, proposer.value);
    msig_proposals.get(proposal_name.value, "ERR::PROPOSAL_NOT_FOUND_MSIG::Proposal not found in eosio.msig");

    proposals_table proposals(_self, proposer.value);
    auto& proposal = proposals.get(proposal_name.value, "ERR::PROPOSAL_NOT_FOUND::Proposal not found");
    proposals.modify(proposal, _self, [&](storedproposal &p) {
        p.modifieddate = now();
    });
}

void dacmultisigs::cancelled( name proposer, name proposal_name, name canceler ){
    require_auth(canceler);
    require_auth( "dacauthority"_n );

    msig_proposals_table msig_proposals("eosio.msig"_n, proposer.value);
    auto prop = msig_proposals.find(proposal_name.value);
    eosio_assert(prop == msig_proposals.end(), "ERR::PROPOSAL_EXISTS::The proposal still exists in eosio.msig");

    proposals_table proposals(_self, proposer.value);
    auto& proposal_to_erase = proposals.get(proposal_name.value, "ERR::PROPOSAL_NOT_FOUND::Proposal not found");
    proposals.erase(proposal_to_erase);
}

void dacmultisigs::executed( name proposer, name proposal_name, name executer ) {
    require_auth(executer);
    require_auth( "dacauthority"_n );

    msig_proposals_table msig_proposals("eosio.msig"_n, proposer.value);
    auto prop = msig_proposals.find(proposal_name.value);
    eosio_assert(prop == msig_proposals.end(), "ERR::PROPOSAL_EXISTS::The proposal still exists in eosio.msig");

    proposals_table proposals(_self, proposer.value);
    auto& proposal_to_erase = proposals.get(proposal_name.value, "ERR::PROPOSAL_NOT_FOUND::Proposal not found");
    proposals.erase(proposal_to_erase);
}

void dacmultisigs::clean( name proposer, name proposal_name ) {
    require_auth( "dacauthority"_n );

    uint32_t dtnow = now();
    uint32_t two_weeks = 60 * 60 * 24 * 14;

    proposals_table proposals(_self, proposer.value);
    auto& proposal = proposals.get(proposal_name.value, "ERR::PROPOSAL_NOT_FOUND::Proposal not found");

    eosio_assert(dtnow > (proposal.modifieddate + two_weeks), "ERR::PROPOSAL_STILL_ACTIVE::This proposal is still active");

    proposals.erase(proposal);
}

EOSIO_DISPATCH( dacmultisigs,
        (proposed)
        (cancelled)
        (approved)
        (unapproved)
        (executed)
        (clean)
)
