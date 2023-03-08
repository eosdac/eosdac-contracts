#include "referendum.hpp"

void referendum::receive(name from, name to, asset quantity, string memo) {
    if (to != _self || from == "eosio"_n || from == "eosio.ram"_n || from == "eosio.stake"_n) {
        return;
    }

    deposits_table deposits(get_self(), get_self().value);
    auto           existing = deposits.find(from.value);

    check(existing == deposits.end(),
        "ERR:EXISTING_DEPOSIT::There is an existing deposit, please call refund and try again");

    deposits.emplace(get_self(), [&](deposit_info &d) {
        d.account = from;
        d.deposit = extended_asset(quantity, get_first_receiver());
    });
}

void referendum::refund(name account) {
    deposits_table deposits(get_self(), get_self().value);
    auto           existing = deposits.find(account.value);
    check(existing != deposits.end(), "ERR::NO_DEPOSIT::This account does not have any deposit");
    //    print(existing->deposit.contract, " ", account, " ", existing->deposit.quantity);

    string memo = "Return of referendum deposit.";
    eosio::action(eosio::permission_level{get_self(), "active"_n}, existing->deposit.contract, "transfer"_n,
        make_tuple(get_self(), account, existing->deposit.quantity, memo))
        .send();

    deposits.erase(existing);
}

void referendum::updateconfig(config_item config, name dac_id) {
    checkDAC(dac_id);

    auto dac          = dacdir::dac_for_id(dac_id);
    auto auth_account = dac.owner;
    require_auth(auth_account);

    config.save(get_self(), dac_id, auth_account);
}

void referendum::propose(name proposer, name referendum_id, name type_name, name voting_type_name, string title,
    string content, name dac_id, vector<action> acts) {

    checkDAC(dac_id);
    require_auth(proposer);
    assertValidMember(proposer, dac_id);
    auto ref_type    = referendum_type(type_name.value);
    auto voting_type = count_type(voting_type_name.value);
#if ENABLE_BINDING_VOTE == 0
    check(ref_type != referendum_type::TYPE_BINDING,
        "ERR::CONTRACT_NOT_COMPILED::Contract was not compiled to allow binding votes");
#endif

    auto config = config_item::get_current_configs(get_self(), dac_id);
    check(config.allow_vote_type.at(type_name), "ERR::VOTING_TYPE_NOT_ALLOWED::This type of vote is not allowed");

    switch (ref_type) {
    case referendum_type::TYPE_BINDING:
    case referendum_type::TYPE_SEMI_BINDING:
        check(hasAuth(acts), "ERR::PERMS_FAILED::The authorization supplied with the action does not pass");
        check(acts.size() > 0, "ERR::TYPE_REQUIRES_ACTION::This type of referendum requires an action to be executed");
        break;
    case referendum_type::TYPE_OPINION:
        check(acts.size() == 0, "ERR::CANT_SEND_ACT::Can't supply an action with opinion based referendum");
        break;
    default:
        check(false, "ERR::TYPE_INVALID::Referendum type is invalid");
    };

    string msg;

    switch (voting_type) {
    case count_type::COUNT_ACCOUNT:
        msg = "ERR::ACCOUNT_VOTE_NOT_ALLOWED::Account vote is not allowed for this type of referendum";
        check(config.allow_per_account_voting.at(name{ref_type}), msg);
        break;
    case count_type::COUNT_TOKEN:
        break;
    default:
        check(false, "ERR::COUNT_TYPE_INVALID::Referendum vote counting type is invalid");
    };

    // Get transaction hash for content_ref and next id
    auto     size   = transaction_size();
    char *   buffer = (char *)(512 < size ? malloc(size) : alloca(size));
    uint32_t read   = read_transaction(buffer, size);
    check(size == read, "ERR::READ_TRANSACTION_FAILED::read_transaction failed");
    checksum256 trx_id = sha256(buffer, read);

    // Check the fee has been paid
    deposits_table deposits(get_self(), get_self().value);
    auto           dep          = deposits.find(proposer.value);
    extended_asset fee_required = config.fee[name{ref_type}];
    if (fee_required.quantity.amount > 0) {
        check(dep != deposits.end(),
            "ERR::FEE_REQUIRED::A fee is required to propose this type of referendum.  Please send the correct fee to this contract and try again.");
        check(dep->deposit.quantity >= fee_required.quantity && dep->deposit.contract == fee_required.contract,
            "ERR::INSUFFICIENT_FEE::Fee provided is insufficient");

        if (dep->deposit == fee_required) {
            deposits.erase(dep);
        } else {
            deposits.modify(*dep, same_payer, [&](auto &d) {
                d.deposit -= fee_required;
            });
        }

        // transfer fee to treasury account
        const auto   dac              = dacdir::dac_for_id(dac_id);
        const auto   treasury_account = dac.account_for_type(dacdir::TREASURY);
        const string fee_memo         = fmt("Fee for referendum id %s", referendum_id);
        eosio::action(eosio::permission_level{get_self(), "active"_n}, fee_required.contract, "transfer"_n,
            make_tuple(get_self(), treasury_account, fee_required.quantity, fee_memo))
            .send();
    }

    // Calculate expiry
    uint32_t time_now = current_time_point().sec_since_epoch();
    //    config_item config = config_item::get_current_configs(get_self(), dac_id);
    uint32_t expiry_time = time_now + config.duration;

    // Save to database
    referenda_table referenda(get_self(), dac_id.value);
    referenda.emplace(proposer, [&](referendum_data &r) {
        std::map<name, uint64_t> empty_votes = {{VOTE_PROP_YES, 0}, {VOTE_PROP_NO, 0}, {VOTE_PROP_ABSTAIN, 0}};

        r.referendum_id = referendum_id;
        r.proposer      = proposer;
        r.type          = name{ref_type};
        r.voting_type   = name{voting_type};
        r.title         = title;
        r.content_ref   = trx_id;
        r.token_votes   = empty_votes;
        r.account_votes = empty_votes;
        r.expires       = time_point_sec(expiry_time);
        r.acts          = acts;
        r.status        = REFERENDUM_STATUS_OPEN;
    });
}

