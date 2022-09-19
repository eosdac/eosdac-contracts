#pragma once

#include "common_utilities.hpp"
#include "config.hpp"
#include <eosio/eosio.hpp>
#include <eosio/multi_index.hpp>
#include <eosio/symbol.hpp>

namespace eosdac {
    namespace dacdir {

        enum account_type : uint8_t {
            /**
             * @brief Account that holds DAO's main collection of valuable tokens.
             * This account is then used for a source of payment for DACProposals, token source for custodian pay and
             * new period DAO budgets,
             *
             */
            TREASURY = 1,
            /**
             * @brief Common smart contract to manange the election process for each DAC
             *
             */
            CUSTODIAN = 2,
            /**
             * @brief Dac specific account to be managed by the DAC CUSODIAN election process - includes high, med, low
             * and one permissions.
             *
             */
            MSIGOWNED = 3,
            /**
             * @brief For legal compliance payments may need to be made via a legal service entity rather than direct
             * blockchain. This is currently only used for Custodian Period Pay.
             *
             */
            SERVICE = 5,
            /**
             * @brief Common contract used for worker proposals (This is a complex, multistage system to replace the
             * native multisigs for the DACs)
             *
             */
            PROPOSALS = 6,
            /**
             * @brief Common contract used to act as the escrow account for dacproposals. This is designed to work in
             * close partnership with PROPOSALS and the reason for having a separate contract is that ESCROW should have
             * it's keys null'd out for security while PROPOSALS is complicated and is more likely to be updatedin the
             * future.
             *
             */
            ESCROW = 7,
            /**
             * @brief Common contract used for used for stake * time weighted voting rather than liquid token weighted.
             *
             */
            VOTE_WEIGHT = 8,
            /**
             * @brief If set provides a mechanism for an authorised account to activate a DAC rather than wait for the
             * preconfigured thresholds to activate a DAC.
             *
             */
            ACTIVATION = 9,
            /**
             * @brief Common smart contract used for referrendums. The referrendum types can be binding,
             * semi-binding or opinion, ranging from preparing and executing an msig or just a signal for the
             * custodians.
             *
             */
            REFERENDUM = 10,
            SPENDINGS  = 11, // Account to hold all the spending allowance for the current period.
            EXTERNAL   = 254,
            OTHER      = 255
        };

        enum ref_type : uint8_t {
            HOMEPAGE            = 0,
            LOGO_URL            = 1,
            DESCRIPTION         = 2,
            LOGO_NOTEXT_URL     = 3,
            BACKGROUND_URL      = 4,
            COLORS              = 5,
            CLIENT_EXTENSION    = 6,
            FAVICON_URL         = 7,
            DAC_CURRENCY_URL    = 8,
            SYSTEM_CURRENCY_URL = 9,
            DISCORD_URL         = 10,
            TELEGRAM_URL        = 11,
        };

        enum dac_state_type : uint8_t { dac_state_typeINACTIVE = 0, dac_state_typeACTIVE = 1 };

        struct [[eosio::table("dacs"), eosio::contract("dacdirectory")]] dac {
            eosio::name                    owner;
            eosio::name                    dac_id;
            std::string                    title;
            eosio::extended_symbol         symbol;
            std::map<uint8_t, std::string> refs;
            std::map<uint8_t, eosio::name> accounts;
            uint8_t                        dac_state;

            eosio::name account_for_type(account_type type) const {
                const auto x = accounts.find(type);
                check(x != accounts.end(),
                    "ERR:ACC_NOT_FOUND: Account for type %s not found in dac with dac_id %s owned by %s",
                    std::to_string(type), dac_id, owner);
                return x->second;
            }

            std::optional<eosio::name> account_for_type_maybe(account_type type) const {
                const auto x = accounts.find(type);
                if (x != accounts.end()) {
                    return x->second;
                } else {
                    return {};
                }
            }
            
            uint64_t  primary_key() const { return dac_id.value; }
            uint64_t  by_owner() const { return owner.value; }
            uint128_t by_symbol() const { return eosdac::raw_from_extended_symbol(symbol); }
        };

        using dac_table = eosio::multi_index<"dacs"_n, dac,
            eosio::indexed_by<"byowner"_n, eosio::const_mem_fun<dac, uint64_t, &dac::by_owner>>,
            eosio::indexed_by<"bysymbol"_n, eosio::const_mem_fun<dac, uint128_t, &dac::by_symbol>>>;

        const dac dac_for_id(eosio::name id) {
            dac_table dactable = dac_table(DACDIRECTORY_CONTRACT, DACDIRECTORY_CONTRACT.value);
            return dactable.get(id.value, "ERR::DAC_NOT_FOUND::DAC not found in directory");
        }

        const dac dac_for_symbol(eosio::extended_symbol sym) {
            dac_table dactable = dac_table(DACDIRECTORY_CONTRACT, DACDIRECTORY_CONTRACT.value);
            auto      index    = dactable.get_index<"bysymbol"_n>();
            auto      dac_idx  = index.find(eosdac::raw_from_extended_symbol(sym));
            eosio::check(dac_idx != index.end() && dac_idx->symbol.get_symbol().code() == sym.get_symbol().code(),
                "ERR::DAC_NOT_FOUND_SYMBOL::DAC not found in directory for the given symbol");
            return *dac_idx;
        }
        
        const std::optional<dac> dac_for_owner(eosio::name owner) {
          const auto dactable = dac_table{DACDIRECTORY_CONTRACT, DACDIRECTORY_CONTRACT.value};
          const auto      index    = dactable.get_index<"byowner"_n>();
          const auto itr = index.find(owner.value);
          if(itr != index.end()) {
            return *itr;
          } else {
            return {};
          }
        }
        
        struct [[eosio::table("nftcache"), eosio::contract("dacdirectory")]] nftcache {
            uint64_t nft_id;
            name  schema_name;
            uint64_t value;

            uint64_t primary_key() const { return nft_id; }

            static uint128_t template_and_value_key_descending(name schema_name, uint64_t value) {
                return (uint128_t(schema_name.value) << uint128_t(64)) | uint128_t(std::numeric_limits<uint64_t>::max() - value);
            }

            static uint128_t template_and_value_key_ascending(name schema_name, uint64_t value) {
              return (uint128_t(schema_name.value) << uint128_t(64)) | uint128_t(value);
            }
            
            uint128_t by_template_and_value_descending() const {
                return template_and_value_key_descending(schema_name, value);
            }

            uint128_t by_template_and_value_ascending() const {
                return template_and_value_key_ascending(schema_name, value);
            }
        };

        using nftcache_table = multi_index<"nftcache"_n, nftcache,
            indexed_by<"valasc"_n, const_mem_fun<nftcache, uint128_t, &nftcache::by_template_and_value_ascending>>,
            indexed_by<"valdesc"_n, const_mem_fun<nftcache, uint128_t, &nftcache::by_template_and_value_descending>>>;
        
    } // namespace dacdir
} // namespace eosdac
