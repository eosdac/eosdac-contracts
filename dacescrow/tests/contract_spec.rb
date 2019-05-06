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

CONTRACT_NAME = 'dacescrow'
ACCOUNT_NAME = 'dacescrow'

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
def seed_dac_account(name, issue: nil, memberreg: nil, stake: nil, requestedpay: nil)
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

def configure_dac_accounts
  beforescript = <<~SHELL
   # set -x
   cleos system newaccount --stake-cpu \"10.0000 EOS\" --stake-net \"10.0000 EOS\" --transfer --buy-ram-kbytes 1024 eosio daccustodian #{CONTRACT_OWNER_PUBLIC_KEY} #{CONTRACT_ACTIVE_PUBLIC_KEY}
   cleos system newaccount --stake-cpu \"10.0000 EOS\" --stake-net \"10.0000 EOS\" --transfer --buy-ram-kbytes 1024 eosio eosdactokens #{CONTRACT_OWNER_PUBLIC_KEY} #{CONTRACT_ACTIVE_PUBLIC_KEY}
   cleos system newaccount --stake-cpu \"10.0000 EOS\" --stake-net \"10.0000 EOS\" --transfer --buy-ram-kbytes 1024 eosio dacauthority #{CONTRACT_OWNER_PUBLIC_KEY} #{CONTRACT_ACTIVE_PUBLIC_KEY}
   cleos system newaccount --stake-cpu \"10.0000 EOS\" --stake-net \"10.0000 EOS\" --transfer --buy-ram-kbytes 1024 eosio eosdacthedac #{CONTRACT_OWNER_PUBLIC_KEY} #{CONTRACT_ACTIVE_PUBLIC_KEY}
   cleos system newaccount --stake-cpu \"10.0000 EOS\" --stake-net \"10.0000 EOS\" --transfer --buy-ram-kbytes 1024 eosio dacocoiogmbh #{CONTRACT_OWNER_PUBLIC_KEY} #{CONTRACT_ACTIVE_PUBLIC_KEY}
   cleos system newaccount --stake-cpu \"10.0000 EOS\" --stake-net \"10.0000 EOS\" --transfer --buy-ram-kbytes 1024 eosio dacproposals #{CONTRACT_OWNER_PUBLIC_KEY} #{CONTRACT_ACTIVE_PUBLIC_KEY}
   cleos system newaccount --stake-cpu \"10.0000 EOS\" --stake-net \"10.0000 EOS\" --transfer --buy-ram-kbytes 1024 eosio dacescrow #{CONTRACT_OWNER_PUBLIC_KEY} #{CONTRACT_ACTIVE_PUBLIC_KEY}

   # Setup the inital permissions.
   cleos set account permission dacauthority owner '{"threshold": 1,"keys": [{"key": "#{CONTRACT_ACTIVE_PUBLIC_KEY}","weight": 1}],"accounts": [{"permission":{"actor":"daccustodian","permission":"eosio.code"},"weight":1}]}' '' -p dacauthority@owner
   # cleos set account permission eosdacthedac active '{"threshold": 1,"keys": [{"key": "#{CONTRACT_ACTIVE_PUBLIC_KEY}","weight": 1}],"accounts": [{"permission":{"actor":"daccustodian","permission":"eosio.code"},"weight":1}]}' owner -p eosdacthedac@owner
   cleos set account permission daccustodian xfer '{"threshold": 1,"keys": [{"key": "#{CONTRACT_ACTIVE_PUBLIC_KEY}","weight": 1}],"accounts": [{"permission":{"actor":"daccustodian","permission":"eosio.code"},"weight":1}]}' active -p eosdacthedac@active
   cleos push action eosio.token issue '["eosdacthedac", "100000.0000 EOS", "Initial EOS amount."]' -p eosio

   cleos set action permission eosdacthedac eosdactokens transfer xfer
   cleos set action permission eosdacthedac eosio.token transfer xfer  
   cleos set action permission daccustodian eosdactokens transfer xfer  
 
   # Configure accounts permissions hierarchy
   cleos set account permission dacauthority high #{CONTRACT_OWNER_PUBLIC_KEY} owner -p dacauthority@owner 
   cleos set account permission dacauthority med #{CONTRACT_OWNER_PUBLIC_KEY} high -p dacauthority@owner 
   cleos set account permission dacauthority low #{CONTRACT_OWNER_PUBLIC_KEY} med -p dacauthority@owner 
   cleos set account permission dacauthority one #{CONTRACT_OWNER_PUBLIC_KEY} low -p dacauthority@owner   

   cleos set account permission #{ACCOUNT_NAME} active '{"threshold": 1,"keys": [{"key": "#{CONTRACT_ACTIVE_PUBLIC_KEY}","weight": 1}],"accounts": [{"permission":{"actor":"#{ACCOUNT_NAME}","permission":"eosio.code"},"weight":1}]}' owner -p #{ACCOUNT_NAME}

  SHELL

  `#{beforescript}`
  exit() unless $? == 0
end

def install_dependencies

  beforescript = <<~SHELL
   # set -x


   cleos set contract eosdactokens ../_compiled_contracts/eosdactokens/unit_tests/eosdactokens -p eosdactokens
   cleos set contract daccustodian ../_compiled_contracts/daccustodian/unit_tests/daccustodian -p daccustodian
   cleos set contract dacproposals ../_compiled_contracts/dacproposals/unit_tests/dacproposals -p dacproposals

   cleos set contract #{ACCOUNT_NAME} ../_compiled_contracts/#{ACCOUNT_NAME}/unit_tests/#{ACCOUNT_NAME} -p #{ACCOUNT_NAME}

  SHELL

  `#{beforescript}`
  exit() unless $? == 0
end

