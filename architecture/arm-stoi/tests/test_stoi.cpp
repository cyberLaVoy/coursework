#include "gtest/gtest.h"

extern "C" int stoi(const char *buffer);
extern "C" int regwrapper(const char *buffer);
extern "C" int (*target_function)(const char *buffer);
extern "C" int bad_register;

TEST(stoi, zero) {
    target_function = stoi;

    int n = regwrapper("0");
    EXPECT_EQ(0, n);
    EXPECT_EQ(0, bad_register);
    n = regwrapper("");
    EXPECT_EQ(0, n);
    EXPECT_EQ(0, bad_register);
    n = regwrapper("notanumber");
    EXPECT_EQ(0, n);
    EXPECT_EQ(0, bad_register);
    n = regwrapper(" 123");
    EXPECT_EQ(0, n);
    EXPECT_EQ(0, bad_register);
}

TEST(stoi, one) {
    target_function = stoi;

    int n = regwrapper("1");
    EXPECT_EQ(1, n);
    EXPECT_EQ(0, bad_register);

    n = regwrapper("9");
    EXPECT_EQ(9, n);
    EXPECT_EQ(0, bad_register);

    n = regwrapper("5");
    EXPECT_EQ(5, n);
    EXPECT_EQ(0, bad_register);
}

TEST(stoi, two) {
    target_function = stoi;

    int n = regwrapper("34");
    EXPECT_EQ(34, n);
    EXPECT_EQ(0, bad_register);

    n = regwrapper("90");
    EXPECT_EQ(90, n);
    EXPECT_EQ(0, bad_register);

    n = regwrapper("55");
    EXPECT_EQ(55, n);
    EXPECT_EQ(0, bad_register);

    n = regwrapper("01");
    EXPECT_EQ(1, n);
    EXPECT_EQ(0, bad_register);

    n = regwrapper("23junk");
    EXPECT_EQ(23, n);
    EXPECT_EQ(0, bad_register);

    n = regwrapper("00 123");
    EXPECT_EQ(0, n);
    EXPECT_EQ(0, bad_register);
}

TEST(stoi, multi) {
    target_function = stoi;

    int n = regwrapper("100");
    EXPECT_EQ(100, n);
    EXPECT_EQ(0, bad_register);

    n = regwrapper("999");
    EXPECT_EQ(999, n);
    EXPECT_EQ(0, bad_register);

    n = regwrapper("123456");
    EXPECT_EQ(123456, n);
    EXPECT_EQ(0, bad_register);

    n = regwrapper("987654321");
    EXPECT_EQ(987654321, n);
    EXPECT_EQ(0, bad_register);

    n = regwrapper("987654321-0");
    EXPECT_EQ(987654321, n);
    EXPECT_EQ(0, bad_register);
}

TEST(stoi, negative) {
    target_function = stoi;

    int n = regwrapper("-100");
    EXPECT_EQ(-100, n);
    EXPECT_EQ(0, bad_register);

    n = regwrapper("-");
    EXPECT_EQ(0, n);
    EXPECT_EQ(0, bad_register);

    n = regwrapper("-999");
    EXPECT_EQ(-999, n);
    EXPECT_EQ(0, bad_register);

    n = regwrapper("-123456");
    EXPECT_EQ(-123456, n);
    EXPECT_EQ(0, bad_register);

    n = regwrapper("-987654321");
    EXPECT_EQ(-987654321, n);
    EXPECT_EQ(0, bad_register);

    n = regwrapper("-987654321-0");
    EXPECT_EQ(-987654321, n);
    EXPECT_EQ(0, bad_register);

    n = regwrapper("--987654321");
    EXPECT_EQ(0, n);
    EXPECT_EQ(0, bad_register);
}
