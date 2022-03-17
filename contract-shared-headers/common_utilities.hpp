#pragma once
#include <eosio/asset.hpp>
#include <eosio/eosio.hpp>
#include <eosio/symbol.hpp>
#include <experimental/type_traits>

using namespace eosio;

namespace eosdac {

    // Utility to combine ids to help with indexing.
    uint128_t combine_ids(const uint8_t &boolvalue, const uint64_t &longValue) {
        return (uint128_t{boolvalue} << 64) | longValue;
    }

    uint128_t combine_ids(const uint16_t &value, const uint64_t &longValue) {
        return (uint128_t{value} << 64) | longValue;
    }

    static const uint128_t combine_ids(const uint64_t &x, const uint64_t &y) { return (uint128_t{x} << 64) | y; }

    static const checksum256 combine_ids(const uint64_t &w, const uint64_t &x, const uint64_t &y, const uint64_t &z) {
        uint8_t arr[32];

        std::memcpy(arr, &w, 8);
        std::memcpy(arr + 8, &x, 8);
        std::memcpy(arr + 16, &y, 8);
        std::memcpy(arr + 24, &z, 8);

        return checksum256(arr);
    }

    static const __uint128_t raw_from_extended_symbol(const extended_symbol &symbol) {
        return (uint128_t{symbol.get_contract().value} << 64) | symbol.get_symbol().code().raw();
    }

} // namespace eosdac

/*
 * Helper functions to build more helpful error and debug messages:
 */

/* Helpers to detect if a type has the "to_string" method */
template <typename T> using to_string_t = decltype(std::declval<T>().to_string());

template <typename T> using has_to_string = std::experimental::is_detected<to_string_t, T>;

/*
 * Polymorphic helper to convert common EOS.IO types to string
 */
template <typename T> inline std::string toString(const T &x) {
    if constexpr (std::is_same<T, std::string>::value) {
        return x;
    } else if constexpr (std::is_same<T, eosio::symbol>::value) {
        return x.code().to_string();
    } else if constexpr (has_to_string<T>::value) {
        return x.to_string();
    } else {
        return std::to_string(x);
    }
}

/*
 * C++'s missing format string function :-)
 */
template <typename... Args> inline char *fmt(const std::string_view format, Args const &...args) {
    static char buf[512];
    snprintf(buf, sizeof(buf), format.data(), toString(args).c_str()...);
    return buf;
}
/* eosio::check overload that allows passing a format string for more
 * helpful error messages.
 */
template <typename... Args> inline void check(bool pred, const std::string_view format, Args const &...args) {
    if (!pred) {
        const auto msg = fmt(format, args...);
        check(pred, msg);
    }
}

/**
 * Helper to insert or update a value in eosio tables. If table entry with 
 * primary key pk is found, the table entry is updated using the supplied 
 * updater function, if no table entry exists, it is emplaced using that same 
 * function.
 *
 * @param table - The eosio multi_index instance
 * @param pk - The primary key of the table entry to insert or update
 * @param payer - The RAM payer
 * @param updater - The updater lambda function (e.g. [&](auto &x) { x.id = id; x.key = value;} )
 * @return true - if a new table entry was created
 * @return false - if an existing table entry was updated
 */
template <typename Table, typename Pk, typename Function>
bool upsert(Table &table, const Pk &pk, const eosio::name payer, const Function &updater) {
    const auto itr = table.find(pk);
    if (itr == table.end()) {
        table.emplace(payer, updater);
        return true;
    } else {
        table.modify(itr, payer, updater);
        return false;
    }
}