# Configure the initial state for the contracts for elements that are assumed to work from other contracts already.
def configure_contracts
  # configure accounts for eosdactokens
  `cleos push action eosdactokens updateconfig '["daccustodian"]' -p eosdactokens`
  `cleos push action eosdactokens create '{ "issuer": "eosdactokens", "maximum_supply": "100000.0000 EOSDAC", "transfer_locked": false}' -p eosdactokens`
  `cleos push action eosdactokens issue '{ "to": "eosdactokens", "quantity": "78337.0000 EOSDAC", "memo": "Initial amount of tokens for you."}' -p eosdactokens`
  `cleos push action eosio.token issue '{ "to": "eosdacthedac", "quantity": "100000.0000 EOS", "memo": "Initial EOS amount."}' -p eosio`

  #create users
  # Ensure terms are registered in the token contract
  `cleos push action eosdactokens newmemterms '{ "terms": "normallegalterms", "hash": "New Latest terms"}' -p eosdactokens`

  #create users
  seed_dac_account("sender1", issue: "100.0000 EOSDAC", memberreg: "New Latest terms")
  seed_dac_account("sender2", issue: "100.0000 EOSDAC", memberreg: "New Latest terms")
  seed_dac_account("sender3", issue: "100.0000 EOSDAC", memberreg: "New Latest terms")
  seed_dac_account("sender4", issue: "100.0000 EOSDAC", memberreg: "New Latest terms")
  seed_dac_account("receiver1", issue: "100.0000 EOSDAC", memberreg: "New Latest terms")
  seed_dac_account("arb1", issue: "100.0000 EOSDAC", memberreg: "New Latest terms")
  seed_dac_account("arb2", issue: "100.0000 EOSDAC", memberreg: "New Latest terms")

  `cleos push action eosio.token issue '{ "to": "sender1", "quantity": "1000.0000 EOS", "memo": "Initial EOS amount."}' -p eosio`
  `cleos push action eosio.token issue '{ "to": "sender2", "quantity": "1000.0000 EOS", "memo": "Initial EOS amount."}' -p eosio`
  `cleos push action eosio.token issue '{ "to": "sender3", "quantity": "1000.0000 EOS", "memo": "Initial EOS amount."}' -p eosio`
  `cleos push action eosio.token issue '{ "to": "sender4", "quantity": "1000.0000 EOS", "memo": "Initial EOS amount."}' -p eosio`
end

def killchain
  `sleep 0.5; kill \`pgrep nodeos\``
end

