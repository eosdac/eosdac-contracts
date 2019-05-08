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

CONTRACT_OWNER_PRIVATE_KEY = '5KYuGgAQUagSKsM66BpGsBhp9vFNnPEWuNjP5v4XHubUBY8j4KW'
CONTRACT_OWNER_PUBLIC_KEY = 'EOS54b6gLjogLNRS4Ay3JRxAke5r35FC6ZmJTTgVVeCrtbsYaNs9k'

CONTRACT_ACTIVE_PRIVATE_KEY = '5KYuGgAQUagSKsM66BpGsBhp9vFNnPEWuNjP5v4XHubUBY8j4KW'
CONTRACT_ACTIVE_PUBLIC_KEY = 'EOS54b6gLjogLNRS4Ay3JRxAke5r35FC6ZmJTTgVVeCrtbsYaNs9k'

CONTRACT_NAME = 'dacmultisigs'
ACCOUNT_NAME = 'dacmultisigs'

CONTRACTS_DIR = '../_test_helpers/system_contract_dependencies'

def configure_wallet
  beforescript = <<~SHELL

    cleos wallet unlock --password `cat ~/eosio-wallet/.pass`
    cleos wallet import --private-key #{CONTRACT_ACTIVE_PRIVATE_KEY}
    cleos wallet import --private-key #{EOSIO_PVT}
  SHELL

  `#{beforescript}`
end

def string_date_to_UTC input
  Date.iso8601(input).to_time.utc.to_datetime
end

def utc_today
  Date.today().to_time.utc.to_datetime
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

    cleos system newaccount --stake-cpu \"10.0000 EOS\" --stake-net \"10.0000 EOS\" --transfer --buy-ram-kbytes 1024 eosio #{ACCOUNT_NAME} #{CONTRACT_OWNER_PUBLIC_KEY} #{CONTRACT_ACTIVE_PUBLIC_KEY}
    cleos system newaccount --stake-cpu \"10.0000 EOS\" --stake-net \"10.0000 EOS\" --transfer --buy-ram-kbytes 1024 eosio dacauthority #{CONTRACT_OWNER_PUBLIC_KEY} #{CONTRACT_ACTIVE_PUBLIC_KEY}
    cleos push action eosio.token issue '["dacauthority", "10000.0000 EOS", "Initial EOS amount."]' -p eosio


   # Setup the inital permissions.
   # cleos set account permission dacauthority owner '{"threshold": 1,"keys": [{"key": "#{CONTRACT_ACTIVE_PUBLIC_KEY}","weight": 1}],"accounts": [{"permission":{"actor":"#{CONTRACT_NAME}","permission":"eosio.code"},"weight":1}]}' '' -p dacauthority@owner

   # cleos set account permission dacauthority high #{CONTRACT_OWNER_PUBLIC_KEY} owner -p dacauthority@owner 
   # cleos set account permission dacauthority med #{CONTRACT_OWNER_PUBLIC_KEY} high -p dacauthority@owner 
   # cleos set account permission dacauthority low #{CONTRACT_OWNER_PUBLIC_KEY} med -p dacauthority@owner 
   # cleos set account permission dacauthority one #{CONTRACT_OWNER_PUBLIC_KEY} low -p dacauthority@owner

    # cleos set action permission dacmultisigs dacmultisigs '' eosio.code -p dacmultisigs@owner

    cleos set contract #{CONTRACT_NAME} ../_compiled_contracts/#{CONTRACT_NAME}/#{CONTRACT_NAME} -p #{ACCOUNT_NAME}


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
  seed_account("invaliduser1")

  seed_account("tester1")

  seed_account("custodian1")
  seed_account("custodian2")
  seed_account("custodian3")
  seed_account("approver1")

  `cleos set account permission custodian1 active '{"threshold": 1,"keys": [{"key": "#{CONTRACT_ACTIVE_PUBLIC_KEY}","weight": 1}],"accounts": [{"permission":{"actor":"dacmultisigs","permission":"eosio.code"},"weight":1}]}' owner -p custodian1@owner`
  `cleos set account permission custodian2 active '{"threshold": 1,"keys": [{"key": "#{CONTRACT_ACTIVE_PUBLIC_KEY}","weight": 1}],"accounts": [{"permission":{"actor":"dacmultisigs","permission":"eosio.code"},"weight":1}]}' owner -p custodian2@owner`
  `cleos set account permission custodian3 active '{"threshold": 1,"keys": [{"key": "#{CONTRACT_ACTIVE_PUBLIC_KEY}","weight": 1}],"accounts": [{"permission":{"actor":"dacmultisigs","permission":"eosio.code"},"weight":1}]}' owner -p custodian3@owner`

  `cleos set account permission dacauthority active '{"threshold": 1,"keys": [],"accounts": [{"permission":{"actor":"custodian1","permission":"active"},"weight":1},{"permission":{"actor":"custodian2","permission":"active"},"weight":1},{"permission":{"actor":"custodian3","permission":"active"},"weight":1}]}' owner -p dacauthority@owner`

