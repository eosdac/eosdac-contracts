#include <eosio/eosio.hpp>
#include <eosio/transaction.hpp>

#include <string>

#include "dacescrow.hpp"

using namespace eosio;
using namespace std;

namespace eosdac {

    dacescrow::~dacescrow() {}  


  ACTION dacescrow::transfer(name from,
                               name to,
                               asset quantity,
                               string memo) {

        if (to != _self){
            return;
        }

        require_auth(from);

        auto by_sender = escrows.get_index<"bysender"_n>();

        uint8_t found = 0;

        for (auto esc_itr = by_sender.lower_bound(from.value), end_itr = by_sender.upper_bound(from.value); esc_itr != end_itr; ++esc_itr) {
            if (esc_itr->ext_asset.quantity.amount == 0){

                by_sender.modify(esc_itr, from, [&](escrow_info &e) {
                    e.ext_asset = extended_asset{quantity, sending_code};
                });

                found = 1;

                break;
            }
        }

        check(found, "Could not find existing escrow to deposit to, transfer cancelled");
    }

    ACTION dacescrow::init(name sender, name receiver, name arb, time_point_sec expires, string memo, std::optional<uint64_t> ext_reference ) {
        require_auth(sender);

        extended_asset zero_asset{{0, symbol{"EOS", 4}}, "eosio.token"_n};

        auto by_sender = escrows.get_index<"bysender"_n>();

        for (auto esc_itr = by_sender.lower_bound(sender.value), end_itr = by_sender.upper_bound(sender.value); esc_itr != end_itr; ++esc_itr) {
            check(esc_itr->ext_asset.quantity.amount != 0, "You already have an empty escrow.  Either fill it or delete it");
        }

        if (ext_reference) {
            print("Has external reference: ", ext_reference.value());
            check(!key_for_external_key(*ext_reference),
                         "Already have an escrow with this external reference");
        }
        escrows.emplace(sender, [&](escrow_info &p) {
            p.key = escrows.available_primary_key();
            p.sender = sender;
            p.receiver = receiver;
            p.arb = arb;
            p.ext_asset = zero_asset;
            p.expires = expires;
            p.memo = memo;
            if (!ext_reference) {
                p.external_reference = -1;
            } else {
                p.external_reference = *ext_reference;
            }
        });
    }

    ACTION dacescrow::approve(uint64_t key, name approver) {
        require_auth(approver);

        auto esc_itr = escrows.find(key);
        check(esc_itr != escrows.end(), "Could not find escrow with that index");

        check(esc_itr->ext_asset.quantity.amount > 0, "This has not been initialized with a transfer");

        check(esc_itr->sender == approver || esc_itr->arb == approver, "You are not allowed to approve this escrow.");

        auto approvals = esc_itr->approvals;
        check(std::find(approvals.begin(), approvals.end(), approver) == approvals.end(), "You have already approved this escrow");

        escrows.modify(esc_itr, approver, [&](escrow_info &e){
            e.approvals.push_back(approver);
        });
    }

    ACTION dacescrow::approveext(uint64_t ext_key, name approver) {
        auto key = key_for_external_key(ext_key);
        check(key.has_value(), "No escrow exists for this external key.");
        approve(*key, approver);
    }

        ACTION dacescrow::unapprove(uint64_t key, name disapprover) {
        require_auth(disapprover);

        auto esc_itr = escrows.find(key);
        check(esc_itr != escrows.end(), "Could not find escrow with that index");

        escrows.modify(esc_itr, name{0}, [&](escrow_info &e){
            auto existing = std::find(e.approvals.begin(), e.approvals.end(), disapprover);
            check(existing != e.approvals.end(), "You have NOT approved this escrow");
            e.approvals.erase(existing);
        });
    }

    ACTION dacescrow::unapproveext(uint64_t ext_key, name unapprover) {
        auto key = key_for_external_key(ext_key);
        check(key.has_value(), "No escrow exists for this external key.");
        unapprove(*key, unapprover);
    }

    ACTION dacescrow::claim(uint64_t key) {

        auto esc_itr = escrows.find(key);
        check(esc_itr != escrows.end(), "Could not find escrow with that index");

        require_auth(esc_itr->receiver);

        check(esc_itr->ext_asset.quantity.amount > 0, "This has not been initialized with a transfer");

        auto approvals = esc_itr->approvals;

        check(approvals.size() >= 1, "This escrow has not received the required approvals to claim");

        //inline transfer the required funds
        eosio::action(
                eosio::permission_level{_self , "active"_n },
                esc_itr->ext_asset.contract, "transfer"_n,
                make_tuple( _self, esc_itr->sender, esc_itr->ext_asset.quantity, esc_itr->memo)
        ).send();


        escrows.erase(esc_itr);
    }

