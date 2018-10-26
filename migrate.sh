#!/bin/sh
set -x

cleoscommand='cleos -u https://node1.eosphere.io '

contract='daccustodian'
account='daccustodian'

function migrateStep {
	$cleoscommand set contract $contract output/mainnet_votingdisabled/daccustodian

	sleep 1

	$cleoscommand push action $contract migrate '' -p $account
}

echo "Part 1/5"
git checkout 319a58433a59fd02e18c225f93486ddc8e4518a5
migrateStep
$cleoscommand get table $contract $contract config
echo "^^^ Should have values"

$cleoscommand get table $contract $contract config2
echo "^^^ Should also have values"

echo "Part 2/5"
git checkout a146be9f8b19886cbf6576407d9f2b9ae6d70d19
migrateStep

$cleoscommand get table $contract $contract config
echo "^^^ Should have no values"

$cleoscommand get table $contract $contract config2
echo "^^^ Should also have values"

echo "Part 3/5"
git checkout 988bd4180d4b8d1484078228f958a30713792f45
migrateStep

$cleoscommand get table $contract $contract config2
echo "^^^ Should have values"
$cleoscommand get table $contract $contract config
echo "^^^ Should have the same values as config2"

echo "Part 4/5"
git checkout a28252b5ba95e9d99fa84cae0080778faae0677b
migrateStep

$cleoscommand get table $contract $contract config2
echo "^^^ Should be empty"
$cleoscommand get table $contract $contract config
echo "^^^ Should have the values with the new schema"

echo "Part 5/5"
git checkout 682538dc5433537c609ad74f4fe503036a677c32
migrateStep

$cleoscommand get table $contract $contract config2
echo "^^^ Should throw non existing error"
$cleoscommand get table $contract $contract config
echo "^^^ Should have the values with the new schema"

