using namespace eosdac;

ACTION daccustodian::votecust(const name &voter, const vector<name> &newvotes, const name &dac_id) {
#ifndef IS_DEV
    // check(dac_id == "testa"_n || dac_id == "testb"_n, "Voting is not yet enabled in the Planet DAOs.");
#endif
    candidates_table registered_candidates(_self, dac_id.value);
    const auto       globals = dacglobals::current(get_self(), dac_id);

    require_auth(voter);
    assertValidMember(voter, dac_id);
    check(newvotes.size() <= globals.get_maxvotes(),
        "ERR::VOTECUST_MAX_VOTES_EXCEEDED::Max number of allowed votes was exceeded.");
    std::set<name> dupSet{};
    assertValidMembers(newvotes, dac_id);
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

    const auto [vote_weight, vote_weight_quorum] = get_vote_weight(voter, dac_id);
    if (existingVote != votes_cast_by_members.end()) {
        update_number_of_votes(existingVote->candidates, newvotes, dac_id);

        modifyVoteWeights({voter, vote_weight, vote_weight_quorum}, existingVote->candidates,
            existingVote->vote_time_stamp, newvotes, dac_id, true);

        if (newvotes.size() == 0) {
            // Remove the vote if the array of candidates is empty
            votes_cast_by_members.erase(existingVote);
            eosio::print("\n Removing empty vote.");
        } else {
            votes_cast_by_members.modify(existingVote, voter, [&](vote &v) {
                v.candidates      = newvotes;
                v.proxy           = name();
                v.vote_time_stamp = now();
                v.vote_count++;
            });
        }

    } else {
        update_number_of_votes({}, newvotes, dac_id);

        modifyVoteWeights({voter, vote_weight, vote_weight_quorum}, {}, {}, newvotes, dac_id, true);

        votes_cast_by_members.emplace(voter, [&](vote &v) {
            v.voter           = voter;
            v.candidates      = newvotes;
            v.vote_time_stamp = now();
            v.vote_count      = 0;
        });
    }
}

ACTION daccustodian::removecstvte(const name &voter, const name &dac_id) {
    votecust(voter, {}, dac_id);
}

void daccustodian::update_number_of_votes(
    const vector<name> &oldvotes, const vector<name> &newvotes, const name &dac_id) {
    auto registered_candidates = candidates_table{get_self(), dac_id.value};

    for (const auto candidate : oldvotes) {
        auto candItr = registered_candidates.find(candidate.value);
        if (candItr != registered_candidates.end()) {
            registered_candidates.modify(candItr, same_payer, [&](auto &c) {
                c.number_voters = S{c.number_voters} - S{uint32_t{1}};
            });
        }
    }
    for (const auto candidate : newvotes) {
        auto candItr = registered_candidates.find(candidate.value);
        if (candItr != registered_candidates.end()) {
            registered_candidates.modify(candItr, same_payer, [&](auto &c) {
                c.number_voters = S{c.number_voters} + S{uint32_t{1}};
            });
        }
    }
}

void daccustodian::modifyProxiesWeight(
    int64_t vote_weight, name oldProxy, name newProxy, name dac_id, bool from_voting) {
    proxies_table proxies(get_self(), dac_id.value);
    votes_table   votes_cast_by_members(_self, dac_id.value);

    auto oldProxyRow = proxies.find(oldProxy.value);

    vector<name>                  oldProxyVotes    = {};
    vector<name>                  newProxyVotes    = {};
    std::optional<time_point_sec> oldVoteTimestamp = {};

    if (oldProxyRow != proxies.end() && oldProxyRow->proxy == oldProxy) {
        proxies.modify(oldProxyRow, same_payer, [&](proxy &p) {
            p.total_weight -= vote_weight;
        });
        auto existingProxyVote = votes_cast_by_members.find(oldProxy.value);
        if (existingProxyVote != votes_cast_by_members.end() && existingProxyVote->voter == oldProxy) {
            oldProxyVotes    = existingProxyVote->candidates;
            oldVoteTimestamp = existingProxyVote->vote_time_stamp;
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

    if (from_voting) {
        update_number_of_votes(oldProxyVotes, newProxyVotes, dac_id);
    }
    modifyVoteWeights(
        {name{}, vote_weight, vote_weight}, oldProxyVotes, oldVoteTimestamp, newProxyVotes, dac_id, from_voting);
}

ACTION daccustodian::voteproxy(const name &voter, const name &proxyName, const name &dac_id) {
#ifndef IS_DEV
    check(false, "proxy voting not yet enabled.");
#endif
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

    const auto [vote_weight, vote_weight_quorum] = get_vote_weight(voter, dac_id);

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

    modifyProxiesWeight(vote_weight, oldProxy, newProxy, dac_id, true);
}

#ifdef IS_DEV
// Used for testing migraterank
void daccustodian::clearrank(const name &dac_id) {

    auto candidates = candidates_table{get_self(), dac_id.value};
    for (auto &candidate : candidates) {
        candidates.modify(candidate, same_payer, [&](auto &c) {
            c.rank = 314159;
        });
    }
}

// Needs to be called for every dac after deployment to fill the index (rank field)
void daccustodian::migraterank(const name &dac_id) {
    auto candidates = candidates_table{get_self(), dac_id.value};
    for (auto &candidate : candidates) {
        candidates.modify(candidate, same_payer, [&](auto &c) {
            c.update_index();
            c.gap_filler = 0;
        });
    }
}
#endif
