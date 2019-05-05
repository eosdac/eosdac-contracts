#!/usr/bin/env bash

source `dirname $BASH_SOURCE`/../common.sh
eosio-cpp -DTOKENCONTRACT='"kasdactokens"' -DTRANSFER_DELAY=20 -o `dirname $BASH_SOURCE`/$CONTRACT/$CONTRACT.wasm $CONTRACT.cpp -I.
