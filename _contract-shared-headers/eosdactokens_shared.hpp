#ifndef EOSDACTOKENS_SHARED_H
#define EOSDACTOKENS_SHARED_H

#include <eosio/asset.hpp>
#include "dacdirectory_shared.hpp"
#include "common_utilities.hpp"
#include "eosio/eosio.hpp"

namespace eosdac {

    struct account_stake_delta {
        name  account;
        asset stake_delta;
    };

    // This is a reference to the member struct as used in the eosdactoken contract.
    // @abi table members
    struct member {
        eosio::name sender;
        /// Hash of agreed terms
        uint64_t agreedterms;

        uint64_t primary_key() const { return sender.value; }
    };

    // This is a reference to the termsinfo struct as used in the eosdactoken contract.
    struct termsinfo {
        std::string terms;
        std::string hash;
        uint64_t version;

        uint64_t primary_key() const { return version; }
    };

    typedef eosio::multi_index<"memberterms"_n, termsinfo> memterms;

    struct account {
        eosio::asset balance;

        uint64_t primary_key() const { return balance.symbol.code().raw(); }
    };

    TABLE currency_stats {
            asset supply;
            asset max_supply;
            name issuer;
            bool transfer_locked = false;

            uint64_t primary_key() const { return supply.symbol.code().raw(); }
    };

    typedef eosio::multi_index<"stat"_n, currency_stats> stats;
    typedef eosio::multi_index<"members"_n, member> regmembers;
    typedef eosio::multi_index<"accounts"_n, account> accounts;


    TABLE stake_info {
            name  account;
            asset stake;

            uint64_t primary_key() const { return account.value; }
    };
    typedef multi_index<"stakes"_n, stake_info> stakes_table;

    TABLE unstake_info {
            uint64_t       key;
            name           account;
            asset          stake;
            time_point_sec release_time;

            uint64_t primary_key() const { return key; }
            uint64_t by_account() const { return account.value; }
    };
    typedef multi_index<"unstakes"_n, unstake_info,
            indexed_by<"byaccount"_n, const_mem_fun<unstake_info, uint64_t, &unstake_info::by_account> >
    > unstakes_table;

    TABLE staketime_info {
            name           account;
            uint32_t       delay;

            uint64_t primary_key() const { return account.value; }
    };
    typedef multi_index<"staketime"_n, staketime_info > staketimes_table;

    asset get_supply(name code, symbol_code sym) {
        stats statstable(code, sym.raw());
        const auto &st = statstable.get(sym.raw());
        return st.supply;
    }

    asset get_balance(name owner, name code, symbol_code sym) {
        accounts accountstable(code, owner.value);
        const auto &ac = accountstable.get(sym.raw());
        return ac.balance;
    }

    asset get_liquid(name owner, name code, symbol_code sym) {
        // Hardcoding a precision of 4, it doesnt matter because the index ignores precision
        dacdir::dac dac = dacdir::dac_for_symbol(extended_symbol{symbol{sym, 4}, code});

        stakes_table stakes(code, dac.dac_id.value);
        unstakes_table unstakes(code, dac.dac_id.value);
        auto unstakes_idx = unstakes.get_index<"byaccount"_n>();

        asset liquid = get_balance(owner, code, sym);

        auto existing_stake = stakes.find(owner.value);
        if (existing_stake != stakes.end()){
            liquid -= existing_stake->stake;
        }
        auto unstakes_itr = unstakes_idx.find(owner.value);
        while (unstakes_itr != unstakes_idx.end()){
            liquid -= unstakes_itr->stake;

            unstakes_itr++;
        }

        return liquid;
    }

    asset get_staked(name owner, name code, symbol_code sym) {
        // Hardcoding a precision of 4, it doesnt matter because the index ignores precision
        dacdir::dac dac = dacdir::dac_for_symbol(extended_symbol{symbol{sym, 4}, code});

        stakes_table stakes(code, dac.dac_id.value);

        asset staked = asset{0, symbol{sym, 4}};

        auto existing_stake = stakes.find(owner.value);
        if (existing_stake != stakes.end()){
            staked += existing_stake->stake;
        }

        return staked;
    }


    static void assertValidMember(eosio::name member, eosio::name dac_id) {
        eosio::name member_terms_account;
        
        member_terms_account = dacdir::dac_for_id(dac_id).symbol.get_contract(); // Need this line without the temp block
        regmembers reg_members(member_terms_account, dac_id.value);
        memterms memberterms(member_terms_account, dac_id.value);

        const auto &regmem = reg_members.get(member.value, "ERR::GENERAL_REG_MEMBER_NOT_FOUND::Account is not registered with members.");
        eosio::check((regmem.agreedterms != 0), "ERR::GENERAL_MEMBER_HAS_NOT_AGREED_TO_ANY_TERMS::Account has not agreed to any terms");
        auto latest_member_terms = (--memberterms.end());
        eosio::check(latest_member_terms->version == regmem.agreedterms, "ERR::GENERAL_MEMBER_HAS_NOT_AGREED_TO_LATEST_TERMS::Agreed terms isn't the latest.");
    }
}

#endif