describe "dacescrow" do
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

  context "Using internal key" do

  describe "init" do
    context "Without valid permission" do
      context "with valid and registered member" do
        command %(cleos push action dacescrow init '{"sender": "sender1", "receiver": "receiver1", "arb": "arb1", "expires": "2019-01-20T23:21:43.528", "memo": "some memo", "ext_reference": null}' -p sender2), allow_error: true
        its(:stderr) {is_expected.to include('missing authority of sender1')}
      end
    end

    context "with valid auth" do
      command %(cleos push action dacescrow init '{"sender": "sender1", "receiver": "receiver1", "arb": "arb1", "expires": "2019-01-20T23:21:43.528", "memo": "some memo", "ext_reference": null}' -p sender1), allow_error: true
      its(:stdout) {is_expected.to include('dacescrow <= dacescrow::init')}

      context "with an existing escrow entry" do
        command %(cleos push action dacescrow init '{"sender": "sender1", "receiver": "receiver1", "arb": "arb1", "expires": "2019-01-20T23:21:43.528", "memo": "some other memo", "ext_reference": null}' -p sender1), allow_error: true
        its(:stderr) {is_expected.to include('You already have an empty escrow.  Either fill it or delete it')}
      end
    end
    context "Read the escrow table after init" do
      command %(cleos get table dacescrow dacescrow escrows), allow_error: true
      it do
        expect(JSON.parse(subject.stdout)).to eq JSON.parse <<~JSON
            {
              "rows": [{
                  "key": 0,
                  "sender": "sender1",
                  "receiver": "receiver1",
                  "arb": "arb1",
                  "approvals": [],
                  "ext_asset": {"quantity":"0.0000 EOS", "contract":"eosio.token"},    
                  "memo": "some memo",
                  "expires": "2019-01-20T23:21:43",
                  "external_reference": "18446744073709551615"
                }
              ],
              "more": false
            }
        JSON
      end
    end
  end

  describe "transfer" do
    context "without valid auth" do
      command %(cleos push action eosio.token transfer '{"from": "sender1", "to": "dacescrow", "quantity": "5.0000 EOS", "memo": "here is a memo" }' -p sender2), allow_error: true
      its(:stderr) {is_expected.to include('missing authority of sender1')}
    end
    context "without a valid escrow" do
      command %(cleos push action eosio.token transfer '{"from": "sender2", "to": "dacescrow", "quantity": "5.0000 EOS", "memo": "here is a memo" }' -p sender2), allow_error: true
      its(:stderr) {is_expected.to include('Could not find existing escrow to deposit to, transfer cancelled')}
    end
    context "balance should not have reduced from 1000.0000 EOS" do
      command %(cleos get currency balance eosio.token sender1 EOS), allow_error: true
      it do
        expect(subject.stdout).to eq <<~JSON
            1000.0000 EOS
        JSON
      end
    end
    context "with a valid escrow" do
      command %(cleos push action eosio.token transfer '{"from": "sender1", "to": "dacescrow", "quantity": "5.0000 EOS", "memo": "here is a memo" }' -p sender1), allow_error: true
      its(:stdout) {is_expected.to include('dacescrow <= eosio.token::transfer')}
    end
    context "balance should have reduced to 995.0000 EOS" do
      command %(cleos get currency balance eosio.token sender1 EOS), allow_error: true
      it do
        expect(subject.stdout).to eq <<~JSON
            995.0000 EOS
        JSON
      end
    end
    context "balance of dacescrow should have increased by 5.0000 EOS" do
      command %(cleos get currency balance eosio.token dacescrow EOS), allow_error: true
      it do
        expect(subject.stdout).to eq <<~JSON
            5.0000 EOS
        JSON
      end
    end
    context "Read the escrow table after init" do
      command %(cleos get table dacescrow dacescrow escrows), allow_error: true
      it do
        expect(JSON.parse(subject.stdout)).to eq JSON.parse <<~JSON
            {
              "rows": [{
                  "key": 0,
                  "sender": "sender1",
                  "receiver": "receiver1",
                  "arb": "arb1",
                  "approvals": [],
                  "ext_asset": {"quantity":"5.0000 EOS", "contract":"eosio.token"},    
                  "memo": "some memo",
                  "expires": "2019-01-20T23:21:43",
                  "external_reference": "18446744073709551615"
                }
              ],
              "more": false
            }
        JSON
      end
    end
  end

  describe "approve" do
    context "without valid auth" do
      command %(cleos push action dacescrow approve '{ "key": 0, "approver": "arb1"}' -p sender2), allow_error: true
      its(:stderr) {is_expected.to include('missing authority of arb1')}
    end
    context "with valid auth" do
      context "with invalid escrow key" do
        command %(cleos push action dacescrow approve '{ "key": 4, "approver": "arb1"}' -p arb1), allow_error: true
        its(:stderr) {is_expected.to include('Could not find escrow with that index')}
      end
      context "with valid escrow id" do
        context "before a corresponding transfer has been made" do
          before(:all) do
            `cleos push action dacescrow init '{"sender": "sender2", "receiver": "receiver1", "arb": "arb1", "expires": "2019-01-20T23:21:43.528", "memo": "another empty escrow", "ext_reference": null}' -p sender2`
          end
          command %(cleos push action dacescrow approve '{ "key": 1, "approver": "arb1"}' -p arb1), allow_error: true
          its(:stderr) {is_expected.to include('This has not been initialized with a transfer')}
        end
        context "with a valid escrow for approval" do
          context "with uninvolved approver" do
            command %(cleos push action dacescrow approve '{ "key": 0, "approver": "arb2"}' -p arb2), allow_error: true
            its(:stderr) {is_expected.to include('You are not allowed to approve this escrow.')}
          end
          context "with involved approver" do
            command %(cleos push action dacescrow approve '{ "key": 0, "approver": "arb1"}' -p arb1), allow_error: true
            its(:stdout) {is_expected.to include('dacescrow <= dacescrow::approve')}
          end
          context "with already approved escrow" do
            before(:all) {sleep 1}
            command %(cleos push action dacescrow approve '{ "key": 0, "approver": "arb1", "none": "anything"}' -p arb1), allow_error: true
            its(:stderr) {is_expected.to include('You have already approved this escrow')}
          end

        end
        context "Read the escrow table after approve" do
          command %(cleos get table dacescrow dacescrow escrows), allow_error: true
          it do
            expect(JSON.parse(subject.stdout)).to eq JSON.parse <<~JSON
            {
              "rows": [{
                  "key": 0,
                  "sender": "sender1",
                  "receiver": "receiver1",
                  "arb": "arb1",
                  "approvals": [
                    "arb1"
                  ],
                  "ext_asset": {"quantity":"5.0000 EOS", "contract":"eosio.token"},    
                  "memo": "some memo",
                  "expires": "2019-01-20T23:21:43",
                  "external_reference": "18446744073709551615"
                },{
                  "key": 1,
                  "sender": "sender2",
                  "receiver": "receiver1",
                  "arb": "arb1",
                  "approvals": [],
                  "ext_asset": {"quantity":"0.0000 EOS", "contract":"eosio.token"},    
                  "memo": "another empty escrow",
                  "expires": "2019-01-20T23:21:43",
                  "external_reference": "18446744073709551615"
                }
              ],
              "more": false
            }
            JSON
          end
        end
      end
    end
  end

  describe "unapprove" do
    context "without valid auth" do
      command %(cleos push action dacescrow unapprove '{ "key": 0, "unapprover": "arb1"}' -p sender2), allow_error: true
      its(:stderr) {is_expected.to include('missing authority of arb1')}
    end
    context "with valid auth" do
      context "with invalid escrow key" do
        command %(cleos push action dacescrow unapprove '{ "key": 4, "unapprover": "arb1"}' -p arb1), allow_error: true
        its(:stderr) {is_expected.to include('Could not find escrow with that index')}
      end
      context "with valid escrow id" do
        context "before the escrow has been previously approved" do
          command %(cleos push action dacescrow unapprove '{ "key": 1, "unapprover": "arb1"}' -p arb1), allow_error: true
          its(:stderr) {is_expected.to include('You have NOT approved this escrow')}
        end
        context "with a valid escrow for unapproval" do
          context "with uninvolved approver" do
            command %(cleos push action dacescrow unapprove '{ "key": 0, "unapprover": "arb2"}' -p arb2), allow_error: true
            its(:stderr) {is_expected.to include('You have NOT approved this escrow')}
          end
          context "with involved approver" do
            before(:all) do
              `cleos push action dacescrow approve '{ "key": 0, "approver": "sender1"}' -p sender1`
            end
            command %(cleos push action dacescrow unapprove '{ "key": 0, "unapprover": "arb1"}' -p arb1), allow_error: true
            its(:stdout) {is_expected.to include('dacescrow <= dacescrow::unapprove')}
          end
          context "with already approved escrow" do
            before(:all) {sleep 1}
            command %(cleos push action dacescrow unapprove '{ "key": 0, "unapprover": "arb1"}' -p arb1), allow_error: true
            its(:stderr) {is_expected.to include('You have NOT approved this escrow')}
          end
        end
        context "Read the escrow table after unapprove" do
          command %(cleos get table dacescrow dacescrow escrows), allow_error: true
          it do
            expect(JSON.parse(subject.stdout)).to eq JSON.parse <<~JSON
            {
              "rows": [{
                  "key": 0,
                  "sender": "sender1",
                  "receiver": "receiver1",
                  "arb": "arb1",
                  "approvals": ["sender1"],
                  "ext_asset": {"quantity":"5.0000 EOS", "contract":"eosio.token"},    
                  "memo": "some memo",
                  "expires": "2019-01-20T23:21:43",
                  "external_reference": "18446744073709551615"
                },{
                  "key": 1,
                  "sender": "sender2",
                  "receiver": "receiver1",
                  "arb": "arb1",
                  "approvals": [],
                  "ext_asset": {"quantity":"0.0000 EOS", "contract":"eosio.token"},    
                  "memo": "another empty escrow",
                  "expires": "2019-01-20T23:21:43",
                  "external_reference": "18446744073709551615"
                }
              ],
              "more": false
            }
            JSON
          end
        end
      end
    end
  end

  describe "claim" do
    context "without valid auth" do
      command %(cleos push action dacescrow claim '{ "key": 0}' -p sender2), allow_error: true
      its(:stderr) {is_expected.to include('Missing required authority')}
    end
    context "with valid auth" do
      context "with invalid escrow key" do
        command %(cleos push action dacescrow claim '{ "key": 4}' -p arb1), allow_error: true
        its(:stderr) {is_expected.to include('Could not find escrow with that index')}
      end
      context "with valid escrow id" do
        context "before a corresponding transfer has been made" do
          command %(cleos push action dacescrow claim '{ "key": 1 }' -p receiver1), allow_error: true
          its(:stderr) {is_expected.to include('This has not been initialized with a transfer')}
        end
        context "without enough approvals for a claim" do
          before(:all) do
            `cleos push action dacescrow unapprove '{ "key": 0, "unapprover": "sender1"}' -p sender1`
          end
          command %(cleos push action dacescrow claim '{ "key": 0 }' -p receiver1), allow_error: true
          its(:stderr) {is_expected.to include('This escrow has not received the required approvals to claim')}
        end
        context "with enough approvals" do
          before(:all) do
            `cleos push action dacescrow approve '{ "key": 0, "approver": "arb1"}' -p arb1`
          end
          command %(cleos push action dacescrow claim '{ "key": 0 }' -p receiver1), allow_error: true
          its(:stdout) {is_expected.to include('dacescrow <= dacescrow::claim')}
        end
        context "with already approved escrow" do
          before(:all) {sleep 1}
          command %(cleos push action dacescrow claim '{ "key": 0}' -p receiver1), allow_error: true
          its(:stderr) {is_expected.to include('Could not find escrow with that index')}
        end
      end
    end
    context "Read the escrow table after approve" do
      command %(cleos get table dacescrow dacescrow escrows), allow_error: true
      it do
        expect(JSON.parse(subject.stdout)).to eq JSON.parse <<~JSON
            {
              "rows": [{
                  "key": 1,
                  "sender": "sender2",
                  "receiver": "receiver1",
                  "arb": "arb1",
                  "approvals": [],
                  "ext_asset": {"quantity": "0.0000 EOS", "contract": "eosio.token"},
                  "memo": "another empty escrow",
                  "expires": "2019-01-20T23:21:43",
                  "external_reference": "18446744073709551615"
                }
              ],
              "more": false
            }
        JSON
      end
    end
  end

  describe "cancel" do
    context "without valid auth" do
      command %(cleos push action dacescrow cancel '{ "key": 1}' -p sender1), allow_error: true
      its(:stderr) {is_expected.to include('missing authority of sender2')}
    end
    context "with valid auth" do
      context "with invalid escrow key" do
        command %(cleos push action dacescrow cancel '{ "key": 4}' -p sender1), allow_error: true
        its(:stderr) {is_expected.to include('Could not find escrow with that index')}
      end
      context "with valid escrow id" do
        context "after a transfer has been made" do
          before(:all) do
            `cleos push action eosio.token transfer '{"from": "sender2", "to": "dacescrow", "quantity": "6.0000 EOS", "memo": "here is a second memo" }' -p sender2`
          end
          command %(cleos push action dacescrow cancel '{ "key": 1}' -p sender2), allow_error: true
          its(:stderr) {is_expected.to include('Amount is not zero, this escrow is locked down')}
        end
        context "before a transfer has been made" do
          before(:all) do
            `cleos push action dacescrow init '{"sender": "sender1", "receiver": "receiver1", "arb": "arb2", "expires": "2019-01-20T23:21:43.528", "memo": "third memo", "ext_reference": null}' -p sender1`
          end
          command %(cleos push action dacescrow cancel '{ "key": 2}' -p sender1), allow_error: true
          its(:stdout) {is_expected.to include('dacescrow <= dacescrow::cancel')}
        end
        context "Read the escrow table after approve" do
          command %(cleos get table dacescrow dacescrow escrows), allow_error: true
          it do
            expect(JSON.parse(subject.stdout)).to eq JSON.parse <<~JSON
            {
              "rows": [{
                  "key": 1,
                  "sender": "sender2",
                  "receiver": "receiver1",
                  "arb": "arb1",
                  "approvals": [],
                  "ext_asset": {"quantity": "6.0000 EOS", "contract": "eosio.token"},
                  "memo": "another empty escrow",
                  "expires": "2019-01-20T23:21:43",
                  "external_reference": "18446744073709551615"
                }
              ],
              "more": false
            }
            JSON
          end
        end
      end
    end
  end

  describe "refund" do
    context "with invalid escrow key" do
      command %(cleos push action dacescrow refund '{ "key": 4}' -p arb1), allow_error: true
      its(:stderr) {is_expected.to include('Could not find escrow with that index')}
    end
    context "with valid escrow id" do
      context "with invalid auth" do
        command %(cleos push action dacescrow refund '{ "key": 1}' -p arb1), allow_error: true
        its(:stderr) {is_expected.to include('missing authority of sender2')}
      end
      context "with valid auth" do
        context "before a corresponding transfer has been made" do
          before(:all) do
            `cleos push action dacescrow init '{"sender": "sender1", "receiver": "receiver1", "arb": "arb2", "expires": "2019-01-20T23:21:43.528", "memo": "some empty memo", "ext_reference": null}' -p sender1`
          end
          command %(cleos push action dacescrow refund '{ "key": 2 }' -p sender1), allow_error: true
          its(:stderr) {is_expected.to include('This has not been initialized with a transfer')}
        end
        context "after a transfer has been made" do
          context "before the escrow has expired" do
            before(:all) do
              `cleos push action dacescrow init '{"sender": "sender4", "receiver": "receiver1", "arb": "arb2", "expires": "2035-01-20T23:21:43.528", "memo": "distant future escrow", "ext_reference": null}' -p sender4`
              `cleos push action eosio.token transfer '{"from": "sender4", "to": "dacescrow", "quantity": "5.0000 EOS", "memo": "here is a memo" }' -p sender4`
              `cleos push action dacescrow approve '{ "key": 3, "approver": "sender4"}' -p sender4`
              `cleos push action dacescrow approve '{ "key": 3, "approver": "receiver1"}' -p receiver1`
            end
            command %(cleos push action dacescrow refund '{ "key": 3 }' -p sender4), allow_error: true
            its(:stderr) {is_expected.to include('Escrow has not expired')}
          end
        end
        context "balance of escrow should be set before preparing the escrow with a known balance starting point" do
          command %(cleos get currency balance eosio.token dacescrow EOS), allow_error: true
          it do
            expect(subject.stdout).to eq <<~JSON
                  11.0000 EOS
            JSON
          end
        end
        context "balance of escrow should be set before preparing the escrow with a known balance starting point" do
          command %(cleos get currency balance eosio.token sender3 EOS), allow_error: true
          it do
            expect(subject.stdout).to eq <<~JSON
                  1000.0000 EOS
            JSON
          end
        end
        context "after the escrow has expired" do
          before(:all) do
            `cleos push action dacescrow init '{"sender": "sender3", "receiver": "receiver1", "arb": "arb2", "expires": "2019-01-19T23:21:43.528", "memo": "some expired memo", "ext_reference": null}' -p sender3`
            `cleos push action eosio.token transfer '{"from": "sender3", "to": "dacescrow", "quantity": "5.0000 EOS", "memo": "here is a memo" }' -p sender3`
            `cleos push action dacescrow approve '{ "key": 4, "approver": "sender3"}' -p sender3`
            `cleos push action dacescrow approve '{ "key": 4, "approver": "receiver1"}' -p receiver1`
          end
          context "balance of dacescrow should have adjusted after preparing the escrow" do
            command %(cleos get currency balance eosio.token dacescrow EOS), allow_error: true
            it do
              expect(subject.stdout).to eq <<~JSON
                  16.0000 EOS
              JSON
            end
          end
          context "balance of sender3 should have adjusted after preparing the escrow" do
            command %(cleos get currency balance eosio.token sender3 EOS), allow_error: true
            it do
              expect(subject.stdout).to eq <<~JSON
                  995.0000 EOS
              JSON
            end
          end
          context "after refund succeeds" do
            command %(cleos push action dacescrow refund '{ "key": 4 }' -p sender3), allow_error: true
            its(:stdout) {is_expected.to include('dacescrow <= dacescrow::refund')}
          end
          context "balance of dacescrow should have changed back after refunding an escrow" do
            command %(cleos get currency balance eosio.token dacescrow EOS), allow_error: true
            it do
              expect(subject.stdout).to eq <<~JSON
                  11.0000 EOS
              JSON
            end
          end
          context "balance of sender3 should have changed back after refunding an escrow" do
            command %(cleos get currency balance eosio.token sender3 EOS), allow_error: true
            it do
              expect(subject.stdout).to eq <<~JSON
                  1000.0000 EOS
              JSON
            end
          end
        end
      end
    end
    context "Read the escrow table after refund" do
      command %(cleos get table dacescrow dacescrow escrows), allow_error: true
      it do
        expect(JSON.parse(subject.stdout)).to eq JSON.parse <<~JSON
            {
              "rows": [{
                  "key": 1,
                  "sender": "sender2",
                  "receiver": "receiver1",
                  "arb": "arb1",
                  "approvals": [],
                  "ext_asset": {"quantity": "6.0000 EOS", "contract": "eosio.token"},
                  "memo": "another empty escrow",
                  "expires": "2019-01-20T23:21:43",
                  "external_reference": "18446744073709551615"
                },{
                  "key": 2,
                  "sender": "sender1",
                  "receiver": "receiver1",
                  "arb": "arb2",
                  "approvals": [],
                  "ext_asset": {"quantity": "0.0000 EOS", "contract": "eosio.token"},
                  "memo": "some empty memo",
                  "expires": "2019-01-20T23:21:43",
                  "external_reference": "18446744073709551615"
                },{
                  "key": 3,
                  "sender": "sender4",
                  "receiver": "receiver1",
                  "arb": "arb2",
                  "approvals": [
                    "sender4"
                  ],
                  "ext_asset": {"quantity": "5.0000 EOS", "contract": "eosio.token"},
                  "memo": "distant future escrow",
                  "expires": "2035-01-20T23:21:43",
                  "external_reference": "18446744073709551615"
                }
              ],
              "more": false
            }
        JSON
      end
    end
  end
  end

  context "Using External key" do
    describe "init" do
    before(:all) do
      `cleos push action dacescrow clean '{}' -p dacescrow`
    end
      context "Without valid permission" do
        context "with valid and registered member" do
          command %(cleos push action dacescrow init '{"sender": "sender1", "receiver": "receiver1", "arb": "arb1", "expires": "2019-01-20T23:21:43.528", "memo": "some memo", "ext_reference": 23}' -p sender2), allow_error: true
          its(:stderr) {is_expected.to include('missing authority of sender1')}
        end
      end

      context "with valid auth" do
        command %(cleos push action dacescrow init '{"sender": "sender1", "receiver": "receiver1", "arb": "arb1", "expires": "2019-01-20T23:21:43.528", "memo": "some memo", "ext_reference": 23}' -p sender1), allow_error: true
        its(:stdout) {is_expected.to include('dacescrow <= dacescrow::init')}

        context "with an existing escrow entry" do
          command %(cleos push action dacescrow init '{"sender": "sender1", "receiver": "receiver1", "arb": "arb1", "expires": "2019-01-20T23:21:43.528", "memo": "some other memo", "ext_reference": 23}' -p sender1), allow_error: true
          its(:stderr) {is_expected.to include('You already have an empty escrow.  Either fill it or delete it')}
        end
      end
      context "Read the escrow table after init" do
        command %(cleos get table dacescrow dacescrow escrows), allow_error: true
        it do
          expect(JSON.parse(subject.stdout)).to eq JSON.parse <<~JSON
            {
              "rows": [{
                  "key": 0,
                  "sender": "sender1",
                  "receiver": "receiver1",
                  "arb": "arb1",
                  "approvals": [],
                  "ext_asset": {"quantity": "0.0000 EOS", "contract": "eosio.token"},
                  "memo": "some memo",
                  "expires": "2019-01-20T23:21:43",
                  "external_reference": 23
                }
              ],
              "more": false
            }
          JSON
        end
      end
    end

    describe "transfer" do
      context "without valid auth" do
        command %(cleos push action eosio.token transfer '{"from": "sender1", "to": "dacescrow", "quantity": "5.0000 EOS", "memo": "here is a memo" }' -p sender2), allow_error: true
        its(:stderr) {is_expected.to include('missing authority of sender1')}
      end
      context "without a valid escrow" do
        command %(cleos push action eosio.token transfer '{"from": "sender2", "to": "dacescrow", "quantity": "5.0000 EOS", "memo": "here is a memo" }' -p sender2), allow_error: true
        its(:stderr) {is_expected.to include('Could not find existing escrow to deposit to, transfer cancelled')}
      end
      context "balance should not have reduced from 1000.0000 EOS" do
        command %(cleos get currency balance eosio.token sender1 EOS), allow_error: true
        it do
          expect(subject.stdout).to eq <<~JSON
            1000.0000 EOS
          JSON
        end
      end
      context "with a valid escrow" do
        command %(cleos push action eosio.token transfer '{"from": "sender1", "to": "dacescrow", "quantity": "5.0000 EOS", "memo": "here is a memo" }' -p sender1), allow_error: true
        its(:stdout) {is_expected.to include('dacescrow <= eosio.token::transfer')}
      end
      context "balance should have reduced to 995.0000 EOS" do
        command %(cleos get currency balance eosio.token sender1 EOS), allow_error: true
        it do
          expect(subject.stdout).to eq <<~JSON
            995.0000 EOS
          JSON
        end
      end
      context "balance of dacescrow should have increased by 5.0000 EOS" do
        command %(cleos get currency balance eosio.token dacescrow EOS), allow_error: true
        it do
          expect(subject.stdout).to eq <<~JSON
            16.0000 EOS
          JSON
        end
      end
      context "Read the escrow table after init" do
        command %(cleos get table dacescrow dacescrow escrows), allow_error: true
        it do
          expect(JSON.parse(subject.stdout)).to eq JSON.parse <<~JSON
            {
              "rows": [{
                  "key": 0,
                  "sender": "sender1",
                  "receiver": "receiver1",
                  "arb": "arb1",
                  "approvals": [],
                  "ext_asset": {"quantity": "5.0000 EOS", "contract": "eosio.token"},
                  "memo": "some memo",
                  "expires": "2019-01-20T23:21:43",
                  "external_reference": 23
                }
              ],
              "more": false
            }
          JSON
        end
      end
    end

    describe "approve" do
      context "without valid auth" do
        command %(cleos push action dacescrow approveext '{ "ext_key": 23, "approver": "arb1"}' -p sender2), allow_error: true
        its(:stderr) {is_expected.to include('missing authority of arb1')}
      end
      context "with valid auth" do
        context "with invalid escrow key" do
          command %(cleos push action dacescrow approveext '{ "ext_key": 45, "approver": "arb1"}' -p arb1), allow_error: true
          its(:stderr) {is_expected.to include('No escrow exists for this external key.')}
        end
        context "with valid escrow id" do
          context "before a corresponding transfer has been made" do
            before(:all) do
              `cleos push action dacescrow init '{"sender": "sender2", "receiver": "receiver1", "arb": "arb1", "expires": "2019-01-20T23:21:43.528", "memo": "another empty escrow", "ext_reference": "666"}' -p sender2`
            end
            command %(cleos push action dacescrow approveext '{ "ext_key": 666, "approver": "arb1"}' -p arb1), allow_error: true
            its(:stderr) {is_expected.to include('This has not been initialized with a transfer')}
          end
          context "with a valid escrow for approval" do
            context "with uninvolved approver" do
              command %(cleos push action dacescrow approveext '{ "ext_key": 23, "approver": "arb2"}' -p arb2), allow_error: true
              its(:stderr) {is_expected.to include('You are not allowed to approve this escrow.')}
            end
            context "with involved approver" do
              command %(cleos push action dacescrow approveext '{ "ext_key": 23, "approver": "arb1"}' -p arb1), allow_error: true
              its(:stdout) {is_expected.to include('dacescrow <= dacescrow::approve')}
            end
            context "with already approved escrow" do
              before(:all) {sleep 1}
              command %(cleos push action dacescrow approveext '{ "ext_key": 23, "approver": "arb1", "none": "anything"}' -p arb1), allow_error: true
              its(:stderr) {is_expected.to include('You have already approved this escrow')}
            end

          end
          context "Read the escrow table after approve" do
            command %(cleos get table dacescrow dacescrow escrows), allow_error: true
            it do
              expect(JSON.parse(subject.stdout)).to eq JSON.parse <<~JSON
            {
              "rows": [{
                  "key": 0,
                  "sender": "sender1",
                  "receiver": "receiver1",
                  "arb": "arb1",
                  "approvals": [
                    "arb1"
                  ],
                  "ext_asset": {"quantity": "5.0000 EOS", "contract": "eosio.token"},
                  "memo": "some memo",
                  "expires": "2019-01-20T23:21:43",
                  "external_reference": 23
                },{
                  "key": 1,
                  "sender": "sender2",
                  "receiver": "receiver1",
                  "arb": "arb1",
                  "approvals": [],
                  "ext_asset": {"quantity": "0.0000 EOS", "contract": "eosio.token"},
                  "memo": "another empty escrow",
                  "expires": "2019-01-20T23:21:43",
                  "external_reference": 666
                }
              ],
              "more": false
            }
              JSON
            end
          end
        end
      end
    end

    describe "unapprove" do
      context "without valid auth" do
        command %(cleos push action dacescrow unapproveext '{ "ext_key": 23, "unapprover": "arb1"}' -p sender2), allow_error: true
        its(:stderr) {is_expected.to include('missing authority of arb1')}
      end
      context "with valid auth" do
        context "with invalid escrow key" do
          command %(cleos push action dacescrow unapproveext '{ "ext_key": 45, "unapprover": "arb1"}' -p arb1), allow_error: true
          its(:stderr) {is_expected.to include('No escrow exists for this external key.')}
        end
        context "with valid escrow id" do
          context "before the escrow has been previously approved" do
            command %(cleos push action dacescrow unapproveext '{ "ext_key": 666, "unapprover": "arb1"}' -p arb1), allow_error: true
            its(:stderr) {is_expected.to include('You have NOT approved this escrow')}
          end
          context "with a valid escrow for unapproval" do
            context "with uninvolved approver" do
              command %(cleos push action dacescrow unapproveext '{ "ext_key": 23, "unapprover": "arb2"}' -p arb2), allow_error: true
              its(:stderr) {is_expected.to include('You have NOT approved this escrow')}
            end
            context "with involved approver" do
              before(:all) do
                `cleos push action dacescrow approveext '{ "ext_key": 23, "approver": "sender1"}' -p sender1`
              end
              command %(cleos push action dacescrow unapproveext '{ "ext_key": 23, "unapprover": "arb1"}' -p arb1), allow_error: true
              its(:stdout) {is_expected.to include('dacescrow <= dacescrow::unapprove')}
            end
            context "with already unapproved escrow" do
              before(:all) {sleep 1}
              command %(cleos push action dacescrow unapproveext '{ "ext_key": 23, "unapprover": "arb1"}' -p arb1), allow_error: true
              its(:stderr) {is_expected.to include('You have NOT approved this escrow')}
            end
          end
          context "Read the escrow table after unapproveext" do
            command %(cleos get table dacescrow dacescrow escrows), allow_error: true
            it do
              expect(JSON.parse(subject.stdout)).to eq JSON.parse <<~JSON
            {
              "rows": [{
                  "key": 0,
                  "sender": "sender1",
                  "receiver": "receiver1",
                  "arb": "arb1",
                  "approvals": ["sender1"],
                  "ext_asset": {"quantity": "5.0000 EOS", "contract": "eosio.token"},
                  "memo": "some memo",
                  "expires": "2019-01-20T23:21:43",
                  "external_reference": 23
                },{
                  "key": 1,
                  "sender": "sender2",
                  "receiver": "receiver1",
                  "arb": "arb1",
                  "approvals": [],
                  "ext_asset": {"quantity": "0.0000 EOS", "contract": "eosio.token"},
                  "memo": "another empty escrow",
                  "expires": "2019-01-20T23:21:43",
                  "external_reference": 666
                }
              ],
              "more": false
            }
              JSON
            end
          end
        end
      end
    end

    describe "claim" do
      context "without valid auth" do
        command %(cleos push action dacescrow claimext '{ "ext_key": 23}' -p sender2), allow_error: true
        its(:stderr) {is_expected.to include('Missing required authority')}
      end
      context "with valid auth" do
        context "with invalid escrow key" do
          command %(cleos push action dacescrow claimext '{ "ext_key": 45}' -p arb1), allow_error: true
          its(:stderr) {is_expected.to include('No escrow exists for this external key.')}
        end
        context "with valid escrow id" do
          context "before a corresponding transfer has been made" do
            command %(cleos push action dacescrow claimext '{ "ext_key": 666 }' -p receiver1), allow_error: true
            its(:stderr) {is_expected.to include('This has not been initialized with a transfer')}
          end
          context "with enough approvals" do
            before(:all) do
              `cleos push action dacescrow approveext '{ "ext_key": 23, "approver": "arb1"}' -p arb1`
            end
            command %(cleos push action dacescrow claimext '{ "ext_key": 23 }' -p receiver1), allow_error: true
            its(:stdout) {is_expected.to include('dacescrow <= dacescrow::claim')}
          end
          context "with already claimed escrow" do
            before(:all) {sleep 1}
            command %(cleos push action dacescrow claimext '{ "ext_key": 23}' -p receiver1), allow_error: true
            its(:stderr) {is_expected.to include('No escrow exists for this external key.')}
          end
        end
      end
      context "Read the escrow table after approve" do
        command %(cleos get table dacescrow dacescrow escrows), allow_error: true
        it do
          expect(JSON.parse(subject.stdout)).to eq JSON.parse <<~JSON
            {
              "rows": [{
                  "key": 1,
                  "sender": "sender2",
                  "receiver": "receiver1",
                  "arb": "arb1",
                  "approvals": [],
                  "ext_asset": {"quantity": "0.0000 EOS", "contract": "eosio.token"},
                  "memo": "another empty escrow",
                  "expires": "2019-01-20T23:21:43",
                  "external_reference": 666
                }
              ],
              "more": false
            }
          JSON
        end
      end
    end

    describe "cancel" do
      context "without valid auth" do
        command %(cleos push action dacescrow cancelext '{ "ext_key": 666}' -p sender1), allow_error: true
        its(:stderr) {is_expected.to include('missing authority of sender2')}
      end
      context "with valid auth" do
        context "with invalid escrow key" do
          command %(cleos push action dacescrow cancelext '{ "ext_key": 45}' -p sender1), allow_error: true
          its(:stderr) {is_expected.to include('No escrow exists for this external key.')}
        end
        context "with valid escrow id" do
          context "after a transfer has been made" do
            before(:all) do
              `cleos push action eosio.token transfer '{"from": "sender2", "to": "dacescrow", "quantity": "6.0000 EOS", "memo": "here is a second memo" }' -p sender2`
            end
            command %(cleos push action dacescrow cancelext '{ "ext_key": 666}' -p sender2), allow_error: true
            its(:stderr) {is_expected.to include('Amount is not zero, this escrow is locked down')}
          end
          context "before a transfer has been made" do
            before(:all) do
              `cleos push action dacescrow init '{"sender": "sender1", "receiver": "receiver1", "arb": "arb2", "expires": "2019-01-20T23:21:43.528", "memo": "third memo", "ext_reference": 777}' -p sender1`
            end
            command %(cleos push action dacescrow cancelext '{ "ext_key": 777}' -p sender1), allow_error: true
            its(:stdout) {is_expected.to include('dacescrow <= dacescrow::cancel')}
          end
          context "Read the escrow table after approve" do
            command %(cleos get table dacescrow dacescrow escrows), allow_error: true
            it do
              expect(JSON.parse(subject.stdout)).to eq JSON.parse <<~JSON
            {
              "rows": [{
                  "key": 1,
                  "sender": "sender2",
                  "receiver": "receiver1",
                  "arb": "arb1",
                  "approvals": [],
                  "ext_asset": {"quantity": "6.0000 EOS", "contract": "eosio.token"},
                  "memo": "another empty escrow",
                  "expires": "2019-01-20T23:21:43",
                  "external_reference": 666
                }
              ],
              "more": false
            }
              JSON
            end
          end
        end
      end
    end

    describe "refund" do
      context "with invalid escrow key" do
        command %(cleos push action dacescrow refundext '{ "ext_key": 777}' -p arb1), allow_error: true
        its(:stderr) {is_expected.to include('No escrow exists for this external key.')}
      end
      context "with valid escrow id" do
        context "with invalid auth" do
          command %(cleos push action dacescrow refundext '{ "ext_key": 666}' -p arb1), allow_error: true
          its(:stderr) {is_expected.to include('missing authority of sender2')}
        end
        context "with valid auth" do
          context "before a corresponding transfer has been made" do
            before(:all) do
              `cleos push action dacescrow init '{"sender": "sender1", "receiver": "receiver1", "arb": "arb2", "expires": "2019-01-20T23:21:43.528", "memo": "some empty memo", "ext_reference": 821}' -p sender1`
            end
            command %(cleos push action dacescrow refundext '{ "ext_key": 821 }' -p sender1), allow_error: true
            its(:stderr) {is_expected.to include('This has not been initialized with a transfer')}
          end
          context "after a transfer has been made" do
            context "before the escrow has expired" do
              before(:all) do
                `cleos push action dacescrow init '{"sender": "sender4", "receiver": "receiver1", "arb": "arb2", "expires": "2035-01-20T23:21:43.528", "memo": "distant future escrow", "ext_reference": 123}' -p sender4`
                `cleos push action eosio.token transfer '{"from": "sender4", "to": "dacescrow", "quantity": "5.0000 EOS", "memo": "here is a memo" }' -p sender4`
                `cleos push action dacescrow approveext '{ "ext_key": 123, "approver": "sender4"}' -p sender4`
                `cleos push action dacescrow approveext '{ "ext_key": 123, "approver": "receiver1"}' -p receiver1`
              end
              command %(cleos push action dacescrow refundext '{ "ext_key": 123 }' -p sender4), allow_error: true
              its(:stderr) {is_expected.to include('Escrow has not expired')}
            end
          end
          context "balance of escrow should be set before preparing the escrow with a known balance starting point" do
            command %(cleos get currency balance eosio.token dacescrow EOS), allow_error: true
            it do
              expect(subject.stdout).to eq <<~JSON
                  22.0000 EOS
              JSON
            end
          end
          context "balance of escrow should be set before preparing the escrow with a known balance starting point" do
            command %(cleos get currency balance eosio.token sender3 EOS), allow_error: true
            it do
              expect(subject.stdout).to eq <<~JSON
                  1000.0000 EOS
              JSON
            end
          end
          context "after the escrow has expired" do
            before(:all) do
              `cleos push action dacescrow init '{"sender": "sender3", "receiver": "receiver1", "arb": "arb2", "expires": "2019-01-19T23:21:43.528", "memo": "some expired memo", "ext_reference": 456}' -p sender3`
              `cleos push action eosio.token transfer '{"from": "sender3", "to": "dacescrow", "quantity": "5.0000 EOS", "memo": "here is a memo" }' -p sender3`
              `cleos push action dacescrow approveext '{ "ext_key": 456, "approver": "sender3"}' -p sender3`
              `cleos push action dacescrow approveext '{ "ext_key": 456, "approver": "receiver1"}' -p receiver1`
            end
            context "balance of dacescrow should have adjusted after preparing the escrow" do
              command %(cleos get currency balance eosio.token dacescrow EOS), allow_error: true
              it do
                expect(subject.stdout).to eq <<~JSON
                  27.0000 EOS
                JSON
              end
            end
            context "balance of sender3 should have adjusted after preparing the escrow" do
              command %(cleos get currency balance eosio.token sender3 EOS), allow_error: true
              it do
                expect(subject.stdout).to eq <<~JSON
                  995.0000 EOS
                JSON
              end
            end
            context "after refund succeeds" do
              command %(cleos push action dacescrow refundext '{ "ext_key": 456 }' -p sender3), allow_error: true
              its(:stdout) {is_expected.to include('dacescrow <= dacescrow::refund')}
            end
            context "balance of dacescrow should have changed back after refunding an escrow" do
              command %(cleos get currency balance eosio.token dacescrow EOS), allow_error: true
              it do
                expect(subject.stdout).to eq <<~JSON
                  22.0000 EOS
                JSON
              end
            end
            context "balance of sender3 should have changed back after refunding an escrow" do
              command %(cleos get currency balance eosio.token sender3 EOS), allow_error: true
              it do
                expect(subject.stdout).to eq <<~JSON
                  1000.0000 EOS
                JSON
              end
            end
          end
        end
      end
      context "Read the escrow table after refund" do
        command %(cleos get table dacescrow dacescrow escrows), allow_error: true
        it do
          expect(JSON.parse(subject.stdout)).to eq JSON.parse <<~JSON
            {
              "rows": [{
                  "key": 1,
                  "sender": "sender2",
                  "receiver": "receiver1",
                  "arb": "arb1",
                  "approvals": [],
                  "ext_asset": {"quantity": "6.0000 EOS", "contract": "eosio.token"},
                  "memo": "another empty escrow",
                  "expires": "2019-01-20T23:21:43",
                  "external_reference": 666
                },{
                  "key": 2,
                  "sender": "sender1",
                  "receiver": "receiver1",
                  "arb": "arb2",
                  "approvals": [],
                  "ext_asset": {"quantity": "0.0000 EOS", "contract": "eosio.token"},
                  "memo": "some empty memo",
                  "expires": "2019-01-20T23:21:43",
                  "external_reference": 821
                },{
                  "key": 3,
                  "sender": "sender4",
                  "receiver": "receiver1",
                  "arb": "arb2",
                  "approvals": [
                    "sender4"
                  ],
                  "ext_asset": {"quantity": "5.0000 EOS", "contract": "eosio.token"},
                  "memo": "distant future escrow",
                  "expires": "2035-01-20T23:21:43",
                  "external_reference": 123
                }
              ],
              "more": false
            }
          JSON
        end
      end
    end
  end
end
