#!/usr/bin/env bash

CONTRACT='daccustodian'

eosio-cpp -o $CONTRACT/$CONTRACT.wasm ./daccustodian_stub/daccustodian_stub.cpp
eosio-abigen ./daccustodian_stub/daccustodian_stub.hpp -contract $CONTRACT -output $CONTRACT/$CONTRACT.abi
