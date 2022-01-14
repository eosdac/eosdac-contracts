#include "distribution.hpp"

void distribution::receive(name from, name to, asset quantity, string memo) {
    if (to != _self || from == "eosio"_n || from == "eosio.ram"_n || from == "eosio.stake"_n) {
        return;
    }

    check(
        memo.length() > 0 && memo.length() <= 12, "ERR::INVALID_DISTRI_ID::Invalid or missing distribution ID in memo");

    name             distri_id = name(memo);
    districonf_table districonf_t(get_self(), get_self().value);
    auto             existing_distri = districonf_t.find(distri_id.value);
    check(existing_distri != districonf_t.end(), "ERR::DISTRI_NOT_FOUND::Distribution not found");

    name receiving = get_first_receiver();
    check(receiving == existing_distri->total_amount.contract, "ERR::WRONG_CONTRACT::Wrong contract for distribution");
    check(quantity.symbol == existing_distri->total_amount.quantity.symbol,
        "ERR::WRONG_SYMBOL::Wrong symbol for distribution");

    check(quantity + existing_distri->total_received <= existing_distri->total_amount.quantity,
        "ERR::CONTRIBUTION_TOO_MUCH::Contribution is more than the total of the distribution");

    districonf_t.modify(existing_distri, same_payer, [&](auto &d) {
        d.total_received += quantity;
    });
}

void distribution::regdistri(name distri_id, name dac_id, name owner, name approver_account,
    extended_asset total_amount, uint8_t distri_type, string memo) {

    require_auth(owner);
    check(distri_type < INVALID, "ERR::DISTRIBUTION_|OUT_BOUNDS::Distribution type out of bounds.");
    check(memo.length() <= 256, "ERR::MEMO_TOO_LONG::Memo can't be longer then 256 chars.");

    districonf_table districonf_t(get_self(), get_self().value);
    auto             existing_distri = districonf_t.find(distri_id.value);

    check(
        existing_distri == districonf_t.end(), "ERR::DISTRI_EXISTS::Distribution config with this id already exists.");
    check(total_amount.quantity.amount > 0,
        "ERR::TOTAL_DISTRI_NEGATIVE::Total distribution amount must be greater then zero.");

    // rampayer is owner
    districonf_t.emplace(owner, [&](auto &n) {
        n.distri_id        = distri_id;
        n.dac_id           = dac_id;
        n.owner            = owner;
        n.total_amount     = total_amount;
        n.approved         = 0;
        n.approver_account = approver_account;
        n.distri_type      = distri_type;
        n.total_received   = asset(0, total_amount.quantity.symbol);
        n.total_sent       = asset(0, total_amount.quantity.symbol);
        n.memo             = memo;
    });
}

void distribution::unregdistri(name distri_id) {

    districonf_table districonf_t(get_self(), get_self().value);
    auto             districonf = districonf_t.find(distri_id.value);
    check(
        districonf != districonf_t.end(), "ERR::DISTRI_DOESNT_EXIST::Distribution config with this id doesn't exist.");
    require_auth(districonf->owner);

    distri_table distri_t(get_self(), distri_id.value);
    check(distri_t.begin() == distri_t.end(),
        "ERR::CANT_DELETE_EMPTY::Can't delete config while the distribution list isn't empty. Empty the distribution list before calling this action.");

    districonf_t.erase(districonf);
}

void distribution::approve(name distri_id) {

    districonf_table districonf_t(get_self(), get_self().value);
    auto             districonf = districonf_t.find(distri_id.value);
    check(
        districonf != districonf_t.end(), "ERR::DISTRI_DOESNT_EXIST::Distribution config with this id doesn't exist.");
    require_auth(districonf->approver_account);

    distri_table distri_t(get_self(), distri_id.value);
    check(distri_t.begin() != distri_t.end(), "ERR::CANT_APPROVE_EMPTY::Can't approve an empty distribution list.");

    check(districonf->approved == 0, "ERR::DISTRI_APPROVED::Distribution is already approved.");

    districonf_t.modify(districonf, same_payer, [&](auto &n) {
        n.approved = 1;
    });
}

void distribution::populate(name distri_id, vector<dropdata> data, bool allow_modify) {

    districonf_table districonf_t(get_self(), get_self().value);
    auto             existing_distri = districonf_t.find(distri_id.value);

    check(existing_distri != districonf_t.end(),
        "ERR::DISTRI_DOESNT_EXIST::Distribution config with this id doesn't exist.");
    check(existing_distri->approved == 0,
        "ERR::CANT_POPULATE_APPROVED::Can't populate an already approved distribution list.");

    require_auth(existing_distri->owner);

    distri_table distri_t(get_self(), distri_id.value);

    name rampayer = existing_distri->owner;

    for (dropdata dropitem : data) {
        check(dropitem.amount.amount > 0, "ERR::AMOUNT_NOT_POSITIVE::Amount must be greater then zero.");
        check(dropitem.amount.symbol == existing_distri->total_amount.quantity.symbol,
            "ERR::WRONG_SYMBOL::Wrong symbol for distribution");

        auto existing_entry = distri_t.find(dropitem.receiver.value);
        if (existing_entry == distri_t.end()) {
            // new entry - always allowed
            distri_t.emplace(rampayer, [&](auto &n) {
                n.receiver = dropitem.receiver;
                n.amount   = dropitem.amount;
            });
        } else if (allow_modify) {
            // existing entry and allowed to modify
            distri_t.modify(existing_entry, same_payer, [&](auto &n) {
                n.amount = dropitem.amount;
            });
        }
    }
}

