require 'rspec_command'
require 'json'
require 'date'

RSpec.configure do |config|
  config.include RSpecCommand
end


EOSIO_PRIVATE_KEY = '5KDFWhsMK3fuze6yXgFRmVDEEE5kbQJrJYCBhGKV2KWHCbjsYYy'
EOSIO_PUBLIC_KEY = 'EOS8kkhi1qYPWJMpDJXabv4YnqjuzisA5ZdRpGG8vhSGmRDqi6CUn'

CONTRACT_PRIVATE_KEY = '5Jbf3f26fz4HNWXVAd3TMYHnC68uu4PtkMnbgUa5mdCWmgu47sR'
CONTRACT_PUBLIC_KEY = 'EOS7rjn3r52PYd2ppkVEKYvy6oRDP9MZsJUPB2MStrak8LS36pnTZ'

def run?(command)
  puts command
  system (command)
end

def run(command)
  puts command
  system (command)
  exit_code = $?
  if exit_code.exitstatus != 0
    raise 'Exit code is not zero'
  end
end

def configure_wallet
    run? %(cleos wallet unlock --password `cat ~/eosio-wallet/.pass`)
    run? %(cleos wallet import --private-key #{CONTRACT_PRIVATE_KEY})
    run? %(cleos wallet import --private-key #{EOSIO_PRIVATE_KEY})
end
  


# @param [eos account name for the new account] name
# @param [if not nil amount of eosdac to issue to the new account] issue
# @param [if not nil register the account with the agreed terms as this value] memberreg
# @param [if not nil transfer this amount to the elections contract so they can register as an election candidate] stake
# @param [if not nil register as a candidate with this amount as the requested pay] requestedpay
def seed_dac_account(name, issue: nil, memberreg: nil, stake: nil, requestedpay: nil, dac_scope: nil, dac_owner: nil)
  if dac_scope.nil? || dac_owner.nil? { fail() }

  end
  run? %(cleos system newaccount --stake-cpu "10.0000 EOS" --stake-net "10.0000 EOS" --transfer --buy-ram-kbytes 1024 eosio #{name} #{CONTRACT_PUBLIC_KEY} #{CONTRACT_PUBLIC_KEY})

  if !issue.nil? && !dac_owner.nil?
    run %(cleos push action eosdactokens issue '{ "to": "#{name}", "quantity": "#{issue}", "memo": "Initial amount."}' -p #{dac_owner})
  end

  if !memberreg.nil? && !dac_scope.nil?
    run? %(cleos push action eosdactokens memberrege '{ "sender": "#{name}", "agreedterms": "#{memberreg}", "dac_id": "#{dac_scope}"}' -p #{name})
  end

  unless stake.nil?
    run %(cleos push action eosdactokens transfer '{ "from": "#{name}", "to": "daccustodian", "quantity": "#{stake}","memo":"daccustodian"}' -p #{name})
  end

  if !requestedpay.nil? && !dac_scope.nil?
    run %(cleos push action daccustodian nominatecand '{ "cand": "#{name}", "bio": "any bio", "requestedpay": "#{requestedpay}", "dac_scope": "#{dac_scope}"}' -p #{name})
  end
end

def string_date_to_UTC input
  Date.iso8601(input).to_time.utc.to_datetime
end

def utc_today
  Date.today().to_time.utc.to_datetime
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

CONTRACTS_DIR = '../_test_helpers/system_contract_dependencies'

def seed_system_contracts
    run %(cleos set contract eosio #{CONTRACTS_DIR}/eosio.bios -p eosio)
    run %(cleos create account eosio eosio.msig #{EOSIO_PUBLIC_KEY})
    run %(cleos get code eosio.msig)
    run %(cleos create account eosio eosio.token #{EOSIO_PUBLIC_KEY})
    run %(cleos create account eosio eosio.ram #{EOSIO_PUBLIC_KEY})
    run %(cleos create account eosio eosio.ramfee #{EOSIO_PUBLIC_KEY})
    run %(cleos create account eosio eosio.names #{EOSIO_PUBLIC_KEY})
    run %(cleos create account eosio eosio.stake #{EOSIO_PUBLIC_KEY})
    run %(cleos create account eosio eosio.saving #{EOSIO_PUBLIC_KEY})
    run %(cleos create account eosio eosio.bpay #{EOSIO_PUBLIC_KEY})
    run %(cleos create account eosio eosio.vpay #{EOSIO_PUBLIC_KEY})
    run %(cleos push action eosio setpriv  '["eosio.msig",1]' -p eosio)
    run %(cleos set contract eosio.msig #{CONTRACTS_DIR}/eosio.msig -p eosio.msig)
    run %(cleos set contract eosio.token #{CONTRACTS_DIR}/eosio.token -p eosio.token)
    run %(cleos push action eosio.token create '["eosio","10000000000.0000 EOS"]' -p eosio.token)
    run %(cleos push action eosio.token issue '["eosio", "1000000000.0000 EOS", "Initial EOS amount."]' -p eosio)
    run %(cleos set contract eosio #{CONTRACTS_DIR}/eosio.system -p eosio)
end

def configure_dac_accounts_and_permissions

    run %(cleos system newaccount --stake-cpu "10.0000 EOS" --stake-net "10.0000 EOS" --transfer --buy-ram-kbytes 1024 eosio dacdirectory #{CONTRACT_PUBLIC_KEY} #{CONTRACT_PUBLIC_KEY})
    run %(cleos system newaccount --stake-cpu "10.0000 EOS" --stake-net "10.0000 EOS" --transfer --buy-ram-kbytes 2024 eosio daccustodian #{CONTRACT_PUBLIC_KEY} #{CONTRACT_PUBLIC_KEY})
    run %(cleos system newaccount --stake-cpu "10.0000 EOS" --stake-net "10.0000 EOS" --transfer --buy-ram-kbytes 2024 eosio daccustmock #{CONTRACT_PUBLIC_KEY} #{CONTRACT_PUBLIC_KEY}) # mock contract
    run %(cleos system newaccount --stake-cpu "10.0000 EOS" --stake-net "10.0000 EOS" --transfer --buy-ram-kbytes 1024 eosio eosdactokens #{CONTRACT_PUBLIC_KEY} #{CONTRACT_PUBLIC_KEY})
    run %(cleos system newaccount --stake-cpu "10.0000 EOS" --stake-net "10.0000 EOS" --transfer --buy-ram-kbytes 1024 eosio dacauthority #{CONTRACT_PUBLIC_KEY} #{CONTRACT_PUBLIC_KEY})
    run %(cleos system newaccount --stake-cpu "10.0000 EOS" --stake-net "10.0000 EOS" --transfer --buy-ram-kbytes 1024 eosio eosdacthedac #{CONTRACT_PUBLIC_KEY} #{CONTRACT_PUBLIC_KEY})
    run %(cleos system newaccount --stake-cpu "10.0000 EOS" --stake-net "10.0000 EOS" --transfer --buy-ram-kbytes 1024 eosio dacocoiogmbh #{CONTRACT_PUBLIC_KEY} #{CONTRACT_PUBLIC_KEY})
    run %(cleos system newaccount --stake-cpu "10.0000 EOS" --stake-net "10.0000 EOS" --transfer --buy-ram-kbytes 1024 eosio dacproposals #{CONTRACT_PUBLIC_KEY} #{CONTRACT_PUBLIC_KEY})
    run %(cleos system newaccount --stake-cpu "10.0000 EOS" --stake-net "10.0000 EOS" --transfer --buy-ram-kbytes 1024 eosio dacescrow    #{CONTRACT_PUBLIC_KEY} #{CONTRACT_PUBLIC_KEY})

    run %(cleos system newaccount --stake-cpu "10.0000 EOS" --stake-net "10.0000 EOS" --transfer --buy-ram-kbytes 1024 eosio dacdirtester #{CONTRACT_PUBLIC_KEY} #{CONTRACT_PUBLIC_KEY})

    # Setup the inital permissions.
    run %(cleos set account permission dacauthority owner '{"threshold": 1,"keys": [{"key": "#{CONTRACT_PUBLIC_KEY}","weight": 1}],"accounts": [{"permission":{"actor":"daccustodian","permission":"eosio.code"},"weight":1}]}' '' -p dacauthority@owner)
    run %(cleos set account permission dacauthority active '{"threshold": 1,"keys": [{"key": "#{CONTRACT_PUBLIC_KEY}","weight": 1}],"accounts": [{"permission":{"actor":"daccustodian","permission":"eosio.code"},"weight":1}]}' owner   -p dacauthority@owner)
    # cleos set account permission eosdacthedac active '{"threshold": 1,"keys": [{"key": "#{CONTRACT_PUBLIC_KEY}","weight": 1}],"accounts": [{"permission":{"actor":"daccustodian","permission":"eosio.code"},"weight":1}]}' owner -p eosdacthedac@owner)
    run %(cleos set account permission dacproposals active '{"threshold": 1,"keys": [{"key": "#{CONTRACT_PUBLIC_KEY}","weight": 1}],"accounts": [{"permission":{"actor":"dacproposals","permission":"eosio.code"},"weight":1}]}' owner -p dacproposals@owner)
    run %(cleos set account permission daccustodian xfer '{"threshold": 1,"keys": [{"key": "#{CONTRACT_PUBLIC_KEY}","weight": 1}],"accounts": [{"permission":{"actor":"daccustodian","permission":"eosio.code"},"weight":1}]}' active -p daccustodian@active)
    # run %(cleos set account permission daccustodian one '{"threshold": 1,"keys": [{"key": "#{CONTRACT_PUBLIC_KEY}","weight": 1}],"accounts": [{"permission":{"actor":"daccustodian","permission":"eosio.code"},"weight":1}]}' low -p daccustodian@active)
    run %(cleos push action eosio.token issue '["eosdacthedac", "100000.0000 EOS", "Initial EOS amount."]' -p eosio)
    run %(cleos push action eosio.token issue '["dacproposals", "100000.0000 EOS", "Initial EOS amount."]' -p eosio)
    run %(cleos set action permission eosdacthedac eosdactokens transfer xfer)
    run %(cleos set action permission eosdacthedac eosio.token transfer xfer)
    run %(cleos set action permission daccustodian eosdactokens transfer xfer)
    
    # Configure accounts permissions hierarchy
      run %(cleos set account permission dacauthority high #{CONTRACT_PUBLIC_KEY} active -p dacauthority )
    run %(cleos set account permission dacauthority med #{CONTRACT_PUBLIC_KEY} high -p dacauthority )
    run %(cleos set account permission dacauthority low #{CONTRACT_PUBLIC_KEY} med -p dacauthority )
    run %(cleos set account permission dacauthority one #{CONTRACT_PUBLIC_KEY} low -p dacauthority  )
    run %(cleos set account permission eosdactokens active '{"threshold": 1,"keys": [{"key": "#{CONTRACT_PUBLIC_KEY}","weight": 1}],"accounts": [{"permission":{"actor":"eosdactokens","permission":"eosio.code"},"weight":1}]}' owner -p eosdactokens)
    run %(cleos set account permission daccustodian active '{"threshold": 1,"keys": [{"key": "#{CONTRACT_PUBLIC_KEY}","weight": 1}],"accounts": [{"permission":{"actor":"daccustodian","permission":"eosio.code"},"weight":1}]}' owner -p daccustodian)
    run %(cleos set account permission eosdacthedac xfer '{"threshold": 1,"keys": [],"accounts": [{"permission":{"actor":"daccustodian","permission":"eosio.code"},"weight":1},{"permission":{"actor":"dacproposals","permission":"eosio.code"},"weight":1}]}' active -p eosdacthedac@active)
    run %(cleos set account permission eosdacthedac active '{"threshold": 1,"keys": [],"accounts": [{"permission":{"actor":"dacproposals","permission":"eosio.code"},"weight":1}]}' owner -p eosdacthedac@owner)

    # Set action permission for the voteprop
    run %(cleos set action permission dacauthority dacproposals voteprop one)
end

def killchain
  # `sleep 0.5; kill \`pgrep nodeos\``
end

def mylog(str = "marker")
  puts ":#{__LINE__}:marker"
end

def install_dac_contracts
    run %(cleos set contract dacdirectory ../_compiled_contracts/dacdirectory/unit_tests/dacdirectory -p dacdirectory)
    run %(cleos set contract eosdactokens ../_compiled_contracts/eosdactokens -p eosdactokens)
    run %(cleos set contract dacescrow    ../_compiled_contracts/dacescrow/unit_tests/dacescrow -p dacescrow)
    run %(cleos set contract dacproposals ../_compiled_contracts/dacproposals -p dacproposals)
    run %(cleos set contract daccustodian ../_compiled_contracts/daccustodian/unit_tests/daccustodian -p daccustodian)

    # Mock contracts to help testing
    run %(cleos set contract daccustmock  ../_test_helpers/daccustodian_stub/daccustodian -p daccustmock)
    run %(cleos set contract dacdirtester ../_test_helpers/dacdirtester/dacdirtester -p dacdirtester)

end

def wrap_command cli_command
  puts "Executed: \n#{cli_command}\n"
  command cli_command, allow_error: true
end
