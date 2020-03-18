#include "dacescrow_shared.hpp"
#include <eosio/asset.hpp>
#include <eosio/eosio.hpp>
#include <eosio/time.hpp>
#include <optional>

using namespace eosio;
using namespace std;

namespace eosdac {
    class dacescrow : public contract {

      private:
        escrows_table escrows;
        name          sending_code;

      public:
        dacescrow(name s, name code, datastream<const char *> ds) : contract(s, code, ds), escrows(_self, _self.value) {
            sending_code = name{code};
        }

        ~dacescrow();

        /**
         * Escrow contract
         */

        ACTION init(name sender, name receiver, name arb, time_point_sec expires, string memo, name ext_reference,
            std::optional<uint16_t> arb_payment);

        ACTION transfer(name from, name to, asset quantity, string memo);
        /**
         * @brief This action can only be a called by the sender of the escrow or the arbitrator if the escrow is
         * locked. Upon a success the escrow funds wil be sent to the receiver of the escrow funds and the arbitrators
         * fees will be sent to the arbitraor account. Then the escrow record will be removed from the contract table.
         *
         * @param key: the unique identifier for the escrow entry
         * @param approver: the EOSIO account name for the account approving this escrow.
         */
        ACTION approve(name key, name approver);
        /**
         * @brief This action can only be a called by the assigned arbitrator for the escrow. Upon a success the
         * escrow funds wil be returned to the sender of the escrow funds and the escrow record will be removed from the
         * contract table.
         *
         * @param key: the unique identifier for the escrow entry
         * @param disapprover: the EOSIO account name for the account disapproving this escrow.
         */
        ACTION disapprove(name key, name disapprover);
        /**
         * @brief This action is intended to refund the escrowed amount back to the sender. It can only be called by
         * sender after expiry and when the escrow is not locked for arbitration. Upon success the escrowed funds will
         * be transferred back to the sender's account and the escrow record will be removed from the contract.
         *
         * @param key Unique identifer for the escrow to refund
         */
        ACTION refund(name key);

        /**
         * @brief This action is intended to dispute an escrow that has not been paid but the receiver feels should be
         * paid. It can only be called by the intended receiver of the escrow after funds have been transferred into the
         * identified escrow. Upon success the escrow record will be locked and then it can only be resolved by the
         * nominated arbitrator for the escrow.
         *
         * @param key Unique identifer for the escrow to refund
         */
        ACTION dispute(name key);
        /**
         * @brief This action is intended to cancel an escrow. It can only be called by the sender of the escrow before
         * funds have been transferred into the identified escrow. Upon success the escrow record will be deleted the
         * escrow contract table.
         *
         * @param key Unique identifer for the escrow to refund
         */
        ACTION cancel(name key);
        /**
         * @brief This action is intended to clean out all records in the escrow contract. It should only be used for
         * development purposes and should not be used in production. It requires the `self` permission ofthe contract.
         *
         * @param key Unique identifer for the escrow to refund
         */
        ACTION clean();

      private:
        void pay_arbitrator(const escrows_table::const_iterator esc_itr);
    }; // namespace eosdac
