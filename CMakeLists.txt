

cmake_minimum_required(VERSION 3.5)
project(test_example VERSION 1.0.0)

find_package(eosio.cdt)

#link_libraries(LIBRARIES libc libc++ eosiolib)

#include_directories(eosio.cdt)

add_contract( dacproposals dacproposals dacproposals.cpp )