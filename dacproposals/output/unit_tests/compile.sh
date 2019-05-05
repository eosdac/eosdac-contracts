#!/usr/bin/env bash

CONTRACT='dacproposals'

eosio-cpp -o output/unit_tests/$CONTRACT/$CONTRACT.wasm $CONTRACT.cpp -I.
