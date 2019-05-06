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

EOSIO_PUB = 'EOS8kkhi1qYPWJMpDJXabv4YnqjuzisA5ZdRpGG8vhSGmRDqi6CUn'
EOSIO_PVT = '5KDFWhsMK3fuze6yXgFRmVDEEE5kbQJrJYCBhGKV2KWHCbjsYYy'

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

CONTRACTS_DIR = '../_test_helpers/system_contract_dependencies'

def configure_wallet
  beforescript = <<~SHELL

  cleos wallet unlock --password `cat ~/eosio-wallet/.pass`
  cleos wallet import --private-key #{CONTRACT_ACTIVE_PRIVATE_KEY}
  cleos wallet import --private-key #{TEST_ACTIVE_PRIVATE_KEY}
  cleos wallet import --private-key #{TEST_OWNER_PRIVATE_KEY}
  cleos wallet import --private-key #{EOSIO_PVT}
  SHELL

  `#{beforescript}`
end

# @param [eos account name for the new account] name
# @param [if not nil amount of eosdac to issue to the new account] issue
# @param [if not nil register the account with the agreed terms as this value] memberreg
# @param [if not nil transfer this amount to the elections contract so they can register as an election candidate] stake
# @param [if not nil register as a candidate with this amount as the requested pay] requestedpay
def seed_account(name, issue: nil, memberreg: nil, stake: nil, requestedpay: nil)
  `cleos system newaccount --stake-cpu "10.0000 EOS" --stake-net "10.0000 EOS" --transfer --buy-ram-kbytes 1024 eosio #{name} #{TEST_OWNER_PUBLIC_KEY} #{TEST_ACTIVE_PUBLIC_KEY}`

  unless issue.nil?
    `cleos push action eosdactokens issue '{ "to": "#{name}", "quantity": "#{issue}", "memo": "Initial amount."}' -p eosdactokens`
  end

  unless memberreg.nil?
    `cleos push action eosdactokens memberreg '{ "sender": "#{name}", "agreedterms": "#{memberreg}"}' -p #{name}`
  end

  unless stake.nil?
    `cleos push action eosdactokens transfer '{ "from": "#{name}", "to": "daccustodian", "quantity": "#{stake}","memo":"daccustodian"}' -p #{name}`
  end

  unless requestedpay.nil?
    `cleos push action daccustodian nominatecand '{ "cand": "#{name}", "bio": "any bio", "requestedpay": "#{requestedpay}"}' -p #{name}`
  end
end

def reset_chain
  `kill -INT \`pgrep nodeos\``

  # Launch nodeos in a new tab so the output can be observed.
  # ttab is a nodejs module but this could be easily achieved manually without ttab.
  `ttab 'nodeos --delete-all-blocks --verbose-http-errors'`

  # nodeos --delete-all-blocks --verbose-http-errors &>/dev/null & # Alternative without ttab installed

  puts "Give the chain a chance to settle."
  sleep 4

end

def seed_system_contracts

  beforescript = <<~SHELL
   set -x

  cleos set contract eosio #{CONTRACTS_DIR}/eosio.bios -p eosio
  echo `pwd`
  cleos create account eosio eosio.msig #{EOSIO_PUB}
  cleos get code eosio.msig
  echo "eosio.msig"
  cleos create account eosio eosio.token #{EOSIO_PUB}
  cleos create account eosio eosio.ram #{EOSIO_PUB}
  cleos create account eosio eosio.ramfee #{EOSIO_PUB}
  cleos create account eosio eosio.names #{EOSIO_PUB}
  cleos create account eosio eosio.stake #{EOSIO_PUB}
  cleos create account eosio eosio.saving #{EOSIO_PUB}
  cleos create account eosio eosio.bpay #{EOSIO_PUB}
  cleos create account eosio eosio.vpay #{EOSIO_PUB}
  cleos push action eosio setpriv  '["eosio.msig",1]' -p eosio
  cleos set contract eosio.msig #{CONTRACTS_DIR}/eosio.msig -p eosio.msig
  cleos set contract eosio.token #{CONTRACTS_DIR}/eosio.token -p eosio.token
  cleos push action eosio.token create '["eosio","10000000000.0000 EOS"]' -p eosio.token
  cleos push action eosio.token issue '["eosio", "1000000000.0000 EOS", "Initial EOS amount."]' -p eosio
  cleos set contract eosio #{CONTRACTS_DIR}/eosio.system -p eosio
  SHELL

  `#{beforescript}`
  exit() unless $? == 0
end

def install_contracts

  beforescript = <<~SHELL
   # set -x

   cleos system newaccount --stake-cpu \"10.0000 EOS\" --stake-net \"10.0000 EOS\" --transfer --buy-ram-kbytes 1024 eosio #{ACCOUNT_NAME} #{CONTRACT_OWNER_PUBLIC_KEY} #{CONTRACT_ACTIVE_PUBLIC_KEY}

   cleos system newaccount --stake-cpu \"10.0000 EOS\" --stake-net \"10.0000 EOS\" --transfer --buy-ram-kbytes 1024 eosio eosdactokens #{CONTRACT_OWNER_PUBLIC_KEY} #{CONTRACT_ACTIVE_PUBLIC_KEY}
   
   cleos system newaccount --stake-cpu \"10.0000 EOS\" --stake-net \"10.0000 EOS\" --transfer --buy-ram-kbytes 1024 eosio dacauthority #{CONTRACT_OWNER_PUBLIC_KEY} #{CONTRACT_ACTIVE_PUBLIC_KEY}
   cleos system newaccount --stake-cpu \"10.0000 EOS\" --stake-net \"10.0000 EOS\" --transfer --buy-ram-kbytes 1024 eosio eosdacthedac #{CONTRACT_OWNER_PUBLIC_KEY} #{CONTRACT_ACTIVE_PUBLIC_KEY}
   cleos system newaccount --stake-cpu \"10.0000 EOS\" --stake-net \"10.0000 EOS\" --transfer --buy-ram-kbytes 1024 eosio dacocoiogmbh #{CONTRACT_OWNER_PUBLIC_KEY} #{CONTRACT_ACTIVE_PUBLIC_KEY}

   # Setup the inital permissions.


   cleos set account permission dacauthority owner '{"threshold": 1,"keys": [{"key": "#{CONTRACT_ACTIVE_PUBLIC_KEY}","weight": 1}],"accounts": [{"permission":{"actor":"daccustodian","permission":"eosio.code"},"weight":1}]}' '' -p dacauthority@owner
   cleos set account permission dacauthority active '{"threshold": 1,"keys": [{"key": "#{CONTRACT_ACTIVE_PUBLIC_KEY}","weight": 1}],"accounts": [{"permission":{"actor":"daccustodian","permission":"eosio.code"},"weight":1}]}' owner   -p dacauthority@owner
   # cleos set account permission eosdacthedac active '{"threshold": 1,"keys": [{"key": "#{CONTRACT_ACTIVE_PUBLIC_KEY}","weight": 1}],"accounts": [{"permission":{"actor":"daccustodian","permission":"eosio.code"},"weight":1}]}' active -p eosdacthedac@active
   cleos set account permission eosdacthedac xfer '{"threshold": 1,"keys": [{"key": "#{CONTRACT_ACTIVE_PUBLIC_KEY}","weight": 1}],"accounts": [{"permission":{"actor":"daccustodian","permission":"eosio.code"},"weight":1}]}' active -p eosdacthedac@active
   cleos set account permission daccustodian xfer '{"threshold": 1,"keys": [{"key": "#{CONTRACT_ACTIVE_PUBLIC_KEY}","weight": 1}],"accounts": [{"permission":{"actor":"daccustodian","permission":"eosio.code"},"weight":1}]}' active -p daccustodian@active
     cleos push action eosio.token issue '["eosdacthedac", "100000.0000 EOS", "Initial EOS amount."]' -p eosio

   cleos set action permission eosdacthedac eosdactokens transfer xfer
   cleos set action permission eosdacthedac eosio.token transfer xfer  
   cleos set action permission daccustodian eosdactokens transfer xfer  
 
   cleos set account permission dacauthority high #{CONTRACT_OWNER_PUBLIC_KEY} active -p dacauthority@owner 
   cleos set account permission dacauthority med #{CONTRACT_OWNER_PUBLIC_KEY} high -p dacauthority@owner 
   cleos set account permission dacauthority low #{CONTRACT_OWNER_PUBLIC_KEY} med -p dacauthority@owner 
   cleos set account permission dacauthority one #{CONTRACT_OWNER_PUBLIC_KEY} low -p dacauthority@owner   

   cleos set account permission #{ACCOUNT_NAME} active '{"threshold": 1,"keys": [{"key": "#{CONTRACT_ACTIVE_PUBLIC_KEY}","weight": 1}],"accounts": [{"permission":{"actor":"daccustodian","permission":"eosio.code"},"weight":1}]}' owner -p #{ACCOUNT_NAME}

  #  source output/unit_tests/compile.sh
  #  if [[ $? != 0 ]] 
  #    then 
  #    echo "failed to compile contract" 
  #    exit 1
  #  fi
   # cd ..
   cleos set contract #{ACCOUNT_NAME} ../_compiled_contracts/#{CONTRACT_NAME}/unit_tests/#{CONTRACT_NAME}
   
   echo ""
   echo ""
   # echo "Set up the eosio.token contract"
 # pwd
   # cleos set contract eosio.token tests/dependencies/eosio.token -p eosio.token

   echo ""
   echo ""
   echo "Set up the eosdactokens contract"
   cleos set contract eosdactokens ../_compiled_contracts/eosdactokens/unit_tests/eosdactokens -p eosdactokens

   # Set the token contract to refer to this contract
   cleos push action eosdactokens updateconfig '["daccustodian"]' -p eosdactokens 
   cd ../#{CONTRACT_NAME}

  SHELL

  `#{beforescript}`
  exit() unless $? == 0
