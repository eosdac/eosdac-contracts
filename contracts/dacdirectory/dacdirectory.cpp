#include "dacdirectory.hpp"

using namespace eosio;
using namespace std;

namespace eosdac {
    namespace dacdir {

        dacdirectory::dacdirectory(eosio::name self, eosio::name first_receiver, eosio::datastream<const char *> ds)
            : contract(self, first_receiver, ds), _dacs(get_self(), get_self().value) {}

        void dacdirectory::regdac(eosio::name owner, eosio::name dac_id, extended_symbol dac_symbol, string title,
            map<uint8_t, string> refs, map<uint8_t, eosio::name> accounts) {
            require_auth(owner);

            const vector<name> forbidden{
                "admin"_n, "builder"_n, "members"_n, "dacauthority"_n, "daccustodian"_n, "eosdactokens"_n};
            check(std::find(forbidden.begin(), forbidden.end(), dac_id) == forbidden.end(),
                "ERR::DAC_FORBIDDEN_NAME::DAC ID is forbidden");
            auto existing = _dacs.find(dac_id.value);

            auto symbol_idx          = _dacs.get_index<"bysymbol"_n>();
            auto matching_symbol_itr = symbol_idx.find(eosdac::raw_from_extended_symbol(dac_symbol));
            if (existing == _dacs.end()) {
                eosio::check(matching_symbol_itr == symbol_idx.end() ||
                                 matching_symbol_itr->symbol.get_symbol().code() != dac_symbol.get_symbol().code(),
                    "ERR::DAC_EXISTS_SYMBOL::A dac already exists for the provided symbol.");
            }

            if (existing == _dacs.end()) {
                // dac name must be >= 5 characters, with no dots
                // skip the extra 4 bytes
                uint64_t tmp     = dac_id.value >> 4;
                bool     started = false;
                uint8_t  length  = 0;
                for (uint8_t i = 0; i < 12; i++) {
                    if (!(tmp & 0x1f)) {
                        // blank (dot)
                        check(!started, "ERR::DAC_ID_DOTS::DAC ID cannot contain dots");
                    } else {
                        started = true;
                        length++;
                    }

                    tmp >>= 5;
                }
                check(length > 4, "ERR::DAC_ID_SHORT::DAC ID must be at least 5 characters");

                if (accounts.find(TREASURY) != accounts.end()) {
                    require_auth(accounts.at(TREASURY));
                }
                for (const auto &[key, account] : accounts) {
                    check(is_account(account), "ERR::ACCOUNT_DOES_NOT_EXIST: Account '%s' does not exist", account);
                }

                const auto owner_already_owns_a_dac = dac_for_owner(owner);
                check(!owner_already_owns_a_dac, "Owner %s already owns a dac %s", owner,
                    owner_already_owns_a_dac->dac_id);

                _dacs.emplace(owner, [&](dac &d) {
                    d.owner    = owner;
                    d.dac_id   = dac_id;
                    d.symbol   = dac_symbol;
                    d.title    = title;
                    d.refs     = refs;
                    d.accounts = accounts;
                });
            } else {
                require_auth(existing->owner);

                _dacs.modify(existing, same_payer, [&](dac &d) {
                    d.title = title;
                    d.refs  = refs;
                });
            }
        }

        void dacdirectory::unregdac(name dac_id) {

            auto dac = _dacs.find(dac_id.value);
            check(dac != _dacs.end(), "ERR::DAC_NOT_FOUND::DAC not found in directory");

            require_auth(dac->owner);

            _dacs.erase(dac);
        }

        void dacdirectory::regaccount(name dac_id, name account, uint8_t type) {

            check(is_account(account), "ERR::INVALID_ACCOUNT::Invalid or non-existent account supplied");

            auto dac_inst = _dacs.find(dac_id.value);
            check(dac_inst != _dacs.end(), "ERR::DAC_NOT_FOUND::DAC not found in directory");

            require_auth(dac_inst->owner);

            if (type == TREASURY) {
                require_auth(account);
            }

            _dacs.modify(dac_inst, same_payer, [&](dac &d) {
                d.accounts[type] = account;
            });
        }

        void dacdirectory::unregaccount(name dac_id, uint8_t type) {

            auto dac_inst = _dacs.find(dac_id.value);
            check(dac_inst != _dacs.end(), "ERR::DAC_NOT_FOUND::DAC not found in directory");

            require_auth(dac_inst->owner);

            _dacs.modify(dac_inst, same_payer, [&](dac &a) {
                a.accounts.erase(type);
            });
        }

        void dacdirectory::regref(name dac_id, string value, uint8_t type) {

            auto dac_inst = _dacs.find(dac_id.value);
            check(dac_inst != _dacs.end(), "ERR::DAC_NOT_FOUND::DAC not found in directory");

            require_auth(dac_inst->owner);

            _dacs.modify(dac_inst, same_payer, [&](dac &d) {
                d.refs[type] = value;
            });
        }

        void dacdirectory::unregref(name dac_id, uint8_t type) {

            auto dac_inst = _dacs.find(dac_id.value);
            check(dac_inst != _dacs.end(), "ERR::DAC_NOT_FOUND::DAC not found in directory");

            require_auth(dac_inst->owner);

            _dacs.modify(dac_inst, same_payer, [&](dac &d) {
                d.refs.erase(type);
            });
        }

