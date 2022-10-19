#pragma once

#include "common_utilities.hpp"
#include "dacdirectory_shared.hpp"
#include "eosio/eosio.hpp"
#include <eosio/asset.hpp>

namespace eosdac {

    struct stake_config;

    using stakeconfig_container = eosio::singleton<"stakeconfig"_n, stake_config>;
    struct [[eosio::table("stakeconfig"), eosio::contract("eosdactokens")]] stake_config {
        bool enabled = false;
#ifdef IS_DEV
        uint32_t min_stake_time = 3 * DAYS;
        uint32_t max_stake_time = 9 * MONTHS;
#else
        uint32_t min_stake_time = 2;
        uint32_t max_stake_time = 2 * DAYS;
#endif
        static stake_config get_current_configs(eosio::name account, eosio::name scope) {
            return stakeconfig_container(account, scope.value).get_or_default(stake_config());
        }

        void save(eosio::name account, eosio::name scope, eosio::name payer = same_payer) {
            stakeconfig_container(account, scope.value).set(*this, payer);
        }
    };

    struct account_stake_delta {
        name     account;
        asset    stake_delta;
        uint32_t unstake_delay;
    };

    struct account_balance_delta {
        eosio::name  account;
        eosio::asset balance_delta;
    };

    struct account_weight_delta {
        eosio::name account;
        int64_t     weight_delta;
        int64_t     weight_delta_quorum;
    };

    // This is a reference to the member struct as used in the eosdactoken contract.
    // @abi table members
    struct member {
        eosio::name sender;
        /// Hash of agreed terms
        uint64_t agreedterms;

        uint64_t primary_key() const {
            return sender.value;
        }
    };

    // This is a reference to the termsinfo struct as used in the eosdactoken contract.
    struct termsinfo {
        std::string terms;
        std::string hash;
        uint64_t    version;

        uint64_t primary_key() const {
            return version;
        }
    };

    using memterms = eosio::multi_index<"memberterms"_n, termsinfo>;

    struct account {
        eosio::asset balance;

        uint64_t primary_key() const {
            return balance.symbol.code().raw();
        }
    };

    TABLE currency_stats {
        asset supply;
        asset max_supply;
        name  issuer;
        bool  transfer_locked = false;

        uint64_t primary_key() const {
            return supply.symbol.code().raw();
        }
    };

    using stats      = eosio::multi_index<"stat"_n, currency_stats>;
    using regmembers = eosio::multi_index<"members"_n, member>;
    using accounts   = eosio::multi_index<"accounts"_n, account>;

    TABLE stake_info {
        name  account;
        asset stake;

        uint64_t primary_key() const {
            return account.value;
        }
    };
    using stakes_table = multi_index<"stakes"_n, stake_info>;

    TABLE unstake_info {
        uint64_t       key;
        name           account;
        asset          stake;
        time_point_sec release_time;

        uint64_t primary_key() const {
            return key;
        }
        uint64_t by_account() const {
            return account.value;
        }
        bool released() const {
            const auto now = time_point_sec(current_time_point());
            return now > release_time;
        }
    };
    using unstakes_table = multi_index<"unstakes"_n, unstake_info,
        indexed_by<"byaccount"_n, const_mem_fun<unstake_info, uint64_t, &unstake_info::by_account>>>;

    struct staketime_info;
    using staketimes_table = multi_index<"staketime"_n, staketime_info>;

    TABLE staketime_info {
        name     account;
        uint32_t delay;

        uint64_t primary_key() const {
            return account.value;
        }

        static uint32_t get_delay(const name account, const name dac_id, const name user) {
            const auto config     = stake_config::get_current_configs(account, dac_id);
            const auto staketimes = staketimes_table{account, dac_id.value};
            const auto existing   = staketimes.find(user.value);
            return existing != staketimes.end() ? existing->delay : config.min_stake_time;
        }
    };

    asset get_supply(name code, symbol_code sym) {
        stats       statstable(code, sym.raw());
        const auto &st =
            statstable.get(sym.raw(), fmt("eosdactokens::get_supply symbol %s not found in statstable", sym));
        return st.supply;
    }

    asset get_balance(name owner, name code, symbol_code sym) {
        accounts    accountstable(code, owner.value);
        const auto &ac =
            accountstable.get(sym.raw(), fmt("eosdactokens::get_balance user %s has no %s balance", owner, sym));
        return ac.balance;
    }

    asset get_balance_graceful(name owner, name code, symbol sym) {
        accounts   accountstable(code, owner.value);
        const auto itr = accountstable.find(sym.code().raw());
        if (itr != accountstable.end()) {
            return itr->balance;
        } else {
            return asset{0, sym};
        }
    }

