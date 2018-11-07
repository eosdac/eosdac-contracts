//
// Created by Dallas Johnson on 23/10/2018.
//

#include "dacmultisigs.hpp"
#include <eosiolib/action.hpp>
#include <eosiolib/permission.hpp>
#include <eosiolib/transaction.hpp>
#include <eosiolib/crypto.h>
#include <eosiolib/system.h>

void dacmultisigs::stproposal( name proposer, name proposalname, string metadata ) {
    require_auth( "dacauthority"_n );

    auto size = transaction_size();
    char* buffer = (char*)( 512 < size ? malloc(size) : alloca(size) );
    uint32_t read = read_transaction( buffer, size );
    eosio_assert( size == read, "ERR::READ_TRANSACTION_FAILED::read_transaction failed");

    capi_checksum256 ALIGNED(trx_id);
    sha256(buffer, read, &trx_id);

    proposals_table proposals(_self, proposer.value);

    proposals.emplace(proposer, [&](storedproposal &p) {
        p.proposalname = proposalname;
        p.transactionid = trx_id;
        p.modifieddate = now();
    });
}

void dacmultisigs::approved( name proposer, name proposal_name, permission_level level ){
    require_auth(level.actor);
    require_auth( "dacauthority"_n );

    proposals_table proposals(_self, proposer.value);
    auto& proposal = proposals.get(proposal_name.value, "ERR::PROPOSAL_NOT_FOUND::Proposal not found");
    proposals.modify(proposal, level.actor, [&](storedproposal &p) {
        p.modifieddate = now();
    });
}

void dacmultisigs::unapproved( name proposer, name proposal_name, permission_level level ){
    require_auth(level.actor);
    require_auth( "dacauthority"_n );

    proposals_table proposals(_self, proposer.value);
    auto& proposal = proposals.get(proposal_name.value, "ERR::PROPOSAL_NOT_FOUND::Proposal not found");
    proposals.modify(proposal, level.actor, [&](storedproposal &p) {
        p.modifieddate = now();
    });
}

void dacmultisigs::cancelled( name proposer, name proposal_name, name canceler ){
    require_auth(canceler);
    require_auth( "dacauthority"_n );

    proposals_table proposals(_self, proposer.value);
    auto& proposal_to_erase = proposals.get(proposal_name.value, "ERR::PROPOSAL_NOT_FOUND::Proposal not found");
    proposals.erase(proposal_to_erase);
}

void dacmultisigs::executed( name proposer, name proposal_name, name executer ) {
    require_auth(executer);
    require_auth( "dacauthority"_n );

    proposals_table proposals(_self, proposer.value);
    auto& proposal_to_erase = proposals.get(proposal_name.value, "ERR::PROPOSAL_NOT_FOUND::Proposal not found");
    proposals.erase(proposal_to_erase);
}

void dacmultisigs::clean( name proposer, name proposal_name ) {
    uint32_t dtnow = now();
    uint32_t two_weeks = 60 * 60 * 24 * 14;

    proposals_table proposals(_self, proposer.value);
    auto& proposal = proposals.get(proposal_name.value, "ERR::PROPOSAL_NOT_FOUND::Proposal not found");

    eosio_assert(dtnow > (proposal.modifieddate + two_weeks), "ERR::PROPOSAL_STILL_ACTIVE::This proposal is still active");

    proposals.erase(proposal);
}

EOSIO_DISPATCH( dacmultisigs,
        (stproposal)
        (cancelled)
        (approved)
        (unapproved)
        (executed)
        (clean)
)
