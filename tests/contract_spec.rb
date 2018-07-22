require 'rspec'
require 'rspec_command'
require "json"

# 1. A recent version of Ruby is required
# 2. Ensure the required gems are installed with `gem install rspec json rspec-command`
# 3. Run this from the command line with rspec contract_spec.rb

# Optionally output the test results with -f [p|d|h] for required views of the test results.

RSpec.configure do |config|
  config.include RSpecCommand
end

CONTRACT_OWNER_PRIVATE_KEY = '5K8eYgacDDNqPJBz7a3EV6yusLg7tTwf4i96wBs3Y2ZqwFrXPGF'
CONTRACT_OWNER_PUBLIC_KEY = 'EOS6u2zxhs6VPRU9j1XFKs65GJjf5qYsC2Ufcc9dNVBefXC4f7b4e'

CONTRACT_ACTIVE_PRIVATE_KEY = '5Jh2w4XH8jQg3XJxV1YPFH5pAqDgKR9iMwmFuePCTr7pcD8RQ5z'
CONTRACT_ACTIVE_PUBLIC_KEY = 'EOS8T3yTxnZD4fyCGR7hwzLFemgp2no2eAXZgKFzhjZhCESRrygri'


TEST_OWNER_PRIVATE_KEY = '5KdoDLgLc8shajQhT1czpVQ33pdE5bvQfLxzHSLgQKKsozgxxBb'
TEST_OWNER_PUBLIC_KEY = 'EOS6ZCSAJKqmYDxFnPTL9Srfn2Z76AFPJtfWuUFJ77YB9BfQpEmp9'

TEST_ACTIVE_PRIVATE_KEY = '5HvBdkhsNKdyHZaqTRMmEuxJWSA4ez2amL6atnGoVPRWbo9KPYz'
TEST_ACTIVE_PUBLIC_KEY = 'EOS8SPGwVZX35xVvk8TwkXzAnosHLz4ULPsXQvJj2cTf48AZjSiXr'

CONTRACT_NAME = 'daccustodian'
ACCOUNT_NAME = 'daccustodian'


beforescript = <<~SHELL
  set -x
  kill -INT `pgrep nodeos`
  nodeos --delete-all-blocks  &>/dev/null &
  sleep 0.5
  cleos wallet import #{CONTRACT_ACTIVE_PRIVATE_KEY}
  cleos wallet import #{TEST_ACTIVE_PRIVATE_KEY}
  cleos wallet import #{TEST_OWNER_PRIVATE_KEY}
  cleos create account eosio #{ACCOUNT_NAME} #{CONTRACT_OWNER_PUBLIC_KEY} #{CONTRACT_ACTIVE_PUBLIC_KEY}
  cleos create account eosio eosdactoken #{CONTRACT_OWNER_PUBLIC_KEY} #{CONTRACT_ACTIVE_PUBLIC_KEY}
  if [[ $? != 0 ]] 
    then 
    echo "Failed to create contract account" 
    exit 1
    fi
    eosiocpp -g #{CONTRACT_NAME}.abi #{CONTRACT_NAME}.cpp
    eosiocpp -o #{CONTRACT_NAME}.wast *.cpp
    if [[ $? != 0 ]] 
      then 
      echo "failed to compile contract" 
      exit 1
      fi
      cd ..
      cleos set contract #{ACCOUNT_NAME} #{CONTRACT_NAME} -p #{ACCOUNT_NAME}
      echo `pwd`

      cd eosdactoken/
      cleos set contract eosdactoken eosdactoken -p eosdactoken
      cd ../#{CONTRACT_NAME}

SHELL


