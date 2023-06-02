#include "../../contract-shared-headers/contracts-common/string_format.hpp"
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
        name sending_code;

      public:
        dacescrow(name s, name code, datastream<const char *> ds) : contract(s, code, ds) {
            sending_code = name{code};
        }

        ~dacescrow();

        /**
         * Escrow contract
         */

        ACTION init(
            name sender, name receiver, name arb, time_point_sec expires, string memo, name ext_reference, name dac_id);
        using init_action = action_wrapper<"init"_n, &dacescrow::init>;

        [[eosio::on_notify("*::transfer")]] void transfer(name from, name to, asset quantity, string memo);
        /**
         * @brief This action can only be a called by the sender of the escrow or the arbitrator if the escrow is
         * locked. Upon a success the escrow funds wil be sent to the receiver of the escrow funds and the arbitrators
         * fees will be sent to the arbitraor account. Then the escrow record will be removed from the contract table.
         *
         * @param key: the unique identifier for the escrow entry
         * @param approver: the EOSIO account name for the account approving this escrow.
         * @param dac_id The dac_id for the scope where the escrow is stored
         */
        ACTION approve(name key, name approver, name dac_id);
        /**
         * @brief This action can only be a called by the assigned arbitrator for the escrow. Upon a success the
         * escrow funds wil be returned to the sender of the escrow funds and the escrow record will be removed from the
         * contract table.
         *
         * @param key: the unique identifier for the escrow entry
         * @param disapprover: the EOSIO account name for the account disapproving this escrow.
         * @param dac_id The dac_id for the scope where the escrow is stored
         */
        ACTION disapprove(name key, name disapprover, name dac_id);
        /**
         * @brief This action is intended to refund the escrowed amount back to the sender. It can only be called by
         * sender after expiry and when the escrow is not locked for arbitration. Upon success the escrowed funds will
         * be transferred back to the sender's account and the escrow record will be removed from the contract.
         *
         * @param key Unique identifer for the escrow to refund
         * @param dac_id The dac_id for the scope where the escrow is stored

         */
        ACTION refund(name key, name dac_id);

        /**
         * @brief This action is intended to dispute an escrow that has not been paid but the receiver feels should be
         * paid. It can only be called by the intended receiver of the escrow after funds have been transferred into the
         * identified escrow. Upon success the escrow record will be locked and then it can only be resolved by the
         * nominated arbitrator for the escrow.
         *
         * @param key Unique identifer for the escrow to refund
         * @param dac_id The dac_id for the scope where the escrow is stored
         */
        ACTION dispute(name key, name dac_id);
        /**
         * @brief This action is intended to cancel an escrow. It can only be called by the sender of the escrow before
         * funds have been transferred into the identified escrow. Upon success the escrow record will be deleted the
         * escrow contract table.
         *
         * @param key Unique identifer for the escrow to refund
         * @param dac_id The dac_id for the scope where the escrow is stored
         */
        ACTION cancel(name key, name dac_id);
        /**
         * @brief This action is intended to clean out all records in the escrow contract. It should only be used for
         * development purposes and should not be used in production. It requires the `self` permission ofthe contract.
         *
         * @param dac_id The dac_id for the scope where the escrow is stored
         */
        ACTION clean(name dac_id);

      private:
        void pay_arbitrator(const escrows_table::const_iterator esc_itr);
        void refund_arbitrator_pay(const escrows_table::const_iterator esc_itr);
    };
} // namespace eosdac
