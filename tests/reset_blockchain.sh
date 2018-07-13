#!/bin/bash

set -x
kill -INT `pgrep nodeos`
rm -rf ~/Library/Application\\ Support/eosio/nodeos/data/
if [[ $? != 0 ]]
then
  echo " failed to clear out the old blocks"
  exit 1
fi

nodeos