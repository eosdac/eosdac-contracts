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

CONTRACT_OWNER_PRIVATE_KEY = '5KYuGgAQUagSKsM66BpGsBhp9vFNnPEWuNjP5v4XHubUBY8j4KW'
CONTRACT_OWNER_PUBLIC_KEY = 'EOS54b6gLjogLNRS4Ay3JRxAke5r35FC6ZmJTTgVVeCrtbsYaNs9k'

CONTRACT_ACTIVE_PRIVATE_KEY = '5KYuGgAQUagSKsM66BpGsBhp9vFNnPEWuNjP5v4XHubUBY8j4KW'
CONTRACT_ACTIVE_PUBLIC_KEY = 'EOS54b6gLjogLNRS4Ay3JRxAke5r35FC6ZmJTTgVVeCrtbsYaNs9k'

CONTRACT_NAME = 'dacmultisigs'
ACCOUNT_NAME = 'dacmultisigs'

CONTRACTS_DIR = 'tests/dependencies'

def configure_wallet
  beforescript = <<~SHELL

    cleos wallet unlock --password `cat ~/eosio-wallet/.pass`
    cleos wallet import --private-key #{CONTRACT_ACTIVE_PRIVATE_KEY}
    cleos wallet import --private-key #{EOSIO_PVT}
  SHELL

  `#{beforescript}`
end

# @param [eos account name for the new account] name
def seed_account(name)
  `cleos system newaccount --stake-cpu "10.0000 EOS" --stake-net "10.0000 EOS" --transfer --buy-ram-kbytes 1024 eosio #{name} #{CONTRACT_ACTIVE_PUBLIC_KEY} #{CONTRACT_ACTIVE_PUBLIC_KEY}`
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
    set -x

    # eosio-abigen dacmultisigs.cpp -output dacmultisigs.abi
    eosio-cpp -o dacmultisigs.wast dacmultisigs.cpp

    cleos system newaccount --stake-cpu \"10.0000 EOS\" --stake-net \"10.0000 EOS\" --transfer --buy-ram-kbytes 1024 eosio #{ACCOUNT_NAME} #{CONTRACT_OWNER_PUBLIC_KEY} #{CONTRACT_ACTIVE_PUBLIC_KEY}

    cleos set code #{ACCOUNT_NAME} #{ACCOUNT_NAME}.wast -p #{ACCOUNT_NAME}
    cleos set abi #{ACCOUNT_NAME} #{ACCOUNT_NAME}.abi -p #{ACCOUNT_NAME}

  SHELL

  `#{beforescript}`
  exit() unless $? == 0
end

def killchain
  # `sleep 0.5; kill \`pgrep nodeos\``
end

# Configure the initial state for the contracts for elements that are assumed to work from other contracts already.
def configure_contracts_for_tests

  #create users
  seed_account("validuser1")
  seed_account("invaliduser1")
end

describe "dacmultisigs" do
  before(:all) do
    reset_chain
    configure_wallet
    seed_system_contracts
    install_contracts
    configure_contracts_for_tests
  end

  after(:all) do
    killchain
  end

  describe "stproposal" do
    context "without valid auth" do
      command %(cleos push action dacmultisigs stproposal '{ "transactionid": "579159b224ebd9c0a3d36b1c53ae97a2df96025a054b29b62f1534ecfed080bf", "proposer": "validuser1", "proposalname": "myproposal"}' -p invaliduser1
), allow_error: true
      its(:stderr) {is_expected.to include('Error 3090004')}
    end

    context "with valid auth" do
      command %(cleos push action dacmultisigs stproposal '{ "transactionid": "579159b224ebd9c0a3d36b1c53ae97a2df96025a054b29b62f1534ecfed080bf", "proposer": "validuser1", "proposalname": "myproposal"}' -p validuser1
), allow_error: true
      its(:stdout) {is_expected.to include('dacmultisigs::stproposal')}
    end
  end
end

