#ifndef COMMON_UTILITIES_H
#define COMMON_UTILITIES_H
#include <eosio/eosio.hpp>
#include <eosio/symbol.hpp>
#include <eosio/asset.hpp>

using namespace eosio;
using namespace std;

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
 * Polymorphic helper to convert common EOS.IO types to string
 */
template<typename T>
inline string toString(const T& x) {
  if constexpr(is_same<T, string>::value) {
    return x;
  } else if constexpr(is_same<T, eosio::name>::value || is_same<T, eosio::asset>::value){
    return x.to_string();
  } else if constexpr(is_same<T, eosio::symbol>::value) {
    return x.code().to_string();
  } else {
    return to_string(x);
  }
} 

/*
 * C++'s missing format string function :-)
 */
template<typename... Args>
inline string fmt(const string& format, Args const& ... args){
  char buf[512];
  snprintf(buf, sizeof(buf), format.c_str(), toString(args).c_str()...);
  return buf;
}
/* eosio::check overload that allows passing a format string for more 
 * helpful error messages.
 */
template<typename... Args>
inline void check(bool pred, const string& format, Args const& ... args) {
  if(!pred) {
    const auto msg = fmt(format, args...);
    check(pred, msg.c_str());    
  }
}

#endif
