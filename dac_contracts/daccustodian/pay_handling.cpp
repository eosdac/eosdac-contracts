#include "daccustodian.hpp"
#include <eosio.msig/eosio.msig.hpp>
#include <eosio/crypto.hpp>
#include <eosio/eosio.hpp>
#include <eosio/transaction.hpp>

// using namespace eosdac;
using namespace eosio;
using namespace std;
using namespace eosdac;

void daccustodian::claimpay(uint64_t payid) { check(false, "This action is deprecated call `claimpaye` instead."); };

void daccustodian::claimpaye(uint64_t payid, name dac_id) {

    if (claimoldpaye_if_found(payid, dac_id)) {
        return; // if the condition returns true the action has been handled already
    }
    pending_pay_table pending_pay(get_self(), dac_id.value);

    dacdir::dac dac = dacdir::dac_for_id(dac_id);

    contr_config configs  = contr_config::get_current_configs(get_self(), dac_id);
    const pay &  payClaim = pending_pay.get(payid, "ERR::CLAIMPAY_INVALID_CLAIM_ID::Invalid pay claim id.");
    assertValidMember(payClaim.receiver, dac_id);

    require_auth(payClaim.receiver);

    eosio::transaction deferredTrans{};

    name   payment_destination;
    string memo;

    string memo_message = "Custodian Pay. Thank you.";

    name service_account = dac.account_for_type(dacdir::SERVICE);
    name token_holder    = dac.account_for_type(dacdir::TREASURY);

    if (configs.should_pay_via_service_provider) {
        memo = payClaim.receiver.to_string() + ":" + memo_message + ":" + to_string(payid);
        print("constructed memo for the service contract: " + memo);
        payment_destination = service_account;
    } else {
        memo = memo_message + ":" + to_string(payid);
        ;
        print("constructed memo for the receiver contract: " + memo);
        payment_destination = payClaim.receiver;
    }

    permission_level tokenHolderXferPerm{token_holder, "xfer"_n};
    // permission_level selfPayPerm{get_self(), "pay"_n};
    permission_level selfXferPerm{get_self(), "xfer"_n};

    auto transferAction = action(tokenHolderXferPerm, configs.requested_pay_max.contract, "transfer"_n,
        make_tuple(token_holder, payment_destination, payClaim.quantity.quantity, memo));

    auto removeCustPayAction = action(selfXferPerm, get_self(), "removecuspay"_n, make_tuple(payid, dac_id));
    auto dummyAction         = action(selfXferPerm, get_self(), "dummyaction"_n, make_tuple("payid"));

    // deferredTrans.actions.emplace_back(transferAction);
    // deferredTrans.actions.emplace_back(removeCustPayAction);
    deferredTrans.actions.emplace_back(dummyAction);

    deferredTrans.expiration = time_point_sec(current_time_point()) + 30 * 60 * 60;

    eosio::name proposalName = name(name("claimpay").value | current_time_point().sec_since_epoch());

    eosio::multisig::propose_action proposeAction("eosio.msig"_n, selfXferPerm);

    vector<eosio::permission_level> requiredPermissions{tokenHolderXferPerm, selfXferPerm};

    proposeAction.send(get_self(), proposalName, requiredPermissions, deferredTrans);

    action(tokenHolderXferPerm, "eosio.msig"_n, "approve"_n, make_tuple(get_self(), proposalName, tokenHolderXferPerm))
        .send();
    action(selfXferPerm, "eosio.msig"_n, "approve"_n, make_tuple(get_self(), proposalName, selfXferPerm)).send();

    // // eosio::multisig::approve_action
    // eosio::multisig::approve_action approve2("eosio.msig"_n, permission2);
    // approve2.send(get_self(), proposalName, permission2);

    // action(permission_level{get_self(), "xfer"_n}, "eosio.msig"_n, "propose"_n, payload).send();

    // action(permission_level{get_self(), "random"_n}, RNG_CONTRACT_ACCOUNT, "requestrand"_n,
    //     make_tuple(matchRoundId, signing_value, get_self()))
    //     .send();

    pending_pay.modify(payClaim, same_payer, [&](pay &p) {
        p.due_date = time_point_sec(current_time_point().sec_since_epoch()) + TRANSFER_DELAY;
    });
}

