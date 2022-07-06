#include "../../contract-shared-headers/safemath.hpp"
#include "../../contract-shared-headers/common_utilities.hpp"
#include <eosio/eosio.hpp>
#include <math.h>

using namespace eosio;

static constexpr auto constexpr_a = S<uint8_t>{1};
static constexpr auto constexpr_b = S<uint8_t>{2};

CONTRACT safemath : public contract {
  public:
    using contract::contract;

    ACTION testuint() {
        const uint64_t a = 123;
        const uint64_t b = 456;
        const uint64_t c = 789;
        const uint64_t d = 2718;
        const uint64_t e = 31;

        check(S{a} * S{b} * S{c} == a * b * c, "wrong result 1");
        check(S{a} * S{b} / S{c} == a * b / c, "wrong result 2");
        check(S{a} / S{b} == a / b, "wrong result 3");
        check(S{a} + S{b} == a + b, "wrong result 4");
        check(S{a} + S{b} * S{c} == a + b * c, "wrong result 5");

        const auto x1  = S{a} * S{b} / S{c} + S{d} - S{e};
        const auto x1_ = a * b / c + d - e;
        check(x1 == x1_, "wrong result 6");

        const auto x2  = S{a} - S{a};
        const auto x2_ = a - a;
        check(x2 == x2_, "wrong result 7");

        check(S{a} == a, "wrong result 8");
    }
    ACTION testint() {
        const int64_t a = 123;
        const int64_t b = 456;
        const int64_t c = 789;
        const int64_t d = 2718;
        const int64_t e = 31;

        check(S{a} * S{b} * S{c} == a * b * c, "wrong result 1");
        check(S{a} * S{b} / S{c} == a * b / c, "wrong result 2");
        check(S{a} / S{b} == a / b, "wrong result 3");
        check(S{a} + S{b} == a + b, "wrong result 4");
        check(S{a} + S{b} * S{c} == a + b * c, "wrong result 5");

        const auto x1  = S{a} * S{b} / S{c} + S{d} - S{e};
        const auto x1_ = a * b / c + d - e;
        check(x1 == x1_, "wrong result 6");

        const auto x2  = S{a} - S{a};
        const auto x2_ = a - a;
        check(x2 == x2_, "wrong result 7");

        check(S{a} == a, "wrong result 8");
    }

    ACTION testfloat() {
        const double a = 123.1432;
        const double b = 456.5534;
        const double c = 789.35436;
        const double d = 2718.26536;
        const double e = 31.863302;

        check(S{a} * S{b} * S{c} == a * b * c, "wrong result 1");
        check(S{a} * S{b} / S{c} == a * b / c, "wrong result 2");
        check(S{a} / S{b} == a / b, "wrong result 3");
        check(S{a} + S{b} == a + b, "wrong result 4");
        check(S{a} + S{b} * S{c} == a + b * c, "wrong result 5");

        const auto x1  = S{a} * S{b} / S{c} + S{d} - S{e};
        const auto x1_ = a * b / c + d - e;
        check(x1 == x1_, "wrong result 6");

        const auto x2  = S{a} - S{a};
        const auto x2_ = a - a;
        check(x2 == x2_, "wrong result 7");

        check(S{a} == a, "wrong result 8");
    }

    ACTION smoverflow() {
        S{std::numeric_limits<int64_t>::max()} * S<int64_t>{2};
    }

    ACTION umoverflow() {
        S{std::numeric_limits<uint64_t>::max()} * S<uint64_t>{2};
    }

    ACTION aoverflow() {
        S{std::numeric_limits<int64_t>::max()} + S<int64_t>{1};
    }

    ACTION auoverflow() {
        S{std::numeric_limits<uint64_t>::max()} + S<uint64_t>{1};
    }

    ACTION uunderflow() {
        S<uint64_t>{1} - S<uint64_t>{2};
    }

    ACTION usdivzero() {
        S<uint64_t>{1} / S<uint64_t>{0};
    }
    ACTION sdivzero() {
        S<int64_t>{1} / S<int64_t>{0};
    }

    ACTION fdivzero() {
        S{1.0} / S{0.0};
    }

    ACTION sdivoverflow() {
        const auto min_value = std::numeric_limits<int64_t>::min();
        const auto res       = S{min_value} / S<int64_t>{-1};
    }
    ACTION infinity() {
        S<float>{1.0} + S{INFINITY};
    }
    ACTION nan() {
        S<float>{1.0} + S{NAN};
    }

    ACTION convert1() {
        S{256}.to<uint8_t>();
    }
    ACTION convert2() {
        S{-1}.to<uint8_t>();
    }

    ACTION convert3() {
        const auto max_value = std::numeric_limits<int32_t>::max();
        const auto too_large = S{max_value}.to<int64_t>() + S{1}.to<int64_t>();
        S{too_large}.to<int32_t>();
    }

    ACTION convert4() {
        const auto max_value = std::numeric_limits<uint32_t>::max();
        S{max_value}.to<int32_t>();
    }

    ACTION xxx1() {
        // tests expressions with (). This should throw invalid usigned subtraction error.
        S<uint32_t>{1} * S<uint32_t>{1} - (S<uint32_t>{1} * S<uint32_t>{2});
    }

    ACTION xxx2() {
        const auto tmp = S<uint32_t>{2} * S<uint32_t>{3} + (S<uint32_t>{5} * S<uint32_t>{6});
        const auto res = tmp.to<uint32_t>();
        check(res == 36, "wrong result");
    }

    ACTION xxx3() {
        const auto x   = S{std::numeric_limits<int64_t>::max()};
        const auto tmp = x.to<int128_t>() * x.to<int128_t>() / x.to<int128_t>();
        const auto res = tmp.to<int64_t>();
        check(res == x, "wrong result res: %s x: %s", res, x);
    }

    ACTION xxx4() {
        S{std::numeric_limits<int128_t>::min()} - S<int128_t>{1};
    }
    ACTION xxx5() {
        S{std::numeric_limits<int128_t>::max()} - S<int128_t>{-1};
    }

    ACTION yyy1() {
        const auto res = -S{std::numeric_limits<int64_t>::min()};
    }
    ACTION yyy2() {
        constexpr_a - constexpr_b;
    }
    ACTION yyy3() {
        S{1}.to<double>() - S{1}.to<double>();
    }
    ACTION yyy4() {
        S{log2(0)} - S{1}.to<double>();
    }

    ACTION yyy5() {
        check(S{10}.ipow(3) == 1000, "wrong result 1 ");
        check(S{10}.ipow(6) == 1000000, "wrong result 2");
        check(S{2}.ipow(3) == 8, "wrong result 3");
        check(S{2}.ipow(0) == 1, "wrong result 4");
        check(S{-2}.ipow(3) == -8, "wrong result 5");
        check(S{0}.ipow(3) == 0, "wrong result 6");
    }
};