#!/usr/bin/env bash

CONTRACT='dacescrow'

eosio-cpp -o output/jungle/$CONTRACT/$CONTRACT.wasm $CONTRACT.cpp
eosio-abigen $CONTRACT.hpp -contract $CONTRACT -output output/jungle/$CONTRACT/$CONTRACT.abi