void referendum::vote(name voter, name referendum_id, name vote, name dac_id) {

    checkDAC(dac_id);
    assertValidMember(voter, dac_id);
    auto dac = dacdir::dac_for_id(dac_id);

    referenda_table referenda(get_self(), dac_id.value);
    auto            ref = referenda.get(referendum_id.value, "ERR::REFERENDUM_NOT_FOUND::Referendum not found");

    uint32_t time_now = current_time_point().sec_since_epoch();
    check(ref.expires.sec_since_epoch() >= time_now,
        "ERR::REFERENDUM_EXPIRED::Referendum is closed, no more voting is allowed");
    check(ref.status == REFERENDUM_STATUS_OPEN, "ERR::REFERENDUM_NOT_OPEN::Referendum is not open for voting");

    uint64_t current_votes_token = 0;
    if (ref.token_votes.find(vote) != ref.token_votes.end()) {
        current_votes_token = ref.token_votes[vote];
    }
    uint64_t current_votes_account = 0;
    if (ref.account_votes.find(vote) != ref.account_votes.end()) {
        current_votes_account = ref.account_votes[vote];
    }

    uint64_t new_votes_token = current_votes_token;

    // get vote weight from token (staked balance - unstaking balance)
    asset    weightAsset = get_staked(voter, dac.symbol.get_contract(), dac.symbol.get_symbol());
    uint64_t weight      = weightAsset.amount;
    name     old_vote    = VOTE_PROP_REMOVE;
    // get existing vote
    votes_table votes(get_self(), dac_id.value);
    auto        existing_vote_data = votes.find(voter.value);
    if (existing_vote_data != votes.end()) {
        if (existing_vote_data->votes.find(referendum_id) != existing_vote_data->votes.end()) {
            old_vote = existing_vote_data->votes.at(referendum_id);
        }

        auto ev = *existing_vote_data;

        print("Going to modify votes");

        auto existing_votes = ev.votes;
        if (vote == VOTE_PROP_REMOVE) {
            existing_votes.erase(referendum_id);
        } else {
            if (old_vote == VOTE_PROP_REMOVE) {
                // new vote, check that they havent voted for more than 20 to avoid timeouts during clean and
                // when updating vote weight
                check(existing_votes.size() < 20,
                    "ERR::TO_MANY_REF_VOTED_ON::Can only vote on 20 referenda at a time, try using the clean action to remove old votes");
            }
            existing_votes[referendum_id] = vote;
        }

        votes.modify(existing_vote_data, same_payer, [&](vote_info &v) {
            v.votes = existing_votes;
        });

        print("Modified vote");
    } else {

        votes.emplace(voter, [&](vote_info &v) {
            v.voter = voter;
            map<name, name> votes;
            votes.emplace(referendum_id, vote);
            v.votes = votes;
        });
    }

    auto token_votes   = ref.token_votes;
    auto account_votes = ref.account_votes;

    switch (vote_choice{old_vote.value}) {
    case vote_choice::VOTE_REMOVE:
        break;
    case vote_choice::VOTE_ABSTAIN:
    case vote_choice::VOTE_NO:
    case vote_choice::VOTE_YES:
        token_votes[old_vote] -= weight;
        account_votes[old_vote]--;
        break;
    default:
        check(false, "ERR::OLD_INVALID::Old vote is invalid");
    }

    switch (vote_choice{vote.value}) {
    case vote_choice::VOTE_REMOVE:
        break;
    case vote_choice::VOTE_ABSTAIN:
    case vote_choice::VOTE_NO:
    case vote_choice::VOTE_YES:
        token_votes[vote] += weight;
        account_votes[vote]++;
        break;
    default:
        check(false, "ERR::NEW_INVALID::New vote is invalid");
    }

    auto ref2 = referenda.find(referendum_id.value);
    referenda.modify(*ref2, same_payer, [&](auto &r) {
        r.token_votes   = token_votes;
        r.account_votes = account_votes;
    });

    action(eosio::permission_level{get_self(), "active"_n}, get_self(), "updatestatus"_n,
        make_tuple(referendum_id, dac_id))
        .send();
}

