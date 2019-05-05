#!/usr/bin/env bash

CONTRACT='dacescrow'

eosio-cpp -o output/unit_tests/$CONTRACT/$CONTRACT.wasm $CONTRACT.cpp
eosio-abigen $CONTRACT.hpp -contract $CONTRACT -output output/unit_tests/$CONTRACT/$CONTRACT.abi