    ACTION dacescrow::claimext(uint64_t ext_key) {
        auto key = key_for_external_key(ext_key);
        check(key.has_value(), "No escrow exists for this external key.");
        print("found key to approve :", key.value());
        claim(*key);
    }

    /*
     * Empties an unfilled escrow request
     */
    ACTION dacescrow::cancel(uint64_t key) {

        auto esc_itr = escrows.find(key);
        check(esc_itr != escrows.end(), "Could not find escrow with that index");

        require_auth(esc_itr->sender);

        check(0 == esc_itr->ext_asset.quantity.amount, "Amount is not zero, this escrow is locked down");

        escrows.erase(esc_itr);
    }

    ACTION dacescrow::cancelext(uint64_t ext_key) {
        auto key = key_for_external_key(ext_key);
        check(key.has_value(), "No escrow exists for this external key.");
        print("found key to approve :", key.value());
        cancel(*key);
    }

    /*
     * Allows the sender to withdraw the funds if there are not enough approvals and the escrow has expired
     */
    ACTION dacescrow::refund(uint64_t key) {

        auto esc_itr = escrows.find(key);
        check(esc_itr != escrows.end(), "Could not find escrow with that index");

        require_auth(esc_itr->sender);

        check(esc_itr->ext_asset.quantity.amount > 0, "This has not been initialized with a transfer");

        time_point_sec time_now = time_point_sec(eosio::current_time_point());

        check(time_now >= esc_itr->expires, "Escrow has not expired");
        // check(esc_itr->approvals.size() >= 2, "Escrow has not received the required number of approvals");


        eosio::action(
                eosio::permission_level{_self , "active"_n }, esc_itr->ext_asset.contract, "transfer"_n,
                make_tuple( _self, esc_itr->sender, esc_itr->ext_asset.quantity, esc_itr->memo)
        ).send();


        escrows.erase(esc_itr);
    }

    ACTION dacescrow::refundext(uint64_t ext_key) {
        auto key = key_for_external_key(ext_key);
        check(key.has_value(), "No escrow exists for this external key.");
        print("found key to approve :", key.value());
        refund(*key);
    }

    ACTION dacescrow::clean() {
        require_auth(_self);

        auto itr = escrows.begin();
        while (itr != escrows.end()){
            itr = escrows.erase(itr);
        }
    }

    // private helper

    std::optional<uint64_t> dacescrow::key_for_external_key(std::optional<uint64_t> ext_key) {

        if (!ext_key.has_value()) {
            return std::nullopt;
        }

        auto by_external_ref = escrows.get_index<"byextref"_n>();

        for (auto esc_itr = by_external_ref.lower_bound(ext_key.value()), end_itr = by_external_ref.upper_bound(ext_key.value()); esc_itr != end_itr; ++esc_itr) {
            print("found a match key");
            return esc_itr->key;
        }
        print("no match key");
        return std::nullopt;
    }
}

#define EOSIO_ABI_EX(TYPE, MEMBERS) \
extern "C" { \
   void apply( uint64_t receiver, uint64_t code, uint64_t action ) { \
      if( action == "onerror"_n.value) { \
         /* onerror is only valid if it is for the "eosio" code account and authorized by "eosio"'s "active permission */ \
         check(code == "eosio"_n.value, "onerror action's are only valid from the \"eosio\" system account"); \
      } \
      auto self = receiver; \
      if( (code == self  && action != "transfer"_n.value) || (action == "transfer"_n.value) ) { \
         switch( action ) { \
            EOSIO_DISPATCH_HELPER( TYPE, MEMBERS ) \
         } \
         /* does not allow destructor of thiscontract to run: eosio_exit(0); */ \
      } \
   } \
}


EOSIO_ABI_EX(eosdac::dacescrow,
             (transfer)
                     (init)
                     (approve)
                     (approveext)
                     (unapprove)
                     (unapproveext)
                     (claim)
                     (claimext)
                     (refund)
                     (refundext)
                     (cancel)
                     (cancelext)
                     (clean)
)
    