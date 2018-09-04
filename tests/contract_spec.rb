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

CONTRACT_OWNER_PRIVATE_KEY = '5K86iZz9h8jwgGDttMPcHqFHHru5ueqnfDs5fVSHfm8bJt8PjK6'
CONTRACT_OWNER_PUBLIC_KEY = 'EOS6Y1fKGLVr2zEFKKfAmRUoH1LzM7crJEBi4dL5ikYeGYqiJr6SS'

CONTRACT_ACTIVE_PRIVATE_KEY = '5Jbf3f26fz4HNWXVAd3TMYHnC68uu4PtkMnbgUa5mdCWmgu47sR'
CONTRACT_ACTIVE_PUBLIC_KEY = 'EOS7rjn3r52PYd2ppkVEKYvy6oRDP9MZsJUPB2MStrak8LS36pnTZ'

TEST_OWNER_PRIVATE_KEY = '5K86iZz9h8jwgGDttMPcHqFHHru5ueqnfDs5fVSHfm8bJt8PjK6'
TEST_OWNER_PUBLIC_KEY = 'EOS6Y1fKGLVr2zEFKKfAmRUoH1LzM7crJEBi4dL5ikYeGYqiJr6SS'

TEST_ACTIVE_PRIVATE_KEY = '5Jbf3f26fz4HNWXVAd3TMYHnC68uu4PtkMnbgUa5mdCWmgu47sR'
TEST_ACTIVE_PUBLIC_KEY = 'EOS7rjn3r52PYd2ppkVEKYvy6oRDP9MZsJUPB2MStrak8LS36pnTZ'

CONTRACT_NAME = 'daccustodian'
ACCOUNT_NAME = 'daccustodian'


beforescript = <<~SHELL
   set -x
   kill -INT `pgrep nodeos`

  ttab 'nodeos --delete-all-blocks --verbose-http-errors'

   # kill -INT `pgrep nodeos`
    # nodeos --delete-all-blocks --verbose-http-errors &>/dev/null &
    sleep 2
   cleos wallet unlock --password `cat ~/eosio-wallet/.pass`
   cleos wallet import --private-key #{CONTRACT_ACTIVE_PRIVATE_KEY}
   cleos wallet import --private-key #{TEST_ACTIVE_PRIVATE_KEY}
   cleos wallet import --private-key #{TEST_OWNER_PRIVATE_KEY}
   cleos create account eosio #{ACCOUNT_NAME} #{CONTRACT_OWNER_PUBLIC_KEY} #{CONTRACT_ACTIVE_PUBLIC_KEY}
   cleos create account eosio eosdactoken #{CONTRACT_OWNER_PUBLIC_KEY} #{CONTRACT_ACTIVE_PUBLIC_KEY}
   cleos create account eosio eosio.token #{CONTRACT_OWNER_PUBLIC_KEY} #{CONTRACT_ACTIVE_PUBLIC_KEY}

   # Setup for the auth setting.
   cleos create account eosio dacauthority #{CONTRACT_OWNER_PUBLIC_KEY} #{CONTRACT_ACTIVE_PUBLIC_KEY}
   cleos set account permission dacauthority active '{"threshold": 1,"keys": [{"key": "#{CONTRACT_ACTIVE_PUBLIC_KEY}","weight": 1}],"accounts": [{"permission":{"actor":"daccustodian","permission":"eosio.code"},"weight":1}]}' owner -p dacauthority

   if [[ $? != 0 ]] 
     then 
     echo "Failed to create contract account" 
     exit 1
   fi
     # eosio-cpp -o #{CONTRACT_NAME}.wast *.cpp
     if [[ $? != 0 ]] 
       then 
       echo "failed to compile contract" 
       exit 1
     fi
     cd ..
     cleos set contract #{ACCOUNT_NAME} #{CONTRACT_NAME} -p #{ACCOUNT_NAME}
     
     echo "Set up the EOS token contract"
     cd eosio.token
     # eosio-cpp -o eosio.token.wast eosio.token.cpp
     cd ..
     cleos set contract eosio.token eosio.token -p eosio.token

     cd eosdactoken/
     cleos set contract eosdactoken eosdactoken -p eosdactoken

     cleos push action eosdactoken updateconfig '["daccustodian"]' -p eosdactoken 
     cd ../#{CONTRACT_NAME}

SHELL


