#!/usr/bin/env bash

CONTRACT='dacdirectory'

eosio-cpp -o output/mainnet/$CONTRACT/$CONTRACT.wasm $CONTRACT.cpp -I.
