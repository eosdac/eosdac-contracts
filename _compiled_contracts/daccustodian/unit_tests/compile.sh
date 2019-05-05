#!/usr/bin/env bash

source `dirname $BASH_SOURCE`/../common.sh
eosio-cpp -DTOKENCONTRACT='"eosdactokens"' -DTRANSFER_DELAY=10 -o `dirname $BASH_SOURCE`/$CONTRACT/$CONTRACT.wasm $CONTRACT.cpp -I.
