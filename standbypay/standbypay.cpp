#include "standbypay.hpp"

using namespace eosdac;
using namespace std;

void standbypay::newperiod( newperiod_notify nn, name dac_id ) {
    checkAuth(dac_id);

    // find standbys, first we have to remove the current custodians because it is possible votes between newperiod
    // and this notification being called
    // TODO : Check the lastperiodtime against one that we store to make sure a new period has been called

    vector<name> custodians_list;
    vector<name> standbys_list;
    uint8_t      number_standbys = 6;

    dacdir::dac dac = dacdir::dac_for_id(dac_id);
    auto custodian_account = dac.account_for_type(dacdir::CUSTODIAN);

    custodians_table custodians(custodian_account, dac_id.value);
    candidates_table candidates(custodian_account, dac_id.value);

    auto cust = custodians.begin();
    while (cust != custodians.end()){
        custodians_list.push_back(cust->cust_name);

        cust++;
    }


    auto by_votes = candidates.get_index<"byvotesrank"_n>();
    auto cand = by_votes.begin();
    while (cand != by_votes.end() && standbys_list.size() < number_standbys){
        if (std::find(custodians_list.begin(), custodians_list.end(), cand->candidate_name) != custodians_list.end()){
            standbys_list.push_back(cand->candidate_name);
        }

        cand++;
    }

    distributeStandbyPay(standbys_list, dac, dac_id);
}


// Following copied with small modifications from daccustodian


void standbypay::distributeStandbyPay(vector<name> standbys, dacdir::dac dac, name dac_id) {

    name custodian_account = dac.account_for_type(dacdir::CUSTODIAN);
    name auth_account = dacdir::dac_for_id(dac_id).account_for_type(dacdir::AUTH);

    custodians_table custodians(get_self(), dac_id.value);
    pending_pay_table pending_pay(get_self(), dac_id.value);
    contr_config configs = contr_config::get_current_configs(get_self(), dac_id);


    //Find the mean pay using a temporary vector to hold the requestedpay amounts.
    asset total = asset{0, configs.requested_pay_max.quantity.symbol};
    int64_t count = 0;
    for (auto cust: custodians) {
        total += cust.requestedpay;
        count += 1;
    }

    asset meanAsset = count == 0 ? total : total / count;
    extended_asset standbyAsset = extended_asset(meanAsset/2, configs.requested_pay_max.contract);

    if (meanAsset.amount > 0) {
        for (auto standby: standbys) {
            pending_pay.emplace(get_self(), [&](pay &p) {
                p.key = pending_pay.available_primary_key();
                p.receiver = standby;
                p.quantity = standbyAsset;
                p.memo = "Standby pay. Thank you.";
            });
        }
    }

    print("distribute mean pay");
}



void standbypay::claimpay(uint64_t payid, name dac_id) {
    pending_pay_table pending_pay(get_self(), dac_id.value);

    dacdir::dac dac = dacdir::dac_for_id(dac_id);
    name service_account = dac.account_for_type(dacdir::SERVICE);
    name token_holder = dac.account_for_type(dacdir::TREASURY);
    name custodian_account = dac.account_for_type(dacdir::CUSTODIAN);

    contr_config configs = contr_config::get_current_configs(custodian_account, dac_id);
    const pay &payClaim = pending_pay.get(payid, "ERR::CLAIMPAY_INVALID_CLAIM_ID::Invalid pay claim id.");
//    assertValidMember(payClaim.receiver, dac_id);

    require_auth(payClaim.receiver);

    transaction deferredTrans{};

    name payment_destination;
    string memo;


    if (configs.should_pay_via_service_provider) {
        memo = payClaim.receiver.to_string() + ":" + payClaim.memo + ":" + to_string(payid);;
        print("constructed memo for the service contract: " + memo);
        payment_destination = service_account;
    } else {
        memo = payClaim.memo + ":" + to_string(payid);;
        print("constructed memo for the receiver contract: " + memo);
        payment_destination = payClaim.receiver;
    }

    deferredTrans.actions.emplace_back(
            action(permission_level{token_holder, "xfer"_n},
                   configs.requested_pay_max.contract,
                   "transfer"_n,
                   std::make_tuple(token_holder, payment_destination, payClaim.quantity, memo)
            ));

    deferredTrans.actions.emplace_back(
            action(permission_level{get_self(), "pay"_n},
                   get_self(), "removecuspay"_n,
                   std::make_tuple(payid, dac_id)
            ));

    deferredTrans.delay_sec = 60;
    deferredTrans.send(uint128_t(payid) << 64 | time_point_sec(current_time_point()).sec_since_epoch() , get_self());
}

void standbypay::removepay(uint64_t payid, name dac_id) {
    require_auth(get_self());

    pending_pay_table pending_pay(get_self(), get_self().value);
    const pay &payClaim = pending_pay.get(payid, "ERR::CLAIMPAY_INVALID_CLAIM_ID::Invalid pay claim id.");

    pending_pay.erase(payClaim);
}

void standbypay::rejectpay(uint64_t payid, name dac_id) {
    pending_pay_table pending_pay(get_self(), get_self().value);
    const pay &payClaim = pending_pay.get(payid, "ERR::CLAIMPAY_INVALID_CLAIM_ID::Invalid pay claim id.");
//    assertValidMember(payClaim.receiver, dac_id);

    require_auth(payClaim.receiver);

    pending_pay.erase(payClaim);
}




// Private methods

void standbypay::checkAuth( name dac_id ){
    dacdir::dac dac = dacdir::dac_for_id(dac_id);

    auto relay_account = dac.account_for_type(dacdir::NOTIFY_RELAY);
    require_auth(relay_account);
}
