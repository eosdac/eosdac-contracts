#!/usr/bin/env bash

CONTRACT='dacdirectory'

eosio-cpp -o output/unit_tests/$CONTRACT/$CONTRACT.wasm $CONTRACT.cpp -I.
