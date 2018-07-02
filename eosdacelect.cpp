#include <eosiolib/eosio.hpp>
#include <eosiolib/multi_index.hpp>
#include <eosiolib/singleton.hpp>
#include <eosiolib/asset.hpp>

#include <string>

using namespace eosio;
using namespace std;

struct contract_config {
    asset lockupasset = asset(1000.000, S(4, "EOSDAC"));
    uint8_t maxvotes = 5;
    string latestterms;

    EOSLIB_SERIALIZE(contract_config, (lockupasset)(maxvotes)(agreedterms))
};

//struct candconfig {
//    string bio;
//    asset reqpay;
//};

// @abi table candidates
struct candidate {
    name candidate_name;
    string bio;
    asset requestedpay;
    uint8_t is_custodian; // bool
    asset locked;
    uint32_t total_votes;
    vector<name> proxyfrom;

    name primary_key() const { return candidate_name; }

    EOSLIB_SERIALIZE(candidate, (candidate_name)(bio)(is_custodian)(locked)(total_votes)(proxyfrom))
};

// @abi table votes
struct vote {
    name voter;
    name proxy;
    vector<name> candidates;
    asset stake;

    name primary_key() const { return voter; }

    EOSLIB_SERIALIZE(vote, (voter)(proxy)(candidates)(stake))
};

//TODO: Add indices as it becomes more clear what search is needed.
typedef multi_index<N(candidates), candidate> candidates;
typedef multi_index<N(votes), vote> votes;
typedef singleton<N(config), contract_config> configscontainer;

class eosdacselect : public contract {

private:
    configscontainer config_singleton;
    contract_config configs;
    candidates candidates;
    votes custodian_votes;

    contract_config get_default_configs() {
        return contract_config{asset(1000.000, S(4, "EOSDAC"))};
    }

public:

    eosdacselect(account_name self)
            : contract(self),
              candidates(_self, _self),
              custodian_votes(_self, _self),
              config_singleton(_self, _self) {

        configs = config_singleton.exists() ? config_singleton.get() : get_default_configs();
    }

    void regcandidate(name candidate, string bio, asset requestedpay) {
        /* From Tech Doc vvvv
         * 1. Check the message has the permission of the account registering, and that account has agreed to the membership agreement
         * 2. Query the candidate table to see if the account is already registered.
         * 3. If the candidate is already registered then check if new_config is present
         * 4. Insert the candidate record into the database, making sure to set elected to 0
         * 5. Check that the message has permission to transfer tokens, assert if not
         * 6. Transfer the configurable number of tokens which need to be locked to the contract account and assert if this fails
         * From Tech doc ^^^^
         */
        print("regcandidate...");
        require_auth(candidate);

        regmembers reg_members(N(eosdactoken), N(eosdactoken));
        const auto &regmem = reg_members.get(candidate, "Candidate is not registered with members");
        eosio_assert(!regmem.agreedterms.empty(), "Candidate has not agreed any to terms");
        eosio_assert(!regmem.agreedterms == configs.latestterms, "Candidate has not agreed to current terms");

        auto reg_candidate = candidates.find(candidate);
        eosio_assert(reg_candidate == candidates.end(), "Candidate is already registered.");
        action(
                permission_level{N(candidate), N(active)},
                N(eosdactoken), N(transfer),
                std::make_tuple(candidate, _self, configs.lockupasset, "Candidate lockup amount")
        ).send();

        candidates.emplace(_self, [&](auto &c) {
            c.candidate_name = candidate;
            c.bio = bio;
            c.requestedpay = requestedpay;
            c.is_custodian = false;
            c.locked = configs.lockupasset;
            c.total_votes = 0;
        });
    }

    void unregcand(name cand) {
        print("unregcand...");

        require_auth(cand);
        const auto &reg_candidate = candidates.get(cand, "Candidate is not already registered.");

        //TODO: In order to return staked funds I think the following will need to be owner driven, multisig (with the owner)
        // or a transaction that will go into a pending buffer of transactions to be drained periodically by the contract owner.
        action(
                permission_level{N(eosdactoken), N(active)},
                N(eosdactoken), N(transfer),
                std::make_tuple(_self, cand, reg_candidate.locked, "Returning candidate lockup amount")
        ).send();
        candidates.erase(reg_candidate);
    }

    void updatebio(name cand, string bio) {
        print("updatebio...");

        require_auth(cand);
        const auto &reg_candidate = candidates.get(cand, "Candidate is not already registered.");

        candidates.modify(reg_candidate, 0, [&](candidate &c) {
            c.bio = bio;
        });
    }

    void updateconfig(name cand, asset requestedpay) {
        print("updateconfig...");

        require_auth(cand);
        const auto &reg_candidate = candidates.get(cand, "Candidate is not already registered.");

        //TODO: If this should only reset on the next period then this should get saved on
        // a "pendingrequestedPay" until the next period. Then move to requestedPay in order to save both states.
        candidates.modify(reg_candidate, 0, [&](candidate &c) {
            c.requestedpay = requestedpay;
        });
    }