void referendum::updatestatus(name referendum_id, name dac_id) {
    checkDAC(dac_id);
    auto       referenda = referenda_table{get_self(), dac_id.value};
    const auto ref = referenda.require_find(referendum_id.value, "ERR::REFERENDUM_NOT_FOUND::Referendum not found");
    const auto new_status = ref->get_status(get_self(), dac_id);
    referenda.modify(ref, same_payer, [&](auto &r) {
        r.status = name{new_status};
    });
}

void referendum::cancel(name referendum_id, name dac_id) {
    checkDAC(dac_id);
    referenda_table referenda(get_self(), dac_id.value);
    auto            ref = referenda.get(referendum_id.value, "ERR::REFERENDUM_NOT_FOUND::Referendum not found");

    require_auth(ref.proposer);

    referenda.erase(ref);
}

void referendum::exec(name referendum_id, name dac_id) {
    checkDAC(dac_id);

    referenda_table referenda(get_self(), dac_id.value);
    auto            ref = referenda.require_find(referendum_id.value, "ERR:REFERENDUM_NOT_FOUND::Referendum not found");

    check(ref->status == REFERENDUM_STATUS_PASSING,
        "ERR:REFERENDUM_NOT_PASSED::Referendum has not passed required number of yes votes");

    if (ref->type != REFERENDUM_OPINION) {
        check(ref->acts.size(), "ERR::NO_ACTION::No action to execute");

        if (ref->type == REFERENDUM_BINDING) {
            for (auto a : ref->acts) {
                a.send();
            }
        } else if (ref->type == REFERENDUM_SEMI) {
            proposeMsig(*ref, dac_id);
        }
    }
    action(permission_level{get_self(), "active"_n}, get_self(), "publresult"_n, make_tuple(*ref)).send();
    referenda.erase(ref);
}

void referendum::stakeobsv(vector<account_stake_delta> stake_deltas, name dac_id) {
    checkDAC(dac_id);
    auto dac            = dacdir::dac_for_id(dac_id);
    auto token_contract = dac.symbol.get_contract();
    require_auth(token_contract);

    referenda_table referenda(get_self(), dac_id.value);

    for (auto asd : stake_deltas) {
        votes_table votes(get_self(), dac_id.value);
        auto        existing_vote_data = votes.find(asd.account.value);

        if (existing_vote_data != votes.end()) {
            auto existing_votes = existing_vote_data->votes;

            auto v = existing_votes.begin();
            while (v != existing_votes.end()) {
                auto ref = referenda.find(v->first.value);

                if (ref != referenda.end()) {
                    referenda.modify(ref, same_payer, [&](referendum_data &r) {
                        r.token_votes[v->second] += asd.stake_delta.amount;
                    });
                    v++;
                } else {
                    // If the referendum cannot be found remove the vote.
                    v = existing_votes.erase(v);
                }
            }
            // set back the cleaned votes for the voter.
            votes.modify(existing_vote_data, same_payer, [&](auto &existing) {
                existing.votes = existing_votes;
            });
        }
    }
}

