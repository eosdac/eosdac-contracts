#include <eosiolib/eosio.hpp>
#include <eosiolib/asset.hpp>
#include <eosiolib/transaction.hpp>

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

        asset zero_asset{0, symbol{"EOS", 4}};

        auto by_sender = escrows.get_index<"bysender"_n>();

        uint8_t found = 0;

        for (auto esc_itr = by_sender.lower_bound(from.value), end_itr = by_sender.upper_bound(from.value); esc_itr != end_itr; ++esc_itr) {
            if (esc_itr->amount == zero_asset){

                by_sender.modify(esc_itr, from, [&](escrow_info &e) {
                    e.amount = quantity;
                });

                found = 1;

                break;
            }
        }

        eosio_assert(found, "Could not find existing escrow to deposit to, transfer cancelled");
    }


    ACTION dacescrow::init(name sender, name receiver, name arb, time_point_sec expires, string memo) {
        require_auth(sender);

        asset zero_asset{0, symbol{"EOS", 4}};

        auto by_sender = escrows.get_index<"bysender"_n>();
        auto existing = by_sender.begin();

        while (existing != by_sender.end()){
            eosio_assert(existing->amount != zero_asset, "You already have an empty escrow.  Either fill it or delete it");
            existing++;
        }

        escrows.emplace(sender, [&](escrow_info &p) {
            p.key = escrows.available_primary_key();
            p.sender = sender;
            p.receiver = receiver;
            p.arb = arb;
            p.amount = zero_asset;
            p.expires = expires;
            p.memo = memo;
        });
    }

    ACTION dacescrow::approve(uint64_t key, name approver) {
        require_auth(approver);

        auto esc_itr = escrows.find(key);
        eosio_assert(esc_itr != escrows.end(), "Could not find escrow with that index");

        eosio_assert(esc_itr->sender == approver || esc_itr->receiver == approver || esc_itr->arb == approver, "You are not involved in this escrow");

        auto approvals = esc_itr->approvals;
        eosio_assert(std::find(approvals.begin(), approvals.end(), approver) == approvals.end(), "You have already approved this escrow");

        escrows.modify(esc_itr, approver, [&](escrow_info &e){
            e.approvals.push_back(approver);
        });
    }

    ACTION dacescrow::unapprove(uint64_t key, name disapprover) {
        require_auth(disapprover);

        auto esc_itr = escrows.find(key);
        eosio_assert(esc_itr != escrows.end(), "Could not find escrow with that index");

        eosio_assert(esc_itr->sender == disapprover || esc_itr->receiver == disapprover || esc_itr->arb == disapprover, "You are not involved in this escrow");

        auto approvals = esc_itr->approvals;
        auto existing = std::find(approvals.begin(), approvals.end(), disapprover);
        eosio_assert(existing != approvals.end(), "You have NOT approved this escrow");

        escrows.modify(esc_itr, name{0}, [&](escrow_info &e){
            e.approvals.erase(existing);
        });
    }

    ACTION dacescrow::claim(uint64_t key) {

        auto esc_itr = escrows.find(key);
        eosio_assert(esc_itr != escrows.end(), "Could not find escrow with that index");

        require_auth(esc_itr->receiver);

        auto approvals = esc_itr->approvals;

        eosio_assert(approvals.size() >= 2, "This escrow does not have the required approvals to claim");

        //inline transfer the required funds
        transaction pay_trans{};

        pay_trans.actions.emplace_back(
            action(permission_level{_self, "active"_n},
                   "eosio.token"_n, "transfer"_n,
                   std::make_tuple(_self, esc_itr->receiver, esc_itr->amount, esc_itr->memo)
            )
        );

        pay_trans.send(key, esc_itr->receiver);

        escrows.erase(esc_itr);
    }

    /*
     * Allows the sender to withdraw the funds if there are not enough approvals and the escrow has expired
     */
    ACTION dacescrow::refund(uint64_t key) {

        auto esc_itr = escrows.find(key);
        eosio_assert(esc_itr != escrows.end(), "Could not find escrow with that index");

        require_auth(esc_itr->sender);

    }

    ACTION dacescrow::clean() {
        require_auth(_self);

        auto itr = escrows.begin();
        while (itr != escrows.end()){
            itr = escrows.erase(itr);
        }

    }
}

#define EOSIO_ABI_EX(TYPE, MEMBERS) \
extern "C" { \
   void apply( uint64_t receiver, uint64_t code, uint64_t action ) { \
      if( action == "onerror"_n.value) { \
         /* onerror is only valid if it is for the "eosio" code account and authorized by "eosio"'s "active permission */ \
         eosio_assert(code == "eosio"_n.value, "onerror action's are only valid from the \"eosio\" system account"); \
      } \
      auto self = receiver; \
      if( (code == self  && action != "transfer"_n.value) || (code == "eosio.token"_n.value && action == "transfer"_n.value) ) { \
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
             (unapprove)
             (claim)
             (refund)
             (clean)
)
