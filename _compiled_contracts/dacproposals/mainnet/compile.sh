#!/usr/bin/env bash

CONTRACT='dacproposals'

eosio-cpp -o output/mainnet/$CONTRACT/$CONTRACT.wasm $CONTRACT.cpp -I.
