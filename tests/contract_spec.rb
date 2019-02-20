require 'rspec'
require 'rspec_command'
require "json"
require 'date'

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

CONTRACTS_DIR = 'tests/contract-shared-dependencies'

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
   cleos set account permission dacproposals active '{"threshold": 1,"keys": [{"key": "#{CONTRACT_ACTIVE_PUBLIC_KEY}","weight": 1}],"accounts": [{"permission":{"actor":"dacproposals","permission":"eosio.code"},"weight":1}]}' owner -p dacproposals@owner
   cleos set account permission eosdacthedac xfer '{"threshold": 1,"keys": [{"key": "#{CONTRACT_ACTIVE_PUBLIC_KEY}","weight": 1}],"accounts": [{"permission":{"actor":"daccustodian","permission":"eosio.code"},"weight":1}]}' active -p eosdacthedac@active
   cleos set account permission daccustodian xfer '{"threshold": 1,"keys": [{"key": "#{CONTRACT_ACTIVE_PUBLIC_KEY}","weight": 1}],"accounts": [{"permission":{"actor":"daccustodian","permission":"eosio.code"},"weight":1}]}' active -p daccustodian@active
   cleos set account permission daccustodian one '{"threshold": 1,"keys": [{"key": "#{CONTRACT_ACTIVE_PUBLIC_KEY}","weight": 1}],"accounts": [{"permission":{"actor":"daccustodian","permission":"eosio.code"},"weight":1}]}' low -p daccustodian@low
   
   cleos push action eosio.token issue '["eosdacthedac", "100000.0000 EOS", "Initial EOS amount."]' -p eosio
   cleos push action eosio.token issue '["dacproposals", "100000.0000 EOS", "Initial EOS amount."]' -p eosio

   cleos set action permission eosdacthedac eosdactokens transfer xfer
   cleos set action permission eosdacthedac eosio.token transfer xfer  
   cleos set action permission daccustodian eosdactokens transfer xfer  
 
   # Configure accounts permissions hierarchy
   cleos set account permission dacauthority high #{CONTRACT_OWNER_PUBLIC_KEY} active -p dacauthority 
   cleos set account permission dacauthority med #{CONTRACT_OWNER_PUBLIC_KEY} high -p dacauthority 
   cleos set account permission dacauthority low #{CONTRACT_OWNER_PUBLIC_KEY} med -p dacauthority 
   cleos set account permission dacauthority one #{CONTRACT_OWNER_PUBLIC_KEY} low -p dacauthority  

   cleos set account permission #{ACCOUNT_NAME} active '{"threshold": 1,"keys": [{"key": "#{CONTRACT_ACTIVE_PUBLIC_KEY}","weight": 1}],"accounts": [{"permission":{"actor":"daccustodian","permission":"eosio.code"},"weight":1}]}' owner -p #{ACCOUNT_NAME}

   # Set action permission for the voteprop
     cleos set action permission dacauthority dacproposals voteprop one

  SHELL

  `#{beforescript}`
  exit() unless $? == 0
end

