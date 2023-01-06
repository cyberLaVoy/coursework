#include "gtest/gtest.h"

extern "C" int birthday(int n);
extern "C" int regwrapper(int n);
extern "C" int (*target_function)(int n);
extern "C" int bad_register;

TEST(birthday, one) {
    target_function = birthday;

    int n = regwrapper(1);
    EXPECT_EQ(0, n);
    EXPECT_EQ(0, bad_register);
}

TEST(birthday, small) {
    target_function = birthday;

    int n = regwrapper(2);
    EXPECT_EQ(0, n);
    EXPECT_EQ(0, bad_register);

    n = regwrapper(3);
    EXPECT_EQ(1, n);
    EXPECT_EQ(0, bad_register);

    n = regwrapper(4);
    EXPECT_EQ(2, n);
    EXPECT_EQ(0, bad_register);

    n = regwrapper(5);
    EXPECT_EQ(3, n);
    EXPECT_EQ(0, bad_register);

    n = regwrapper(6);
    EXPECT_EQ(4, n);
    EXPECT_EQ(0, bad_register);

    n = regwrapper(7);
    EXPECT_EQ(6, n);
    EXPECT_EQ(0, bad_register);

    n = regwrapper(8);
    EXPECT_EQ(7, n);
    EXPECT_EQ(0, bad_register);

    n = regwrapper(9);
    EXPECT_EQ(9, n);
    EXPECT_EQ(0, bad_register);

    n = regwrapper(10);
    EXPECT_EQ(12, n);
    EXPECT_EQ(0, bad_register);
}

TEST(birthday, medium) {
    target_function = birthday;

    int n = regwrapper(11);
    EXPECT_EQ(14, n);
    EXPECT_EQ(0, bad_register);

    n = regwrapper(12);
    EXPECT_EQ(17, n);
    EXPECT_EQ(0, bad_register);

    n = regwrapper(13);
    EXPECT_EQ(19, n);
    EXPECT_EQ(0, bad_register);

    n = regwrapper(15);
    EXPECT_EQ(25, n);
    EXPECT_EQ(0, bad_register);

    n = regwrapper(18);
    EXPECT_EQ(35, n);
    EXPECT_EQ(0, bad_register);

    n = regwrapper(19);
    EXPECT_EQ(38, n);
    EXPECT_EQ(0, bad_register);

    n = regwrapper(21);
    EXPECT_EQ(44, n);
    EXPECT_EQ(0, bad_register);

    n = regwrapper(22);
    EXPECT_EQ(48, n);
    EXPECT_EQ(0, bad_register);

    n = regwrapper(23);
    EXPECT_EQ(51, n);
    EXPECT_EQ(0, bad_register);

    n = regwrapper(24);
    EXPECT_EQ(54, n);
    EXPECT_EQ(0, bad_register);
}

TEST(birthday, large) {
    target_function = birthday;

    int n = regwrapper(26);
    EXPECT_EQ(60, n);
    EXPECT_EQ(0, bad_register);

    n = regwrapper(34);
    EXPECT_EQ(80, n);
    EXPECT_EQ(0, bad_register);

    n = regwrapper(40);
    EXPECT_EQ(89, n);
    EXPECT_EQ(0, bad_register);

    n = regwrapper(41);
    EXPECT_EQ(90, n);
    EXPECT_EQ(0, bad_register);

    n = regwrapper(55);
    EXPECT_EQ(99, n);
    EXPECT_EQ(0, bad_register);
}
