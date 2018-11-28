#!/usr/bin/env bash
#eosio-cpp -DTOKEN_CONTRACT='"eosdactokens"' -DTRANSFER_DELAY=3600 -o output/mainnet_votingenabled/daccustodian/daccustodian.wast daccustodian.cpp

~/Documents/code/EOSIO/eosio.cdt/build/bin/eosio-cpp -DTOKENCONTRACT='"eosdactokens"' -DTRANSFER_DELAY=3600 -o output/mainnet_votingenabled/daccustodian/daccustodian.wast daccustodian.cpp