def install_dependencies

  beforescript = <<~SHELL
   # set -x


   cleos set contract daccustodian #{CONTRACTS_DIR}/daccustodian -p daccustodian 
   cleos set contract eosdactokens #{CONTRACTS_DIR}/eosdactokens -p eosdactokens
   cleos set contract dacproposals output/unit_tests/dacproposals -p dacproposals
   cleos set contract dacescrow #{CONTRACTS_DIR}/dacescrow -p dacescrow

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
  `cleos push action eosio.token issue '{ "to": "eosdacthedac", "quantity": "100000.0000 EOS", "memo": "Initial EOS amount."}' -p eosio.token`

  #create users
  # Ensure terms are registered in the token contract
  `cleos push action eosdactokens newmemterms '{ "terms": "normallegalterms", "hash": "New Latest terms"}' -p eosdactokens`

  #create users
  seed_dac_account("proposeracc1", issue: "100.0000 EOSDAC", memberreg: "New Latest terms")
  seed_dac_account("proposeracc2", issue: "100.0000 EOSDAC", memberreg: "New Latest terms")
  seed_dac_account("arbitrator11", issue: "100.0000 EOSDAC", memberreg: "New Latest terms")

  seed_dac_account("custodian1", issue: "100.0000 EOSDAC", memberreg: "New Latest terms")
  seed_dac_account("custodian2", issue: "100.0000 EOSDAC", memberreg: "New Latest terms")
  seed_dac_account("custodian3", issue: "100.0000 EOSDAC", memberreg: "New Latest terms")
  seed_dac_account("custodian4", issue: "100.0000 EOSDAC", memberreg: "New Latest terms")
  seed_dac_account("custodian5", issue: "100.0000 EOSDAC", memberreg: "New Latest terms")
  seed_dac_account("custodian11", issue: "100.0000 EOSDAC", memberreg: "New Latest terms")
  seed_dac_account("custodian12", issue: "100.0000 EOSDAC", memberreg: "New Latest terms")
  seed_dac_account("custodian13", issue: "100.0000 EOSDAC", memberreg: "New Latest terms")

  `cleos set account permission dacauthority one '{"threshold": 1,"keys": [],"accounts": [{"permission":{"actor":"custodian1","permission":"active"},"weight":1}, {"permission":{"actor":"custodian11","permission":"active"},"weight":1}, {"permission":{"actor":"custodian12","permission":"active"},"weight":1}, {"permission":{"actor":"custodian13","permission":"active"},"weight":1}, {"permission":{"actor":"custodian2","permission":"active"},"weight":1}, {"permission":{"actor":"custodian3","permission":"active"},"weight":1}, {"permission":{"actor":"custodian4","permission":"active"},"weight":1}, {"permission":{"actor":"custodian5","permission":"active"},"weight":1}]}' low -p dacauthority@low`
end

def killchain
  # `sleep 0.5; kill \`pgrep nodeos\``
end