        void dacdirectory::setowner(name dac_id, name new_owner) {

            auto existing_dac = _dacs.find(dac_id.value);
            check(existing_dac != _dacs.end(), "ERR::DAC_NOT_FOUND::DAC not found in directory");

            require_auth(existing_dac->owner);
            require_auth(new_owner);

            _dacs.modify(existing_dac, new_owner, [&](dac &d) {
                d.owner = new_owner;
            });
        }

        void dacdirectory::settitle(name dac_id, string title) {
            auto existing_dac = _dacs.find(dac_id.value);
            check(existing_dac != _dacs.end(), "ERR::DAC_NOT_FOUND::DAC not found in directory");

            require_auth(existing_dac->owner);

            _dacs.modify(existing_dac, same_payer, [&](dac &d) {
                d.title = title;
            });
        }

        void dacdirectory::setstatus(name dac_id, uint8_t value) {
            auto dac_inst = _dacs.find(dac_id.value);
            check(dac_inst != _dacs.end(), "ERR::DAC_NOT_FOUND::DAC not found in directory");

            require_auth(get_self());

            _dacs.modify(dac_inst, same_payer, [&](dac &d) {
                d.dac_state = value;
            });
        }
        
        void dacdirectory::upsert_nft(const uint64_t id, const std::optional<name> old_owner_optional, const name new_owner) {
            const auto  assets = atomicassets::assets_t(NFT_CONTRACT, new_owner.value);
            const auto &nft    = assets.get(id, fmt("Owner %s does not own NFT with id %s", new_owner, id));
            if (nft.collection_name != NFT_COLLECTION || nft.schema_name != BUDGET_SCHEMA) {
                return;
            }
            const auto percentage = nft::get_immutable_attr<uint16_t>(nft, "percentage");

            if (old_owner_optional) {
                const auto old_owner        = *old_owner_optional;
                const auto old_dac_optional = dacdir::dac_for_owner(old_owner);
                if (old_dac_optional) {
                    const auto old_dac   = *old_dac_optional;
                    auto       nftcache  = nftcache_table{DACDIRECTORY_CONTRACT, old_dac.dac_id.value};
                    const auto to_delete = nftcache.find(id);
                    if (to_delete != nftcache.end()) {
                        nftcache.erase(to_delete);
                    }
                }
            }

            const auto new_dac_optional = dacdir::dac_for_owner(new_owner);
            if (new_dac_optional) {
                const auto new_dac  = *new_dac_optional;
                auto       nftcache = nftcache_table{DACDIRECTORY_CONTRACT, new_dac.dac_id.value};
                upsert(nftcache, id, get_self(), [&](auto &x) {
                    x.nft_id      = id;
                    x.schema_name = nft.schema_name;
                    x.value       = percentage;
                });
            }
        }



        #ifdef IS_DEV
        void dacdirectory::indextest() {
          const auto dacs = dacdir::dac_table{DACDIRECTORY_CONTRACT, DACDIRECTORY_CONTRACT.value};
          const auto dac = dacs.begin();
          auto       _nftcache = nftcache_table{DACDIRECTORY_CONTRACT, dac->dac_id.value};

          const auto schema_name = "myschema"_n;
          auto data = std::vector<nftcache>{
            {.nft_id=1, .schema_name=schema_name, .value=92},
            {.nft_id=2, .schema_name=schema_name, .value=561},
            {.nft_id=3, .schema_name=schema_name, .value=239},
            {.nft_id=4, .schema_name=schema_name, .value=966},
            {.nft_id=5, .schema_name=schema_name, .value=380},
            {.nft_id=6, .schema_name=schema_name, .value=1},
            {.nft_id=7, .schema_name=schema_name, .value=518},
            {.nft_id=8, .schema_name=schema_name, .value=654},
            {.nft_id=9, .schema_name=schema_name, .value=876},
            {.nft_id=10, .schema_name=schema_name, .value=299},
            {.nft_id=11, .schema_name=schema_name, .value=20},
            {.nft_id=12, .schema_name=schema_name, .value=31},
          };
          for(const auto &nft: data) {
            _nftcache.emplace(get_self(), [&](auto &x) {
              x.nft_id = nft.nft_id;
              x.schema_name = nft.schema_name;
              x.value = nft.value;
            });
          }
          
          // sort by value descending 
          std::sort(data.begin(), data.end(),[](auto &a, auto &b) {
                return a.value > b.value;
            });

          const auto index    = _nftcache.get_index<"valdesc"_n>();
          const auto index_key = nftcache::template_and_value_key_ascending(schema_name, 0);
          auto       itr       = index.lower_bound(index_key);  
          
          for(const auto &nft: data) {
            check(itr->value == nft.value && itr->schema_name == nft.schema_name, "index is not correctly sorted expected: %s actual: %s schema_name: %s nft_id: %s", nft.value, itr->value, itr->schema_name, itr->nft_id);
            itr++;
          }  
        }
        #endif
        
        void dacdirectory::logtransfer(const name collection_name, const name from, const name new_owner,
            const vector<uint64_t> &asset_ids, const string &memo) {
            for (const auto asset_id : asset_ids) {
                upsert_nft(asset_id, from, new_owner);
            }
        }

        void dacdirectory::logmint(const uint64_t asset_id, const name authorized_minter, const name collection_name,
            const name schema_name, const int32_t preset_id, const name new_asset_owner,
            const atomicdata::ATTRIBUTE_MAP &immutable_data, const atomicdata::ATTRIBUTE_MAP &mutable_data,
            const vector<asset> &backed_tokens) {
            upsert_nft(asset_id, {}, new_asset_owner);
        }

    } // namespace dacdir
} // namespace eosdac
