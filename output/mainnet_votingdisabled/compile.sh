#!/usr/bin/env bash

eosio-cpp -DTOKENCONTRACT='"eosdactokens"' -DTRANSFER_DELAY=3600 -DVOTING_DISABLED=1 -o output/mainnet_votingdisabled/daccustodian/daccustodian.wasm daccustodian.cpp -I.
