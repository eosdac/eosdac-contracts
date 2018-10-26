
void daccustodian::votecust(name voter, vector<name> newvotes) {
#ifdef VOTING_DISABLED
    eosio_assert(false,"ERR::VOTECUST_VOTING_IS_DISABLED::Voting is currently disabled.");
#endif

    require_auth(voter);
    assertValidMember(voter);

    eosio_assert(newvotes.size() <= configs().maxvotes, "ERR::VOTECUST_MAX_VOTES_EXCEEDED::Max number of allowed votes was exceeded.");
    std::set<name> dupSet{};
    for (name vote: newvotes) {
        eosio_assert(dupSet.insert(vote).second, "ERR::VOTECUST_DUPLICATE_VOTES::Added duplicate votes for the same candidate.");
        auto candidate = registered_candidates.get(vote, "ERR::VOTECUST_CANDIDATE_NOT_FOUND::Candidate could not be found.");
        eosio_assert(candidate.is_active, "ERR::VOTECUST_VOTING_FOR_INACTIVE_CAND::Attempting to vote for an inactive candidate.");
    }

    // Find a vote that has been cast by this voter previously.
    auto existingVote = votes_cast_by_members.find(voter);
    if (existingVote != votes_cast_by_members.end()) {
        modifyVoteWeights(voter, existingVote->candidates, newvotes);

        if (newvotes.size() == 0) {
            // Remove the vote if the array of candidates is empty
            votes_cast_by_members.erase(existingVote);
            eosio::print("\n Removing empty vote.");
        } else {
            votes_cast_by_members.modify(existingVote, voter, [&](vote &v) {
                v.candidates = newvotes;
                v.proxy = name();
            });
        }
    } else {
        modifyVoteWeights(voter, {}, newvotes);

        votes_cast_by_members.emplace(voter, [&](vote &v) {
            v.voter = voter;
            v.candidates = newvotes;
        });
    }
}

//void daccustodian::voteproxy(name voter, name proxy) {
//
//    require_auth(voter);
//    assertValidMember(voter);
//
//    string error_msg = "Member cannot proxy vote for themselves: " + voter.to_string();
//    eosio_assert(voter != proxy, error_msg.c_str());
//    auto destproxy = votes_cast_by_members.find(proxy);
//    if (destproxy != votes_cast_by_members.end()) {
//        error_msg = "Proxy voters cannot vote for another proxy: " + voter.to_string();
//        eosio_assert(destproxy->proxy == 0, error_msg.c_str());
//    }
//
//    // Find a vote that has been cast by this voter previously.
//    auto existingVote = votes_cast_by_members.find(voter);
//    if (existingVote != votes_cast_by_members.end()) {
//
//        votes_cast_by_members.modify(existingVote, _self, [&](vote &v) {
//            v.candidates.clear();
//            v.proxy = proxy;
//        });
//    } else {
//        votes_cast_by_members.emplace(_self, [&](vote &v) {
//            v.voter = voter;
//            v.proxy = proxy;
//        });
//    }
//}
