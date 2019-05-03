#!/usr/bin/env bash

source `dirname "$0"`/common.sh

COMMON_PATH=contract-shared-dependencies/CompiledContracts/$CONTRACT

source $COMMON_PATH/jungle/compile.sh
source $COMMON_PATH/mainnet/compile.sh
source $COMMON_PATH/unit_tests/compile.sh
