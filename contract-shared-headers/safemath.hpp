template <typename T>
class S {
    T n;

  public:
    S(T a) : n(a) {
        static_assert(!std::is_same_v<T, int128_t>, "Cannot be used with int128_t");
        static_assert(!std::is_same_v<T, uint128_t>, "Cannot be used with uint128_t");
        static_assert(std::is_integral<std::decay_t<T>>::value, "Floating point not implemented yet");
    };

    T value() const {
        return n;
    }

    explicit operator T() const {
        return value();
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
        if constexpr (std::is_unsigned_v<T>) {
            eosio::check(n >= a.n, "invalid unsigned subtraction: result would be negative");
            const auto tmp = uint128_t(n) - uint128_t(a.n);
            eosio::check(n <= max_amount, "subtraction overflow");
            n = T(tmp);
        } else {
            const auto tmp = int128_t(n) - int128_t(a.n);
            eosio::check(-max_amount <= n, "subtraction underflow");
            eosio::check(n <= max_amount, "subtraction overflow");
            n = T(tmp);
        }
        return *this;
    }

    /**
     * Addition Assignment  operator
     */
    S &operator+=(const S &a) {
        const auto max_amount = std::numeric_limits<T>::max();
        if constexpr (std::is_unsigned_v<T>) {
            const auto tmp = uint128_t(n) + uint128_t(a.n);
            eosio::check(n <= max_amount, "addition overflow");
            n = T(tmp);
        } else {
            const auto tmp = int128_t(n) + int128_t(a.n);
            eosio::check(-max_amount <= n, "subtraction underflow");
            eosio::check(n <= max_amount, "subtraction overflow");
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
        if constexpr (std::is_unsigned_v<T>) {
            const auto tmp = uint128_t(n) * uint128_t(a.n);
            eosio::check(tmp <= max_amount, "multiplication overflow");
            n = T(tmp);
        } else {
            const auto tmp = int128_t(n) * int128_t(a.n);
            eosio::check(tmp <= max_amount, "multiplication overflow");
            eosio::check(tmp >= -max_amount, "multiplication underflow");
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
        eosio::check(a.n != 0, "division by zero");
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

    /**
     * Equality operator
     */
    friend bool operator==(const S &a, const S &b) {
        return a.n == b.n;
    }

    /**
     * Inequality operator
     */
    friend bool operator!=(const S &a, const S &b) {
        return !(a == b);
    }

    /**
     * Less than operator
     */
    friend bool operator<(const S &a, const S &b) {
        return a.n < b.n;
    }

    /**
     * Less or equal to operator
     */
    friend bool operator<=(const S &a, const S &b) {
        return a.n <= b.n;
    }

    /**
     * Greater than operator
     */
    friend bool operator>(const S &a, const S &b) {
        return a.n > b.n;
    }

    /**
     * Greater or equal to operator
     */
    friend bool operator>=(const S &a, const S &b) {
        return a.n >= b.n;
    }
};
