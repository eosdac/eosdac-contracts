//
// Created by Dallas Johnson on 23/10/2018.
//

#include "eosdacmsigs.hpp"

void eosdacmsigs::stproposal(string transactionid, name proposer, name proposalname) {
//    eosio_assert();
    require_auth(proposer);

    proposals_table proposals(_self, _self);

    proposals.emplace(_self, [&](proposal &p) {
        p.proposalid = proposals.available_primary_key();
        p.transactionid = transactionid;
        p.proposer = proposer;
        p.proposalname = proposalname;
    });

}

EOSIO_ABI( eosdacmsigs, (stproposal) )
