#!/usr/bin/env bash

eosio-cpp -DTOKENCONTRACT='"kasdactokens"' -DTRANSFER_DELAY=20 -o output/jungle/daccustodian/daccustodian.wasm daccustodian.cpp

eosio-abigen daccustodian.hpp -contract daccustodian -output output/jungle/daccustodian/daccustodian.abi
