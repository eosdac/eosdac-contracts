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

CONTRACT_NAME = 'dacdirectory'
ACCOUNT_NAME = 'dacdirectory'

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

def configure_dac_accounts
  beforescript = <<~SHELL
    # set -x
    cleos system newaccount --stake-cpu \"10.0000 EOS\" --stake-net \"10.0000 EOS\" --transfer --buy-ram-kbytes 1024 eosio dacdirectory #{CONTRACT_OWNER_PUBLIC_KEY} #{CONTRACT_ACTIVE_PUBLIC_KEY}

    cleos system newaccount --stake-cpu \"10.0000 EOS\" --stake-net \"10.0000 EOS\" --transfer --buy-ram-kbytes 1024 eosio dacdirtester #{CONTRACT_OWNER_PUBLIC_KEY} #{CONTRACT_ACTIVE_PUBLIC_KEY}

    cleos system newaccount --stake-cpu \"10.0000 EOS\" --stake-net \"10.0000 EOS\" --transfer --buy-ram-kbytes 1024 eosio ow #{CONTRACT_OWNER_PUBLIC_KEY} #{CONTRACT_ACTIVE_PUBLIC_KEY}
    cleos system newaccount --stake-cpu \"10.0000 EOS\" --stake-net \"10.0000 EOS\" --transfer --buy-ram-kbytes 1024 eosio testaccount1 #{CONTRACT_OWNER_PUBLIC_KEY} #{CONTRACT_ACTIVE_PUBLIC_KEY}
    cleos system newaccount --stake-cpu \"10.0000 EOS\" --stake-net \"10.0000 EOS\" --transfer --buy-ram-kbytes 1024 eosio testaccount2 #{CONTRACT_OWNER_PUBLIC_KEY} #{CONTRACT_ACTIVE_PUBLIC_KEY}

  SHELL

  `#{beforescript}`
  exit() unless $? == 0
end

def install_dependencies

  beforescript = <<~SHELL
    # set -x
    cleos set contract #{ACCOUNT_NAME} ../_compiled_contracts/dacdirectory/unit_tests/#{CONTRACT_NAME} -p #{ACCOUNT_NAME}
    cleos set contract dacdirtester ../_test_helpers/dacdirtester/dacdirtester -p dacdirtester

  SHELL

  `#{beforescript}`
  exit() unless $? == 0
end

# Configure the initial state for the contracts for elements that are assumed to work from other contracts already.
def configure_contracts
  # configure accounts for eosdactokens

end

def killchain
  `sleep 0.5; kill \`pgrep nodeos\``
end

