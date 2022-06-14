#pragma once

#include "../../contract-shared-headers/dacdirectory_shared.hpp"
#include "nft.hpp"
#include <eosio/eosio.hpp>
#include <eosio/multi_index.hpp>
#include <eosio/symbol.hpp>
#include <eosio/system.hpp>

using namespace eosio;
using namespace std;

namespace eosdac {
    namespace dacdir {
        CONTRACT dacdirectory : public contract {
          public:
            dacdirectory(name self, name first_receiver, datastream<const char *> ds);

            ACTION regdac(name owner, name dac_id, extended_symbol dac_symbol, string title, map<uint8_t, string> refs,
                map<uint8_t, eosio::name> accounts);
            ACTION unregdac(name dac_id);
            ACTION regaccount(name dac_id, name account, uint8_t type);
            ACTION unregaccount(name dac_id, uint8_t type);
            ACTION regref(name dac_id, string value, uint8_t type);
            ACTION unregref(name dac_id, uint8_t type);
            ACTION setowner(name dac_id, name new_owner);
            ACTION settitle(name dac_id, string title);
            ACTION setstatus(name dac_id, uint8_t value);
#ifdef IS_DEV
            ACTION indextest();
#endif
            /* NFT token log */
            [[eosio::on_notify(NFT_CONTRACT_STR "::logtransfer")]] void logtransfer(const name collection_name,
                const name from, const name new_owner, const vector<uint64_t> &asset_ids, const string &memo);

            /* NFT token log */
            [[eosio::on_notify(NFT_CONTRACT_STR "::logmint")]] void logmint(const uint64_t asset_id,
                const name authorized_minter, const name collection_name, const name schema_name,
                const int32_t preset_id, const name new_asset_owner, const atomicdata::ATTRIBUTE_MAP &immutable_data,
                const atomicdata::ATTRIBUTE_MAP &mutable_data, const vector<asset> &backed_tokens);

          private:
            void upsert_nft(const uint64_t id, const std::optional<name> old_owner_optional, const name new_owner);

          protected:
            dac_table _dacs;
        };
    } // namespace dacdir
} // namespace eosdac
