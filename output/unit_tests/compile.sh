#!/usr/bin/env bash

eosio-cpp -DTOKENCONTRACT='"eosdactokens"' -DTRANSFER_DELAY=10 -o output/unit_tests/daccustodian/daccustodian.wasm daccustodian.cpp

eosio-abigen daccustodian.hpp -contract daccustodian -output output/unit_tests/daccustodian/daccustodian.abi