describe "eosdacelect" do
  before(:all) do
    `#{beforescript}`
    exit() unless $? == 0
  end

  after(:all) do
    `sleep 2; kill \`pgrep nodeos\``
  end

  describe "configure initial accounts" do
    before(:all) do
      # configure accounts for eosdactoken
      `cleos push action eosdactoken create '{ "issuer": "eosdactoken", "maximum_supply": "100000.0000 EOSDAC", "transfer_locked": false}' -p eosdactoken`
      `cleos push action eosio.token create '{ "issuer": "eosio.token", "maximum_supply": "1000000.0000 EOS"}' -p eosio.token`
      `cleos push action eosdactoken issue '{ "to": "eosdactoken", "quantity": "1000.0000 EOSDAC", "memo": "Initial amount of tokens for you."}' -p eosdactoken`
      `cleos push action eosio.token issue '{ "to": "daccustodian", "quantity": "100000.0000 EOS", "memo": "Initial EOS amount."}' -p eosio.token`

      #create users
      `cleos create account eosio testreguser1 #{TEST_OWNER_PUBLIC_KEY} #{TEST_ACTIVE_PUBLIC_KEY}`
      `cleos create account eosio testreguser2 #{TEST_OWNER_PUBLIC_KEY} #{TEST_ACTIVE_PUBLIC_KEY}`
      `cleos create account eosio testreguser3 #{TEST_OWNER_PUBLIC_KEY} #{TEST_ACTIVE_PUBLIC_KEY}`
      `cleos create account eosio testreguser4 #{TEST_OWNER_PUBLIC_KEY} #{TEST_ACTIVE_PUBLIC_KEY}`
      `cleos create account eosio testreguser5 #{TEST_OWNER_PUBLIC_KEY} #{TEST_ACTIVE_PUBLIC_KEY}`
      `cleos create account eosio testregusera #{TEST_OWNER_PUBLIC_KEY} #{TEST_ACTIVE_PUBLIC_KEY}`

      # Issue tokens to the first accounts in the token contract
      `cleos push action eosdactoken issue '{ "to": "testreguser1", "quantity": "100.0000 EOSDAC", "memo": "Initial amount."}' -p eosdactoken`
      `cleos push action eosdactoken issue '{ "to": "testreguser2", "quantity": "100.0000 EOSDAC", "memo": "Initial amount."}' -p eosdactoken`
      `cleos push action eosdactoken issue '{ "to": "testreguser3", "quantity": "100.0000 EOSDAC", "memo": "Initial amount."}' -p eosdactoken`
      `cleos push action eosdactoken issue '{ "to": "testreguser4", "quantity": "100.0000 EOSDAC", "memo": "Initial amount."}' -p eosdactoken`
      `cleos push action eosdactoken issue '{ "to": "testreguser5", "quantity": "100.0000 EOSDAC", "memo": "Initial amount."}' -p eosdactoken`
      `cleos push action eosdactoken issue '{ "to": "testregusera", "quantity": "100.0000 EOSDAC", "memo": "Initial amount."}' -p eosdactoken`


      # Ensure terms are registered in the token contract
      `cleos push action eosdactoken newmemterms '{ "terms": "normallegalterms", "hash": "New Latest terms"}' -p eosdactoken`
      # Add the founders to the memberreg table
      `cleos push action eosdactoken memberreg '{ "sender": "testreguser1", "agreedterms": "New Latest terms"}' -p testreguser1`
      # `cleos push action eosdactoken memberreg '{ "sender": "testreguser2", "agreedterms": "New Latest terms"}' -p testreguser2` # not registered
      `cleos push action eosdactoken memberreg '{ "sender": "testreguser3", "agreedterms": ""}' -p testreguser3` # empty terms
      `cleos push action eosdactoken memberreg '{ "sender": "testreguser4", "agreedterms": "oldterms"}' -p testreguser4`
      `cleos push action eosdactoken memberreg '{ "sender": "testreguser5", "agreedterms": "New Latest terms"}' -p testreguser5`
      `cleos push action eosdactoken memberreg '{ "sender": "testregusera", "agreedterms": "New Latest terms"}' -p testregusera`

    end

    it {expect(true)} # to trigger the above before all to run this is needed.
  end

  describe "updateconfig" do
    context "before being called with token contract will prevent other actions from working" do
      context "with valid and registered member" do
        command %(cleos push action daccustodian regcandidate '{ "cand": "testreguser1", "bio": "any bio", "requestedpay": "11.5000 EOS", "authaccount": "dacauthority", "auththresh": 3}' -p testreguser1), allow_error: true
        its(:stderr) {is_expected.to include('Error 3050003')}
        # its(:stderr) {is_expected.to include('no error')}
      end
    end

    context "with invalid auth" do
      command %(cleos push action daccustodian updateconfig '{ "lockupasset": "13.0000 EOSDAC", "maxvotes": 4, "periodlength": 604800 , "numelected": 12, "tokcontr": "eosdactoken", "authaccount": "dacauthority", "auththresh": 3, "initial_vote_quorum_percent": 15, "vote_quorum_percent": 10, "auth_threshold_high": 11, "auth_threshold_mid": 50, "auth_threshold_low": 15}' -p testreguser1), allow_error: true
      # its(:stdout) {is_expected.to include('daccustodian::regcandidate')}
      its(:stderr) {is_expected.to include('Error 3090004')}
    end

    context "with valid auth" do
      command %(cleos push action daccustodian updateconfig '{ "lockupasset": "10.0000 EOSDAC", "maxvotes": 5, "periodlength": 604800 , "numelected": 12, "tokcontr": "eosdactoken", "authaccount": "dacauthority", "auththresh": 3, "initial_vote_quorum_percent": 15, "vote_quorum_percent": 10, "auth_threshold_high": 11, "auth_threshold_mid": 50, "auth_threshold_low": 15}' -p daccustodian), allow_error: true
      # its(:stdout) {is_expected.to include('daccustodian::regcandidate')}
      its(:stdout) {is_expected.to include('daccustodian::updateconfig')}
    end
  end

  describe "regcandidate" do

    context "with valid and registered member after transferring insufficient staked tokens" do
      before(:all) do
        `cleos push action eosdactoken transfer '{ "from": "testreguser1", "to": "daccustodian", "quantity": "5.0000 EOSDAC","memo":"daccustodian"}' -p testreguser1 -f`
        # Verify that a transaction with an invalid account memo still is insufficient funds.
        `cleos push action eosdactoken transfer '{ "from": "testreguser1", "to": "daccustodian", "quantity": "25.0000 EOSDAC","memo":"noncaccount"}' -p testreguser1 -f`
      end
      command %(cleos push action daccustodian regcandidate '{ "cand": "testreguser1", "bio": "any bio", "requestedpay": "11.5000 EOS"}' -p testreguser1), allow_error: true
      its(:stderr) {is_expected.to include('The amount staked is insufficient by: 50000 tokens.')}
      # its(:stderr) {is_expected.to include('no error')}
    end

    context "with valid and registered member after transferring sufficient staked tokens in multiple transfers" do
      before(:all) do
        `cleos push action eosdactoken transfer '{ "from": "testreguser1", "to": "daccustodian", "quantity": "5.0000 EOSDAC","memo":"daccustodian"}' -p testreguser1 -f`
      end
      command %(cleos push action daccustodian regcandidate '{ "cand": "testreguser1", "bio": "any bio", "requestedpay": "11.5000 EOS"}' -p testreguser1), allow_error: true
      its(:stdout) {is_expected.to include('daccustodian::regcandidate')}
      # its(:stderr) {is_expected.to include('no error')}
    end

    context "with unregistered user" do
      command %(cleos push action daccustodian regcandidate '{ "cand": "testreguser2", "bio": "any bio", "requestedpay": "10.0000 EOS"}' -p testreguser2), allow_error: true
      # its(:stdout) {is_expected.to include('daccustodian::regcandidate')}
      its(:stderr) {is_expected.to include("Account is not registered with members")}
    end

    context "with user with empty agree terms" do
      command %(cleos push action daccustodian regcandidate '{ "cand": "testreguser3", "bio": "any bio", "requestedpay": "10.0000 EOS"}' -p testreguser3), allow_error: true
      # its(:stdout) {is_expected.to include('daccustodian::regcandidate')}
      its(:stderr) {is_expected.to include('Error 3050003')}
    end

    context "with user with old agreed terms" do
      command %(cleos push action daccustodian regcandidate '{ "cand": "testreguser4", "bio": "any bio", "requestedpay": "10.0000 EOS"}' -p testreguser4), allow_error: true
      # its(:stdout) {is_expected.to include('daccustodian::regcandidate')}
      its(:stderr) {is_expected.to include('Error 3050003')}
    end

    context "without first staking" do
      command %(cleos push action daccustodian regcandidate '{ "cand": "testreguser5", "bio": "any bio", "requestedpay": "10.0000 EOS"}' -p testreguser5), allow_error: true
      # its(:stdout) {is_expected.to include('daccustodian::regcandidate')}
      its(:stderr) {is_expected.to include("A registering member must first stake tokens as set by the contract's config")}
    end


    context "with user is already registered" do
      command %(cleos push action daccustodian regcandidate '{ "cand": "testreguser1", "bio": "any bio", "requestedpay": "10.0000 EOS"}' -p testreguser1), allow_error: true
      # its(:stdout) {is_expected.to include('daccustodian::regcandidate')}
      its(:stderr) {is_expected.to include('Error 3050003')}
    end

    context "Read the candidates table after regcandidate" do
      command %(cleos get table daccustodian daccustodian candidates), allow_error: true
      it do
        expect(JSON.parse(subject.stdout)).to eq JSON.parse <<~JSON
            {
              "rows": [{
                "candidate_name": "testreguser1",
                "bio": "any bio",
                "requestedpay": "11.5000 EOS",
                "locked_tokens": "10.0000 EOSDAC",
                "total_votes": 0
              }
            ],
            "more": false
          }
        JSON
      end
    end

    context "Read the pendingstake table after regcandidate and it should be empty" do
      command %(cleos get table daccustodian daccustodian pendingstake), allow_error: true
      it do
        expect(JSON.parse(subject.stdout)).to eq JSON.parse <<~JSON
            {
              "rows": [],
            "more": false
          }
        JSON
      end
    end
  end

  context "To ensure behaviours change after updateconfig" do
    context "updateconfigs with valid auth" do
      command %(cleos push action daccustodian updateconfig '{ "lockupasset": "23.0000 EOSDAC", "maxvotes": 5, "periodlength": 604800 , "numelected": 12, "tokcontr": "eosdactoken", "authaccount": "dacauthority", "auththresh": 3, "initial_vote_quorum_percent": 15, "vote_quorum_percent": 10, "auth_threshold_high": 11, "auth_threshold_mid": 50, "auth_threshold_low": 15}' -p daccustodian), allow_error: true
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

      `cleos push action eosdactoken transfer '{ "from": "unreguser2", "to": "daccustodian", "quantity": "23.0000 EOSDAC","memo":"daccustodian"}' -p unreguser2`

      `cleos push action daccustodian regcandidate '{ "cand": "unreguser2", "bio": "any bio", "requestedpay": "11.5000 EOS"}' -p unreguser2`
    end

    context "with invalid auth" do
      command %(cleos push action daccustodian unregcand '{ "cand": "unreguser3"}' -p testreguser3), allow_error: true
      # its(:stdout) {is_expected.to include('daccustodian::regcandidate')}
      its(:stderr) {is_expected.to include('Error 3090004')}
    end

    context "with valid auth but not registered" do
      command %(cleos push action daccustodian unregcand '{ "cand": "unreguser1"}' -p unreguser1), allow_error: true
      its(:stderr) {is_expected.to include('Error 3050003')}
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

      `cleos push action eosdactoken transfer '{ "from": "updatebio2", "to": "daccustodian", "quantity": "23.0000 EOSDAC","memo":"daccustodian"}' -p updatebio2`
      `cleos push action daccustodian regcandidate '{ "cand": "updatebio2", "bio": "any bio", "requestedpay": "11.5000 EOS"}' -p updatebio2`
    end

    context "with invalid auth" do
      command %(cleos push action daccustodian updatebio '{ "cand": "updatebio1", "bio": "new bio"}' -p testreguser3), allow_error: true
      # its(:stdout) {is_expected.to include('daccustodian::regcandidate')}
      its(:stderr) {is_expected.to include('Error 3090004')}
    end

    context "with valid auth but not registered" do
      command %(cleos push action daccustodian updatebio '{ "cand": "updatebio1", "bio": "new bio"}' -p updatebio1), allow_error: true
      its(:stderr) {is_expected.to include('Error 3050003')}
    end

    context "with valid auth" do
      command %(cleos push action daccustodian updatebio '{ "cand": "updatebio2", "bio": "new bio"}' -p updatebio2), allow_error: true
      its(:stdout) {is_expected.to include('daccustodian::updatebio')}
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

      `cleos push action eosdactoken transfer '{ "from": "updatepay2", "to": "daccustodian", "quantity": "23.0000 EOSDAC","memo":"daccustodian"}' -p updatepay2`

      `cleos push action daccustodian regcandidate '{ "cand": "updatepay2", "bio": "any bio", "requestedpay": "21.5000 EOS"}' -p updatepay2`
    end

    context "with invalid auth" do
      command %(cleos push action daccustodian updatereqpay '{ "cand": "updatepay1", "requestedpay": "11.5000 EOS"}' -p testreguser3), allow_error: true
      # its(:stdout) {is_expected.to include('daccustodian::regcandidate')}
      its(:stderr) {is_expected.to include('Error 3090004')}
    end

    context "with valid auth but not registered" do
      command %(cleos push action daccustodian updatereqpay '{ "cand": "updatepay1", "requestedpay": "31.5000 EOS"}' -p updatepay1), allow_error: true
      its(:stderr) {is_expected.to include('Error 3050003')}
    end

    context "with valid auth" do
      command %(cleos push action daccustodian updatereqpay '{ "cand": "updatepay2", "requestedpay": "41.5000 EOS"}' -p updatepay2), allow_error: true
      its(:stdout) {is_expected.to include('daccustodian::updatereqpay')}
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
              "requestedpay": "11.5000 EOS",
              "locked_tokens": "10.0000 EOSDAC",
              "total_votes": 0
            },{
              "candidate_name": "updatebio2",
              "bio": "new bio",
              "requestedpay": "11.5000 EOS",
              "locked_tokens": "23.0000 EOSDAC",
              "total_votes": 0
            },{
              "candidate_name": "updatepay2",
              "bio": "any bio",
              "requestedpay": "41.5000 EOS",
              "locked_tokens": "23.0000 EOSDAC",
              "total_votes": 0
            }
          ],
          "more": false
        }
      JSON
    end
  end

  describe "votedcust" do
    before(:all) do
      # configure accounts for eosdactoken

      #create users
      `cleos create account eosio votedcust1 #{TEST_OWNER_PUBLIC_KEY} #{TEST_ACTIVE_PUBLIC_KEY}`
      `cleos create account eosio votedcust2 #{TEST_OWNER_PUBLIC_KEY} #{TEST_ACTIVE_PUBLIC_KEY}`
      `cleos create account eosio votedcust3 #{TEST_OWNER_PUBLIC_KEY} #{TEST_ACTIVE_PUBLIC_KEY}`
      `cleos create account eosio votedcust4 #{TEST_OWNER_PUBLIC_KEY} #{TEST_ACTIVE_PUBLIC_KEY}`
      `cleos create account eosio votedcust5 #{TEST_OWNER_PUBLIC_KEY} #{TEST_ACTIVE_PUBLIC_KEY}`
      `cleos create account eosio votedcust11 #{TEST_OWNER_PUBLIC_KEY} #{TEST_ACTIVE_PUBLIC_KEY}`
      `cleos create account eosio unrvotecust1 #{TEST_OWNER_PUBLIC_KEY} #{TEST_ACTIVE_PUBLIC_KEY}`
      `cleos create account eosio voter1 #{TEST_OWNER_PUBLIC_KEY} #{TEST_ACTIVE_PUBLIC_KEY}`
      `cleos create account eosio unregvoter #{TEST_OWNER_PUBLIC_KEY} #{TEST_ACTIVE_PUBLIC_KEY}`

      # Issue tokens to the first accounts in the token contract
      `cleos push action eosdactoken issue '{ "to": "votedcust1", "quantity": "101.0000 EOSDAC", "memo": "Initial amount."}' -p eosdactoken`
      `cleos push action eosdactoken issue '{ "to": "votedcust2", "quantity": "102.0000 EOSDAC", "memo": "Initial amount."}' -p eosdactoken`
      `cleos push action eosdactoken issue '{ "to": "votedcust3", "quantity": "103.0000 EOSDAC", "memo": "Initial amount."}' -p eosdactoken`
      `cleos push action eosdactoken issue '{ "to": "votedcust4", "quantity": "104.0000 EOSDAC", "memo": "Initial amount."}' -p eosdactoken`
      `cleos push action eosdactoken issue '{ "to": "votedcust5", "quantity": "105.0000 EOSDAC", "memo": "Initial amount."}' -p eosdactoken`
      `cleos push action eosdactoken issue '{ "to": "votedcust11", "quantity": "106.0000 EOSDAC", "memo": "Initial amount."}' -p eosdactoken`
      `cleos push action eosdactoken issue '{ "to": "unrvotecust1", "quantity": "107.0000 EOSDAC", "memo": "Initial amount."}' -p eosdactoken`
      `cleos push action eosdactoken issue '{ "to": "voter1", "quantity": "108.0000 EOSDAC", "memo": "Initial amount."}' -p eosdactoken`
      `cleos push action eosdactoken issue '{ "to": "unregvoter", "quantity": "109.0000 EOSDAC", "memo": "Initial amount."}' -p eosdactoken`

      # Add the founders to the memberreg table
      `cleos push action eosdactoken memberreg '{ "sender": "votedcust1", "agreedterms": "New Latest terms"}' -p votedcust1`
      `cleos push action eosdactoken memberreg '{ "sender": "votedcust2", "agreedterms": "New Latest terms"}' -p votedcust2`
      `cleos push action eosdactoken memberreg '{ "sender": "votedcust3", "agreedterms": "New Latest terms"}' -p votedcust3`
      `cleos push action eosdactoken memberreg '{ "sender": "votedcust4", "agreedterms": "New Latest terms"}' -p votedcust4`
      `cleos push action eosdactoken memberreg '{ "sender": "votedcust5", "agreedterms": "New Latest terms"}' -p votedcust5`
      `cleos push action eosdactoken memberreg '{ "sender": "votedcust11", "agreedterms": "New Latest terms"}' -p votedcust11`
      # `cleos push action eosdactoken memberreg '{ "sender": "unrvotecust1", "agreedterms": "New Latest terms"}' -p unrvotecust1`
      `cleos push action eosdactoken memberreg '{ "sender": "voter1", "agreedterms": "New Latest terms"}' -p voter1`
      # `cleos push action eosdactoken memberreg '{ "sender": "unregvoter", "agreedterms": "New Latest terms"}' -p unregvoter`

      # pre-transfer staking tokens before attempting to register from within this contract.

      `cleos push action eosdactoken transfer '{ "from": "votedcust1", "to": "daccustodian", "quantity": "23.0000 EOSDAC","memo":"daccustodian"}' -p votedcust1`
      `cleos push action eosdactoken transfer '{ "from": "votedcust2", "to": "daccustodian", "quantity": "23.0000 EOSDAC","memo":"daccustodian"}' -p votedcust2`
      `cleos push action eosdactoken transfer '{ "from": "votedcust3", "to": "daccustodian", "quantity": "23.0000 EOSDAC","memo":"daccustodian"}' -p votedcust3`
      `cleos push action eosdactoken transfer '{ "from": "votedcust4", "to": "daccustodian", "quantity": "23.0000 EOSDAC","memo":"daccustodian"}' -p votedcust4`
      `cleos push action eosdactoken transfer '{ "from": "votedcust5", "to": "daccustodian", "quantity": "23.0000 EOSDAC","memo":"daccustodian"}' -p votedcust5`
      `cleos push action eosdactoken transfer '{ "from": "votedcust11", "to": "daccustodian", "quantity": "23.0000 EOSDAC","memo":"daccustodian"}' -p votedcust11`
      `cleos push action eosdactoken transfer '{ "from": "voter1", "to": "daccustodian", "quantity": "23.0000 EOSDAC","memo":"daccustodian"}' -p voter1`

      `cleos push action daccustodian regcandidate '{ "cand": "votedcust1", "bio": "any bio", "requestedpay": "11.0000 EOS"}' -p votedcust1`
      `cleos push action daccustodian regcandidate '{ "cand": "votedcust2", "bio": "any bio", "requestedpay": "12.0000 EOS"}' -p votedcust2`
      `cleos push action daccustodian regcandidate '{ "cand": "votedcust3", "bio": "any bio", "requestedpay": "13.0000 EOS"}' -p votedcust3`
      `cleos push action daccustodian regcandidate '{ "cand": "votedcust4", "bio": "any bio", "requestedpay": "14.0000 EOS"}' -p votedcust4`
      `cleos push action daccustodian regcandidate '{ "cand": "votedcust5", "bio": "any bio", "requestedpay": "15.0000 EOS"}' -p votedcust5`
      `cleos push action daccustodian regcandidate '{ "cand": "votedcust11", "bio": "any bio", "requestedpay": "16.0000 EOS"}' -p votedcust11`
      # `cleos push action daccustodian regcandidate '{ "cand": "unrvotecust1", "bio": "any bio", "requestedpay": "21.5000 EOS"}' -p unrvotecust1`
      `cleos push action daccustodian regcandidate '{ "cand": "voter1", "bio": "any bio", "requestedpay": "17.0000 EOS"}' -p voter1`
      # `cleos push action daccustodian regcandidate '{ "cand": "unregvoter", "bio": "any bio", "requestedpay": "21.5000 EOS"}' -p unregvoter`
    end

    context "with invalid auth" do
      command %(cleos push action daccustodian votecust '{ "voter": "voter1", "newvotes": ["votedcust1","votedcust2","votedcust3","votedcust4","votedcust5"]}' -p testreguser3), allow_error: true
      # its(:stdout) {is_expected.to include('daccustodian::regcandidate')}
      its(:stderr) {is_expected.to include('Error 3090004')}
    end

    context "not registered" do
      command %(cleos push action daccustodian votecust '{ "voter": "unregvoter", "newvotes": ["votedcust1","votedcust2","votedcust3","votedcust4","votedcust5"]}' -p unregvoter), allow_error: true
      its(:stderr) {is_expected.to include('Error 3050003')}
    end

    context "exceeded allowed number of votes" do
      command %(cleos push action daccustodian votecust '{ "voter": "voter1", "newvotes": ["voter1","votedcust2","votedcust3","votedcust4","votedcust5", "votedcust11"]}' -p voter1), allow_error: true
      its(:stderr) {is_expected.to include('Error 3050003')}
    end

    context "Voted for the same candidate multiple times" do
      command %(cleos push action daccustodian votecust '{ "voter": "voter1", "newvotes": ["votedcust2","votedcust3","votedcust2","votedcust5", "votedcust11"]}' -p voter1), allow_error: true
      its(:stderr) {is_expected.to include('Added duplicate votes for the same candidate')}
    end

    context "with valid auth create new vote" do
      command %(cleos push action daccustodian votecust '{ "voter": "voter1", "newvotes": ["votedcust1","votedcust2","votedcust3"]}' -p voter1), allow_error: true
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
                  "votedcust1",
                  "votedcust2",
                  "votedcust3"
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
                "requestedpay": "11.5000 EOS",
                "locked_tokens": "10.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "updatebio2",
                "bio": "new bio",
                "requestedpay": "11.5000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "updatepay2",
                "bio": "any bio",
                "requestedpay": "41.5000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "votedcust1",
                "bio": "any bio",
                "requestedpay": "11.0000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 850000
              },{
                "candidate_name": "votedcust11",
                "bio": "any bio",
                "requestedpay": "16.0000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "votedcust2",
                "bio": "any bio",
                "requestedpay": "12.0000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 850000
              },{
                "candidate_name": "votedcust3",
                "bio": "any bio",
                "requestedpay": "13.0000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 850000
              },{
                "candidate_name": "votedcust4",
                "bio": "any bio",
                "requestedpay": "14.0000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "votedcust5",
                "bio": "any bio",
                "requestedpay": "15.0000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "voter1",
                "bio": "any bio",
                "requestedpay": "17.0000 EOS",
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
      command %(cleos push action daccustodian votecust '{ "voter": "voter1", "newvotes": ["votedcust1","votedcust2","votedcust4"]}' -p voter1), allow_error: true
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
                  "votedcust1",
                  "votedcust2",
                  "votedcust4"
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
                "requestedpay": "11.5000 EOS",
                "locked_tokens": "10.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "updatebio2",
                "bio": "new bio",
                "requestedpay": "11.5000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "updatepay2",
                "bio": "any bio",
                "requestedpay": "41.5000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "votedcust1",
                "bio": "any bio",
                "requestedpay": "11.0000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 850000
              },{
                "candidate_name": "votedcust11",
                "bio": "any bio",
                "requestedpay": "16.0000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "votedcust2",
                "bio": "any bio",
                "requestedpay": "12.0000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 850000
              },{
                "candidate_name": "votedcust3",
                "bio": "any bio",
                "requestedpay": "13.0000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "votedcust4",
                "bio": "any bio",
                "requestedpay": "14.0000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 850000
              },{
                "candidate_name": "votedcust5",
                "bio": "any bio",
                "requestedpay": "15.0000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "voter1",
                "bio": "any bio",
                "requestedpay": "17.0000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              }
            ],
            "more": true
          }
        JSON
      end
    end

    context "After token transfer vote weight should update" do
      before(:all) do
        `cleos push action daccustodian votecust '{ "voter": "votedcust2", "newvotes": ["votedcust1","votedcust3","votedcust4"]}' -p votedcust2`
      end
      command %(cleos push action eosdactoken transfer '{ "from": "voter1", "to": "votedcust4", "quantity": "13.0000 EOSDAC","memo":"random transfer"}' -p voter1), allow_error: true
      # its(:stdout) {is_expected.to include('daccustodian::votecust')}
      its(:stdout) {is_expected.to include('eosdactoken::transfer')}
    end
  end

  context "Read the candidates table after transfer for voter" do
    command %(cleos get table daccustodian daccustodian candidates), allow_error: true
    it do
      expect(JSON.parse(subject.stdout)).to eq JSON.parse <<~JSON
          {
            "rows": [{
              "candidate_name": "testreguser1",
              "bio": "any bio",
              "requestedpay": "11.5000 EOS",
              "locked_tokens": "10.0000 EOSDAC",
              "total_votes": 0
            },{
              "candidate_name": "updatebio2",
              "bio": "new bio",
              "requestedpay": "11.5000 EOS",
              "locked_tokens": "23.0000 EOSDAC",
              "total_votes": 0
            },{
              "candidate_name": "updatepay2",
              "bio": "any bio",
              "requestedpay": "41.5000 EOS",
              "locked_tokens": "23.0000 EOSDAC",
              "total_votes": 0
            },{
              "candidate_name": "votedcust1",
              "bio": "any bio",
              "requestedpay": "11.0000 EOS",
              "locked_tokens": "23.0000 EOSDAC",
              "total_votes": 1510000
            },{
              "candidate_name": "votedcust11",
              "bio": "any bio",
              "requestedpay": "16.0000 EOS",
              "locked_tokens": "23.0000 EOSDAC",
              "total_votes": 0
            },{
              "candidate_name": "votedcust2",
              "bio": "any bio",
              "requestedpay": "12.0000 EOS",
              "locked_tokens": "23.0000 EOSDAC",
              "total_votes": 720000
            },{
              "candidate_name": "votedcust3",
              "bio": "any bio",
              "requestedpay": "13.0000 EOS",
              "locked_tokens": "23.0000 EOSDAC",
              "total_votes": 790000
            },{
              "candidate_name": "votedcust4",
              "bio": "any bio",
              "requestedpay": "14.0000 EOS",
              "locked_tokens": "23.0000 EOSDAC",
              "total_votes": 1510000
            },{
              "candidate_name": "votedcust5",
              "bio": "any bio",
              "requestedpay": "15.0000 EOS",
              "locked_tokens": "23.0000 EOSDAC",
              "total_votes": 0
            },{
              "candidate_name": "voter1",
              "bio": "any bio",
              "requestedpay": "17.0000 EOS",
              "locked_tokens": "23.0000 EOSDAC",
              "total_votes": 0
            }
          ],
          "more": true
        }
      JSON
    end
  end

  context "Read the custodians table after previous actions" do
    command %(cleos get table daccustodian daccustodian custodians), allow_error: true
    it do
      expect(JSON.parse(subject.stdout)).to eq JSON.parse <<~JSON
          {
            "rows": [],
          "more": false
        }
      JSON
    end
  end

  #
  #
  #
  #
  #
  #
  #
  #
  #
  #
  #
  #
  #
  #  Excluded for now.           vvvvvvvvvvvv
  #
  xdescribe "votedproxy" do
    before(:all) do
      # configure accounts for eosdactoken

      #create users
      `cleos create account eosio votedproxy1 #{TEST_OWNER_PUBLIC_KEY} #{TEST_ACTIVE_PUBLIC_KEY}`
      `cleos create account eosio votedproxy3 #{TEST_OWNER_PUBLIC_KEY} #{TEST_ACTIVE_PUBLIC_KEY}`

      # Issue tokens to the first accounts in the token contract
      `cleos push action eosdactoken issue '{ "to": "votedproxy1", "quantity": "101.0000 EOSDAC", "memo": "Initial amount."}' -p eosdactoken`
      `cleos push action eosdactoken issue '{ "to": "votedproxy3", "quantity": "101.0000 EOSDAC", "memo": "Initial amount."}' -p eosdactoken`
      `cleos push action eosdactoken issue '{ "to": "unregvoter", "quantity": "109.0000 EOSDAC", "memo": "Initial amount."}' -p eosdactoken`

      # Add the founders to the memberreg table
      `cleos push action eosdactoken memberreg '{ "sender": "votedproxy1", "agreedterms": "New Latest terms"}' -p votedproxy1`
      `cleos push action eosdactoken memberreg '{ "sender": "votedproxy3", "agreedterms": "New Latest terms"}' -p votedproxy3`
      `cleos push action eosdactoken memberreg '{ "sender": "voter1", "agreedterms": "New Latest terms"}' -p voter1`
      # `cleos push action eosdactoken memberreg '{ "sender": "unregvoter", "agreedterms": "New Latest terms"}' -p unregvoter`

      # pre-transfer for staking before registering from within the contract.
      `cleos push action eosdactoken transfer '{ "from": "votedproxy1", "to": "daccustodian", "quantity": "23.0000 EOSDAC","memo":"daccustodian"}' -p votedproxy1`

      `cleos push action daccustodian regcandidate '{ "cand": "votedproxy1", "bio": "any bio", "requestedpay": "10.0000 EOS"}' -p votedproxy1`
      # `cleos push action daccustodian regcandidate '{ "cand": "unregvoter", "bio": "any bio", "requestedpay": "21.5000 EOS"}' -p unregvoter`
    end

    context "with invalid auth" do
      command %(cleos push action daccustodian voteproxy '{ "voter": "voter1", "proxy": "votedproxy1"}' -p testreguser3), allow_error: true
      # its(:stdout) {is_expected.to include('daccustodian::regcandidate')}
      its(:stderr) {is_expected.to include('Error 3090004')}
    end

    context "not registered" do
      command %(cleos push action daccustodian voteproxy '{ "voter": "unregvoter", "proxy": "votedproxy1"}' -p unregvoter), allow_error: true
      its(:stderr) {is_expected.to include('Error 3050003')}
    end

    context "voting for self" do
      command %(cleos push action daccustodian voteproxy '{ "voter": "voter1", "proxy":"voter1"}' -p voter1), allow_error: true
      its(:stderr) {is_expected.to include('Error 3050003')}
    end

    context "with valid auth create new vote" do
      command %(cleos push action daccustodian voteproxy '{ "voter": "voter1", "proxy": "votedproxy1"}' -p voter1), allow_error: true
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
                "proxy": "votedproxy1",
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
                "requestedpay": "11.5000 EOS",
                "locked_tokens": "10.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "updatebio2",
                "bio": "new bio",
                "requestedpay": "11.5000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "updatepay2",
                "bio": "any bio",
                "requestedpay": "41.5000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "votedcust1",
                "bio": "any bio",
                "requestedpay": "11.0000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "votedcust11",
                "bio": "any bio",
                "requestedpay": "16.0000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "votedcust2",
                "bio": "any bio",
                "requestedpay": "12.0000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "votedcust3",
                "bio": "any bio",
                "requestedpay": "13.0000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "votedcust4",
                "bio": "any bio",
                "requestedpay": "14.0000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "votedcust5",
                "bio": "any bio",
                "requestedpay": "15.0000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "votedproxy1",
                "bio": "any bio",
                "requestedpay": "10.0000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "voter1",
                "bio": "any bio",
                "requestedpay": "17.0000 EOS",
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
      command %(cleos push action daccustodian voteproxy '{ "voter": "voter1", "proxy": "votedproxy3"}' -p voter1), allow_error: true
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
                "proxy": "votedproxy3",
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
                "requestedpay": "11.5000 EOS",
                "locked_tokens": "10.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "updatebio2",
                "bio": "new bio",
                "requestedpay": "11.5000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "updatepay2",
                "bio": "any bio",
                "requestedpay": "41.5000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "votedcust1",
                "bio": "any bio",
                "requestedpay": "11.0000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "votedcust11",
                "bio": "any bio",
                "requestedpay": "16.0000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "votedcust2",
                "bio": "any bio",
                "requestedpay": "12.0000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "votedcust3",
                "bio": "any bio",
                "requestedpay": "13.0000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "votedcust4",
                "bio": "any bio",
                "requestedpay": "14.0000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "votedcust5",
                "bio": "any bio",
                "requestedpay": "15.0000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "votedproxy1",
                "bio": "any bio",
                "requestedpay": "10.0000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0
              },{
                "candidate_name": "voter1",
                "bio": "any bio",
                "requestedpay": "17.0000 EOS",
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
        `cleos push action daccustodian votecust '{ "voter": "votedproxy3", "newvotes": ["votedcust1","votedcust2","votedcust3"]}' -p votedproxy3`
      end

      context "the votes table" do
        command %(cleos get table daccustodian daccustodian votes), allow_error: true
        it do
          expect(JSON.parse(subject.stdout)).to eq JSON.parse <<~JSON
              {
                "rows": [{
                  "voter": "votedproxy3",
                  "proxy": "",
                  "weight": 0,
                  "candidates": [
                    "votedcust1",
                    "votedcust2",
                    "votedcust3"
                  ]
                },{
                  "voter": "voter1",
                  "proxy": "votedproxy3",
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
                  "requestedpay": "11.5000 EOS",
                  "locked_tokens": "10.0000 EOSDAC",
                  "total_votes": 0
                },{
                  "candidate_name": "updatebio2",
                  "bio": "new bio",
                  "requestedpay": "11.5000 EOS",
                  "locked_tokens": "23.0000 EOSDAC",
                  "total_votes": 0
                },{
                  "candidate_name": "updatepay2",
                  "bio": "any bio",
                  "requestedpay": "41.5000 EOS",
                  "locked_tokens": "23.0000 EOSDAC",
                  "total_votes": 0
                },{
                  "candidate_name": "votedcust1",
                  "bio": "any bio",
                  "requestedpay": "11.0000 EOS",
                  "locked_tokens": "23.0000 EOSDAC",
                  "total_votes": 0
                },{
                  "candidate_name": "votedcust11",
                  "bio": "any bio",
                  "requestedpay": "16.0000 EOS",
                  "locked_tokens": "23.0000 EOSDAC",
                  "total_votes": 0
                },{
                  "candidate_name": "votedcust2",
                  "bio": "any bio",
                  "requestedpay": "12.0000 EOS",
                  "locked_tokens": "23.0000 EOSDAC",
                  "total_votes": 0
                },{
                  "candidate_name": "votedcust3",
                  "bio": "any bio",
                  "requestedpay": "13.0000 EOS",
                  "locked_tokens": "23.0000 EOSDAC",
                  "total_votes": 0
                },{
                  "candidate_name": "votedcust4",
                  "bio": "any bio",
                  "requestedpay": "14.0000 EOS",
                  "locked_tokens": "23.0000 EOSDAC",
                  "total_votes": 0
                },{
                  "candidate_name": "votedcust5",
                  "bio": "any bio",
                  "requestedpay": "15.0000 EOS",
                  "locked_tokens": "23.0000 EOSDAC",
                  "total_votes": 0
                },{
                  "candidate_name": "votedproxy1",
                  "bio": "any bio",
                  "requestedpay": "10.0000 EOS",
                  "locked_tokens": "23.0000 EOSDAC",
                  "total_votes": 0
                },{
                  "candidate_name": "voter1",
                  "bio": "any bio",
                  "requestedpay": "17.0000 EOS",
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
  end


  # Excluded ^^^^^^^^^^^^^^^^^^^^^^












  describe "newperiod without valid auth should fail" do
    command %(cleos push action daccustodian newperiod '{ "message": "log message",  "earlyelect": false}' -p testreguser3), allow_error: true
    # its(:stdout) {is_expected.to include('daccustodian::voteproxy')}
    its(:stderr) {is_expected.to include('Error 3090004')}
  end

  describe "newperiod before votes processing" do
    before(:all) do
      `cleos push action daccustodian votecust '{ "voter": "votedcust11", "newvotes": ["votedcust2","votedcust3","votedcust4"]}' -p votedcust11`
      `cleos set account permission #{ACCOUNT_NAME} active '{"threshold": 1,"keys": [{"key": "#{CONTRACT_ACTIVE_PUBLIC_KEY}","weight": 1}],"accounts": [{"permission":{"actor":"daccustodian","permission":"eosio.code"},"weight":1}]}' owner -p #{ACCOUNT_NAME}`
    end
    command %(cleos push action daccustodian newperiod '{ "message": "log message", "earlyelect": false}' -p daccustodian), allow_error: true
    # its(:stdout) {is_expected.to include('daccustodian::voteproxy')}
    its(:stdout) {is_expected.to include('daccustodian::newperiod')} # changed from stdout
  end

  context "the pending_pay table" do
    # Assuming that proxied voter's weight should be 0 since the weight has been delegated to proxy.
    # Also assumes that staked tokens for candidate are not used for voting power.
    command %(cleos get table daccustodian daccustodian pendingpay), allow_error: true
    it do
      expect(JSON.parse(subject.stdout)).to eq JSON.parse <<~JSON
                    {
          "rows": [
  {
    "key": 0,
    "receiver": "unreguser2",
    "quantity": "23.0000 EOSDAC",
    "memo": "Returning locked up stake. Thank you."
  },
  {
    "key": 1,
    "receiver": "votedcust4",
    "quantity": "13.0000 EOS",
    "memo": "EOSDAC Custodian pay. Thank you."
  },
  {
    "key": 2,
    "receiver": "votedcust3",
    "quantity": "13.0000 EOS",
    "memo": "EOSDAC Custodian pay. Thank you."
  },
  {
    "key": 3,
    "receiver": "votedcust2",
    "quantity": "13.0000 EOS",
    "memo": "EOSDAC Custodian pay. Thank you."
  },
  {
    "key": 4,
    "receiver": "votedcust1",
    "quantity": "13.0000 EOS",
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
          "rows": [
  {
    "voter": "votedcust11",
    "proxy": "",
    "weight": 0,
    "candidates": [
      "votedcust2",
      "votedcust3",
      "votedcust4"
    ]
  },
  {
    "voter": "votedcust2",
    "proxy": "",
    "weight": 0,
    "candidates": [
      "votedcust1",
      "votedcust3",
      "votedcust4"
    ]
  },
  {
    "voter": "voter1",
    "proxy": "",
    "weight": 0,
    "candidates": [
      "votedcust1",
      "votedcust2",
      "votedcust4"
    ]
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
              "requestedpay": "11.5000 EOS",
              "locked_tokens": "10.0000 EOSDAC",
              "total_votes": 0
            },{
              "candidate_name": "updatebio2",
              "bio": "new bio",
              "requestedpay": "11.5000 EOS",
              "locked_tokens": "23.0000 EOSDAC",
              "total_votes": 0
            },{
              "candidate_name": "updatepay2",
              "bio": "any bio",
              "requestedpay": "41.5000 EOS",
              "locked_tokens": "23.0000 EOSDAC",
              "total_votes": 0
            },{
              "candidate_name": "votedcust1",
              "bio": "any bio",
              "requestedpay": "11.0000 EOS",
              "locked_tokens": "23.0000 EOSDAC",
              "total_votes": 1510000
            },{
              "candidate_name": "votedcust11",
              "bio": "any bio",
              "requestedpay": "16.0000 EOS",
              "locked_tokens": "23.0000 EOSDAC",
              "total_votes": 0
            },{
              "candidate_name": "votedcust2",
              "bio": "any bio",
              "requestedpay": "12.0000 EOS",
              "locked_tokens": "23.0000 EOSDAC",
              "total_votes": 1550000
            },{
              "candidate_name": "votedcust3",
              "bio": "any bio",
              "requestedpay": "13.0000 EOS",
              "locked_tokens": "23.0000 EOSDAC",
              "total_votes": 1620000
            },{
              "candidate_name": "votedcust4",
              "bio": "any bio",
              "requestedpay": "14.0000 EOS",
              "locked_tokens": "23.0000 EOSDAC",
              "total_votes": 2340000
            },{
              "candidate_name": "votedcust5",
              "bio": "any bio",
              "requestedpay": "15.0000 EOS",
              "locked_tokens": "23.0000 EOSDAC",
              "total_votes": 0
            },{
              "candidate_name": "voter1",
              "bio": "any bio",
              "requestedpay": "17.0000 EOS",
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
    command %(cleos push action daccustodian newperiod '{ "message": "log message", "earlyelect": false}' -p daccustodian), allow_error: true
    # its(:stdout) {is_expected.to include('daccustodian::voteproxy')}
    its(:stdout) {is_expected.to include('daccustodian::newperiod')}
  end

  context "the pending_pay table" do
    # Assuming that proxied voter's weight should be 0 since the weight has been delegated to proxy.
    command %(cleos get table daccustodian daccustodian pendingpay), allow_error: true
    it do
      expect(JSON.parse(subject.stdout)).to eq JSON.parse <<~JSON
                    {
          "rows": [
  {
    "key": 0,
    "receiver": "unreguser2",
    "quantity": "23.0000 EOSDAC",
    "memo": "Returning locked up stake. Thank you."
  },
  {
    "key": 1,
    "receiver": "votedcust4",
    "quantity": "13.0000 EOS",
    "memo": "EOSDAC Custodian pay. Thank you."
  },
  {
    "key": 2,
    "receiver": "votedcust3",
    "quantity": "13.0000 EOS",
    "memo": "EOSDAC Custodian pay. Thank you."
  },
  {
    "key": 3,
    "receiver": "votedcust2",
    "quantity": "13.0000 EOS",
    "memo": "EOSDAC Custodian pay. Thank you."
  },
  {
    "key": 4,
    "receiver": "votedcust1",
    "quantity": "13.0000 EOS",
    "memo": "EOSDAC Custodian pay. Thank you."
  },
  {
    "key": 5,
    "receiver": "votedcust4",
    "quantity": "13.0000 EOS",
    "memo": "EOSDAC Custodian pay. Thank you."
  },
  {
    "key": 6,
    "receiver": "votedcust3",
    "quantity": "13.0000 EOS",
    "memo": "EOSDAC Custodian pay. Thank you."
  },
  {
    "key": 7,
    "receiver": "votedcust2",
    "quantity": "13.0000 EOS",
    "memo": "EOSDAC Custodian pay. Thank you."
  },
  {
    "key": 8,
    "receiver": "votedcust1",
    "quantity": "13.0000 EOS",
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
          "rows": [
  {
    "voter": "votedcust11",
    "proxy": "",
    "weight": 0,
    "candidates": [
      "votedcust2",
      "votedcust3",
      "votedcust4"
    ]
  },
  {
    "voter": "votedcust2",
    "proxy": "",
    "weight": 0,
    "candidates": [
      "votedcust1",
      "votedcust3",
      "votedcust4"
    ]
  },
  {
    "voter": "voter1",
    "proxy": "",
    "weight": 0,
    "candidates": [
      "votedcust1",
      "votedcust2",
      "votedcust4"
    ]
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
            "rows": [
  {
    "candidate_name": "testreguser1",
    "bio": "any bio",
    "requestedpay": "11.5000 EOS",
    "locked_tokens": "10.0000 EOSDAC",
    "total_votes": 0
  },
  {
    "candidate_name": "updatebio2",
    "bio": "new bio",
    "requestedpay": "11.5000 EOS",
    "locked_tokens": "23.0000 EOSDAC",
    "total_votes": 0
  },
  {
    "candidate_name": "updatepay2",
    "bio": "any bio",
    "requestedpay": "41.5000 EOS",
    "locked_tokens": "23.0000 EOSDAC",
    "total_votes": 0
  },
  {
    "candidate_name": "votedcust1",
    "bio": "any bio",
    "requestedpay": "11.0000 EOS",
    "locked_tokens": "23.0000 EOSDAC",
    "total_votes": 1510000
  },
  {
    "candidate_name": "votedcust11",
    "bio": "any bio",
    "requestedpay": "16.0000 EOS",
    "locked_tokens": "23.0000 EOSDAC",
    "total_votes": 0
  },
  {
    "candidate_name": "votedcust2",
    "bio": "any bio",
    "requestedpay": "12.0000 EOS",
    "locked_tokens": "23.0000 EOSDAC",
    "total_votes": 1550000
  },
  {
    "candidate_name": "votedcust3",
    "bio": "any bio",
    "requestedpay": "13.0000 EOS",
    "locked_tokens": "23.0000 EOSDAC",
    "total_votes": 1620000
  },
  {
    "candidate_name": "votedcust4",
    "bio": "any bio",
    "requestedpay": "14.0000 EOS",
    "locked_tokens": "23.0000 EOSDAC",
    "total_votes": 2340000
  },
  {
    "candidate_name": "votedcust5",
    "bio": "any bio",
    "requestedpay": "15.0000 EOS",
    "locked_tokens": "23.0000 EOSDAC",
    "total_votes": 0
  },
  {
    "candidate_name": "voter1",
    "bio": "any bio",
    "requestedpay": "17.0000 EOS",
    "locked_tokens": "23.0000 EOSDAC",
    "total_votes": 0
  }
]
,
            "more": false
          }


      JSON
    end
  end

  context "the custodians table" do
    command %(cleos get table daccustodian daccustodian custodians --limit 20), allow_error: true
    it do
      expect(JSON.parse(subject.stdout)).to eq JSON.parse <<~JSON
        {
          "rows": [],
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
      its(:stderr) {is_expected.to include('Error 3090004')}
    end

    context "the pending_pay table still has content" do
      # Assuming that proxied voter's weight should be 0 since the weight has been delegated to proxy.
      # Also assumes that staked tokens for candidate are not used for voting power.
      command %(cleos get table daccustodian daccustodian pendingpay), allow_error: true
      # Based on the number of elected custodians being 3 the expected quanities below should be 12.
      # There were 4 candidates
      # votedcust1 - 1860000 votes - 11 EOS
      # votedcust2 - 2690000 votes - 12 EOS
      # votedcust3 - 2690000 votes - 13 EOS
      # votedcust4 - 830000  votes - 14 EOS // will be eliminated because it has the least votes out of 4
      # --> Therefore the median amount is 12 EOS.

      it do
        expect(JSON.parse(subject.stdout)).to eq JSON.parse <<~JSON
          {
              "rows": [
  {
    "key": 0,
    "receiver": "unreguser2",
    "quantity": "23.0000 EOSDAC",
    "memo": "Returning locked up stake. Thank you."
  },
  {
    "key": 1,
    "receiver": "votedcust4",
    "quantity": "13.0000 EOS",
    "memo": "EOSDAC Custodian pay. Thank you."
  },
  {
    "key": 2,
    "receiver": "votedcust3",
    "quantity": "13.0000 EOS",
    "memo": "EOSDAC Custodian pay. Thank you."
  },
  {
    "key": 3,
    "receiver": "votedcust2",
    "quantity": "13.0000 EOS",
    "memo": "EOSDAC Custodian pay. Thank you."
  },
  {
    "key": 4,
    "receiver": "votedcust1",
    "quantity": "13.0000 EOS",
    "memo": "EOSDAC Custodian pay. Thank you."
  },
  {
    "key": 5,
    "receiver": "votedcust4",
    "quantity": "13.0000 EOS",
    "memo": "EOSDAC Custodian pay. Thank you."
  },
  {
    "key": 6,
    "receiver": "votedcust3",
    "quantity": "13.0000 EOS",
    "memo": "EOSDAC Custodian pay. Thank you."
  },
  {
    "key": 7,
    "receiver": "votedcust2",
    "quantity": "13.0000 EOS",
    "memo": "EOSDAC Custodian pay. Thank you."
  },
  {
    "key": 8,
    "receiver": "votedcust1",
    "quantity": "13.0000 EOS",
    "memo": "EOSDAC Custodian pay. Thank you."
  }
]
,
              "more": false
            }
        JSON
      end
    end

    context "the balances should not have changed" do
      # Assuming that proxied voter's weight should be 0 since the weight has been delegated to proxy.
      # Also assumes that staked tokens for candidate are not used for voting power.
      command %(cleos get currency balance eosdactoken votedcust2 EOSDAC), allow_error: true
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

  context "the balances should updated to 102 - 23 = 79" do
    # Assuming that proxied voter's weight should be 0 since the weight has been delegated to proxy.
    # Also assumes that staked tokens for candidate are not used for voting power.
    command %(cleos get currency balance eosdactoken votedcust2 EOSDAC), allow_error: true
    its(:stdout) {is_expected.to include('79.0000 EOSDAC')}
  end
end


