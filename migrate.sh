#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
CLR='\033[0m' # No Color

MIGRATE_DIR=./_dac_migration
CLEOS=~/Projects/eos-chains/mainnet.sh
CONTRACT_DIR=~/Projects/eosdac/eosdac-contracts

TOKEN=eosdactokens
CUSTODIAN=daccustodian
AUTHORITY=dacauthority
MSIG=dacmultisigs
RAM_BUYER=eosdacthedac





printf "${BLUE}2. Add eosio.code to ${TOKEN}@active${CLR}\n"
read -rsp $'Press any key to continue...\n' -n1 key
$CLEOS push transaction $MIGRATE_DIR/eosdactokens_notify.trx



printf "${BLUE}3. Set ${CUSTODIAN} and ${TOKEN} contracts in two transactions closely, configure the contract
  3a. Buy 1378000 bytes of RAM for ${CUSTODIAN}
  3b. Buy 313000 bytes of RAM for ${TOKEN}
  3c. Check hashes are
	${CUSTODIAN}:fbec1b92725cf6c309c7dbce6465c36be8b21d2e096a53b9a402b02d52f6dc5d
	${TOKEN}:20b06072cb803fa42b7ee78139fde8aee333f23d4ab88cb33547d59566d69a83
  3d. Immediately call updateconfige with the new config${CLR}\n"

read -rsp $'Press any key to continue...\n' -n1 key
$CLEOS system buyram -b $RAM_BUYER $CUSTODIAN 1378000
$CLEOS system buyram -b $RAM_BUYER $TOKEN 400000

$CLEOS set contract ${TOKEN} $CONTRACT_DIR/_compiled_contracts/eosdactokens/ && $CLEOS set contract ${CUSTODIAN}  $CONTRACT_DIR/_compiled_contracts/daccustodian/mainnet/daccustodian/ && $CLEOS push action ${CUSTODIAN} updateconfige $MIGRATE_DIR/custodian_config.json  -p ${AUTHORITY}

printf "${BLUE}3e. Check code hashes match${CLR}\n"
read -rsp $'Press any key to continue...\n' -n1 key
CHAIN_HASH=$($CLEOS get code ${CUSTODIAN} | awk '{gsub(/\code\ hash\:\ /,"");}1')
if [[ "${CHAIN_HASH}" != "895db4a8afb5f8bbd26a921316524260dd9b92d91feacffba9000d74faa9e7c6" ]]
then
  printf "${RED}${CUSTODIAN} code hash doesnt match! - WAS ${CHAIN_HASH}${CLR}\n"
else
  printf "${GREEN}${CUSTODIAN} code hash matched${CLR}\n"
fi
CHAIN_HASH=$($CLEOS get code ${TOKEN} | awk '{gsub(/\code\ hash\:\ /,"");}1')
if [[ "$CHAIN_HASH" != "20b06072cb803fa42b7ee78139fde8aee333f23d4ab88cb33547d59566d69a83" ]]
then
  printf "${RED}${TOKEN} code hash doesnt match! - WAS ${CHAIN_HASH}${CLR}\n"
else
  printf "${GREEN}${TOKEN} code hash matched${CLR}\n"
fi



printf "${BLUE}4. Add custom linkauths for firecuste and firecande to ${AUTHORITY}@med, add new permission to ${CUSTODIAN}${CLR}\n"
read -rsp $'Press any key to continue...\n' -n1 key

$CLEOS set action permission ${AUTHORITY} ${CUSTODIAN} firecuste med
$CLEOS set action permission ${AUTHORITY} ${CUSTODIAN} firecande med
$CLEOS set account permission ${CUSTODIAN} pay $MIGRATE_DIR/daccustodian_pay.json active
$CLEOS set action permission ${CUSTODIAN} ${CUSTODIAN} removecuspay pay


printf "${BLUE}5. Call ${TOKEN}::migrate and ${CUSTODIAN}::migrate repeatedly until data is all migrated (batch size of 200 is recommended)${CLR}\n"
read -rsp $'Press any key to continue...\n' -n1 key

for i in {1..20}
do
    echo $i
    $CLEOS push action -f $TOKEN migrate '[200]' -p $TOKEN
done
for i in {1..12}
do
    echo $i
    $CLEOS push action -f ${CUSTODIAN} migrate '[200]' -p ${CUSTODIAN}
done




printf "${BLUE}6. Update ${MSIG} contract
  6a. Buy 104000 bytes RAM${CLR}\n"
read -rsp $'Press any key to continue...\n' -n1 key

$CLEOS system buyram -b $RAM_BUYER $MSIG 104000
$CLEOS set contract $MSIG $CONTRACT_DIR/_compiled_contracts/dacmultisigs/mainnet/dacmultisigs/


printf "${BLUE}7. Buy 10000 bytes RAM for ${AUTHORITY}${CLR}\n"
read -rsp $'Press any key to continue...\n' -n1 key

$CLEOS system buyram -b $RAM_BUYER $DACAUTHORITY 10000


printf "${BLUE}8. Remove old data${CLR}\n"
read -rsp $'Press any key to continue...\n' -n1 key

for i in {1..7}
do
    echo $i
    $CLEOS push action -f ${CUSTODIAN} clearold '[500]' -p $CUSTODIAN
done
for i in {1..10}
do
    echo $i
    $CLEOS push action -f ${TOKEN} clearold '[500]' -p $TOKEN
done


