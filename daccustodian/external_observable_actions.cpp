
#include "../_contract-shared-headers/dacdirectory_shared.hpp"

void daccustodian::capturestake(name from,
                                asset quantity,
                                name dac_id) {
    
    auto dac = dacdir::dac_for_id(dac_id);
    auto token_contract = dac.account_for_type(dacdir::TOKEN);
    print("token contract: ", token_contract);
    require_auth(token_contract);

    candidates_table candidates(_self, dac_id.value);
    auto cand = candidates.find(from.value);
    if (cand != candidates.end()){
        candidates.modify(cand, _self, [&](candidate &c) {
            c.locked_tokens += quantity;
        });
    } else {
        pendingstake_table_t pendingstake(_self, dac_id.value);
        auto source = pendingstake.find(from.value);
        if (source != pendingstake.end()) {
            pendingstake.modify(source, _self, [&](tempstake &s) {
                s.quantity += quantity;
            });
            print("Modified exisiting stake record: ", from);
        } else {
            pendingstake.emplace(_self, [&](tempstake &s) {
                s.sender = from;
                s.quantity = quantity;
            });
            print("Created stake record: ", from);
        }
    }
}

void daccustodian::transferobsv(name from,
                                name to,
                                asset quantity,
                                name dac_id) {
    
    eosio::print("\n > transfer from : ", from, " to: ", to, " quantity: ", quantity);

    auto dac = dacdir::dac_for_id(dac_id);
    auto token_contract = dac.account_for_type(dacdir::TOKEN);
    print("token contract: ", token_contract);
    require_auth(token_contract);

    votes_table votes_cast_by_members(_self, dac_id.value);
    contr_state currentState = contr_state::get_current_state(_self, dac_id);

    auto existingVote = votes_cast_by_members.find(from.value);
    if (existingVote != votes_cast_by_members.end()) {
        updateVoteWeights(existingVote->candidates, -quantity.amount, dac_id, currentState);
        currentState.total_weight_of_votes -= quantity.amount;
    }

    // Update vote weight for the 'to' in the transfer if vote exists
    existingVote = votes_cast_by_members.find(to.value);
    if (existingVote != votes_cast_by_members.end()) {
        updateVoteWeights(existingVote->candidates, quantity.amount, dac_id, currentState);
        currentState.total_weight_of_votes += quantity.amount;
    }
    currentState.save(_self, dac_id);
}