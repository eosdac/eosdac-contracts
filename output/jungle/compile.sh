#!/usr/bin/env bash

CONTRACT='dacdirectory'

eosio-cpp -o output/jungle/$CONTRACT/$CONTRACT.wasm $CONTRACT.cpp -I.
