#ifndef COMMON_UTILITIES_H
#define COMMON_UTILITIES_H
#include <eosio/eosio.hpp>

namespace eosdac {

    using namespace eosio;
    using namespace std;

    // Utility to combine ids to help with indexing.
    uint128_t combine_ids(const uint8_t &boolvalue, const uint64_t &longValue) {
        return (uint128_t{boolvalue} << 64) | longValue;
    }

    uint128_t combine_ids(const uint16_t &value, const uint64_t &longValue) {
        return (uint128_t{value} << 64) | longValue;
    }

    static const uint128_t combine_ids(const uint64_t &x, const uint64_t &y) {
        return (uint128_t{x} << 64) | y;
    }

    static const checksum256 combine_ids(const uint64_t &w, const uint64_t &x, const uint64_t &y, const uint64_t &z)
    {
        uint8_t arr[32];

        std::memcpy(arr, &w, 8);
        std::memcpy(arr + 8, &x, 8);
        std::memcpy(arr + 16, &y, 8);
        std::memcpy(arr + 24, &z, 8);
        
        return checksum256(arr);
    }

        static const __uint128_t
        raw_from_extended_symbol(const extended_symbol &symbol)
    {
        return (uint128_t{symbol.get_contract().value} << 64) | symbol.get_symbol().code().raw();
    }
}
#endif
