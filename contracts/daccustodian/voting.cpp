using namespace eosdac;

void daccustodian::votecust(name voter, vector<name> newvotes, name dac_id) {

    candidates_table registered_candidates(_self, dac_id.value);
    contr_config     configs = contr_config::get_current_configs(_self, dac_id);

    require_auth(voter);
    assertValidMember(voter, dac_id);

    check(newvotes.size() <= configs.maxvotes,
        "ERR::VOTECUST_MAX_VOTES_EXCEEDED::Max number of allowed votes was exceeded.");
    std::set<name> dupSet{};
    for (name vote : newvotes) {
        check(
            dupSet.insert(vote).second, "ERR::VOTECUST_DUPLICATE_VOTES::Added duplicate votes for the same candidate.");
        auto candidate =
            registered_candidates.get(vote.value, "ERR::VOTECUST_CANDIDATE_NOT_FOUND::Candidate could not be found.");
        check(candidate.is_active,
            "ERR::VOTECUST_VOTING_FOR_INACTIVE_CAND::Attempting to vote for an inactive candidate.");
    }

    // Find a vote that has been cast by this voter previously.
    votes_table votes_cast_by_members(_self, dac_id.value);
    auto        existingVote = votes_cast_by_members.find(voter.value);

    int64_t vote_weight = get_vote_weight(voter, dac_id);
    if (existingVote != votes_cast_by_members.end()) {

        modifyVoteWeights(vote_weight, existingVote->candidates, newvotes, dac_id);

        if (newvotes.size() == 0) {
            // Remove the vote if the array of candidates is empty
            votes_cast_by_members.erase(existingVote);
            eosio::print("\n Removing empty vote.");
        } else {
            votes_cast_by_members.modify(existingVote, voter, [&](vote &v) {
                v.candidates = newvotes;
                v.proxy      = name();
            });
        }
    } else {
        modifyVoteWeights(vote_weight, {}, newvotes, dac_id);

        votes_cast_by_members.emplace(voter, [&](vote &v) {
            v.voter      = voter;
            v.candidates = newvotes;
        });
    }
}

void daccustodian::modifyProxiesWeight(int64_t vote_weight, name oldProxy, name newProxy, name dac_id) {
    proxies_table proxies(get_self(), dac_id.value);
    votes_table   votes_cast_by_members(_self, dac_id.value);

    auto oldProxyRow = proxies.find(oldProxy.value);

    vector<name> oldProxyVotes = {};
    vector<name> newProxyVotes = {};

    if (oldProxyRow != proxies.end() && oldProxyRow->proxy == oldProxy) {
        proxies.modify(oldProxyRow, same_payer, [&](proxy &p) {
            p.total_weight -= vote_weight;
        });
        auto existingProxyVote = votes_cast_by_members.find(oldProxy.value);
        if (existingProxyVote != votes_cast_by_members.end() && existingProxyVote->voter == oldProxy) {
            oldProxyVotes = existingProxyVote->candidates;
        }
    }

    auto newProxyRow = proxies.find(newProxy.value);

    if (newProxyRow != proxies.end() && newProxyRow->proxy == newProxy) {
        proxies.modify(newProxyRow, same_payer, [&](proxy &p) {
            p.total_weight += vote_weight;
        });
        auto existingProxyVote = votes_cast_by_members.find(newProxy.value);
        if (existingProxyVote != votes_cast_by_members.end() && existingProxyVote->voter == newProxy) {
            newProxyVotes = existingProxyVote->candidates;
        }
    }
    modifyVoteWeights(vote_weight, oldProxyVotes, newProxyVotes, dac_id);
}

void daccustodian::voteproxy(name voter, name proxyName, name dac_id) {

    require_auth(voter);
    assertValidMember(voter, dac_id);

    string error_msg = "Member cannot proxy vote for themselves: " + voter.to_string();
    check(voter != proxyName, error_msg.c_str());
    votes_table   votes_cast_by_members(get_self(), dac_id.value);
    proxies_table proxies(get_self(), dac_id.value);

    auto newProxyRow = proxies.find(proxyName.value);
    check(newProxyRow != proxies.end() && newProxyRow->proxy == proxyName,
        "ERR::VOTEPROXY_PROXY_NOT_ACTIVE::The nominated proxy is not an active proxy.");

    auto selfProxyRow = proxies.find(voter.value);
    check(selfProxyRow == proxies.end() || selfProxyRow->proxy != voter,
        "ERR::VOTEPROXY_PROXY_VOTE_FOR_PROXY::A registered proxy cannot make a proxy vote.");

    // Prevent a proxy voting for another proxy voter
    // auto destProxyVote = votes_cast_by_members.find(proxyName.value);
    // if (destProxyVote != votes_cast_by_members.end() && destProxyVote.) {
    //   error_msg = "Proxy voters cannot vote for another proxy: " + voter.to_string();
    //   check(destProxyVote->proxy.value == 0, error_msg.c_str());
    // }

    name oldProxy;
    name newProxy;

    int64_t vote_weight = get_vote_weight(voter, dac_id);

    // Find a vote that has been cast by this voter previously.
    auto existingVote = votes_cast_by_members.find(voter.value);
    if (existingVote != votes_cast_by_members.end() && existingVote->voter == voter) {
        name existingVoteForProxy = existingVote->proxy;
        check(existingVoteForProxy != proxyName,
            "ERR::VOTEPROXY_ALREADY_VOTED_FOR_PROXY::Voter has already voted for this proxy.");

        if (existingVoteForProxy.value != 0) {
            // Check the proxy is still an active proxy

            auto oldProxyRow = proxies.find(existingVoteForProxy.value);
            if (oldProxyRow != proxies.end() && oldProxyRow->proxy == existingVoteForProxy) {
                oldProxy = oldProxyRow->proxy;
            }
        }

        votes_cast_by_members.modify(existingVote, get_self(), [&](vote &v) {
            v.candidates.clear();
            v.proxy = proxyName;
        });
    } else {
        votes_cast_by_members.emplace(get_self(), [&](vote &v) {
            v.voter = voter;
            v.proxy = proxyName;
        });

        newProxy = proxyName;
    }

    modifyProxiesWeight(vote_weight, oldProxy, newProxy, dac_id);
}
