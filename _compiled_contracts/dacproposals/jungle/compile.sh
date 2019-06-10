#!/usr/bin/env bash

source `dirname $BASH_SOURCE`/../common.sh
eosio-cpp -DTRANSFER_DELAY=2 -o `dirname $BASH_SOURCE`/$CONTRACT/$CONTRACT.wasm $CONTRACT.cpp -I.
