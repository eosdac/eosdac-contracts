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

    ACTION dacescrow::init(name sender, name receiver, name arb, time_point_sec expires, string memo, uint64_t ext_reference, std::optional<uint16_t> arb_payment) {
        require_auth(sender);

        check(receiver != arb, "Receiver cannot be the same as arbitrator");
        check(sender != arb, "Sender cannot be the same as arbitrator");
        check(expires > time_point_sec(eosio::current_time_point()), "Expiry date is in the past");

        uint64_t arb_payment_int = 0;

        if (arb_payment && arb_payment.value() >= 0){
            arb_payment_int = arb_payment.value();
        }
        check(arb_payment_int <= 20'00, "Arbitrator payment cannot be over 20%");

        extended_asset zero_asset{{0, symbol{"EOS", 4}}, "eosio.token"_n};

        auto by_sender = escrows.get_index<"bysender"_n>();

        for (auto esc_itr = by_sender.lower_bound(sender.value), end_itr = by_sender.upper_bound(sender.value); esc_itr != end_itr; ++esc_itr) {
            check(esc_itr->ext_asset.quantity.amount > 0, "You already have an empty escrow.  Either fill it or delete it");
        }

        print("Check reference: ", ext_reference);
        check(!key_for_external_key(ext_reference),
                         "Already have an escrow with this external reference");

        escrows.emplace(sender, [&](escrow_info &p) {
            p.key = escrows.available_primary_key();
            p.sender = sender;
            p.receiver = receiver;
            p.arb = arb;
            p.ext_asset = zero_asset;
            p.expires = expires;
            p.memo = memo;
            p.external_reference = ext_reference;
            p.arb_payment = arb_payment_int;
        });
    }

    ACTION dacescrow::approve(uint64_t key, name approver) {
        require_auth(approver);

        auto index = key_for_external_key(key);
        check(index.has_value(), "Escrow index not found by key");
        auto esc_itr = escrows.find(index.value());
        check(esc_itr != escrows.end(), "Could not find escrow with that index");

        check(esc_itr->ext_asset.quantity.amount > 0, "This has not been initialized with a transfer");

        check(esc_itr->sender == approver || esc_itr->arb == approver, "You are not allowed to approve this escrow.");

        // send funds to the receiver
        eosio::action(
                eosio::permission_level{_self , "active"_n }, esc_itr->ext_asset.contract, "transfer"_n,
                make_tuple( _self, esc_itr->receiver, esc_itr->ext_asset.quantity, esc_itr->memo)
        ).send();

        escrows.erase(esc_itr);
    }

    ACTION dacescrow::disapprove(uint64_t key, name disapprover) {
        require_auth(disapprover);

        auto index = key_for_external_key(key);
        check(index.has_value(), "Escrow index not found by key");
        auto esc_itr = escrows.find(index.value());
        check(esc_itr != escrows.end(), "Could not find escrow with that index");

        check(esc_itr->ext_asset.quantity.amount > 0, "This has not been initialized with a transfer");

        check(disapprover == esc_itr->arb, "Only arbitrator can disapprove");

        // return funds back to the sender
        // TODO: Send arbitrator payment too
        eosio::action(
                eosio::permission_level{_self , "active"_n }, esc_itr->ext_asset.contract, "transfer"_n,
                make_tuple( _self, esc_itr->sender, esc_itr->ext_asset.quantity, esc_itr->memo)
        ).send();

        escrows.erase(esc_itr);
    }

    /*
     * Empties an unfilled escrow request
     */
    ACTION dacescrow::cancel(uint64_t key) {

        auto index = key_for_external_key(key);
        check(index.has_value(), "Escrow index not found by key");
        auto esc_itr = escrows.find(index.value());
        check(esc_itr != escrows.end(), "Could not find escrow with that index");

        require_auth(esc_itr->sender);

        check(0 == esc_itr->ext_asset.quantity.amount, "Amount is not zero, this escrow is locked down");

        escrows.erase(esc_itr);
    }

    /*
     * Allows the sender to withdraw the funds if the escrow has expired
     */
    ACTION dacescrow::refund(uint64_t key) {
        auto index = key_for_external_key(key);
        check(index.has_value(), "Escrow index not found by key");
        auto esc_itr = escrows.find(index.value());
        check(esc_itr != escrows.end(), "Could not find escrow with that index");

        require_auth(esc_itr->sender);

        check(esc_itr->ext_asset.quantity.amount > 0, "This has not been initialized with a transfer");

        time_point_sec time_now = time_point_sec(eosio::current_time_point());

        check(time_now >= esc_itr->expires, "Escrow has not expired");

        eosio::action(
                eosio::permission_level{_self , "active"_n }, esc_itr->ext_asset.contract, "transfer"_n,
                make_tuple( _self, esc_itr->sender, esc_itr->ext_asset.quantity, esc_itr->memo)
        ).send();


        escrows.erase(esc_itr);
    }

    ACTION dacescrow::clean() {
        require_auth(_self);

        auto itr = escrows.begin();
        while (itr != escrows.end()){
            itr = escrows.erase(itr);
        }
    }

    // private helper

    std::optional<uint64_t> dacescrow::key_for_external_key(uint64_t ext_key) {

        if (!ext_key) {
            return std::nullopt;
        }

        auto by_external_ref = escrows.get_index<"byextref"_n>();

        for (auto esc_itr = by_external_ref.lower_bound(ext_key), end_itr = by_external_ref.upper_bound(ext_key); esc_itr != end_itr; ++esc_itr) {
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
                     (disapprove)
                     (refund)
                     (cancel)
                     (clean)
)
    