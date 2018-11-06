//
// Created by Dallas Johnson on 23/10/2018.
//

#include "dacmultisigs.hpp"
#include <eosiolib/action.hpp>
#include <eosiolib/permission.hpp>
#include <eosiolib/transaction.hpp>
#include <eosiolib/crypto.h>

void dacmultisigs::stproposal(name proposer, name proposalname, string metadata) {
    require_auth( "dacauthority"_n );

    auto size = transaction_size();
    char* buffer = (char*)( 512 < size ? malloc(size) : alloca(size) );
    uint32_t read = read_transaction( buffer, size );
    eosio_assert( size == read, "read_transaction failed");

    capi_checksum256 trx_id;
    sha256(buffer, read, &trx_id);

    proposals_table proposals(_self, proposer.value);

    proposals.emplace(_self, [&](storedproposal &p) {
        p.proposalname = proposalname;
        p.transactionid = trx_id;
    });
}

void dacmultisigs::stinproposal(name proposer,
                                name proposal_name,
                                std::vector<permission_level> requested,
                                transaction trx,
                                string metadata) {

    require_auth("dacauthority"_n);
    require_auth(proposer);

    auto size = transaction_size();
    char* buffer = (char*)( 512 < size ? malloc(size) : alloca(size) );
    uint32_t read = read_transaction( buffer, size );
    eosio_assert( size == read, "read_transaction failed");

    capi_checksum256 trx_id;
    sha256(buffer, read, &trx_id);

    action(
            permission_level( proposer, "active"_n ),
            "eosio.msig"_n,
            "propose"_n,
            std::make_tuple(proposer, proposal_name, requested, trx)
    ).send();

    proposals_table proposals(_self, proposer.value);

    proposals.emplace(proposer, [&](storedproposal &p) {
        p.proposalname = proposal_name;
        p.transactionid = trx_id;
    });

}

void dacmultisigs::approve( name proposer, name proposal_name, permission_level level ){
    require_auth(level.actor.value);
    action(
            level,
            "eosio.msig"_n,
            "approve"_n,
            std::make_tuple(proposer, proposal_name, level)
    ).send();
}

void dacmultisigs::unapprove( name proposer, name proposal_name, permission_level level ){
    require_auth(level.actor.value);
    // forward to multisig contract
    action(
            level,
            "eosio.msig"_n,
            "unapprove"_n,
            std::make_tuple(proposer, proposal_name, level)
    ).send();
}

void dacmultisigs::cancel( name proposer, name proposal_name, name canceler ){
    require_auth(canceler.value);
    // forward to multisig contract
    action(
            permission_level{ canceler, "active"_n },
            "eosio.msig"_n,
            "cancel"_n,
            std::make_tuple(proposer, proposal_name, canceler)
    ).send();

    //Clean up after canceling the proposal in the multisig contract
    proposals_table proposals(_self, proposer.value);
    auto& proposal_to_erase = proposals.get(proposal_name.value, "Proposal not found");
    proposals.erase(proposal_to_erase);
}

void dacmultisigs::exec( name proposer, name proposal_name, name executer ) {
    require_auth(executer.value);

    // forward to multisig contract
    action(
            permission_level{ executer, "active"_n },
            "eosio.msig"_n,
            "exec"_n,
            std::make_tuple(proposer, proposal_name, executer)
    ).send();

    //Clean up after executing the proposal in the multisig contract
    proposals_table proposals(_self, proposer.value);
    auto& proposal_to_erase = proposals.get(proposal_name.value, "Proposal not found");
    proposals.erase(proposal_to_erase);
}

EOSIO_DISPATCH( dacmultisigs,
        (stproposal)
        (stinproposal)
        (cancel)
        (approve)
        (unapprove)
        (exec)
)
