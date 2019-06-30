require_relative '../../_test_helpers/CommonTestHelpers'

# Configure the initial state for the contracts for elements that are assumed to work from other contracts already.
def configure_contracts_for_tests
  # configure accounts for eosdactokens
  run? %(cleos system newaccount --stake-cpu "10.0000 EOS" --stake-net "10.0000 EOS" --transfer --buy-ram-kbytes 2024 eosio dacowner #{CONTRACT_PUBLIC_KEY} #{CONTRACT_PUBLIC_KEY})
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
    # seed_system_contracts
    configure_dac_accounts_and_permissions
    install_dac_contracts

    configure_contracts_for_tests
  end

  after(:all) do
    killchain
  end

  describe "preconditions" do
    context "Read the votes table" do
      it do
        result = wrap_command %(cleos get table daccustodian daccustodian votes --limit 40)
        expect(JSON.parse(result.stdout)).to eq JSON.parse <<~JSON
          {
            "rows": [{
                "voter": "voter1",
                "proxy": "",
                "candidates": [
                  "allocate1",
                  "allocate2",
                  "allocate3",
                  "allocate4",
                  "allocate5"
                ]
              },{
                "voter": "voter2",
                "proxy": "",
                "candidates": [
                  "allocate11",
                  "allocate21",
                  "allocate31",
                  "allocate41",
                  "allocate51"
                ]
              },{
                "voter": "voter3",
                "proxy": "",
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
    context "Read the custodians table" do
      it do
        result = wrap_command %(cleos get table daccustodian daccustodian custodians --limit 40)
        expect(JSON.parse(result.stdout)).to eq JSON.parse <<~JSON
          {
            "rows": [{
                "cust_name": "allocate1",
                "requestedpay": "11.0000 EOS",
                "total_votes": 30000000
              },{
                "cust_name": "allocate11",
                "requestedpay": "16.0000 EOS",
                "total_votes": 14080000
              },{
                "cust_name": "allocate12",
                "requestedpay": "21.0000 EOS",
                "total_votes": 1100000
              },{
                "cust_name": "allocate2",
                "requestedpay": "12.0000 EOS",
                "total_votes": 30000000
              },{
                "cust_name": "allocate21",
                "requestedpay": "17.0000 EOS",
                "total_votes": 14080000
              },{
                "cust_name": "allocate22",
                "requestedpay": "22.0000 EOS",
                "total_votes": 1100000
              },{
                "cust_name": "allocate3",
                "requestedpay": "13.0000 EOS",
                "total_votes": 30000000
              },{
                "cust_name": "allocate32",
                "requestedpay": "23.0000 EOS",
                "total_votes": 1100000
              },{
                "cust_name": "allocate4",
                "requestedpay": "14.0000 EOS",
                "total_votes": 31100000
              },{
                "cust_name": "allocate41",
                "requestedpay": "19.0000 EOS",
                "total_votes": 14080000
              },{
                "cust_name": "allocate5",
                "requestedpay": "15.0000 EOS",
                "total_votes": 31100000
              },{
                "cust_name": "allocate51",
                "requestedpay": "20.0000 EOS",
                "total_votes": 14080000
              }
            ],
            "more": false
          }
        JSON
      end
    end
    context "Read the candidates table after _create_ vote" do
      it do
        result = wrap_command %(cleos get table daccustodian daccustodian candidates --limit 40)
        json = JSON.parse(result.stdout)
        expect(json["rows"].count).to eq 25

        candidate = json["rows"][4]
        expect(candidate["candidate_name"]).to eq 'allocate21'
        expect(candidate["requestedpay"]).to eq '17.0000 EOS'
        expect(candidate["total_votes"]).to eq 14080000
        expect(candidate["is_active"]).to eq 1
        expect(candidate["custodian_end_time_stamp"]).to eq "2019-06-26T08:42:19"

        candidate = json["rows"][24]
        expect(candidate["candidate_name"]).to eq 'votedcust5'
        expect(candidate["requestedpay"]).to eq '15.0000 EOS'
        expect(candidate["locked_tokens"]).to eq '23.0000 EOSDAC'
        expect(candidate["total_votes"]).to eq 0
        expect(candidate["is_active"]).to eq 1
        expect(candidate["custodian_end_time_stamp"]).to eq "1970-01-01T00:00:00"
      end
    end

    context "Read the config table" do
      it do
        result = wrap_command %(cleos get table daccustodian daccustodian config --limit 40)
        expect(JSON.parse(result.stdout)).to eq JSON.parse <<~JSON
          {
            "rows": [{
                "lockupasset": "10.0000 EOSDAC",
                "maxvotes": 5,
                "numelected": 12,
                "periodlength": 1,
                "authaccount": "dacauthority",
                "tokenholder": "eosdacthedac",
                "serviceprovider": "dacocoiogmbh",
                "should_pay_via_service_provider": 1,
                "initial_vote_quorum_percent": 15,
                "vote_quorum_percent": 4,
                "auth_threshold_high": 3,
                "auth_threshold_mid": 2,
                "auth_threshold_low": 1,
                "lockup_release_time_delay": 10,
                "requested_pay_max": "450.0000 EOS"
              }
            ],
            "more": false
          }

        JSON
      end
    end
    context "Read the state table" do
      it do
        result = wrap_command %(cleos get table daccustodian daccustodian state --limit 40)
        json = JSON.parse(result.stdout)
        expect(json["rows"].count).to eq 1
        state = json["rows"][0]

        expect(state["lastperiodtime"]).to eq "2019-06-26T08:42:09"
        expect(state["total_weight_of_votes"]).to eq 45180000
        expect(state["total_votes_on_candidates"]).to eq 225900000
        expect(state["number_active_candidates"]).to eq 23
        expect(state["met_initial_votes_threshold"]).to eq 1
      end
    end

    describe "updateconfige" do
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
        result = wrap_command %(cleos push action daccustodian migrate '{ "skip": 0, "batch_size": 2}' -p daccustodian)
        expect(result.stdout).to include('daccustodian::migrate')
      end
    end

    context "Read the votes table" do
      it do
        result = wrap_command %(cleos get table daccustodian eosdacio votes --limit 40)
        expect(JSON.parse(result.stdout)).to eq JSON.parse <<~JSON
          {
            "rows": [{
                "voter": "voter1",
                "proxy": "",
                "candidates": [
                  "allocate1",
                  "allocate2",
                  "allocate3",
                  "allocate4",
                  "allocate5"
                ]
              },{
                "voter": "voter2",
                "proxy": "",
                "candidates": [
                  "allocate11",
                  "allocate21",
                  "allocate31",
                  "allocate41",
                  "allocate51"
                ]
              }
            ],
            "more": false
          }
        JSON
      end
    end
    context "Read the custodians table" do
      it do
        result = wrap_command %(cleos get table daccustodian eosdacio custodians --limit 40)
        expect(JSON.parse(result.stdout)).to eq JSON.parse <<~JSON
          {
            "rows": [{
                "cust_name": "allocate1",
                "requestedpay": "11.0000 EOS",
                "total_votes": 30000000
              },{
                "cust_name": "allocate11",
                "requestedpay": "16.0000 EOS",
                "total_votes": 14080000
              }
            ],
            "more": false
          }
        JSON
      end
    end
    context "Read the candidates table after _create_ vote" do
      it do
        result = wrap_command %(cleos get table daccustodian eosdacio candidates --limit 40)
        json = JSON.parse(result.stdout)
        expect(json).to eq JSON.parse <<~JSON
        {
        "rows": [{
            "candidate_name": "allocate1",
            "requestedpay": "11.0000 EOS",
            "locked_tokens": "23.0000 EOSDAC",
            "total_votes": 30000000,
            "is_active": 1,
            "custodian_end_time_stamp": "2019-06-26T08:42:19"
          },{
            "candidate_name": "allocate11",
            "requestedpay": "16.0000 EOS",
            "locked_tokens": "23.0000 EOSDAC",
            "total_votes": 14080000,
            "is_active": 1,
            "custodian_end_time_stamp": "2019-06-26T08:42:19"
          }
        ],
        "more": false
      }
      JSON
      end
    end

    context "Read the old config table" do
      it do
        result = wrap_command %(cleos get table daccustodian eosdacio config --limit 40)
        expect(JSON.parse(result.stdout)).to eq JSON.parse <<~JSON
          {
            "rows": [],
            "more": false
          }

        JSON
      end
    end
    context "Read the new config table" do
      it do
        result = wrap_command %(cleos get table daccustodian eosdacio config2 --limit 40)
        expect(JSON.parse(result.stdout)).to eq JSON.parse <<~JSON
          {
            "rows": [{
                "lockupasset": "10.0000 EOSDAC",
                "maxvotes": 5,
                "numelected": 12,
                "periodlength": 1,
                "should_pay_via_service_provider": 1,
                "initial_vote_quorum_percent": 15,
                "vote_quorum_percent": 4,
                "auth_threshold_high": 3,
                "auth_threshold_mid": 2,
                "auth_threshold_low": 1,
                "lockup_release_time_delay": 10,
                "requested_pay_max": "450.0000 EOS"
              }
            ],
            "more": false
          }

        JSON
      end
    end
    context "Read the state table" do
      it do
        result = wrap_command %(cleos get table daccustodian eosdacio state --limit 40)
        json = JSON.parse(result.stdout)
        expect(json["rows"].count).to eq 1
        state = json["rows"][0]

        expect(state["lastperiodtime"]).to eq "2019-06-26T08:42:09"
        expect(state["total_weight_of_votes"]).to eq 45180000
        expect(state["total_votes_on_candidates"]).to eq 225900000
        expect(state["number_active_candidates"]).to eq 23
        expect(state["met_initial_votes_threshold"]).to eq 1
      end
    end
  end

  describe "state after migrating second batch" do
    context "After migrating 2 rows from the after the first 2" do
      it "should migrate 2 rows and leave the original unchanged" do
        result = wrap_command %(cleos push action daccustodian migrate '{ "skip": 2, "batch_size": 2}' -p daccustodian)
        expect(result.stdout).to include('daccustodian::migrate')
      end
    end

    context "Read the votes table" do
      it do
        result = wrap_command %(cleos get table daccustodian eosdacio votes --limit 40)
        expect(JSON.parse(result.stdout)).to eq JSON.parse <<~JSON
          {
            "rows": [{
                "voter": "voter1",
                "proxy": "",
                "candidates": [
                  "allocate1",
                  "allocate2",
                  "allocate3",
                  "allocate4",
                  "allocate5"
                ]
              },{
                "voter": "voter2",
                "proxy": "",
                "candidates": [
                  "allocate11",
                  "allocate21",
                  "allocate31",
                  "allocate41",
                  "allocate51"
                ]
              },{
                "voter": "voter3",
                "proxy": "",
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
    context "Read the custodians table" do
      it do
        result = wrap_command %(cleos get table daccustodian eosdacio custodians --limit 40)
        expect(JSON.parse(result.stdout)).to eq JSON.parse <<~JSON
          {
            "rows": [{
                "cust_name": "allocate1",
                "requestedpay": "11.0000 EOS",
                "total_votes": 30000000
              },{
                "cust_name": "allocate11",
                "requestedpay": "16.0000 EOS",
                "total_votes": 14080000
              },{
                "cust_name": "allocate12",
                "requestedpay": "21.0000 EOS",
                "total_votes": 1100000
              },{
                "cust_name": "allocate2",
                "requestedpay": "12.0000 EOS",
                "total_votes": 30000000
              }
            ],
            "more": false
          }
        JSON
      end
    end
    context "Read the candidates table after _create_ vote" do
      it do
        result = wrap_command %(cleos get table daccustodian eosdacio candidates --limit 40)
        json = JSON.parse(result.stdout)
        expect(json).to eq JSON.parse <<~JSON
        {
          "rows": [{
              "candidate_name": "allocate1",
              "requestedpay": "11.0000 EOS",
              "locked_tokens": "23.0000 EOSDAC",
              "total_votes": 30000000,
              "is_active": 1,
              "custodian_end_time_stamp": "2019-06-26T08:42:19"
            },{
              "candidate_name": "allocate11",
              "requestedpay": "16.0000 EOS",
              "locked_tokens": "23.0000 EOSDAC",
              "total_votes": 14080000,
              "is_active": 1,
              "custodian_end_time_stamp": "2019-06-26T08:42:19"
            },{
              "candidate_name": "allocate12",
              "requestedpay": "21.0000 EOS",
              "locked_tokens": "23.0000 EOSDAC",
              "total_votes": 1100000,
              "is_active": 1,
              "custodian_end_time_stamp": "2019-06-26T08:42:19"
            },{
              "candidate_name": "allocate2",
              "requestedpay": "12.0000 EOS",
              "locked_tokens": "23.0000 EOSDAC",
              "total_votes": 30000000,
              "is_active": 1,
              "custodian_end_time_stamp": "2019-06-26T08:42:19"
            }
          ],
          "more": false
        }

        JSON
      end
    end

    context "Read the old config table" do
      it do
        result = wrap_command %(cleos get table daccustodian eosdacio config --limit 40)
        expect(JSON.parse(result.stdout)).to eq JSON.parse <<~JSON
          {
            "rows": [],
            "more": false
          }

        JSON
      end
    end
    context "Read the new config table" do
      it do
        result = wrap_command %(cleos get table daccustodian eosdacio config2 --limit 40)
        expect(JSON.parse(result.stdout)).to eq JSON.parse <<~JSON
          {
            "rows": [{
                "lockupasset": "10.0000 EOSDAC",
                "maxvotes": 5,
                "numelected": 12,
                "periodlength": 1,
                "should_pay_via_service_provider": 1,
                "initial_vote_quorum_percent": 15,
                "vote_quorum_percent": 4,
                "auth_threshold_high": 3,
                "auth_threshold_mid": 2,
                "auth_threshold_low": 1,
                "lockup_release_time_delay": 10,
                "requested_pay_max": "450.0000 EOS"
              }
            ],
            "more": false
          }

        JSON
      end
    end
    context "Read the state table" do
      it do
        result = wrap_command %(cleos get table daccustodian eosdacio state --limit 40)
        json = JSON.parse(result.stdout)
        expect(json["rows"].count).to eq 1
        state = json["rows"][0]

        expect(state["lastperiodtime"]).to eq "2019-06-26T08:42:09"
        expect(state["total_weight_of_votes"]).to eq 45180000
        expect(state["total_votes_on_candidates"]).to eq 225900000
        expect(state["number_active_candidates"]).to eq 23
        expect(state["met_initial_votes_threshold"]).to eq 1
      end
    end
  end

end

#
#     context "with invalid auth" do
#       it do
#         result = wrap_command %(cleos push action daccustodian updateconfige '{"newconfig": { "lockupasset": "13.0000 EOSDAC", "maxvotes": 4, "periodlength": 604800 , "numelected": 12, "should_pay_via_service_provider": 1, "auththresh": 3, "initial_vote_quorum_percent": 15, "vote_quorum_percent": 10, "auth_threshold_high": 11, "auth_threshold_mid": 7, "auth_threshold_low": 3, "lockup_release_time_delay": 10, "requested_pay_max": "450.0000 EOS"}, "dac_id": "custtestdac"}' -p testreguser1)
#         expect(result.stderr).to include('Error 3090004')
#       end
#     end
#
#     context "with valid auth" do
#       it do
#         result = wrap_command %(cleos push action daccustodian updateconfige '{"newconfig": { "lockupasset": "10.0000 EOSDAC", "maxvotes": 5, "periodlength": 604800 , "numelected": 12, "should_pay_via_service_provider": 1, "auththresh": 3, "initial_vote_quorum_percent": 15, "vote_quorum_percent": 10, "auth_threshold_high": 11, "auth_threshold_mid": 7, "auth_threshold_low": 3, "lockup_release_time_delay": 10, "requested_pay_max": "450.0000 EOS"}, "dac_id": "custtestdac"}' -p dacowner)
#         expect(result.stdout).to include('daccustodian::updateconfige')
#       end
#     end
#   end
#
#   describe "nominatecane" do
#
#     context "with valid and registered member after transferring insufficient staked tokens" do
#       before(:all) do
#         `cleos push action eosdactokens transfer '{ "from": "testreguser1", "to": "daccustodian", "quantity": "5.0000 EOSDAC","memo":"daccustodian"}' -p testreguser1 -f`
#         # Verify that a transaction with a different token symbol on the same account will still yield insufficient funds.
#         `cleos push action eosdactokens transfer '{ "from": "testreguser1", "to": "daccustodian", "quantity": "4.0000 OTRDAC","memo":"noncaccount"}' -p testreguser1 -f`
#       end
#       it do
#         result = wrap_command %(cleos push action daccustodian nominatecane '{ "cand": "testreguser1", "bio": "any bio", "requestedpay": "11.5000 EOS", "dac_id": "custtestdac"}' -p testreguser1)
#         expect(result.stderr).to include('A registering candidate must transfer sufficient tokens to the contract for staking')
#       end
#     end
#
#     context "with negative requestpay amount" do
#       it do
#         result = wrap_command %(cleos push action daccustodian nominatecane '{ "cand": "testreguser1", "bio": "any bio", "requestedpay": "-11.5000 EOS", "dac_id": "custtestdac"}' -p testreguser1)
#         expect(result.stderr).to include("ERR::UPDATEREQPAY_UNDER_ZERO")
#       end
#     end
#
#     context "with valid and registered member after transferring sufficient staked tokens in multiple transfers" do
#       before(:all) do
#         `cleos push action eosdactokens transfer '{ "from": "testreguser1", "to": "daccustodian", "quantity": "5.0000 EOSDAC","memo":"daccustodian"}' -p testreguser1 -f`
#       end
#       it do
#         result = wrap_command %(cleos push action daccustodian nominatecane '{ "cand": "testreguser1", "bio": "any bio", "requestedpay": "11.5000 EOS", "dac_id": "custtestdac"}' -p testreguser1)
#         expect(result.stdout).to include('daccustodian::nominatecane')
#       end
#     end
#
#     context "with unregistered user" do
#       it do
#         result = wrap_command %(cleos push action daccustodian nominatecane '{ "cand": "testreguser2", "bio": "any bio", "requestedpay": "10.0000 EOS", "dac_id": "custtestdac"}' -p testreguser2)
#         expect(result.stderr).to include("Account is not registered with members")
#       end
#     end
#
#     context "with user with empty agree terms" do
#       it do
#         result = wrap_command %(cleos push action daccustodian nominatecane '{ "cand": "testreguser3", "bio": "any bio", "requestedpay": "10.0000 EOS", "dac_id": "custtestdac"}' -p testreguser3)
#         expect(result.stderr).to include('Error 3050003')
#       end
#     end
#
#     context "with user with old agreed terms" do
#       it do
#         result = wrap_command %(cleos push action daccustodian nominatecane '{ "cand": "testreguser4", "bio": "any bio", "requestedpay": "10.0000 EOS", "dac_id": "custtestdac"}' -p testreguser4)
#         expect(result.stderr).to include('Error 3050003')
#       end
#     end
#
#     context "without first staking" do
#       it do
#         result = wrap_command %(cleos push action daccustodian nominatecane '{ "cand": "testreguser5", "bio": "any bio", "requestedpay": "10.0000 EOS", "dac_id": "custtestdac"}' -p testreguser5)
#         expect(result.stderr).to include("A registering candidate must transfer sufficient tokens to the contract for staking")
#       end
#     end
#
#
#     context "with user is already registered" do
#       it do
#         result = wrap_command %(cleos push action daccustodian nominatecane '{ "cand": "testreguser1", "bio": "any bio", "requestedpay": "10.0000 EOS", "dac_id": "custtestdac"}' -p testreguser1)
#         expect(result.stderr).to include('Error 3050003')
#       end
#     end
#
#     context "Read the candidates table after nominatecane" do
#       it do
#         result = wrap_command %(cleos get table daccustodian custtestdac candidates)
#         expect(JSON.parse(result.stdout)).to eq JSON.parse <<~JSON
#             {
#               "rows": [{
#                 "candidate_name": "testreguser1",
#                 "requestedpay": "11.5000 EOS",
#                 "locked_tokens": "10.0000 EOSDAC",
#                 "total_votes": 0,
#                 "is_active": 1,
#                 "custodian_end_time_stamp": "1970-01-01T00:00:00"
#               }
#             ],
#             "more": false
#           }
#         JSON
#       end
#     end
#
#     context "Read the pendingstake table after nominatecane and it should be empty" do
#       it do
#         result = wrap_command %(cleos get table daccustodian custtestdac pendingstake)
#         expect(JSON.parse(result.stdout)).to eq JSON.parse <<~JSON
#             {
#               "rows": [],
#             "more": false
#           }
#         JSON
#       end
#     end
#   end
#
#   context "To ensure behaviours change after updateconfige" do
#     it "updateconfigs with valid auth" do
#       result = wrap_command %(cleos push action daccustodian updateconfige '{"newconfig": { "lockupasset": "23.0000 EOSDAC", "maxvotes": 5, "periodlength": 604800 , "numelected": 12, "should_pay_via_service_provider": 1, "auththresh": 3, "initial_vote_quorum_percent": 15, "vote_quorum_percent": 10, "auth_threshold_high": 11, "auth_threshold_mid": 7, "auth_threshold_low": 3, "lockup_release_time_delay": 10, "requested_pay_max": "450.0000 EOS"}, "dac_id": "custtestdac"}' -p dacowner)
#       expect(result.stdout).to include('daccustodian::updateconfige')
#     end
#   end
#
#   context "withdrawcane" do
#     before(:all) do
#       seed_dac_account("unreguser1", issue: "100.0000 EOSDAC", memberreg: "New Latest terms", dac_id: "custtestdac", dac_owner: "dacowner")
#       seed_dac_account("unreguser2", issue: "100.0000 EOSDAC", memberreg: "New Latest terms", stake: "23.0000 EOSDAC", requestedpay: "11.5000 EOS", dac_id: "custtestdac", dac_owner: "dacowner")
#     end
#
#     it "with invalid auth" do
#       result = wrap_command %(cleos push action daccustodian withdrawcane '{ "cand": "unreguser3", "dac_id": "custtestdac"}' -p testreguser3)
#       expect(result.stderr).to include('Error 3090004')
#     end
#
#     it "with valid auth but not registered" do
#       result = wrap_command %(cleos push action daccustodian withdrawcane '{ "cand": "unreguser1", "dac_id": "custtestdac"}' -p unreguser1)
#       expect(result.stderr).to include('Error 3050003')
#     end
#
#     context "with valid auth" do
#       it do
#         result = wrap_command %(cleos push action daccustodian withdrawcane '{ "cand": "unreguser2", "dac_id": "custtestdac"}' -p unreguser2)
#         expect(result.stdout).to include('daccustodian::withdrawcane')
#       end
#     end
#   end
#
#   describe "update bio" do
#     before(:all) do
#       seed_dac_account("updatebio1", issue: "100.0000 EOSDAC", memberreg: "New Latest terms", dac_id: "custtestdac", dac_owner: "dacowner")
#       seed_dac_account("updatebio2", issue: "100.0000 EOSDAC", memberreg: "New Latest terms", stake: "23.0000 EOSDAC", requestedpay: "11.5000 EOS", dac_id: "custtestdac", dac_owner: "dacowner")
#     end
#
#     context "with invalid auth" do
#       it do
#         result = wrap_command %(cleos push action daccustodian updatebioe '{ "cand": "updatebio1", "bio": "new bio", "dac_id": "custtestdac"}' -p testreguser3)
#         expect(result.stderr).to include('Error 3090004')
#       end
#     end
#
#     context "with valid auth but not registered" do
#       it do
#         result = wrap_command %(cleos push action daccustodian updatebioe '{ "cand": "updatebio1", "bio": "new bio", "dac_id": "custtestdac"}' -p updatebio1)
#         expect(result.stderr).to include('Error 3050003')
#       end
#     end
#
#     context "with valid auth" do
#       it do
#         result = wrap_command %(cleos push action daccustodian updatebioe '{ "cand": "updatebio2", "bio": "new bio", "dac_id": "custtestdac"}' -p updatebio2)
#         expect(result.stdout).to include('daccustodian::updatebioe')
#       end
#     end
#   end
#
#   describe "updatereqpae" do
#     before(:all) do
#       seed_dac_account("updatepay1", issue: "100.0000 EOSDAC", memberreg: "New Latest terms", dac_id: "custtestdac", dac_owner: "dacowner")
#       seed_dac_account("updatepay2", issue: "100.0000 EOSDAC", memberreg: "New Latest terms", stake: "23.0000 EOSDAC", requestedpay: "21.5000 EOS", dac_id: "custtestdac", dac_owner: "dacowner")
#     end
#
#     context "with valid auth but not registered" do
#       it do
#         result = wrap_command %(cleos push action daccustodian updatereqpae '{ "cand": "updatepay1", "requestedpay": "31.5000 EOS", "dac_id": "custtestdac"}' -p updatepay1)
#         expect(result.stderr).to include('Error 3050003')
#       end
#     end
#
#     context "with invalid auth" do
#       it do
#         result = wrap_command %(cleos push action daccustodian updatereqpae '{ "cand": "updatepay2", "requestedpay": "11.5000 EOS", "dac_id": "custtestdac"}' -p testreguser3)
#         expect(result.stderr).to include('Error 3090004')
#       end
#     end
#
#     context "with negative requestpay amount" do
#       it do
#         result = wrap_command %(cleos push action daccustodian updatereqpae '{ "cand": "updatepay2", "requestedpay": "-450.5000 EOS", "dac_id": "custtestdac"}' -p updatepay2)
#         expect(result.stderr).to include("ERR::UPDATEREQPAY_UNDER_ZERO")
#       end
#     end
#
#     context "with valid auth" do
#       it "exceeding the req pay limit" do
#         result = wrap_command %(cleos push action daccustodian updatereqpae '{ "cand": "updatepay2", "requestedpay": "450.5000 EOS", "dac_id": "custtestdac"}' -p updatepay2)
#         expect(result.stderr).to include('ERR::UPDATEREQPAY_EXCESS_MAX_PAY')
#       end
#       it "equal to the max req pay limit" do
#         result = wrap_command %(cleos push action daccustodian updatereqpae '{ "cand": "updatepay2", "requestedpay": "450.0000 EOS", "dac_id": "custtestdac"}' -p updatepay2)
#         expect(result.stdout).to include('daccustodian::updatereqpae')
#       end
#
#       it "with normal valid value" do
#         result = wrap_command %(cleos push action daccustodian updatereqpae '{ "cand": "updatepay2", "requestedpay": "41.5000 EOS", "dac_id": "custtestdac"}' -p updatepay2)
#         expect(result.stdout).to include('daccustodian::updatereqpae')
#       end
#
#       context "Read the candidates table after change reqpay" do
#         it do
#           result = wrap_command %(cleos get table daccustodian custtestdac candidates)
#           json = JSON.parse(result.stdout)
#           expect(json["rows"].count).to eq 4
#
#           expect(json["rows"][-1]["candidate_name"]).to eq 'updatepay2'
#           expect(json["rows"][-1]["requestedpay"]).to eq '41.5000 EOS'
#           expect(json["rows"][-1]["locked_tokens"]).to eq '23.0000 EOSDAC'
#         end
#       end
#     end
#   end
#
#   describe "votecuste" do
#     before(:all) do
#
#       #create users
#
#       seed_dac_account("votedcust1", issue: "101.0000 EOSDAC", memberreg: "New Latest terms", stake: "23.0000 EOSDAC", requestedpay: "11.0000 EOS", dac_id: "custtestdac", dac_owner: "dacowner")
#       seed_dac_account("votedcust2", issue: "102.0000 EOSDAC", memberreg: "New Latest terms", stake: "23.0000 EOSDAC", requestedpay: "12.0000 EOS", dac_id: "custtestdac", dac_owner: "dacowner")
#       seed_dac_account("votedcust3", issue: "103.0000 EOSDAC", memberreg: "New Latest terms", stake: "23.0000 EOSDAC", requestedpay: "13.0000 EOS", dac_id: "custtestdac", dac_owner: "dacowner")
#       seed_dac_account("votedcust4", issue: "104.0000 EOSDAC", memberreg: "New Latest terms", stake: "23.0000 EOSDAC", requestedpay: "14.0000 EOS", dac_id: "custtestdac", dac_owner: "dacowner")
#       seed_dac_account("votedcust5", issue: "105.0000 EOSDAC", memberreg: "New Latest terms", stake: "23.0000 EOSDAC", requestedpay: "15.0000 EOS", dac_id: "custtestdac", dac_owner: "dacowner")
#       seed_dac_account("votedcust11", issue: "106.0000 EOSDAC", memberreg: "New Latest terms", stake: "23.0000 EOSDAC", requestedpay: "16.0000 EOS", dac_id: "custtestdac", dac_owner: "dacowner")
#       seed_dac_account("voter1", issue: "3000.0000 EOSDAC", memberreg: "New Latest terms", dac_id: "custtestdac", dac_owner: "dacowner")
#       seed_dac_account("voter2", issue: "108.0000 EOSDAC", memberreg: "New Latest terms", dac_id: "custtestdac", dac_owner: "dacowner")
#       seed_dac_account("unregvoter", issue: "109.0000 EOSDAC", dac_owner: "dacowner")
#     end
#
#
#     context "with invalid auth" do
#       it do
#       result = wrap_command %(cleos push action daccustodian votecuste '{ "voter": "voter1", "newvotes": ["votedcust1","votedcust2","votedcust3","votedcust4","votedcust5"], "dac_id": "custtestdac"}' -p testreguser3)
#       expect(result.stderr).to include('Error 3090004')
#       end
#     end
#
#     context "not registered" do
#       it do
#         result = wrap_command %(cleos push action daccustodian votecuste '{ "voter": "unregvoter", "newvotes": ["votedcust1","votedcust2","votedcust3","votedcust4","votedcust5"], "dac_id": "custtestdac"}' -p unregvoter)
#         expect(result.stderr).to include('Error 3050003')
#       end
#     end
#
#     context "exceeded allowed number of votes" do
#       it do
#         result = wrap_command %(cleos push action daccustodian votecuste '{ "voter": "voter1", "newvotes": ["voter1","votedcust2","votedcust3","votedcust4","votedcust5", "votedcust11"], "dac_id": "custtestdac"}' -p voter1)
#         expect(result.stderr).to include('Error 3050003')
#       end
#     end
#
#     context "Voted for the same candidate multiple times" do
#       it do
#         result = wrap_command %(cleos push action daccustodian votecuste '{ "voter": "voter1", "newvotes": ["votedcust2","votedcust3","votedcust2","votedcust5", "votedcust11"], "dac_id": "custtestdac"}' -p voter1)
#         expect(result.stderr).to include('Added duplicate votes for the same candidate')
#       end
#     end
#
#     context "Voted for an inactive candidate" do
#       it do
#         result = wrap_command %(cleos push action daccustodian votecuste '{ "voter": "voter1", "newvotes": ["votedcust1","unreguser2","votedcust2","votedcust5", "votedcust11"], "dac_id": "custtestdac"}' -p voter1)
#         expect(result.stderr).to include('Attempting to vote for an inactive candidate.')
#       end
#     end
#
#     context "Voted for an candidate not in the list of candidates" do
#       it do
#         result = wrap_command %(cleos push action daccustodian votecuste '{ "voter": "voter1", "newvotes": ["votedcust1","testreguser5","votedcust2","votedcust5", "votedcust11"], "dac_id": "custtestdac"}' -p voter1)
#         expect(result.stderr).to include('ERR::VOTECUST_CANDIDATE_NOT_FOUND::')
#       end
#     end
#
#     context "with valid auth create new vote" do
#       it do
#         result = wrap_command %(cleos push action daccustodian votecuste '{ "voter": "voter1", "newvotes": ["votedcust1","votedcust2","votedcust3"], "dac_id": "custtestdac"}' -p voter1)
#         expect(result.stdout).to include('daccustodian::votecuste')
#       end
#     end
#
#     context "Read the votes table after _create_ vote" do
#       before(:all) do
#         `cleos push action daccustodian votecuste '{ "voter": "voter2", "newvotes": ["votedcust1","votedcust2","votedcust3"], "dac_id": "custtestdac"}' -p voter2`
#       end
#       it do
#         result = wrap_command %(cleos get table daccustodian custtestdac votes)
#         expect(JSON.parse(result.stdout)).to eq JSON.parse <<~JSON
#             {
#               "rows": [{
#                 "voter": "voter1",
#                 "proxy": "",
#                 "candidates": [
#                   "votedcust1",
#                   "votedcust2",
#                   "votedcust3"
#                 ]
#               }, {
#                 "voter": "voter2",
#                 "proxy": "",
#                 "candidates": [
#                   "votedcust1",
#                   "votedcust2",
#                   "votedcust3"
#                 ]
#               }
#             ],
#             "more": false
#           }
#         JSON
#       end
#     end
#
#     context "Read the state table after placed votes" do
#       before(:all) do
#         # `cleos push action daccustodian votecuste '{ "voter": "voter2", "newvotes": ["votedcust1","votedcust2","votedcust3"], "dac_id": "custtestdac"}' -p voter2`
#       end
#       it do
#         result = wrap_command %(cleos get table daccustodian custtestdac state)
#         expect(JSON.parse(result.stdout)).to eq JSON.parse <<~JSON
#             {
#               "rows": [
#               {
#                 "lastperiodtime": "1970-01-01T00:00:00",
#                 "total_weight_of_votes": 31080000,
#                 "total_votes_on_candidates": 93240000,
#                 "number_active_candidates": 9,
#                 "met_initial_votes_threshold": 0
#               }
#             ],
#             "more": false
#           }
#         JSON
#       end
#     end
#
#     context "with valid auth to clear a vote" do
#       it do
#         result = wrap_command %(cleos push action daccustodian votecuste '{ "voter": "voter2", "newvotes": [], "dac_id": "custtestdac"}' -p voter2)
#         expect(result.stdout).to include('daccustodian::votecuste')
#       end
#     end
#
#     context "Read the votes table after clearing a vote" do
#
#       it do
#         result = wrap_command %(cleos get table daccustodian custtestdac votes)
#         expect(JSON.parse(result.stdout)).to eq JSON.parse <<~JSON
#             {
#               "rows": [{
#                 "voter": "voter1",
#                 "proxy": "",
#                 "candidates": [
#                   "votedcust1",
#                   "votedcust2",
#                   "votedcust3"
#                 ]
#               }
#             ],
#             "more": false
#           }
#         JSON
#       end
#     end
#
#     context "Read the candidates table after _create_ vote" do
#       it do
#         result = wrap_command %(cleos get table daccustodian custtestdac candidates)
#         json = JSON.parse(result.stdout)
#         expect(json["rows"].count).to eq 10
#
#         candidate = json["rows"][4]
#
#         expect(candidate["candidate_name"]).to eq 'votedcust1'
#         expect(candidate["requestedpay"]).to eq '11.0000 EOS'
#         expect(candidate["total_votes"]).to eq 30000000
#         expect(candidate["is_active"]).to eq 1
#         expect(candidate["custodian_end_time_stamp"]).to eq "1970-01-01T00:00:00"
#
#         candidate = json["rows"][6]
#
#         expect(candidate["candidate_name"]).to eq 'votedcust2'
#         expect(candidate["requestedpay"]).to eq '12.0000 EOS'
#         expect(candidate["total_votes"]).to eq 30000000
#         expect(candidate["is_active"]).to eq 1
#         expect(candidate["custodian_end_time_stamp"]).to eq "1970-01-01T00:00:00"
#
#         candidate = json["rows"][7]
#
#         expect(candidate["candidate_name"]).to eq 'votedcust3'
#         expect(candidate["requestedpay"]).to eq '13.0000 EOS'
#         expect(candidate["total_votes"]).to eq 30000000
#         expect(candidate["is_active"]).to eq 1
#         expect(candidate["custodian_end_time_stamp"]).to eq "1970-01-01T00:00:00"
#
#         candidate = json["rows"][8]
#
#         expect(candidate["candidate_name"]).to eq 'votedcust4'
#         expect(candidate["requestedpay"]).to eq '14.0000 EOS'
#         expect(candidate["total_votes"]).to eq 0
#         expect(candidate["is_active"]).to eq 1
#         expect(candidate["custodian_end_time_stamp"]).to eq "1970-01-01T00:00:00"
#       end
#     end
#
#     context "with valid auth change existing vote" do
#       it do
#       result = wrap_command %(cleos push action daccustodian votecuste '{ "voter": "voter1", "newvotes": ["votedcust1","votedcust2","votedcust4"], "dac_id": "custtestdac"}' -p voter1)
#       expect(result.stdout).to include('daccustodian::votecuste')
#       end
#     end
#
#     context "Read the votes table after _change_ vote" do
#       it do
#         result = wrap_command %(cleos get table daccustodian custtestdac votes)
#         expect(JSON.parse(result.stdout)).to eq JSON.parse <<~JSON
#             {
#               "rows": [{
#                 "voter": "voter1",
#                 "proxy": "",
#                 "candidates": [
#                   "votedcust1",
#                   "votedcust2",
#                   "votedcust4"
#                 ]
#               }
#             ],
#             "more": false
#           }
#         JSON
#       end
#     end
#
#     context "Read the candidates table after _change_ vote" do
#       it do
#         result = wrap_command %(cleos get table daccustodian custtestdac candidates)
#
#         json = JSON.parse(result.stdout)
#         expect(json["rows"].count).to eq 10
#
#         candidate = json["rows"][4]
#
#         expect(candidate["candidate_name"]).to eq 'votedcust1'
#         expect(candidate["requestedpay"]).to eq '11.0000 EOS'
#         expect(candidate["total_votes"]).to eq 30000000
#         expect(candidate["is_active"]).to eq 1
#         expect(candidate["custodian_end_time_stamp"]).to eq "1970-01-01T00:00:00"
#
#         candidate = json["rows"][6]
#
#         expect(candidate["candidate_name"]).to eq 'votedcust2'
#         expect(candidate["requestedpay"]).to eq '12.0000 EOS'
#         expect(candidate["total_votes"]).to eq 30000000
#         expect(candidate["is_active"]).to eq 1
#         expect(candidate["custodian_end_time_stamp"]).to eq "1970-01-01T00:00:00"
#
#         candidate = json["rows"][7]
#
#         expect(candidate["candidate_name"]).to eq 'votedcust3'
#         expect(candidate["requestedpay"]).to eq '13.0000 EOS'
#         expect(candidate["total_votes"]).to eq 0
#         expect(candidate["is_active"]).to eq 1
#         expect(candidate["custodian_end_time_stamp"]).to eq "1970-01-01T00:00:00"
#
#         candidate = json["rows"][8]
#
#         expect(candidate["candidate_name"]).to eq 'votedcust4'
#         expect(candidate["requestedpay"]).to eq '14.0000 EOS'
#         expect(candidate["total_votes"]).to eq 30000000
#         expect(candidate["is_active"]).to eq 1
#         expect(candidate["custodian_end_time_stamp"]).to eq "1970-01-01T00:00:00"
#       end
#     end
#
#     context "After token transfer vote weight should move to different candidates" do
#       before(:all) do
#         `cleos push action daccustodian votecuste '{ "voter": "voter2", "newvotes": ["votedcust3"], "dac_id": "custtestdac"}' -p voter2`
#       end
#       it do
#         result = wrap_command %(cleos push action eosdactokens transfer '{ "from": "voter1", "to": "voter2", "quantity": "1300.0000 EOSDAC","memo":"random transfer"}' -p voter1)
#         expect(result.stdout).to include('eosdactokens::transfer')
#       end
#     end
#
#     context "Read the candidates table after transfer for voter" do
#       it do
#         result = wrap_command %(cleos get table daccustodian custtestdac candidates)
#
#         json = JSON.parse(result.stdout)
#         expect(json["rows"].count).to eq 10
#
#         candidate = json["rows"][4]
#
#         expect(candidate["candidate_name"]).to eq 'votedcust1'
#         expect(candidate["requestedpay"]).to eq '11.0000 EOS'
#         expect(candidate["total_votes"]).to eq 17000000 # was 3000,0000 now subtract 1300,0000 = 1700,0000
#         expect(candidate["is_active"]).to eq 1
#         expect(candidate["custodian_end_time_stamp"]).to eq "1970-01-01T00:00:00"
#
#         candidate = json["rows"][6]
#
#         expect(candidate["candidate_name"]).to eq 'votedcust2'
#         expect(candidate["requestedpay"]).to eq '12.0000 EOS'
#         expect(candidate["total_votes"]).to eq 17000000 # was 3000,0000 now subtract 1300,0000 = 1700,0000
#         expect(candidate["is_active"]).to eq 1
#         expect(candidate["custodian_end_time_stamp"]).to eq "1970-01-01T00:00:00"
#
#         candidate = json["rows"][7]
#
#         expect(candidate["candidate_name"]).to eq 'votedcust3'
#         expect(candidate["requestedpay"]).to eq '13.0000 EOS'
#         expect(candidate["total_votes"]).to eq 14080000 # initial balance of 108,0000 + 1300,0000 = 1408,0000
#         expect(candidate["is_active"]).to eq 1
#         expect(candidate["custodian_end_time_stamp"]).to eq "1970-01-01T00:00:00"
#
#         candidate = json["rows"][8]
#
#         expect(candidate["candidate_name"]).to eq 'votedcust4'
#         expect(candidate["requestedpay"]).to eq '14.0000 EOS'
#         expect(candidate["total_votes"]).to eq 17000000 # was 3000,0000 now subtract 1300,0000 = 1700,0000
#         expect(candidate["is_active"]).to eq 1
#         expect(candidate["custodian_end_time_stamp"]).to eq "1970-01-01T00:00:00"
#       end
#     end
#
#     context "Before new period has been called the custodians table should be empty" do
#       it do
#         result = wrap_command %(cleos get table daccustodian custtestdac custodians)
#         expect(JSON.parse(result.stdout)).to eq JSON.parse <<~JSON
#             {
#               "rows": [],
#             "more": false
#           }
#         JSON
#       end
#     end
#   end
#
# #
# #
# #
# #  Excluded for now.           vvvvvvvvvvvv
# #
#   # xdescribe "votedproxy" do
#   #   before(:all) do
#   #     # configure accounts for eosdactokens
#   #
#   #     #create users
#   #     `cleos create account eosio votedproxy1 #{TEST_OWNER_PUBLIC_KEY} #{TEST_ACTIVE_PUBLIC_KEY}`
#   #     `cleos create account eosio votedproxy3 #{TEST_OWNER_PUBLIC_KEY} #{TEST_ACTIVE_PUBLIC_KEY}`
#   #
#   #     # Issue tokens to the first accounts in the token contract
#   #     `cleos push action eosdactokens issue '{ "to": "votedproxy1", "quantity": "101.0000 EOSDAC", "memo": "Initial amount."}' -p eosdactokens`
#   #     `cleos push action eosdactokens issue '{ "to": "votedproxy3", "quantity": "101.0000 EOSDAC", "memo": "Initial amount."}' -p eosdactokens`
#   #     `cleos push action eosdactokens issue '{ "to": "unregvoter", "quantity": "109.0000 EOSDAC", "memo": "Initial amount."}' -p eosdactokens`
#   #
#   #     # Add the founders to the memberreg table
#   #     `cleos push action eosdactokens memberreg '{ "sender": "votedproxy1", "agreedterms": "New Latest terms"}' -p votedproxy1`
#   #     `cleos push action eosdactokens memberreg '{ "sender": "votedproxy3", "agreedterms": "New Latest terms"}' -p votedproxy3`
#   #     `cleos push action eosdactokens memberreg '{ "sender": "voter1", "agreedterms": "New Latest terms"}' -p voter1`
#   #     # `cleos push action eosdactokens memberreg '{ "sender": "unregvoter", "agreedterms": "New Latest terms"}' -p unregvoter`
#   #
#   #     # pre-transfer for staking before registering from within the contract.
#   #     `cleos push action eosdactokens transfer '{ "from": "votedproxy1", "to": "daccustodian", "quantity": "23.0000 EOSDAC","memo":"daccustodian"}' -p votedproxy1`
#   #
#   #     `cleos push action daccustodian nominatecane '{ "cand": "votedproxy1", "bio": "any bio", "requestedpay": "10.0000 EOS"}' -p votedproxy1`
#   #     # `cleos push action daccustodian nominatecane '{ "cand": "unregvoter" "requestedpay": "21.5000 EOS"}' -p unregvoter`
#   #   end
#   #
#   #   context "with invalid auth" do
#   #     it do
#   #       result = wrap_command %(cleos push action daccustodian voteproxy '{ "voter": "voter1", "proxy": "votedproxy1"}' -p testreguser3)
#   #       # expect(result.stdout).to include('daccustodian::nominatecane')
#   #       expect(result.stderr).to include('Error 3090004')
#   #     end
#   #   end
#   #
#   #   context "not registered" do
#   #     result = wrap_command %(cleos push action daccustodian voteproxy '{ "voter": "unregvoter", "proxy": "votedproxy1"}' -p unregvoter)
#   #     expect(result.stderr).to include('Error 3050003')
#   #   end
#   #
#   #   context "voting for self" do
#   #     result = wrap_command %(cleos push action daccustodian voteproxy '{ "voter": "voter1", "proxy":"voter1"}' -p voter1)
#   #     expect(result.stderr).to include('Error 3050003')
#   #   end
#   #
#   #   context "with valid auth create new vote" do
#   #     result = wrap_command %(cleos push action daccustodian voteproxy '{ "voter": "voter1", "proxy": "votedproxy1"}' -p voter1)
#   #     expect(result.stdout).to include('daccustodian::voteproxy')
#   #   end
#   #
#   #   context "Read the votes table after _create_ vote" do
#   #     result = wrap_command %(cleos get table daccustodian daccustodian votes)
#   #     it do
#   #       expect(JSON.parse(result.stdout)).to eq JSON.parse <<~JSON
#   #           {
#   #             "rows": [{
#   #               "voter": "voter1",
#   #               "proxy": "votedproxy1",
#   #               "weight": 0,
#   #               "candidates": []
#   #             }
#   #           ],
#   #           "more": false
#   #         }
#   #       JSON
#   #     end
#   #   end
#   #
#   #   context "candidates table after _create_ proxy vote should have empty totalvotes" do
#   #     result = wrap_command %(cleos get table daccustodian daccustodian candidates --limit 20)
#   #     it do
#   #       expect(JSON.parse(result.stdout)).to eq JSON.parse <<~JSON
#   #           {
#   #             "rows": [{
#   #               "candidate_name": "testreguser1",
#   #               "requestedpay": "11.5000 EOS",
#   #               "locked_tokens": "10.0000 EOSDAC",
#   #               "total_votes": 0,
#   #               "is_active": 1,
#   #               "custodian_end_time_stamp": "1970-01-01T00:00:00"
#   #             },{
#   #               "candidate_name": "unreguser2",
#   #               "requestedpay": "11.5000 EOS",
#   #               "locked_tokens": "0.0000 EOSDAC",
#   #               "total_votes": 0,
#   #               "is_active": 0,
#   #               "custodian_end_time_stamp": "1970-01-01T00:00:00"
#   #             },{
#   #               "candidate_name": "updatebio2",
#   #               "bio": "new bio", "dac_id": "custtestdac",
#   #               "requestedpay": "11.5000 EOS",
#   #               "locked_tokens": "23.0000 EOSDAC",
#   #               "total_votes": 0,
#   #               "is_active": 1,
#   #               "custodian_end_time_stamp": "1970-01-01T00:00:00"
#   #             },{
#   #               "candidate_name": "updatepay2",
#   #               "requestedpay": "41.5000 EOS",
#   #               "locked_tokens": "23.0000 EOSDAC",
#   #               "total_votes": 0,
#   #               "is_active": 1,
#   #               "custodian_end_time_stamp": "1970-01-01T00:00:00"
#   #             },{
#   #               "candidate_name": "votedcust1",
#   #               "requestedpay": "11.0000 EOS",
#   #               "locked_tokens": "23.0000 EOSDAC",
#   #               "total_votes": 0,
#   #               "is_active": 1,
#   #               "custodian_end_time_stamp": "1970-01-01T00:00:00"
#   #             },{
#   #               "candidate_name": "votedcust11",
#   #               "requestedpay": "16.0000 EOS",
#   #               "locked_tokens": "23.0000 EOSDAC",
#   #               "total_votes": 0,
#   #               "is_active": 1,
#   #               "custodian_end_time_stamp": "1970-01-01T00:00:00"
#   #             },{
#   #               "candidate_name": "votedcust2",
#   #               "requestedpay": "12.0000 EOS",
#   #               "locked_tokens": "23.0000 EOSDAC",
#   #               "total_votes": 0,
#   #               "is_active": 1,
#   #               "custodian_end_time_stamp": "1970-01-01T00:00:00"
#   #             },{
#   #               "candidate_name": "votedcust3",
#   #               "requestedpay": "13.0000 EOS",
#   #               "locked_tokens": "23.0000 EOSDAC",
#   #               "total_votes": 0,
#   #               "is_active": 1,
#   #               "custodian_end_time_stamp": "1970-01-01T00:00:00"
#   #             },{
#   #               "candidate_name": "votedcust4",
#   #               "requestedpay": "14.0000 EOS",
#   #               "locked_tokens": "23.0000 EOSDAC",
#   #               "total_votes": 0,
#   #               "is_active": 1,
#   #               "custodian_end_time_stamp": "1970-01-01T00:00:00"
#   #             },{
#   #               "candidate_name": "votedcust5",
#   #               "requestedpay": "15.0000 EOS",
#   #               "locked_tokens": "23.0000 EOSDAC",
#   #               "total_votes": 0,
#   #               "is_active": 1,
#   #               "custodian_end_time_stamp": "1970-01-01T00:00:00"
#   #             },{
#   #               "candidate_name": "votedproxy1",
#   #               "requestedpay": "10.0000 EOS",
#   #               "locked_tokens": "23.0000 EOSDAC",
#   #               "total_votes": 0,
#   #               "is_active": 1,
#   #               "custodian_end_time_stamp": "1970-01-01T00:00:00"
#   #             }
#   #           ],
#   #           "more": false
#   #         }
#   #
#   #       JSON
#   #     end
#   #   end
#   #
#   #   context "with valid auth change existing vote" do
#   #     result = wrap_command %(cleos push action daccustodian voteproxy '{ "voter": "voter1", "proxy": "votedproxy3"}' -p voter1)
#   #     expect(result.stdout).to include('daccustodian::voteproxy')
#   #   end
#   #
#   #   context "Read the votes table after _change_ vote" do
#   #     result = wrap_command %(cleos get table daccustodian daccustodian votes)
#   #     it do
#   #       expect(JSON.parse(result.stdout)).to eq JSON.parse <<~JSON
#   #           {
#   #             "rows": [{
#   #               "voter": "voter1",
#   #               "proxy": "votedproxy3",
#   #               "weight": 0,
#   #               "candidates": []
#   #             }
#   #           ],
#   #           "more": false
#   #         }
#   #       JSON
#   #     end
#   #   end
#   #
#   #   context "the candidates table after _change_ to proxy vote total votes should still be 0" do
#   #     result = wrap_command %(cleos get table daccustodian daccustodian candidates --limit 20)
#   #     it do
#   #       expect(JSON.parse(result.stdout)).to eq JSON.parse <<~JSON
#   #           {
#   #             "rows": [{
#   #               "candidate_name": "testreguser1",
#   #               "requestedpay": "11.5000 EOS",
#   #               "locked_tokens": "10.0000 EOSDAC",
#   #               "total_votes": 0,
#   #               "is_active": 1,
#   #               "custodian_end_time_stamp": "1970-01-01T00:00:00"
#   #             },{
#   #               "candidate_name": "unreguser2",
#   #               "requestedpay": "11.5000 EOS",
#   #               "locked_tokens": "0.0000 EOSDAC",
#   #               "total_votes": 0,
#   #               "is_active": 0,
#   #               "custodian_end_time_stamp": "1970-01-01T00:00:00"
#   #             },{
#   #               "candidate_name": "updatebio2",
#   #               "bio": "new bio", "dac_id": "custtestdac",
#   #               "requestedpay": "11.5000 EOS",
#   #               "locked_tokens": "23.0000 EOSDAC",
#   #               "total_votes": 0,
#   #               "is_active": 1,
#   #               "custodian_end_time_stamp": "1970-01-01T00:00:00"
#   #             },{
#   #               "candidate_name": "updatepay2",
#   #               "requestedpay": "41.5000 EOS",
#   #               "locked_tokens": "23.0000 EOSDAC",
#   #               "total_votes": 0,
#   #               "is_active": 1,
#   #               "custodian_end_time_stamp": "1970-01-01T00:00:00"
#   #             },{
#   #               "candidate_name": "votedcust1",
#   #               "requestedpay": "11.0000 EOS",
#   #               "locked_tokens": "23.0000 EOSDAC",
#   #               "total_votes": 0,
#   #               "is_active": 1,
#   #               "custodian_end_time_stamp": "1970-01-01T00:00:00"
#   #             },{
#   #               "candidate_name": "votedcust11",
#   #               "requestedpay": "16.0000 EOS",
#   #               "locked_tokens": "23.0000 EOSDAC",
#   #               "total_votes": 0,
#   #               "is_active": 1,
#   #               "custodian_end_time_stamp": "1970-01-01T00:00:00"
#   #             },{
#   #               "candidate_name": "votedcust2",
#   #               "requestedpay": "12.0000 EOS",
#   #               "locked_tokens": "23.0000 EOSDAC",
#   #               "total_votes": 0,
#   #               "is_active": 1,
#   #               "custodian_end_time_stamp": "1970-01-01T00:00:00"
#   #             },{
#   #               "candidate_name": "votedcust3",
#   #               "requestedpay": "13.0000 EOS",
#   #               "locked_tokens": "23.0000 EOSDAC",
#   #               "total_votes": 0,
#   #               "is_active": 1,
#   #               "custodian_end_time_stamp": "1970-01-01T00:00:00"
#   #             },{
#   #               "candidate_name": "votedcust4",
#   #               "requestedpay": "14.0000 EOS",
#   #               "locked_tokens": "23.0000 EOSDAC",
#   #               "total_votes": 0,
#   #               "is_active": 1,
#   #               "custodian_end_time_stamp": "1970-01-01T00:00:00"
#   #             },{
#   #               "candidate_name": "votedcust5",
#   #               "requestedpay": "15.0000 EOS",
#   #               "locked_tokens": "23.0000 EOSDAC",
#   #               "total_votes": 0,
#   #               "is_active": 1,
#   #               "custodian_end_time_stamp": "1970-01-01T00:00:00"
#   #             },{
#   #               "candidate_name": "votedproxy1",
#   #               "requestedpay": "10.0000 EOS",
#   #               "locked_tokens": "23.0000 EOSDAC",
#   #               "total_votes": 0,
#   #               "is_active": 1,
#   #               "custodian_end_time_stamp": "1970-01-01T00:00:00"
#   #             }
#   #           ],
#   #           "more": false
#   #         }
#   #       JSON
#   #     end
#   #   end
#   #
#   #   context "with valid auth change to existing vote of proxy" do
#   #     before(:all) do
#   #       `cleos push action daccustodian votecuste '{ "voter": "votedproxy3", "newvotes": ["votedcust1","votedcust2","votedcust3"]}' -p votedproxy3`
#   #     end
#   #
#   #     context "the votes table" do
#   #       result = wrap_command %(cleos get table daccustodian daccustodian votes)
#   #       it do
#   #         expect(JSON.parse(result.stdout)).to eq JSON.parse <<~JSON
#   #             {
#   #               "rows": [{
#   #                 "voter": "votedproxy3",
#   #                 "proxy": "",
#   #                 "weight": 0,
#   #                 "candidates": [
#   #                   "votedcust1",
#   #                   "votedcust2",
#   #                   "votedcust3"
#   #                 ]
#   #               },{
#   #                 "voter": "voter1",
#   #                 "proxy": "votedproxy3",
#   #                 "weight": 0,
#   #                 "candidates": []
#   #               }
#   #             ],
#   #             "more": false
#   #           }
#   #         JSON
#   #       end
#   #     end
#   #
#   #     context "the candidates table" do
#   #       result = wrap_command %(cleos get table daccustodian daccustodian candidates --limit 20)
#   #       it do
#   #         expect(JSON.parse(result.stdout)).to eq JSON.parse <<~JSON
#   #             {
#   #               "rows": [{
#   #                 "candidate_name": "testreguser1",
#   #                 "requestedpay": "11.5000 EOS",
#   #                 "locked_tokens": "10.0000 EOSDAC",
#   #                 "total_votes": 0,
#   #               "is_active": 1,
#   #               "custodian_end_time_stamp": "1970-01-01T00:00:00"
#   #               },{
#   #                 "candidate_name": "unreguser2",
#   #                 "requestedpay": "11.5000 EOS",
#   #                 "locked_tokens": "0.0000 EOSDAC",
#   #                 "total_votes": 0,
#   #               "is_active": 0,
#   #               "custodian_end_time_stamp": "1970-01-01T00:00:00"
#   #               },{
#   #                 "candidate_name": "updatebio2",
#   #                 "bio": "new bio",
#   #                 "requestedpay": "11.5000 EOS",
#   #                 "locked_tokens": "23.0000 EOSDAC",
#   #                 "total_votes": 0,
#   #               "is_active": 1,
#   #               "custodian_end_time_stamp": "1970-01-01T00:00:00"
#   #               },{
#   #                 "candidate_name": "updatepay2",
#   #                 "requestedpay": "41.5000 EOS",
#   #                 "locked_tokens": "23.0000 EOSDAC",
#   #                 "total_votes": 0,
#   #               "is_active": 1,
#   #               "custodian_end_time_stamp": "1970-01-01T00:00:00"
#   #               },{
#   #                 "candidate_name": "votedcust1",
#   #                 "requestedpay": "11.0000 EOS",
#   #                 "locked_tokens": "23.0000 EOSDAC",
#   #                 "total_votes": 0,
#   #               "is_active": 1,
#   #               "custodian_end_time_stamp": "1970-01-01T00:00:00"
#   #               },{
#   #                 "candidate_name": "votedcust11",
#   #                 "requestedpay": "16.0000 EOS",
#   #                 "locked_tokens": "23.0000 EOSDAC",
#   #                 "total_votes": 0,
#   #               "is_active": 1,
#   #               "custodian_end_time_stamp": "1970-01-01T00:00:00"
#   #               },{
#   #                 "candidate_name": "votedcust2",
#   #                 "requestedpay": "12.0000 EOS",
#   #                 "locked_tokens": "23.0000 EOSDAC",
#   #                 "total_votes": 0,
#   #               "is_active": 1,
#   #               "custodian_end_time_stamp": "1970-01-01T00:00:00"
#   #               },{
#   #                 "candidate_name": "votedcust3",
#   #                 "requestedpay": "13.0000 EOS",
#   #                 "locked_tokens": "23.0000 EOSDAC",
#   #                 "total_votes": 0,
#   #               "is_active": 1,
#   #               "custodian_end_time_stamp": "1970-01-01T00:00:00"
#   #               },{
#   #                 "candidate_name": "votedcust4",
#   #                 "requestedpay": "14.0000 EOS",
#   #                 "locked_tokens": "23.0000 EOSDAC",
#   #                 "total_votes": 0,
#   #               "is_active": 1,
#   #               "custodian_end_time_stamp": "1970-01-01T00:00:00"
#   #               },{
#   #                 "candidate_name": "votedcust5",
#   #                 "requestedpay": "15.0000 EOS",
#   #                 "locked_tokens": "23.0000 EOSDAC",
#   #                 "total_votes": 0,
#   #               "custodian_end_time_stamp": "1970-01-01T00:00:00"
#   #               },{
#   #                 "candidate_name": "votedproxy1",
#   #                 "requestedpay": "10.0000 EOS",
#   #                 "locked_tokens": "23.0000 EOSDAC",
#   #                 "total_votes": 0,
#   #               "is_active": 1,
#   #               "custodian_end_time_stamp": "1970-01-01T00:00:00"
#   #               }
#   #             ],
#   #             "more": false
#   #           }
#   #
#   #         JSON
#   #       end
#   #     end
#   #   end
#   # end
#
#
# # Excluded ^^^^^^^^^^^^^^^^^^^^^^
#
#   describe "newperiode" do
#     before(:all) do
#       seed_dac_account("voter3", issue: "110.0000 EOSDAC", memberreg: "New Latest terms", dac_id: "custtestdac", dac_owner: "dacowner")
#       seed_dac_account("whale1", issue: "15000.0000 EOSDAC", memberreg: "New Latest terms", dac_id: "custtestdac", dac_owner: "dacowner")
#     end
#
#     context "with insufficient votes to trigger the dac should fail" do
#       before(:all) do
#         `cleos push action daccustodian updateconfige '{"newconfig": { "lockupasset": "10.0000 EOSDAC", "maxvotes": 5, "periodlength": 5, "numelected": 12, "should_pay_via_service_provider": 1, "auththresh": 3, "initial_vote_quorum_percent": 15, "vote_quorum_percent": 10, "auth_threshold_high": 3, "auth_threshold_mid": 2, "auth_threshold_low": 1, "lockup_release_time_delay": 10, "requested_pay_max": "450.0000 EOS"}, "dac_id": "custtestdac"}' -p dacowner`
#       end
#       it do
#         result = wrap_command %(cleos push action daccustodian newperiode '{ "message": "log message", "earlyelect": false, "dac_id": "custtestdac"}' -p daccustodian)
#         expect(result.stderr).to include('Voter engagement is insufficient to activate the DAC.')
#       end
#     end
#
#     describe "allocateCust" do
#       before(:all) do
#         # add cands
#         `cleos push action daccustodian updateconfige '{"newconfig": { "lockupasset": "10.0000 EOSDAC", "maxvotes": 5, "periodlength": 1 , "numelected": 12, "should_pay_via_service_provider": 1, "auththresh": 3, "initial_vote_quorum_percent": 15, "vote_quorum_percent": 10, "auth_threshold_high": 4, "auth_threshold_mid": 4, "auth_threshold_low": 2, "lockup_release_time_delay": 10, "requested_pay_max": "450.0000 EOS"}, "dac_id": "custtestdac"}' -p dacowner`
#       end
#
#       context "given there are not enough candidates to fill the custodians" do
#         it do
#           result = wrap_command %(cleos push action daccustodian newperiode '{ "message": "log message", "earlyelect": false, "dac_id": "custtestdac"}' -p daccustodian)
#           expect(result.stderr).to include('Voter engagement is insufficient to activate the DAC.')
#         end
#       end
#
#       context "given there are enough candidates to fill the custodians but not enough have votes greater than 0" do
#         before(:all) do
#           seed_dac_account("allocate1", issue: "101.0000 EOSDAC", memberreg: "New Latest terms", stake: "23.0000 EOSDAC", requestedpay: "11.0000 EOS", dac_id: "custtestdac", dac_owner: "dacowner")
#           seed_dac_account("allocate2", issue: "101.0000 EOSDAC", memberreg: "New Latest terms", stake: "23.0000 EOSDAC", requestedpay: "12.0000 EOS", dac_id: "custtestdac", dac_owner: "dacowner")
#           seed_dac_account("allocate3", issue: "101.0000 EOSDAC", memberreg: "New Latest terms", stake: "23.0000 EOSDAC", requestedpay: "13.0000 EOS", dac_id: "custtestdac", dac_owner: "dacowner")
#           seed_dac_account("allocate4", issue: "101.0000 EOSDAC", memberreg: "New Latest terms", stake: "23.0000 EOSDAC", requestedpay: "14.0000 EOS", dac_id: "custtestdac", dac_owner: "dacowner")
#           seed_dac_account("allocate5", issue: "101.0000 EOSDAC", memberreg: "New Latest terms", stake: "23.0000 EOSDAC", requestedpay: "15.0000 EOS", dac_id: "custtestdac", dac_owner: "dacowner")
#           seed_dac_account("allocate11", issue: "101.0000 EOSDAC", memberreg: "New Latest terms", stake: "23.0000 EOSDAC", requestedpay: "16.0000 EOS", dac_id: "custtestdac", dac_owner: "dacowner")
#           seed_dac_account("allocate21", issue: "101.0000 EOSDAC", memberreg: "New Latest terms", stake: "23.0000 EOSDAC", requestedpay: "17.0000 EOS", dac_id: "custtestdac", dac_owner: "dacowner")
#           seed_dac_account("allocate31", issue: "101.0000 EOSDAC", memberreg: "New Latest terms", stake: "23.0000 EOSDAC", requestedpay: "18.0000 EOS", dac_id: "custtestdac", dac_owner: "dacowner")
#           seed_dac_account("allocate41", issue: "101.0000 EOSDAC", memberreg: "New Latest terms", stake: "23.0000 EOSDAC", requestedpay: "19.0000 EOS", dac_id: "custtestdac", dac_owner: "dacowner")
#           seed_dac_account("allocate51", issue: "101.0000 EOSDAC", memberreg: "New Latest terms", stake: "23.0000 EOSDAC", requestedpay: "20.0000 EOS", dac_id: "custtestdac", dac_owner: "dacowner")
#           seed_dac_account("allocate12", issue: "101.0000 EOSDAC", memberreg: "New Latest terms", stake: "23.0000 EOSDAC", requestedpay: "21.0000 EOS", dac_id: "custtestdac", dac_owner: "dacowner")
#           seed_dac_account("allocate22", issue: "101.0000 EOSDAC", memberreg: "New Latest terms", stake: "23.0000 EOSDAC", requestedpay: "22.0000 EOS", dac_id: "custtestdac", dac_owner: "dacowner")
#           seed_dac_account("allocate32", issue: "101.0000 EOSDAC", memberreg: "New Latest terms", stake: "23.0000 EOSDAC", requestedpay: "23.0000 EOS", dac_id: "custtestdac", dac_owner: "dacowner")
#           seed_dac_account("allocate42", issue: "101.0000 EOSDAC", memberreg: "New Latest terms", stake: "23.0000 EOSDAC", requestedpay: "24.0000 EOS", dac_id: "custtestdac", dac_owner: "dacowner")
#           seed_dac_account("allocate52", issue: "101.0000 EOSDAC", memberreg: "New Latest terms", stake: "23.0000 EOSDAC", requestedpay: "25.0000 EOS", dac_id: "custtestdac", dac_owner: "dacowner")
#         end
#         it do
#           result = wrap_command %(cleos push action daccustodian newperiode '{ "message": "log message", "earlyelect": false, "dac_id": "custtestdac"}' -p daccustodian)
#           expect(result.stderr).to include('Voter engagement is insufficient to activate the DAC.')
#         end
#       end
#
#       context "given there are enough votes with total_votes over 0" do
#         before(:all) do
#           `cleos push action daccustodian votecuste '{ "voter": "voter1", "newvotes": ["allocate1","allocate2","allocate3","allocate4","allocate5"], "dac_id": "custtestdac"}' -p voter1`
#           `cleos push action daccustodian votecuste '{ "voter": "voter2", "newvotes": ["allocate11","allocate21","allocate31","allocate41","allocate51"], "dac_id": "custtestdac"}' -p voter2`
#           `cleos push action daccustodian votecuste '{ "voter": "voter3", "newvotes": ["allocate12","allocate22","allocate32","allocate4","allocate5"], "dac_id": "custtestdac"}' -p voter3`
#         end
#         context "But not enough engagement to active the DAC" do
#           it do
#             result = wrap_command %(cleos push action daccustodian newperiode '{ "message": "log message", "earlyelect": false, "dac_id": "custtestdac"}' -p daccustodian)
#             expect(result.stderr).to include('Voter engagement is insufficient to activate the DAC.')
#           end
#         end
#
#         context "And enough voter weight to activate the DAC" do
#           before(:all) {`cleos push action daccustodian votecuste '{ "voter": "whale1", "newvotes": ["allocate12","allocate22","allocate32","allocate4","allocate5"], "dac_id": "custtestdac"}' -p whale1`}
#           it do
#             result = wrap_command %(cleos push action daccustodian newperiode '{ "message": "log message", "dac_id": "custtestdac"}' -p dacowner)
#             expect(result.stdout).to include('daccustodian::newperiode')
#           end
#         end
#       end
#
#       context "Read the votes table after adding enough votes for a valid election" do
#         it do
#           result = wrap_command %(cleos get table daccustodian custtestdac votes)
#
#           json = JSON.parse(result.stdout)
#           expect(json["rows"].count).to eq 4
#
#           vote = json["rows"].detect {|v| v["voter"] == 'voter2'}
#
#           expect(vote["candidates"].count).to eq 5
#           expect(vote["candidates"][0]).to eq 'allocate11'
#
#           vote = json["rows"].detect {|v| v["voter"] == 'voter3'}
#
#           expect(vote["candidates"].count).to eq 5
#           expect(vote["candidates"][0]).to eq 'allocate12'
#
#           vote = json["rows"].detect {|v| v["voter"] == 'whale1'}
#           expect(vote["candidates"].count).to eq 5
#           expect(vote["candidates"][0]).to eq 'allocate12'
#         end
#       end
#
#       context "Read the custodians table after adding enough votes for election" do
#         it do
#           result = wrap_command %(cleos get table daccustodian custtestdac custodians --limit 20)
#           json = JSON.parse(result.stdout)
#           expect(json["rows"].count).to eq 12
#
#           custodian = json["rows"].detect {|v| v["cust_name"] == 'allocate11'}
#           expect(custodian["total_votes"]).to eq 14080000
#
#           custodian = json["rows"].detect {|v| v["cust_name"] == 'allocate32'}
#           expect(custodian["total_votes"]).to eq 151100000
#
#           custodian = json["rows"].detect {|v| v["cust_name"] == 'allocate4'}
#           expect(custodian["total_votes"]).to eq 168100000
#
#           custnames = json["rows"].map {|c| c["cust_name"]}
#           expect(custnames).to eq ["allocate1", "allocate11", "allocate12", "allocate2", "allocate21", "allocate22", "allocate3", "allocate31", "allocate32", "allocate4", "allocate41", "allocate5"]
#         end
#       end
#     end
#
#     describe "called too early in the period should fail after recent newperiode call" do
#       before(:all) do
#         `cleos push action daccustodian votecuste '{ "voter": "whale1", "newvotes": ["allocate1","allocate2","allocate3","allocate4","allocate5"], "dac_id": "custtestdac"}' -p whale1`
#       end
#       it do
#         result = wrap_command %(cleos push action daccustodian newperiode '{ "message": "called too early", "earlyelect": false, "dac_id": "custtestdac"}' -p dacowner)
#         expect(result.stderr).to include('New period is being called too soon. Wait until the period has complete')
#       end
#     end
#
#     describe "called after period time has passed" do
#       before(:all) do
#         `cleos push action daccustodian updateconfige '{"newconfig": { "lockupasset": "10.0000 EOSDAC", "maxvotes": 5, "periodlength": 1, "numelected": 12, "should_pay_via_service_provider": 1, "auththresh": 3, "initial_vote_quorum_percent": 15, "vote_quorum_percent": 10, "auth_threshold_high": 3, "auth_threshold_mid": 2, "auth_threshold_low": 1, "lockup_release_time_delay": 10, "requested_pay_max": "450.0000 EOS"}, "dac_id": "custtestdac"}' -p dacowner`
#         sleep 2
#       end
#       it do
#         result = wrap_command %(cleos push action daccustodian newperiode '{ "message": "Good new period call after config change", "earlyelect": false, "dac_id": "custtestdac"}' -p dacowner)
#         expect(result.stdout).to include('daccustodian::newperiode')
#       end
#     end
#
#     context "called after voter engagement has dropped to too low" do
#       before(:all) do
#         # Remove the whale vote to drop backs
#         `cleos push action daccustodian votecuste '{ "voter": "whale1", "newvotes": [], "dac_id": "custtestdac"}' -p whale1`
#         `cleos push action daccustodian updateconfige '{"newconfig": { "lockupasset": "10.0000 EOSDAC", "maxvotes": 5, "periodlength": 1, "numelected": 12, "should_pay_via_service_provider": 1, "auththresh": 3, "initial_vote_quorum_percent": 15, "vote_quorum_percent": 4, "auth_threshold_high": 3, "auth_threshold_mid": 2, "auth_threshold_low": 1, "lockup_release_time_delay": 10, "requested_pay_max": "450.0000 EOS"}, "dac_id": "custtestdac"}' -p dacowner`
#         sleep 2
#       end
#       it do
#         result = wrap_command %(cleos push action daccustodian newperiode '{ "message": "Good new period call after config change", "earlyelect": false, "dac_id": "custtestdac"}' -p dacowner)
#         expect(result.stderr).to include('Voter engagement is insufficient to process a new period')
#       end
#     end
#
#     context "called after voter engagement has risen to above the continuing threshold" do
#       before(:all) do
#         `cleos push action daccustodian updateconfige '{"newconfig": { "lockupasset": "10.0000 EOSDAC", "maxvotes": 5, "periodlength": 1, "numelected": 12, "should_pay_via_service_provider": 1, "auththresh": 3, "initial_vote_quorum_percent": 15, "vote_quorum_percent": 4, "auth_threshold_high": 3, "auth_threshold_mid": 2, "auth_threshold_low": 1, "lockup_release_time_delay": 10, "requested_pay_max": "450.0000 EOS"}, "dac_id": "custtestdac"}' -p dacowner`
#         `cleos push action eosdactokens transfer '{ "from": "whale1", "to": "voter1", "quantity": "1300.0000 EOSDAC","memo":"random transfer"}' -p whale1`
#
#         sleep 2
#       end
#       it do
#         result = wrap_command %(cleos push action daccustodian newperiode '{ "message": "Good new period call after config change", "earlyelect": false, "dac_id": "custtestdac"}' -p dacowner)
#         expect(result.stdout).to include('daccustodian::newperiode')
#       end
#     end
#
#     context "the pending_pay table" do
#       it do
#         result = wrap_command %(cleos get table daccustodian custtestdac pendingpay --limit 50)
#
#         json = JSON.parse(result.stdout)
#         expect(json["rows"].count).to eq 24
#
#         custodian = json["rows"].detect {|v| v["receiver"] == 'allocate5'}
#         expect(custodian["quantity"]).to eq '17.0000 EOS'
#         expect(custodian["memo"]).to eq 'Custodian pay. Thank you.'
#
#         custodian = json["rows"].detect {|v| v["receiver"] == 'allocate3'}
#         expect(custodian["quantity"]).to eq '17.0000 EOS'
#       end
#     end
#
#     context "the votes table" do
#       it do
#         result = wrap_command %(cleos get table daccustodian custtestdac votes)
#
#         json = JSON.parse(result.stdout)
#         expect(json["rows"].count).to eq 3
#
#         vote = json["rows"].detect {|v| v["voter"] == 'voter2'}
#
#         expect(vote["candidates"].count).to eq 5
#         expect(vote["candidates"][0]).to eq 'allocate11'
#
#         vote = json["rows"].detect {|v| v["voter"] == 'voter3'}
#
#         expect(vote["candidates"].count).to eq 5
#         expect(vote["candidates"][0]).to eq 'allocate12'
#
#         vote = json["rows"].detect {|v| v["voter"] == 'voter1'}
#         expect(vote["candidates"].count).to eq 5
#         expect(vote["candidates"][0]).to eq 'allocate1'
#       end
#     end
#
#     context "the candidates table" do
#       it do
#         result = wrap_command %(cleos get table daccustodian custtestdac candidates --limit 40)
#         json = JSON.parse(result.stdout)
#
#         expect(json["rows"].count).to eq 25
#
#         delayedcandidates = json["rows"].select {|v| v["custodian_end_time_stamp"] > "1970-01-01T00:00:00"}
#         expect(delayedcandidates.count).to eq(13)
#
#         # custnames = json["rows"].map { |c| c["candidate_name"] }
#         # puts custnames
#         # expect(custnames).to eq ["allocate1", "allocate11", "allocate12", "allocate2", "allocate21", "allocate22", "allocate3", "allocate31", "allocate32", "allocate4", "allocate41", "allocate5"]
#       end
#     end
#
#     context "the custodians table" do
#       it do
#         result = wrap_command %(cleos get table daccustodian custtestdac custodians --limit 20)
#         json = JSON.parse(result.stdout)
#         expect(json["rows"].count).to eq 12
#
#         custodian = json["rows"].detect {|v| v["cust_name"] == 'allocate11'}
#         expect(custodian["total_votes"]).to eq 14080000
#
#         custodian = json["rows"].detect {|v| v["cust_name"] == 'allocate1'}
#         expect(custodian["total_votes"]).to eq 30000000
#
#         custodian = json["rows"].detect {|v| v["cust_name"] == 'allocate4'}
#         expect(custodian["total_votes"]).to eq 31100000
#
#         custnames = json["rows"].map {|c| c["cust_name"]}
#
#         # allocate32 was dropped and then allocate51 took the spot
#         expect(custnames).to eq ["allocate1", "allocate11", "allocate12", "allocate2", "allocate21", "allocate22", "allocate3", "allocate31", "allocate4", "allocate41", "allocate5", "allocate51"]
#       end
#     end
#   end
#
#   describe "claimpaye" do
#     context "with invalid payId should fail" do
#       it do
#         result = wrap_command %(cleos push action daccustodian claimpaye '{ "payid": 100, "dac_id": "custtestdac"}' -p votedcust4)
#         expect(result.stderr).to include('Invalid pay claim id')
#       end
#     end
#
#     context "claiming for a different acount should fail" do
#       it do
#         result = wrap_command %(cleos push action daccustodian claimpaye '{ "payid": 10, "dac_id": "custtestdac"}' -p votedcust4)
#         expect(result.stderr).to include('missing authority of allocate41')
#       end
#     end
#
#     context "Before claiming pay the balance should be 0" do
#       it do
#         result = wrap_command %(cleos get currency balance eosio.token dacocoiogmbh EOS)
#         expect(result.stdout).to eq('')
#       end
#     end
#
#     context "claiming for the correct account with matching auth should succeed" do
#       it do
#         result = wrap_command %(cleos push action daccustodian claimpaye '{ "payid": 1 , "dac_id": "custtestdac"}' -p allocate11)
#         expect(result.stdout).to include('daccustodian::claimpaye')
#         # exit
#       end
#     end
#
#     context "After claiming for the correct should be added to the claimer" do
#       it do
#         result = wrap_command %(cleos get currency balance eosio.token dacocoiogmbh EOS)
#         expect(result.stdout).not_to include('17.0000 EOS') # eventually this would pass but now it's time delayed I cannot assert
#       end
#     end
#
#     context "After claiming for the correct should be added to the claimer" do
#       before(:each) {sleep 12}
#       it do
#         result = wrap_command %(cleos get currency balance eosio.token dacocoiogmbh EOS)
#         expect(result.stdout).to include('17.0000 EOS') # eventually this would pass but now it's time delayed I cannot assert
#       end
#     end
#   end
#
#   describe "withdrawcane" do
#     context "when the auth is wrong" do
#       it do
#         result = wrap_command %(cleos push action daccustodian withdrawcane '{ "cand": "allocate41", "dac_id": "custtestdac"}' -p allocate4)
#         expect(result.stderr).to include('missing authority of allocate41')
#       end
#     end
#
#     context "when the auth is correct" do
#       it do
#         result = wrap_command %(cleos push action daccustodian withdrawcane '{ "cand": "allocate41", "dac_id": "custtestdac"}' -p allocate41)
#         expect(result.stdout).to include('daccustodian::withdrawcane')
#       end
#     end
#
#     context "the candidates table" do
#       it do
#         result = wrap_command %(cleos get table daccustodian custtestdac candidates --limit 40)
#         json = JSON.parse(result.stdout)
#
#         expect(json["rows"].count).to eq 25
#
#         delayedcandidatescount = json["rows"].count {|v| v["custodian_end_time_stamp"] > "1970-01-01T00:00:00"}
#         expect(delayedcandidatescount).to eq(13)
#
#         inactiveCandidatesCount = json["rows"].count {|v| v["is_active"] == 0}
#         expect(inactiveCandidatesCount).to eq(2)
#
#         inactiveCand = json["rows"].detect {|v| v["candidate_name"] == 'allocate41'}
#         expect(inactiveCand["is_active"]).to eq(0)
#       end
#     end
#   end
#
#   describe "rereg custodian candidate" do
#     context "with valid and registered member after transferring sufficient staked tokens in multiple transfers" do
#       before(:all) do
#         `cleos push action eosdactokens transfer '{ "from": "allocate41", "to": "daccustodian", "quantity": "10.0000 EOSDAC","memo":"daccustodian"}' -p allocate41 -f`
#       end
#       it do
#         result = wrap_command %(cleos push action daccustodian nominatecane '{ "cand": "allocate41" "requestedpay": "11.5000 EOS", "dac_id": "custtestdac"}' -p allocate41)
#         expect(result.stdout).to include('daccustodian::nominatecane')
#       end
#     end
#
#     context "Read the custodians table after unreg custodian and a single vote will be replaced" do
#       it do
#         result = wrap_command %(cleos get table daccustodian custtestdac candidates --limit 40)
#         json = JSON.parse(result.stdout)
#         expect(json["rows"].count).to eq 25
#
#         candidate = json["rows"].detect {|v| v["candidate_name"] == 'allocate41'}
#         expect(candidate["total_votes"]).to eq 14080000
#         expect(candidate["candidate_name"]).to eq 'allocate41'
#         expect(candidate["requestedpay"]).to eq '11.5000 EOS'
#         expect(candidate["locked_tokens"]).to eq "33.0000 EOSDAC"
#         expect(candidate["custodian_end_time_stamp"]).to be > "1970-01-01T00:00:00"
#       end
#     end
#   end
#
#   describe "resigncuste" do
#     context "with invalid auth" do
#       it do
#         result = wrap_command %(cleos push action daccustodian resigncuste '{ "cust": "allocate31", "dac_id": "custtestdac"}' -p allocate3)
#         expect(result.stderr).to include('missing authority of allocate31')
#       end
#     end
#
#     context "with a candidate who is not an elected custodian" do
#       it do
#         result = wrap_command %(cleos push action daccustodian resigncuste '{ "cust": "votedcust3", "dac_id": "custtestdac"}' -p votedcust3)
#         expect(result.stderr).to include('The entered account name is not for a current custodian.')
#       end
#     end
#
#     context "when the auth is correct" do
#       it do
#         result = wrap_command %(cleos push action daccustodian resigncuste '{ "cust": "allocate31", "dac_id": "custtestdac"}' -p allocate31 -p dacowner) # Need Michael's help here for the permission.
#         expect(result.stdout).to include('daccustodian::resigncuste')
#       end
#     end
#
#     context "Read the state" do
#       it do
#         result = wrap_command %(cleos get table daccustodian custtestdac state)
#
#         json = JSON.parse(result.stdout)
#         expect(json["rows"].count).to eq 1
#
#         state = json["rows"][0]
#         expect(state["total_weight_of_votes"]).to eq 45180000
#         expect(state["total_votes_on_candidates"]).to eq 225900000
#         expect(state["number_active_candidates"]).to eq 23
#         expect(state["met_initial_votes_threshold"]).to eq 1
#       end
#     end
#
#     context "the custodians table" do
#       it do
#         result = wrap_command %(cleos get table daccustodian custtestdac custodians --limit 20)
#         json = JSON.parse(result.stdout)
#         expect(json["rows"].count).to eq 12
#
#         custodian = json["rows"].detect {|v| v["cust_name"] == 'allocate11'}
#         expect(custodian["total_votes"]).to eq 14080000
#
#         custodian = json["rows"].detect {|v| v["cust_name"] == 'allocate1'}
#         expect(custodian["total_votes"]).to eq 30000000
#
#         custodian = json["rows"].detect {|v| v["cust_name"] == 'allocate4'}
#         expect(custodian["total_votes"]).to eq 31100000
#
#       end
#     end
#
#     context "Read the candidates table after resign cust" do
#       it do
#         result = wrap_command %(cleos get table daccustodian custtestdac candidates --limit 40)
#         json = JSON.parse(result.stdout)
#         expect(json["rows"].count).to eq 25
#
#         candidate = json["rows"].detect {|v| v["candidate_name"] == 'allocate31'}
#
#         expect(candidate["candidate_name"]).to eq 'allocate31'
#         expect(candidate["requestedpay"]).to eq "18.0000 EOS"
#         expect(candidate["locked_tokens"]).to eq "23.0000 EOSDAC"
#         expect(candidate["custodian_end_time_stamp"]).to be > "1970-01-01T00:00:00"
#         expect(candidate["is_active"]).to eq(0)
#       end
#     end
#   end
#
#   describe "unstakee" do
#     context "for an elected custodian" do
#       it do
#         result = wrap_command %(cleos push action daccustodian unstakee '{ "cand": "allocate41", "dac_id": "custtestdac"}' -p allocate41)
#         expect(result.stderr).to include('ERR::UNSTAKE_CANNOT_UNSTAKE_FROM_ACTIVE_CAND')
#       end
#     end
#
#     context "for a unelected custodian" do
#       context "who has not withdrawn as a candidate" do
#         it do
#           result = wrap_command %(cleos push action daccustodian unstakee '{ "cand": "votedcust2", "dac_id": "custtestdac"}' -p votedcust2)
#           expect(result.stderr).to include('ERR::UNSTAKE_CANNOT_UNSTAKE_FROM_ACTIVE_CAND')
#         end
#       end
#
#       context "who has withdrawn as a candidate" do
#         it do
#           result = wrap_command %(cleos push action daccustodian unstakee '{ "cand": "allocate31", "dac_id": "custtestdac"}' -p allocate31)
#           expect(result.stderr).to include('ERR::UNSTAKE_CANNOT_UNSTAKE_UNDER_TIME_LOCK')
#         end
#       end
#     end
#
#     context "Before unstaking the token should note have been transferred back" do
#       it do
#         result = wrap_command %(cleos get currency balance eosdactokens unreguser2 EOSDAC)
#         expect(result.stdout).to include('77.0000 EOSDAC')
#       end
#     end
#
#     context "for a resigned custodian after time expired" do
#       it do
#         result = wrap_command %(cleos push action daccustodian unstakee '{ "cand": "unreguser2", "dac_id": "custtestdac"}' -p unreguser2)
#         expect(result.stdout).to include('daccustodian::unstakee')
#       end
#     end
#
#     context "After successful unstaking the token should have been transferred back" do
#       it do
#         result = wrap_command %(cleos get currency balance eosdactokens unreguser2 EOSDAC)
#         expect(result.stdout).to include('77.0000 EOSDAC')
#       end
#     end
#
#     context "After successful unstaking the token should have been transferred back" do
#       before(:each) {sleep 12}
#       it do
#         result = wrap_command %(cleos get currency balance eosdactokens unreguser2 EOSDAC)
#         expect(result.stdout).to include('100.0000 EOSDAC')
#       end
#     end
#   end
#
#   describe "firecande" do
#     context "with invalid auth" do
#       it do
#         result = wrap_command %(cleos push action daccustodian firecande '{ "cand": "votedcust4", "lockupStake": true, "dac_id": "custtestdac"}' -p votedcust4)
#         expect(result.stderr).to include('missing authority of dacowner')
#       end
#     end
#
#     xcontext "with valid auth" do # Needs further work to understand how this could be tested.
#       context "without locked up stake" do
#         it do
#           result = wrap_command %(cleos multisig propose fireproposal '[{"actor": "dacauthority", "permission": "med"}]' '[{"actor": "allocate2", "permission": "active"}, {"actor": "allocate3", "permission": "active"}]' daccustodian firecande '{ "cand": "votedcust4", "lockupStake": false, "dac_id": "custtestdac"}' -p dacowner@active -sdj)
#           expect(result.stderr).to include('ERR::UNSTAKE_CANNOT_UNSTAKE_UNDER_TIME_LOCK')
#         end
#       end
#       context "with locked up stake" do
#         it do
#           result = wrap_command %(cleos push action daccustodian firecande '{ "cand": "votedcust5", "lockupStake": true, "dac_id": "custtestdac"}' -p dacowner)
#           expect(result.stderr).to include('ERR::UNSTAKE_CANNOT_UNSTAKE_UNDER_TIME_LOCK')
#         end
#       end
#     end
#
#     context "Read the candidates table after fire candidate" do
#       it do
#         result = wrap_command %(cleos get table daccustodian custtestdac candidates --limit 40)
#         json = JSON.parse(result.stdout)
#         expect(json["rows"].count).to eq 25
#
#         candidate = json["rows"].detect {|v| v["candidate_name"] == 'votedcust4'}
#
#         expect(candidate["candidate_name"]).to eq 'votedcust4'
#         expect(candidate["requestedpay"]).to eq "14.0000 EOS"
#         expect(candidate["locked_tokens"]).to eq "23.0000 EOSDAC"
#         expect(candidate["custodian_end_time_stamp"]).to eq "1970-01-01T00:00:00"
#
#         #expect(candidate["is_active"]).to eq(0) # Since the multisig is not yet working in the tests this will fail.
#
#         candidate = json["rows"].detect {|v| v["candidate_name"] == 'votedcust5'}
#
#         expect(candidate["candidate_name"]).to eq 'votedcust5'
#         expect(candidate["requestedpay"]).to eq "15.0000 EOS"
#         expect(candidate["locked_tokens"]).to eq "23.0000 EOSDAC"
#         # expect(candidate["custodian_end_time_stamp"]).to be > "2018-01-01T00:00:00" # Will fail due to the multisig not being testable at the moment.
#         # expect(candidate["is_active"]).to eq(0) # Will fail due to the multisig not being testable at the moment.
#       end
#     end
#   end
#
#   # xdescribe "fire custodian" do
#   #   context "with invalid auth" do
#   #     result = wrap_command %(cleos push action daccustodian firecust '{ "cust": "allocate1"}' -p allocate31)
#   #     expect(result.stderr).to include('missing authority of dacauthority')
#   #   end
#   #
#   #   context "with valid auth" do
#   #     result = wrap_command %(cleos push action daccustodian firecust '{ "cust": "allocate1"}' -p dacowner)
#   #     expect(result.stderr).to include('Cannot unstakee tokens before they are unlocked from the time delay.')
#   #   end
#   #
#   #   context "Read the candidates table after fire candidate" do
#   #     result = wrap_command %(cleos get table daccustodian daccustodian candidates --limit 40)
#   #     it do
#   #       json = JSON.parse(result.stdout)
#   #       expect(json["rows"].count).to eq 25
#   #
#   #       candidate = json["rows"].detect {|v| v["candidate_name"] == 'allocate1'}
#   #
#   #       expect(candidate["candidate_name"]).to eq 'allocate1'
#   #       expect(candidate["requestedpay"]).to eq "18.0000 EOS"
#   #       expect(candidate["locked_tokens"]).to eq "23.0000 EOSDAC"
#   #       expect(candidate["custodian_end_time_stamp"]).to be eq "1970-01-01T00:00:00"
#   #       expect(candidate["is_active"]).to eq(0)
#   #
#   #       candidate = json["rows"].detect {|v| v["candidate_name"] == 'allocate11'}
#   #
#   #       expect(candidate["candidate_name"]).to eq 'allocate11'
#   #       expect(candidate["requestedpay"]).to eq "18.0000 EOS"
#   #       expect(candidate["locked_tokens"]).to eq "23.0000 EOSDAC"
#   #       expect(candidate["custodian_end_time_stamp"]).to be > "2018-01-01T00:00:00"
#   #       expect(candidate["is_active"]).to eq(0)
#   #     end
#   #   end
#   #
#   #   context "Read the custodians table" do
#   #     result = wrap_command %(cleos get table daccustodian custtestdac custodians --limit 20)
#   #     it do
#   #       json = JSON.parse(result.stdout)
#   #       expect(json["rows"].count).to eq 12
#   #
#   #       custodian = json["rows"].detect {|v| v["cust_name"] == 'allocate11'}
#   #       expect(custodian["total_votes"]).to eq 14080000
#   #
#   #       custodian = json["rows"].detect {|v| v["cust_name"] == 'allocate1'}
#   #       expect(custodian["total_votes"]).to eq 30000000
#   #
#   #       custodian = json["rows"].detect {|v| v["cust_name"] == 'allocate4'}
#   #       expect(custodian["total_votes"]).to eq 31100000
#   #
#   #     end
#   #   end
#   # end
# end
#
