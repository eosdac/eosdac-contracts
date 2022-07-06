#pragma once

#include <eosio/eosio.hpp>
#include <math.h>

template <typename T>
class S {
    T n;

  public:
    constexpr S(T a) : n(a) {
        static_assert(std::is_unsigned_v<T> || std::is_signed_v<T>, "wrong type, only for numbers");
    };

    T value() const {
        return n;
    }

    operator T() const {
        return value();
    }

    T min() const {
        return std::numeric_limits<T>::min();
    }

    T max() const {
        return std::numeric_limits<T>::max();
    }

    template <typename U>
    auto to() const {
        const auto max_u = std::numeric_limits<U>::max();
        if constexpr (std::is_unsigned_v<U>) {
            eosio::check(n >= 0, "Cannot convert negative value to unsigned");
        } else {
            eosio::check(n >= -max_u, "conversion underflow");
        }
        eosio::check(n <= max_u, "conversion overflow");
        return S<U>{static_cast<U>(n)};
    }

    /**
     * Unary minus operator
     *
     */
    S operator-() const {
        static_assert(std::is_signed_v<T>, "operator-() works only on signed");
        auto r = *this;
        eosio::check(n != min(), "overflow");
        r.n = -r.n;
        return r;
    }

    /**
     * Subtraction assignment operator
     */
    S &operator-=(const S a) {
        if constexpr (std::is_floating_point_v<T>) {
            n -= a.n;
            eosio::check(!isinf(n), "infinity");
            eosio::check(!isnan(n), "NaN");
        } else if constexpr (std::is_unsigned_v<T>) {
            eosio::check(n >= a.n, "invalid unsigned subtraction: result would be negative");
            n -= a.n;
        } else {
            eosio::check(a.n <= 0 || n >= min() + a.n, "signed subtraction underflow");
            eosio::check(a.n >= 0 || n <= max() + a.n, "signed subtraction overflow");
            n -= a.n;
        }
        return *this;
    }

    /**
     * Addition Assignment  operator
     */
    S &operator+=(const S &a) {
        if constexpr (std::is_floating_point_v<T>) {
            n += a.n;
            eosio::check(!isinf(n), "infinity");
            eosio::check(!isnan(n), "NaN");
        } else if constexpr (std::is_unsigned_v<T>) {
            eosio::check(max() - n >= a.n, "unsigned wrap");
            n += a.n;
        } else {
            eosio::check(a.n <= 0 || n <= max() - a.n, "signed addition overflow");
            eosio::check(a.n >= 0 || n >= min() - a.n, "signed addition underflow");
            n += a.n;
        }
        return *this;
    }

    /**
     * Addition operator
     */
    inline friend S operator+(const S &a, const S &b) {
        S result = a;
        result += b;
        return result;
    }

    /**
     * Subtraction operator
     */
    inline friend S operator-(const S &a, const S &b) {
        S result = a;
        result -= b;
        return result;
    }

    /**
     * Multiplication assignment operator
     */
    S &operator*=(const S &a) {
        if constexpr (std::is_floating_point_v<T>) {
            n *= a.n;
            eosio::check(!isinf(n), "infinity");
            eosio::check(!isnan(n), "NaN");
        } else if constexpr (std::is_unsigned_v<T>) {
            eosio::check(n <= max() / a.n, "unsigned multiplication overflow");
            n *= a.n;
        } else {
            if (n > 0) {
                if (a.n > 0) {
                    eosio::check(n <= max() / a.n, "signed multiplication overflow");
                } else {
                    eosio::check(a.n >= min() / n, "signed multiplication underflow");
                }
            } else {
                if (a.n > 0) {
                    eosio::check(n >= min() / a.n, "signed multiplication underflow");
                } else {
                    eosio::check(n == 0 || a.n >= max() / n, "signed multiplication overflow");
                }
            }
            n *= a.n;
        }
        return *this;
    }

    /**
     * Multiplication operator
     */
    inline friend S operator*(const S &a, const S &b) {
        S result = a;
        result *= b;
        return result;
    }

    /**
     * Division assignment operator
     */
    S &operator/=(const S &a) {
        eosio::check(a.n != 0, "division by zero");
        eosio::check(!(n == min() && a.n == -1), "division overflow");
        n /= a.n;
        return *this;
    }

    /**
     * Division operator
     */
    inline friend S operator/(const S &a, const S &b) {
        S result = a;
        result /= b;
        return result;
    }

    /*----------------------------------------------------------------
     * The following operator extravaganza can be shortened quite a bit
     * with C++20 by implementing the starship operator.
     */

    /**
     * Equality operator
     */
    friend bool operator==(const S &a, const S &b) {
        return a.n == b.n;
    }

    /**
     * Equality operator with anything that has a == operator
     */
    template <typename U>
    friend bool operator==(const S &a, const U b) {
        return a.n == b;
    }

    /**
     * Equality operator with anything that has a == operator
     */
    template <typename U>
    friend bool operator==(const U b, const S &a) {
        return a.n == b;
    }

    /**
     * Inequality operator
     */
    friend bool operator!=(const S &a, const S &b) {
        return !(a == b);
    }

    /**
     * Inequality operator
     */
    template <typename U>
    friend bool operator!=(const S &a, const U b) {
        return !(a == b);
    }

    /**
     * Inequality operator
     */
    template <typename U>
    friend bool operator!=(const U b, const S &a) {
        return !(a == b);
    }

    /**
     * Less than operator
     */
    friend bool operator<(const S &a, const S &b) {
        return a.n < b.n;
    }

    /**
     * Less than operator
     */
    template <typename U>
    friend bool operator<(const S &a, const U b) {
        return a.n < b;
    }

    /**
     * Less than operator
     */
    template <typename U>
    friend bool operator<(const U b, const S &a) {
        return a.n < b;
    }

    /**
     * Less or equal to operator
     */
    friend bool operator<=(const S &a, const S &b) {
        return a.n <= b.n;
    }

    /**
     * Less or equal to operator
     */
    template <typename U>
    friend bool operator<=(const S &a, const U b) {
        return a.n <= b;
    }

    /**
     * Less or equal to operator
     */
    template <typename U>
    friend bool operator<=(const U b, const S &a) {
        return a.n <= b;
    }

    /**
     * Greater than operator
     */
    friend bool operator>(const S &a, const S &b) {
        return a.n > b.n;
    }

    /**
     * Greater than operator
     */
    template <typename U>
    friend bool operator>(const S &a, const U b) {
        return a.n > b;
    }
    /**
     * Greater than operator
     */
    template <typename U>
    friend bool operator>(const U b, const S &a) {
        return a.n > b;
    }

    /**
     * Greater or equal to operator
     */
    friend bool operator>=(const S &a, const S &b) {
        return a.n >= b;
    }

    /**
     * Greater or equal to operator
     */
    template <typename U>
    friend bool operator>=(const S &a, const U b) {
        return a.n >= b;
    }

    /**
     * Greater or equal to operator
     */
    template <typename U>
    friend bool operator>=(const U b, const S &a) {
        return a.n >= b;
    }
};