void distribution::empty(name distri_id, uint8_t batch_size) {

    districonf_table districonf_t(get_self(), get_self().value);
    auto             existing_distri = districonf_t.find(distri_id.value);
    check(existing_distri != districonf_t.end(),
        "ERR::DISTRI_DOESNT_EXIST::Distribution config with this id doesn't exist.");
    require_auth(existing_distri->owner);
    check(existing_distri->approved == 0, "ERR::CANT_CLEAR_APPROVED::Can't clear an already approved distribution.");

    distri_table distri_t(get_self(), distri_id.value);
    check(distri_t.begin() != distri_t.end(), "ERR::TABLE_EMPTY::No more entries, table is already empty.");

    check(batch_size > 0, "ERR::BATCH_SIZE_INVALID::Batch size must be greater then zero.");
    uint8_t count = 0;
    for (auto itr = distri_t.begin(); itr != distri_t.end() && count != batch_size;) {
        itr = distri_t.erase(itr);
        count++;
    }
}

void distribution::send(name distri_id, uint8_t batch_size) {

    districonf_table districonf_t(get_self(), get_self().value);
    auto             existing_distri = districonf_t.find(distri_id.value);

    check(existing_distri != districonf_t.end(),
        "ERR::DISTRI_DOESNT_EXIST::Distribution config with this id doesn't exist.");
    check(existing_distri->approved == 1, "ERR::DISTRI_NOT_APPROVED::Distribution must be approved first.");
    check(existing_distri->distri_type == SENDABLE,
        "ERR::DISTRI_TYPE_INVALID_SENDABLE::distri_type must be of type SENDABLE.");
    check(existing_distri->total_received == existing_distri->total_amount.quantity,
        "ERR::DISTRI_NOT_FUNDED::Distribution has not been funded.");

    distri_table distri_t(get_self(), distri_id.value);
    check(distri_t.begin() != distri_t.end(), "ERR::SEND_COMPLETE::Sending tokens completed, no more entries.");

    check(batch_size > 0, "ERR::BATCH_SIZE_INVALID::Batch size must be greater then zero.");

    string memo          = existing_distri->memo;
    name   tokencontract = existing_distri->total_amount.contract;

    uint8_t count = 0;
    for (auto itr = distri_t.begin(); itr != distri_t.end() && count != batch_size;) {

        action(permission_level{get_self(), "active"_n}, tokencontract, "transfer"_n,
            make_tuple(get_self(), itr->receiver, itr->amount, memo))
            .send();

        districonf_t.modify(existing_distri, same_payer, [&](auto &n) {
            n.total_sent += itr->amount;
        });

        itr = distri_t.erase(itr);
        count++;
    }
}

void distribution::claim(name distri_id, name receiver) {
    require_auth(receiver);
    districonf_table districonf_t(get_self(), get_self().value);
    auto             existing_distri = districonf_t.find(distri_id.value);

    check(existing_distri != districonf_t.end(),
        "ERR::DISTRI_DOESNT_EXIST::Distribution config with this id doesn't exist.");
    check(existing_distri->approved == 1, "ERR::DISTRI_NOT_APPROVED::Distribution must be approved first.");
    check(existing_distri->distri_type == CLAIMABLE,
        "ERR::DISTRI_TYPE_INVALID_CLAIMABLE::distri_type must be of type CLAIMABLE.");
    check(existing_distri->total_received == existing_distri->total_amount.quantity,
        "ERR::DISTRI_NOT_FUNDED::Distribution has not been funded.");

    distri_table distri_t(get_self(), distri_id.value);
    auto         claim_entry = distri_t.find(receiver.value);
    check(claim_entry != distri_t.end(), "ERR::NOTHING_TO_CLAIM::You don't have anything to claim.");

    string memo = existing_distri->memo;

    name tokencontract = existing_distri->total_amount.contract;

    action(permission_level{get_self(), "active"_n}, tokencontract, "transfer"_n,
        make_tuple(get_self(), receiver, claim_entry->amount, memo))
        .send();

    districonf_t.modify(existing_distri, same_payer, [&](auto &n) {
        n.total_sent += claim_entry->amount;
    });

    distri_t.erase(claim_entry);
}
