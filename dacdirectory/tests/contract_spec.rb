require_relative '../../_test_helpers/CommonTestHelpers'

def configure_contracts_for_tests
  run %(cleos system newaccount --stake-cpu "10.0000 EOS" --stake-net "10.0000 EOS" --transfer --buy-ram-kbytes 1024 eosio ow #{CONTRACT_PUBLIC_KEY} #{CONTRACT_PUBLIC_KEY})
  run %(cleos system newaccount --stake-cpu "10.0000 EOS" --stake-net "10.0000 EOS" --transfer --buy-ram-kbytes 1024 eosio testaccount1 #{CONTRACT_PUBLIC_KEY} #{CONTRACT_PUBLIC_KEY})
  run %(cleos system newaccount --stake-cpu "10.0000 EOS" --stake-net "10.0000 EOS" --transfer --buy-ram-kbytes 1024 eosio testaccount2 #{CONTRACT_PUBLIC_KEY} #{CONTRACT_PUBLIC_KEY})
end

describe "dacdirectory" do
  before(:all) do
    reset_chain
    configure_wallet
    seed_system_contracts
    configure_dac_accounts_and_permissions
    install_dac_contracts
    configure_contracts_for_tests
  end

  after(:all) do
    # killchain
  end

  describe "regdac" do
    context "Without valid permission" do
      it do
        result = wrap_command %(cleos push action dacdirectory regdac '{"owner": "testaccount1", "dac_name": "mydacname", "dac_symbol": { "contract": "eosdactokens","symbol": "4,MYSYM"}, "title": "Dac Title", "refs": [[1,"some_ref"]], "accounts": [[1,"account1"]], "scopes": []}' -p testaccount2)
        expect(result.stderr).to include('missing authority of testaccount1')
      end
    end
    context "With valid permission" do
      it do
        result = wrap_command %(cleos push action dacdirectory regdac '{"owner": "testaccount1", "dac_name": "mydacname", "dac_symbol": { "contract": "eosdactokens","symbol": "4,MYSYM"}, "title": "Dac Title", "refs": [[1,"some_ref"]], "accounts": [[1,"account1"]], "scopes": []}' -p testaccount1)
        expect(result.stdout).to include('dacdirectory::regdac')
      end
    end
    context "Read the dacs table after regdac" do
      it do
        result = wrap_command %(cleos get table dacdirectory dacdirectory dacs)
        expect(JSON.parse(result.stdout)).to eq JSON.parse <<~JSON
          {
            "rows": [{
                "owner": "testaccount1",
                "dac_name": "mydacname",
                "title": "Dac Title",
                "symbol": { "contract": "eosdactokens","symbol": "4,MYSYM"},
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
                "dac_state": 0
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
      it do
        result = wrap_command %(cleos push action dacdirectory regaccount '{ "dac_name": "mydacname", "account": "testaccount2", "type": 3, "scope": ""}' -p testaccount2)
        expect(result.stderr).to include('missing authority of testaccount1')
      end
    end
    context "With valid permission" do
      it do
        result = wrap_command %(cleos push action dacdirectory regaccount '{ "dac_name": "mydacname", "account": "testaccount2", "type": 1, "scope": "helloworld"}' -p testaccount1)
        expect(result.stdout).to include('dacdirectory::regaccount')
      end
    end
    context "Read the dacs table after regaccount" do
      it do
        result = wrap_command %(cleos get table dacdirectory dacdirectory dacs)
        expect(JSON.parse(result.stdout)).to eq JSON.parse <<~JSON
          {
            "rows": [{
                "owner": "testaccount1",
                "dac_name": "mydacname",
                "title": "Dac Title",
                "symbol": { "contract": "eosdactokens","symbol": "4,MYSYM"},
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
                "dac_state": 0
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
      it do
        result = wrap_command %(cleos push action dacdirectory unregaccount '{ "dac_name": "mydacname", "type": 3}' -p testaccount2)
        expect(result.stderr).to include('missing authority of testaccount1')
      end
    end
    context "With valid permission" do
      it do
        result = wrap_command %(cleos push action dacdirectory unregaccount '{ "dac_name": "mydacname", "type": 3 }' -p testaccount1)
        expect(result.stdout).to include('dacdirectory::unregaccount')
      end
    end
    context "Read the dacs table after unregaccount" do
      it do
        result = wrap_command %(cleos get table dacdirectory dacdirectory dacs)
        expect(JSON.parse(result.stdout)).to eq JSON.parse <<~JSON
          {
            "rows": [{
                "owner": "testaccount1",
                "dac_name": "mydacname",
                "title": "Dac Title",
                "symbol": { "contract": "eosdactokens","symbol": "4,MYSYM"},
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
                "dac_state": 0
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
      it do
        result = wrap_command %(cleos push action dacdirectory setowner '{ "dac_name": "mydacname", "new_owner": "testaccount2"}' -p testaccount2)
        expect(result.stderr).to include('missing authority of testaccount1')
      end
    end
    context "With valid permission" do
      it do
        result = wrap_command %(cleos push action dacdirectory setowner '{ "dac_name": "mydacname", "new_owner": "testaccount2"}' -p testaccount1 -p testaccount2)
        expect(result.stdout).to include('dacdirectory::setowner')
      end
    end
    context "Read the dacs table after regaccount" do
      it do
        result = wrap_command %(cleos get table dacdirectory dacdirectory dacs)
        expect(JSON.parse(result.stdout)).to eq JSON.parse <<~JSON
          {
            "rows": [{
                "owner": "testaccount2",
                "dac_name": "mydacname",
                "title": "Dac Title",
                "symbol": { "contract": "eosdactokens","symbol": "4,MYSYM"},
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
                "dac_state": 0
              }
            ],
            "more": false
          }
        JSON
      end
    end
  end

  describe "read account from contract with id" do
    context "with existing dac id" do
      it do
        result = wrap_command %(cleos push action dacdirtester assertdacid '{ "dac_name": "mydacname","id": 1}' -p testaccount2)
        expect(result.stdout).to include('dacdirtester <= dacdirtester::assertdacid')
      end
      context "without non-existing account id" do
        it do
          result = wrap_command %(cleos push action dacdirtester assertdacid '{ "dac_name": "mydacname","id": 10}' -p testaccount2)
          expect(result.stderr).to include('No account found for the given id.')
        end
      end
    end
    context "without non-existing dac id" do
      it do
        result = wrap_command %(cleos push action dacdirtester assertdacid '{ "dac_name": "nondac","id": 2}' -p testaccount2)
        expect(result.stderr).to include('dac with dac_name not found')
      end
    end
  end

  describe "read account from contract with symbol" do
    context "with exisitng dac symbol" do
      it do
        result = wrap_command %(cleos push action dacdirtester assertdacsym '{ "sym": { "contract": "eosdactokens","symbol": "4,MYSYM"},"id": 1}' -p testaccount2)
        expect(result.stdout).to include('dacdirtester <= dacdirtester::assertdacsym')
      end
    end
    context "with non-existing dac symbol" do
      it do
        result = wrap_command %(cleos push action dacdirtester assertdacsym '{ "sym": { "contract": "eosdactokens","symbol": "4,OTHR"},"id": 2}' -p testaccount2)
        expect(result.stderr).to include('dac not found for the given symbol')
      end
    end
  end

  describe "unregdac" do
    context "Without valid permission" do
      it do
        result = wrap_command %(cleos push action dacdirectory unregdac '{ "dac_name": "mydacname"}' -p testaccount1)
        expect(result.stderr).to include('missing authority of testaccount2')
      end
    end
    context "With valid permission" do
      it do
        result = wrap_command %(cleos push action dacdirectory unregdac '{ "dac_name": "mydacname"}' -p testaccount2)
        expect(result.stdout).to include('dacdirectory::unregdac')
      end
    end
    context "Read the dacs table after regaccount" do
      it do
        result = wrap_command %(cleos get table dacdirectory dacdirectory dacs)
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