end

describe "dacmultisigs" do
  before(:all) do
    reset_chain
    # compile_contract
    puts "Give the chain a chance to settle."
    sleep 3
    configure_wallet
    seed_system_contracts
    install_contracts
    configure_contracts_for_tests
  end

  after(:all) do
    killchain
  end

  describe "proposed" do
    before(:all) do
      # first put proposal in the system msig contract.
      puts `cleos multisig propose myproposal '[{"actor": "custodian1", "permission": "active"}]' '[{"actor": "custodian1", "permission": "active"}]' eosio.token transfer '{ "from": "custodian1", "to": "tester1", "quantity": "1.0000 EOS", "memo": "random memo"}' -p custodian1`
      puts `cleos multisig review custodian1 myproposal`

    end
    context "without invalid auth" do
      command %(cleos push action dacmultisigs proposed '{ "transactionid": "579159b224ebd9c0a3d36b1c53ae97a2df96025a054b29b62f1534ecfed080bf", "proposer": "custodian1", "proposal_name": "myproposal", "metadata": "random meta"}' -p invaliduser1
), allow_error: true
      its(:stderr) {is_expected.to include('Error 3090004')}
    end

    context "with valid auth" do
      command %(cleos push action dacmultisigs proposed '{ "proposer": "custodian1", "proposal_name": "myproposal", "transactionid": "579159b224ebd9c0a3d36b1c53ae97a2df96025a054b29b62f1534ecfed080bf", "metadata": "random meta"}' -p dacauthority -p custodian1), allow_error: true
      its(:stdout) {is_expected.to include('dacmultisigs::proposed')}
    end

    context "Read the proposals table after successful proposal" do
      command %(cleos get table dacmultisigs custodian1 proposals), allow_error: true
      it do
        json = JSON.parse(subject.stdout)
        expect(json["rows"].count).to eq 1

        prop = json["rows"].detect {|v| v["proposalname"] == 'myproposal'}

        expect(prop["transactionid"].length).to be > 50
        expect(string_date_to_UTC(prop["modifieddate"]).day).to eq (utc_today.day)
      end
    end
  end

  xdescribe "stinproposal" do
    context "without valid auth" do
      command %(cleos push action dacmultisigs stinproposal '{"proposer": "tester1", "proposal_name": "firecand1", "requested" : [{"actor": "tester1", "permission": "active"}], "trx": {"expiration": "2018-10-29T00:42:34", "ref_block_num": 26563, "ref_block_prefix": 4040666510, "max_net_usage_words": 0, "max_cpu_usage_ms": 0, "delay_sec": 30, "context_free_actions": [], "actions": [{"account": "dacmultisigs", "name": "stproposal", "authorization" : [{"actor": "tester1", "permission": "active"}], "data": "40353739313539623232346562643963306133643336623163353361653937613264663936303235613035346232396236326631353334656366656430383062660040b80aebe4a2d900403498567aab97", "context_free_data": []}], "transaction_extensions": []}}' -p tester1), allow_error: true
      its(:stderr) {is_expected.to include('Error 3090004')}
    end

    context "with valid auth" do
      command %(cleos push action dacmultisigs stinproposal '{"proposer": "tester1", "proposal_name": "firecand1", "requested" : [{"actor": "tester1", "permission": "active"}], "trx": {"expiration": "2018-10-29T00:42:34", "ref_block_num": 26563, "ref_block_prefix": 4040666510, "max_net_usage_words": 0, "max_cpu_usage_ms": 0, "delay_sec": 30, "context_free_actions": [], "actions": [{"account": "dacmultisigs", "name": "stproposal", "authorization" : [{"actor": "tester1", "permission": "active"}], "data": "40353739313539623232346562643963306133643336623163353361653937613264663936303235613035346232396236326631353334656366656430383062660040b80aebe4a2d900403498567aab97", "context_free_data": []}], "transaction_extensions": []}}' -p dacauthority), allow_error: true
      its(:stdout) {is_expected.to include('dacmultisigs::stinproposal')}
    end
  end

  describe "approved" do
    context "with invalid auth" do
      command %(cleos push action dacmultisigs approved '{ "proposer": "custodian1", "proposal_name": "myproposal", "level": {"actor": "custodian1", "permission": "active"}, "approver": "approver1"}' -p invaliduser1 -p approver1), allow_error: true
      its(:stderr) {is_expected.to include('Error 3090004')}
    end

    context "with valid auth" do
      command %(cleos push action dacmultisigs approved '{ "proposer": "custodian1", "proposal_name": "myproposal", "level": {"actor": "custodian1", "permission": "active"}, "approver": "approver1"}' -p custodian1 -p approver1 -p dacauthority), allow_error: true
      its(:stdout) {is_expected.to include('dacmultisigs::approved')}
    end
  end

  describe "unapproved" do
    context "with invalid auth" do
      command %(cleos push action dacmultisigs approved '{ "proposer": "custodian1", "proposal_name": "myproposal", "level": {"actor": "custodian1", "permission": "active"}, "approver": "approver1"}' -p invaliduser1 -p approver1), allow_error: true
      its(:stderr) {is_expected.to include('Error 3090004')}
    end

    context "with valid auth and previously granted permission" do
      command %(cleos push action dacmultisigs unapproved '{ "proposer": "custodian1", "proposal_name": "myproposal", "level": {"actor": "custodian1", "permission": "active"}, "unapprover": "approver1"}' -p custodian1 -p approver1 -p dacauthority), allow_error: true
      its(:stdout) {is_expected.to include('dacmultisigs::unapproved')}
    end
  end

  describe "cancelled" do
    context "with invalid auth" do
      command %(cleos push action dacmultisigs cancelled '{ "proposer": "custodian1", "proposal_name": "myproposal", "canceler": "invaliduser1" }' -p dacauthority), allow_error: true
      its(:stderr) {is_expected.to include('missing authority of invaliduser1')}
    end
    context "with valid proposer auth" do
      context "without removing the msig from the system contract" do
        command %(cleos push action dacmultisigs cancelled '{ "proposer": "custodian1", "proposal_name": "myproposal", "canceler": "custodian2"}}' -p custodian2 -p dacauthority), allow_error: true
        its(:stderr) {is_expected.to include('ERR::PROPOSAL_EXISTS')}
      end
      context "with removing the msig from the system contract" do
        before(:all) do
          # first put proposal in the system msig contract.
          puts `cleos multisig cancel custodian1 myproposal custodian1 -p custodian1`
        end
        command %(cleos push action dacmultisigs cancelled '{ "proposer": "custodian1", "proposal_name": "myproposal", "canceler": "custodian1"}' -p custodian1 -p dacauthority), allow_error: true
        its(:stdout) {is_expected.to include('dacmultisigs::cancelled')}
      end
    end

    context "Read the proposals table after successful proposal" do
      command %(cleos get table dacmultisigs custodian1 proposals), allow_error: true
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

  describe "executed" do
    before(:all) do
      # first put proposal in the system msig contract.
      puts `cleos multisig propose myproposal2 '[{"actor": "custodian1", "permission": "active"}]' '[{"actor": "custodian1", "permission": "active"}]' eosio.token transfer '{ "from": "custodian1", "to": "tester1", "quantity": "1.0000 EOS", "memo": "random memo"}}' -p custodian1`
      puts `cleos multisig review custodian1 myproposal2`
      puts `cleos push action dacmultisigs proposed '{ "proposer": "custodian1", "proposal_name": "myproposal2", "transactionid": "579159b224ebd9c0a3d36b1c53ae97a2df96025a054b29b62f1534ecfed080bf", "metadata": "random meta"}' -p dacauthority -p custodian1`
    end

    context "Read the proposals table after successful proposal" do
      command %(cleos get table dacmultisigs custodian1 proposals), allow_error: true
      it do
        json = JSON.parse(subject.stdout)
        expect(json["rows"].count).to eq 1

        prop = json["rows"].detect {|v| v["proposalname"] == 'myproposal2'}

        expect(prop["transactionid"].length).to be > 50
        expect(string_date_to_UTC(prop["modifieddate"]).day).to eq (utc_today.day)
      end
    end

    context "with invalid auth" do
      command %(cleos push action dacmultisigs executed  '{ "proposer": "custodian1", "proposal_name": "myproposal2", "executer": "invaliduser1" }' -p invaliduser2 -p dacauthority), allow_error: true
      its(:stderr) {is_expected.to include('Provided keys, permissions, and delays do not satisfy declared authorizations')}
    end

    context "with valid proposer auth" do
      before(:all) do
        puts `cleos push action dacmultisigs approved '{ "proposer": "custodian1", "proposal_name": "myproposal2", "approver": "custodian1" }' -p custodian1 -p dacauthority`
        puts `cleos multisig approve custodian1 myproposal2 '{"actor": "custodian1", "permission": "active"}'`
        puts `cleos multisig exec custodian1 myproposal2 custodian1 -p custodian1`
      end

      command %(cleos push action dacmultisigs executed '{ "proposer": "custodian1", "proposal_name": "myproposal2", "executer": "custodian1"}' -p custodian1 -p dacauthority), allow_error: true
      its(:stdout) {is_expected.to include('dacmultisigs::executed')}
    end

    context "Read the proposals table after successful proposal" do
      command %(cleos get table dacmultisigs custodian1 proposals), allow_error: true
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