void daccustodian::removecuspay(uint64_t payid, name dac_id) {
    if (removeoldpay_if_found(payid, dac_id)) {
        return; // if the condition returns true the action has been handled already
    }
    require_auth(get_self());

    pending_pay_table pending_pay(get_self(), dac_id.value);
    const pay &       payClaim = pending_pay.get(payid, "ERR::CLAIMPAY_INVALID_CLAIM_ID::Invalid pay claim id.");

    pending_pay.erase(payClaim);
}

void daccustodian::rejectcuspay(uint64_t payid, name dac_id) {
    if (rejectoldpay_if_found(payid, dac_id)) {
        return; // if the condition returns true the action has been handled already
    }
    pending_pay_table pending_pay(get_self(), dac_id.value);
    const pay &       payClaim = pending_pay.get(payid, "ERR::CLAIMPAY_INVALID_CLAIM_ID::Invalid pay claim id.");
    assertValidMember(payClaim.receiver, dac_id);

    require_auth(payClaim.receiver);

    pending_pay.erase(payClaim);
}

// Temporary code for the old payments processing
bool daccustodian::claimoldpaye_if_found(uint64_t payid, name dac_id) {
    pending_pay_table_old pending_pay(get_self(), get_self().value);

    dacdir::dac dac = dacdir::dac_for_id(dac_id);

    contr_config configs  = contr_config::get_current_configs(get_self(), dac_id);
    auto         payClaim = pending_pay.find(payid);
    if (payClaim != pending_pay.end() && has_auth(payClaim->receiver)) {
        assertValidMember(payClaim->receiver, dac_id);

        require_auth(payClaim->receiver);

        transaction deferredTrans{};

        name   payment_destination;
        string memo;

        name service_account = dac.account_for_type(dacdir::SERVICE);
        name token_holder    = dac.account_for_type(dacdir::TREASURY);

        if (configs.should_pay_via_service_provider) {
            memo = payClaim->receiver.to_string() + ":" + payClaim->memo + ":" + to_string(payid);
            ;
            print("constructed memo for the service contract: " + memo);
            payment_destination = service_account;
        } else {
            memo = payClaim->memo + ":" + to_string(payid);
            ;
            print("constructed memo for the receiver contract: " + memo);
            payment_destination = payClaim->receiver;
        }

        deferredTrans.actions.emplace_back(
            action(permission_level{token_holder, "xfer"_n}, configs.requested_pay_max.contract, "transfer"_n,
                std::make_tuple(token_holder, payment_destination, payClaim->quantity, memo)));

        deferredTrans.actions.emplace_back(action(
            permission_level{get_self(), "pay"_n}, get_self(), "removecuspay"_n, std::make_tuple(payid, get_self())));

        deferredTrans.delay_sec = TRANSFER_DELAY;
        // Change here

        deferredTrans.send(uint128_t(payid) << 64 | time_point_sec(current_time_point()).sec_since_epoch(), get_self());
        return true;
    } else {
        return false;
    }
}

bool daccustodian::removeoldpay_if_found(uint64_t payid, name dac_id) {
    if (dac_id == get_self()) {
        require_auth(get_self());

        pending_pay_table_old pending_pay(get_self(), get_self().value);
        const payold &payClaim = pending_pay.get(payid, "ERR::CLAIMPAY_INVALID_CLAIM_ID::Invalid pay claim id.");

        pending_pay.erase(payClaim);
        return true;
    } else {
        return false;
    }
}

bool daccustodian::rejectoldpay_if_found(uint64_t payid, name dac_id) {
    pending_pay_table_old pending_pay(get_self(), get_self().value);
    auto                  payClaim = pending_pay.find(payid);
    if (payClaim != pending_pay.end() && has_auth(payClaim->receiver)) {
        assertValidMember(payClaim->receiver, dac_id);

        require_auth(payClaim->receiver);

        pending_pay.erase(payClaim);
        return true;
    } else {
        return false;
    }
}
// end Temporary code