describe "eosdacelect" do
  before(:all) do
    `#{beforescript}`
    exit() unless $? == 0
  end

  describe "test before all" do
    it {expect(true)}
  end

  describe "regcandidate" do
    before(:all) do
      # configure accounts for eosdactoken
      `cleos push action eosdactoken create '{ "issuer": "eosdactoken", "maximum_supply": "100000.0000 EOSDAC", "transfer_locked": false}' -p eosdactoken`
      `cleos push action eosdactoken issue '{ "to": "eosdactoken", "quantity": "1000.0000 EOSDAC", "memo": "Initial amount of tokens for you."}' -p eosdactoken`
      #create users
      `cleos create account eosio testreguser1 #{TEST_OWNER_PUBLIC_KEY} #{TEST_ACTIVE_PUBLIC_KEY}`
      `cleos create account eosio testreguser2 #{TEST_OWNER_PUBLIC_KEY} #{TEST_ACTIVE_PUBLIC_KEY}`
      `cleos create account eosio testreguser3 #{TEST_OWNER_PUBLIC_KEY} #{TEST_ACTIVE_PUBLIC_KEY}`
      `cleos create account eosio testreguser4 #{TEST_OWNER_PUBLIC_KEY} #{TEST_ACTIVE_PUBLIC_KEY}`
      `cleos create account eosio testreguser5 #{TEST_OWNER_PUBLIC_KEY} #{TEST_ACTIVE_PUBLIC_KEY}`
      # Issue tokens to the first accounts in the token contract
      `cleos push action eosdactoken issue '{ "to": "testreguser1", "quantity": "100.0000 EOSDAC", "memo": "Initial amount."}' -p eosdactoken`
      `cleos push action eosdactoken issue '{ "to": "testreguser2", "quantity": "100.0000 EOSDAC", "memo": "Initial amount."}' -p eosdactoken`
      `cleos push action eosdactoken issue '{ "to": "testreguser3", "quantity": "100.0000 EOSDAC", "memo": "Initial amount."}' -p eosdactoken`
      `cleos push action eosdactoken issue '{ "to": "testreguser4", "quantity": "100.0000 EOSDAC", "memo": "Initial amount."}' -p eosdactoken`
      `cleos push action eosdactoken issue '{ "to": "testreguser5", "quantity": "100.0000 EOSDAC", "memo": "Initial amount."}' -p eosdactoken`
      # Add the founders to the memberreg table
      `cleos push action eosdactoken memberreg '{ "sender": "testreguser1", "agreedterms": "initaltermsagreedbyuser"}' -p testreguser1`
      # `cleos push action eosdactoken memberreg '{ "sender": "testreguser2", "agreedterms": "initaltermsagreedbyuser"}' -p testreguser2` # not registered
      `cleos push action eosdactoken memberreg '{ "sender": "testreguser3", "agreedterms": ""}' -p testreguser3` # empty terms
      `cleos push action eosdactoken memberreg '{ "sender": "testreguser4", "agreedterms": "oldterms"}' -p testreguser4`
      `cleos push action eosdactoken memberreg '{ "sender": "testreguser5", "agreedterms": "initaltermsagreedbyuser"}' -p testreguser5`

      # set account permissions for transfers from within the contract.
      `cleos set account permission testreguser1 active '{"threshold": 1,"keys": [{"key": "#{TEST_ACTIVE_PUBLIC_KEY}","weight": 1}],"accounts": [{"permission":{"actor":"daccustodian","permission":"eosio.code"},"weight":1}]}' owner -p testreguser1`
      `cleos set account permission testreguser2 active '{"threshold": 1,"keys": [{"key": "#{TEST_ACTIVE_PUBLIC_KEY}","weight": 1}],"accounts": [{"permission":{"actor":"daccustodian","permission":"eosio.code"},"weight":1}]}' owner -p testreguser2`
      `cleos set account permission testreguser3 active '{"threshold": 1,"keys": [{"key": "#{TEST_ACTIVE_PUBLIC_KEY}","weight": 1}],"accounts": [{"permission":{"actor":"daccustodian","permission":"eosio.code"},"weight":1}]}' owner -p testreguser3`
      `cleos set account permission testreguser4 active '{"threshold": 1,"keys": [{"key": "#{TEST_ACTIVE_PUBLIC_KEY}","weight": 1}],"accounts": [{"permission":{"actor":"daccustodian","permission":"eosio.code"},"weight":1}]}' owner -p testreguser4`

    end

    context "with valid and member registered user" do
      command %(cleos push action daccustodian regcandidate '{ "cand": "testreguser1", "bio": "any bio", "requestedpay": "11.5000 EOSDAC"}' -p testreguser1), allow_error: true
      its(:stdout) {is_expected.to include('daccustodian::regcandidate')}
      # its(:stderr) {is_expected.to include('no error')}
    end

    context "with unregistered user" do
      command %(cleos push action daccustodian regcandidate '{ "cand": "testreguser2", "bio": "any bio", "requestedpay": "10.0000 EOSDAC"}' -p testreguser2), allow_error: true
      # its(:stdout) {is_expected.to include('daccustodian::regcandidate')}
      its(:stderr) {is_expected.to include('Account is not registered with members')}
    end

    context "with user with empty agree terms" do
      command %(cleos push action daccustodian regcandidate '{ "cand": "testreguser3", "bio": "any bio", "requestedpay": "10.0000 EOSDAC"}' -p testreguser3), allow_error: true
      # its(:stdout) {is_expected.to include('daccustodian::regcandidate')}
      its(:stderr) {is_expected.to include('Account has not agreed any to terms')}
    end

    context "with user with old agreed terms" do
      command %(cleos push action daccustodian regcandidate '{ "cand": "testreguser4", "bio": "any bio", "requestedpay": "10.0000 EOSDAC"}' -p testreguser4), allow_error: true
      # its(:stdout) {is_expected.to include('daccustodian::regcandidate')}
      its(:stderr) {is_expected.to include('Account has not agreed to current terms')}
    end

    context "without delegated permission for staking" do
      command %(cleos push action daccustodian regcandidate '{ "cand": "testreguser5", "bio": "any bio", "requestedpay": "10.0000 EOSDAC"}' -p testreguser5), allow_error: true
      # its(:stdout) {is_expected.to include('daccustodian::regcandidate')}
      its(:stderr) {is_expected.to include('but does not have signatures for it under a provided delay of 0 ms')}
    end


    context "with user is already registered" do
      command %(cleos push action daccustodian regcandidate '{ "cand": "testreguser1", "bio": "any bio", "requestedpay": "10.0000 EOSDAC"}' -p testreguser1), allow_error: true
      # its(:stdout) {is_expected.to include('daccustodian::regcandidate')}
      its(:stderr) {is_expected.to include('Candidate is already registered.')}
    end

    context "Read the candidates table after regcandidate" do
      command %(cleos get table daccustodian daccustodian candidates), allow_error: true
      it do
        expect(JSON.parse(subject.stdout)).to eq JSON.parse <<~JSON
            {
              "rows": [{
                "candidate_name": "testreguser1",
                "bio": "any bio",
                "requestedpay": "11.5000 EOSDAC",
                "pendreqpay": "0.0000 EOSDAC",
                "is_custodian": 0,
                "locked_tokens": "10.0000 EOSDAC",
                "total_votes": 0
              }
            ],
            "more": false
          }
        JSON
      end
    end
  end


  describe "updateconfig" do
    context "with invalid auth" do
      command %(cleos push action daccustodian updateconfig '{ "lockupasset": "13.0000 EOSDAC", "maxvotes": 4, "latestterms": "New Latest terms", "numelected": 3}' -p testreguser1), allow_error: true
      # its(:stdout) {is_expected.to include('daccustodian::regcandidate')}
      its(:stderr) {is_expected.to include('missing required authority')}
    end

    context "with valid auth" do
      command %(cleos push action daccustodian updateconfig '{ "lockupasset": "23.0000 EOSDAC", "maxvotes": 4, "latestterms": "New Latest terms", "numelected": 3}' -p daccustodian), allow_error: true
      # its(:stdout) {is_expected.to include('daccustodian::regcandidate')}
      its(:stdout) {is_expected.to include('daccustodian::updateconfig')}
    end
  end

  describe "unregcand" do
    before(:all) do
      # configure accounts for eosdactoken
      `cleos push action eosdactoken issue '{ "to": "eosdactoken", "quantity": "1000.0000 EOSDAC", "memo": "Initial amount of tokens for you."}' -p eosdactoken`
      #create users
      `cleos create account eosio unreguser1 #{TEST_OWNER_PUBLIC_KEY} #{TEST_ACTIVE_PUBLIC_KEY}`
      `cleos create account eosio unreguser2 #{TEST_OWNER_PUBLIC_KEY} #{TEST_ACTIVE_PUBLIC_KEY}`

      # Issue tokens to the first accounts in the token contract
      `cleos push action eosdactoken issue '{ "to": "unreguser1", "quantity": "100.0000 EOSDAC", "memo": "Initial amount."}' -p eosdactoken`
      `cleos push action eosdactoken issue '{ "to": "unreguser2", "quantity": "100.0000 EOSDAC", "memo": "Initial amount."}' -p eosdactoken`

      # Add the founders to the memberreg table
      `cleos push action eosdactoken memberreg '{ "sender": "unreguser1", "agreedterms": "New Latest terms"}' -p unreguser1`
      `cleos push action eosdactoken memberreg '{ "sender": "unreguser2", "agreedterms": "New Latest terms"}' -p unreguser2`

      `cleos set account permission unreguser2 active '{"threshold": 1,"keys": [{"key": "#{TEST_ACTIVE_PUBLIC_KEY}","weight": 1}],"accounts": [{"permission":{"actor":"daccustodian","permission":"eosio.code"},"weight":1}]}' owner -p unreguser2`

      `cleos push action daccustodian regcandidate '{ "cand": "unreguser2", "bio": "any bio", "requestedpay": "11.5000 EOSDAC"}' -p unreguser2`
    end

    context "with invalid auth" do
      command %(cleos push action daccustodian unregcand '{ "cand": "unreguser3"}' -p testreguser3), allow_error: true
      # its(:stdout) {is_expected.to include('daccustodian::regcandidate')}
      its(:stderr) {is_expected.to include('missing required authority')}
    end

    context "with valid auth but not registered" do
      command %(cleos push action daccustodian unregcand '{ "cand": "unreguser1"}' -p unreguser1), allow_error: true
      its(:stderr) {is_expected.to include('Candidate is not already registered.')}
      # its(:stdout) {is_expected.to include('daccustodian::updateconfig')}
    end

    context "with valid auth" do
      command %(cleos push action daccustodian unregcand '{ "cand": "unreguser2"}' -p unreguser2), allow_error: true
      its(:stdout) {is_expected.to include('daccustodian::unregcand')}
      # its(:stderr) {is_expected.to include('daccustodian:: error occurred')}
    end
  end

  describe "update bio" do
    before(:all) do
      # configure accounts for eosdactoken
      `cleos push action eosdactoken issue '{ "to": "eosdactoken", "quantity": "1000.0000 EOSDAC", "memo": "Initial amount of tokens for you."}' -p eosdactoken`
      #create users
      `cleos create account eosio updatebio1 #{TEST_OWNER_PUBLIC_KEY} #{TEST_ACTIVE_PUBLIC_KEY}`
      `cleos create account eosio updatebio2 #{TEST_OWNER_PUBLIC_KEY} #{TEST_ACTIVE_PUBLIC_KEY}`

      # Issue tokens to the first accounts in the token contract
      `cleos push action eosdactoken issue '{ "to": "updatebio1", "quantity": "100.0000 EOSDAC", "memo": "Initial amount."}' -p eosdactoken`
      `cleos push action eosdactoken issue '{ "to": "updatebio2", "quantity": "100.0000 EOSDAC", "memo": "Initial amount."}' -p eosdactoken`

      # Add the founders to the memberreg table
      `cleos push action eosdactoken memberreg '{ "sender": "updatebio1", "agreedterms": "New Latest terms"}' -p updatebio1`
      `cleos push action eosdactoken memberreg '{ "sender": "updatebio2", "agreedterms": "New Latest terms"}' -p updatebio2`

      # set account permissions for transfers from within the contract.
      `cleos set account permission updatebio2 active '{"threshold": 1,"keys": [{"key": "#{TEST_ACTIVE_PUBLIC_KEY}","weight": 1}],"accounts": [{"permission":{"actor":"daccustodian","permission":"eosio.code"},"weight":1}]}' owner -p updatebio2`

      `cleos push action daccustodian regcandidate '{ "cand": "updatebio2", "bio": "any bio", "requestedpay": "11.5000 EOSDAC"}' -p updatebio2`
    end

    context "with invalid auth" do
      command %(cleos push action daccustodian updatebio '{ "cand": "updatebio1", "bio": "new bio"}' -p testreguser3), allow_error: true
      # its(:stdout) {is_expected.to include('daccustodian::regcandidate')}
      its(:stderr) {is_expected.to include('missing required authority')}
    end

    context "with valid auth but not registered" do
      command %(cleos push action daccustodian updatebio '{ "cand": "updatebio1", "bio": "new bio"}' -p updatebio1), allow_error: true
      its(:stderr) {is_expected.to include('Candidate is not already registered.')}
      # its(:stdout) {is_expected.to include('daccustodian::updateconfig')}
    end

    context "with valid auth" do
      command %(cleos push action daccustodian updatebio '{ "cand": "updatebio2", "bio": "new bio"}' -p updatebio2), allow_error: true
      its(:stdout) {is_expected.to include('daccustodian::updatebio')}
      # its(:stdout) {is_expected.to include('daccustodian::updateconfig')}
    end
  end

  describe "updatereqpay" do
    before(:all) do
      # configure accounts for eosdactoken
      `cleos push action eosdactoken issue '{ "to": "eosdactoken", "quantity": "1000.0000 EOSDAC", "memo": "Initial amount of tokens for you."}' -p eosdactoken`
      #create users
      `cleos create account eosio updatepay1 #{TEST_OWNER_PUBLIC_KEY} #{TEST_ACTIVE_PUBLIC_KEY}`
      `cleos create account eosio updatepay2 #{TEST_OWNER_PUBLIC_KEY} #{TEST_ACTIVE_PUBLIC_KEY}`

      # Issue tokens to the first accounts in the token contract
      `cleos push action eosdactoken issue '{ "to": "updatepay1", "quantity": "100.0000 EOSDAC", "memo": "Initial amount."}' -p eosdactoken`
      `cleos push action eosdactoken issue '{ "to": "updatepay2", "quantity": "100.0000 EOSDAC", "memo": "Initial amount."}' -p eosdactoken`

      # Add the founders to the memberreg table
      `cleos push action eosdactoken memberreg '{ "sender": "updatepay1", "agreedterms": "New Latest terms"}' -p updatepay1`
      `cleos push action eosdactoken memberreg '{ "sender": "updatepay2", "agreedterms": "New Latest terms"}' -p updatepay2`

      # set account permissions for transfers from within the contract.
      `cleos set account permission updatepay2 active '{"threshold": 1,"keys": [{"key": "#{TEST_ACTIVE_PUBLIC_KEY}","weight": 1}],"accounts": [{"permission":{"actor":"daccustodian","permission":"eosio.code"},"weight":1}]}' owner -p updatepay2`

      `cleos push action daccustodian regcandidate '{ "cand": "updatepay2", "bio": "any bio", "requestedpay": "21.5000 EOSDAC"}' -p updatepay2`
    end

    context "with invalid auth" do
      command %(cleos push action daccustodian updatereqpay '{ "cand": "updatepay1", "requestedpay": "11.5000 EOSDAC"}' -p testreguser3), allow_error: true
      # its(:stdout) {is_expected.to include('daccustodian::regcandidate')}
      its(:stderr) {is_expected.to include('missing required authority')}
    end

    context "with valid auth but not registered" do
      command %(cleos push action daccustodian updatereqpay '{ "cand": "updatepay1", "requestedpay": "31.5000 EOSDAC"}' -p updatepay1), allow_error: true
      its(:stderr) {is_expected.to include('Candidate is not already registered.')}
      # its(:stdout) {is_expected.to include('daccustodian::updateconfig')}
    end

    context "with valid auth" do
      command %(cleos push action daccustodian updatereqpay '{ "cand": "updatepay2", "requestedpay": "41.5000 EOSDAC"}' -p updatepay2), allow_error: true
      its(:stdout) {is_expected.to include('daccustodian::updatereqpay')}
      # its(:stdout) {is_expected.to include('daccustodian::updateconfig')}
    end
  end

  context "Read the candidates table after change reqpay" do
    command %(cleos get table daccustodian daccustodian candidates), allow_error: true
    it do
      expect(JSON.parse(subject.stdout)).to eq JSON.parse <<~JSON
          {
            "rows": [{
              "candidate_name": "testreguser1",
              "bio": "any bio",
              "requestedpay": "11.5000 EOSDAC",
              "pendreqpay": "0.0000 EOSDAC",
              "is_custodian": 0,
              "locked_tokens": "10.0000 EOSDAC",
              "total_votes": 0
            },{
              "candidate_name": "updatebio2",
              "bio": "new bio",
              "requestedpay": "11.5000 EOSDAC",
              "pendreqpay": "0.0000 EOSDAC",
              "is_custodian": 0,
              "locked_tokens": "23.0000 EOSDAC",
              "total_votes": 0
            },{
              "candidate_name": "updatepay2",
              "bio": "any bio",
              "requestedpay": "21.5000 EOSDAC",
              "pendreqpay": "41.5000 EOSDAC",
              "is_custodian": 0,
              "locked_tokens": "23.0000 EOSDAC",
              "total_votes": 0
            }
          ],
          "more": false
        }
      JSON
    end
  end

  describe "votecust" do
    before(:all) do
      # configure accounts for eosdactoken

      #create users
      `cleos create account eosio votecust1 #{TEST_OWNER_PUBLIC_KEY} #{TEST_ACTIVE_PUBLIC_KEY}`
      `cleos create account eosio votecust2 #{TEST_OWNER_PUBLIC_KEY} #{TEST_ACTIVE_PUBLIC_KEY}`
      `cleos create account eosio votecust3 #{TEST_OWNER_PUBLIC_KEY} #{TEST_ACTIVE_PUBLIC_KEY}`
      `cleos create account eosio votecust4 #{TEST_OWNER_PUBLIC_KEY} #{TEST_ACTIVE_PUBLIC_KEY}`
      `cleos create account eosio votecust5 #{TEST_OWNER_PUBLIC_KEY} #{TEST_ACTIVE_PUBLIC_KEY}`
      `cleos create account eosio votecust11 #{TEST_OWNER_PUBLIC_KEY} #{TEST_ACTIVE_PUBLIC_KEY}`
      `cleos create account eosio unrvotecust1 #{TEST_OWNER_PUBLIC_KEY} #{TEST_ACTIVE_PUBLIC_KEY}`
      `cleos create account eosio voter1 #{TEST_OWNER_PUBLIC_KEY} #{TEST_ACTIVE_PUBLIC_KEY}`
      `cleos create account eosio unregvoter #{TEST_OWNER_PUBLIC_KEY} #{TEST_ACTIVE_PUBLIC_KEY}`

      # Issue tokens to the first accounts in the token contract
      `cleos push action eosdactoken issue '{ "to": "votecust1", "quantity": "101.0000 EOSDAC", "memo": "Initial amount."}' -p eosdactoken`
      `cleos push action eosdactoken issue '{ "to": "votecust2", "quantity": "102.0000 EOSDAC", "memo": "Initial amount."}' -p eosdactoken`
      `cleos push action eosdactoken issue '{ "to": "votecust3", "quantity": "103.0000 EOSDAC", "memo": "Initial amount."}' -p eosdactoken`
      `cleos push action eosdactoken issue '{ "to": "votecust4", "quantity": "104.0000 EOSDAC", "memo": "Initial amount."}' -p eosdactoken`
      `cleos push action eosdactoken issue '{ "to": "votecust5", "quantity": "105.0000 EOSDAC", "memo": "Initial amount."}' -p eosdactoken`
      `cleos push action eosdactoken issue '{ "to": "votecust11", "quantity": "106.0000 EOSDAC", "memo": "Initial amount."}' -p eosdactoken`
      `cleos push action eosdactoken issue '{ "to": "unrvotecust1", "quantity": "107.0000 EOSDAC", "memo": "Initial amount."}' -p eosdactoken`
      `cleos push action eosdactoken issue '{ "to": "voter1", "quantity": "108.0000 EOSDAC", "memo": "Initial amount."}' -p eosdactoken`
      `cleos push action eosdactoken issue '{ "to": "unregvoter", "quantity": "109.0000 EOSDAC", "memo": "Initial amount."}' -p eosdactoken`

      # Add the founders to the memberreg table
      `cleos push action eosdactoken memberreg '{ "sender": "votecust1", "agreedterms": "New Latest terms"}' -p votecust1`
      `cleos push action eosdactoken memberreg '{ "sender": "votecust2", "agreedterms": "New Latest terms"}' -p votecust2`
      `cleos push action eosdactoken memberreg '{ "sender": "votecust3", "agreedterms": "New Latest terms"}' -p votecust3`
      `cleos push action eosdactoken memberreg '{ "sender": "votecust4", "agreedterms": "New Latest terms"}' -p votecust4`
      `cleos push action eosdactoken memberreg '{ "sender": "votecust5", "agreedterms": "New Latest terms"}' -p votecust5`
      `cleos push action eosdactoken memberreg '{ "sender": "votecust11", "agreedterms": "New Latest terms"}' -p votecust11`
      # `cleos push action eosdactoken memberreg '{ "sender": "unrvotecust1", "agreedterms": "New Latest terms"}' -p unrvotecust1`
      `cleos push action eosdactoken memberreg '{ "sender": "voter1", "agreedterms": "New Latest terms"}' -p voter1`
      # `cleos push action eosdactoken memberreg '{ "sender": "unregvoter", "agreedterms": "New Latest terms"}' -p unregvoter`

      # set account permissions for transfers from within the contract.
      `cleos set account permission votecust1 active '{"threshold": 1,"keys": [{"key": "#{TEST_ACTIVE_PUBLIC_KEY}","weight": 1}],"accounts": [{"permission":{"actor":"daccustodian","permission":"eosio.code"},"weight":1}]}' owner -p votecust1`
      `cleos set account permission votecust2 active '{"threshold": 1,"keys": [{"key": "#{TEST_ACTIVE_PUBLIC_KEY}","weight": 1}],"accounts": [{"permission":{"actor":"daccustodian","permission":"eosio.code"},"weight":1}]}' owner -p votecust2`
      `cleos set account permission votecust3 active '{"threshold": 1,"keys": [{"key": "#{TEST_ACTIVE_PUBLIC_KEY}","weight": 1}],"accounts": [{"permission":{"actor":"daccustodian","permission":"eosio.code"},"weight":1}]}' owner -p votecust3`
      `cleos set account permission votecust4 active '{"threshold": 1,"keys": [{"key": "#{TEST_ACTIVE_PUBLIC_KEY}","weight": 1}],"accounts": [{"permission":{"actor":"daccustodian","permission":"eosio.code"},"weight":1}]}' owner -p votecust4`
      `cleos set account permission votecust5 active '{"threshold": 1,"keys": [{"key": "#{TEST_ACTIVE_PUBLIC_KEY}","weight": 1}],"accounts": [{"permission":{"actor":"daccustodian","permission":"eosio.code"},"weight":1}]}' owner -p votecust5`
      `cleos set account permission votecust11 active '{"threshold": 1,"keys": [{"key": "#{TEST_ACTIVE_PUBLIC_KEY}","weight": 1}],"accounts": [{"permission":{"actor":"daccustodian","permission":"eosio.code"},"weight":1}]}' owner -p votecust11`
      `cleos set account permission voter1 active '{"threshold": 1,"keys": [{"key": "#{TEST_ACTIVE_PUBLIC_KEY}","weight": 1}],"accounts": [{"permission":{"actor":"daccustodian","permission":"eosio.code"},"weight":1}]}' owner -p voter1`

      `cleos push action daccustodian regcandidate '{ "cand": "votecust1", "bio": "any bio", "requestedpay": "11.0000 EOSDAC"}' -p votecust1`
      `cleos push action daccustodian regcandidate '{ "cand": "votecust2", "bio": "any bio", "requestedpay": "12.0000 EOSDAC"}' -p votecust2`
      `cleos push action daccustodian regcandidate '{ "cand": "votecust3", "bio": "any bio", "requestedpay": "13.0000 EOSDAC"}' -p votecust3`
      `cleos push action daccustodian regcandidate '{ "cand": "votecust4", "bio": "any bio", "requestedpay": "14.0000 EOSDAC"}' -p votecust4`
      `cleos push action daccustodian regcandidate '{ "cand": "votecust5", "bio": "any bio", "requestedpay": "15.0000 EOSDAC"}' -p votecust5`
      `cleos push action daccustodian regcandidate '{ "cand": "votecust11", "bio": "any bio", "requestedpay": "16.0000 EOSDAC"}' -p votecust11`
      # `cleos push action daccustodian regcandidate '{ "cand": "unrvotecust1", "bio": "any bio", "requestedpay": "21.5000 EOSDAC"}' -p unrvotecust1`
      `cleos push action daccustodian regcandidate '{ "cand": "voter1", "bio": "any bio", "requestedpay": "17.0000 EOSDAC"}' -p voter1`
      # `cleos push action daccustodian regcandidate '{ "cand": "unregvoter", "bio": "any bio", "requestedpay": "21.5000 EOSDAC"}' -p unregvoter`
    end

    context "with invalid auth" do
      command %(cleos push action daccustodian votecust '{ "voter": "voter1", "newvotes": ["votecust1","votecust2","votecust3","votecust4","votecust5"]}' -p testreguser3), allow_error: true
      # its(:stdout) {is_expected.to include('daccustodian::regcandidate')}
      its(:stderr) {is_expected.to include('missing required authority')}
    end

    context "not registered" do
      command %(cleos push action daccustodian votecust '{ "voter": "unregvoter", "newvotes": ["votecust1","votecust2","votecust3","votecust4","votecust5"]}' -p unregvoter), allow_error: true
      its(:stderr) {is_expected.to include('Account is not registered with members')}
      # its(:stdout) {is_expected.to include('daccustodian::updateconfig')}
    end

    context "exceeded allowed number of votes" do
      command %(cleos push action daccustodian votecust '{ "voter": "voter1", "newvotes": ["voter1","votecust2","votecust3","votecust4","votecust5", "votecust11"]}' -p voter1), allow_error: true
      its(:stderr) {is_expected.to include('Max number of allowed votes was exceeded.')}
      # its(:stdout) {is_expected.to include('daccustodian::updateconfig')}
    end

    context "with valid auth create new vote" do
      command %(cleos push action daccustodian votecust '{ "voter": "voter1", "newvotes": ["votecust1","votecust2","votecust3"]}' -p voter1), allow_error: true
      # its(:stdout) {is_expected.to include('daccustodian::votecust')}
      its(:stdout) {is_expected.to include('daccustodian::votecust')}
    end

    context "Read the votes table after _create_ vote" do
      command %(cleos get table daccustodian daccustodian votes), allow_error: true
      it do
        expect(JSON.parse(subject.stdout)).to eq JSON.parse <<~JSON
            {
              "rows": [{
                "voter": "voter1",
                "proxy": "",
                "weight": 0,
                "candidates": [
                  "votecust1",
                  "votecust2",
                  "votecust3"
                ]
              }
            ],
            "more": false
          }
        JSON
      end
    end

    context "Read the candidates table after _create_ vote" do
      command %(cleos get table daccustodian daccustodian candidates), allow_error: true
      it do
        expect(JSON.parse(subject.stdout)).to eq JSON.parse <<~JSON
            {
              "rows": [{
                "candidate_name": "testreguser1",
                "bio": "any bio",
                "requestedpay": "11.5000 EOSDAC",
                "pendreqpay": "0.0000 EOSDAC",
                "is_custodian": 0,
                "locked_tokens": "10.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "updatebio2",
                "bio": "new bio",
                "requestedpay": "11.5000 EOSDAC",
                "pendreqpay": "0.0000 EOSDAC",
                "is_custodian": 0,
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "updatepay2",
                "bio": "any bio",
                "requestedpay": "21.5000 EOSDAC",
                "pendreqpay": "41.5000 EOSDAC",
                "is_custodian": 0,
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "votecust1",
                "bio": "any bio",
                "requestedpay": "11.0000 EOSDAC",
                "pendreqpay": "0.0000 EOSDAC",
                "is_custodian": 0,
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "votecust11",
                "bio": "any bio",
                "requestedpay": "16.0000 EOSDAC",
                "pendreqpay": "0.0000 EOSDAC",
                "is_custodian": 0,
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "votecust2",
                "bio": "any bio",
                "requestedpay": "12.0000 EOSDAC",
                "pendreqpay": "0.0000 EOSDAC",
                "is_custodian": 0,
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "votecust3",
                "bio": "any bio",
                "requestedpay": "13.0000 EOSDAC",
                "pendreqpay": "0.0000 EOSDAC",
                "is_custodian": 0,
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "votecust4",
                "bio": "any bio",
                "requestedpay": "14.0000 EOSDAC",
                "pendreqpay": "0.0000 EOSDAC",
                "is_custodian": 0,
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "votecust5",
                "bio": "any bio",
                "requestedpay": "15.0000 EOSDAC",
                "pendreqpay": "0.0000 EOSDAC",
                "is_custodian": 0,
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "voter1",
                "bio": "any bio",
                "requestedpay": "17.0000 EOSDAC",
                "pendreqpay": "0.0000 EOSDAC",
                "is_custodian": 0,
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              }
            ],
            "more": true
          }

        JSON
      end
    end

    context "with valid auth change existing vote" do
      # before(:all) do
      #   `cleos push action eosdactoken issue '{ "to": "voter1", "quantity": "58.0000 EOSDAC", "memo": "Second amount."}' -p eosdactoken`
      # end
      command %(cleos push action daccustodian votecust '{ "voter": "voter1", "newvotes": ["votecust1","votecust2","votecust4"]}' -p voter1), allow_error: true
      # its(:stdout) {is_expected.to include('daccustodian::votecust')}
      its(:stdout) {is_expected.to include('daccustodian::votecust')}
    end

    context "Read the votes table after _change_ vote" do
      command %(cleos get table daccustodian daccustodian votes), allow_error: true
      it do
        expect(JSON.parse(subject.stdout)).to eq JSON.parse <<~JSON
            {
              "rows": [{
                "voter": "voter1",
                "proxy": "",
                "weight": 0,
                "candidates": [
                  "votecust1",
                  "votecust2",
                  "votecust4"
                ]
              }
            ],
            "more": false
          }
        JSON
      end
    end

    context "Read the candidates table after _change_ vote" do
      command %(cleos get table daccustodian daccustodian candidates), allow_error: true
      it do
        expect(JSON.parse(subject.stdout)).to eq JSON.parse <<~JSON
            {
              "rows": [{
                "candidate_name": "testreguser1",
                "bio": "any bio",
                "requestedpay": "11.5000 EOSDAC",
                "pendreqpay": "0.0000 EOSDAC",
                "is_custodian": 0,
                "locked_tokens": "10.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "updatebio2",
                "bio": "new bio",
                "requestedpay": "11.5000 EOSDAC",
                "pendreqpay": "0.0000 EOSDAC",
                "is_custodian": 0,
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "updatepay2",
                "bio": "any bio",
                "requestedpay": "21.5000 EOSDAC",
                "pendreqpay": "41.5000 EOSDAC",
                "is_custodian": 0,
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "votecust1",
                "bio": "any bio",
                "requestedpay": "11.0000 EOSDAC",
                "pendreqpay": "0.0000 EOSDAC",
                "is_custodian": 0,
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "votecust11",
                "bio": "any bio",
                "requestedpay": "16.0000 EOSDAC",
                "pendreqpay": "0.0000 EOSDAC",
                "is_custodian": 0,
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "votecust2",
                "bio": "any bio",
                "requestedpay": "12.0000 EOSDAC",
                "pendreqpay": "0.0000 EOSDAC",
                "is_custodian": 0,
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "votecust3",
                "bio": "any bio",
                "requestedpay": "13.0000 EOSDAC",
                "pendreqpay": "0.0000 EOSDAC",
                "is_custodian": 0,
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "votecust4",
                "bio": "any bio",
                "requestedpay": "14.0000 EOSDAC",
                "pendreqpay": "0.0000 EOSDAC",
                "is_custodian": 0,
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "votecust5",
                "bio": "any bio",
                "requestedpay": "15.0000 EOSDAC",
                "pendreqpay": "0.0000 EOSDAC",
                "is_custodian": 0,
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "voter1",
                "bio": "any bio",
                "requestedpay": "17.0000 EOSDAC",
                "pendreqpay": "0.0000 EOSDAC",
                "is_custodian": 0,
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              }
            ],
            "more": true
          }
        JSON
      end
    end

  end

  describe "voteproxy" do
    before(:all) do
      # configure accounts for eosdactoken

      #create users
      `cleos create account eosio voteproxy1 #{TEST_OWNER_PUBLIC_KEY} #{TEST_ACTIVE_PUBLIC_KEY}`
      `cleos create account eosio voteproxy3 #{TEST_OWNER_PUBLIC_KEY} #{TEST_ACTIVE_PUBLIC_KEY}`

      # Issue tokens to the first accounts in the token contract
      `cleos push action eosdactoken issue '{ "to": "voteproxy1", "quantity": "101.0000 EOSDAC", "memo": "Initial amount."}' -p eosdactoken`
      `cleos push action eosdactoken issue '{ "to": "voteproxy3", "quantity": "101.0000 EOSDAC", "memo": "Initial amount."}' -p eosdactoken`
      `cleos push action eosdactoken issue '{ "to": "unregvoter", "quantity": "109.0000 EOSDAC", "memo": "Initial amount."}' -p eosdactoken`

      # Add the founders to the memberreg table
      `cleos push action eosdactoken memberreg '{ "sender": "voteproxy1", "agreedterms": "New Latest terms"}' -p voteproxy1`
      `cleos push action eosdactoken memberreg '{ "sender": "voteproxy3", "agreedterms": "New Latest terms"}' -p voteproxy3`
      `cleos push action eosdactoken memberreg '{ "sender": "voter1", "agreedterms": "New Latest terms"}' -p voter1`
      # `cleos push action eosdactoken memberreg '{ "sender": "unregvoter", "agreedterms": "New Latest terms"}' -p unregvoter`

      # set account permissions for transfers from within the contract.
      `cleos set account permission voteproxy1 active '{"threshold": 1,"keys": [{"key": "#{TEST_ACTIVE_PUBLIC_KEY}","weight": 1}],"accounts": [{"permission":{"actor":"daccustodian","permission":"eosio.code"},"weight":1}]}' owner -p voteproxy1`

      `cleos push action daccustodian regcandidate '{ "cand": "voteproxy1", "bio": "any bio", "requestedpay": "10.0000 EOSDAC"}' -p voteproxy1`
      # `cleos push action daccustodian regcandidate '{ "cand": "unregvoter", "bio": "any bio", "requestedpay": "21.5000 EOSDAC"}' -p unregvoter`
    end

    context "with invalid auth" do
      command %(cleos push action daccustodian voteproxy '{ "voter": "voter1", "proxy": "voteproxy1"}' -p testreguser3), allow_error: true
      # its(:stdout) {is_expected.to include('daccustodian::regcandidate')}
      its(:stderr) {is_expected.to include('missing required authority')}
    end

    context "not registered" do
      command %(cleos push action daccustodian voteproxy '{ "voter": "unregvoter", "proxy": "voteproxy1"}' -p unregvoter), allow_error: true
      its(:stderr) {is_expected.to include('Account is not registered with members')}
      # its(:stdout) {is_expected.to include('daccustodian::updateconfig')}
    end

    context "voting for self" do
      command %(cleos push action daccustodian voteproxy '{ "voter": "voter1", "proxy":"voter1"}' -p voter1), allow_error: true
      its(:stderr) {is_expected.to include('Member cannot proxy vote for themselves: voter1')}
      # its(:stdout) {is_expected.to include('daccustodian::updateconfig')}
    end

    context "with valid auth create new vote" do
      command %(cleos push action daccustodian voteproxy '{ "voter": "voter1", "proxy": "voteproxy1"}' -p voter1), allow_error: true
      # its(:stdout) {is_expected.to include('daccustodian::voteproxy')}
      its(:stdout) {is_expected.to include('daccustodian::voteproxy')}
    end

    context "Read the votes table after _create_ vote" do
      command %(cleos get table daccustodian daccustodian votes), allow_error: true
      it do
        expect(JSON.parse(subject.stdout)).to eq JSON.parse <<~JSON
            {
              "rows": [{
                "voter": "voter1",
                "proxy": "voteproxy1",
                "weight": 0,
                "candidates": []
              }
            ],
            "more": false
          }
        JSON
      end
    end

    context "candidates table after _create_ proxy vote should have empty totalvotes" do
      command %(cleos get table daccustodian daccustodian candidates --limit 20), allow_error: true
      it do
        expect(JSON.parse(subject.stdout)).to eq JSON.parse <<~JSON
            {
              "rows": [{
                "candidate_name": "testreguser1",
                "bio": "any bio",
                "requestedpay": "11.5000 EOSDAC",
                "pendreqpay": "0.0000 EOSDAC",
                "is_custodian": 0,
                "locked_tokens": "10.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "updatebio2",
                "bio": "new bio",
                "requestedpay": "11.5000 EOSDAC",
                "pendreqpay": "0.0000 EOSDAC",
                "is_custodian": 0,
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "updatepay2",
                "bio": "any bio",
                "requestedpay": "21.5000 EOSDAC",
                "pendreqpay": "41.5000 EOSDAC",
                "is_custodian": 0,
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "votecust1",
                "bio": "any bio",
                "requestedpay": "11.0000 EOSDAC",
                "pendreqpay": "0.0000 EOSDAC",
                "is_custodian": 0,
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "votecust11",
                "bio": "any bio",
                "requestedpay": "16.0000 EOSDAC",
                "pendreqpay": "0.0000 EOSDAC",
                "is_custodian": 0,
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "votecust2",
                "bio": "any bio",
                "requestedpay": "12.0000 EOSDAC",
                "pendreqpay": "0.0000 EOSDAC",
                "is_custodian": 0,
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "votecust3",
                "bio": "any bio",
                "requestedpay": "13.0000 EOSDAC",
                "pendreqpay": "0.0000 EOSDAC",
                "is_custodian": 0,
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "votecust4",
                "bio": "any bio",
                "requestedpay": "14.0000 EOSDAC",
                "pendreqpay": "0.0000 EOSDAC",
                "is_custodian": 0,
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "votecust5",
                "bio": "any bio",
                "requestedpay": "15.0000 EOSDAC",
                "pendreqpay": "0.0000 EOSDAC",
                "is_custodian": 0,
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "voteproxy1",
                "bio": "any bio",
                "requestedpay": "10.0000 EOSDAC",
                "pendreqpay": "0.0000 EOSDAC",
                "is_custodian": 0,
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "voter1",
                "bio": "any bio",
                "requestedpay": "17.0000 EOSDAC",
                "pendreqpay": "0.0000 EOSDAC",
                "is_custodian": 0,
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              }
            ],
            "more": false
          }

        JSON
      end
    end

    context "with valid auth change existing vote" do
      command %(cleos push action daccustodian voteproxy '{ "voter": "voter1", "proxy": "voteproxy3"}' -p voter1), allow_error: true
      # its(:stdout) {is_expected.to include('daccustodian::voteproxy')}
      its(:stdout) {is_expected.to include('daccustodian::voteproxy')}
    end

    context "Read the votes table after _change_ vote" do
      command %(cleos get table daccustodian daccustodian votes), allow_error: true
      it do
        expect(JSON.parse(subject.stdout)).to eq JSON.parse <<~JSON
            {
              "rows": [{
                "voter": "voter1",
                "proxy": "voteproxy3",
                "weight": 0,
                "candidates": []
              }
            ],
            "more": false
          }
        JSON
      end
    end

    context "the candidates table after _change_ to proxy vote total votes should still be 0" do
      command %(cleos get table daccustodian daccustodian candidates --limit 20), allow_error: true
      it do
        expect(JSON.parse(subject.stdout)).to eq JSON.parse <<~JSON
            {
              "rows": [{
                "candidate_name": "testreguser1",
                "bio": "any bio",
                "requestedpay": "11.5000 EOSDAC",
                "pendreqpay": "0.0000 EOSDAC",
                "is_custodian": 0,
                "locked_tokens": "10.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "updatebio2",
                "bio": "new bio",
                "requestedpay": "11.5000 EOSDAC",
                "pendreqpay": "0.0000 EOSDAC",
                "is_custodian": 0,
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "updatepay2",
                "bio": "any bio",
                "requestedpay": "21.5000 EOSDAC",
                "pendreqpay": "41.5000 EOSDAC",
                "is_custodian": 0,
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "votecust1",
                "bio": "any bio",
                "requestedpay": "11.0000 EOSDAC",
                "pendreqpay": "0.0000 EOSDAC",
                "is_custodian": 0,
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "votecust11",
                "bio": "any bio",
                "requestedpay": "16.0000 EOSDAC",
                "pendreqpay": "0.0000 EOSDAC",
                "is_custodian": 0,
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "votecust2",
                "bio": "any bio",
                "requestedpay": "12.0000 EOSDAC",
                "pendreqpay": "0.0000 EOSDAC",
                "is_custodian": 0,
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "votecust3",
                "bio": "any bio",
                "requestedpay": "13.0000 EOSDAC",
                "pendreqpay": "0.0000 EOSDAC",
                "is_custodian": 0,
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "votecust4",
                "bio": "any bio",
                "requestedpay": "14.0000 EOSDAC",
                "pendreqpay": "0.0000 EOSDAC",
                "is_custodian": 0,
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "votecust5",
                "bio": "any bio",
                "requestedpay": "15.0000 EOSDAC",
                "pendreqpay": "0.0000 EOSDAC",
                "is_custodian": 0,
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "voteproxy1",
                "bio": "any bio",
                "requestedpay": "10.0000 EOSDAC",
                "pendreqpay": "0.0000 EOSDAC",
                "is_custodian": 0,
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "voter1",
                "bio": "any bio",
                "requestedpay": "17.0000 EOSDAC",
                "pendreqpay": "0.0000 EOSDAC",
                "is_custodian": 0,
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              }
            ],
            "more": false
          }
        JSON
      end
    end

    context "with valid auth change to existing vote of proxy" do
      before(:all) do
        `cleos push action daccustodian votecust '{ "voter": "voteproxy3", "newvotes": ["votecust1","votecust2","votecust3"]}' -p voteproxy3`
      end

      context "the votes table" do
        command %(cleos get table daccustodian daccustodian votes), allow_error: true
        it do
          expect(JSON.parse(subject.stdout)).to eq JSON.parse <<~JSON
              {
                "rows": [{
                  "voter": "voteproxy3",
                  "proxy": "",
                  "weight": 0,
                  "candidates": [
                    "votecust1",
                    "votecust2",
                    "votecust3"
                  ]
                },{
                  "voter": "voter1",
                  "proxy": "voteproxy3",
                  "weight": 0,
                  "candidates": []
                }
              ],
              "more": false
            }
          JSON
        end
      end

      context "the candidates table" do
        command %(cleos get table daccustodian daccustodian candidates --limit 20), allow_error: true
        it do
          expect(JSON.parse(subject.stdout)).to eq JSON.parse <<~JSON
              {
                "rows": [{
                  "candidate_name": "testreguser1",
                  "bio": "any bio",
                  "requestedpay": "11.5000 EOSDAC",
                  "pendreqpay": "0.0000 EOSDAC",
                  "is_custodian": 0,
                  "locked_tokens": "10.0000 EOSDAC",
                  "total_votes": 0
                },{
                  "candidate_name": "updatebio2",
                  "bio": "new bio",
                  "requestedpay": "11.5000 EOSDAC",
                  "pendreqpay": "0.0000 EOSDAC",
                  "is_custodian": 0,
                  "locked_tokens": "23.0000 EOSDAC",
                  "total_votes": 0
                },{
                  "candidate_name": "updatepay2",
                  "bio": "any bio",
                  "requestedpay": "21.5000 EOSDAC",
                  "pendreqpay": "41.5000 EOSDAC",
                  "is_custodian": 0,
                  "locked_tokens": "23.0000 EOSDAC",
                  "total_votes": 0
                },{
                  "candidate_name": "votecust1",
                  "bio": "any bio",
                  "requestedpay": "11.0000 EOSDAC",
                  "pendreqpay": "0.0000 EOSDAC",
                  "is_custodian": 0,
                  "locked_tokens": "23.0000 EOSDAC",
                  "total_votes": 0
                },{
                  "candidate_name": "votecust11",
                  "bio": "any bio",
                  "requestedpay": "16.0000 EOSDAC",
                  "pendreqpay": "0.0000 EOSDAC",
                  "is_custodian": 0,
                  "locked_tokens": "23.0000 EOSDAC",
                  "total_votes": 0
                },{
                  "candidate_name": "votecust2",
                  "bio": "any bio",
                  "requestedpay": "12.0000 EOSDAC",
                  "pendreqpay": "0.0000 EOSDAC",
                  "is_custodian": 0,
                  "locked_tokens": "23.0000 EOSDAC",
                  "total_votes": 0
                },{
                  "candidate_name": "votecust3",
                  "bio": "any bio",
                  "requestedpay": "13.0000 EOSDAC",
                  "pendreqpay": "0.0000 EOSDAC",
                  "is_custodian": 0,
                  "locked_tokens": "23.0000 EOSDAC",
                  "total_votes": 0
                },{
                  "candidate_name": "votecust4",
                  "bio": "any bio",
                  "requestedpay": "14.0000 EOSDAC",
                  "pendreqpay": "0.0000 EOSDAC",
                  "is_custodian": 0,
                  "locked_tokens": "23.0000 EOSDAC",
                  "total_votes": 0
                },{
                  "candidate_name": "votecust5",
                  "bio": "any bio",
                  "requestedpay": "15.0000 EOSDAC",
                  "pendreqpay": "0.0000 EOSDAC",
                  "is_custodian": 0,
                  "locked_tokens": "23.0000 EOSDAC",
                  "total_votes": 0
                },{
                  "candidate_name": "voteproxy1",
                  "bio": "any bio",
                  "requestedpay": "10.0000 EOSDAC",
                  "pendreqpay": "0.0000 EOSDAC",
                  "is_custodian": 0,
                  "locked_tokens": "23.0000 EOSDAC",
                  "total_votes": 0
                },{
                  "candidate_name": "voter1",
                  "bio": "any bio",
                  "requestedpay": "17.0000 EOSDAC",
                  "pendreqpay": "0.0000 EOSDAC",
                  "is_custodian": 0,
                  "locked_tokens": "23.0000 EOSDAC",
                  "total_votes": 0
                }
              ],
              "more": false
            }

          JSON
        end
      end
    end

    describe "newperiod without valid auth should fail" do
      command %(cleos push action daccustodian newperiod '{ "message": "log message"}' -p testreguser3), allow_error: true
      # its(:stdout) {is_expected.to include('daccustodian::voteproxy')}
      its(:stderr) {is_expected.to include('missing authority of daccustodian')}
    end

    describe "newperiod before votes processing" do
      before(:all) do
        `cleos push action daccustodian votecust '{ "voter": "votecust11", "newvotes": ["votecust2","votecust3","votecust4"]}' -p votecust11`
      end
      command %(cleos push action daccustodian newperiod '{ "message": "log message"}' -p daccustodian), allow_error: true
      # its(:stdout) {is_expected.to include('daccustodian::voteproxy')}
      its(:stdout) {is_expected.to include('daccustodian::newperiod')}
    end

    context "the pending_pay table" do
      # Assuming that proxied voter's weight should be 0 since the weight has been delegated to proxy.
      # Also assumes that staked tokens for candidate are not used for voting power.
      command %(cleos get table daccustodian daccustodian pendingpay), allow_error: true
      it do
        expect(JSON.parse(subject.stdout)).to eq JSON.parse <<~JSON
                      {
            "rows": [{
                "receiver": "unreguser2",
                "quantity": "23.0000 EOSDAC",
                "memo": "Returning locked up stake. Thank you."
              }
            ],
            "more": false
          }
        JSON
      end
    end

    context "the votes table" do
      command %(cleos get table daccustodian daccustodian votes), allow_error: true
      it do
        expect(JSON.parse(subject.stdout)).to eq JSON.parse <<~JSON
                      {
            "rows": [{
                "voter": "votecust11",
                "proxy": "",
                "weight": 830000,
                "candidates": [
                  "votecust2",
                  "votecust3",
                  "votecust4"
                ]
              },{
                "voter": "voteproxy3",
                "proxy": "",
                "weight": 1860000,
                "candidates": [
                  "votecust1",
                  "votecust2",
                  "votecust3"
                ]
              },{
                "voter": "voter1",
                "proxy": "voteproxy3",
                "weight": 850000,
                "candidates": []
              }
            ],
            "more": false
          }

        JSON
      end
    end

    context "the candidates table" do
      command %(cleos get table daccustodian daccustodian candidates --limit 20), allow_error: true
      it do
        expect(JSON.parse(subject.stdout)).to eq JSON.parse <<~JSON
                                {
            "rows": [{
                "candidate_name": "testreguser1",
                "bio": "any bio",
                "requestedpay": "11.5000 EOSDAC",
                "pendreqpay": "0.0000 EOSDAC",
                "is_custodian": 0,
                "locked_tokens": "10.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "updatebio2",
                "bio": "new bio",
                "requestedpay": "11.5000 EOSDAC",
                "pendreqpay": "0.0000 EOSDAC",
                "is_custodian": 0,
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "updatepay2",
                "bio": "any bio",
                "requestedpay": "41.5000 EOSDAC",
                "pendreqpay": "0.0000 EOSDAC",
                "is_custodian": 0,
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "votecust1",
                "bio": "any bio",
                "requestedpay": "11.0000 EOSDAC",
                "pendreqpay": "0.0000 EOSDAC",
                "is_custodian": 1,
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 1860000
              },{
                "candidate_name": "votecust11",
                "bio": "any bio",
                "requestedpay": "16.0000 EOSDAC",
                "pendreqpay": "0.0000 EOSDAC",
                "is_custodian": 0,
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "votecust2",
                "bio": "any bio",
                "requestedpay": "12.0000 EOSDAC",
                "pendreqpay": "0.0000 EOSDAC",
                "is_custodian": 1,
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 2690000
              },{
                "candidate_name": "votecust3",
                "bio": "any bio",
                "requestedpay": "13.0000 EOSDAC",
                "pendreqpay": "0.0000 EOSDAC",
                "is_custodian": 1,
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 2690000
              },{
                "candidate_name": "votecust4",
                "bio": "any bio",
                "requestedpay": "14.0000 EOSDAC",
                "pendreqpay": "0.0000 EOSDAC",
                "is_custodian": 0,
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 830000
              },{
                "candidate_name": "votecust5",
                "bio": "any bio",
                "requestedpay": "15.0000 EOSDAC",
                "pendreqpay": "0.0000 EOSDAC",
                "is_custodian": 0,
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "voteproxy1",
                "bio": "any bio",
                "requestedpay": "10.0000 EOSDAC",
                "pendreqpay": "0.0000 EOSDAC",
                "is_custodian": 0,
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "voter1",
                "bio": "any bio",
                "requestedpay": "17.0000 EOSDAC",
                "pendreqpay": "0.0000 EOSDAC",
                "is_custodian": 0,
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              }
            ],
            "more": false
          }

        JSON
      end
    end

    describe "newperiod after votes processing" do
      command %(cleos push action daccustodian newperiod '{ "message": "log message"}' -p daccustodian), allow_error: true
      # its(:stdout) {is_expected.to include('daccustodian::voteproxy')}
      its(:stdout) {is_expected.to include('daccustodian::newperiod')}
    end

    context "the pending_pay table" do
      # Assuming that proxied voter's weight should be 0 since the weight has been delegated to proxy.
      # Also assumes that staked tokens for candidate are not used for voting power.
      command %(cleos get table daccustodian daccustodian pendingpay), allow_error: true
      it do
        expect(JSON.parse(subject.stdout)).to eq JSON.parse <<~JSON
                      {
            "rows": [{
                "receiver": "unreguser2",
                "quantity": "23.0000 EOSDAC",
                "memo": "Returning locked up stake. Thank you."
              },{
                "receiver": "votecust1",
                "quantity": "12.0000 EOSDAC",
                "memo": "EOSDAC Custodian pay. Thank you."
              },{
                "receiver": "votecust2",
                "quantity": "12.0000 EOSDAC",
                "memo": "EOSDAC Custodian pay. Thank you."
              },{
                "receiver": "votecust3",
                "quantity": "12.0000 EOSDAC",
                "memo": "EOSDAC Custodian pay. Thank you."
              }
            ],
            "more": false
          }
        JSON
      end
    end

    context "the votes table" do
      command %(cleos get table daccustodian daccustodian votes), allow_error: true
      it do
        expect(JSON.parse(subject.stdout)).to eq JSON.parse <<~JSON
                      {
            "rows": [{
                "voter": "votecust11",
                "proxy": "",
                "weight": 830000,
                "candidates": [
                  "votecust2",
                  "votecust3",
                  "votecust4"
                ]
              },{
                "voter": "voteproxy3",
                "proxy": "",
                "weight": 1860000,
                "candidates": [
                  "votecust1",
                  "votecust2",
                  "votecust3"
                ]
              },{
                "voter": "voter1",
                "proxy": "voteproxy3",
                "weight": 850000,
                "candidates": []
              }
            ],
            "more": false
          }

        JSON
      end
    end

    context "the candidates table" do
      command %(cleos get table daccustodian daccustodian candidates --limit 20), allow_error: true
      it do
        expect(JSON.parse(subject.stdout)).to eq JSON.parse <<~JSON
                                          {
            "rows": [{
                "candidate_name": "testreguser1",
                "bio": "any bio",
                "requestedpay": "11.5000 EOSDAC",
                "pendreqpay": "0.0000 EOSDAC",
                "is_custodian": 0,
                "locked_tokens": "10.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "updatebio2",
                "bio": "new bio",
                "requestedpay": "11.5000 EOSDAC",
                "pendreqpay": "0.0000 EOSDAC",
                "is_custodian": 0,
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "updatepay2",
                "bio": "any bio",
                "requestedpay": "41.5000 EOSDAC",
                "pendreqpay": "0.0000 EOSDAC",
                "is_custodian": 0,
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "votecust1",
                "bio": "any bio",
                "requestedpay": "11.0000 EOSDAC",
                "pendreqpay": "0.0000 EOSDAC",
                "is_custodian": 1,
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 1860000
              },{
                "candidate_name": "votecust11",
                "bio": "any bio",
                "requestedpay": "16.0000 EOSDAC",
                "pendreqpay": "0.0000 EOSDAC",
                "is_custodian": 0,
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "votecust2",
                "bio": "any bio",
                "requestedpay": "12.0000 EOSDAC",
                "pendreqpay": "0.0000 EOSDAC",
                "is_custodian": 1,
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 2690000
              },{
                "candidate_name": "votecust3",
                "bio": "any bio",
                "requestedpay": "13.0000 EOSDAC",
                "pendreqpay": "0.0000 EOSDAC",
                "is_custodian": 1,
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 2690000
              },{
                "candidate_name": "votecust4",
                "bio": "any bio",
                "requestedpay": "14.0000 EOSDAC",
                "pendreqpay": "0.0000 EOSDAC",
                "is_custodian": 0,
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 830000
              },{
                "candidate_name": "votecust5",
                "bio": "any bio",
                "requestedpay": "15.0000 EOSDAC",
                "pendreqpay": "0.0000 EOSDAC",
                "is_custodian": 0,
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "voteproxy1",
                "bio": "any bio",
                "requestedpay": "10.0000 EOSDAC",
                "pendreqpay": "0.0000 EOSDAC",
                "is_custodian": 0,
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "voter1",
                "bio": "any bio",
                "requestedpay": "17.0000 EOSDAC",
                "pendreqpay": "0.0000 EOSDAC",
                "is_custodian": 0,
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              }
            ],
            "more": false
          }


        JSON
      end
    end

    describe "paypending" do
      before(:all) do
        `cleos set account permission daccustodian active '{"threshold": 1,"keys": [{"key": "#{TEST_ACTIVE_PUBLIC_KEY}","weight": 1}],"accounts": [{"permission":{"actor":"daccustodian","permission":"eosio.code"},"weight":1}]}' owner -p daccustodian`
      end

      context "without valid auth" do
        command %(cleos push action daccustodian paypending '{ "message": "log message"}' -p voter1), allow_error: true
        # its(:stdout) {is_expected.to include('daccustodian::voteproxy')}
        its(:stderr) {is_expected.to include('missing authority of daccustodian')}
      end

      context "the pending_pay table still has content" do
        # Assuming that proxied voter's weight should be 0 since the weight has been delegated to proxy.
        # Also assumes that staked tokens for candidate are not used for voting power.
        command %(cleos get table daccustodian daccustodian pendingpay), allow_error: true
        it do
          expect(JSON.parse(subject.stdout)).to eq JSON.parse <<~JSON
                        {
              "rows": [{
                  "receiver": "unreguser2",
                  "quantity": "23.0000 EOSDAC",
                  "memo": "Returning locked up stake. Thank you."
                },{
                  "receiver": "votecust1",
                  "quantity": "12.0000 EOSDAC",
                  "memo": "EOSDAC Custodian pay. Thank you."
                },{
                  "receiver": "votecust2",
                  "quantity": "12.0000 EOSDAC",
                  "memo": "EOSDAC Custodian pay. Thank you."
                },{
                  "receiver": "votecust3",
                  "quantity": "12.0000 EOSDAC",
                  "memo": "EOSDAC Custodian pay. Thank you."
                }
              ],
              "more": false
            }
          JSON
        end
      end

      context "the balances should not have changed" do
        # Assuming that proxied voter's weight should be 0 since the weight has been delegated to proxy.
        # Also assumes that staked tokens for candidate are not used for voting power.
        command %(cleos get currency balance eosdactoken votecust2 EOSDAC), allow_error: true
        its(:stdout) {is_expected.to include('79.0000 EOSDAC')}
      end
    end

    context "with valid auth" do
      command %(cleos push action daccustodian paypending '{ "message": "log message"}' -p daccustodian), allow_error: true
      # its(:stdout) {is_expected.to include('daccustodian::voteproxy')}
      its(:stdout) {is_expected.to include('daccustodian::paypending')}
    end

    context "the pending_pay table should be empty" do
      # Assuming that proxied voter's weight should be 0 since the weight has been delegated to proxy.
      # Also assumes that staked tokens for candidate are not used for voting power.
      command %(cleos get table daccustodian daccustodian pendingpay), allow_error: true
      it do
        expect(JSON.parse(subject.stdout)).to eq JSON.parse <<~JSON
                      {
            "rows": [],
            "more": false
          }
        JSON
      end
    end

    context "the balances should updated" do
      # Assuming that proxied voter's weight should be 0 since the weight has been delegated to proxy.
      # Also assumes that staked tokens for candidate are not used for voting power.
      command %(cleos get currency balance eosdactoken votecust2 EOSDAC), allow_error: true
      its(:stdout) {is_expected.to include('91.0000 EOSDAC')}
    end
  end
end

