#include <eosiolib/eosio.hpp>
#include <eosiolib/singleton.hpp>
#include <eosiolib/asset.hpp>
#include <eosiolib/transaction.hpp>
#include <string>

#include "daccustodian.hpp"

using namespace eosio;
using namespace std;
using eosio::print;

class daccustodian : public contract {

private:
    configscontainer config_singleton;
    statecontainer contract_state;
    candidates_table registered_candidates;
    votes_table votes_cast_by_members;
    pending_pay_table pending_pay;

    symbol_type PAYMENT_TOKEN = eosio::symbol_type(eosio::string_to_symbol(4, "EOS"));

    contr_state currentState;

public:

    daccustodian(account_name self)
            : contract(self),
              registered_candidates(_self, _self),
              votes_cast_by_members(_self, _self),
              pending_pay(_self, _self),
              config_singleton(_self, _self),
              contract_state(_self, _self) {

        currentState = contract_state.get_or_default(contr_state());
    }

    void updateconfig(asset lockupasset, uint8_t maxvotes, uint8_t numelected, uint32_t periodlength, name tokcontr) {
        require_auth(_self);

        // If the registered candidates is not empty prevent a change to the lockup asset symbol.
        if (registered_candidates.begin() != registered_candidates.end()) {
            eosio_assert(lockupasset.symbol == configs().lockupasset.symbol,
                         "The provided asset cannot be changed while there are registered candidates due to current staking in the old asset.");
        }
        contr_config newconfig{lockupasset, maxvotes, numelected, periodlength, tokcontr};
        config_singleton.set(newconfig, _self);
    }

// Action to listen to from the associated token contract to ensure registering should be allowed.
    void transfer(account_name from,
                  account_name to,
                  asset quantity,
                  string memo) {
        print("listening to transfer with memo == dacaccountId");
        if (to == _self) {
            account_name dacId = eosio::string_to_name(memo.c_str());
            if (is_account(dacId)) {
                pendingstake_table_t pendingstake(_self, dacId);
                auto source = pendingstake.find(from);
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
    }

    void regcandidate(name cand, string bio, asset requestedpay) {

        require_auth(cand);
        get_valid_member(cand);
        account_name tokencontract = configs().tokencontr;

        auto reg_candidate = registered_candidates.find(cand);
        eosio_assert(reg_candidate == registered_candidates.end(), "Candidate is already registered.");
        eosio_assert(requestedpay.symbol == PAYMENT_TOKEN, "Incorrect payment token for the current configuration");

        pendingstake_table_t pendingstake(_self, _self);
        auto pending = pendingstake.find(cand);
        eosio_assert(pending != pendingstake.end(),
                     "A registering member must first stake tokens as set by the contract's config.");
        int64_t shortfall = configs().lockupasset.amount - pending->quantity.amount;
        if (shortfall > 0) {
            print("The amount staked is insufficient by: ", shortfall, " tokens.");
            eosio_assert(false, "");
        }

//        TODO: handle returning the partially staked tokens.
//            pending_pay.emplace(_self, [&](pay &p) {
//                p.key = pending_pay.available_primary_key();
//                p.receiver = cand;
//                p.quantity = pending->quantity;
//                p.memo = "Returning incorrect amount of staked tokens from registering attempt.";
//            });
//        }

        registered_candidates.emplace(_self, [&](candidate &c) {
            c.candidate_name = cand;
            c.bio = bio;
            c.requestedpay = requestedpay;
            c.pendreqpay = asset(0, PAYMENT_TOKEN);
            c.locked_tokens = pending->quantity;
            c.total_votes = 0;
        });

        pendingstake.erase(pending);
    }

    void unregcand(name cand) {

        require_auth(cand);
        const auto &reg_candidate = registered_candidates.get(cand, "Candidate is not already registered.");

        if (isCustodian(reg_candidate)) {
            transaction nextTrans{};
            nextTrans.actions.emplace_back(permission_level(_self, N(active)), _self, N(newperiod),
                                           std::make_tuple("", false));
            nextTrans.delay_sec = configs().periodlength;
            nextTrans.send(N(newperiod), true);
        }
        registered_candidates.erase(reg_candidate);

        pending_pay.emplace(_self, [&](pay &p) {
            p.key = pending_pay.available_primary_key();
            p.receiver = cand;
            p.quantity = reg_candidate.locked_tokens;
            p.memo = "Returning locked up stake. Thank you.";
        });
    }

    void updatebio(name cand, string bio) {

        require_auth(cand);
        get_valid_member(cand);

        const auto &reg_candidate = registered_candidates.get(cand, "Candidate is not already registered.");

        registered_candidates.modify(reg_candidate, 0, [&](candidate &c) {
            c.bio = bio;
        });
    }

    void updatereqpay(name cand, asset requestedpay) {

        require_auth(cand);
        get_valid_member(cand);
        const auto &reg_candidate = registered_candidates.get(cand, "Candidate is not already registered.");

        registered_candidates.modify(reg_candidate, 0, [&](candidate &c) {
            c.pendreqpay = requestedpay;
        });
    }

    void votecust(name voter, vector<name> newvotes) {

        require_auth(voter);
        get_valid_member(voter);

        eosio_assert(newvotes.size() <= configs().maxvotes, "Max number of allowed votes was exceeded.");
        std::set<name> dupSet{};
        for_each(newvotes.begin(), newvotes.end(), [&] (name& v) {
            eosio_assert(dupSet.insert(v).second, "Added duplicate votes for the same candidate");
        });

        // Find a vote that has been cast by this voter previously.
        auto existingVote = votes_cast_by_members.find(voter);
        if (existingVote != votes_cast_by_members.end()) {

            votes_cast_by_members.modify(existingVote, _self, [&](vote &v) {
                v.candidates = newvotes;
                v.proxy = name();
            });
        } else {
            votes_cast_by_members.emplace(_self, [&](vote &v) {
                v.voter = voter;
                v.candidates = newvotes;
            });
        }
    }

    void voteproxy(name voter, name proxy) {

        require_auth(voter);
        get_valid_member(voter);

        string error_msg = "Member cannot proxy vote for themselves: " + voter.to_string();
        eosio_assert(voter != proxy, error_msg.c_str());
        auto destproxy = votes_cast_by_members.find(proxy);
        if (destproxy != votes_cast_by_members.end()) {
            error_msg = "Proxy voters cannot vote for another proxy: " + voter.to_string();
            eosio_assert(destproxy->proxy == 0, error_msg.c_str());
        }

        // Find a vote that has been cast by this voter previously.
        auto existingVote = votes_cast_by_members.find(voter);
        if (existingVote != votes_cast_by_members.end()) {

            votes_cast_by_members.modify(existingVote, _self, [&](vote &v) {
                v.candidates.clear();
                v.proxy = proxy;
            });
        } else {
            votes_cast_by_members.emplace(_self, [&](vote &v) {
                v.voter = voter;
                v.proxy = proxy;
            });
        }
    }

    void newperiod(string message, bool earlyelect) {
        require_auth(_self);

        /* Copied from the Tech Doc vvvvv
         // 1. Distribute custodian pay based on the median of requested pay for all currently elected candidates

         // 2. Tally the current votes_cast_by_members and prepare a list of the winning custodians
         // 3. Assigns the custodians, this may include updating a multi-sig wallet which controls the funds in the DAC as well as updating DAC contract code
         * Copied from the Tech Doc ^^^^^
         */

        // These actions a separated out for clarity and incase we want to be able to call them individually the change would be minimal.
        distributepay(earlyelect);
        clearOldVotes();
        tallyNewVotes();
        configureForNextPeriod();

//        Schedule the the next election cycle at the end of the period.
//        transaction nextTrans{};
//        nextTrans.actions.emplace_back(permission_level(_self,N(active)), _self, N(newperiod), std::make_tuple("", false));
//        nextTrans.delay_sec = configs().periodlength;
//        nextTrans.send(N(newperiod), false);
    }

    void paypending(string message) {
        require_auth(_self);
        auto payidx = pending_pay.begin();
        eosio_assert(payidx != pending_pay.end(), "pending pay is empty");

        while (payidx != pending_pay.end()/* TODO: Add AND batch condition here to avoid long transaction errors */) {
            if (payidx->quantity.symbol == PAYMENT_TOKEN) {
                action(permission_level{_self, N(active)},
                       N(eosio.token), N(transfer),
                       std::make_tuple(_self, payidx->receiver, payidx->quantity, payidx->memo)
                ).send();
            } else {
                action(permission_level{_self, N(active)},
                       configs().tokencontr, N(transfer),
                       std::make_tuple(_self, payidx->receiver, payidx->quantity, payidx->memo)
                ).send();
            }

            payidx = pending_pay.erase(payidx);
        }
        if (payidx != pending_pay.end()) {
            //        Schedule the the next pending pay batch into a separate transaction.
            transaction nextPendingPayBatch{};
            nextPendingPayBatch.actions.emplace_back(
                    permission_level(_self, N(active)),
                    _self, N(paypending),
                    std::make_tuple("DAC Payment delayed batch transaction.")
            );
            nextPendingPayBatch.delay_sec = 1;
            nextPendingPayBatch.send(N(paypending), false);
        }
    }

private:

    contr_config configs() {
        contr_config conf = config_singleton.get_or_default(contr_config());
        config_singleton.set(conf, _self);
        return conf;
    }

    member get_valid_member(name member) {
        name tokenContract = configs().tokencontr;
        eosio_assert(tokenContract != 0, "The token contract has not been set via `updateconfig`.");
        regmembers reg_members(tokenContract, tokenContract);
        memterms memberterms(tokenContract, tokenContract);

        const auto &regmem = reg_members.get(member, "Account is not registered with members");
        eosio_assert((regmem.agreedterms != 0), "Account has not agreed to any terms");
        auto latest_member_terms = (--memberterms.end());
        eosio_assert(latest_member_terms->version == regmem.agreedterms, "Agreed terms isn't the latest.");
        return regmem;
    }

    bool isCustodian(candidate account) {
        return false; // temp function as part of the earlyelect logic.
    }

    void distributepay(bool earlyelect) {
        auto idx = registered_candidates.get_index<N(byvotes)>();
        auto it = idx.rbegin();

        //Find the median pay using a temporary vector to hold the requestedpay amounts.
        std::vector<int64_t> reqpays;
        uint16_t custodian_count = 0;
        while (it != idx.rend() && custodian_count < configs().numelected && it->total_votes > 0) {
            reqpays.push_back(it->requestedpay.amount);
            it++;
            custodian_count++;
        }

        // Using nth_element to just sort for the entry we need for the median value.
        size_t mid = reqpays.size() / 2;
        std::nth_element(reqpays.begin(), reqpays.begin() + mid, reqpays.end());

        // To account for an early called election the pay may need calculated pro-rata'd
        int64_t medianPay = reqpays[mid];

        uint32_t timestamp = now();
        if (earlyelect) {
            uint32_t periodBlockCount = timestamp - currentState.lastperiodtime;
            medianPay = medianPay * (periodBlockCount / configs().periodlength);
        }
        currentState.lastperiodtime = timestamp;


        asset medianAsset = asset(medianPay, PAYMENT_TOKEN);

        custodian_count = 0;
        it = idx.rbegin();
        while (it != idx.rend() && custodian_count < configs().numelected && it->total_votes > 0) {
            pending_pay.emplace(_self, [&](pay &p) {
                p.key = pending_pay.available_primary_key();
                p.receiver = it->candidate_name;
                p.quantity = medianAsset;
                p.memo = "EOSDAC Custodian pay. Thank you.";
            });
            it++;
            custodian_count++;
        }

        print("distribute pay");
    }

    void clearOldVotes() {
        auto voteitr = votes_cast_by_members.begin();
        while (voteitr != votes_cast_by_members.end()) {
            votes_cast_by_members.modify(*voteitr, _self, [&](vote &v) {
                v.weight = 0;
            });
            voteitr++;
        }

        auto canditr = registered_candidates.begin();
        while (canditr != registered_candidates.end()) {
            registered_candidates.modify(*canditr, _self, [&](candidate &c) {
                c.total_votes = 0;
            });
            canditr++;
        }
        print("clear old votes");
    }

    void tallyNewVotes() {
        auto byProxyIdx = votes_cast_by_members.get_index<N(byproxy)>();
        uint64_t asset_name = configs().lockupasset.symbol.name();

        auto itr = byProxyIdx.rbegin();
        auto end = byProxyIdx.rend();

        // This should go iterate through proxy votes first to increase the proxy weight factor.
        // Therefore the sorting order is important here.
        while (itr != end) {
            accounts accountstable(configs().tokencontr, itr->voter);
            const auto ac = accountstable.find(asset_name);
            if (ac != accountstable.end()) {
                int64_t vote_weight = ac->balance.amount;

                votes_cast_by_members.modify(*itr, _self, [&](vote &v) {
                    v.weight += vote_weight;
                });

                if (itr->proxy != 0) {
                    auto proxied_to_voter = votes_cast_by_members.find(itr->proxy); // else "no active vote for proxy");
                    if (proxied_to_voter != votes_cast_by_members.end()) {
                        votes_cast_by_members.modify(proxied_to_voter, _self, [&](vote &p) {
                            p.weight += vote_weight;
                        });
                    }
                }
            } else {
                print("tally new votes - voter has no balance");
            }
            if (itr->proxy == 0) {
                for (const auto &newVote : itr->candidates) {
                    auto candidate = registered_candidates.find(newVote);
                    registered_candidates.modify(candidate, _self, [&](auto &c) {
                        c.total_votes += itr->weight;
                    });
                }
            }
            ++itr;
        }
        print("tally new votes");
    }

    void configureForNextPeriod() {
        auto byPendingPayIdx = registered_candidates.get_index<N(bypendingpay)>();
        auto it = byPendingPayIdx.rbegin();
        auto end = byPendingPayIdx.rend();

        int i = 0;
        int32_t electcount = configs().numelected;
        while (it != end && it->pendreqpay.amount > 0) {
            registered_candidates.modify(*it, _self, [&](candidate &cand) {
                // Move the pending request pay to the request pay for the next period.
                cand.requestedpay = cand.pendreqpay;
                // zeros the pending request to prevent overwrite of requestedPay on the next cycle.
                cand.pendreqpay = asset(0, PAYMENT_TOKEN);
            });
            ++it;
            ++i;
        }
        print("configureForNextPeriod");
    }

public:
    void migrate(name cand) {

        //Copy to a holding table - Enable this for the first step
        /*
        candidates_table oldcands(_self, _self);
        candidates2_table holding_table(_self, _self);
        auto it = oldcands.begin();
        while (it != oldcands.end()) {
            holding_table.emplace(_self, [&](candidate2 &c) {
                c.candidate_name = it->candidate_name;
                c.bio = it->bio;
                c.requestedpay = it->requestedpay;
                c.pendreqpay = it->pendreqpay;
                c.locked_tokens = it->locked_tokens;
                c.total_votes = it->total_votes;
            });
            it = oldcands.erase(it);
        }
         */

        // Copy back to the original table with the new schema - Enable this for the second step *after* modifying the original object's schema before copying back to the original table location.

//        candidates2_table holding_table(_self, _self);
//        candidates_table oldcands(_self, _self);
//        auto it = holding_table.begin();
//        while (it != holding_table.end()) {
//            oldcands.emplace(_self, [&](candidate &c) {
//                c.candidate_name = it->candidate_name;
//                c.bio = it->bio;
//                c.requestedpay = it->requestedpay;
//                c.pendreqpay = it->pendreqpay;
//                c.locked_tokens = it->locked_tokens;
//                c.total_votes = it->total_votes;
//            });
//            it = holding_table.erase(it);
//        }
    }
};

#define EOSIO_ABI_EX(TYPE, MEMBERS) \
extern "C" { \
   void apply( uint64_t receiver, uint64_t code, uint64_t action ) { \
      if( action == N(onerror)) { \
         /* onerror is only valid if it is for the "eosio" code account and authorized by "eosio"'s "active permission */ \
         eosio_assert(code == N(eosio), "onerror action's are only valid from the \"eosio\" system account"); \
      } \
      auto self = receiver; \
      if( code == self || action == N(transfer) ) { \
         TYPE thiscontract( self ); \
         switch( action ) { \
            EOSIO_API( TYPE, MEMBERS ) \
         } \
         /* does not allow destructor of thiscontract to run: eosio_exit(0); */ \
      } \
   } \
}

EOSIO_ABI_EX(daccustodian,
             (updateconfig)
                     (regcandidate)
                     (unregcand)
                     (updatebio)
                     (updatereqpay)
                     (votecust)
                     (voteproxy)
                     (newperiod)
                     (paypending)
                     (migrate)
                     (transfer)
)