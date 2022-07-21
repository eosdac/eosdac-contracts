#pragma once

#include "common_utilities.hpp"
#include <eosio/eosio.hpp>
#include <math.h>

/**
 * @brief narrow_cast is just an alias for static_cast but it makes it explicit that
 * that the programmer intended to narrowcast a value while accepting conversion
 * losses (e.g. from float to int rounding down).
 * Adapted from: https://github.com/microsoft/GSL/blob/main/include/gsl/util (MIT licensed)
 *
 * @param u: the value to downcast to type T
 */
template <class T, class U>
constexpr T narrow_cast(U &&u) {
    return static_cast<T>(std::forward<U>(u));
}

template <typename T>
class S {
    T n;

  public:
    explicit constexpr S(T a) : n(a) {
        static_assert(std::is_unsigned_v<T> || std::is_signed_v<T>, "wrong type, only for numbers");
    };

    constexpr T value() const {
        return n;
    }

    constexpr operator T() const {
        return value();
    }

    static constexpr T min() {
        return std::numeric_limits<T>::min();
    }

    static constexpr T max() {
        return std::numeric_limits<T>::max();
    }

    std::string to_string() const {
        if constexpr (std::is_same_v<T, int128_t>) {
            return std::to_string(to<int64_t>());
        } else if constexpr (std::is_same_v<T, uint128_t>) {
            return std::to_string(to<uint64_t>());
        } else {
            return std::to_string(n);
        }
    }

    // a checked version of narrow_cast() that throws if the cast changed the value
    // Adapted from: https://github.com/microsoft/GSL/blob/main/include/gsl/narrow (MIT licensed)
    template <typename U, typename std::enable_if<std::is_arithmetic<U>::value>::type * = nullptr>
    constexpr S<U> to() const {
        static_assert(!std::is_floating_point_v<T> || !std::is_integral_v<U>,
            "Conversion from floating point to integral is not lossless");
        constexpr const auto is_different_signedness = (std::is_signed<U>::value != std::is_signed<T>::value);

        const auto u = narrow_cast<U>(n);
        if (static_cast<T>(u) != n || (is_different_signedness && ((u < U{}) != (n < T{})))) {
            ::check(false, "Invalid narrow cast");
        }
        return S<U>{u};
    }

    /**
     * Unary minus operator
     *
     */
    constexpr S operator-() const {
        static_assert(std::is_signed_v<T>, "operator-() works only on signed");
        auto r = *this;
        ::check(n != min(), "overflow");
        r.n = -r.n;
        return r;
    }

    /**
     * Subtraction assignment operator
     */
    constexpr S &operator-=(const S a) {
        if constexpr (std::is_floating_point_v<T>) {
            n -= a.n;
            ::check(!isinf(n), "infinity");
            ::check(!isnan(n), "NaN");
        } else if constexpr (std::is_unsigned_v<T>) {
            ::check(n >= a.n, "invalid unsigned subtraction: result would be negative");
            n -= a.n;
        } else {
            ::check(a.n <= 0 || n >= min() + a.n, "signed subtraction underflow");
            ::check(a.n >= 0 || n <= max() + a.n, "signed subtraction overflow");
            n -= a.n;
        }
        return *this;
    }

    /**
     * Addition Assignment  operator
     */
    constexpr S &operator+=(const S &a) {
        if constexpr (std::is_floating_point_v<T>) {
            n += a.n;
            ::check(!isinf(n), "infinity");
            ::check(!isnan(n), "NaN");
        } else if constexpr (std::is_unsigned_v<T>) {
            ::check(max() - n >= a.n, "unsigned wrap");
            n += a.n;
        } else {
            ::check(a.n <= 0 || n <= max() - a.n, "signed addition overflow");
            ::check(a.n >= 0 || n >= min() - a.n, "signed addition underflow");
            n += a.n;
        }
        return *this;
    }

    /**
     * Addition operator
     */
    template <typename U, typename V>
    constexpr friend S<T> operator+(const U &a, const V &b) {
        static_assert(std::is_same_v<U, V>, "Types don't match");
        S result = a;
        result += b;
        return result;
    }

    /**
     * Subtraction operator
     */
    template <typename U, typename V>
    constexpr friend S operator-(const U &a, const V &b) {
        static_assert(std::is_same_v<U, V>, "Types don't match");
        S result = a;
        result -= b;
        return result;
    }

