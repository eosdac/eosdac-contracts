#!/usr/bin/env bash

eosio-cpp -DTOKENCONTRACT='"kasdactokens"' -DTRANSFER_DELAY=20 -o output/jungle/daccustodian/daccustodian.wasm daccustodian.cpp -I.
