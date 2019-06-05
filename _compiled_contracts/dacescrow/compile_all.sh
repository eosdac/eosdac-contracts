#!/usr/bin/env bash

CONTRACT='dacescrow'

eosio-cpp -o `dirname $BASH_SOURCE`/$CONTRACT.wasm $CONTRACT.cpp -I.