#!/usr/bin/env bash

CONTRACT='dacproposals'

eosio-cpp -o `dirname $BASH_SOURCE`/$CONTRACT.wasm $CONTRACT.cpp -I.