    /**
     * Multiplication assignment operator
     */
    constexpr S &operator*=(const S &a) {
        if constexpr (std::is_floating_point_v<T>) {
            n *= a.n;
            ::check(!isinf(n), "infinity");
            ::check(!isnan(n), "NaN");
        } else if constexpr (std::is_unsigned_v<T>) {
            ::check(n <= max() / a.n, "unsigned multiplication overflow");
            n *= a.n;
        } else {
            if (n > 0) {
                if (a.n > 0) {
                    ::check(n <= max() / a.n, "signed multiplication overflow");
                } else {
                    ::check(a.n >= min() / n, "signed multiplication underflow");
                }
            } else {
                if (a.n > 0) {
                    ::check(n >= min() / a.n, "signed multiplication underflow");
                } else {
                    ::check(n == 0 || a.n >= max() / n, "signed multiplication overflow");
                }
            }
            n *= a.n;
        }
        return *this;
    }

    /**
     * Multiplication operator
     */
    template <typename U, typename V>
    constexpr friend S operator*(const U &a, const V &b) {
        static_assert(std::is_same_v<U, V>, "Types don't match");
        S result = a;
        result *= b;
        return result;
    }

    /**
     * Division assignment operator
     */
    constexpr S &operator/=(const S &a) {
        ::check(a.n != 0, "division by zero");
        ::check(!(n == min() && a.n == -1), "division overflow");
        n /= a.n;
        return *this;
    }

    /**
     * Division operator
     */
    template <typename U, typename V>
    constexpr friend S operator/(const U &a, const V &b) {
        static_assert(std::is_same_v<U, V>, "Types don't match");
        S result = a;
        result /= b;
        return result;
    }

    /**
     * Checked abs function. Contrary to the abs function from math.h, this will
     * also work with int128_t data types.
     */
    constexpr S<T> abs() {
        S r = *this;
        if (n < T{}) {
            r = -r;
        }
        return r;
    }

    /**
     * Checked x to the power of y function for integers
     */
    template <typename U>
    constexpr S ipow(U x) {
        static_assert(std::is_same_v<T, U>, "Types don't match");
        static_assert(std::is_integral_v<T>, "wrong type, pow is only for integers");
        ::check(x >= 0, "pow: exponent must be non-negative");
        S r = *this;
        if (x == 0) {
            r.n = 1;
        } else {
            auto y = S{T{1}};
            while (x > 1) {
                if ((x % 2) == 0) { // even
                    r *= r;
                    x /= 2;
                } else { // odd
                    y *= r;
                    r *= r;
                    x = (x - 1) / 2;
                }
            }
            r *= y;
        }

        return r;
    }

    /*----------------------------------------------------------------
     * The following operator extravaganza can be shortened quite a bit
     * with C++20 by implementing the starship operator.
     */

    /**
     * Equality operator
     */
    constexpr friend bool operator==(const S &a, const S &b) {
        return a.n == b.n;
    }

    /**
     * Equality operator with anything that has a == operator
     */
    constexpr friend bool operator==(const S &a, const T b) {
        return a.n == b;
    }

    /**
     * Equality operator with anything that has a == operator
     */
    constexpr friend bool operator==(const T b, const S &a) {
        return a.n == b;
    }

    /**
     * Inequality operator
     */
    constexpr friend bool operator!=(const S &a, const S &b) {
        return !(a == b);
    }

    /**
     * Inequality operator
     */
    constexpr friend bool operator!=(const S &a, const T b) {
        return !(a == b);
    }

    /**
     * Inequality operator
     */
    constexpr friend bool operator!=(const T b, const S &a) {
        return !(a == b);
    }

    /**
     * Less than operator
     */
    constexpr friend bool operator<(const S &a, const S &b) {
        return a.n < b.n;
    }

    /**
     * Less than operator
     */
    constexpr friend bool operator<(const S &a, const T b) {
        return a.n < b;
    }

    /**
     * Less than operator
     */
    constexpr friend bool operator<(const T b, const S &a) {
        return a.n < b;
    }

    /**
     * Less or equal to operator
     */
    constexpr friend bool operator<=(const S &a, const S &b) {
        return a.n <= b.n;
    }

    /**
     * Less or equal to operator
     */
    constexpr friend bool operator<=(const S &a, const T b) {
        return a.n <= b;
    }

    /**
     * Less or equal to operator
     */
    constexpr friend bool operator<=(const T b, const S &a) {
        return a.n <= b;
    }

    /**
     * Greater than operator
     */
    constexpr friend bool operator>(const S &a, const S &b) {
        return a.n > b.n;
    }

    /**
     * Greater than operator
     */
    constexpr friend bool operator>(const S &a, const T b) {
        return a.n > b;
    }
    /**
     * Greater than operator
     */
    constexpr friend bool operator>(const T b, const S &a) {
        return a.n > b;
    }

    /**
     * Greater or equal to operator
     */
    constexpr friend bool operator>=(const S &a, const S &b) {
        return a.n >= b;
    }

    /**
     * Greater or equal to operator
     */
    constexpr friend bool operator>=(const S &a, const T b) {
        return a.n >= b;
    }

    /**
     * Greater or equal to operator
     */
    constexpr friend bool operator>=(const T b, const S &a) {
        return a.n >= b;
    }
};
