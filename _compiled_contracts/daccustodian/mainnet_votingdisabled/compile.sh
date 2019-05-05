#!/usr/bin/env bash

source `dirname $BASH_SOURCE`/../common.sh
eosio-cpp -DTOKENCONTRACT='"eosdactokens"' -DTRANSFER_DELAY=3600 -DVOTING_DISABLED=1 -o `dirname $BASH_SOURCE`/$CONTRACT/$CONTRACT.wasm $CONTRACT.cpp -I.
