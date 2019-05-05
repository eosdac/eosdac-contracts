#!/usr/bin/env bash

eosio-cpp -DTOKENCONTRACT='"eosdactokens"' -DTRANSFER_DELAY=3600 -o output/mainnet_votingenabled/daccustodian/daccustodian.wasm daccustodian.cpp -I.
