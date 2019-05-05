#!/usr/bin/env bash

CONTRACT='dacmultisigs'

eosio-cpp -o `dirname $BASH_SOURCE`/$CONTRACT/$CONTRACT.wasm $CONTRACT.cpp -I.
