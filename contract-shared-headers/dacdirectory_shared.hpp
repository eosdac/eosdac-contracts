#pragma once

#include "common_utilities.hpp"
#include <eosio/eosio.hpp>
#include <eosio/multi_index.hpp>
#include <eosio/symbol.hpp>

namespace eosdac {

    namespace dacdir {

        enum account_type : uint8_t {
            AUTH        = 0,
            TREASURY    = 1,
            CUSTODIAN   = 2,
            MSIGOWNED   = 3,
            SERVICE     = 5,
            PROPOSALS   = 6,
            ESCROW      = 7,
            VOTE_WEIGHT = 8,
            ACTIVATION  = 9,
            REFERENDUM  = 10,
            EXTERNAL    = 254,
            OTHER       = 255
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

            eosio::name account_for_type(uint8_t type) const {
                eosio::print("\ngetting account for type: ", type, "\n");
                const auto x = accounts.find(type);
                check(x != accounts.end(),
                    "ERR:ACC_NOT_FOUND: Account for type %s not found in dac with dac_id %s owned by %s",
                    std::to_string(type), dac_id, owner);
                return x->second;
            }

            std::optional<eosio::name> account_for_type_maybe(uint8_t type) const {
                eosio::print("\ngetting account for type: ", type, "\n");
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
            dac_table dactable = dac_table("dacdirectory"_n, "dacdirectory"_n.value);
            return dactable.get(id.value, "ERR::DAC_NOT_FOUND::DAC not found in directory");
        }

        const dac dac_for_symbol(eosio::extended_symbol sym) {
            dac_table dactable = dac_table("dacdirectory"_n, "dacdirectory"_n.value);
            auto      index    = dactable.get_index<"bysymbol"_n>();
            auto      dac_idx  = index.find(eosdac::raw_from_extended_symbol(sym));
            eosio::check(dac_idx != index.end() && dac_idx->symbol.get_symbol().code() == sym.get_symbol().code(),
                "ERR::DAC_NOT_FOUND_SYMBOL::DAC not found in directory for the given symbol");
            return *dac_idx;
        }
    } // namespace dacdir
} // namespace eosdac
