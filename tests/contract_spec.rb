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

def install_contracts

  beforescript = <<~SHELL
   set -x
   kill -INT `pgrep nodeos`

  ttab 'nodeos --delete-all-blocks --verbose-http-errors'

   # kill -INT `pgrep nodeos`
    # nodeos --delete-all-blocks --verbose-http-errors &>/dev/null &
    sleep 4
   cleos wallet unlock --password `cat ~/eosio-wallet/.pass`
   cleos wallet import --private-key #{CONTRACT_ACTIVE_PRIVATE_KEY}
   cleos wallet import --private-key #{TEST_ACTIVE_PRIVATE_KEY}
   cleos wallet import --private-key #{TEST_OWNER_PRIVATE_KEY}
   cleos create account eosio #{ACCOUNT_NAME} #{CONTRACT_OWNER_PUBLIC_KEY} #{CONTRACT_ACTIVE_PUBLIC_KEY}
   cleos create account eosio eosdactoken #{CONTRACT_OWNER_PUBLIC_KEY} #{CONTRACT_ACTIVE_PUBLIC_KEY}
   cleos create account eosio eosio.token #{CONTRACT_OWNER_PUBLIC_KEY} #{CONTRACT_ACTIVE_PUBLIC_KEY}

   # Setup for the auth setting.
   cleos create account eosio dacauthority #{CONTRACT_OWNER_PUBLIC_KEY} #{CONTRACT_ACTIVE_PUBLIC_KEY}
   cleos set account permission dacauthority owner '{"threshold": 1,"keys": [{"key": "#{CONTRACT_ACTIVE_PUBLIC_KEY}","weight": 1}],"accounts": [{"permission":{"actor":"daccustodian","permission":"eosio.code"},"weight":1}]}' '' -p dacauthority@owner
   cleos set account permission #{ACCOUNT_NAME} active '{"threshold": 1,"keys": [{"key": "#{CONTRACT_ACTIVE_PUBLIC_KEY}","weight": 1}],"accounts": [{"permission":{"actor":"daccustodian","permission":"eosio.code"},"weight":1}]}' owner -p #{ACCOUNT_NAME}

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
  `#{beforescript}`
  exit() unless $? == 0
end

def killchain
  `sleep 0.5; kill \`pgrep nodeos\``
end

def seed_account(name, issue: nil, memberreg: nil, stake: nil, requestedpay: nil)
  `cleos create account eosio #{name} #{TEST_OWNER_PUBLIC_KEY} #{TEST_ACTIVE_PUBLIC_KEY}`

  unless issue.nil?
    `cleos push action eosdactoken issue '{ "to": "#{name}", "quantity": "#{issue}", "memo": "Initial amount."}' -p eosdactoken`
    puts("Issue to #{name}")
  end

  unless memberreg.nil?
    `cleos push action eosdactoken memberreg '{ "sender": "#{name}", "agreedterms": "#{memberreg}"}' -p #{name}`
    puts("memberreg #{memberreg}")
  end

  unless stake.nil?
    `cleos push action eosdactoken transfer '{ "from": "#{name}", "to": "daccustodian", "quantity": "#{stake}","memo":"daccustodian"}' -p #{name}`
    puts("regcandidate #{name}")
  end

  unless requestedpay.nil?
    `cleos push action daccustodian regcandidate '{ "cand": "#{name}", "bio": "any bio", "requestedpay": "#{requestedpay}"}' -p #{name}`
    puts("regcandidate #{name}")
  end
end

def configure_contracts
  # configure accounts for eosdactoken
  `cleos push action eosdactoken create '{ "issuer": "eosdactoken", "maximum_supply": "100000.0000 EOSDAC", "transfer_locked": false}' -p eosdactoken`
  `cleos push action eosio.token create '{ "issuer": "eosio.token", "maximum_supply": "1000000.0000 EOS"}' -p eosio.token`
  `cleos push action eosdactoken issue '{ "to": "eosdactoken", "quantity": "1000.0000 EOSDAC", "memo": "Initial amount of tokens for you."}' -p eosdactoken`
  `cleos push action eosio.token issue '{ "to": "daccustodian", "quantity": "100000.0000 EOS", "memo": "Initial EOS amount."}' -p eosio.token`

  #create users
  # Ensure terms are registered in the token contract
  `cleos push action eosdactoken newmemterms '{ "terms": "normallegalterms", "hash": "New Latest terms"}' -p eosdactoken`

  #create users
  seed_account("testreguser1", issue: "100.0000 EOSDAC", memberreg: "New Latest terms")
  seed_account("testreguser2", issue: "100.0000 EOSDAC")
  seed_account("testreguser3", issue: "100.0000 EOSDAC", memberreg: "")
  seed_account("testreguser4", issue: "100.0000 EOSDAC", memberreg: "old terms")
  seed_account("testreguser5", issue: "100.0000 EOSDAC", memberreg: "New Latest terms")
  seed_account("testregusera", issue: "100.0000 EOSDAC", memberreg: "New Latest terms")
end

