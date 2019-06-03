#!/usr/bin/env bash

CONTRACT='dacdirectory'

eosio-cpp -o `dirname $BASH_SOURCE`/$CONTRACT.wasm $CONTRACT.cpp -I.