end

def killchain
  # `sleep 0.5; kill \`pgrep nodeos\``
end

# Configure the initial state for the contracts for elements that are assumed to work from other contracts already.
def configure_contracts
  # configure accounts for eosdactokens
  `cleos push action eosdactokens create '{ "issuer": "eosdactokens", "maximum_supply": "100000.0000 EOSDAC", "transfer_locked": false}' -p eosdactokens`
  `cleos push action eosdactokens issue '{ "to": "eosdactokens", "quantity": "77337.0000 EOSDAC", "memo": "Initial amount of tokens for you."}' -p eosdactokens`
  `cleos push action eosio.token issue '{ "to": "eosdacthedac", "quantity": "100000.0000 EOS", "memo": "Initial EOS amount."}' -p eosio.token`
  `cleos push action eosdactokens issue '{ "to": "eosdacthedac", "quantity": "1000.0000 EOSDAC", "memo": "Initial amount of tokens for you."}' -p eosdactokens`

  #create users
  # Ensure terms are registered in the token contract
  `cleos push action eosdactokens newmemterms '{ "terms": "normallegalterms", "hash": "New Latest terms"}' -p eosdactokens`

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
    reset_chain
    configure_wallet
    seed_system_contracts
    install_contracts
    configure_contracts
  end

  after(:all) do
    killchain
  end

  describe "updateconfig" do
    context "before being called with token contract will prevent other actions from working" do
      context "with valid and registered member" do
        command %(cleos push action daccustodian nominatecand '{ "cand": "testreguser1", "bio": "any bio", "requestedpay": "11.5000 EOS", "authaccount": "dacauthority", "tokenholder": "eosdacthedac", "auththresh": 3}' -p testreguser1), allow_error: true
        its(:stderr) {is_expected.to include('Error 3050003')}
      end
    end

    context "with invalid auth" do
      command %(cleos push action daccustodian updateconfig '{"newconfig": { "lockupasset": "13.0000 EOSDAC", "maxvotes": 4, "periodlength": 604800 , "numelected": 12, "authaccount": "dacauthority", "tokenholder": "eosdacthedac", "serviceprovider": "dacocoiogmbh", "should_pay_via_service_provider": 1, "auththresh": 3, "initial_vote_quorum_percent": 15, "vote_quorum_percent": 10, "auth_threshold_high": 11, "auth_threshold_mid": 7, "auth_threshold_low": 3, "lockup_release_time_delay": 10, "requested_pay_max": "450.0000 EOS"}}' -p testreguser1), allow_error: true
      its(:stderr) {is_expected.to include('Error 3090004')}
    end

    context "with valid auth" do
      command %(cleos push action daccustodian updateconfig '{"newconfig": { "lockupasset": "10.0000 EOSDAC", "maxvotes": 5, "periodlength": 604800 , "numelected": 12, "authaccount": "dacauthority", "tokenholder": "eosdacthedac",  "serviceprovider": "dacocoiogmbh", "should_pay_via_service_provider": 1, "auththresh": 3, "initial_vote_quorum_percent": 15, "vote_quorum_percent": 10, "auth_threshold_high": 11, "auth_threshold_mid": 7, "auth_threshold_low": 3, "lockup_release_time_delay": 10, "requested_pay_max": "450.0000 EOS"}}' -p daccustodian), allow_error: true
      its(:stdout) {is_expected.to include('daccustodian::updateconfig')}
    end
  end

  describe "nominatecand" do

    context "with valid and registered member after transferring insufficient staked tokens" do
      before(:all) do
        `cleos push action eosdactokens transfer '{ "from": "testreguser1", "to": "daccustodian", "quantity": "5.0000 EOSDAC","memo":"daccustodian"}' -p testreguser1 -f`
        # Verify that a transaction with an invalid account memo still is insufficient funds.
        `cleos push action eosdactokens transfer '{ "from": "testreguser1", "to": "daccustodian", "quantity": "25.0000 EOSDAC","memo":"noncaccount"}' -p testreguser1 -f`
      end
      command %(cleos push action daccustodian nominatecand '{ "cand": "testreguser1", "bio": "any bio", "requestedpay": "11.5000 EOS"}' -p testreguser1), allow_error: true
      its(:stderr) {is_expected.to include('A registering candidate must transfer sufficient tokens to the contract for staking')}
    end

    context "with negative requestpay amount" do
      command %(cleos push action daccustodian nominatecand '{ "cand": "testreguser1", "bio": "any bio", "requestedpay": "-11.5000 EOS"}' -p testreguser1), allow_error: true
      its(:stderr) {is_expected.to include("ERR::UPDATEREQPAY_UNDER_ZERO")}
    end

    context "with valid and registered member after transferring sufficient staked tokens in multiple transfers" do
      before(:all) do
        `cleos push action eosdactokens transfer '{ "from": "testreguser1", "to": "daccustodian", "quantity": "5.0000 EOSDAC","memo":"daccustodian"}' -p testreguser1 -f`
      end
      command %(cleos push action daccustodian nominatecand '{ "cand": "testreguser1", "bio": "any bio", "requestedpay": "11.5000 EOS"}' -p testreguser1), allow_error: true
      its(:stdout) {is_expected.to include('daccustodian::nominatecand')}
    end

    context "with unregistered user" do
      command %(cleos push action daccustodian nominatecand '{ "cand": "testreguser2", "bio": "any bio", "requestedpay": "10.0000 EOS"}' -p testreguser2), allow_error: true
      its(:stderr) {is_expected.to include("Account is not registered with members")}
    end

    context "with user with empty agree terms" do
      command %(cleos push action daccustodian nominatecand '{ "cand": "testreguser3", "bio": "any bio", "requestedpay": "10.0000 EOS"}' -p testreguser3), allow_error: true
      its(:stderr) {is_expected.to include('Error 3050003')}
    end

    context "with user with old agreed terms" do
      command %(cleos push action daccustodian nominatecand '{ "cand": "testreguser4", "bio": "any bio", "requestedpay": "10.0000 EOS"}' -p testreguser4), allow_error: true
      its(:stderr) {is_expected.to include('Error 3050003')}
    end

    context "without first staking" do
      command %(cleos push action daccustodian nominatecand '{ "cand": "testreguser5", "bio": "any bio", "requestedpay": "10.0000 EOS"}' -p testreguser5), allow_error: true
      its(:stderr) {is_expected.to include("A registering candidate must transfer sufficient tokens to the contract for staking")}
    end


    context "with user is already registered" do
      command %(cleos push action daccustodian nominatecand '{ "cand": "testreguser1", "bio": "any bio", "requestedpay": "10.0000 EOS"}' -p testreguser1), allow_error: true
      its(:stderr) {is_expected.to include('Error 3050003')}
    end

    context "Read the candidates table after nominatecand" do
      command %(cleos get table daccustodian daccustodian candidates), allow_error: true
      it do
        expect(JSON.parse(subject.stdout)).to eq JSON.parse <<~JSON
            {
              "rows": [{
                "candidate_name": "testreguser1",
                "requestedpay": "11.5000 EOS",
                "locked_tokens": "10.0000 EOSDAC",
                "total_votes": 0,
                "is_active": 1,
                "custodian_end_time_stamp": "1970-01-01T00:00:00"
              }
            ],
            "more": false
          }
        JSON
      end
    end

    context "Read the pendingstake table after nominatecand and it should be empty" do
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
      command %(cleos push action daccustodian updateconfig '{"newconfig": { "lockupasset": "23.0000 EOSDAC", "maxvotes": 5, "periodlength": 604800 , "numelected": 12, "authaccount": "dacauthority", "tokenholder": "eosdacthedac", "serviceprovider": "dacocoiogmbh", "should_pay_via_service_provider": 1, "auththresh": 3, "initial_vote_quorum_percent": 15, "vote_quorum_percent": 10, "auth_threshold_high": 11, "auth_threshold_mid": 7, "auth_threshold_low": 3, "lockup_release_time_delay": 10, "requested_pay_max": "450.0000 EOS"}}' -p dacauthority), allow_error: true
      its(:stdout) {is_expected.to include('daccustodian::updateconfig')}
    end
  end

  describe "withdrawcand" do
    before(:all) do
      seed_account("unreguser1", issue: "100.0000 EOSDAC", memberreg: "New Latest terms")
      seed_account("unreguser2", issue: "100.0000 EOSDAC", memberreg: "New Latest terms", stake: "23.0000 EOSDAC", requestedpay: "11.5000 EOS")
    end

    context "with invalid auth" do
      command %(cleos push action daccustodian withdrawcand '{ "cand": "unreguser3"}' -p testreguser3), allow_error: true
      its(:stderr) {is_expected.to include('Error 3090004')}
    end

    context "with valid auth but not registered" do
      command %(cleos push action daccustodian withdrawcand '{ "cand": "unreguser1"}' -p unreguser1), allow_error: true
      its(:stderr) {is_expected.to include('Error 3050003')}
    end

    context "with valid auth" do

      command %(cleos push action daccustodian withdrawcand '{ "cand": "unreguser2"}' -p unreguser2), allow_error: true
      its(:stdout) {is_expected.to include('daccustodian::withdrawcand')}
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

    context "with valid auth but not registered" do
      command %(cleos push action daccustodian updatereqpay '{ "cand": "updatepay1", "requestedpay": "31.5000 EOS"}' -p updatepay1), allow_error: true
      its(:stderr) {is_expected.to include('Error 3050003')}
    end

    context "with invalid auth" do
      command %(cleos push action daccustodian updatereqpay '{ "cand": "updatepay2", "requestedpay": "11.5000 EOS"}' -p testreguser3), allow_error: true
      its(:stderr) {is_expected.to include('Error 3090004')}
    end

    context "with negative requestpay amount" do
      command %(cleos push action daccustodian updatereqpay '{ "cand": "updatepay2", "requestedpay": "-450.5000 EOS"}' -p updatepay2), allow_error: true
      its(:stderr) {is_expected.to include("ERR::UPDATEREQPAY_UNDER_ZERO")}
    end

    context "with valid auth" do
      context "exceeding the req pay limit" do
        command %(cleos push action daccustodian updatereqpay '{ "cand": "updatepay2", "requestedpay": "450.5000 EOS"}' -p updatepay2), allow_error: true
        its(:stderr) {is_expected.to include('ERR::UPDATEREQPAY_EXCESS_MAX_PAY')}
      end
      context "equal to the max req pay limit" do
        command %(cleos push action daccustodian updatereqpay '{ "cand": "updatepay2", "requestedpay": "450.0000 EOS"}' -p updatepay2), allow_error: true
        its(:stdout) {is_expected.to include('daccustodian::updatereqpay')}
      end

      context "with normal valid value" do
        command %(cleos push action daccustodian updatereqpay '{ "cand": "updatepay2", "requestedpay": "41.5000 EOS"}' -p updatepay2), allow_error: true
        its(:stdout) {is_expected.to include('daccustodian::updatereqpay')}
      end

      context "Read the candidates table after change reqpay" do
        command %(cleos get table daccustodian daccustodian candidates), allow_error: true
        it do
          json = JSON.parse(subject.stdout)
          expect(json["rows"].count).to eq 4

          expect(json["rows"][-1]["candidate_name"]).to eq 'updatepay2'
          expect(json["rows"][-1]["requestedpay"]).to eq '41.5000 EOS'
          expect(json["rows"][-1]["locked_tokens"]).to eq '23.0000 EOSDAC'
        end
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
      seed_account("voter1", issue: "3000.0000 EOSDAC", memberreg: "New Latest terms")
      seed_account("voter2", issue: "108.0000 EOSDAC", memberreg: "New Latest terms")
      seed_account("unregvoter", issue: "109.0000 EOSDAC")
    end

    context "Read the candidates table after _change_ vote" do
      command %(cleos get table daccustodian daccustodian candidates), allow_error: true
      it do

        json = JSON.parse(subject.stdout)
        expect(json["rows"].count).to eq 10

        candidate = json["rows"][4]

        expect(candidate["candidate_name"]).to eq 'votedcust1'
        expect(candidate["requestedpay"]).to eq '11.0000 EOS'
        expect(candidate["total_votes"]).to eq 0
        expect(candidate["is_active"]).to eq 1
        expect(candidate["custodian_end_time_stamp"]).to eq "1970-01-01T00:00:00"

        candidate = json["rows"][6]

        expect(candidate["candidate_name"]).to eq 'votedcust2'
        expect(candidate["requestedpay"]).to eq '12.0000 EOS'
        expect(candidate["total_votes"]).to eq 0
        expect(candidate["is_active"]).to eq 1
        expect(candidate["custodian_end_time_stamp"]).to eq "1970-01-01T00:00:00"

        candidate = json["rows"][7]

        expect(candidate["candidate_name"]).to eq 'votedcust3'
        expect(candidate["requestedpay"]).to eq '13.0000 EOS'
        expect(candidate["total_votes"]).to eq 0
        expect(candidate["is_active"]).to eq 1
        expect(candidate["custodian_end_time_stamp"]).to eq "1970-01-01T00:00:00"

        candidate = json["rows"][8]

        expect(candidate["candidate_name"]).to eq 'votedcust4'
        expect(candidate["requestedpay"]).to eq '14.0000 EOS'
        expect(candidate["total_votes"]).to eq 0
        expect(candidate["is_active"]).to eq 1
        expect(candidate["custodian_end_time_stamp"]).to eq "1970-01-01T00:00:00"
      end
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
      its(:stderr) {is_expected.to include('ERR::VOTECUST_CANDIDATE_NOT_FOUND::')}
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
                "candidates": [
                  "votedcust1",
                  "votedcust2",
                  "votedcust3"
                ]
              }, {
                "voter": "voter2",
                "proxy": "",
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
    "lastperiodtime": "1970-01-01T00:00:00",
    "total_weight_of_votes": 31080000,
    "total_votes_on_candidates": 93240000,
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

        json = JSON.parse(subject.stdout)
        expect(json["rows"].count).to eq 10

        candidate = json["rows"][4]

        expect(candidate["candidate_name"]).to eq 'votedcust1'
        expect(candidate["requestedpay"]).to eq '11.0000 EOS'
        expect(candidate["total_votes"]).to eq 30000000
        expect(candidate["is_active"]).to eq 1
        expect(candidate["custodian_end_time_stamp"]).to eq "1970-01-01T00:00:00"

        candidate = json["rows"][6]

        expect(candidate["candidate_name"]).to eq 'votedcust2'
        expect(candidate["requestedpay"]).to eq '12.0000 EOS'
        expect(candidate["total_votes"]).to eq 30000000
        expect(candidate["is_active"]).to eq 1
        expect(candidate["custodian_end_time_stamp"]).to eq "1970-01-01T00:00:00"

        candidate = json["rows"][7]

        expect(candidate["candidate_name"]).to eq 'votedcust3'
        expect(candidate["requestedpay"]).to eq '13.0000 EOS'
        expect(candidate["total_votes"]).to eq 30000000
        expect(candidate["is_active"]).to eq 1
        expect(candidate["custodian_end_time_stamp"]).to eq "1970-01-01T00:00:00"

        candidate = json["rows"][8]

        expect(candidate["candidate_name"]).to eq 'votedcust4'
        expect(candidate["requestedpay"]).to eq '14.0000 EOS'
        expect(candidate["total_votes"]).to eq 0
        expect(candidate["is_active"]).to eq 1
        expect(candidate["custodian_end_time_stamp"]).to eq "1970-01-01T00:00:00"
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

        json = JSON.parse(subject.stdout)
        expect(json["rows"].count).to eq 10

        candidate = json["rows"][4]

        expect(candidate["candidate_name"]).to eq 'votedcust1'
        expect(candidate["requestedpay"]).to eq '11.0000 EOS'
        expect(candidate["total_votes"]).to eq 30000000
        expect(candidate["is_active"]).to eq 1
        expect(candidate["custodian_end_time_stamp"]).to eq "1970-01-01T00:00:00"

        candidate = json["rows"][6]

        expect(candidate["candidate_name"]).to eq 'votedcust2'
        expect(candidate["requestedpay"]).to eq '12.0000 EOS'
        expect(candidate["total_votes"]).to eq 30000000
        expect(candidate["is_active"]).to eq 1
        expect(candidate["custodian_end_time_stamp"]).to eq "1970-01-01T00:00:00"

        candidate = json["rows"][7]

        expect(candidate["candidate_name"]).to eq 'votedcust3'
        expect(candidate["requestedpay"]).to eq '13.0000 EOS'
        expect(candidate["total_votes"]).to eq 0
        expect(candidate["is_active"]).to eq 1
        expect(candidate["custodian_end_time_stamp"]).to eq "1970-01-01T00:00:00"

        candidate = json["rows"][8]

        expect(candidate["candidate_name"]).to eq 'votedcust4'
        expect(candidate["requestedpay"]).to eq '14.0000 EOS'
        expect(candidate["total_votes"]).to eq 30000000
        expect(candidate["is_active"]).to eq 1
        expect(candidate["custodian_end_time_stamp"]).to eq "1970-01-01T00:00:00"
      end
    end

    context "After token transfer vote weight should move to different candidates" do
      before(:all) do
        `cleos push action daccustodian votecust '{ "voter": "voter2", "newvotes": ["votedcust3"]}' -p voter2`
      end
      command %(cleos push action eosdactokens transfer '{ "from": "voter1", "to": "voter2", "quantity": "1300.0000 EOSDAC","memo":"random transfer"}' -p voter1), allow_error: true
      its(:stdout) {is_expected.to include('eosdactokens::transfer')}
    end

    context "Read the candidates table after transfer for voter" do
      command %(cleos get table daccustodian daccustodian candidates), allow_error: true
      it do

        json = JSON.parse(subject.stdout)
        expect(json["rows"].count).to eq 10

        candidate = json["rows"][4]

        expect(candidate["candidate_name"]).to eq 'votedcust1'
        expect(candidate["requestedpay"]).to eq '11.0000 EOS'
        expect(candidate["total_votes"]).to eq 17000000 # was 3000,0000 now subtract 1300,0000 = 1700,0000
        expect(candidate["is_active"]).to eq 1
        expect(candidate["custodian_end_time_stamp"]).to eq "1970-01-01T00:00:00"

        candidate = json["rows"][6]

        expect(candidate["candidate_name"]).to eq 'votedcust2'
        expect(candidate["requestedpay"]).to eq '12.0000 EOS'
        expect(candidate["total_votes"]).to eq 17000000 # was 3000,0000 now subtract 1300,0000 = 1700,0000
        expect(candidate["is_active"]).to eq 1
        expect(candidate["custodian_end_time_stamp"]).to eq "1970-01-01T00:00:00"

        candidate = json["rows"][7]

        expect(candidate["candidate_name"]).to eq 'votedcust3'
        expect(candidate["requestedpay"]).to eq '13.0000 EOS'
        expect(candidate["total_votes"]).to eq 14080000 # initial balance of 108,0000 + 1300,0000 = 1408,0000
        expect(candidate["is_active"]).to eq 1
        expect(candidate["custodian_end_time_stamp"]).to eq "1970-01-01T00:00:00"

        candidate = json["rows"][8]

        expect(candidate["candidate_name"]).to eq 'votedcust4'
        expect(candidate["requestedpay"]).to eq '14.0000 EOS'
        expect(candidate["total_votes"]).to eq 17000000 # was 3000,0000 now subtract 1300,0000 = 1700,0000
        expect(candidate["is_active"]).to eq 1
        expect(candidate["custodian_end_time_stamp"]).to eq "1970-01-01T00:00:00"
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
#  Excluded for now.           vvvvvvvvvvvv
#
  xdescribe "votedproxy" do
    before(:all) do
      # configure accounts for eosdactokens

      #create users
      `cleos create account eosio votedproxy1 #{TEST_OWNER_PUBLIC_KEY} #{TEST_ACTIVE_PUBLIC_KEY}`
      `cleos create account eosio votedproxy3 #{TEST_OWNER_PUBLIC_KEY} #{TEST_ACTIVE_PUBLIC_KEY}`

      # Issue tokens to the first accounts in the token contract
      `cleos push action eosdactokens issue '{ "to": "votedproxy1", "quantity": "101.0000 EOSDAC", "memo": "Initial amount."}' -p eosdactokens`
      `cleos push action eosdactokens issue '{ "to": "votedproxy3", "quantity": "101.0000 EOSDAC", "memo": "Initial amount."}' -p eosdactokens`
      `cleos push action eosdactokens issue '{ "to": "unregvoter", "quantity": "109.0000 EOSDAC", "memo": "Initial amount."}' -p eosdactokens`

      # Add the founders to the memberreg table
      `cleos push action eosdactokens memberreg '{ "sender": "votedproxy1", "agreedterms": "New Latest terms"}' -p votedproxy1`
      `cleos push action eosdactokens memberreg '{ "sender": "votedproxy3", "agreedterms": "New Latest terms"}' -p votedproxy3`
      `cleos push action eosdactokens memberreg '{ "sender": "voter1", "agreedterms": "New Latest terms"}' -p voter1`
      # `cleos push action eosdactokens memberreg '{ "sender": "unregvoter", "agreedterms": "New Latest terms"}' -p unregvoter`

      # pre-transfer for staking before registering from within the contract.
      `cleos push action eosdactokens transfer '{ "from": "votedproxy1", "to": "daccustodian", "quantity": "23.0000 EOSDAC","memo":"daccustodian"}' -p votedproxy1`

      `cleos push action daccustodian nominatecand '{ "cand": "votedproxy1", "bio": "any bio", "requestedpay": "10.0000 EOS"}' -p votedproxy1`
      # `cleos push action daccustodian nominatecand '{ "cand": "unregvoter" "requestedpay": "21.5000 EOS"}' -p unregvoter`
    end

    context "with invalid auth" do
      command %(cleos push action daccustodian voteproxy '{ "voter": "voter1", "proxy": "votedproxy1"}' -p testreguser3), allow_error: true
      # its(:stdout) {is_expected.to include('daccustodian::nominatecand')}
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
                "requestedpay": "11.5000 EOS",
                "locked_tokens": "10.0000 EOSDAC",
                "total_votes": 0,
                "is_active": 1,
                "custodian_end_time_stamp": "1970-01-01T00:00:00"
              },{
                "candidate_name": "unreguser2",
                "requestedpay": "11.5000 EOS",
                "locked_tokens": "0.0000 EOSDAC",
                "total_votes": 0,
                "is_active": 0,
                "custodian_end_time_stamp": "1970-01-01T00:00:00"
              },{
                "candidate_name": "updatebio2",
                "bio": "new bio",
                "requestedpay": "11.5000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0,
                "is_active": 1,
                "custodian_end_time_stamp": "1970-01-01T00:00:00"
              },{
                "candidate_name": "updatepay2",
                "requestedpay": "41.5000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0,
                "is_active": 1,
                "custodian_end_time_stamp": "1970-01-01T00:00:00"
              },{
                "candidate_name": "votedcust1",
                "requestedpay": "11.0000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0,
                "is_active": 1,
                "custodian_end_time_stamp": "1970-01-01T00:00:00"
              },{
                "candidate_name": "votedcust11",
                "requestedpay": "16.0000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0,
                "is_active": 1,
                "custodian_end_time_stamp": "1970-01-01T00:00:00"
              },{
                "candidate_name": "votedcust2",
                "requestedpay": "12.0000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0,
                "is_active": 1,
                "custodian_end_time_stamp": "1970-01-01T00:00:00"
              },{
                "candidate_name": "votedcust3",
                "requestedpay": "13.0000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0,
                "is_active": 1,
                "custodian_end_time_stamp": "1970-01-01T00:00:00"
              },{
                "candidate_name": "votedcust4",
                "requestedpay": "14.0000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0,
                "is_active": 1,
                "custodian_end_time_stamp": "1970-01-01T00:00:00"
              },{
                "candidate_name": "votedcust5",
                "requestedpay": "15.0000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0,
                "is_active": 1,
                "custodian_end_time_stamp": "1970-01-01T00:00:00"
              },{
                "candidate_name": "votedproxy1",
                "requestedpay": "10.0000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0,
                "is_active": 1,
                "custodian_end_time_stamp": "1970-01-01T00:00:00"
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
                "requestedpay": "11.5000 EOS",
                "locked_tokens": "10.0000 EOSDAC",
                "total_votes": 0,
                "is_active": 1,
                "custodian_end_time_stamp": "1970-01-01T00:00:00"
              },{
                "candidate_name": "unreguser2",
                "requestedpay": "11.5000 EOS",
                "locked_tokens": "0.0000 EOSDAC",
                "total_votes": 0,
                "is_active": 0,
                "custodian_end_time_stamp": "1970-01-01T00:00:00"
              },{
                "candidate_name": "updatebio2",
                "bio": "new bio",
                "requestedpay": "11.5000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0,
                "is_active": 1,
                "custodian_end_time_stamp": "1970-01-01T00:00:00"
              },{
                "candidate_name": "updatepay2",
                "requestedpay": "41.5000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0,
                "is_active": 1,
                "custodian_end_time_stamp": "1970-01-01T00:00:00"
              },{
                "candidate_name": "votedcust1",
                "requestedpay": "11.0000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0,
                "is_active": 1,
                "custodian_end_time_stamp": "1970-01-01T00:00:00"
              },{
                "candidate_name": "votedcust11",
                "requestedpay": "16.0000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0,
                "is_active": 1,
                "custodian_end_time_stamp": "1970-01-01T00:00:00"
              },{
                "candidate_name": "votedcust2",
                "requestedpay": "12.0000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0,
                "is_active": 1,
                "custodian_end_time_stamp": "1970-01-01T00:00:00"
              },{
                "candidate_name": "votedcust3",
                "requestedpay": "13.0000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0,
                "is_active": 1,
                "custodian_end_time_stamp": "1970-01-01T00:00:00"
              },{
                "candidate_name": "votedcust4",
                "requestedpay": "14.0000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0,
                "is_active": 1,
                "custodian_end_time_stamp": "1970-01-01T00:00:00"
              },{
                "candidate_name": "votedcust5",
                "requestedpay": "15.0000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0,
                "is_active": 1,
                "custodian_end_time_stamp": "1970-01-01T00:00:00"
              },{
                "candidate_name": "votedproxy1",
                "requestedpay": "10.0000 EOS",
                "locked_tokens": "23.0000 EOSDAC",
                "total_votes": 0,
                "is_active": 1,
                "custodian_end_time_stamp": "1970-01-01T00:00:00"
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
                  "requestedpay": "11.5000 EOS",
                  "locked_tokens": "10.0000 EOSDAC",
                  "total_votes": 0,
                "is_active": 1,
                "custodian_end_time_stamp": "1970-01-01T00:00:00"
                },{
                  "candidate_name": "unreguser2",
                  "requestedpay": "11.5000 EOS",
                  "locked_tokens": "0.0000 EOSDAC",
                  "total_votes": 0,
                "is_active": 0,
                "custodian_end_time_stamp": "1970-01-01T00:00:00"
                },{
                  "candidate_name": "updatebio2",
                  "bio": "new bio",
                  "requestedpay": "11.5000 EOS",
                  "locked_tokens": "23.0000 EOSDAC",
                  "total_votes": 0,
                "is_active": 1,
                "custodian_end_time_stamp": "1970-01-01T00:00:00"
                },{
                  "candidate_name": "updatepay2",
                  "requestedpay": "41.5000 EOS",
                  "locked_tokens": "23.0000 EOSDAC",
                  "total_votes": 0,
                "is_active": 1,
                "custodian_end_time_stamp": "1970-01-01T00:00:00"
                },{
                  "candidate_name": "votedcust1",
                  "requestedpay": "11.0000 EOS",
                  "locked_tokens": "23.0000 EOSDAC",
                  "total_votes": 0,
                "is_active": 1,
                "custodian_end_time_stamp": "1970-01-01T00:00:00"
                },{
                  "candidate_name": "votedcust11",
                  "requestedpay": "16.0000 EOS",
                  "locked_tokens": "23.0000 EOSDAC",
                  "total_votes": 0,
                "is_active": 1,
                "custodian_end_time_stamp": "1970-01-01T00:00:00"
                },{
                  "candidate_name": "votedcust2",
                  "requestedpay": "12.0000 EOS",
                  "locked_tokens": "23.0000 EOSDAC",
                  "total_votes": 0,
                "is_active": 1,
                "custodian_end_time_stamp": "1970-01-01T00:00:00"
                },{
                  "candidate_name": "votedcust3",
                  "requestedpay": "13.0000 EOS",
                  "locked_tokens": "23.0000 EOSDAC",
                  "total_votes": 0,
                "is_active": 1,
                "custodian_end_time_stamp": "1970-01-01T00:00:00"
                },{
                  "candidate_name": "votedcust4",
                  "requestedpay": "14.0000 EOS",
                  "locked_tokens": "23.0000 EOSDAC",
                  "total_votes": 0,
                "is_active": 1,
                "custodian_end_time_stamp": "1970-01-01T00:00:00"
                },{
                  "candidate_name": "votedcust5",
                  "requestedpay": "15.0000 EOS",
                  "locked_tokens": "23.0000 EOSDAC",
                  "total_votes": 0,
                "custodian_end_time_stamp": "1970-01-01T00:00:00"
                },{
                  "candidate_name": "votedproxy1",
                  "requestedpay": "10.0000 EOS",
                  "locked_tokens": "23.0000 EOSDAC",
                  "total_votes": 0,
                "is_active": 1,
                "custodian_end_time_stamp": "1970-01-01T00:00:00"
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
    before(:all) do
      seed_account("voter3", issue: "110.0000 EOSDAC", memberreg: "New Latest terms")
      seed_account("whale1", issue: "15000.0000 EOSDAC", memberreg: "New Latest terms")
    end

    describe "with insufficient votes to trigger the dac should fail" do
      before(:all) do
        `cleos push action daccustodian updateconfig '{"newconfig": { "lockupasset": "10.0000 EOSDAC", "maxvotes": 5, "periodlength": 5, "numelected": 12, "authaccount": "dacauthority", "tokenholder": "eosdacthedac", "serviceprovider": "dacocoiogmbh", "should_pay_via_service_provider": 1, "auththresh": 3, "initial_vote_quorum_percent": 15, "vote_quorum_percent": 10, "auth_threshold_high": 3, "auth_threshold_mid": 2, "auth_threshold_low": 1, "lockup_release_time_delay": 10, "requested_pay_max": "450.0000 EOS"}}' -p dacauthority`
      end
      command %(cleos push action daccustodian newperiod '{ "message": "log message", "earlyelect": false}' -p daccustodian), allow_error: true
      its(:stderr) {is_expected.to include('Voter engagement is insufficient to activate the DAC.')}
    end

    describe "allocateCust" do
      before(:all) do
        # add cands
        `cleos push action daccustodian updateconfig '{"newconfig": { "lockupasset": "10.0000 EOSDAC", "maxvotes": 5, "periodlength": 1 , "numelected": 12, "authaccount": "dacauthority", "tokenholder": "eosdacthedac", "serviceprovider": "dacocoiogmbh", "should_pay_via_service_provider": 1, "auththresh": 3, "initial_vote_quorum_percent": 15, "vote_quorum_percent": 10, "auth_threshold_high": 4, "auth_threshold_mid": 4, "auth_threshold_low": 2, "lockup_release_time_delay": 10, "requested_pay_max": "450.0000 EOS"}}' -p dacauthority`
      end

      context "given there are not enough candidates to fill the custodians" do
        command %(cleos push action daccustodian newperiod '{ "message": "log message", "earlyelect": false}' -p daccustodian), allow_error: true
        its(:stderr) {is_expected.to include('Voter engagement is insufficient to activate the DAC.')}
      end

      context "given there are enough candidates to fill the custodians but not enough have votes greater than 0" do
        before(:all) do
          seed_account("allocate1", issue: "101.0000 EOSDAC", memberreg: "New Latest terms", stake: "23.0000 EOSDAC", requestedpay: "11.0000 EOS")
          seed_account("allocate2", issue: "101.0000 EOSDAC", memberreg: "New Latest terms", stake: "23.0000 EOSDAC", requestedpay: "12.0000 EOS")
          seed_account("allocate3", issue: "101.0000 EOSDAC", memberreg: "New Latest terms", stake: "23.0000 EOSDAC", requestedpay: "13.0000 EOS")
          seed_account("allocate4", issue: "101.0000 EOSDAC", memberreg: "New Latest terms", stake: "23.0000 EOSDAC", requestedpay: "14.0000 EOS")
          seed_account("allocate5", issue: "101.0000 EOSDAC", memberreg: "New Latest terms", stake: "23.0000 EOSDAC", requestedpay: "15.0000 EOS")
          seed_account("allocate11", issue: "101.0000 EOSDAC", memberreg: "New Latest terms", stake: "23.0000 EOSDAC", requestedpay: "16.0000 EOS")
          seed_account("allocate21", issue: "101.0000 EOSDAC", memberreg: "New Latest terms", stake: "23.0000 EOSDAC", requestedpay: "17.0000 EOS")
          seed_account("allocate31", issue: "101.0000 EOSDAC", memberreg: "New Latest terms", stake: "23.0000 EOSDAC", requestedpay: "18.0000 EOS")
          seed_account("allocate41", issue: "101.0000 EOSDAC", memberreg: "New Latest terms", stake: "23.0000 EOSDAC", requestedpay: "19.0000 EOS")
          seed_account("allocate51", issue: "101.0000 EOSDAC", memberreg: "New Latest terms", stake: "23.0000 EOSDAC", requestedpay: "20.0000 EOS")
          seed_account("allocate12", issue: "101.0000 EOSDAC", memberreg: "New Latest terms", stake: "23.0000 EOSDAC", requestedpay: "21.0000 EOS")
          seed_account("allocate22", issue: "101.0000 EOSDAC", memberreg: "New Latest terms", stake: "23.0000 EOSDAC", requestedpay: "22.0000 EOS")
          seed_account("allocate32", issue: "101.0000 EOSDAC", memberreg: "New Latest terms", stake: "23.0000 EOSDAC", requestedpay: "23.0000 EOS")
          seed_account("allocate42", issue: "101.0000 EOSDAC", memberreg: "New Latest terms", stake: "23.0000 EOSDAC", requestedpay: "24.0000 EOS")
          seed_account("allocate52", issue: "101.0000 EOSDAC", memberreg: "New Latest terms", stake: "23.0000 EOSDAC", requestedpay: "25.0000 EOS")
        end

        command %(cleos push action daccustodian newperiod '{ "message": "log message", "earlyelect": false}' -p daccustodian), allow_error: true
        its(:stderr) {is_expected.to include('Voter engagement is insufficient to activate the DAC.')}
      end

      context "given there are enough votes with total_votes over 0" do
        before(:all) do
          `cleos push action daccustodian votecust '{ "voter": "voter1", "newvotes": ["allocate1","allocate2","allocate3","allocate4","allocate5"]}' -p voter1`
          `cleos push action daccustodian votecust '{ "voter": "voter2", "newvotes": ["allocate11","allocate21","allocate31","allocate41","allocate51"]}' -p voter2`
          `cleos push action daccustodian votecust '{ "voter": "voter3", "newvotes": ["allocate12","allocate22","allocate32","allocate4","allocate5"]}' -p voter3`
        end
        context "But not enough engagement to active the DAC" do
          command %(cleos push action daccustodian newperiod '{ "message": "log message", "earlyelect": false}' -p daccustodian), allow_error: true
          its(:stderr) {is_expected.to include('Voter engagement is insufficient to activate the DAC.')}
        end

        context "And enough voter weight to activate the DAC" do
          before(:all) {`cleos push action daccustodian votecust '{ "voter": "whale1", "newvotes": ["allocate12","allocate22","allocate32","allocate4","allocate5"]}' -p whale1`}

          command %(cleos push action daccustodian newperiod '{ "message": "log message"}' -p daccustodian), allow_error: true
            its(:stdout) {is_expected.to include('daccustodian::newperiod')}
        end
      end

      context "Read the votes table after adding enough votes for a valid election" do
        command %(cleos get table daccustodian daccustodian votes), allow_error: true
        it do

          json = JSON.parse(subject.stdout)
          expect(json["rows"].count).to eq 4

          vote = json["rows"].detect {|v| v["voter"] == 'voter2'}

          expect(vote["candidates"].count).to eq 5
          expect(vote["candidates"][0]).to eq 'allocate11'

          vote = json["rows"].detect {|v| v["voter"] == 'voter3'}

          expect(vote["candidates"].count).to eq 5
          expect(vote["candidates"][0]).to eq 'allocate12'

          vote = json["rows"].detect {|v| v["voter"] == 'whale1'}
          expect(vote["candidates"].count).to eq 5
          expect(vote["candidates"][0]).to eq 'allocate12'
        end
      end

      context "Read the custodians table after adding enough votes for election" do
        command %(cleos get table daccustodian daccustodian custodians --limit 20), allow_error: true
        it do
          json = JSON.parse(subject.stdout)
          expect(json["rows"].count).to eq 12

          custodian = json["rows"].detect {|v| v["cust_name"] == 'allocate11'}
          expect(custodian["total_votes"]).to eq 14080000

          custodian = json["rows"].detect {|v| v["cust_name"] == 'allocate32'}
          expect(custodian["total_votes"]).to eq 151100000

          custodian = json["rows"].detect {|v| v["cust_name"] == 'allocate4'}
          expect(custodian["total_votes"]).to eq 168100000

          custnames = json["rows"].map {|c| c["cust_name"]}
          expect(custnames).to eq ["allocate1", "allocate11", "allocate12", "allocate2", "allocate21", "allocate22", "allocate3", "allocate31", "allocate32", "allocate4", "allocate41", "allocate5"]
        end
      end
    end

    describe "called too early in the period should fail after recent newperiod call" do
      before(:all) do
        `cleos push action daccustodian votecust '{ "voter": "whale1", "newvotes": ["allocate1","allocate2","allocate3","allocate4","allocate5"]}' -p whale1`
      end

      command %(cleos push action daccustodian newperiod '{ "message": "called too early", "earlyelect": false}' -p daccustodian), allow_error: true
      its(:stderr) {is_expected.to include('New period is being called too soon. Wait until the period has complete')}
    end

    describe "called after period time has passed" do
      before(:all) do
        `cleos push action daccustodian updateconfig '{"newconfig": { "lockupasset": "10.0000 EOSDAC", "maxvotes": 5, "periodlength": 1, "numelected": 12, "authaccount": "dacauthority", "tokenholder": "eosdacthedac", "serviceprovider": "dacocoiogmbh", "should_pay_via_service_provider": 1, "auththresh": 3, "initial_vote_quorum_percent": 15, "vote_quorum_percent": 10, "auth_threshold_high": 3, "auth_threshold_mid": 2, "auth_threshold_low": 1, "lockup_release_time_delay": 10, "requested_pay_max": "450.0000 EOS"}}' -p dacauthority`
        sleep 2
      end
      command %(cleos push action daccustodian newperiod '{ "message": "Good new period call after config change", "earlyelect": false}' -p daccustodian), allow_error: true
      its(:stdout) {is_expected.to include('daccustodian::newperiod')}
    end

    describe "called after voter engagement has dropped to too low" do
      before(:all) do
        # Remove the whale vote to drop backs
        `cleos push action daccustodian votecust '{ "voter": "whale1", "newvotes": []}' -p whale1`
        `cleos push action daccustodian updateconfig '{"newconfig": { "lockupasset": "10.0000 EOSDAC", "maxvotes": 5, "periodlength": 1, "numelected": 12, "authaccount": "dacauthority", "tokenholder": "eosdacthedac", "serviceprovider": "dacocoiogmbh", "should_pay_via_service_provider": 1, "auththresh": 3, "initial_vote_quorum_percent": 15, "vote_quorum_percent": 4, "auth_threshold_high": 3, "auth_threshold_mid": 2, "auth_threshold_low": 1, "lockup_release_time_delay": 10, "requested_pay_max": "450.0000 EOS"}}' -p dacauthority`
        sleep 2
      end
      command %(cleos push action daccustodian newperiod '{ "message": "Good new period call after config change", "earlyelect": false}' -p daccustodian), allow_error: true
      its(:stderr) {is_expected.to include('Voter engagement is insufficient to process a new period')}
    end

    describe "called after voter engagement has risen to above the continuing threshold" do
      before(:all) do
        `cleos push action daccustodian updateconfig '{"newconfig": { "lockupasset": "10.0000 EOSDAC", "maxvotes": 5, "periodlength": 1, "numelected": 12, "authaccount": "dacauthority", "tokenholder": "eosdacthedac", "serviceprovider": "dacocoiogmbh", "should_pay_via_service_provider": 1, "auththresh": 3, "initial_vote_quorum_percent": 15, "vote_quorum_percent": 4, "auth_threshold_high": 3, "auth_threshold_mid": 2, "auth_threshold_low": 1, "lockup_release_time_delay": 10, "requested_pay_max": "450.0000 EOS"}}' -p dacauthority`
        `cleos push action eosdactokens transfer '{ "from": "whale1", "to": "voter1", "quantity": "1300.0000 EOSDAC","memo":"random transfer"}' -p whale1`

        sleep 2
      end
      command %(cleos push action daccustodian newperiod '{ "message": "Good new period call after config change", "earlyelect": false}' -p daccustodian), allow_error: true
      its(:stdout) {is_expected.to include('daccustodian::newperiod')}
    end

    context "the pending_pay table" do
      command %(cleos get table daccustodian daccustodian pendingpay --limit 50), allow_error: true
      it do

        json = JSON.parse(subject.stdout)
        expect(json["rows"].count).to eq 24

        custodian = json["rows"].detect {|v| v["receiver"] == 'allocate5'}
        expect(custodian["quantity"]).to eq '16.7500 EOS'
        expect(custodian["memo"]).to eq 'Custodian pay. Thank you.'

        custodian = json["rows"].detect {|v| v["receiver"] == 'allocate3'}
        expect(custodian["quantity"]).to eq '16.7500 EOS'
      end
    end

    context "the votes table" do
      command %(cleos get table daccustodian daccustodian votes), allow_error: true
      it do

        json = JSON.parse(subject.stdout)
        expect(json["rows"].count).to eq 3

        vote = json["rows"].detect {|v| v["voter"] == 'voter2'}

        expect(vote["candidates"].count).to eq 5
        expect(vote["candidates"][0]).to eq 'allocate11'

        vote = json["rows"].detect {|v| v["voter"] == 'voter3'}

        expect(vote["candidates"].count).to eq 5
        expect(vote["candidates"][0]).to eq 'allocate12'

        vote = json["rows"].detect {|v| v["voter"] == 'voter1'}
        expect(vote["candidates"].count).to eq 5
        expect(vote["candidates"][0]).to eq 'allocate1'
      end
    end

    context "the candidates table" do
      subject {command %(cleos get table daccustodian daccustodian candidates --limit 40), allow_error: true}
      it do
        json = JSON.parse(subject.stdout)

        expect(json["rows"].count).to eq 25

        delayedcandidates = json["rows"].select {|v| v["custodian_end_time_stamp"] > "1970-01-01T00:00:00"}
        expect(delayedcandidates.count).to eq(13)

        # custnames = json["rows"].map { |c| c["candidate_name"] }
        # puts custnames
        # expect(custnames).to eq ["allocate1", "allocate11", "allocate12", "allocate2", "allocate21", "allocate22", "allocate3", "allocate31", "allocate32", "allocate4", "allocate41", "allocate5"]
      end
    end

    context "the custodians table" do
      command %(cleos get table daccustodian daccustodian custodians --limit 20), allow_error: true
      it do
        json = JSON.parse(subject.stdout)
        expect(json["rows"].count).to eq 12

        custodian = json["rows"].detect {|v| v["cust_name"] == 'allocate11'}
        expect(custodian["total_votes"]).to eq 14080000

        custodian = json["rows"].detect {|v| v["cust_name"] == 'allocate1'}
        expect(custodian["total_votes"]).to eq 30000000

        custodian = json["rows"].detect {|v| v["cust_name"] == 'allocate4'}
        expect(custodian["total_votes"]).to eq 31100000

        custnames = json["rows"].map {|c| c["cust_name"]}

        # allocate32 was dropped and then allocate51 took the spot
        expect(custnames).to eq ["allocate1", "allocate11", "allocate12", "allocate2", "allocate21", "allocate22", "allocate3", "allocate31", "allocate4", "allocate41", "allocate5", "allocate51"]
      end
    end
  end

  describe "claimpay" do
    context "with invalid payId should fail" do
      command %(cleos push action daccustodian claimpay '{ "payid": 100}' -p votedcust4), allow_error: true
      its(:stderr) {is_expected.to include('Invalid pay claim id')}
    end

    context "claiming for a different acount should fail" do
      command %(cleos push action daccustodian claimpay '{ "payid": 10}' -p votedcust4), allow_error: true
      its(:stderr) {is_expected.to include('missing authority of allocate41')}
    end

    context "Before claiming pay the balance should be 0" do
      command %(cleos get currency balance eosio.token dacocoiogmbh EOS), allow_error: true
      its(:stdout) {is_expected.to eq('')}
    end

    context "claiming for the correct account with matching auth should succeed" do
      command %(cleos push action daccustodian claimpay '{ "payid": 1 }' -p allocate11), allow_error: true
      its(:stdout) {is_expected.to include('daccustodian::claimpay')}
      # exit
    end

    context "After claiming for the correct should be added to the claimer" do
      command %(cleos get currency balance eosio.token dacocoiogmbh EOS), allow_error: true
      its(:stdout) {is_expected.not_to include('17.0000 EOS')} # eventually this would pass but now it's time delayed I cannot assert.
    end

    context "After claiming for the correct should be added to the claimer" do
      before(:each) { sleep 12 }
      command %(cleos get currency balance eosio.token dacocoiogmbh EOS), allow_error: true
      its(:stdout) {is_expected.to include('16.7500 EOS')} # eventually this would pass but now it's time delayed I cannot assert.
    end
  end

  describe "withdrawcand" do
    context "when the auth is wrong" do
      command %(cleos push action daccustodian withdrawcand '{ "cand": "allocate41"}' -p allocate4), allow_error: true
      its(:stderr) {is_expected.to include('missing authority of allocate41')}
    end

    context "when the auth is correct" do
      command %(cleos push action daccustodian withdrawcand '{ "cand": "allocate41"}' -p allocate41), allow_error: true
      its(:stdout) {is_expected.to include('daccustodian::withdrawcand')}
    end

    context "the candidates table" do
      subject {command %(cleos get table daccustodian daccustodian candidates --limit 40), allow_error: true}
      it do
        json = JSON.parse(subject.stdout)

        expect(json["rows"].count).to eq 25

        delayedcandidatescount = json["rows"].count {|v| v["custodian_end_time_stamp"] > "1970-01-01T00:00:00"}
        expect(delayedcandidatescount).to eq(13)

        inactiveCandidatesCount = json["rows"].count {|v| v["is_active"] == 0}
        expect(inactiveCandidatesCount).to eq(2)

        inactiveCand = json["rows"].detect {|v| v["candidate_name"] == 'allocate41'}
        expect(inactiveCand["is_active"]).to eq(0)
      end
    end
  end

  describe "rereg custodian candidate" do
    context "with valid and registered member after transferring sufficient staked tokens in multiple transfers" do
      before(:all) do
        `cleos push action eosdactokens transfer '{ "from": "allocate41", "to": "daccustodian", "quantity": "10.0000 EOSDAC","memo":"daccustodian"}' -p allocate41 -f`
      end
      command %(cleos push action daccustodian nominatecand '{ "cand": "allocate41" "requestedpay": "11.5000 EOS"}' -p allocate41), allow_error: true
      its(:stdout) {is_expected.to include('daccustodian::nominatecand')}
    end

    context "Read the custodians table after unreg custodian and a single vote will be replaced" do
      command %(cleos get table daccustodian daccustodian candidates --limit 40), allow_error: true
      it do
        json = JSON.parse(subject.stdout)
        expect(json["rows"].count).to eq 25

        candidate = json["rows"].detect {|v| v["candidate_name"] == 'allocate41'}
        expect(candidate["total_votes"]).to eq 14080000
        expect(candidate["candidate_name"]).to eq 'allocate41'
        expect(candidate["requestedpay"]).to eq '11.5000 EOS'
        expect(candidate["locked_tokens"]).to eq "33.0000 EOSDAC"
        expect(candidate["custodian_end_time_stamp"]).to be > "1970-01-01T00:00:00"
      end
    end
  end

  describe "resign cust" do
    context "with invalid auth" do
      command %(cleos push action daccustodian resigncust '{ "cust": "allocate31"}' -p allocate3), allow_error: true
      its(:stderr) {is_expected.to include('missing authority of allocate31')}
    end

    context "with a candidate who is not an elected custodian" do
      command %(cleos push action daccustodian resigncust '{ "cust": "votedcust3"}' -p votedcust3), allow_error: true
      its(:stderr) {is_expected.to include('The entered account name is not for a current custodian.')}
    end

    context "when the auth is correct" do
      command %(cleos push action daccustodian resigncust '{ "cust": "allocate31"}' -p allocate31), allow_error: true
      its(:stdout) {is_expected.to include('daccustodian::resigncust')}
    end

    context "Read the state" do
      command %(cleos get table daccustodian daccustodian state), allow_error: true
      it do

        json = JSON.parse(subject.stdout)
        expect(json["rows"].count).to eq 1

        state = json["rows"][0]
        expect(state["total_weight_of_votes"]).to eq 45180000
        expect(state["total_votes_on_candidates"]).to eq 225900000
        expect(state["number_active_candidates"]).to eq 23
        expect(state["met_initial_votes_threshold"]).to eq 1
      end
    end

    context "the custodians table" do
      command %(cleos get table daccustodian daccustodian custodians --limit 20), allow_error: true
      it do
        json = JSON.parse(subject.stdout)
        expect(json["rows"].count).to eq 12

        custodian = json["rows"].detect {|v| v["cust_name"] == 'allocate11'}
        expect(custodian["total_votes"]).to eq 14080000

        custodian = json["rows"].detect {|v| v["cust_name"] == 'allocate1'}
        expect(custodian["total_votes"]).to eq 30000000

        custodian = json["rows"].detect {|v| v["cust_name"] == 'allocate4'}
        expect(custodian["total_votes"]).to eq 31100000

      end
    end

    context "Read the candidates table after resign cust" do
      command %(cleos get table daccustodian daccustodian candidates --limit 40), allow_error: true
      it do
        json = JSON.parse(subject.stdout)
        expect(json["rows"].count).to eq 25

        candidate = json["rows"].detect {|v| v["candidate_name"] == 'allocate31'}

        expect(candidate["candidate_name"]).to eq 'allocate31'
        expect(candidate["requestedpay"]).to eq "18.0000 EOS"
        expect(candidate["locked_tokens"]).to eq "23.0000 EOSDAC"
        expect(candidate["custodian_end_time_stamp"]).to be > "1970-01-01T00:00:00"
        expect(candidate["is_active"]).to eq(0)
      end
    end
  end

  describe "unstake" do
    context "for an elected custodian" do
      command %(cleos push action daccustodian unstake '{ "cand": "allocate41"}' -p allocate41), allow_error: true
      its(:stderr) {is_expected.to include('Cannot unstake tokens for an active candidate. Call withdrawcand first.')}
    end

    context "for a unelected custodian" do
      context "who has not withdrawn as a candidate" do
        command %(cleos push action daccustodian unstake '{ "cand": "votedcust2"}' -p votedcust2), allow_error: true
        its(:stderr) {is_expected.to include('Cannot unstake tokens for an active candidate. Call withdrawcand first.')}
      end

      context "who has withdrawn as a candidate" do
        command %(cleos push action daccustodian unstake '{ "cand": "allocate31"}' -p allocate31), allow_error: true
        its(:stderr) {is_expected.to include('Cannot unstake tokens before they are unlocked from the time delay.')}
      end
    end

    context "Before unstaking the token should note have been transferred back" do
      command %(cleos get currency balance eosdactokens unreguser2 EOSDAC), allow_error: true
      its(:stdout) {is_expected.to include('77.0000 EOSDAC')}
    end

    context "for a resigned custodian after time expired" do
      command %(cleos push action daccustodian unstake '{ "cand": "unreguser2"}' -p unreguser2), allow_error: true
      its(:stdout) {is_expected.to include('daccustodian::unstake')}
    end

    context "After successful unstaking the token should have been transferred back" do
      command %(cleos get currency balance eosdactokens unreguser2 EOSDAC), allow_error: true
      its(:stdout) {is_expected.to include('77.0000 EOSDAC')}
    end

    context "After successful unstaking the token should have been transferred back" do
      before(:each) { sleep 12 }
      command %(cleos get currency balance eosdactokens unreguser2 EOSDAC), allow_error: true
      its(:stdout) {is_expected.to include('100.0000 EOSDAC')}
    end
  end

  describe "fire cand" do
    context "with invalid auth" do
      command %(cleos push action daccustodian firecand '{ "cand": "votedcust4", "lockupStake": true}' -p votedcust4), allow_error: true
      its(:stderr) {is_expected.to include('missing authority of dacauthority')}
    end

    xcontext "with valid auth" do # Needs further work to understand how this could be tested.
      context "without locked up stake" do
        command %(cleos multisig propose fireproposal '[{"actor": "dacauthority", "permission": "med"}]' '[{"actor": "allocate2", "permission": "active"}, {"actor": "allocate3", "permission": "active"}]' daccustodian firecand '{ "cand": "votedcust4", "lockupStake": false}' -p dacauthority@active -sdj), allow_error: true
        its(:stderr) {is_expected.to include('Cannot unstake tokens before they are unlocked from the time delay.')}
      end
      context "with locked up stake" do
        command %(cleos push action daccustodian firecand '{ "cand": "votedcust5", "lockupStake": true}' -p dacauthority), allow_error: true
        its(:stderr) {is_expected.to include('Cannot unstake tokens before they are unlocked from the time delay.')}
      end
    end

    context "Read the candidates table after fire candidate" do
      command %(cleos get table daccustodian daccustodian candidates --limit 40), allow_error: true
      it do
        json = JSON.parse(subject.stdout)
        expect(json["rows"].count).to eq 25

        candidate = json["rows"].detect {|v| v["candidate_name"] == 'votedcust4'}

        expect(candidate["candidate_name"]).to eq 'votedcust4'
        expect(candidate["requestedpay"]).to eq "14.0000 EOS"
        expect(candidate["locked_tokens"]).to eq "23.0000 EOSDAC"
        expect(candidate["custodian_end_time_stamp"]).to eq "1970-01-01T00:00:00"

        #expect(candidate["is_active"]).to eq(0) # Since the multisig is not yet working in the tests this will fail.

        candidate = json["rows"].detect {|v| v["candidate_name"] == 'votedcust5'}

        expect(candidate["candidate_name"]).to eq 'votedcust5'
        expect(candidate["requestedpay"]).to eq "15.0000 EOS"
        expect(candidate["locked_tokens"]).to eq "23.0000 EOSDAC"
        # expect(candidate["custodian_end_time_stamp"]).to be > "2018-01-01T00:00:00" # Will fail due to the multisig not being testable at the moment.
        # expect(candidate["is_active"]).to eq(0) # Will fail due to the multisig not being testable at the moment.
      end
    end
  end

  xdescribe "fire custodian" do
    context "with invalid auth" do
      command %(cleos push action daccustodian firecust '{ "cust": "allocate1"}' -p allocate31), allow_error: true
      its(:stderr) {is_expected.to include('missing authority of dacauthority')}
    end

    context "with valid auth" do
      command %(cleos push action daccustodian firecust '{ "cust": "allocate1"}' -p dacauthority), allow_error: true
      its(:stderr) {is_expected.to include('Cannot unstake tokens before they are unlocked from the time delay.')}
    end

    context "Read the candidates table after fire candidate" do
      command %(cleos get table daccustodian daccustodian candidates --limit 40), allow_error: true
      it do
        json = JSON.parse(subject.stdout)
        expect(json["rows"].count).to eq 25

        candidate = json["rows"].detect {|v| v["candidate_name"] == 'allocate1'}

        expect(candidate["candidate_name"]).to eq 'allocate1'
        expect(candidate["requestedpay"]).to eq "18.0000 EOS"
        expect(candidate["locked_tokens"]).to eq "23.0000 EOSDAC"
        expect(candidate["custodian_end_time_stamp"]).to be eq "1970-01-01T00:00:00"
        expect(candidate["is_active"]).to eq(0)

        candidate = json["rows"].detect {|v| v["candidate_name"] == 'allocate11'}

        expect(candidate["candidate_name"]).to eq 'allocate11'
        expect(candidate["requestedpay"]).to eq "18.0000 EOS"
        expect(candidate["locked_tokens"]).to eq "23.0000 EOSDAC"
        expect(candidate["custodian_end_time_stamp"]).to be > "2018-01-01T00:00:00"
        expect(candidate["is_active"]).to eq(0)
      end
    end

    context "Read the custodians table" do
      command %(cleos get table daccustodian daccustodian custodians --limit 20), allow_error: true
      it do
        json = JSON.parse(subject.stdout)
        expect(json["rows"].count).to eq 12

        custodian = json["rows"].detect {|v| v["cust_name"] == 'allocate11'}
        expect(custodian["total_votes"]).to eq 14080000

        custodian = json["rows"].detect {|v| v["cust_name"] == 'allocate1'}
        expect(custodian["total_votes"]).to eq 30000000

        custodian = json["rows"].detect {|v| v["cust_name"] == 'allocate4'}
        expect(custodian["total_votes"]).to eq 31100000

      end
    end
  end
end

