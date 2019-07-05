#ifndef EOSDACTOKENS_SHARED_H
#define EOSDACTOKENS_SHARED_H

#include <eosio/asset.hpp>
#include "dacdirectory_shared.hpp"
#include "common_utilities.hpp"
#include "eosio/eosio.hpp"

namespace eosdac {

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

    typedef eosio::multi_index<"members"_n, member> regmembers;
    typedef eosio::multi_index<"accounts"_n, account> accounts;


    static void assertValidMember(eosio::name member, eosio::name dac_scope) {
        eosio::name member_terms_account;
        
        // Start TempBlock
        if (dac_scope == "dacelections"_n) {
            dac_scope = "kasdactokens"_n;
            member_terms_account = "kasdactokens"_n;
        } else {
        // End TempBlock
            member_terms_account = dacdir::dac_for_id(dac_scope).account_for_type(dacdir::TOKEN); // Need this line without the temp block
        }
        regmembers reg_members(member_terms_account, dac_scope.value);
        memterms memberterms(member_terms_account, dac_scope.value);

        const auto &regmem = reg_members.get(member.value, "ERR::GENERAL_REG_MEMBER_NOT_FOUND::Account is not registered with members.");
        eosio::check((regmem.agreedterms != 0), "ERR::GENERAL_MEMBER_HAS_NOT_AGREED_TO_ANY_TERMS::Account has not agreed to any terms");
        auto latest_member_terms = (--memberterms.end());
        eosio::check(latest_member_terms->version == regmem.agreedterms, "ERR::GENERAL_MEMBER_HAS_NOT_AGREED_TO_LATEST_TERMS::Agreed terms isn't the latest.");
    }
}

#endif
