#!/usr/bin/env bash
#eosio-cpp -DTOKEN_CONTRACT='"eosdactokens"' -DTRANSFER_DELAY=10 -o output/unit_tests/daccustodian/daccustodian.wast daccustodian.cpp

~/Documents/code/EOSIO/eosio.cdt/build/bin/eosio-cpp -DTOKENCONTRACT='"eosdactokens"' -DTRANSFER_DELAY=10 -o output/unit_tests/daccustodian/daccustodian.wast daccustodian.cpp