describe "dacdirectory" do
  before(:all) do
    reset_chain
    configure_wallet
    seed_system_contracts
    configure_dac_accounts
    install_dependencies
    configure_contracts
  end

  after(:all) do
    # killchain
  end

  describe "regdac" do
    context "Without valid permission" do
      command %(cleos push action dacdirectory regdac '{"owner": "testaccount1", "dac_name": "mydacname", "dac_symbol": "4,MYSYM", "title": "Dac Title", "refs": [[1,"some_ref"]], "accounts": [[1,"account1"]], "scopes": []}' -p testaccount2), allow_error: true
      its(:stderr) {is_expected.to include('missing authority of testaccount1')}
    end
    context "With valid permission" do
      command %(cleos push action dacdirectory regdac '{"owner": "testaccount1", "dac_name": "mydacname", "dac_symbol": "4,MYSYM", "title": "Dac Title", "refs": [[1,"some_ref"]], "accounts": [[1,"account1"]], "scopes": []}' -p testaccount1), allow_error: true
      its(:stdout) {is_expected.to include('dacdirectory::regdac')}
    end
    context "Read the dacs table after regdac" do
      command %(cleos get table dacdirectory dacdirectory dacs), allow_error: true
      it do
        expect(JSON.parse(subject.stdout)).to eq JSON.parse <<~JSON
          {
            "rows": [{
                "owner": "testaccount1",
                "dac_name": "mydacname",
                "title": "Dac Title",
                "symbol": "4,MYSYM",
                "refs": [{
                    "key": 1,
                    "value": "some_ref"
                  }
                ],
                "accounts": [{
                    "key": 1,
                    "value": "account1"
                  }
                ],
                "scopes": []
              }
            ],
            "more": false
          }
        JSON
      end
    end
  end
  describe "regaccount" do
    context "Without valid permission" do
      command %(cleos push action dacdirectory regaccount '{ "dac_name": "mydacname", "account": "testaccount2", "type": 3, "scope": ""}' -p testaccount2), allow_error: true
      its(:stderr) {is_expected.to include('missing authority of testaccount1')}
    end
    context "With valid permission" do
      command %(cleos push action dacdirectory regaccount '{ "dac_name": "mydacname", "account": "testaccount2", "type": 1, "scope": "helloworld"}' -p testaccount1), allow_error: true
      its(:stdout) {is_expected.to include('dacdirectory::regaccount')}
    end
    context "Read the dacs table after regaccount" do
      command %(cleos get table dacdirectory dacdirectory dacs), allow_error: true
      it do
        expect(JSON.parse(subject.stdout)).to eq JSON.parse <<~JSON
          {
            "rows": [{
                "owner": "testaccount1",
                "dac_name": "mydacname",
                "title": "Dac Title",
                "symbol": "4,MYSYM",
                "refs": [{
                    "key": 1,
                    "value": "some_ref"
                  }
                ],
                "accounts": [{
                    "key": 1,
                    "value": "testaccount2"
                  }
                ],
                "scopes": [{
                    "key": 1,
                    "value": "helloworld"
                  }
                ]
              }
            ],
            "more": false
          }
        JSON
      end
    end
  end

  describe "unregaccount" do
    context "Without valid permission" do
      command %(cleos push action dacdirectory unregaccount '{ "dac_name": "mydacname", "type": 3}' -p testaccount2), allow_error: true
      its(:stderr) {is_expected.to include('missing authority of testaccount1')}
    end
    context "With valid permission" do
      command %(cleos push action dacdirectory unregaccount '{ "dac_name": "mydacname", "type": 3 }' -p testaccount1), allow_error: true
      its(:stdout) {is_expected.to include('dacdirectory::unregaccount')}
    end
    context "Read the dacs table after unregaccount" do
      command %(cleos get table dacdirectory dacdirectory dacs), allow_error: true
      it do
        expect(JSON.parse(subject.stdout)).to eq JSON.parse <<~JSON
          {
            "rows": [{
                "owner": "testaccount1",
                "dac_name": "mydacname",
                "title": "Dac Title",
                "symbol": "4,MYSYM",
                "refs": [{
                    "key": 1,
                    "value": "some_ref"
                  }
                ],
                "accounts": [{
                    "key": 1,
                    "value": "testaccount2"
                  }
                ],
                "scopes": [{
                    "key": 1,
                    "value": "helloworld"
                  }
                ]
              }
            ],
            "more": false
          }
        JSON
      end
    end
  end

  describe "setowner" do
    context "Without valid permission" do
      command %(cleos push action dacdirectory setowner '{ "dac_name": "mydacname", "new_owner": "testaccount2"}' -p testaccount2), allow_error: true
      its(:stderr) {is_expected.to include('missing authority of testaccount1')}
    end
    context "With valid permission" do
      command %(cleos push action dacdirectory setowner '{ "dac_name": "mydacname", "new_owner": "testaccount2"}' -p testaccount1 -p testaccount2), allow_error: true
      its(:stdout) {is_expected.to include('dacdirectory::setowner')}
    end
    context "Read the dacs table after regaccount" do
      command %(cleos get table dacdirectory dacdirectory dacs), allow_error: true
      it do
        expect(JSON.parse(subject.stdout)).to eq JSON.parse <<~JSON
          {
            "rows": [{
                "owner": "testaccount2",
                "dac_name": "mydacname",
                "title": "Dac Title",
                "symbol": "4,MYSYM",
                "refs": [{
                    "key": 1,
                    "value": "some_ref"
                  }
                ],
                "accounts": [
                  {
                    "key": 1,
                    "value": "testaccount2"
                  }
                ],
                "scopes": [{"key": 1, "value": "helloworld"}]
              }
            ],
            "more": false
          }
        JSON
      end
    end
  end

  describe "read scope from contract" do
    context "with explicit value" do
      command %(cleos push action dacdirtester assdacscope '{ "dac_name": "mydacname","scope_type": 1}' -p testaccount2), allow_error: true
      its(:stdout) {is_expected.to include('found scope: helloworld')}
    end
    context "without explicit value" do
      command %(cleos push action dacdirtester assdacscope '{ "dac_name": "mydacname","scope_type": 3}' -p testaccount2), allow_error: true
      its(:stdout) {is_expected.to include('found scope: mydacname')}
    end
  end

  describe "unregdac" do
    context "Without valid permission" do
      command %(cleos push action dacdirectory unregdac '{ "dac_name": "mydacname"}' -p testaccount1), allow_error: true
      its(:stderr) {is_expected.to include('missing authority of testaccount2')}
    end
    context "With valid permission" do
      command %(cleos push action dacdirectory unregdac '{ "dac_name": "mydacname"}' -p testaccount2), allow_error: true
      its(:stdout) {is_expected.to include('dacdirectory::unregdac')}
    end
    context "Read the dacs table after regaccount" do
      command %(cleos get table dacdirectory dacdirectory dacs), allow_error: true
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
end



