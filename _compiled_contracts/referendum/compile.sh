#!/usr/bin/env bash

source `dirname $BASH_SOURCE`/common.sh

eosio-cpp -o `dirname $BASH_SOURCE`/$CONTRACT.wasm $CONTRACT.cpp

# replace action? with action in the abi, all the tools seem to have trouble with it

sed 's/action\?/action/g' `dirname $BASH_SOURCE`/$CONTRACT.abi > `dirname $BASH_SOURCE`/$CONTRACT.abi.tmp
mv `dirname $BASH_SOURCE`/$CONTRACT.abi.tmp  `dirname $BASH_SOURCE`/$CONTRACT.abi
