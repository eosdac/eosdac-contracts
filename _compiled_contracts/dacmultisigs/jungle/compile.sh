#!/usr/bin/env bash

eosio-cpp -o output/jungle/dacmultisigs/dacmultisigs.wasm dacmultisigs.cpp
eosio-abigen dacmultisigs.hpp -contract dacmultisigs -output output/jungle/dacmultisigs/dacmultisigs.abi