describe "eosdacelect" do
  before(:all) do
    reset_chain
    configure_wallet
    seed_system_contracts
    configure_dac_accounts
    install_dependencies
    configure_contracts
  end

  after(:all) do
    killchain
  end

  describe "createprop" do
    context "Without valid permission" do
      context "with valid and registered member" do
        command %(cleos push action dacproposals createprop '{"proposer": "proposeracc1", "title": "some_title", "summary": "some_summary", "arbitrator": "arbitrator11", "pay_amount": "100.0000 EOS", "content_hash": "jhsdfkjhsdfkjhkjsdf" }' -p proposeracc2), allow_error: true
        its(:stderr) {is_expected.to include('missing authority of proposeracc1')}
      end
    end

    context "with valid auth" do
      context "with an invalid title" do
        command %(cleos push action dacproposals createprop '{"proposer": "proposeracc1", "title": "", "summary": "some_summary", "arbitrator": "arbitrator11", "pay_amount": "100.0000 EOS", "content_hash": "jhsdfkjhsdfkjhkjsdf" }' -p proposeracc1), allow_error: true
        its(:stderr) {is_expected.to include('Title length is too short')}
      end
      context "with an invalid Summary" do
        command %(cleos push action dacproposals createprop '{"proposer": "proposeracc1", "title": "some_title", "summary": "", "arbitrator": "arbitrator11", "pay_amount": "100.0000 EOS", "content_hash": "jhsdfkjhsdfkjhkjsdf" }' -p proposeracc1), allow_error: true
        its(:stderr) {is_expected.to include('Summary length is too short')}
      end
      context "with an invalid contentHash" do
        command %(cleos push action dacproposals createprop '{"proposer": "proposeracc1", "title": "some_title", "summary": "some_summary", "arbitrator": "arbitrator11", "pay_amount": "100.0000 EOS", "content_hash": "asdfasdfasdfasdfasdfasdfasdfasd" }' -p proposeracc1), allow_error: true
        its(:stderr) {is_expected.to include('Invalid content hash.')}
      end
      context "with valid params" do
        command %(cleos push action dacproposals createprop '{"proposer": "proposeracc1", "title": "some_title", "summary": "some_summary", "arbitrator": "arbitrator11", "pay_amount": "100.0000 EOS", "content_hash": "asdfasdfasdfasdfasdfasdfasdfasdf" }' -p proposeracc1), allow_error: true
        its(:stdout) {is_expected.to include('dacproposals <= dacproposals::createprop')}
      end
    end
    context "Read the proposals table after createprop" do
      command %(cleos get table dacproposals dacproposals proposals), allow_error: true
      it do
        expect(JSON.parse(subject.stdout)).to eq JSON.parse <<~JSON
            {
              "rows": [{
              "key": 0,
              "proposer": "proposeracc1",
              "arbitrator": "arbitrator11", 
              "content_hash": "asdfasdfasdfasdfasdfasdfasdfasdf", 
              "pay_amount": "100.0000 EOS", 
              "state": 0
              }
            ],
            "more": false
          }
        JSON
      end
    end
  end

  describe "voteprop" do
    context "without valid auth" do
      command %(cleos push action dacproposals voteprop '{"custodian": "custodian1", "proposal_id": 0, "vote": 1 }' -p proposeracc2 -p custodian1), allow_error: true
      its(:stderr) {is_expected.to include('missing authority of dacauthority')}
    end
    context "with valid auth" do
      context "with invalid proposal id" do
          command %(cleos push action dacproposals voteprop '{"custodian": "custodian1", "proposal_id": 1, "vote": 1 }' -p dacauthority -p custodian1), allow_error: true
        its(:stderr) {is_expected.to include('Proposal not found')}
      end
      context "proposal in pending_approval state" do
        context "claim_approve vote" do
          command %(cleos push action dacproposals voteprop '{"custodian": "custodian1", "proposal_id": 0, "vote": 1 }' -p dacauthority -p custodian1), allow_error: true
          its(:stdout) {is_expected.to include('dacproposals <= dacproposals::voteprop')}
        end
        context "claim_deny vote" do
          command %(cleos push action dacproposals voteprop '{"custodian": "custodian2", "proposal_id": 0, "vote": 2 }' -p dacauthority -p custodian2), allow_error: true
          its(:stdout) {is_expected.to include('dacproposals <= dacproposals::voteprop')}
        end
        context "proposal_approve vote" do
          command %(cleos push action dacproposals voteprop '{"custodian": "custodian3", "proposal_id": 0, "vote": 1 }' -p dacauthority -p custodian3), allow_error: true
          its(:stdout) {is_expected.to include('dacproposals <= dacproposals::voteprop')}
        end
        context "proposal_deny vote of existing vote" do
          command %(cleos push action dacproposals voteprop '{"custodian": "custodian3", "proposal_id": 0, "vote": 2 }' -p dacauthority -p custodian3), allow_error: true
          its(:stdout) {is_expected.to include('dacproposals <= dacproposals::voteprop')}
        end
      end
    end
  end

  describe "startwork" do
    before(:all) do
      `cleos push action dacproposals createprop '{"proposer": "proposeracc1", "title": "startwork_title", "summary": "startwork_summary", "arbitrator": "arbitrator11", "pay_amount": "101.0000 EOS", "content_hash": "asdfasdfasdfasdfasdfasdfasdffdsa" }' -p proposeracc1`
    end
    context "without valid auth" do
      command %(cleos push action dacproposals startwork '{ "proposer": "proposeracc1", "proposal_id": 1}' -p proposeracc2), allow_error: true
      its(:stderr) {is_expected.to include('missing authority of proposeracc1')}
    end
    context "with valid auth" do
      context "with invalid proposal id" do
        command %(cleos push action dacproposals startwork '{ "proposer": "proposeracc1", "proposal_id": 4}' -p proposeracc1), allow_error: true
        its(:stderr) {is_expected.to include('Proposal not found')}
      end
      context "proposal in pending_approval state" do
        context "with insufficient votes count" do
          command %(cleos push action dacproposals startwork '{ "proposer": "proposeracc1", "proposal_id": 1}' -p proposeracc1), allow_error: true
          its(:stderr) {is_expected.to include('Insufficient votes on worker proposal')}
        end
        context "with enough votes to activate" do
          context "with more denied than approved votes" do
            before(:all) do
              `cleos push action dacproposals voteprop '{"custodian": "custodian1", "proposal_id": 1, "vote": 2 }' -p custodian1 -p dacauthority`
              `cleos push action dacproposals voteprop '{"custodian": "custodian2", "proposal_id": 1, "vote": 2 }' -p custodian2 -p dacauthority`
              `cleos push action dacproposals voteprop '{"custodian": "custodian3", "proposal_id": 1, "vote": 2 }' -p custodian3 -p dacauthority`
              `cleos push action dacproposals voteprop '{"custodian": "custodian4", "proposal_id": 1, "vote": 2 }' -p custodian4 -p dacauthority`
              `cleos push action dacproposals voteprop '{"custodian": "custodian5", "proposal_id": 1, "vote": 2 }' -p custodian5 -p dacauthority`
              `cleos push action dacproposals voteprop '{"custodian": "custodian11", "proposal_id": 1, "vote": 1 }' -p custodian11 -p dacauthority`
              `cleos push action dacproposals voteprop '{"custodian": "custodian12", "proposal_id": 1, "vote": 1 }' -p custodian12 -p dacauthority`
              `cleos push action dacproposals voteprop '{"custodian": "custodian13", "proposal_id": 1, "vote": 1 }' -p custodian13 -p dacauthority`
            end
            command %(cleos push action dacproposals startwork '{ "proposer": "proposeracc1", "proposal_id": 1}' -p proposeracc1), allow_error: true
            its(:stderr) {is_expected.to include('Vote approval threshold not met.')}
          end
        end
        context "with enough votes to approve the proposal" do
          before(:all) do
            sleep 2
            `cleos push action dacproposals voteprop '{"custodian": "custodian1", "proposal_id": 1, "vote": 1 }' -p custodian1 -p dacauthority`
            `cleos push action dacproposals voteprop '{"custodian": "custodian2", "proposal_id": 1, "vote": 1 }' -p custodian2 -p dacauthority`
            `cleos push action dacproposals voteprop '{"custodian": "custodian3", "proposal_id": 1, "vote": 1 }' -p custodian3 -p dacauthority`
            `cleos push action dacproposals voteprop '{"custodian": "custodian4", "proposal_id": 1, "vote": 2 }' -p custodian4 -p dacauthority`
            `cleos push action dacproposals voteprop '{"custodian": "custodian5", "proposal_id": 1, "vote": 2 }' -p custodian5 -p dacauthority`
            `cleos push action dacproposals voteprop '{"custodian": "custodian11", "proposal_id": 1, "vote": 1 }' -p custodian11 -p dacauthority`
            `cleos push action dacproposals voteprop '{"custodian": "custodian12", "proposal_id": 1, "vote": 1 }' -p custodian12 -p dacauthority`
            `cleos push action dacproposals voteprop '{"custodian": "custodian13", "proposal_id": 1, "vote": 1 }' -p custodian13 -p dacauthority`
          end
            command %(cleos push action dacproposals startwork '{ "proposer": "proposeracc1", "proposal_id": 1}' -p proposeracc1), allow_error: true
          its(:stdout) {is_expected.to include('dacproposals::startwork')}
        end
      end
      context "proposal not in pending_approval state" do
        before(:all) {sleep 1.5}
        command %(cleos push action dacproposals startwork '{ "proposer": "proposeracc1", "proposal_id": 1, "nonce": "stuff"}' -p proposeracc1), allow_error: true
        its(:stderr) {is_expected.to include('Proposal is not in the pending approval state therefore cannot start work.')}
      end
    end
    context "Read the proposals table after createprop" do
      command %(cleos get table dacproposals dacproposals propvotes), allow_error: true
      it do
        expect(JSON.parse(subject.stdout)).to eq JSON.parse <<~JSON
            {
  "rows": [{
      "vote_id": 0,
      "proposal_id": 0,
      "voter": "custodian1",
      "vote": 1,
      "comment_hash": ""
    },{
      "vote_id": 1,
      "proposal_id": 0,
      "voter": "custodian2",
      "vote": 2,
      "comment_hash": ""
    },{
      "vote_id": 2,
      "proposal_id": 0,
      "voter": "custodian3",
      "vote": 2,
      "comment_hash": ""
    },{
      "vote_id": 3,
      "proposal_id": 1,
      "voter": "custodian1",
      "vote": 1,
      "comment_hash": ""
    },{
      "vote_id": 4,
      "proposal_id": 1,
      "voter": "custodian2",
      "vote": 1,
      "comment_hash": ""
    },{
      "vote_id": 5,
      "proposal_id": 1,
      "voter": "custodian3",
      "vote": 1,
      "comment_hash": ""
    },{
      "vote_id": 6,
      "proposal_id": 1,
      "voter": "custodian4",
      "vote": 2,
      "comment_hash": ""
    },{
      "vote_id": 7,
      "proposal_id": 1,
      "voter": "custodian5",
      "vote": 2,
      "comment_hash": ""
    },{
      "vote_id": 8,
      "proposal_id": 1,
      "voter": "custodian11",
      "vote": 1,
      "comment_hash": ""
    },{
      "vote_id": 9,
      "proposal_id": 1,
      "voter": "custodian12",
      "vote": 1,
      "comment_hash": ""
    }
  ],
  "more": true
}
        JSON
      end
    end
    context "Read the proposals table after startwork" do
      command %(cleos get table dacproposals dacproposals proposals), allow_error: true
      it do
        expect(JSON.parse(subject.stdout)).to eq JSON.parse <<~JSON
            {
          "rows": [{
              "key": 0,
              "proposer": "proposeracc1",
              "arbitrator": "arbitrator11",
              "content_hash": "asdfasdfasdfasdfasdfasdfasdfasdf",
              "pay_amount": "100.0000 EOS",
              "state": 0
            },{
              "key": 1,
              "proposer": "proposeracc1",
              "arbitrator": "arbitrator11",
              "content_hash": "asdfasdfasdfasdfasdfasdfasdffdsa",
              "pay_amount": "101.0000 EOS",
              "state": 1
            }
          ],
          "more": false
        }
        JSON
      end
    end
    context "Read the escrow table after startwork" do
      command %(cleos get table dacescrow dacescrow escrows), allow_error: true
      it do
        json = JSON.parse(subject.stdout)
        expect(json["rows"].count).to eq 1

        escrow = json["rows"].detect {|v| v["receiver"] == 'proposeracc1'}

        expect(escrow["key"]).to eq 0
        expect(escrow["sender"]).to eq 'dacproposals'
        expect(escrow["receiver"]).to eq 'proposeracc1'
        expect(escrow["arb"]).to eq 'arbitrator11'
        expect(escrow["approvals"].count).to eq 0
        expect(escrow["amount"]).to eq "101.0000 EOS"
        expect(escrow["memo"]).to eq "proposeracc1:1:asdfasdfasdfasdfasdfasdfasdffdsa"
        expect(escrow["external_reference"]).to eq 1
        expect(Date.iso8601(escrow["expires"]).day).to eq (Date.today().next_day(30).day)
      end
    end
  end

  context "voteprop with valid auth and proposal in work_in_progress state" do
    context "voteup" do
      command %(cleos push action dacproposals voteprop '{"custodian": "custodian1", "proposal_id": 1, "vote": 1 }' -p custodian1 -p dacauthority), allow_error: true
      its(:stderr) {is_expected.to include('Invalid proposal state to accept votes.')}
    end
    context "votedown" do
      command %(cleos push action dacproposals voteprop '{"custodian": "custodian1", "proposal_id": 1, "vote": 2 }' -p custodian1 -p dacauthority), allow_error: true
      its(:stderr) {is_expected.to include('Invalid proposal state to accept votes.')}
    end
  end

  describe "claim" do
    context "without valid auth" do
      before(:all) do
        `cleos push action eosdactokens transfer '{ "from": "testreguser1", "to": "daccustodian", "quantity": "5.0000 EOSDAC","memo":"daccustodian"}' -p testreguser1 -f`
        # Verify that a transaction with an invalid account memo still is insufficient funds.
        `cleos push action eosdactokens transfer '{ "from": "testreguser1", "to": "daccustodian", "quantity": "25.0000 EOSDAC","memo":"noncaccount"}' -p testreguser1 -f`
      end
      command %(cleos push action dacproposals claim '{ "proposer": "proposeracc1", "proposal_id": "1"}' -p proposeracc2), allow_error: true
      its(:stderr) {is_expected.to include('missing authority of proposeracc1')}
    end
    context "with valid auth" do
      context "with invalid proposal id" do
        command %(cleos push action dacproposals claim '{ "proposer": "proposeracc1", "proposal_id": "4"}' -p proposeracc1), allow_error: true
        its(:stderr) {is_expected.to include('Proposal not found')}
      end
      context "proposal in not in pending_claim state" do
        command %(cleos push action dacproposals claim '{ "proposer": "proposeracc1", "proposal_id": "0"}' -p proposeracc1), allow_error: true
        its(:stderr) {is_expected.to include('Proposal is not in the pending_claim state therefore cannot be claimed for payment')}
      end
      context "proposal is in pending_claim state" do
        before(:all) do
          `cleos push action dacproposals completework '{ "proposer": "proposeracc1", "proposal_id": "1"}' -p proposeracc1`
        end
        context "without enough votes to approve the claim" do
          command %(cleos push action dacproposals claim '{ "proposer": "proposeracc1", "proposal_id": "1"}' -p proposeracc1), allow_error: true
          its(:stderr) {is_expected.to include('Insufficient votes on worker proposal to approve or deny claim.')}
        end
        context "with enough votes to to complete claim with denial" do
          context "with more denied than approved votes" do
            before(:all) do
              `cleos push action dacproposals voteprop '{"custodian": "custodian1", "proposal_id": 1, "vote": 4 }' -p custodian1 -p dacauthority`
              `cleos push action dacproposals voteprop '{"custodian": "custodian2", "proposal_id": 1, "vote": 4 }' -p custodian2 -p dacauthority`
              `cleos push action dacproposals voteprop '{"custodian": "custodian3", "proposal_id": 1, "vote": 4 }' -p custodian3 -p dacauthority`
              `cleos push action dacproposals voteprop '{"custodian": "custodian4", "proposal_id": 1, "vote": 4 }' -p custodian4 -p dacauthority`
              `cleos push action dacproposals voteprop '{"custodian": "custodian5", "proposal_id": 1, "vote": 4 }' -p custodian5 -p dacauthority`
              `cleos push action dacproposals voteprop '{"custodian": "custodian11", "proposal_id": 1, "vote": 3 }' -p custodian11 -p dacauthority`
              `cleos push action dacproposals voteprop '{"custodian": "custodian12", "proposal_id": 1, "vote": 3 }' -p custodian12 -p dacauthority`
              `cleos push action dacproposals voteprop '{"custodian": "custodian13", "proposal_id": 1, "vote": 3 }' -p custodian13 -p dacauthority`
            end
            command %(cleos push action dacproposals claim '{ "proposer": "proposeracc1", "proposal_id": "1"}' -p proposeracc1), allow_error: true
            its(:stderr) {is_expected.to include('Claim approval threshold not met.')}
          end
          context "with enough votes to approve the claim" do
            before(:all) do
              `cleos push action dacproposals voteprop '{"custodian": "custodian1", "proposal_id": 1, "vote": 3 }' -p custodian1 -p dacauthority`
              `cleos push action dacproposals voteprop '{"custodian": "custodian2", "proposal_id": 1, "vote": 3 }' -p custodian2 -p dacauthority`
              `cleos push action dacproposals voteprop '{"custodian": "custodian3", "proposal_id": 1, "vote": 3 }' -p custodian3 -p dacauthority`
              `cleos push action dacproposals voteprop '{"custodian": "custodian4", "proposal_id": 1, "vote": 4 }' -p custodian4 -p dacauthority`
              `cleos push action dacproposals voteprop '{"custodian": "custodian5", "proposal_id": 1, "vote": 4 }' -p custodian5 -p dacauthority`
              `cleos push action dacproposals voteprop '{"custodian": "custodian11", "proposal_id": 1, "vote": 3 }' -p custodian11 -p dacauthority`
              `cleos push action dacproposals voteprop '{"custodian": "custodian12", "proposal_id": 1, "vote": 3 }' -p custodian12 -p dacauthority`
              `cleos push action dacproposals voteprop '{"custodian": "custodian13", "proposal_id": 1, "vote": 3 }' -p custodian13 -p dacauthority`
            end
            command %(cleos push action dacproposals claim '{ "proposer": "proposeracc1", "proposal_id": "1"}' -p proposeracc1), allow_error: true
            its(:stdout) {is_expected.to include('dacproposals <= dacproposals::claim')}
          end
        end
      end
    end
    context "Read the proposals table after createprop" do
      command %(cleos get table dacproposals dacproposals propvotes), allow_error: true
      it do
        expect(JSON.parse(subject.stdout)).to eq JSON.parse <<~JSON
            {
  "rows": [{
      "vote_id": 0,
      "proposal_id": 0,
      "voter": "custodian1",
      "vote": 1,
      "comment_hash": ""
    },{
      "vote_id": 1,
      "proposal_id": 0,
      "voter": "custodian2",
      "vote": 2,
      "comment_hash": ""
    },{
      "vote_id": 2,
      "proposal_id": 0,
      "voter": "custodian3",
      "vote": 2,
      "comment_hash": ""
    }
  ],
  "more": false
}
        JSON
      end
    end
    context "Read the proposals table after claim" do
      command %(cleos get table dacproposals dacproposals proposals), allow_error: true
      it do
        expect(JSON.parse(subject.stdout)).to eq JSON.parse <<~JSON
            {
          "rows": [{
              "key": 0,
              "proposer": "proposeracc1",
              "arbitrator": "arbitrator11",
              "content_hash": "asdfasdfasdfasdfasdfasdfasdfasdf",
              "pay_amount": "100.0000 EOS",
              "state": 0
            } 
          ],
          "more": false
        }
        JSON
      end
    end
    context "Read the escrow table after startwork" do
      command %(cleos get table dacescrow dacescrow escrows), allow_error: true
      it do
        json = JSON.parse(subject.stdout)
        expect(json["rows"].count).to eq 1

        escrow = json["rows"].detect {|v| v["receiver"] == 'proposeracc1'}

        expect(escrow["key"]).to eq 0
        expect(escrow["sender"]).to eq 'dacproposals'
        expect(escrow["receiver"]).to eq 'proposeracc1'
        expect(escrow["arb"]).to eq 'arbitrator11'
        expect(escrow["approvals"]).to eq ["dacproposals"]
        expect(escrow["amount"]).to eq "101.0000 EOS"
        expect(escrow["memo"]).to eq "proposeracc1:1:asdfasdfasdfasdfasdfasdfasdffdsa"
        expect(escrow["external_reference"]).to eq 1
        expect(Date.iso8601(escrow["expires"]).day).to eq (Date.today().next_day(30).day)
      end
    end
  end

  describe "cancel" do
    context "without valid auth" do
      command %(cleos push action dacproposals cancel '{ "proposer": "proposeracc1", "proposal_id": "0"}' -p proposeracc2), allow_error: true
      its(:stderr) {is_expected.to include('missing authority of proposeracc1')}
    end
    context "with valid auth" do
      context "with invalid proposal id" do
        command %(cleos push action dacproposals cancel '{ "proposer": "proposeracc1", "proposal_id": "4"}' -p proposeracc1), allow_error: true
        its(:stderr) {is_expected.to include('Proposal not found')}
      end
      context "with valid proposal id" do
        command %(cleos push action dacproposals cancel '{ "proposer": "proposeracc1", "proposal_id": "0"}' -p proposeracc1), allow_error: true
        its(:stdout) {is_expected.to include('dacproposals <= dacproposals::cancel')}
      end
      context "with valid proposal id after successfully started work but before completing" do
        before(:all) do
          sleep 1
          `cleos push action dacproposals createprop '{"proposer": "proposeracc1", "title": "startwork_title", "summary": "startwork_summary", "arbitrator": "arbitrator11", "pay_amount": "101.0000 EOS", "content_hash": "asdfasdfasdfasdfasdfasdfasdfzzzz" }' -p proposeracc1`

          `cleos push action dacproposals voteprop '{"custodian": "custodian1", "proposal_id": 2, "vote": 1 }' -p custodian1 -p dacauthority`
          `cleos push action dacproposals voteprop '{"custodian": "custodian2", "proposal_id": 2, "vote": 1 }' -p custodian2 -p dacauthority`
          # fail()
          `cleos push action dacproposals voteprop '{"custodian": "custodian3", "proposal_id": 2, "vote": 1 }' -p custodian3 -p dacauthority`
          `cleos push action dacproposals voteprop '{"custodian": "custodian4", "proposal_id": 2, "vote": 2 }' -p custodian4 -p dacauthority`
          `cleos push action dacproposals voteprop '{"custodian": "custodian5", "proposal_id": 2, "vote": 2 }' -p custodian5 -p dacauthority`
          `cleos push action dacproposals voteprop '{"custodian": "custodian11", "proposal_id": 2, "vote": 1 }' -p custodian11 -p dacauthority`
          `cleos push action dacproposals voteprop '{"custodian": "custodian12", "proposal_id": 2, "vote": 1 }' -p custodian12 -p dacauthority`
          `cleos push action dacproposals voteprop '{"custodian": "custodian13", "proposal_id": 2, "vote": 1 }' -p custodian13 -p dacauthority`

          `cleos push action dacproposals startwork '{ "proposer": "proposeracc1", "proposal_id": 2}' -p proposeracc1`

          # `cleos push action dacproposals completework '{ "proposer": "proposeracc1", "proposal_id": "2"}' -p proposeracc1`
          #
          # `cleos push action dacproposals voteprop '{"custodian": "custodian1", "proposal_id": 2, "vote": 3 }' -p custodian1`
          # `cleos push action dacproposals voteprop '{"custodian": "custodian2", "proposal_id": 2, "vote": 3 }' -p custodian2`
          # `cleos push action dacproposals voteprop '{"custodian": "custodian3", "proposal_id": 2, "vote": 3 }' -p custodian3`
          # `cleos push action dacproposals voteprop '{"custodian": "custodian4", "proposal_id": 2, "vote": 4 }' -p custodian4`
          # `cleos push action dacproposals voteprop '{"custodian": "custodian5", "proposal_id": 2, "vote": 4 }' -p custodian5`
          # `cleos push action dacproposals voteprop '{"custodian": "custodian11", "proposal_id": 2, "vote": 3 }' -p custodian11`
          # `cleos push action dacproposals voteprop '{"custodian": "custodian12", "proposal_id": 2, "vote": 3 }' -p custodian12`
          # `cleos push action dacproposals voteprop '{"custodian": "custodian13", "proposal_id": 2, "vote": 3 }' -p custodian13`
          #
          # `cleos push action dacproposals claim '{ "proposer": "proposeracc1", "proposal_id": "2"}' -p proposeracc1`
        end
        command %(cleos push action dacproposals cancel '{ "proposer": "proposeracc1", "proposal_id": "2"}' -p proposeracc1), allow_error: true
        its(:stdout) {is_expected.to include('dacproposals <= dacproposals::cancel')}
      end
    end
    context "Read the proposals table after cancel" do
      command %(cleos get table dacproposals dacproposals proposals), allow_error: true
      it do
        expect(JSON.parse(subject.stdout)).to eq JSON.parse <<~JSON
            {
          "rows": [ 
          ],
          "more": false
        }
        JSON
      end
    end
    context "Read the escrow table after startwork" do
      command %(cleos get table dacescrow dacescrow escrows), allow_error: true
      it do
        json = JSON.parse(subject.stdout)
        expect(json["rows"].count).to eq 2

        escrow = json["rows"].detect {|v| v["receiver"] == 'proposeracc1'}

        expect(escrow["key"]).to eq 0
        expect(escrow["sender"]).to eq 'dacproposals'
        expect(escrow["receiver"]).to eq 'proposeracc1'
        expect(escrow["arb"]).to eq 'arbitrator11'
        expect(escrow["approvals"]).to eq ["dacproposals"]
        expect(escrow["amount"]).to eq "101.0000 EOS"
        expect(escrow["memo"]).to eq "proposeracc1:1:asdfasdfasdfasdfasdfasdfasdffdsa"
        expect(escrow["external_reference"]).to eq 1
        expect(Date.iso8601(escrow["expires"]).day).to eq (Date.today().next_day(30).day)
      end
    end
  end

  describe "updateconfig" do
    context "without valid auth" do
      command %(cleos push action dacproposals updateconfig '{"new_config": { "service_account": "proposeracc1", "proposal_threshold": 5,"proposal_approval_threshold_percent": 90, "claim_threshold": 3, "claim_approval_threshold_percent": 20, "escrow_expiry": 2592000, "authority_account": "dacauthority"}}' -p proposeracc1), allow_error: true
      its(:stderr) {is_expected.to include('missing authority of dacauthority')}
    end
    context "with valid auth" do
      command %(cleos push action dacproposals updateconfig '{"new_config": { "service_account": "proposeracc1", "proposal_threshold": 4,"proposal_approval_threshold_percent": 30, "claim_threshold": 3, "claim_approval_threshold_percent": 20, "escrow_expiry": 2592000, "authority_account": "dacauthority"}}' -p dacauthority), allow_error: true
      its(:stdout) {is_expected.to include('dacproposals <= dacproposals::updateconfig')}
    end
  end
  context "Read the config table after createprop" do
    command %(cleos get table dacproposals dacproposals configtype), allow_error: true
    it do
      expect(JSON.parse(subject.stdout)).to eq JSON.parse <<~JSON
            {
              "rows": [{
                  "service_account": "proposeracc1",
                  "authority_account": "dacauthority",
                  "proposal_threshold": 4,
                  "proposal_approval_threshold_percent": 30,
                  "claim_threshold": 3,
                  "claim_approval_threshold_percent": 20,
                  "escrow_expiry": 2592000
                }
              ],
              "more": false
            }
      JSON
    end
  end
end
