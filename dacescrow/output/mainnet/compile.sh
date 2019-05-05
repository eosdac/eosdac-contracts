#!/usr/bin/env bash

CONTRACT='dacescrow'

eosio-cpp -o output/mainnet/$CONTRACT/$CONTRACT.wasm $CONTRACT.cpp
eosio-abigen $CONTRACT.hpp -contract $CONTRACT -output output/mainnet/$CONTRACT/$CONTRACT.abi