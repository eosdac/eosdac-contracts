require_relative '../../_test_helpers/CommonTestHelpers'

# Configure the initial state for the contracts for elements that are assumed to work from other contracts already.
def configure_contracts_for_tests
  run %(cleos system newaccount --stake-cpu "10.0000 EOS" --stake-net "10.0000 EOS" --transfer --buy-ram-kbytes 2024 eosio dacmsigowner #{CONTRACT_PUBLIC_KEY} #{CONTRACT_PUBLIC_KEY})
  run %(cleos system newaccount --stake-cpu "10.0000 EOS" --stake-net "10.0000 EOS" --transfer --buy-ram-kbytes 2024 eosio dacowner #{CONTRACT_PUBLIC_KEY} #{CONTRACT_PUBLIC_KEY})

  run %(cleos push action dacdirectory regdac '{"owner": "dacmsigowner",  "dac_name": "multisigdac", "dac_symbol": "4,EOSDAC", "title": "Custodian Test DAC", "refs": [[1,"some_ref"]], "accounts": [[2,"daccustodian"], [5,"dacocoiogmbh"], [7,"dacescrow"], [0, "dacowner"],  [4, "eosdactokens"], [1, "eosdacthedac"]] }' -p dacmsigowner)
  # run %(cleos push action dacdirectory regdac '{"owner": "otherowner",  "dac_name": "otherdac", "dac_symbol": "4,OTRDAC", "title": "Other Test DAC", "refs": [[1,"some_ref"]], "accounts": [[2,"daccustodian"], [5,"dacocoiogmbh"], [7,"dacescrow"], [0, "dacowner"],  [4, "eosdactokens"], [1, "eosdacthedac"]], "scopes": [] }' -p otherowner)

  #create users
  seed_dac_account("invaliduser1", dac_id: "dacmultisigs", dac_owner: "dacmsigowner")

  seed_dac_account("tester1", dac_id: "dacmultisigs", dac_owner: "dacmsigowner")

  seed_dac_account("custodian1", dac_id: "dacmultisigs", dac_owner: "dacmsigowner")
  seed_dac_account("custodian2", dac_id: "dacmultisigs", dac_owner: "dacmsigowner")
  seed_dac_account("custodian3", dac_id: "dacmultisigs", dac_owner: "dacmsigowner")
  seed_dac_account("approver1",  dac_id: "dacmultisigs", dac_owner: "dacmsigowner")

  run %(cleos set account permission custodian1 active '{"threshold": 1,"keys": [{"key": "#{CONTRACT_PUBLIC_KEY}","weight": 1}],"accounts": [{"permission":{"actor":"dacmultisigs","permission":"eosio.code"},"weight":1}]}' owner -p custodian1@owner)
  run %(cleos set account permission custodian2 active '{"threshold": 1,"keys": [{"key": "#{CONTRACT_PUBLIC_KEY}","weight": 1}],"accounts": [{"permission":{"actor":"dacmultisigs","permission":"eosio.code"},"weight":1}]}' owner -p custodian2@owner)
  run %(cleos set account permission custodian3 active '{"threshold": 1,"keys": [{"key": "#{CONTRACT_PUBLIC_KEY}","weight": 1}],"accounts": [{"permission":{"actor":"dacmultisigs","permission":"eosio.code"},"weight":1}]}' owner -p custodian3@owner)

  run %(cleos set account permission dacowner active '{"threshold": 1,"keys": [],"accounts": [{"permission":{"actor":"custodian1","permission":"active"},"weight":1},{"permission":{"actor":"custodian2","permission":"active"},"weight":1},{"permission":{"actor":"custodian3","permission":"active"},"weight":1}]}' owner -p dacowner@owner)

end

describe "dacmultisigs" do
  before(:all) do
    reset_chain
    configure_wallet
    seed_system_contracts
    configure_dac_accounts_and_permissions
    install_dac_contracts

    configure_contracts_for_tests
  end

  after(:all) do
    killchain
  end

  describe "proposed" do
    before(:all) do
      # first put proposal in the system msig contract.
      run %(cleos multisig propose myproposal '[{"actor": "custodian1", "permission": "active"}]' '[{"actor": "custodian1", "permission": "active"}]' eosio.token transfer '{ "from": "custodian1", "to": "tester1", "quantity": "1.0000 EOS", "memo": "random memo"}' -p custodian1)
      run %(cleos multisig review custodian1 myproposal)

    end
    context "without invalid auth" do
      it do
        result = wrap_command %(cleos push action dacmultisigs proposed '{ "transactionid": "579159b224ebd9c0a3d36b1c53ae97a2df96025a054b29b62f1534ecfed080bf", "proposer": "custodian1", "proposal_name": "myproposal", "metadata": "random meta", "dac_id": "multisigdac"}' -p invaliduser1)
        expect(result.stderr).to include('Error 3090004')
      end
    end

    context "with valid auth" do
      it do
        result = wrap_command %(cleos push action dacmultisigs proposed '{ "proposer": "custodian1", "proposal_name": "myproposal", "transactionid": "579159b224ebd9c0a3d36b1c53ae97a2df96025a054b29b62f1534ecfed080bf", "metadata": "random meta", "dac_id": "multisigdac"}' -p dacowner -p custodian1)
        expect(result.stdout).to include('dacmultisigs::proposed')
      end
    end

    context "Read the proposals table after successful proposal" do
      it do
        result = wrap_command %(cleos get table dacmultisigs multisigdac proposals)
        json = JSON.parse(result.stdout)
        expect(json["rows"].count).to eq 1

        prop = json["rows"].detect {|v| v["proposalname"] == 'myproposal'}

        expect(prop["transactionid"].length).to be > 50
        expect(string_date_to_UTC(prop["modifieddate"]).day).to eq (utc_today.day)
      end
    end
  end

  describe "approved" do
    context "with invalid auth" do
      it do
        result = wrap_command %(cleos push action dacmultisigs approved '{ "proposer": "custodian1", "proposal_name": "myproposal", "level": {"actor": "custodian1", "permission": "active"}, "approver": "approver1", "dac_id": "multisigdac"}' -p invaliduser1 -p approver1)
        expect(result.stderr).to include('Error 3090004')
      end
    end

    context "with valid auth" do
      it do
        result = wrap_command %(cleos push action dacmultisigs approved '{ "proposer": "custodian1", "proposal_name": "myproposal", "level": {"actor": "custodian1", "permission": "active"}, "approver": "approver1", "dac_id": "multisigdac"}' -p custodian1 -p approver1 -p dacowner)
        expect(result.stdout).to include('dacmultisigs::approved')
      end
    end
  end

  describe "unapproved" do
    context "with invalid auth" do
      it do
        result = wrap_command %(cleos push action dacmultisigs approved '{ "proposer": "custodian1", "proposal_name": "myproposal", "level": {"actor": "custodian1", "permission": "active"}, "approver": "approver1", "dac_id": "multisigdac"}' -p invaliduser1 -p approver1)
        expect(result.stderr).to include('Error 3090004')
      end
    end

    context "with valid auth and previously granted permission" do
      it do
        result = wrap_command %(cleos push action dacmultisigs unapproved '{ "proposer": "custodian1", "proposal_name": "myproposal", "level": {"actor": "custodian1", "permission": "active"}, "unapprover": "approver1", "dac_id": "multisigdac"}' -p custodian1 -p approver1 -p dacowner)
        expect(result.stdout).to include('dacmultisigs::unapproved')
      end
    end
  end

  describe "cancelled" do
    context "with invalid auth" do
      it do
        result = wrap_command %(cleos push action dacmultisigs cancelled '{ "proposer": "custodian1", "proposal_name": "myproposal", "canceler": "invaliduser1", "dac_id": "multisigdac" }' -p dacowner)
        expect(result.stderr).to include('missing authority of invaliduser1')
      end
    end
    context "with valid proposer auth" do
      context "without removing the msig from the system contract" do
        it do
          result = wrap_command %(cleos push action dacmultisigs cancelled '{ "proposer": "custodian1", "proposal_name": "myproposal", "canceler": "custodian2", "dac_id": "multisigdac"}' -p custodian2 -p dacowner)
          expect(result.stderr).to include('ERR::PROPOSAL_EXISTS')
        end
      end
      context "with removing the msig from the system contract" do
        before(:all) do
          # first put proposal in the system msig contract.
          run %(cleos multisig cancel custodian1 myproposal custodian1 -p custodian1)
        end
        it do
          result = wrap_command %(cleos push action dacmultisigs cancelled '{ "proposer": "custodian1", "proposal_name": "myproposal", "canceler": "custodian1", "dac_id": "multisigdac"}' -p custodian1 -p dacowner)
          expect(result.stdout).to include('dacmultisigs::cancelled')
        end
      end
    end

    context "Read the proposals table after successful proposal" do
      it do
        result = wrap_command %(cleos get table dacmultisigs multisigdac proposals)
        expect(JSON.parse(result.stdout)).to eq JSON.parse <<~JSON
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
      run %(cleos multisig propose myproposal2 '[{"actor": "custodian1", "permission": "active"}]' '[{"actor": "custodian1", "permission": "active"}]' eosio.token transfer '{ "from": "custodian1", "to": "tester1", "quantity": "1.0000 EOS", "memo": "random memo"}}' -p custodian1)
      run %(cleos multisig review custodian1 myproposal2)
      run %(cleos push action dacmultisigs proposed '{ "proposer": "custodian1", "proposal_name": "myproposal2", "transactionid": "579159b224ebd9c0a3d36b1c53ae97a2df96025a054b29b62f1534ecfed080bf", "metadata": "random meta", "dac_id": "multisigdac"}' -p dacowner -p custodian1)
    end

    context "Read the proposals table after successful proposal" do
      it do
        result = wrap_command %(cleos get table dacmultisigs multisigdac proposals)
        json = JSON.parse(result.stdout)
        expect(json["rows"].count).to eq 1

        prop = json["rows"].detect {|v| v["proposalname"] == 'myproposal2'}

        expect(prop["transactionid"].length).to be > 50
        expect(string_date_to_UTC(prop["modifieddate"]).day).to eq (utc_today.day)
      end
    end

    context "with invalid auth" do
      it do
        result = wrap_command %(cleos push action dacmultisigs executed  '{ "proposer": "custodian1", "proposal_name": "myproposal2", "executer": "invaliduser1" , "dac_id": "multisigdac"}' -p invaliduser2 -p dacowner)
        expect(result.stderr).to include('Provided keys, permissions, and delays do not satisfy declared authorizations')
      end
    end

    context "with valid proposer auth" do
      before(:all) do
        run %(cleos push action dacmultisigs approved '{ "proposer": "custodian1", "proposal_name": "myproposal2", "approver": "custodian1" , "dac_id": "multisigdac"}' -p custodian1 -p dacowner)
        run %(cleos multisig approve custodian1 myproposal2 '{"actor": "custodian1", "permission": "active"}')
        run %(cleos multisig exec custodian1 myproposal2 custodian1 -p custodian1)
      end
      it do
        result = wrap_command %(cleos push action dacmultisigs executed '{ "proposer": "custodian1", "proposal_name": "myproposal2", "executer": "custodian1", "dac_id": "multisigdac"}' -p custodian1 -p dacowner)
        expect(result.stdout).to include('dacmultisigs::executed')
      end
    end

    context "Read the proposals table after successful proposal" do
      it do
        result = wrap_command %(cleos get table dacmultisigs multisigdac proposals)
        expect(JSON.parse(result.stdout)).to eq JSON.parse <<~JSON
          {
            "rows": [],
            "more": false
          }
        JSON
      end
    end
  end
end