    void claimpay(name cand) {
        print("claimpay...");
        require_auth(cand);
        /*
         * Feels like this should be in the custodian rewards contract.
         * Also in order to send pay this will need permission of contract owner so should probably be `sendpay` instead.
         * Otherwise could follow a similar pattern suggested in unreg with a pending transaction buffer.
         * Copied from tech doc VVVVV
          1. Check the message has permission of the account
          2. Check if there is a record in the CustodianReward table, if there is not then assert
          3. If the account has an outstanding balance then send it to the account, otherwise assert
          4. Remove the record in the CustodianReward table
         * Copied from tech doc ^^^^^

        */
    }

    void votecust(name voter, vector<name> newvotes) {
        /*
         * From Tech doc vvvv
        1. Check that the message has voting permission of account
        2. For each of the votes, check that the account names are registered as custodian candidates.  Assert if any of the accounts are not registered as candidates
        3. Save the votes in the CandidateVotes table, update if the voting account already has a record
         * From Tech doc ^^^^
        */
        print("votecust...");
        require_auth(voter);
        eosio_assert(newvotes.size() <= configs.maxvotes, "Number of votes is the message was exceeded.");
        /*
         * The deltaVotes approach aims to find a minimal change set of votes as a map<name,int_8>.
         * If a new votee is added it will have a +1
         * If a votee is removed it will have -1
         * If the vote is unchanged then it will be removed in preparation for the next step.
         */
        map<name, int8_t> deltaVotes;

        for (const auto &newVote : newvotes) {
            // Add vote with +1
            deltaVotes.insert(make_pair(newVote, 1));
        }

        auto existingVote = custodian_votes.find(voter);
        if (existingVote != custodian_votes.end()) {
            for (const auto &currentVotedCandidate : existingVote->candidates) {
                // If vote is no longer present decrement vote count on currentVotedCandidate.
                if (deltaVotes.find(currentVotedCandidate) == deltaVotes.end()) {
                    deltaVotes.insert(make_pair(currentVotedCandidate, -1));
                } else {
                    // remove vote from delta if no change to avoid uneeded action below.
                    deltaVotes.erase(currentVotedCandidate);
                }
            }

            for (auto &voteChange : deltaVotes) {
                auto candidate = candidates.get(voteChange.first, "Candidate is not registered for voting");
                candidates.modify(candidate, 0, [&](auto &c) {
                    c.total_votes += voteChange.second;
                    //TODO: Update votes to reflect effect from proxies with outstanding questions in tech doc.
                });
            }

            custodian_votes.modify(existingVote, _self, [&](vote &v) {
                v.candidates = newvotes;
                v.proxy = name();
            });
        } else {
            custodian_votes.emplace(_self, [&](vote &v) {
                v.voter = voter;
                v.candidates = newvotes;
                //   v.stake = // Not sure what to put here or if it's needed at all.
            });
        }
    }

    void voteproxy(name voter, name proxy) {
        /*
        1. Check that the message has voting permission of account
        2. If proxy is not null then set that account as a proxy for all votes from account
        */
        print("voteproxy...");
        require_auth(voter);

        auto existingVote = custodian_votes.find(voter);
        if (existingVote != custodian_votes.end()) {
            for (const auto &currentVotedCandidate : existingVote->candidates) {

                auto candidate = candidates.get(currentVotedCandidate, "Candidate is not registered for voting");

                candidates.modify(candidate, 0, [&](auto &c) {
                    c.total_votes--;
                    //TODO: Update votes to reflect effect from proxies with outstanding questions in tech doc.
                });
            }
            custodian_votes.modify(existingVote, _self, [&](vote &v) {
                v.candidates.clear();
                v.proxy = proxy;
            });
        } else {
            custodian_votes.emplace(_self, [&](vote &v) {
                v.voter = voter;
                v.proxy = proxy;
                //   v.stake = // Not sure what to put here - if it's needed for this calculation.
            });
        }
    }

    void newperiod(string message) {
        print("newperiod...");
/* Copied from the Tech Doc vvvvv
// 1. Distribute custodian pay based on the median of requested pay for all currently elected candidates

// 2. Tally the current votes and prepare a list of the winning custodians
// 3. Assigns the custodians, this may include updating a multi-sig wallet which controls the funds in the DAC as well as updating DAC contract code
* Copied from the Tech Doc ^^^^^
 */
    }

//    asset getMedianPay() {
//        //TODO: Add index to candidates to sort by requestedPay. Then find the middle record from the collection.
////        candidates.find()
////        return asset{};
//    }
};

EOSIO_ABI(eosdacselect, (regcandidate)(unregcand)(updateconfig)(updatebio)(claimpay)(votecust)(voteproxy)(newperiod))