    asset get_liquid(name owner, name code, symbol sym) {
        // Hardcoding a precision of 4, it doesnt matter because the index ignores precision
        dacdir::dac dac = dacdir::dac_for_symbol(extended_symbol{sym, code});

        stakes_table   stakes(code, dac.dac_id.value);
        unstakes_table unstakes(code, dac.dac_id.value);
        auto           unstakes_idx = unstakes.get_index<"byaccount"_n>();

        asset liquid = get_balance(owner, code, sym.code());

        auto existing_stake = stakes.find(owner.value);
        if (existing_stake != stakes.end()) {
            liquid -= existing_stake->stake;
        }
        auto unstakes_itr = unstakes_idx.find(owner.value);
        while (unstakes_itr != unstakes_idx.end()) {
            if (unstakes_itr->released()) {
                print("this is already released, erasing");
                // if this unstake is already released, it can be safely deleted
                unstakes_itr = unstakes_idx.erase(unstakes_itr);
            } else {
                print("NOT yet released");

                // otherwise it still negatively impacts the liquid balance
                liquid -= unstakes_itr->stake;
                unstakes_itr++;
            }
        }

        return liquid;
    }

    std::pair<asset, string> get_liquid_debug(name owner, name code, symbol sym) {

        std::string debug_output = "";

        // Hardcoding a precision of 4, it doesnt matter because the index ignores precision
        dacdir::dac dac = dacdir::dac_for_symbol(extended_symbol{sym, code});

        stakes_table   stakes(code, dac.dac_id.value);
        unstakes_table unstakes(code, dac.dac_id.value);
        auto           unstakes_idx = unstakes.get_index<"byaccount"_n>();

        asset liquid = get_balance(owner, code, sym.code());
        debug_output += fmt("get_balance(%s, %s, %s) = %s | ", owner, code, sym.code(), liquid);
        auto existing_stake = stakes.find(owner.value);
        if (existing_stake != stakes.end()) {
            debug_output += fmt("reducing by existing_stake->stake: %s | ", existing_stake->stake);
            liquid -= existing_stake->stake;
        }
        debug_output += fmt("liquid is now: %s | ", liquid);

        auto unstakes_itr = unstakes_idx.find(owner.value);
        while (unstakes_itr != unstakes_idx.end()) {
            if (unstakes_itr->released()) {
                print("this is already released, erasing");
                // if this unstake is already released, it can be safely deleted
                debug_output += fmt("deleting stake %s | ", unstakes_itr->stake);
                unstakes_itr = unstakes_idx.erase(unstakes_itr);
            } else {
                print("NOT yet released");

                // otherwise it still negatively impacts the liquid balance
                debug_output += fmt("reducing by unstakes_itr->stake: %s | ", unstakes_itr->stake);
                liquid -= unstakes_itr->stake;
                debug_output += fmt("liquid is now: %s | ", liquid);
                unstakes_itr++;
            }
        }
        debug_output += fmt("while loop ended liquid is now: %s", liquid);

        return {liquid, debug_output};
    }

    asset get_staked(name owner, name code, symbol sym) {
        // Hardcoding a precision of 4, it doesnt matter because the index ignores precision
        dacdir::dac dac = dacdir::dac_for_symbol(extended_symbol{sym, code});

        stakes_table stakes(code, dac.dac_id.value);

        asset staked = asset{0, sym};

        auto existing_stake = stakes.find(owner.value);
        if (existing_stake != stakes.end()) {
            staked += existing_stake->stake;
        }

        return staked;
    }

    static void assertValidMembers(const std::vector<name> &members, eosio::name dac_id) {
        eosio::name member_terms_account;

        member_terms_account =
            dacdir::dac_for_id(dac_id).symbol.get_contract(); // Need this line without the temp block
        regmembers reg_members(member_terms_account, dac_id.value);
        memterms   memberterms(member_terms_account, dac_id.value);
        auto       latest_member_terms = (--memberterms.end());
        for (const auto member : members) {
            const auto &regmem = reg_members.get(member.value,
                fmt("ERR::GENERAL_REG_MEMBER_NOT_FOUND::Account %s is not registered with members.", member));
            eosio::check((regmem.agreedterms != 0),
                "ERR::GENERAL_MEMBER_HAS_NOT_AGREED_TO_ANY_TERMS::Account has not agreed to any terms");
            eosio::check(latest_member_terms->version == regmem.agreedterms,
                "ERR::GENERAL_MEMBER_HAS_NOT_AGREED_TO_LATEST_TERMS::Agreed terms isn't the latest.");
        }
    }

    static void assertValidMember(name member, eosio::name dac_id) {
        auto members = std::vector{member};
        assertValidMembers(members, dac_id);
    }
} // namespace eosdac
