#!/usr/bin/env bash
#eosio-cpp -DTOKEN_CONTRACT='"eosdactokens"' -DTRANSFER_DELAY=3600 -DVOTING_DISABLED=1 -o output/mainnet_votingdisabled/daccustodian/daccustodian.wast daccustodian.cpp

~/Documents/code/EOSIO/eosio.cdt/build/bin/eosio-cpp -DTOKENCONTRACT='"eosdactokens"' -DTRANSFER_DELAY=3600 -DVOTING_DISABLED=1 -o output/mainnet_votingdisabled/daccustodian/daccustodian.wast daccustodian.cpp