void referendum::clean(name account, name dac_id) {
    checkDAC(dac_id);
    require_auth(account);

    referenda_table referenda(get_self(), dac_id.value);
    votes_table     votes(get_self(), dac_id.value);
    auto            existing_vote_data = votes.find(account.value);

    map<name, name> new_votes;
    if (existing_vote_data != votes.end()) {
        for (auto vd : existing_vote_data->votes) {
            if (referenda.find(vd.first.value) != referenda.end()) {
                new_votes[vd.first] = vd.second;
            }
        }
    }

    votes.modify(*existing_vote_data, same_payer, [&new_votes](vote_info &v) {
        v.votes = new_votes;
    });
}

void referendum::clearconfig(name dac_id) {
    checkDAC(dac_id);

    auto dac          = dacdir::dac_for_id(dac_id);
    auto auth_account = dac.owner;
    require_auth(auth_account);

    config_container c = config_container(get_self(), dac_id.value);
    c.remove();
}

ACTION referendum::publresult(referendum_data ref) {
    require_auth(get_self());
}

// Private

bool referendum::hasAuth(vector<action> acts) {
    // TODO : this only checks if the permissions provided in the actions can authenticate the action
    // not if this contract will be able to execute it
    transaction trx;
    trx.actions = acts;

    auto check_perms = std::vector<permission_level>();
    for (auto a : acts) {
        check_perms.insert(check_perms.end(), a.authorization.begin(), a.authorization.end());
    }

    auto packed_trx   = pack(trx);
    auto packed_perms = pack(check_perms);

    auto res = check_transaction_authorization(
        packed_trx.data(), packed_trx.size(), (const char *)0, 0, packed_perms.data(), packed_perms.size());

    return (res > 0);
}

void referendum::checkDAC(name dac_id) {
#ifdef RESTRICT_DAC
    check(dac_id == name(RESTRICT_DAC), "DAC not permitted");
#endif
}

void referendum::proposeMsig(referendum_data ref, name dac_id) {
    auto dac                = dacdir::dac_for_id(dac_id);
    auto custodian_contract = dac.account_for_type(dacdir::CUSTODIAN);
    auto auth_account       = dac.owner;

    transaction trx;
    trx.actions = ref.acts;

    // Calculate expiry as 30 days
    uint32_t time_now = current_time_point().sec_since_epoch();
    trx.expiration    = time_point_sec(time_now + (60 * 60 * 24 * 30));

    // Get required auths
    candidates_table candidates(custodian_contract, dac_id.value);
    candperms_table  candperms(custodian_contract, dac_id.value);
    auto             cand_idx = candidates.get_index<"byvotesrank"_n>();
    auto             cand_itr = cand_idx.begin();

    name proposal_name = ref.referendum_id;

    vector<permission_level> reqd_perms;

    const auto globals  = dacglobals{custodian_contract, dac_id};
    uint8_t    count    = 0;
    uint8_t    num_reqs = min(255, globals.get_numelected() * 2);

    while (count < num_reqs && cand_itr != cand_idx.end()) {
        name perm_name   = "active"_n;
        auto custom_perm = candperms.find(cand_itr->candidate_name.value);
        if (custom_perm != candperms.end()) {
            perm_name = custom_perm->permission;
        }
        reqd_perms.push_back(permission_level{cand_itr->candidate_name, perm_name});
        //        print(" Adding ", cand_itr->candidate_name);

        cand_itr++;
        count++;
    }
    const auto metadata = map<string, string>{{"title", fmt("REFERENDUM: %s", ref.title)},
        {"description", fmt("Automated submission of passing referendum number %s", ref.referendum_id)}};

    action(permission_level{get_self(), "active"_n}, MSIG_CONTRACT, "propose"_n,
        make_tuple(get_self(), proposal_name, reqd_perms, dac_id, metadata, trx))
        .send();
}