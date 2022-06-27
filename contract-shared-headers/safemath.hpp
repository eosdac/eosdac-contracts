#include <eosio/eosio.hpp>
#include <math.h>

template <typename T>
class S {
    T n;

  public:
    S(T a) : n(a) {
        static_assert(std::is_unsigned_v<T> || std::is_signed_v<T>, "wrong type, only for numbers");
        static_assert(!std::is_same_v<T, int128_t>, "Cannot be used with int128_t");
        static_assert(!std::is_same_v<T, uint128_t>, "Cannot be used with uint128_t");
    };

    T value() const {
        return n;
    }

    operator T() const {
        return value();
    }

    template <typename U>
    auto to() const {
        const auto max = std::numeric_limits<U>::max();
        if constexpr (std::is_unsigned_v<U>) {
            eosio::check(n >= 0, "Cannot convert negative value to unsigned");
        } else {
            eosio::check(n >= -max, "conversion underflow. max: " + std::to_string(-max));
        }
        eosio::check(n <= max, "conversion overflow. max: " + std::to_string(max) + " n: " + std::to_string(n));
        return S<U>{static_cast<U>(n)};
    }

    /**
     * Unary minus operator
     *
     */
    S operator-() const {
        auto r = *this;
        r.n    = -r.n;
        return r;
    }

    /**
     * Subtraction assignment operator
     */
    S &operator-=(const S a) {
        const auto max_amount = std::numeric_limits<T>::max();
        if constexpr (std::is_floating_point_v<T>) {
            n -= a.n;
            eosio::check(!isinf(n), "infinity");
            eosio::check(!isnan(n), "NaN");
        } else if constexpr (std::is_unsigned_v<T>) {
            eosio::check(n >= a.n, "invalid unsigned subtraction: result would be negative");
            n -= a.n;
        } else {
            const auto tmp = int128_t(n) - int128_t(a.n);
            eosio::check(-max_amount <= tmp, "signed subtraction underflow");
            eosio::check(tmp <= max_amount, "signed subtraction overflow");
            n = T(tmp);
        }
        return *this;
    }

    /**
     * Addition Assignment  operator
     */
    S &operator+=(const S &a) {
        const auto max_amount = std::numeric_limits<T>::max();
        if constexpr (std::is_floating_point_v<T>) {
            n += a.n;
            eosio::check(!isinf(n), "infinity");
            eosio::check(!isnan(n), "NaN");
        } else if constexpr (std::is_unsigned_v<T>) {
            eosio::check(max_amount - n >= a.n, "unsigned wrap");
            n += a.n;
        } else {
            const auto tmp = int128_t(n) + int128_t(a.n);
            eosio::check(-max_amount <= tmp, "signed addition underflow");
            eosio::check(tmp <= max_amount, "signed addition overflow");
            n = T(tmp);
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
        auto max_amount = std::numeric_limits<T>::max();
        if constexpr (std::is_floating_point_v<T>) {
            n *= a.n;
            eosio::check(!isinf(n), "infinity");
            eosio::check(!isnan(n), "NaN");
        } else if constexpr (std::is_unsigned_v<T>) {
            const auto tmp = uint128_t(n) * uint128_t(a.n);
            eosio::check(tmp <= max_amount, "unsigned multiplication overflow");
            n = T(tmp);
        } else {
            const auto tmp = int128_t(n) * int128_t(a.n);
            eosio::check(tmp <= max_amount, "signed multiplication overflow");
            eosio::check(tmp >= -max_amount, "signed multiplication underflow");
            n = T(tmp);
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
        const auto min_value = std::numeric_limits<T>::min();
        eosio::check(a.n != 0, "division by zero");
        eosio::check(!(n == min_value && a.n == -1), "division overflow");
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