describe "eosdacelect" do
  before(:all) do
    install_contracts
    configure_contracts
  end

  after(:all) do
    killchain
  end

  describe "updateconfig" do
    context "before being called with token contract will prevent other actions from working" do
      context "with valid and registered member" do
        command %(cleos push action daccustodian regcandidate '{ "cand": "testreguser1", "bio": "any bio", "requestedpay": "11.5000 EOS", "authaccount": "dacauthority", "auththresh": 3}' -p testreguser1), allow_error: true
        its(:stderr) {is_expected.to include('Error 3050003')}
      end
    end

    context "with invalid auth" do
      command %(cleos push action daccustodian updateconfig '{ "lockupasset": "13.0000 EOSDAC", "maxvotes": 4, "periodlength": 604800 , "numelected": 12, "tokcontr": "eosdactoken", "authaccount": "dacauthority", "auththresh": 3, "initial_vote_quorum_percent": 15, "vote_quorum_percent": 10, "auth_threshold_high": 11, "auth_threshold_mid": 7, "auth_threshold_low": 3}' -p testreguser1), allow_error: true
      its(:stderr) {is_expected.to include('Error 3090004')}
    end

    context "with valid auth" do
      command %(cleos push action daccustodian updateconfig '{ "lockupasset": "10.0000 EOSDAC", "maxvotes": 5, "periodlength": 604800 , "numelected": 12, "tokcontr": "eosdactoken", "authaccount": "dacauthority", "auththresh": 3, "initial_vote_quorum_percent": 15, "vote_quorum_percent": 10, "auth_threshold_high": 11, "auth_threshold_mid": 7, "auth_threshold_low": 3}' -p daccustodian), allow_error: true
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
    end

    context "with valid and registered member after transferring sufficient staked tokens in multiple transfers" do
      before(:all) do
        `cleos push action eosdactoken transfer '{ "from": "testreguser1", "to": "daccustodian", "quantity": "5.0000 EOSDAC","memo":"daccustodian"}' -p testreguser1 -f`
      end
      command %(cleos push action daccustodian regcandidate '{ "cand": "testreguser1", "bio": "any bio", "requestedpay": "11.5000 EOS"}' -p testreguser1), allow_error: true
      its(:stdout) {is_expected.to include('daccustodian::regcandidate')}
    end

    context "with unregistered user" do
      command %(cleos push action daccustodian regcandidate '{ "cand": "testreguser2", "bio": "any bio", "requestedpay": "10.0000 EOS"}' -p testreguser2), allow_error: true
      its(:stderr) {is_expected.to include("Account is not registered with members")}
    end

    context "with user with empty agree terms" do
      command %(cleos push action daccustodian regcandidate '{ "cand": "testreguser3", "bio": "any bio", "requestedpay": "10.0000 EOS"}' -p testreguser3), allow_error: true
      its(:stderr) {is_expected.to include('Error 3050003')}
    end

    context "with user with old agreed terms" do
      command %(cleos push action daccustodian regcandidate '{ "cand": "testreguser4", "bio": "any bio", "requestedpay": "10.0000 EOS"}' -p testreguser4), allow_error: true
      its(:stderr) {is_expected.to include('Error 3050003')}
    end

    context "without first staking" do
      command %(cleos push action daccustodian regcandidate '{ "cand": "testreguser5", "bio": "any bio", "requestedpay": "10.0000 EOS"}' -p testreguser5), allow_error: true
      its(:stderr) {is_expected.to include("A registering member must first stake tokens as set by the contract's config")}
    end


    context "with user is already registered" do
      command %(cleos push action daccustodian regcandidate '{ "cand": "testreguser1", "bio": "any bio", "requestedpay": "10.0000 EOS"}' -p testreguser1), allow_error: true
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
                "total_votes": 0,
                "is_active": 1

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
      command %(cleos push action daccustodian updateconfig '{ "lockupasset": "23.0000 EOSDAC", "maxvotes": 5, "periodlength": 604800 , "numelected": 12, "tokcontr": "eosdactoken", "authaccount": "dacauthority", "auththresh": 3, "initial_vote_quorum_percent": 15, "vote_quorum_percent": 10, "auth_threshold_high": 11, "auth_threshold_mid": 7, "auth_threshold_low": 3}' -p daccustodian), allow_error: true
      its(:stdout) {is_expected.to include('daccustodian::updateconfig')}
    end
  end

  describe "unregcand" do
    before(:all) do
      seed_account("unreguser1", issue: "100.0000 EOSDAC", memberreg: "New Latest terms")
      seed_account("unreguser2", issue: "100.0000 EOSDAC", memberreg: "New Latest terms", stake: "23.0000 EOSDAC", requestedpay: "11.5000 EOS")
    end

    context "with invalid auth" do
      command %(cleos push action daccustodian unregcand '{ "cand": "unreguser3"}' -p testreguser3), allow_error: true
      its(:stderr) {is_expected.to include('Error 3090004')}
    end

    context "with valid auth but not registered" do
      command %(cleos push action daccustodian unregcand '{ "cand": "unreguser1"}' -p unreguser1), allow_error: true
      its(:stderr) {is_expected.to include('Error 3050003')}
    end

    context "with valid auth" do

      command %(cleos push action daccustodian unregcand '{ "cand": "unreguser2"}' -p unreguser2), allow_error: true
      its(:stdout) {is_expected.to include('daccustodian::unregcand')}
    end
  end

  describe "update bio" do
    before(:all) do
      seed_account("updatebio1", issue: "100.0000 EOSDAC", memberreg: "New Latest terms")
      seed_account("updatebio2", issue: "100.0000 EOSDAC", memberreg: "New Latest terms", stake: "23.0000 EOSDAC", requestedpay: "11.5000 EOS")
    end

    context "with invalid auth" do
      command %(cleos push action daccustodian updatebio '{ "cand": "updatebio1", "bio": "new bio"}' -p testreguser3), allow_error: true
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
      seed_account("updatepay1", issue: "100.0000 EOSDAC", memberreg: "New Latest terms")
      seed_account("updatepay2", issue: "100.0000 EOSDAC", memberreg: "New Latest terms", stake: "23.0000 EOSDAC", requestedpay: "21.5000 EOS")
    end

    context "with invalid auth" do
      command %(cleos push action daccustodian updatereqpay '{ "cand": "updatepay1", "requestedpay": "11.5000 EOS"}' -p testreguser3), allow_error: true
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
              "total_votes": 0,
              "is_active": 1

            },{
              "candidate_name": "unreguser2",
              "bio": "any bio",
              "requestedpay": "11.5000 EOS",
              "locked_tokens": "0.0000 EOSDAC",
              "total_votes": 0,
              "is_active": 0

            },{
              "candidate_name": "updatebio2",
              "bio": "new bio",
              "requestedpay": "11.5000 EOS",
              "locked_tokens": "23.0000 EOSDAC",
              "total_votes": 0,
              "is_active": 1

            },{
              "candidate_name": "updatepay2",
              "bio": "any bio",
              "requestedpay": "41.5000 EOS",
              "locked_tokens": "23.0000 EOSDAC",
              "total_votes": 0,
              "is_active": 1
            }
          ],
          "more": false
        }
        JSON
      end
    end
  end

  describe "votedcust" do
    before(:all) do

      #create users

      seed_account("votedcust1", issue: "101.0000 EOSDAC", memberreg: "New Latest terms", stake: "23.0000 EOSDAC", requestedpay: "11.0000 EOS")
      seed_account("votedcust2", issue: "102.0000 EOSDAC", memberreg: "New Latest terms", stake: "23.0000 EOSDAC", requestedpay: "12.0000 EOS")
      seed_account("votedcust3", issue: "103.0000 EOSDAC", memberreg: "New Latest terms", stake: "23.0000 EOSDAC", requestedpay: "13.0000 EOS")
      seed_account("votedcust4", issue: "104.0000 EOSDAC", memberreg: "New Latest terms", stake: "23.0000 EOSDAC", requestedpay: "14.0000 EOS")
      seed_account("votedcust5", issue: "105.0000 EOSDAC", memberreg: "New Latest terms", stake: "23.0000 EOSDAC", requestedpay: "15.0000 EOS")
      seed_account("votedcust11", issue: "106.0000 EOSDAC", memberreg: "New Latest terms", stake: "23.0000 EOSDAC", requestedpay: "16.0000 EOS")
      seed_account("voter1", issue: "85.0000 EOSDAC", memberreg: "New Latest terms")
      seed_account("voter2", issue: "108.0000 EOSDAC", memberreg: "New Latest terms")
      seed_account("unregvoter", issue: "109.0000 EOSDAC")
    end

    context "with invalid auth" do
      command %(cleos push action daccustodian votecust '{ "voter": "voter1", "newvotes": ["votedcust1","votedcust2","votedcust3","votedcust4","votedcust5"]}' -p testreguser3), allow_error: true
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

    context "Voted for an inactive candidate" do
      command %(cleos push action daccustodian votecust '{ "voter": "voter1", "newvotes": ["votedcust1","unreguser2","votedcust2","votedcust5", "votedcust11"]}' -p voter1), allow_error: true
      its(:stderr) {is_expected.to include('Attempting to vote for an inactive candidate.')}
    end

    context "Voted for an candidate not in the list of candidates" do
      command %(cleos push action daccustodian votecust '{ "voter": "voter1", "newvotes": ["votedcust1","testreguser5","votedcust2","votedcust5", "votedcust11"]}' -p voter1), allow_error: true
      its(:stderr) {is_expected.to include('candidate could not be found')}
    end

    context "with valid auth create new vote" do
      command %(cleos push action daccustodian votecust '{ "voter": "voter1", "newvotes": ["votedcust1","votedcust2","votedcust3"]}' -p voter1), allow_error: true
      its(:stdout) {is_expected.to include('daccustodian::votecust')}
    end

    context "Read the votes table after _create_ vote" do
      before(:all) do
        `cleos push action daccustodian votecust '{ "voter": "voter2", "newvotes": ["votedcust1","votedcust2","votedcust3"]}' -p voter2`
      end
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
              }, {
                "voter": "voter2",
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

    context "Read the state table after placed votes" do
      before(:all) do
        # `cleos push action daccustodian votecust '{ "voter": "voter2", "newvotes": ["votedcust1","votedcust2","votedcust3"]}' -p voter2`
      end
      command %(cleos get table daccustodian daccustodian state), allow_error: true
      it do
        expect(JSON.parse(subject.stdout)).to eq JSON.parse <<~JSON
            {
              "rows": [
  {
    "lastperiodtime": 0,
    "total_weight_of_votes": 1930000,
    "total_votes_on_candidates": 5790000,
    "number_active_candidates": 9,
    "met_initial_votes_threshold": 0
  }
],
            "more": false
          }
        JSON
      end
    end

    context "with valid auth to clear a vote" do
      command %(cleos push action daccustodian votecust '{ "voter": "voter2", "newvotes": []}' -p voter2), allow_error: true
      its(:stdout) {is_expected.to include('daccustodian::votecust')}
    end

    context "Read the votes table after clearing a vote" do

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
                "total_votes": 0,
                "is_active": 1
              },{
                "candidate_name": "unreguser2",
                "bio": "any bio",
                "requestedpay": "11.5000 EOS",
                "locked_tokens": "0.0000 EOSDAC",
                "total_votes": 0,
                "is_active": 0
              },{
                "candidate_name": "updatebio2",
                "bio": "new bio",
                "requestedpay": "11.5000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0,
                "is_active": 1
              },{
                "candidate_name": "updatepay2",
                "bio": "any bio",
                "requestedpay": "41.5000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0,
                "is_active": 1
              },{
                "candidate_name": "votedcust1",
                "bio": "any bio",
                "requestedpay": "11.0000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 850000,
                "is_active": 1
              },{
                "candidate_name": "votedcust11",
                "bio": "any bio",
                "requestedpay": "16.0000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0,
                "is_active": 1
              },{
                "candidate_name": "votedcust2",
                "bio": "any bio",
                "requestedpay": "12.0000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 850000,
                "is_active": 1
              },{
                "candidate_name": "votedcust3",
                "bio": "any bio",
                "requestedpay": "13.0000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 850000,
                "is_active": 1
              },{
                "candidate_name": "votedcust4",
                "bio": "any bio",
                "requestedpay": "14.0000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0,
                "is_active": 1
              },{
                "candidate_name": "votedcust5",
                "bio": "any bio",
                "requestedpay": "15.0000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0,
                "is_active": 1
              }
            ],
            "more": true
          }

        JSON
      end
    end

    context "with valid auth change existing vote" do
      command %(cleos push action daccustodian votecust '{ "voter": "voter1", "newvotes": ["votedcust1","votedcust2","votedcust4"]}' -p voter1), allow_error: true
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
                "total_votes": 0,
                "is_active": 1
              },{
                "candidate_name": "unreguser2",
                "bio": "any bio",
                "requestedpay": "11.5000 EOS",
                "locked_tokens": "0.0000 EOSDAC",
                "total_votes": 0,
                "is_active": 0
              },{
                "candidate_name": "updatebio2",
                "bio": "new bio",
                "requestedpay": "11.5000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0,
                "is_active": 1
              },{
                "candidate_name": "updatepay2",
                "bio": "any bio",
                "requestedpay": "41.5000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0,
                "is_active": 1
              },{
                "candidate_name": "votedcust1",
                "bio": "any bio",
                "requestedpay": "11.0000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 850000,
                "is_active": 1
              },{
                "candidate_name": "votedcust11",
                "bio": "any bio",
                "requestedpay": "16.0000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0,
                "is_active": 1
              },{
                "candidate_name": "votedcust2",
                "bio": "any bio",
                "requestedpay": "12.0000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 850000,
                "is_active": 1
              },{
                "candidate_name": "votedcust3",
                "bio": "any bio",
                "requestedpay": "13.0000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0,
                "is_active": 1
              },{
                "candidate_name": "votedcust4",
                "bio": "any bio",
                "requestedpay": "14.0000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 850000,
                "is_active": 1
              },{
                "candidate_name": "votedcust5",
                "bio": "any bio",
                "requestedpay": "15.0000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0,
                "is_active": 1
              }
            ],
            "more": true
          }
        JSON
      end
    end

    context "After token transfer vote weight should move to different candidates" do
      before(:all) do
        `cleos push action daccustodian votecust '{ "voter": "votedcust2", "newvotes": ["votedcust1","votedcust3","votedcust4"]}' -p votedcust2`
      end
      command %(cleos push action eosdactoken transfer '{ "from": "voter1", "to": "votedcust4", "quantity": "13.0000 EOSDAC","memo":"random transfer"}' -p voter1), allow_error: true
      its(:stdout) {is_expected.to include('eosdactoken::transfer')}
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
              "total_votes": 0,
                "is_active": 1
            },{
              "candidate_name": "unreguser2",
              "bio": "any bio",
              "requestedpay": "11.5000 EOS",
              "locked_tokens": "0.0000 EOSDAC",
              "total_votes": 0,
                "is_active": 0
            },{
              "candidate_name": "updatebio2",
              "bio": "new bio",
              "requestedpay": "11.5000 EOS",
              "locked_tokens": "23.0000 EOSDAC",
              "total_votes": 0,
                "is_active": 1
            },{
              "candidate_name": "updatepay2",
              "bio": "any bio",
              "requestedpay": "41.5000 EOS",
              "locked_tokens": "23.0000 EOSDAC",
              "total_votes": 0,
                "is_active": 1
            },{
              "candidate_name": "votedcust1",
              "bio": "any bio",
              "requestedpay": "11.0000 EOS",
              "locked_tokens": "23.0000 EOSDAC",
              "total_votes": 1510000,
                "is_active": 1
            },{
              "candidate_name": "votedcust11",
              "bio": "any bio",
              "requestedpay": "16.0000 EOS",
              "locked_tokens": "23.0000 EOSDAC",
              "total_votes": 0,
                "is_active": 1
            },{
              "candidate_name": "votedcust2",
              "bio": "any bio",
              "requestedpay": "12.0000 EOS",
              "locked_tokens": "23.0000 EOSDAC",
              "total_votes": 720000,
                "is_active": 1
            },{
              "candidate_name": "votedcust3",
              "bio": "any bio",
              "requestedpay": "13.0000 EOS",
              "locked_tokens": "23.0000 EOSDAC",
              "total_votes": 790000,
                "is_active": 1
            },{
              "candidate_name": "votedcust4",
              "bio": "any bio",
              "requestedpay": "14.0000 EOS",
              "locked_tokens": "23.0000 EOSDAC",
              "total_votes": 1510000,
                "is_active": 1
            },{
              "candidate_name": "votedcust5",
              "bio": "any bio",
              "requestedpay": "15.0000 EOS",
              "locked_tokens": "23.0000 EOSDAC",
              "total_votes": 0,
                "is_active": 1
            }
          ],
          "more": true
        }
        JSON
      end
    end

    context "Before new period has been called the custodians table should be empty" do
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
                "total_votes": 0,
                "is_active": 1
              },{
                "candidate_name": "unreguser2",
                "bio": "any bio",
                "requestedpay": "11.5000 EOS",
                "locked_tokens": "0.0000 EOSDAC",
                "total_votes": 0,
                "is_active": 0
              },{
                "candidate_name": "updatebio2",
                "bio": "new bio",
                "requestedpay": "11.5000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0,
                "is_active": 1
              },{
                "candidate_name": "updatepay2",
                "bio": "any bio",
                "requestedpay": "41.5000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0,
                "is_active": 1
              },{
                "candidate_name": "votedcust1",
                "bio": "any bio",
                "requestedpay": "11.0000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0,
                "is_active": 1
              },{
                "candidate_name": "votedcust11",
                "bio": "any bio",
                "requestedpay": "16.0000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0,
                "is_active": 1
              },{
                "candidate_name": "votedcust2",
                "bio": "any bio",
                "requestedpay": "12.0000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0,
                "is_active": 1
              },{
                "candidate_name": "votedcust3",
                "bio": "any bio",
                "requestedpay": "13.0000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0,
                "is_active": 1
              },{
                "candidate_name": "votedcust4",
                "bio": "any bio",
                "requestedpay": "14.0000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0,
                "is_active": 1
              },{
                "candidate_name": "votedcust5",
                "bio": "any bio",
                "requestedpay": "15.0000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0,
                "is_active": 1
              },{
                "candidate_name": "votedproxy1",
                "bio": "any bio",
                "requestedpay": "10.0000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0,
                "is_active": 1
              }
            ],
            "more": false
          }

        JSON
      end
    end

    context "with valid auth change existing vote" do
      command %(cleos push action daccustodian voteproxy '{ "voter": "voter1", "proxy": "votedproxy3"}' -p voter1), allow_error: true
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
                "total_votes": 0,
                "is_active": 1
              },{
                "candidate_name": "unreguser2",
                "bio": "any bio",
                "requestedpay": "11.5000 EOS",
                "locked_tokens": "0.0000 EOSDAC",
                "total_votes": 0,
                "is_active": 0
              },{
                "candidate_name": "updatebio2",
                "bio": "new bio",
                "requestedpay": "11.5000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0,
                "is_active": 1
              },{
                "candidate_name": "updatepay2",
                "bio": "any bio",
                "requestedpay": "41.5000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0,
                "is_active": 1
              },{
                "candidate_name": "votedcust1",
                "bio": "any bio",
                "requestedpay": "11.0000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0,
                "is_active": 1
              },{
                "candidate_name": "votedcust11",
                "bio": "any bio",
                "requestedpay": "16.0000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0,
                "is_active": 1
              },{
                "candidate_name": "votedcust2",
                "bio": "any bio",
                "requestedpay": "12.0000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0,
                "is_active": 1
              },{
                "candidate_name": "votedcust3",
                "bio": "any bio",
                "requestedpay": "13.0000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0,
                "is_active": 1
              },{
                "candidate_name": "votedcust4",
                "bio": "any bio",
                "requestedpay": "14.0000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0,
                "is_active": 1
              },{
                "candidate_name": "votedcust5",
                "bio": "any bio",
                "requestedpay": "15.0000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0,
                "is_active": 1
              },{
                "candidate_name": "votedproxy1",
                "bio": "any bio",
                "requestedpay": "10.0000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0,
                "is_active": 1
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
                  "total_votes": 0,
                "is_active": 1
                },{
                  "candidate_name": "unreguser2",
                  "bio": "any bio",
                  "requestedpay": "11.5000 EOS",
                  "locked_tokens": "0.0000 EOSDAC",
                  "total_votes": 0,
                "is_active": 0
                },{
                  "candidate_name": "updatebio2",
                  "bio": "new bio",
                  "requestedpay": "11.5000 EOS",
                  "locked_tokens": "23.0000 EOSDAC",
                  "total_votes": 0,
                "is_active": 1
                },{
                  "candidate_name": "updatepay2",
                  "bio": "any bio",
                  "requestedpay": "41.5000 EOS",
                  "locked_tokens": "23.0000 EOSDAC",
                  "total_votes": 0,
                "is_active": 1
                },{
                  "candidate_name": "votedcust1",
                  "bio": "any bio",
                  "requestedpay": "11.0000 EOS",
                  "locked_tokens": "23.0000 EOSDAC",
                  "total_votes": 0,
                "is_active": 1
                },{
                  "candidate_name": "votedcust11",
                  "bio": "any bio",
                  "requestedpay": "16.0000 EOS",
                  "locked_tokens": "23.0000 EOSDAC",
                  "total_votes": 0,
                "is_active": 1
                },{
                  "candidate_name": "votedcust2",
                  "bio": "any bio",
                  "requestedpay": "12.0000 EOS",
                  "locked_tokens": "23.0000 EOSDAC",
                  "total_votes": 0,
                "is_active": 1
                },{
                  "candidate_name": "votedcust3",
                  "bio": "any bio",
                  "requestedpay": "13.0000 EOS",
                  "locked_tokens": "23.0000 EOSDAC",
                  "total_votes": 0,
                "is_active": 1
                },{
                  "candidate_name": "votedcust4",
                  "bio": "any bio",
                  "requestedpay": "14.0000 EOS",
                  "locked_tokens": "23.0000 EOSDAC",
                  "total_votes": 0,
                "is_active": 1
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
                  "total_votes": 0,
                "is_active": 1
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

  describe "newperiod" do

    describe "with valid auth should succeed" do
      command %(cleos push action daccustodian newperiod '{ "message": "log message", "earlyelect": false}' -p daccustodian), allow_error: true
      its(:stdout) {is_expected.to include('daccustodian::newperiod')} # changed from stdout
    end

    describe "called too early in the period should fail after recent newperiod call" do
      command %(cleos push action daccustodian newperiod '{ "message": "called too early", "earlyelect": false}' -p daccustodian), allow_error: true
      its(:stderr) {is_expected.to include('New period is being called too soon. Wait until the period has complete')}
    end

    describe "called after period time has passed" do
      before(:all) do
        `cleos push action daccustodian updateconfig '{ "lockupasset": "10.0000 EOSDAC", "maxvotes": 5, "periodlength": 1, "numelected": 12, "tokcontr": "eosdactoken", "authaccount": "dacauthority", "auththresh": 3, "initial_vote_quorum_percent": 15, "vote_quorum_percent": 10, "auth_threshold_high": 11, "auth_threshold_mid": 7, "auth_threshold_low": 3}' -p daccustodian`
        sleep 2
      end
      command %(cleos push action daccustodian newperiod '{ "message": "Good new period call after config change", "earlyelect": false}' -p daccustodian), allow_error: true
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
		"key": 0,
		"receiver": "votedcust4",
		"quantity": "13.0000 EOS",
		"memo": "EOSDAC Custodian pay. Thank you."
	},
	{
		"key": 1,
		"receiver": "votedcust1",
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
		"receiver": "votedcust4",
		"quantity": "13.0000 EOS",
		"memo": "EOSDAC Custodian pay. Thank you."
	},
	{
		"key": 5,
		"receiver": "votedcust1",
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
    "total_votes": 0,
     "is_active": 1
  },{
    "candidate_name": "unreguser2",
    "bio": "any bio",
    "requestedpay": "11.5000 EOS",
    "locked_tokens": "0.0000 EOSDAC",
    "total_votes": 0,
     "is_active": 0
  },
  {
    "candidate_name": "updatebio2",
    "bio": "new bio",
    "requestedpay": "11.5000 EOS",
    "locked_tokens": "23.0000 EOSDAC",
    "total_votes": 0,
     "is_active": 1
  },
  {
    "candidate_name": "updatepay2",
    "bio": "any bio",
    "requestedpay": "41.5000 EOS",
    "locked_tokens": "23.0000 EOSDAC",
    "total_votes": 0,
     "is_active": 1
  },
  {
    "candidate_name": "votedcust1",
    "bio": "any bio",
    "requestedpay": "11.0000 EOS",
    "locked_tokens": "23.0000 EOSDAC",
    "total_votes": 1510000,
     "is_active": 1
  },
  {
    "candidate_name": "votedcust11",
    "bio": "any bio",
    "requestedpay": "16.0000 EOS",
    "locked_tokens": "23.0000 EOSDAC",
    "total_votes": 0,
     "is_active": 1
  },
  {
    "candidate_name": "votedcust2",
    "bio": "any bio",
    "requestedpay": "12.0000 EOS",
    "locked_tokens": "23.0000 EOSDAC",
    "total_votes": 720000,
     "is_active": 1
  },
  {
    "candidate_name": "votedcust3",
    "bio": "any bio",
    "requestedpay": "13.0000 EOS",
    "locked_tokens": "23.0000 EOSDAC",
    "total_votes": 790000,
     "is_active": 1
  },
  {
    "candidate_name": "votedcust4",
    "bio": "any bio",
    "requestedpay": "14.0000 EOS",
    "locked_tokens": "23.0000 EOSDAC",
    "total_votes": 1510000,
     "is_active": 1
  },
  {
    "candidate_name": "votedcust5",
    "bio": "any bio",
    "requestedpay": "15.0000 EOS",
    "locked_tokens": "23.0000 EOSDAC",
    "total_votes": 0,
     "is_active": 1
  }
],
          "more": false
        }

        JSON
      end
    end
  end

  context "the custodians table" do
    command %(cleos get table daccustodian daccustodian custodians --limit 20), allow_error: true
    it do
      expect(JSON.parse(subject.stdout)).to eq JSON.parse <<~JSON
        {
          "rows": [
  {
    "cust_name": "votedcust1",
    "bio": "any bio",
    "requestedpay": "11.0000 EOS",
    "total_votes": 1510000
  },
  {
    "cust_name": "votedcust2",
    "bio": "any bio",
    "requestedpay": "12.0000 EOS",
    "total_votes": 720000
  },
  {
    "cust_name": "votedcust3",
    "bio": "any bio",
    "requestedpay": "13.0000 EOS",
    "total_votes": 790000
  },
  {
    "cust_name": "votedcust4",
    "bio": "any bio",
    "requestedpay": "14.0000 EOS",
    "total_votes": 1510000
  }
],
          "more": false
        }

      JSON
    end
  end

  describe "claimpay" do
    context "with invalid payId should fail" do
      command %(cleos push action daccustodian claimpay '{ "claimer": "votedcust4", "payid": 10}' -p votedcust4), allow_error: true
      its(:stderr) {is_expected.to include('Invalid pay claim id')}
    end

    context "claiming for a different acount should fail" do
      command %(cleos push action daccustodian claimpay '{ "claimer": "votedcust4", "payid": 10}' -p voter1), allow_error: true
      its(:stderr) {is_expected.to include('missing authority of votedcust4')}
    end

    context "Before claiming pay the balance should 0" do
      command %(cleos get currency balance eosio.token votedcust4 EOS), allow_error: true
      its(:stdout) {is_expected.to eq('')}
    end

    context "claiming for the correct account with matching auth should succeed" do
      command %(cleos push action daccustodian claimpay '{ "claimer": "votedcust4", "payid": 0}' -p votedcust4), allow_error: true
      its(:stdout) {is_expected.to include('daccustodian::claimpay')}
      # exit
    end

    context "After claiming for the correct should be added to the claimer" do
      command %(cleos get currency balance eosio.token votedcust4 EOS), allow_error: true
      its(:stdout) {is_expected.to include('13.0000 EOS')}
    end
    # after(:all) do
    #   exit
    # end
  end

  describe "paypending" do
    before(:all) do
      `cleos set account permission daccustodian active '{"threshold": 1,"keys": [{"key": "#{TEST_ACTIVE_PUBLIC_KEY}","weight": 1}],"accounts": [{"permission":{"actor":"daccustodian","permission":"eosio.code"},"weight":1}]}' owner -p daccustodian`
    end

    context "without valid auth" do
      command %(cleos push action daccustodian paypending '{ "message": "log message"}' -p voter1), allow_error: true
      its(:stderr) {is_expected.to include('Error 3090004')}
    end

    context "the pending_pay table still has content" do
      # Based on the number of elected custodians being 4 the expected quanities below should be 13.
      # There were 4 candidates
      # votedcust1 - 1510000 votes - 11 EOS
      # votedcust2 - 720000  votes - 12 EOS
      # votedcust3 - 790000  votes - 13 EOS
      # votedcust4 - 151000  votes - 14 EOS // will be eliminated because it has the least votes out of 4
      # --> Therefore the median amount is 13 EOS.

      command %(cleos get table daccustodian daccustodian pendingpay), allow_error: true
      it do
        expect(JSON.parse(subject.stdout)).to eq JSON.parse <<~JSON
          {
              "rows": [
	{
		"key": 1,
		"receiver": "votedcust1",
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
		"receiver": "votedcust4",
		"quantity": "13.0000 EOS",
		"memo": "EOSDAC Custodian pay. Thank you."
	},
	{
		"key": 5,
		"receiver": "votedcust1",
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
	}
],
              "more": false
            }
        JSON
      end
    end

    context "the balance of EOSDAC should not have changed" do
      command %(cleos get currency balance eosdactoken unreguser2 EOSDAC), allow_error: true
      its(:stdout) {is_expected.to include('100.0000 EOSDAC')}
    end

    context "with valid auth" do
      command %(cleos push action daccustodian paypending '{ "message": "log message"}' -p daccustodian), allow_error: true
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

    context "the balance of EOSDAC should updated 100" do
      # Also assumes that staked tokens for candidate are not used for voting power.
      command %(cleos get currency balance eosdactoken unreguser2 EOSDAC), allow_error: true
      its(:stdout) {is_expected.to include('100.0000 EOSDAC')}
    end

    context "the balance of EOS should updated 100" do
      # Also assumes that staked tokens for candidate are not used for voting power.
      command %(cleos get currency balance eosio.token votedcust2 EOS), allow_error: true
      its(:stdout) {is_expected.to include('26.0000 EOS')}
    end
  end

  describe "allocateCust" do
    before(:all) do
      # add cands
      `cleos push action daccustodian updateconfig '{ "lockupasset": "10.0000 EOSDAC", "maxvotes": 5, "periodlength": 604800 , "numelected": 12, "tokcontr": "eosdactoken", "authaccount": "dacauthority", "auththresh": 3, "initial_vote_quorum_percent": 15, "vote_quorum_percent": 10, "auth_threshold_high": 11, "auth_threshold_mid": 7, "auth_threshold_low": 3}' -p daccustodian`
    end

    context "given there are not enough candidates to fill the custodians" do
      command %(cleos push action daccustodian allocatecust '[false]' -p daccustodian), allow_error: true
      its(:stdout) {is_expected.to include('The pool of eligible candidates has been exhausted')}
    end

    context "given there are enough candidates to fill the custodians but not enough have votes greater than 0" do
      before(:all) do
        seed_account("allocate1", issue: "101.0000 EOSDAC", memberreg: "New Latest terms", stake: "23.0000 EOSDAC", requestedpay: "11.0000 EOS")
        seed_account("allocate2", issue: "101.0000 EOSDAC", memberreg: "New Latest terms", stake: "23.0000 EOSDAC", requestedpay: "11.0000 EOS")
        seed_account("allocate3", issue: "101.0000 EOSDAC", memberreg: "New Latest terms", stake: "23.0000 EOSDAC", requestedpay: "11.0000 EOS")
        seed_account("allocate4", issue: "101.0000 EOSDAC", memberreg: "New Latest terms", stake: "23.0000 EOSDAC", requestedpay: "11.0000 EOS")
        seed_account("allocate5", issue: "101.0000 EOSDAC", memberreg: "New Latest terms", stake: "23.0000 EOSDAC", requestedpay: "11.0000 EOS")
        seed_account("allocate11", issue: "101.0000 EOSDAC", memberreg: "New Latest terms", stake: "23.0000 EOSDAC", requestedpay: "11.0000 EOS")
        seed_account("allocate21", issue: "101.0000 EOSDAC", memberreg: "New Latest terms", stake: "23.0000 EOSDAC", requestedpay: "11.0000 EOS")
        seed_account("allocate31", issue: "101.0000 EOSDAC", memberreg: "New Latest terms", stake: "23.0000 EOSDAC", requestedpay: "11.0000 EOS")
        seed_account("allocate41", issue: "101.0000 EOSDAC", memberreg: "New Latest terms", stake: "23.0000 EOSDAC", requestedpay: "11.0000 EOS")
        seed_account("allocate51", issue: "101.0000 EOSDAC", memberreg: "New Latest terms", stake: "23.0000 EOSDAC", requestedpay: "11.0000 EOS")
        seed_account("allocate12", issue: "101.0000 EOSDAC", memberreg: "New Latest terms", stake: "23.0000 EOSDAC", requestedpay: "11.0000 EOS")
        seed_account("allocate22", issue: "101.0000 EOSDAC", memberreg: "New Latest terms", stake: "23.0000 EOSDAC", requestedpay: "11.0000 EOS")
        seed_account("allocate32", issue: "101.0000 EOSDAC", memberreg: "New Latest terms", stake: "23.0000 EOSDAC", requestedpay: "11.0000 EOS")
        seed_account("allocate42", issue: "101.0000 EOSDAC", memberreg: "New Latest terms", stake: "23.0000 EOSDAC", requestedpay: "11.0000 EOS")
        seed_account("allocate52", issue: "101.0000 EOSDAC", memberreg: "New Latest terms", stake: "23.0000 EOSDAC", requestedpay: "11.0000 EOS")

        seed_account("voter3", issue: "110.0000 EOSDAC", memberreg: "New Latest terms")
        seed_account("voter4", issue: "121.0000 EOSDAC", memberreg: "New Latest terms")

      end
      command %(cleos push action daccustodian allocatecust '[false]' -p daccustodian -f), allow_error: true
      its(:stdout) {is_expected.to include('The pool of eligible candidates has been exhausted')}
    end

    context "given there are enough votes with total_votes over 0" do
      before(:all) do
        `cleos push action daccustodian votecust '{ "voter": "voter1", "newvotes": ["allocate1","allocate2","allocate3","allocate4","allocate5"]}' -p voter1`
        `cleos push action daccustodian votecust '{ "voter": "voter2", "newvotes": ["allocate11","allocate21","allocate31","allocate41","allocate51"]}' -p voter2`
        `cleos push action daccustodian votecust '{ "voter": "voter3", "newvotes": ["allocate12","allocate22","allocate32","allocate4","allocate5"]}' -p voter3`
      end
      command %(cleos push action daccustodian allocatecust '[false]' -p daccustodian -f), allow_error: true
      its(:stdout) {is_expected.to include('daccustodian::allocatecust')}
    end

    context "Read the votes table after adding enough votes for a valid election" do
      command %(cleos get table daccustodian daccustodian votes), allow_error: true
      it do
        expect(JSON.parse(subject.stdout)).to eq JSON.parse <<~JSON
            {
	"rows": [{
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
				"allocate1",
				"allocate2",
				"allocate3",
				"allocate4",
				"allocate5"
			]
		},
		{
			"voter": "voter2",
			"proxy": "",
			"weight": 0,
			"candidates": [
				"allocate11",
				"allocate21",
				"allocate31",
				"allocate41",
				"allocate51"
			]
		},
		{
			"voter": "voter3",
			"proxy": "",
			"weight": 0,
			"candidates": [
				"allocate12",
				"allocate22",
				"allocate32",
				"allocate4",
				"allocate5"
			]
		}
	],
	"more": false
}
        JSON
      end
    end

    context "Read the custodians table after adding enough votes for election" do
      command %(cleos get table daccustodian daccustodian custodians --limit 20), allow_error: true
      it do
        expect(JSON.parse(subject.stdout)).to eq JSON.parse <<~JSON
{
  "rows": [{
		"cust_name": "allocate11",
		"bio": "any bio",
		"requestedpay": "11.0000 EOS",
		"total_votes": 1080000
	},
	{
		"cust_name": "allocate12",
		"bio": "any bio",
		"requestedpay": "11.0000 EOS",
		"total_votes": 1100000
	},
	{
		"cust_name": "allocate21",
		"bio": "any bio",
		"requestedpay": "11.0000 EOS",
		"total_votes": 1080000
	},
	{
		"cust_name": "allocate22",
		"bio": "any bio",
		"requestedpay": "11.0000 EOS",
		"total_votes": 1100000
	},
	{
		"cust_name": "allocate31",
		"bio": "any bio",
		"requestedpay": "11.0000 EOS",
		"total_votes": 1080000
	},
	{
		"cust_name": "allocate32",
		"bio": "any bio",
		"requestedpay": "11.0000 EOS",
		"total_votes": 1100000
	},
	{
		"cust_name": "allocate4",
		"bio": "any bio",
		"requestedpay": "11.0000 EOS",
		"total_votes": 1820000
	},
	{
		"cust_name": "allocate41",
		"bio": "any bio",
		"requestedpay": "11.0000 EOS",
		"total_votes": 1080000
	},
	{
		"cust_name": "allocate5",
		"bio": "any bio",
		"requestedpay": "11.0000 EOS",
		"total_votes": 1820000
	},
	{
		"cust_name": "allocate51",
		"bio": "any bio",
		"requestedpay": "11.0000 EOS",
		"total_votes": 1080000
	},
	{
		"cust_name": "votedcust1",
		"bio": "any bio",
		"requestedpay": "11.0000 EOS",
		"total_votes": 790000
	},
	{
		"cust_name": "votedcust3",
		"bio": "any bio",
		"requestedpay": "13.0000 EOS",
		"total_votes": 790000
	}
],
  "more": false
}

        JSON

      end
    end
  end


  describe "unreg custodian candidate" do
    context "when the auth is wrong" do
      command %(cleos push action daccustodian unregcand '{ "cand": "allocate41"}' -p allocate4), allow_error: true
      its(:stderr) {is_expected.to include('missing authority of allocate41')}
    end

    context "when the auth is correct" do
      command %(cleos push action daccustodian unregcand '{ "cand": "allocate41"}' -p allocate41), allow_error: true
      its(:stdout) {is_expected.to include('daccustodian::unregcand')}
    end

    context "Read the custodians table after unreg custodian and a single vote will be replaced" do
      command %(cleos get table daccustodian daccustodian custodians --limit 20), allow_error: true
      it do
        expect(JSON.parse(subject.stdout)).to eq JSON.parse <<~JSON
{
  "rows": [{
		"cust_name": "allocate11",
		"bio": "any bio",
		"requestedpay": "11.0000 EOS",
		"total_votes": 1080000
	},
	{
		"cust_name": "allocate12",
		"bio": "any bio",
		"requestedpay": "11.0000 EOS",
		"total_votes": 1100000
	},
	{
		"cust_name": "allocate21",
		"bio": "any bio",
		"requestedpay": "11.0000 EOS",
		"total_votes": 1080000
	},
	{
		"cust_name": "allocate22",
		"bio": "any bio",
		"requestedpay": "11.0000 EOS",
		"total_votes": 1100000
	},
	{
		"cust_name": "allocate31",
		"bio": "any bio",
		"requestedpay": "11.0000 EOS",
		"total_votes": 1080000
	},
	{
		"cust_name": "allocate32",
		"bio": "any bio",
		"requestedpay": "11.0000 EOS",
		"total_votes": 1100000
	},
	{
		"cust_name": "allocate4",
		"bio": "any bio",
		"requestedpay": "11.0000 EOS",
		"total_votes": 1820000
	},
	{
		"cust_name": "allocate5",
		"bio": "any bio",
		"requestedpay": "11.0000 EOS",
		"total_votes": 1820000
	},
	{
		"cust_name": "allocate51",
		"bio": "any bio",
		"requestedpay": "11.0000 EOS",
		"total_votes": 1080000
	},
	{
		"cust_name": "votedcust1",
		"bio": "any bio",
		"requestedpay": "11.0000 EOS",
		"total_votes": 790000
	},
	{
		"cust_name": "votedcust3",
		"bio": "any bio",
		"requestedpay": "13.0000 EOS",
		"total_votes": 790000
	},
	{
		"cust_name": "votedcust4",
		"bio": "any bio",
		"requestedpay": "14.0000 EOS",
		"total_votes": 790000
	}
],
  "more": false
}
        JSON
      end
    end
  end

  describe "rereg custodian candidate" do
    context "with valid and registered member after transferring sufficient staked tokens in multiple transfers" do
      before(:all) do
        `cleos push action eosdactoken transfer '{ "from": "allocate41", "to": "daccustodian", "quantity": "10.0000 EOSDAC","memo":"daccustodian"}' -p allocate41 -f`
      end
      command %(cleos push action daccustodian regcandidate '{ "cand": "allocate41", "bio": "any bio", "requestedpay": "11.5000 EOS"}' -p allocate41), allow_error: true
      its(:stdout) {is_expected.to include('daccustodian::regcandidate')}
    end

    context "Read the custodians table after unreg custodian and a single vote will be replaced" do
      command %(cleos get table daccustodian daccustodian candidates --limit 40), allow_error: true
      it do
        expect(JSON.parse(subject.stdout)).to eq JSON.parse <<~JSON
{
  "rows": [
  {
    "candidate_name": "allocate1",
    "bio": "any bio",
    "requestedpay": "11.0000 EOS",
    "locked_tokens": "23.0000 EOSDAC",
    "total_votes": 720000,
    "is_active": 1
  },
  {
    "candidate_name": "allocate11",
    "bio": "any bio",
    "requestedpay": "11.0000 EOS",
    "locked_tokens": "23.0000 EOSDAC",
    "total_votes": 1080000,
    "is_active": 1
  },
  {
    "candidate_name": "allocate12",
    "bio": "any bio",
    "requestedpay": "11.0000 EOS",
    "locked_tokens": "23.0000 EOSDAC",
    "total_votes": 1100000,
    "is_active": 1
  },
  {
    "candidate_name": "allocate2",
    "bio": "any bio",
    "requestedpay": "11.0000 EOS",
    "locked_tokens": "23.0000 EOSDAC",
    "total_votes": 720000,
    "is_active": 1
  },
  {
    "candidate_name": "allocate21",
    "bio": "any bio",
    "requestedpay": "11.0000 EOS",
    "locked_tokens": "23.0000 EOSDAC",
    "total_votes": 1080000,
    "is_active": 1
  },
  {
    "candidate_name": "allocate22",
    "bio": "any bio",
    "requestedpay": "11.0000 EOS",
    "locked_tokens": "23.0000 EOSDAC",
    "total_votes": 1100000,
    "is_active": 1
  },
  {
    "candidate_name": "allocate3",
    "bio": "any bio",
    "requestedpay": "11.0000 EOS",
    "locked_tokens": "23.0000 EOSDAC",
    "total_votes": 720000,
    "is_active": 1
  },
  {
    "candidate_name": "allocate31",
    "bio": "any bio",
    "requestedpay": "11.0000 EOS",
    "locked_tokens": "23.0000 EOSDAC",
    "total_votes": 1080000,
    "is_active": 1
  },
  {
    "candidate_name": "allocate32",
    "bio": "any bio",
    "requestedpay": "11.0000 EOS",
    "locked_tokens": "23.0000 EOSDAC",
    "total_votes": 1100000,
    "is_active": 1
  },
  {
    "candidate_name": "allocate4",
    "bio": "any bio",
    "requestedpay": "11.0000 EOS",
    "locked_tokens": "23.0000 EOSDAC",
    "total_votes": 1820000,
    "is_active": 1
  },
  {
    "candidate_name": "allocate41",
    "bio": "any bio",
    "requestedpay": "11.5000 EOS",
    "locked_tokens": "10.0000 EOSDAC",
    "total_votes": 1080000,
    "is_active": 1
  },
  {
    "candidate_name": "allocate42",
    "bio": "any bio",
    "requestedpay": "11.0000 EOS",
    "locked_tokens": "23.0000 EOSDAC",
    "total_votes": 0,
    "is_active": 1
  },
  {
    "candidate_name": "allocate5",
    "bio": "any bio",
    "requestedpay": "11.0000 EOS",
    "locked_tokens": "23.0000 EOSDAC",
    "total_votes": 1820000,
    "is_active": 1
  },
  {
    "candidate_name": "allocate51",
    "bio": "any bio",
    "requestedpay": "11.0000 EOS",
    "locked_tokens": "23.0000 EOSDAC",
    "total_votes": 1080000,
    "is_active": 1
  },
  {
    "candidate_name": "allocate52",
    "bio": "any bio",
    "requestedpay": "11.0000 EOS",
    "locked_tokens": "23.0000 EOSDAC",
    "total_votes": 0,
    "is_active": 1
  },
  {
    "candidate_name": "testreguser1",
    "bio": "any bio",
    "requestedpay": "11.5000 EOS",
    "locked_tokens": "10.0000 EOSDAC",
    "total_votes": 0,
    "is_active": 1
  },
  {
    "candidate_name": "unreguser2",
    "bio": "any bio",
    "requestedpay": "11.5000 EOS",
    "locked_tokens": "0.0000 EOSDAC",
    "total_votes": 0,
    "is_active": 0
  },
  {
    "candidate_name": "updatebio2",
    "bio": "new bio",
    "requestedpay": "11.5000 EOS",
    "locked_tokens": "23.0000 EOSDAC",
    "total_votes": 0,
    "is_active": 1
  },
  {
    "candidate_name": "updatepay2",
    "bio": "any bio",
    "requestedpay": "41.5000 EOS",
    "locked_tokens": "23.0000 EOSDAC",
    "total_votes": 0,
    "is_active": 1
  },
  {
    "candidate_name": "votedcust1",
    "bio": "any bio",
    "requestedpay": "11.0000 EOS",
    "locked_tokens": "23.0000 EOSDAC",
    "total_votes": 790000,
    "is_active": 1
  },
  {
    "candidate_name": "votedcust11",
    "bio": "any bio",
    "requestedpay": "16.0000 EOS",
    "locked_tokens": "23.0000 EOSDAC",
    "total_votes": 0,
    "is_active": 1
  },
  {
    "candidate_name": "votedcust2",
    "bio": "any bio",
    "requestedpay": "12.0000 EOS",
    "locked_tokens": "23.0000 EOSDAC",
    "total_votes": 0,
    "is_active": 1
  },
  {
    "candidate_name": "votedcust3",
    "bio": "any bio",
    "requestedpay": "13.0000 EOS",
    "locked_tokens": "23.0000 EOSDAC",
    "total_votes": 790000,
    "is_active": 1
  },
  {
    "candidate_name": "votedcust4",
    "bio": "any bio",
    "requestedpay": "14.0000 EOS",
    "locked_tokens": "23.0000 EOSDAC",
    "total_votes": 790000,
    "is_active": 1
  },
  {
    "candidate_name": "votedcust5",
    "bio": "any bio",
    "requestedpay": "15.0000 EOS",
    "locked_tokens": "23.0000 EOSDAC",
    "total_votes": 0,
    "is_active": 1
  }
],
  "more": false
}
        JSON
      end
    end
  end

end

