
void daccustodian::transfer(name from,
                            name to,
                            asset quantity,
                            string memo) {
    eosio::print("\nlistening to transfer with memo == dacaccountId");
    if (to == _self) {
        name dacId = name(memo.c_str());
        if (is_account(dacId)) {
            pendingstake_table_t pendingstake(_self, dacId.value);
            auto source = pendingstake.find(from.value);
            if (source != pendingstake.end()) {
                pendingstake.modify(source, _self, [&](tempstake &s) {
                    s.quantity += quantity;
                });
            } else {
                pendingstake.emplace(_self, [&](tempstake &s) {
                    s.sender = from;
                    s.quantity = quantity;
                    s.memo = memo;
                });
            }
        }
    }

    eosio::print("\n > transfer from : ", from, " to: ", to, " quantity: ", quantity);

    if (quantity.symbol == configs().lockupasset.symbol) {
        // Update vote weight for the 'from' in the transfer if vote exists
        auto existingVote = votes_cast_by_members.find(from.value);
        if (existingVote != votes_cast_by_members.end()) {
            updateVoteWeights(existingVote->candidates, -quantity.amount);
            _currentState.total_weight_of_votes -= quantity.amount;
        }

        // Update vote weight for the 'to' in the transfer if vote exists
        existingVote = votes_cast_by_members.find(to.value);
        if (existingVote != votes_cast_by_members.end()) {
            updateVoteWeights(existingVote->candidates, quantity.amount);
            _currentState.total_weight_of_votes += quantity.amount;
        }
    }
}
