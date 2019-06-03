require_relative '../../_test_helpers/CommonTestHelpers'

def configure_contracts_for_tests

  run %(cleos system newaccount --stake-cpu "10.0000 EOS" --stake-net "10.0000 EOS" --transfer --buy-ram-kbytes 1024 eosio testuser1 #{CONTRACT_PUBLIC_KEY} #{CONTRACT_PUBLIC_KEY})
  run %(cleos system newaccount --stake-cpu "10.0000 EOS" --stake-net "10.0000 EOS" --transfer --buy-ram-kbytes 1024 eosio testuser2 #{CONTRACT_PUBLIC_KEY} #{CONTRACT_PUBLIC_KEY})
  run %(cleos system newaccount --stake-cpu "10.0000 EOS" --stake-net "10.0000 EOS" --transfer --buy-ram-kbytes 1024 eosio testuser3 #{CONTRACT_PUBLIC_KEY} #{CONTRACT_PUBLIC_KEY})
  run %(cleos system newaccount --stake-cpu "10.0000 EOS" --stake-net "10.0000 EOS" --transfer --buy-ram-kbytes 1024 eosio otherdacacc #{CONTRACT_PUBLIC_KEY} #{CONTRACT_PUBLIC_KEY})

  run %(cleos push action dacdirectory regdac '{"owner": "dacdirectory", "dac_name": "dacpropabp", "dac_symbol": "4,ABP", "title": "Dac Title", "refs": [[1,"some_ref"]], "accounts": [[2,"daccustodian"], [5,"dacescrow"], [7,"dacescrow"], [0, "dacauthority"], [4, "eosdactokens"], [1, "eosdacthedac"] ], "scopes": [] }' -p dacdirectory)
  run %(cleos push action dacdirectory regdac '{"owner": "dacdirectory", "dac_name": "eosdac", "dac_symbol": "4,EOSDAC", "title": "EOSDAC BP", "refs": [[1,"some_ref"]], "accounts": [[2,"daccustodian"], [5,"dacescrow"], [7,"dacescrow"], [0, "dacauthority"], [4, "eosdactokens"], [1, "eosdacthedac"] ], "scopes": [] }' -p dacdirectory)
  run %(cleos push action dacdirectory regdac '{"owner": "dacdirectory", "dac_name": "dacpropaby", "dac_symbol": "4,ABY", "title": "Dac Title",     "refs": [[1,"some_ref"]], "accounts": [[2,"daccustodian"], [5,"dacescrow"], [7,"dacescrow"], [0, "dacauthority"], [4, "eosdactokens"], [1, "eosdacthedac"] ], "scopes": [] }' -p dacdirectory)
  run %(cleos push action dacdirectory regdac '{"owner": "otherdacacc",  "dac_name": "otherdac", "dac_symbol": "4,ABZ", "title": "Other Dac Title", "refs": [[1,"some_ref"]], "accounts": [[2,"daccustodian"], [5,"dacescrow"], [7,"dacescrow"], [0, "otherdacacc"],  [4, "eosdactokens"], [1, "eosdacthedac"] ], "scopes": [] }' -p otherdacacc)

  run %(cleos push action daccustodian updateconfig '{"newconfig": { "lockupasset": "10.0000 ABP", "maxvotes": 5, "periodlength": 604800 , "numelected": 12, "authaccount": "dacauthority", "tokenholder": "eosdacthedac",  "serviceprovider": "dacocoiogmbh", "should_pay_via_service_provider": 1, "auththresh": 3, "initial_vote_quorum_percent": 15, "vote_quorum_percent": 10, "auth_threshold_high": 11, "auth_threshold_mid": 7, "auth_threshold_low": 3, "lockup_release_time_delay": 10, "requested_pay_max": "450.0000 EOS"}, "dac_scope": "dacpropabp"}' -p dacauthority)
  run %(cleos push action daccustodian updateconfig '{"newconfig": { "lockupasset": "10.0000 ABP", "maxvotes": 5, "periodlength": 604800 , "numelected": 12, "authaccount": "dacauthority", "tokenholder": "eosdacthedac",  "serviceprovider": "dacocoiogmbh", "should_pay_via_service_provider": 1, "auththresh": 3, "initial_vote_quorum_percent": 15, "vote_quorum_percent": 10, "auth_threshold_high": 11, "auth_threshold_mid": 7, "auth_threshold_low": 3, "lockup_release_time_delay": 10, "requested_pay_max": "450.0000 EOS"}, "dac_scope": "eosdac"}' -p dacauthority)
  run %(cleos push action daccustodian updateconfig '{"newconfig": { "lockupasset": "10.0000 ABY", "maxvotes": 5, "periodlength": 604800 , "numelected": 12, "authaccount": "dacauthority", "tokenholder": "eosdacthedac",  "serviceprovider": "dacocoiogmbh", "should_pay_via_service_provider": 1, "auththresh": 3, "initial_vote_quorum_percent": 15, "vote_quorum_percent": 10, "auth_threshold_high": 11, "auth_threshold_mid": 7, "auth_threshold_low": 3, "lockup_release_time_delay": 10, "requested_pay_max": "450.0000 EOS"}, "dac_scope": "dacpropaby"}' -p dacauthority)
  run %(cleos push action daccustodian updateconfig '{"newconfig": { "lockupasset": "10.0000 ABY", "maxvotes": 5, "periodlength": 604800 , "numelected": 12, "authaccount": "dacauthority", "tokenholder": "eosdacthedac",  "serviceprovider": "dacocoiogmbh", "should_pay_via_service_provider": 1, "auththresh": 3, "initial_vote_quorum_percent": 15, "vote_quorum_percent": 10, "auth_threshold_high": 11, "auth_threshold_mid": 7, "auth_threshold_low": 3, "lockup_release_time_delay": 10, "requested_pay_max": "450.0000 EOS"}, "dac_scope": "otherdac"}' -p otherdacacc)

  run %(cleos set account permission daccustodian active '{"threshold": 1,"keys": [{"key": "#{CONTRACT_PUBLIC_KEY}","weight": 1}],"accounts": [{"permission":{"actor":"eosdactokens","permission":"eosio.code"},"weight":1}]}' owner -p daccustodian@owner)

end

describe "eosdactokens" do
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

  context "Create a new currency" do
    it "without account auth should fail" do
      result = wrap_command %(cleos push action eosdactokens create '{ "issuer": "eosdactokens", "maximum_supply": "10000.0000 ABY", "transfer_locked": false}')
      expect(result.stderr).to include('Error 3040003')
    end

    # it "with mismatching auth should fail" do
    #   result = wrap_command %(cleos push action eosdactokens create '{ "issuer": "eosdactokens", "maximum_supply": "10000.0000 ABT", "transfer_locked": false}' -p eosio)
    #   expect(result.stderr).to include('Error 3090004')
    # end

    it "with matching issuer and account auth should succeed." do
      result = wrap_command %(cleos push action eosdactokens create '{ "issuer": "eosdactokens", "maximum_supply": "10000.0000 ABY", "transfer_locked": false}' -p eosdactokens)
      expect(result.stdout).to include('eosdactokens::create')
    end
  end

  context "Locked Tokens - " do
    context "Create with transfer_locked true" do
      it "create new token should succeed" do
        result = wrap_command %(cleos push action eosdactokens create '{ "issuer": "eosdactokens", "maximum_supply": "10000.0000 ABP", "transfer_locked": true}' -p eosdactokens)
        expect(result.stdout).to include('eosdactokens::create')
      end

      context "Issue tokens with valid auth should succeed" do
        it do
          result = wrap_command %(cleos push action eosdactokens issue '{ "to": "eosdactokens", "quantity": "1000.0000 ABP", "memo": "Initial amount of tokens for you."}' -p eosdactokens)
          expect(result.stdout).to include('eosdactokens::issue')
        end
      end
    end

    context "Transfer with valid issuer auth from locked token should succeed" do
      it do
        result = wrap_command %(cleos push action eosdactokens transfer '{ "from": "eosdactokens", "to": "eosio", "quantity": "500.0000 ABP", "memo": "my first transfer"}' --permission eosdactokens@active)
        expect(result.stdout).to include('500.0000 ABP')
      end
    end


    context "Transfer from locked token with non-issuer auth should fail" do
      it do
        result = wrap_command %(cleos push action eosdactokens transfer '{ "from": "tester3", "to": "eosdactokens", "quantity": "400.0000 ABP", "memo": "my second transfer"}' -p tester3)
        expect(result.stderr).to include('Ensure that you have the related private keys inside your wallet and your wallet is unlocked.')
      end
    end

    context "Unlock locked token with non-issuer auth should fail" do
      it do
        result = wrap_command %(cleos push action eosdactokens unlock '{ "unlock": "10000.0000 ABP"}' -p tester3)
        expect(result.stderr).to include('Ensure that you have the related private keys inside your wallet and your wallet is unlocked')
      end
    end

    context "Transfer from locked token with non-issuer auth should fail after failed unlock attempt" do
      it do
        result = wrap_command %(cleos push action eosdactokens transfer '{ "from": "eosio", "to": "eosdactokens", "quantity": "400.0000 ABP", "memo": "my second transfer"}' -p eosio)
        expect(result.stderr).to include('Error 3090004')
      end
    end

    context "Unlock locked token with issuer auth should succeed" do
      it do
        result = wrap_command %(cleos push action eosdactokens unlock '{ "unlock": "1.0 ABP"}' -p eosdactokens)
        expect(result.stdout).to include('{"unlock":"1.0 ABP"}')
      end
    end

    context "Transfer from unlocked token with non-issuer auth should succeed after successful unlock" do
      it do
        result = wrap_command %(cleos push action eosdactokens transfer '{ "from": "eosio", "to": "eosdactokens", "quantity": "400.0000 ABP", "memo": "my second transfer"}' -p eosio)
        expect(result.stdout).to include('400.0000 ABP')
      end
    end

    context "Read the stats after issuing currency should display supply, supply and issuer" do
      it do
        result = wrap_command %(cleos get currency stats eosdactokens ABP)
        expect(JSON.parse(result.stdout)).to eq JSON.parse <<~JSON
          {
            "ABP": {
              "supply": "1000.0000 ABP",
              "max_supply": "10000.0000 ABP",
              "issuer": "eosdactokens"
            }
          }
        JSON
      end
    end
  end

  context "Issue new currency" do
    it "without valid auth should fail" do
      result = wrap_command %(cleos push action eosdactokens issue '{ "to": "eosdactokens", "quantity": "1000.0000 ABY", "memo": "Initial amount of tokens for you."}')
      expect(result.stderr).to include('Transaction should have at least one required authority')
    end

    it "without owner auth should fail" do
      result = wrap_command %(cleos push action eosdactokens issue '{ "to": "tester1", "quantity": "1000.0000 ABY", "memo": "Initial amount of tokens for you."} -p tester1')
      expect(result.stderr).to include('Transaction should have at least one required authority')
    end

    it "with mismatching auth should fail" do
      result = wrap_command %(cleos push action eosdactokens issue '{ "to": "eosdactokens", "quantity": "1000.0000 ABY", "memo": "Initial amount of tokens for you."}' -p eosio)
      expect(result.stderr).to include('Error 3090004')
    end

    it "with valid auth should succeed" do
      result = wrap_command %(cleos push action eosdactokens issue '{ "to": "eosdactokens", "quantity": "1000.0000 ABY", "memo": "Initial amount of tokens for you."}' -p eosdactokens)
      expect(result.stdout).to include('eosdactokens::issue')
    end

    it "greater than max should fail" do
      result = wrap_command %(cleos push action eosdactokens issue '{ "to": "eosdactokens", "quantity": "11000.0000 ABY", "memo": "Initial amount of tokens for you."}' -p eosdactokens)
      expect(result.stderr).to include('Error 3050003')
    end

    it "for inflation with valid auth should succeed" do
      result = wrap_command %(cleos push action eosdactokens issue '{ "to": "eosdactokens", "quantity": "2000.0000 ABY", "memo": "Initial amount of tokens for you."}' -p eosdactokens)
      expect(result.stdout).to include('eosdactokens::issue')
    end
  end

  context "Read back the stats after issuing currency should display max supply, supply and issuer" do
    it do
      result = wrap_command %(cleos get currency stats eosdactokens ABY)
      expect(JSON.parse(result.stdout)).to eq JSON.parse <<~JSON
        {
          "ABY": {
            "supply": "3000.0000 ABY",
            "max_supply": "10000.0000 ABY",
            "issuer": "eosdactokens"
          }
        }
      JSON
    end
  end

  context "Transfer some tokens" do
    it "without auth should fail" do
      result = wrap_command %(cleos push action eosdactokens transfer '{ "from": "eosdactokens", "to": "eosio", "quantity": "500.0000 ABY", "memo": "my first transfer"}')
      expect(result.stderr).to include('Transaction should have at least one required authority')
    end

    it "with mismatching auth should fail" do
      result = wrap_command %(cleos push action eosdactokens transfer '{ "from": "eosdactokens", "to": "eosio", "quantity": "500.0000 ABY", "memo": "my first transfer"}' -p eosio)
      expect(result.stderr).to include('Error 3090004')
    end

    it "with valid auth should succeed" do
      result = wrap_command %(cleos push action eosdactokens transfer '{ "from": "eosdactokens", "to": "eosio", "quantity": "500.0000 ABY", "memo": "my first transfer"}' --permission eosdactokens@active)
      expect(result.stdout).to include('500.0000 ABY')
    end

    it "with amount greater than balance should fail" do
      result = wrap_command %(cleos push action eosdactokens transfer '{ "from": "eosio", "to": "eosdactokens", "quantity": "50000.0000 ABY", "memo": "my first transfer"}' -p eosio)
      expect(result.stderr).to include('Error 3050003')
    end

    it "Read back the result balance" do
      result = wrap_command %(cleos get currency balance eosdactokens eosdactokens)
      expect(result.stdout).to include('500.0000 ABY')
    end
  end

  describe "Unlock tokens" do
    it "without auth should fail" do
      result = wrap_command %(cleos push action eosdactokens unlock '{"unlock": "9500.0000 ABP"}')
      expect(result.stderr).to include('Error 3040003')
    end

    context "with auth should succeed" do
      before do
        run %(cleos push action eosdactokens create '{ "issuer": "eosdactokens", "maximum_supply": "10000.0000 ABX", "transfer_locked": true}' -p eosdactokens)
      end
      it do
        result = wrap_command %(cleos push action eosdactokens unlock '{"unlock": "9500.0000 ABX"}' -p eosdactokens)
        expect(result.stdout).to include('eosdactokens <= eosdactokens::unlock')
      end
    end
  end

  context "Burn tokens" do
    before(:all) do
      run %(cleos push action eosdactokens create '{ "issuer": "eosdactokens", "maximum_supply": "10000.0000 ABZ", "transfer_locked": true}' -p eosdactokens)
    end
    context "before unlocking token should fail" do
      it do
        result = wrap_command %(cleos push action eosdactokens burn '{"from": "eosdactokens", "quantity": "9500.0000 ABZ"}' -p eosdactokens)
        expect(result.stderr).to include('Error 3050003')
      end
    end

    context "After unlocking token" do
      before(:all) do
        run %(cleos push action eosdactokens unlock '{"unlock": "9500.0000 ABP"}' -p eosdactokens)
      end

      context "more than available supply should fail" do
        before do
          run %(cleos push action eosdactokens transfer '{"from": "eosdactokens", "to": "testuser1", "quantity": "900.0000 ABP", "memo": "anything"}' -p eosdactokens)
        end
        it do
          result = wrap_command %(cleos push action eosdactokens burn '{"from": "testuser1", "quantity": "9600.0000 ABP"}' -p testuser1)
          expect(result.stderr).to include('Error 3050003')
        end
      end

      context "without auth should fail" do
        it do
          result = wrap_command %(cleos push action eosdactokens burn '{ "from": "eosdactokens","quantity": "500.0000 ABP"}')
          expect(result.stderr).to include('Transaction should have at least one required authority')
        end
      end

      context "with wrong auth should fail" do
        it do
          result = wrap_command %(cleos push action eosdactokens burn '{"from": "eosdactokens", "quantity": "500.0000 ABP"}' -p eosio)
          expect(result.stderr).to include('Error 3090004')
        end
      end

      context "with legal amount of tokens should succeed" do
        it do
          result = wrap_command %(cleos push action eosdactokens burn '{"from": "testuser1", "quantity": "90.0000 ABP"}' -p testuser1)
          expect(result.stdout).to include('eosdactokens::burn')
        end
      end
    end
  end

  context "Read back the stats after burning currency should display reduced supply, same max supply and issuer" do
    it do
      result = wrap_command %(cleos get currency stats eosdactokens ABP)
      expect(JSON.parse(result.stdout)).to eq JSON.parse <<~JSON
        {
          "ABP": {
            "supply": "910.0000 ABP",
            "max_supply": "10000.0000 ABP",
            "issuer": "eosdactokens"
          }
        }
      JSON
    end
  end

  context "newmemterms" do
    it "without valid auth" do
      result = wrap_command %(cleos push action eosdactokens newmemtermse '{ "terms": "New Latest terms", "hash": "termshashsdsdsd", "dac_id": "eosdac"}' -p tester1)
      expect(result.stderr).to include('Ensure that you have the related private keys inside your wallet and your wallet is unlocked')
    end

    it "without empty terms" do
      result = wrap_command %(cleos push action eosdactokens newmemtermse '{ "terms": "", "hash": "termshashsdsdsd", "dac_id": "eosdac"}' -p dacauthority)
      expect(result.stderr).to include('Error 3050003')
    end

    it "with long terms" do
      result = wrap_command %(cleos push action eosdactokens newmemtermse '{ "terms": "aasdfasdfasddasdfasdfasdfasddasdfasdfasdfasddasdfasdfasdfasddasdfasdfasdfasddasdfasdfasdfasddasdfasdfasdfasddasdfasdfasdfasddasdfasdfasdfasddasdfasdfasdfasddasdfasdfasdfasddasdfasdfasdfasddasdfasdfasdfasddasdfasdfasdfasddasdfasdfasdfasddasdfasdfasdfasddasdf", "hash": "termshashsdsdsd", "dac_id": "eosdac"}' -p dacauthority)
      expect(result.stderr).to include('Error 3050003')
    end

    it "without empty hash" do
      result = wrap_command %(cleos push action eosdactokens newmemtermse '{ "terms": "normallegalterms", "hash": "", "dac_id": "eosdac"}' -p dacauthority)
      expect(result.stderr).to include('Error 3050003')
    end

    it "with long hash" do
      result = wrap_command %(cleos push action eosdactokens newmemtermse '{ "terms": "normallegalterms", "hash": "asdfasdfasdfasdfasdfasdfasdfasdfl", "dac_id": "eosdac"}' -p dacauthority)
      expect(result.stderr).to include('Error 3050003')
    end

    it "with valid terms and hash" do
      result = wrap_command %(cleos push action eosdactokens newmemtermse '{ "terms": "normallegalterms", "hash": "asdfasdfasdfasdfasdfasd", "dac_id": "eosdac"}' -p dacauthority)
      expect(result.stdout).to include('eosdactokens <= eosdactokens::newmemterms')
    end

    context "for other dac" do
      it "with non matching auth" do
        result = wrap_command %(cleos push action eosdactokens newmemtermse '{ "terms": "otherlegalterms", "hash": "asdfasdfasdfasdfffffasd", "dac_id": "otherdac"}' -p testuser1)
        expect(result.stderr).to include('missing authority of otherdacacc')
      end
      it "with matching auth" do
        result = wrap_command %(cleos push action eosdactokens newmemtermse '{ "terms": "otherlegalterms", "hash": "asdfasdfasdfasdfffffasd", "dac_id": "otherdac"}' -p otherdacacc)
        expect(result.stdout).to include('eosdactokens <= eosdactokens::newmemtermse')
      end
    end
  end
  context "Read back the memberterms for eosdactokens", focus: true do
    it do
      result = wrap_command %(cleos get table eosdactokens eosdac memberterms)
      expect(JSON.parse(result.stdout)).to eq JSON.parse <<~JSON
        {
          "rows": [{
              "terms": "normallegalterms",
              "hash": "asdfasdfasdfasdfasdfasd",
              "version": 1
            }
          ],
          "more": false
        }
      JSON
    end
  end
  context "Read back the memberterms for otherdac", focus: true do
    it do
      result = wrap_command %(cleos get table eosdactokens otherdac memberterms)
      expect(JSON.parse(result.stdout)).to eq JSON.parse <<~JSON
        {
          "rows": [{
              "terms": "otherlegalterms",
              "hash": "asdfasdfasdfasdfffffasd",
              "version": 1
            }
          ],
          "more": false
        }
      JSON
    end
  end

  context "updatetermse" do
    it "without valid auth" do
      result = wrap_command %(cleos push action eosdactokens updatetermse '{ "termsid": 1, "terms": "termshashsdsdsd", "dac_id": "eosdac"}' -p tester1)
      expect(result.stderr).to include('Ensure that you have the related private keys inside your wallet and your wallet is unlocked')
    end

    it "with long terms" do
      result = wrap_command %(cleos push action eosdactokens updatetermse '{ "termsid": 1, "terms": "lkhasdfkjhasdkfjhaksdljfhlkajhdflkhadfkahsdfkjhasdkfjhaskdfjhaskdhfkasjdhfkhasdfkhasdfkjhasdkfjhklasdflkhasdfkjhasdkfjhaksdljfhlkajhdflkhadfkahsdfkjhasdkfjhaskdfjhaskdhfkasjdhfkhasdfkhasdfkjhasdfkjhasdkfjhaksdljfhlkajhdflkhadfkahsdfkjhasdkfjhaskdfjhaskdhfkasjdhfkhasdfkhasdfkjhasdkfjhklasdf", "dac_id": "eosdac"}' -p dacauthority)
      expect(result.stderr).to include('Error 3050003')
    end

    it "with valid terms" do
      result = wrap_command %(cleos push action eosdactokens updatetermse '{ "termsid": 1, "terms": "newtermslocation", "dac_id": "eosdac"}' -p dacauthority)
      expect(result.stdout).to include('eosdactokens <= eosdactokens::updatetermse')
    end

    context "for other dac" do
      it "with non matching auth" do
        result = wrap_command %(cleos push action eosdactokens updatetermse '{ "termsid": 1, "terms": "asdfasdfasdfasdfffffasd", "dac_id": "otherdac"}' -p testuser1)
        expect(result.stderr).to include('missing authority of otherdacacc')
      end
      it "with matching auth" do
        result = wrap_command %(cleos push action eosdactokens updatetermse '{ "termsid": 1, "terms": "otherdacterms", "dac_id": "otherdac"}' -p otherdacacc)
        expect(result.stdout).to include('eosdactokens <= eosdactokens::updatetermse')
      end
    end
  end
  context "Read back the memberterms for eosdactokens", focus: true do
    it do
      result = wrap_command %(cleos get table eosdactokens eosdac memberterms)
      expect(JSON.parse(result.stdout)).to eq JSON.parse <<~JSON
        {
          "rows": [{
              "terms": "newtermslocation",
              "hash": "asdfasdfasdfasdfasdfasd",
              "version": 1
            }
          ],
          "more": false
        }
      JSON
    end
  end
  context "Read back the memberterms for otherdac", focus: true do
    it do
      result = wrap_command %(cleos get table eosdactokens otherdac memberterms)
      expect(JSON.parse(result.stdout)).to eq JSON.parse <<~JSON
        {
          "rows": [{
              "terms": "otherdacterms",
              "hash": "asdfasdfasdfasdfffffasd",
              "version": 1
            }
          ],
          "more": false
        }
      JSON
    end
  end

  describe "Member reg" do
    it "without auth should fail" do
      result = wrap_command %(cleos push action eosdactokens memberrege '{ "sender": "eosio", "agreedterms": "New Latest terms", "dac_id": "eosdac"}')
      expect(result.stderr).to include('Transaction should have at least one required authority')
    end

    it "with mismatching auth should fail" do
      result = wrap_command %(cleos push action eosdactokens memberrege '{ "sender": "eosio", "agreedterms": "New Latest terms", "dac_id": "eosdac"}' -p testuser2)
      expect(result.stderr).to include('Error 3090004')
    end

    it "with valid auth for second account should succeed" do
      result = wrap_command %(cleos push action eosdactokens memberrege '{ "sender": "testuser2", "agreedterms": "asdfasdfasdfasdfasdfasd", "dac_id": "eosdac"}' -p testuser2)
      expect(result.stdout).to include('eosdactokens::memberrege')
    end
    context "for other dac" do
      it "with invalid managing_account should fail" do
        result = wrap_command %(cleos push action eosdactokens memberrege '{ "sender": "eosio", "agreedterms": "New Latest terms", "dac_id": "eosdac"}' -p eosdactokens)
        expect(result.stderr).to include('Error 3090004')
      end

      it "with valid managing account should succeed" do
        result = wrap_command %(cleos push action eosdactokens memberrege '{ "sender": "testuser1", "agreedterms": "asdfasdfasdfasdfffffasd", "dac_id": "otherdac"}' -p testuser1)
        expect(result.stdout).to include('eosdactokens::memberrege')
      end
    end

    context "Read back the result for regmembers in eosdactokens hasagreed should have one account", focus: true do
      it do
        result = wrap_command %(cleos get table eosdactokens eosdac members)
        expect(JSON.parse(result.stdout)).to eq JSON.parse <<~JSON
          {
            "rows": [
              {"sender":"testuser2", "agreedtermsversion":1}
            ],
            "more": false
          }
        JSON
      end
    end
    context "Read back the result for regmembers in eosdactokens hasagreed should have one account", focus: true do
      it do
        result = wrap_command %(cleos get table eosdactokens otherdac members)
        expect(JSON.parse(result.stdout)).to eq JSON.parse <<~JSON
          {
            "rows": [
              {"sender":"testuser1", "agreedtermsversion":1}
            ],
            "more": false
          }
        JSON
      end
    end
  end

  context "Update existing member reg" do
    before(:all) do
      run %(cleos push action eosdactokens newmemtermse '{ "terms": "normallegalterms2", "hash": "dfghdfghdfghdfghdfg", "dac_id": "otherdac"}' -p eosdactokens -p otherdacacc)
    end

    it "without auth should fail" do
      result = wrap_command %(cleos push action eosdactokens memberrege '{ "sender": "tester3", "agreedterms": "subsequenttermsagreedbyuser", "dac_id": "eosdac"}')
      expect(result.stderr).to include('Transaction should have at least one required authority')
    end

    it "with mismatching auth should fail" do
      result = wrap_command %(cleos push action eosdactokens memberrege '{ "sender": "tester3", "agreedterms": "subsequenttermsagreedbyuser", "dac_id": "eosdac"}' -p eosdactokens)
      expect(result.stderr).to include('Error 3090004')
    end

    it "with valid auth" do
      result = wrap_command %(cleos push action eosdactokens memberrege '{ "sender": "testuser3", "agreedterms": "asdfasdfasdfasdfasdfasd", "dac_id": "eosdac"}' -p testuser3)
      expect(result.stdout).to include('eosdactokens::memberrege')
    end
    context "for other dac" do
      it "with invalid managing_account should fail" do
        result = wrap_command %(cleos push action eosdactokens memberrege '{ "sender": "testuser3", "agreedterms": "dfghdfghdfghdfghdfg", "dac_id": "otherdac"}' -p dacauthority)
        expect(result.stderr).to include('Error 3090004')
      end

      it "with valid managing account should succeed" do
        result = wrap_command %(cleos push action eosdactokens memberrege '{ "sender": "testuser1", "agreedterms": "dfghdfghdfghdfghdfg", "dac_id": "otherdac"}' -p testuser1)
        expect(result.stdout).to include('eosdactokens::memberrege')
      end
    end
  end

  context "Read back the result for regmembers on eosdactokens hasagreed should have entry" do
    it do
      result = wrap_command %(cleos get table eosdactokens eosdac members)
      expect(JSON.parse(result.stdout)).to eq JSON.parse <<~JSON
        {
          "rows": [
            {"sender":"testuser2", "agreedtermsversion":1},
            {"sender":"testuser3", "agreedtermsversion":1}
          ],
          "more": false
        }
      JSON
    end
  end
  context "Read back the result for regmembers hasagreed should have entry" do
    it do
      result = wrap_command %(cleos get table eosdactokens otherdac members)
      expect(JSON.parse(result.stdout)).to eq JSON.parse <<~JSON
        {
          "rows": [
            {"sender":"testuser1", "agreedtermsversion":2}  
          ],
          "more": false
        }
      JSON
    end
  end

  describe "Unregister existing member" do
    it "without correct auth" do
      result = wrap_command %(cleos push action eosdactokens memberunrege '{ "sender": "testuser3", "dac_id": "eosdac"}')
      expect(result.stderr).to include('Transaction should have at least one required authority')
    end

    it "with mismatching auth" do
      result = wrap_command %(cleos push action eosdactokens memberunrege '{ "sender": "testuser3", "dac_id": "eosdac"}' -p currency)
      expect(result.stderr).to include('Error 3090003')
    end

    it "with correct auth" do
      result = wrap_command %(cleos push action eosdactokens memberunrege '{ "sender": "testuser3", "dac_id": "eosdac"}' -p testuser3)
      expect(result.stdout).to include('eosdactokens::memberunrege')
    end
    context "for other dac" do
      it "with invalid managing account" do
        result = wrap_command %(cleos push action eosdactokens memberunrege '{ "sender": "testuser1", "dac_id": "invaliddac"}' -p testuser1)
        expect(result.stderr).to include('dac with dac_name not found')
      end
      it "with correct auth" do
        result = wrap_command %(cleos push action eosdactokens memberunrege '{ "sender": "testuser1", "dac_id": "otherdac"}' -p testuser1)
        expect(result.stdout).to include('eosdactokens::memberunrege')
      end
    end
  end

  context "Read back the result for regmembers has agreed should be 0" do
    it do
      result = wrap_command %(cleos get table eosdactokens eosdac members)
      expect(JSON.parse(result.stdout)).to eq JSON.parse <<-JSON
      {
        "rows": [
          {"sender":"testuser2", "agreedtermsversion":1}
      ],
      "more": false
    }
      JSON
    end
  end
  context "Read back the result for regmembers has agreed should be 0" do
    it do
      result = wrap_command %(cleos get table eosdactokens otherdac members)
      expect(JSON.parse(result.stdout)).to eq JSON.parse <<-JSON
      {
        "rows": [],
      "more": false
    }
      JSON
    end
  end
end

