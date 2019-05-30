#!/usr/bin/env bash

CONTRACT='eosdactokens'

eosio-cpp -o `dirname $BASH_SOURCE`/$CONTRACT.wasm $CONTRACT.cpp -I.