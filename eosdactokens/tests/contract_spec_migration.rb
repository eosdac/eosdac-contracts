require_relative '../../_test_helpers/CommonTestHelpers'

# Configure the initial state for the contracts for elements that are assumed to work from other contracts already.
def configure_contracts_for_tests
  # configure accounts for eosdactokens
  run? %(cleos system newaccount --stake-cpu "10.0000 EOS" --stake-net "20.0000 EOS" --transfer --buy-ram-kbytes 2024 eosio dacowner #{CONTRACT_PUBLIC_KEY} #{CONTRACT_PUBLIC_KEY})
  run? %(cleos system newaccount --stake-cpu "10.0000 EOS" --stake-net "10.0000 EOS" --transfer --buy-ram-kbytes 2024 eosio otherowner #{CONTRACT_PUBLIC_KEY} #{CONTRACT_PUBLIC_KEY})

  run %(cleos push action dacdirectory regdac '{"owner": "dacowner",  "dac_name": "eosdacio", "dac_symbol": "4,EOSDAC", "title": "Custodian Test DAC", "refs": [[1,"some_ref"]], "accounts": [[2,"daccustodian"], [5,"dacocoiogmbh"], [7,"dacescrow"], [0, "dacowner"],  [4, "eosdactokens"], [1, "eosdacthedac"]], "scopes": [] }' -p dacowner)

  run %(cleos push action daccustodian updateconfige '{"newconfig": { "lockupasset": "10.0000 EOSDAC", "maxvotes": 5, "periodlength": 604800 , "numelected": 12, "should_pay_via_service_provider": 1, "auththresh": 3, "initial_vote_quorum_percent": 15, "vote_quorum_percent": 10, "auth_threshold_high": 11, "auth_threshold_mid": 7, "auth_threshold_low": 3, "lockup_release_time_delay": 10, "requested_pay_max": "450.0000 EOS"}, "dac_id": "eosdacio"}' -p dacowner)
  # run %(cleos push action daccustodian updateconfige '{"newconfig": { "lockupasset": "10.0000 EOSDAC", "maxvotes": 5, "periodlength": 604800 , "numelected": 12, "should_pay_via_service_provider": 1, "auththresh": 3, "initial_vote_quorum_percent": 15, "vote_quorum_percent": 10, "auth_threshold_high": 11, "auth_threshold_mid": 7, "auth_threshold_low": 3, "lockup_release_time_delay": 10, "requested_pay_max": "450.0000 EOS"}, "dac_id": "otherdac"}' -p otherowner -p dacowner)

  # run %(cleos push action eosdactokens create '{ "issuer": "dacowner",   "maximum_supply": "100000.0000 EOSDAC", "transfer_locked": false}' -p dacowner)
  # run %(cleos push action eosdactokens create '{ "issuer": "otherowner", "maximum_supply": "100000.0000 OTRDAC", "transfer_locked": false}' -p otherowner)

  # run %(cleos push action eosdactokens issue '{ "to": "eosdactokens", "quantity": "77337.0000 EOSDAC", "memo": "Initial amount of tokens for you."}' -p dacowner)
  # run %(cleos push action eosdactokens issue '{ "to": "eosdactokens", "quantity": "77337.0000 OTRDAC", "memo": "Initial amount of tokens for you."}' -p otherowner)
  # run %(cleos push action eosio.token  issue '{ "to": "eosdacthedac", "quantity": "100000.0000 EOS", "memo": "Initial EOS amount."}' -p eosio)
  # run %(cleos push action eosdactokens issue '{ "to": "eosdacthedac", "quantity": "1000.0000 EOSDAC", "memo": "Initial amount of tokens for you."}' -p dacowner)
  # run %(cleos push action eosdactokens issue '{ "to": "eosdacthedac", "quantity": "1000.0000 OTRDAC", "memo": "Initial amount of tokens for you."}' -p otherowner)


  # run %(cleos push action eosdactokens newmemtermse '{ "terms": "normallegalterms", "hash": "New Latest terms", "dac_id": "custtestdac"}' -p dacowner)
  # run %(cleos push action eosdactokens newmemtermse '{ "terms": "normallegalterms", "hash": "New Latest terms", "dac_id": "otherdac"}' -p otherowner -p dacowner)

  #create users 
  # seed_dac_account("testreguser1", issue: "100.0000 EOSDAC", memberreg: "New Latest terms", dac_id: "custtestdac", dac_owner: "dacowner")
  # seed_dac_account("testreguser1", issue: "100.0000 OTRDAC", memberreg: "New Latest terms", dac_id: "otherdac", dac_owner: "otherowner") # run again for the same user in a different dac should just do the DAC stuff.
  # seed_dac_account("testreguser2", issue: "100.0000 EOSDAC")
  # seed_dac_account("testreguser3", issue: "100.0000 EOSDAC", dac_id: "custtestdac", dac_owner: "dacowner")
  # seed_dac_account("testreguser4", issue: "100.0000 EOSDAC", memberreg: "old terms", dac_id: "custtestdac", dac_owner: "dacowner")
  # seed_dac_account("testreguser5", issue: "100.0000 EOSDAC", memberreg: "New Latest terms", dac_id: "custtestdac", dac_owner: "dacowner")
  # seed_dac_account("testregusera", issue: "100.0000 EOSDAC", memberreg: "New Latest terms", dac_id: "custtestdac", dac_owner: "dacowner")

  # This is required to allow the newperiode to run and set the account permissions from within the action.
  run %(cleos set account permission dacowner owner '{"threshold": 1,"keys": [{"key": "#{CONTRACT_PUBLIC_KEY}","weight": 1}],"accounts": [{"permission":{"actor":"daccustodian","permission":"eosio.code"},"weight":1}]}' '' -p dacowner@owner)
  # Configure accounts permissions hierarchy
  run %(cleos set account permission dacowner high #{CONTRACT_PUBLIC_KEY} active -p dacowner)
  run %(cleos set account permission dacowner med #{CONTRACT_PUBLIC_KEY} high -p dacowner)
  run %(cleos set account permission dacowner low #{CONTRACT_PUBLIC_KEY} med -p dacowner)
  run %(cleos set account permission dacowner one #{CONTRACT_PUBLIC_KEY} low -p dacowner)

end

describe "migrate" do
  before(:all) do
    # reset_chain
    resume_chain
    configure_wallet
    seed_system_contracts

    configure_dac_accounts_and_permissions

    install_dac_contracts

    configure_contracts_for_tests
  end

  after(:all) do
    killchain
  end

  describe "preconditions" do
    context "Read the members table" do
      it do
        result = wrap_command %(cleos get table eosdactokens eosdactokens members --limit 40)
        expect(JSON.parse(result.stdout)).to eq JSON.parse <<~JSON
        {
          "rows": [{
              "sender": "testuser1",
              "agreedtermsversion": 2
            },{
              "sender": "testuser11",
              "agreedtermsversion": 2
            },{
              "sender": "testuser12",
              "agreedtermsversion": 2
            },{
              "sender": "testuser2",
              "agreedtermsversion": 2
            },{
              "sender": "testuser4",
              "agreedtermsversion": 2
            },{
              "sender": "testuser5",
              "agreedtermsversion": 2
            }
          ],
          "more": false
        }        
        JSON
      end
    end
    context "Read the memberterms table" do
      it do
        result = wrap_command %(cleos get table eosdactokens eosdactokens memberterms --limit 40)
        expect(JSON.parse(result.stdout)).to eq JSON.parse <<~JSON
          {
            "rows": [{
                "terms": "newtermslocation",
                "hash": "asdfasdfasdfasdfasdfasd",
                "version": 1
              },{
                "terms": "normallegalterms2",
                "hash": "dfghdfghdfghdfghdfg",
                "version": 2
              }
            ],
            "more": false
          }
        JSON
      end
    end

    xdescribe "updateconfige" do
      context "before being called with token contract will prevent other actions from working" do
        it "with valid and registered member" do
          result = wrap_command %(cleos push action daccustodian nominatecane '{ "cand": "testreguser1", "requestedpay": "11.5000 EOS", "dac_id": "custtestdac"}' -p testreguser1)
          expect(result.stderr).to include('Error 3050003')
        end
      end
    end
  end

  describe "state after migrating first batch" do
    context "After migrating 2 rows from the start" do
      it "should migrate 2 rows and leave the original unchanged" do
        result = wrap_command %(cleos push action eosdactokens migrate '{ "skip": 0, "batch": 2}' -p eosdactokens)
        expect(result.stdout).to include('eosdactokens::migrate')
      end
    end

    context "Read the members table" do
      it do
        result = wrap_command %(cleos get table eosdactokens eosdacio members --limit 40)
        expect(JSON.parse(result.stdout)).to eq JSON.parse <<~JSON
        {
          "rows": [{
              "sender": "testuser1",
              "agreedtermsversion": 2
            },{
              "sender": "testuser11",
              "agreedtermsversion": 2
            }
          ],
          "more": false
        }
        JSON
      end
    end
    context "Read the memberterms table" do
      it do
        result = wrap_command %(cleos get table eosdactokens eosdacio memberterms --limit 40)
        expect(JSON.parse(result.stdout)).to eq JSON.parse <<~JSON
          {
            "rows": [{
                "terms": "newtermslocation",
                "hash": "asdfasdfasdfasdfasdfasd",
                "version": 1
              },{
                "terms": "normallegalterms2",
                "hash": "dfghdfghdfghdfghdfg",
                "version": 2
              }
            ],
            "more": false
          }
        JSON
      end
    end
  end

  describe "state after migrating second batch" do
    context "After migrating 2 rows from the after the first 2" do
      it "should migrate 2 rows and leave the original unchanged" do
        result = wrap_command %(cleos push action eosdactokens migrate '{ "skip": 2, "batch": 10}' -p eosdactokens)
        expect(result.stdout).to include('eosdactokens::migrate')
      end
    end
    context "Read the members table" do
      it do
        result = wrap_command %(cleos get table eosdactokens eosdacio members --limit 40)
        expect(JSON.parse(result.stdout)).to eq JSON.parse <<~JSON
        {
          "rows": [{
              "sender": "testuser1",
              "agreedtermsversion": 2
            },{
              "sender": "testuser11",
              "agreedtermsversion": 2
            },{
              "sender": "testuser12",
              "agreedtermsversion": 2
            },{
              "sender": "testuser2",
              "agreedtermsversion": 2
            },{
              "sender": "testuser4",
              "agreedtermsversion": 2
            },{
              "sender": "testuser5",
              "agreedtermsversion": 2
            }
          ],
          "more": false
        }
        JSON
      end
    end
    context "Read the memberterms table" do
      it do
        result = wrap_command %(cleos get table eosdactokens eosdacio memberterms --limit 40)
        expect(JSON.parse(result.stdout)).to eq JSON.parse <<~JSON
          {
            "rows": [{
                "terms": "newtermslocation",
                "hash": "asdfasdfasdfasdfasdfasd",
                "version": 1
              },{
                "terms": "normallegalterms2",
                "hash": "dfghdfghdfghdfghdfg",
                "version": 2
              }
            ],
            "more": false
          }
        JSON
      end
    end
  end
end
