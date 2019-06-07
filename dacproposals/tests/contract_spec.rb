require_relative '../../_test_helpers/CommonTestHelpers'

# Configure the initial state for the contracts for elements that are assumed to work from other   contracts already.
def configure_contracts
  # configure accounts for eosdactokens

  run %(cleos push action eosdactokens create '{ "issuer": "dacdirectory", "maximum_supply": "100000.0000 EOSDAC", "transfer_locked": false}' -p dacdirectory)

  run %(cleos push action dacdirectory regdac '{"owner": "dacdirectory", "dac_name": "dacproposals", "dac_symbol": "4,MYSYM", "title": "Dac Title", "refs": [], "accounts": [[2,"daccustmock"], [5,""], [7,"dacescrow"], [0, "dacauthority"], [4, "eosdactokens"], [1, "eosdacthedac"] ], "scopes": []}' -p dacdirectory)
  run %(cleos push action dacdirectory regdac '{"owner": "dacdirectory", "dac_name": "mydacname2",   "dac_symbol": "4,EOSDAC", "title": "Dac Title", "refs": [], "accounts": [[1,"account1"]], "scopes": []}' -p dacdirectory)

  run %(cleos push action eosdactokens issue '{ "to": "eosdactokens", "quantity": "78337.0000 EOSDAC", "memo": "Initial amount of tokens for you."}' -p dacdirectory)
  run %(cleos push action eosio.token issue '{ "to": "eosdacthedac", "quantity": "100000.0000 EOS", "memo": "Initial EOS amount."}' -p eosio)

  # Ensure terms are registered in the token contract
  run %(cleos push action eosdactokens newmemtermse '{ "terms": "normallegalterms", "hash": "New Latest terms",  "dac_id": "dacproposals"}' -p dacauthority)

  #create users
  seed_dac_account("proposeracc1", issue: "100.0000 EOSDAC", memberreg: "New Latest terms", dac_scope: "dacproposals", dac_owner: "dacdirectory")
  seed_dac_account("proposeracc2", issue: "100.0000 EOSDAC", memberreg: "New Latest terms", dac_scope: "dacproposals", dac_owner: "dacdirectory")
  seed_dac_account("proposeracc3", issue: "100.0000 EOSDAC", memberreg: "New Latest terms", dac_scope: "dacproposals", dac_owner: "dacdirectory")
  seed_dac_account("arbitrator11", issue: "100.0000 EOSDAC", memberreg: "New Latest terms", dac_scope: "dacproposals", dac_owner: "dacdirectory")

  seed_dac_account("custodian1", issue: "100.0000 EOSDAC", memberreg: "New Latest terms", dac_scope: "dacproposals", dac_owner: "dacdirectory")
  seed_dac_account("custodian2", issue: "100.0000 EOSDAC", memberreg: "New Latest terms", dac_scope: "dacproposals", dac_owner: "dacdirectory")
  seed_dac_account("custodian3", issue: "100.0000 EOSDAC", memberreg: "New Latest terms", dac_scope: "dacproposals", dac_owner: "dacdirectory")
  seed_dac_account("custodian4", issue: "100.0000 EOSDAC", memberreg: "New Latest terms", dac_scope: "dacproposals", dac_owner: "dacdirectory")
  seed_dac_account("custodian5", issue: "100.0000 EOSDAC", memberreg: "New Latest terms", dac_scope: "dacproposals", dac_owner: "dacdirectory")
  seed_dac_account("custodian11", issue: "100.0000 EOSDAC", memberreg: "New Latest terms", dac_scope: "dacproposals", dac_owner: "dacdirectory")
  seed_dac_account("custodian12", issue: "100.0000 EOSDAC", memberreg: "New Latest terms", dac_scope: "dacproposals", dac_owner: "dacdirectory")
  seed_dac_account("custodian13", issue: "100.0000 EOSDAC", memberreg: "New Latest terms", dac_scope: "dacproposals", dac_owner: "dacdirectory")
  seed_dac_account("custodian14", issue: "100.0000 EOSDAC", memberreg: "New Latest terms", dac_scope: "dacproposals", dac_owner: "dacdirectory")

  run %(cleos push action daccustmock updatecust '{"custodians": ["custodian1", "custodian2", "custodian3", "custodian4", "custodian5", "custodian11", "custodian12", "custodian13", "custodian14"], "dac_scope": "dacproposals"}' -p proposeracc1)

  run %(cleos set account permission dacauthority one '{"threshold": 1,"keys": [],"accounts": [{"permission":{"actor":"custodian1","permission":"active"},"weight":1}, {"permission":{"actor":"custodian11","permission":"active"},"weight":1}, {"permission":{"actor":"custodian12","permission":"active"},"weight":1}, {"permission":{"actor":"custodian13","permission":"active"},"weight":1}, {"permission":{"actor":"custodian2","permission":"active"},"weight":1}, {"permission":{"actor":"custodian3","permission":"active"},"weight":1}, {"permission":{"actor":"custodian4","permission":"active"},"weight":1}, {"permission":{"actor":"custodian5","permission":"active"},"weight":1}]}' low -p dacauthority@low)
end

describe "eosdacelect" do
  before(:all) do
    reset_chain
    configure_wallet
    seed_system_contracts
    configure_dac_accounts_and_permissions
    install_dac_contracts
    configure_contracts
  end

  after(:all) do
    killchain
  end

  describe "updateconfig" do
    context "without valid auth" do
      it do
        result = wrap_result = wrap_command %(cleos push action dacproposals updateconfig '{"new_config": { "service_account": "dacescrow", "member_terms_account": "eosdactokens", "treasury_account": "eosdacthedac", "proposal_threshold": 7, "finalize_threshold": 5, "escrow_expiry": 2592000, "authority_account": "dacauthority", "approval_expiry": 86500}, "dac_scope": "dacproposals"}' -p proposeracc1)
        expect(result.stderr).to include('missing authority of dacauthority')
      end
    end
    context "with valid auth" do
      it do
        result = wrap_command %(cleos push action dacproposals updateconfig '{"new_config": { "service_account": "dacescrow", "member_terms_account": "eosdactokens", "treasury_account": "eosdacthedac", "proposal_threshold": 7, "finalize_threshold": 5, "escrow_expiry": 2592000, "authority_account": "dacauthority", "approval_expiry": 86500}, "dac_scope": "dacproposals"}' -p dacauthority)
        expect(result.stdout).to include('dacproposals <= dacproposals::updateconfig')
      end
    end
  end

  context "Read the config table after updateconfig" do
    it do
      result = wrap_command %(cleos get table dacproposals dacproposals config)
      expect(JSON.parse(result.stdout)).to eq JSON.parse <<~JSON
        {
          "rows": [{
              "proposal_threshold": 7,
              "finalize_threshold": 5,
              "escrow_expiry": 2592000,
              "approval_expiry": 86500
            }
          ],
          "more": false
        }
      JSON
    end
  end

  describe "createprop" do
    context "Without valid permission" do
      context "with valid and registered member" do
        it do
          result = wrap_command %(cleos push action dacproposals createprop '{"proposer": "proposeracc1", "title": "some_title", "summary": "some_summary", "arbitrator": "arbitrator11", "pay_amount": {"quantity": "100.0000 EOS", "contract": "eosio.token"}, "content_hash": "jhsdfkjhsdfkjhkjsdf", "id": 0, "category": 2, "dac_scope": "dacproposals" }' -p proposeracc2)
          expect(result.stderr).to include('missing authority of proposeracc1')
        end
      end
    end

    context "with valid auth" do
      context "with an invalid title" do
        it do
          result = wrap_command %(cleos push action dacproposals createprop '{"proposer": "proposeracc1", "title": "", "summary": "some_summary", "arbitrator": "arbitrator11", "pay_amount": {"quantity": "100.0000 EOS", "contract": "eosio.token"}, "content_hash": "jhsdfkjhsdfkjhkjsdf", "id": 0, "category": 2, "dac_scope": "dacproposals" }' -p proposeracc1)
          expect(result.stderr).to include('Title length is too short')
        end
      end
      context "with an invalid Summary" do
        it do
          result = wrap_command %(cleos push action dacproposals createprop '{"proposer": "proposeracc1", "title": "some_title", "summary": "", "arbitrator": "arbitrator11", "pay_amount": {"quantity": "100.0000 EOS", "contract": "eosio.token"}, "content_hash": "jhsdfkjhsdfkjhkjsdf", "id": 0, "category": 2, "dac_scope": "dacproposals" }' -p proposeracc1)
          expect(result.stderr).to include('Summary length is too short')
        end
      end
      context "with an invalid pay symbol" do
        it do
          result = wrap_command %(cleos push action dacproposals createprop '{"proposer": "proposeracc1", "title": "some_title", "summary": "", "arbitrator": "arbitrator11", "pay_amount": {"quantity": "100.0000 soe", "contract": "eosio.token"}, "content_hash": "jhsdfkjhsdfkjhkjsdf", "id": 0, "category": 2, "dac_scope": "dacproposals" }' -p proposeracc1)
          expect(result.stderr).to include('Invalid symbol')
        end
      end
      context "with an no pay symbol" do
        it do
          result = wrap_command %(cleos push action dacproposals createprop '{"proposer": "proposeracc1", "title": "some_title", "summary": "", "arbitrator": "arbitrator11", "pay_amount": {"quantity": "100.0000", "contract": "eosio.token"}, "content_hash": "jhsdfkjhsdfkjhkjsdf", "id": 0, "category": 2, "dac_scope": "dacproposals" }' -p proposeracc1)
          expect(result.stderr).to include("Asset's amount and symbol should be separated with space")
        end
      end
      context "with negative pay amount" do
        it do
          result = wrap_command %(cleos push action dacproposals createprop '{"proposer": "proposeracc1", "title": "some_title", "summary": "some_summary", "arbitrator": "arbitrator11", "pay_amount": {"quantity": "-100.0000 EOS", "contract": "eosio.token"}, "content_hash": "jhsdfkjhsdfkjhkjsdf", "id": 0, "category": 2, "dac_scope": "dacproposals" }' -p proposeracc1)
          expect(result.stderr).to include('Invalid pay amount. Must be greater than 0.')
        end
      end
      context "with non-existing arbitrator" do
        it do
          result = wrap_command %(cleos push action dacproposals createprop '{"proposer": "proposeracc1", "title": "some_title", "summary": "some_summary", "arbitrator": "unknownarbit", "pay_amount": {"quantity": "100.0000 EOS", "contract": "eosio.token"}, "content_hash": "jhsdfkjhsdfkjhkjsdf", "id": 0, "category": 2, "dac_scope": "dacproposals" }' -p proposeracc1)
          expect(result.stderr).to include('Invalid arbitrator.')
        end
      end
      context "with valid params" do
        it do
          result = wrap_command %(cleos push action dacproposals createprop '{"proposer": "proposeracc1", "title": "some_title", "summary": "some_summary", "arbitrator": "arbitrator11", "pay_amount": {"quantity": "100.0000 EOS", "contract": "eosio.token"}, "content_hash": "asdfasdfasdfasdfasdfasdfasdfasdf", "id": 0, "category": 2, "dac_scope": "dacproposals" }' -p proposeracc1)
          expect(result.stdout).to include('dacproposals <= dacproposals::createprop')
        end
      end
      context "with duplicate id" do
        it do
          result = wrap_command %(cleos push action dacproposals createprop '{"proposer": "proposeracc1", "title": "some_title", "summary": "some_summary", "arbitrator": "arbitrator11", "pay_amount": {"quantity": "110.0000 EOS", "contract": "eosio.token"}, "content_hash": "asdfasdfasdfasdfasdfggggasdfasdf", "id": 0, "category": 2, "dac_scope": "dacproposals" }' -p proposeracc1)
          expect(result.stderr).to include('A Proposal with the id already exists. Try again with a different id.')
        end
      end
      context "with valid params as an extra proposal" do
        it do
          result = wrap_command %(cleos push action dacproposals createprop '{"proposer": "proposeracc2", "title": "some_title", "summary": "some_summary", "arbitrator": "arbitrator11", "pay_amount": {"quantity": "100.0000 EOS", "contract": "eosio.token"}, "content_hash": "asdfasdfasdfasdfasdfasdfasdfasdf", "id": 16, "category": 2, "dac_scope": "dacproposals" }' -p proposeracc2)
          expect(result.stdout).to include('dacproposals <= dacproposals::createprop')
        end
      end
    end
    context "Read the proposals table after createprop" do
      it do
        result = wrap_command %(cleos get table dacproposals dacproposals proposals)
        json = JSON.parse(result.stdout)
        expect(json["rows"].count).to eq 2

        prop = json["rows"].detect {|v| v["proposer"] == 'proposeracc1'}

        expect(prop["key"]).to eq 0
        expect(prop["arbitrator"]).to eq 'arbitrator11'
        expect(prop["content_hash"]).to eq 'asdfasdfasdfasdfasdfasdfasdfasdf'
        expect(prop["pay_amount"]["quantity"]).to eq "100.0000 EOS"
        expect(prop["pay_amount"]["contract"]).to eq "eosio.token"
        expect(prop["state"]).to eq 0
        expect(prop["category"]).to eq 2
        expect(string_date_to_UTC(prop["expiry"]).day).to eq (utc_today.next_day(1).day)
      end
    end
  end


  describe "voteprop" do
    context "without valid auth" do
      it do
        result = wrap_command %(cleos push action dacproposals voteprop '{"custodian": "custodian1", "proposal_id": 0, "vote": 1, "dac_scope": "dacproposals"}' -p proposeracc2 -p custodian1)
        expect(result.stderr).to include('missing authority of dacauthority')
      end
    end
    context "with valid auth" do
      context "with invalid proposal id" do
        it do
          result = wrap_command %(cleos push action dacproposals voteprop '{"custodian": "custodian1", "proposal_id": 1, "vote": 1, "dac_scope": "dacproposals" }' -p dacauthority -p custodian1)
          expect(result.stderr).to include('Proposal not found')
        end
      end
      context "proposal in pending_approval state" do
        context "finalize_approve vote" do
          it do
            result = wrap_command %(cleos push action dacproposals voteprop '{"custodian": "custodian1", "proposal_id": 0, "vote": 1, "dac_scope": "dacproposals" }' -p dacauthority -p custodian1)
            expect(result.stdout).to include('dacproposals <= dacproposals::voteprop')
          end
        end
        context "finalize_deny vote" do
          it do
            result = wrap_command %(cleos push action dacproposals voteprop '{"custodian": "custodian2", "proposal_id": 0, "vote": 2, "dac_scope": "dacproposals" }' -p dacauthority -p custodian2)
            expect(result.stdout).to include('dacproposals <= dacproposals::voteprop')
          end
        end
        context "proposal_approve vote" do
          it do
            result = wrap_command %(cleos push action dacproposals voteprop '{"custodian": "custodian3", "proposal_id": 0, "vote": 1, "dac_scope": "dacproposals" }' -p dacauthority -p custodian3)
            expect(result.stdout).to include('dacproposals <= dacproposals::voteprop')
          end
        end
        context "Extra proposal_approve vote" do
          it do
            result = wrap_command %(cleos push action dacproposals voteprop '{"custodian": "custodian3", "proposal_id": 16, "vote": 1, "dac_scope": "dacproposals" }' -p dacauthority -p custodian3)
            expect(result.stdout).to include('dacproposals <= dacproposals::voteprop')
          end
        end
        context "proposal_deny vote of existing vote" do
          it do
            result = wrap_command %(cleos push action dacproposals voteprop '{"custodian": "custodian3", "proposal_id": 0, "vote": 2, "dac_scope": "dacproposals" }' -p dacauthority -p custodian3)
            expect(result.stdout).to include('dacproposals <= dacproposals::voteprop')
          end
        end
      end
    end
  end

  describe "delegate vote" do
    before(:all) do
      run %(cleos push action dacproposals createprop '{"proposer": "proposeracc1", "title": "startwork_title", "summary": "startwork_summary", "arbitrator": "arbitrator11", "pay_amount": {"quantity": "101.0000 EOS", "contract": "eosio.token"}, "content_hash": "asdfasdfasdfasdfasdfasdfasdffdsa", "id": 1, "category": 3, "dac_scope": "dacproposals" }' -p proposeracc1)
    end
    context "without valid auth" do
      it do
        result = wrap_command %(cleos push action dacproposals delegatevote '{"custodian": "custodian12", "proposal_id": 0, "delegatee_custodian": "custodian11", "dac_scope": "dacproposals" }' -p proposeracc2 -p custodian12)
        expect(result.stderr).to include('missing authority of dacauthority')
      end
    end
    context "with valid auth" do
      context "with invalid proposal id" do
        it do
          result = wrap_command %(cleos push action dacproposals delegatevote '{"custodian": "custodian12", "proposal_id": 6, "delegatee_custodian": "custodian11", "dac_scope": "dacproposals" }' -p dacauthority -p custodian12)
          expect(result.stderr).to include('Proposal not found')
        end
      end
      context "delegating to self" do
        it do
          result = wrap_command %(cleos push action dacproposals delegatevote '{"custodian": "custodian12", "proposal_id": 6, "delegatee_custodian": "custodian12", "dac_scope": "dacproposals" }' -p dacauthority -p custodian12)
          expect(result.stderr).to include('Cannot delegate voting to yourself.')
        end
      end
      context "proposal in pending_approval state" do
        context "delegate vote" do
          it do
            result = wrap_command %(cleos push action dacproposals delegatevote '{"custodian": "custodian12", "proposal_id": 1, "delegatee_custodian": "custodian11", "dac_scope": "dacproposals" }' -p dacauthority -p custodian12)
            expect(result.stdout).to include('dacproposals <= dacproposals::delegatevote')
          end
        end
      end
    end
  end

  describe "comment" do
    context "without valid auth" do
      it do
        result = wrap_command %(cleos push action dacproposals comment '{"commenter": "proposeracc2", "proposal_id": 0, "comment": "some comment", "comment_category": "objection", "dac_scope": "dacproposals" }' -p proposeracc2)
        expect(result.stderr).to include('missing authority of dacauthority')
      end
    end
    context "with valid auth" do
      context "with invalid proposal id" do
        it do
          result = wrap_command %(cleos push action dacproposals comment '{"commenter": "proposeracc2", "proposal_id": 6, "comment": "some comment", "comment_category": "objection", "dac_scope": "dacproposals" }' -p proposeracc2)
          expect(result.stderr).to include('Proposal not found')
        end
      end
      context "with custodian only auth" do
        it do
          result = wrap_command %(cleos push action dacproposals comment '{"commenter": "custodian1", "proposal_id": 0, "comment": "some comment", "comment_category": "objection", "dac_scope": "dacproposals" }' -p custodian1 -p dacauthority)
          expect(result.stdout).to include('dacproposals <= dacproposals::comment')
        end
      end
    end
  end

  describe "startwork" do
    context "without valid auth" do
      it do
        result = wrap_command %(cleos push action dacproposals startwork '{ "proposer": "proposeracc1", "proposal_id": 1, "dac_scope": "dacproposals"}' -p proposeracc2)
        expect(result.stderr).to include('missing authority of proposeracc1')
      end
    end
    context "with valid auth" do
      context "with invalid proposal id" do
        it do
          result = wrap_command %(cleos push action dacproposals startwork '{ "proposer": "proposeracc1", "proposal_id": 4, "dac_scope": "dacproposals"}' -p proposeracc1)
          expect(result.stderr).to include('Proposal not found')
        end
      end
      context "proposal in pending_approval state" do
        context "with insufficient votes count" do
          it do
            result = wrap_command %(cleos push action dacproposals startwork '{ "proposer": "proposeracc1", "proposal_id": 1, "dac_scope": "dacproposals"}' -p proposeracc1)
            expect(result.stderr).to include('Insufficient votes on worker proposal')
          end
        end
        context "with more denied than approved votes" do
          before(:all) do
            run %(cleos push action dacproposals voteprop '{"custodian": "custodian1", "proposal_id": 1, "vote": 2, "dac_scope": "dacproposals" }' -p custodian1 -p dacauthority)
            run %(cleos push action dacproposals voteprop '{"custodian": "custodian2", "proposal_id": 1, "vote": 2, "dac_scope": "dacproposals" }' -p custodian2 -p dacauthority)
            run %(cleos push action dacproposals voteprop '{"custodian": "custodian3", "proposal_id": 1, "vote": 2, "dac_scope": "dacproposals" }' -p custodian3 -p dacauthority)
            run %(cleos push action dacproposals voteprop '{"custodian": "custodian4", "proposal_id": 1, "vote": 2, "dac_scope": "dacproposals" }' -p custodian4 -p dacauthority)
            run %(cleos push action dacproposals voteprop '{"custodian": "custodian5", "proposal_id": 1, "vote": 2, "dac_scope": "dacproposals" }' -p custodian5 -p dacauthority)
            run %(cleos push action dacproposals voteprop '{"custodian": "custodian11", "proposal_id": 1, "vote": 1, "dac_scope": "dacproposals" }' -p custodian11 -p dacauthority)
            # cleos push action dacproposals voteprop '{"custodian": "custodian12", "proposal_id": 1, "vote": 1, "dac_scope": "dacproposals" }' -p custodian12 -p dacauthority
            run %(cleos push action dacproposals voteprop '{"custodian": "custodian13", "proposal_id": 1, "vote": 1, "dac_scope": "dacproposals" }' -p custodian13 -p dacauthority)
          end
          it do
            result = wrap_command %(cleos push action dacproposals startwork '{ "proposer": "proposeracc1", "proposal_id": 1, "dac_scope": "dacproposals"}' -p proposeracc1)
            expect(result.stderr).to include('Insufficient votes on worker proposal')
          end
        end
        context "with enough votes to approve the proposal" do
          context "check updateVotes count on proposal before calling start work" do
            before(:all) do
              sleep 2
              run %(cleos push action dacproposals voteprop '{"custodian": "custodian1", "proposal_id": 1, "vote": 1, "dac_scope": "dacproposals" }' -p custodian1 -p dacauthority)
              run %(cleos push action dacproposals voteprop '{"custodian": "custodian2", "proposal_id": 1, "vote": 1, "dac_scope": "dacproposals" }' -p custodian2 -p dacauthority)
              run %(cleos push action dacproposals voteprop '{"custodian": "custodian3", "proposal_id": 1, "vote": 1, "dac_scope": "dacproposals" }' -p custodian3 -p dacauthority)
              run %(cleos push action dacproposals voteprop '{"custodian": "custodian4", "proposal_id": 1, "vote": 1, "dac_scope": "dacproposals" }' -p custodian4 -p dacauthority)
              run %(cleos push action dacproposals voteprop '{"custodian": "custodian5", "proposal_id": 1, "vote": 1, "dac_scope": "dacproposals" }' -p custodian5 -p dacauthority)
              run %(cleos push action dacproposals voteprop '{"custodian": "custodian11", "proposal_id": 1, "vote": 1, "dac_scope": "dacproposals" }' -p custodian11 -p dacauthority)
              # run %(cleos push action dacproposals voteprop '{"custodian": "custodian12", "proposal_id": 1, "vote": 1, "dac_scope": "dacproposals" }' -p custodian12 -p dacauthority)
              run %(cleos push action dacproposals voteprop '{"custodian": "custodian13", "proposal_id": 1, "vote": 2, "dac_scope": "dacproposals" }' -p custodian13 -p dacauthority)
            end
            # context "with enough votes to approve updatepropvotes" do
            it do
              result = wrap_command %(cleos push action dacproposals updpropvotes '{ "proposal_id": 1, "dac_scope": "dacproposals"}' -p proposeracc1)
              expect(result.stdout).to include('dacproposals::updpropvotes')
            end
          end
          # end
          context "Read the proposals table after create prop before expiring" do
            it do
              result = wrap_command %(cleos get table dacproposals dacproposals proposals)
              json = JSON.parse(result.stdout)
              prop = json["rows"].detect {|v| v["key"] == 1}
              expect(prop["state"]).to eq 3
            end
          end
          context "startwork with enough votes" do
            it do
              result = wrap_command %(cleos push action dacproposals startwork '{ "proposer": "proposeracc1", "proposal_id": 1, "dac_scope": "dacproposals"}' -p proposeracc1)
              expect(result.stdout).to include('dacproposals::startwork')
            end
          end
        end
      end
      context "proposal not in pending_approval state" do
        before(:all) {sleep 1.5}
        it do
          result = wrap_command %(cleos push action dacproposals startwork '{ "proposer": "proposeracc1", "proposal_id": 1, "dac_scope": "dacproposals" "nonce": "stuff"}' -p proposeracc1)
          expect(result.stderr).to include('Proposal is not in the pending approval state therefore cannot start work.')
        end
      end
      context "proposal has expired" do
        before(:all) do
          run %(cleos push action dacproposals updateconfig '{"new_config": { "service_account": "dacescrow", "member_terms_account": "eosdactokens", "treasury_account": "eosdacthedac", "proposal_threshold": 7, "finalize_threshold": 5, "escrow_expiry": 2592000, "authority_account": "dacauthority", "approval_expiry": 2}, "dac_scope": "dacproposals"}' -p dacauthority)
          run %(cleos push action dacproposals createprop '{"proposer": "proposeracc1", "title": "startwork_title", "summary": "startwork_summary", "arbitrator": "arbitrator11", "pay_amount": {"quantity": "102.0000 EOS", "contract": "eosio.token"}, "content_hash": "asdfasdfasdfasdfasdfasdfasdffttt", "id": 5, "category": 4, "dac_scope": "dacproposals" }' -p proposeracc1)
        end
        context "Read the proposals table after create prop before expiring" do
          it do
            result = wrap_command %(cleos get table dacproposals dacproposals proposals)
            json = JSON.parse(result.stdout)
            expect(json["rows"].count).to eq 4

            prop = json["rows"].detect {|v| v["key"] == 5}

            expect(prop["proposer"]).to eq 'proposeracc1'
            expect(prop["arbitrator"]).to eq 'arbitrator11'
            expect(prop["content_hash"]).to eq 'asdfasdfasdfasdfasdfasdfasdffttt'
            expect(prop["pay_amount"]["quantity"]).to eq "102.0000 EOS"
            expect(prop["pay_amount"]["contract"]).to eq "eosio.token"
            expect(prop["state"]).to eq 0
            expect(prop["category"]).to eq 4
            expect(string_date_to_UTC(prop["expiry"]).day).to eq (utc_today.day)
          end
        end
      end
    end
    context "startwork before expiry proposal" do
      it do
        result = wrap_command %(cleos push action dacproposals startwork '{ "proposer": "proposeracc1", "proposal_id": 5, "dac_scope": "dacproposals"}' -p proposeracc1)
        expect(result.stderr).to include('Insufficient votes on worker proposal')
      end
    end
    context "startwork after expiry on proposal" do
      before(:all) do
        sleep 3 # wait for expiry
      end
      it do
        result = wrap_command %(cleos push action dacproposals startwork '{ "proposer": "proposeracc1", "proposal_id": 5, "dac_scope": "dacproposals"}' -p proposeracc1)
        expect(result.stderr).to include('ERR::PROPOSAL_EXPIRED')
      end
    end
    context "Read the propvotes table after voting" do
      it do
        result = wrap_command %(cleos get table dacproposals dacproposals propvotes --limit 20)
        expect(JSON.parse(result.stdout)).to eq JSON.parse <<~JSON
                      {
            "rows": [{
                      "vote_id": 0,
                      "voter": "custodian1",
                      "proposal_id": 0,
                      "category_id": null,
                      "vote": 1,
                      "delegatee": null,
                      "comment_hash": null
                    },{
                      "vote_id": 1,
                      "voter": "custodian2",
                      "proposal_id": 0,
                      "category_id": null,
                      "vote": 2,
                      "delegatee": null,
                      "comment_hash": null
                    },{
                      "vote_id": 2,
                      "voter": "custodian3",
                      "proposal_id": 0,
                      "category_id": null,
                      "vote": 2,
                      "delegatee": null,
                      "comment_hash": null
                    },{
                      "vote_id": 3,
                      "voter": "custodian3",
                      "proposal_id": 16,
                      "category_id": null,
                      "vote": 1,
                      "delegatee": null,
                      "comment_hash": null
                    },{
                      "vote_id": 4,
                      "voter": "custodian12",
                      "proposal_id": 1,
                      "category_id": null,
                      "vote": null,
                      "delegatee": "custodian11",
                      "comment_hash": null
                    },{
                      "vote_id": 5,
                      "voter": "custodian1",
                      "proposal_id": 1,
                      "category_id": null,
                      "vote": 1,
                      "delegatee": null,
                      "comment_hash": null
                    },{
                      "vote_id": 6,
                      "voter": "custodian2",
                      "proposal_id": 1,
                      "category_id": null,
                      "vote": 1,
                      "delegatee": null,
                      "comment_hash": null
                    },{
                      "vote_id": 7,
                      "voter": "custodian3",
                      "proposal_id": 1,
                      "category_id": null,
                      "vote": 1,
                      "delegatee": null,
                      "comment_hash": null
                    },{
                      "vote_id": 8,
                      "voter": "custodian4",
                      "proposal_id": 1,
                      "category_id": null,
                      "vote": 1,
                      "delegatee": null,
                      "comment_hash": null
                    },{
                      "vote_id": 9,
                      "voter": "custodian5",
                      "proposal_id": 1,
                      "category_id": null,
                      "vote": 1,
                      "delegatee": null,
                      "comment_hash": null
                    },{
                      "vote_id": 10,
                      "voter": "custodian11",
                      "proposal_id": 1,
                      "category_id": null,
                      "vote": 1,
                      "delegatee": null,
                      "comment_hash": null
                    },{
                      "vote_id": 11,
                      "voter": "custodian13",
                      "proposal_id": 1,
                      "category_id": null,
                      "vote": 2,
                      "delegatee": null,
                      "comment_hash": null
                    }
            ],
            "more": false
          }
        JSON
      end
    end
    context "Read the proposals table before clear exp proposals" do
      it do
        result = wrap_command %(cleos get table dacproposals dacproposals proposals)
        json = JSON.parse(result.stdout)
        expect(json["rows"].count).to eq 4
      end
    end
    context "clear expired proposals" do
      it do
        result = wrap_command %(cleos push action dacproposals clearexpprop '{ "proposal_id": 5, "dac_scope": "dacproposals"}' -p proposeracc1)
        expect(result.stdout).to include('dacproposals::clearexpprop')
      end
    end
    context "Read the proposals table after startwork" do
      it do
        result = wrap_command %(cleos get table dacproposals dacproposals proposals)
        json = JSON.parse(result.stdout)
        expect(json["rows"].count).to eq 3

        prop = json["rows"].detect {|v| v["key"] == 1}

        expect(prop["proposer"]).to eq 'proposeracc1'
        expect(prop["arbitrator"]).to eq 'arbitrator11'
        expect(prop["content_hash"]).to eq 'asdfasdfasdfasdfasdfasdfasdffdsa'
        expect(prop["pay_amount"]["quantity"]).to eq "101.0000 EOS"
        expect(prop["pay_amount"]["contract"]).to eq "eosio.token"
        expect(prop["state"]).to eq 1
        expect(string_date_to_UTC(prop["expiry"]).day).to eq (utc_today.next_day(1).day)
      end
    end
    context "Read the escrow table after startwork" do
      it do
        result = wrap_command %(cleos get table dacescrow dacescrow escrows)
        json = JSON.parse(result.stdout)
        expect(json["rows"].count).to eq 1

        escrow = json["rows"].detect {|v| v["receiver"] == 'proposeracc1'}

        expect(escrow["key"]).to eq 0
        expect(escrow["sender"]).to eq 'eosdacthedac'
        expect(escrow["receiver"]).to eq 'proposeracc1'
        expect(escrow["arb"]).to eq 'arbitrator11'
        expect(escrow["approvals"].count).to eq 0
        expect(escrow["ext_asset"]["quantity"]).to eq "101.0000 EOS"
        expect(escrow["memo"]).to eq "proposeracc1:1:asdfasdfasdfasdfasdfasdfasdffdsa"
        expect(escrow["external_reference"]).to eq 1
        expect(string_date_to_UTC(escrow["expires"]).day).to eq (utc_today.next_day(30).day)
      end
    end
  end

  context "voteprop with valid auth and proposal in work_in_progress state" do
    context "voteup" do
      it do
        result = wrap_command %(cleos push action dacproposals voteprop '{"custodian": "custodian1", "proposal_id": 1, "vote": 1, "dac_scope": "dacproposals" }' -p custodian1 -p dacauthority)
        expect(result.stderr).to include('Invalid proposal state to accept votes.')
      end
    end
    context "votedown" do
      it do
        result = wrap_command %(cleos push action dacproposals voteprop '{"custodian": "custodian1", "proposal_id": 1, "vote": 2, "dac_scope": "dacproposals" }' -p custodian1 -p dacauthority)
        expect(result.stderr).to include('Invalid proposal state to accept votes.')
      end
    end
  end

  describe "complete work" do
    context "proposal in pending approval state should fail" do
      it do
        result = wrap_command %(cleos push action dacproposals completework '{ "proposer": "proposeracc1", "proposal_id": "0", "dac_scope": "dacproposals"}' -p proposeracc1)
        expect(result.stderr).to include('Worker proposal can only be completed from work_in_progress state')
      end
    end
  end

  describe "finalize" do
    context "without valid auth" do
      before(:all) do
      end

      context "with invalid proposal id" do
        it do
          result = wrap_command %(cleos push action dacproposals finalize '{ "proposal_id": "4", "dac_scope": "dacproposals"}' -p proposeracc1)
          expect(result.stderr).to include('Proposal not found')
        end
      end
      context "proposal in not in pending_finalize state" do
        it do
          result = wrap_command %(cleos push action dacproposals finalize '{ "proposal_id": "0", "dac_scope": "dacproposals"}' -p proposeracc1)
          expect(result.stderr).to include('Proposal is not in the pending_finalize state therefore cannot be finalized.')
        end
      end
      context "proposal is in pending_finalize state" do
        before(:all) do
          run %(cleos push action dacproposals completework '{ "proposer": "proposeracc1", "proposal_id": "1", "dac_scope": "dacproposals", "nonce": "some nonce"}' -p proposeracc1)
          sleep 1
        end
        context "proposal in pending finalize state should fail completework" do
          it do
            result = wrap_command %(cleos push action dacproposals completework '{ "proposer": "proposeracc1", "proposal_id": "1", "dac_scope": "dacproposals"}' -p proposeracc1)
            expect(result.stderr).to include('Worker proposal can only be completed from work_in_progress state')
          end
        end
        context "without enough votes to approve the finalize" do
          it do
            result = wrap_command %(cleos push action dacproposals finalize '{ "proposer": "proposeracc1", "proposal_id": "1", "dac_scope": "dacproposals"}' -p proposeracc1)
            expect(result.stderr).to include('Insufficient votes on worker proposal to be finalized.')
          end
        end
        context "with enough votes to complete finalize with denial" do
          context "update votes count" do
            before(:all) do
              run %(cleos push action dacproposals voteprop '{"custodian": "custodian1",  "proposal_id": 1, "vote": 3, "dac_scope": "dacproposals" }' -p custodian1 -p dacauthority)
              run %(cleos push action dacproposals voteprop '{"custodian": "custodian2",  "proposal_id": 1, "vote": 3, "dac_scope": "dacproposals" }' -p custodian2 -p dacauthority)
              run %(cleos push action dacproposals voteprop '{"custodian": "custodian3",  "proposal_id": 1, "vote": 3, "dac_scope": "dacproposals" }' -p custodian3 -p dacauthority)
              run %(cleos push action dacproposals voteprop '{"custodian": "custodian4",  "proposal_id": 1, "vote": 4, "dac_scope": "dacproposals" }' -p custodian4 -p dacauthority)
              run %(cleos push action dacproposals voteprop '{"custodian": "custodian5",  "proposal_id": 1, "vote": 4, "dac_scope": "dacproposals" }' -p custodian5 -p dacauthority)
              run %(cleos push action dacproposals voteprop '{"custodian": "custodian11", "proposal_id": 1, "vote": 3, "dac_scope": "dacproposals" }' -p custodian11 -p dacauthority)
              # `cleos push action dacproposals voteprop '{"custodian": "custodian12", "proposal_id": 1, "vote": 3, "dac_scope": "dacproposals" }' -p custodian12 -p dacauthority`
            end
            it do
              result = wrap_command %(cleos push action dacproposals updpropvotes '{ "proposal_id": 1, "dac_scope": "dacproposals"}' -p proposeracc1)
              expect(result.stdout).to include('dacproposals::updpropvotes')
            end
          end
          context "Read the proposals table after create prop before expiring" do
            it do
              result = wrap_command %(cleos get table dacproposals dacproposals proposals)
              json = JSON.parse(result.stdout)
              prop = json["rows"].detect {|v| v["key"] == 1}
              expect(prop["state"]).to eq 4
            end
          end
          context "finalize after updating vote counts" do
            it do
              result = wrap_command %(cleos push action dacproposals finalize '{ "proposer": "proposeracc1", "proposal_id": 1, "dac_scope": "dacproposals"}' -p proposeracc1)
              expect(result.stdout).to include('dacproposals <= dacproposals::finalize')
            end
          end
        end
      end
    end

    context "Read the propvotes table after finalizing" do
      it do
        result = wrap_command %(cleos get table dacproposals dacproposals propvotes)
        expect(JSON.parse(result.stdout)).to eq JSON.parse <<~JSON
                    {
          "rows": [{
                    "vote_id": 0,
                    "voter": "custodian1",
                    "proposal_id": 0,
                    "category_id": null,
                    "vote": 1,
                    "delegatee": null,
                    "comment_hash": null
                  },{
                    "vote_id": 1,
                    "voter": "custodian2",
                    "proposal_id": 0,
                    "category_id": null,
                    "vote": 2,
                    "delegatee": null,
                    "comment_hash": null
                  },{
                    "vote_id": 2,
                    "voter": "custodian3",
                    "proposal_id": 0,
                    "category_id": null,
                    "vote": 2,
                    "delegatee": null,
                    "comment_hash": null
                  }
                ],
                "more": false
            }
        JSON
      end
    end
    context "Read the proposals table after finalize" do
      it do
        result = wrap_command %(cleos get table dacproposals dacproposals proposals)
        json = JSON.parse(result.stdout)
        expect(json["rows"].count).to eq 2

        prop = json["rows"].detect {|v| v["key"] == 0}

        expect(prop["proposer"]).to eq 'proposeracc1'
        expect(prop["arbitrator"]).to eq 'arbitrator11'
        expect(prop["content_hash"]).to eq 'asdfasdfasdfasdfasdfasdfasdfasdf'
        expect(prop["pay_amount"]["quantity"]).to eq "100.0000 EOS"
        expect(prop["pay_amount"]["contract"]).to eq "eosio.token"
        expect(prop["state"]).to eq 0
        expect(string_date_to_UTC(prop["expiry"]).day).to eq (utc_today.next_day(1).day)
      end
    end
    context "Read the escrow table after finalize" do
      it do
        result = wrap_command %(cleos get table dacescrow dacescrow escrows)
        json = JSON.parse(result.stdout)
        expect(json["rows"].count).to eq 1

        escrow = json["rows"].detect {|v| v["receiver"] == 'proposeracc1'}

        expect(escrow["key"]).to eq 0
        expect(escrow["sender"]).to eq 'eosdacthedac'
        expect(escrow["receiver"]).to eq 'proposeracc1'
        expect(escrow["arb"]).to eq 'arbitrator11'
        expect(escrow["approvals"]).to eq ["eosdacthedac"]
        expect(escrow["ext_asset"]["quantity"]).to eq "101.0000 EOS"
        expect(escrow["memo"]).to eq "proposeracc1:1:asdfasdfasdfasdfasdfasdfasdffdsa"
        expect(escrow["external_reference"]).to eq 1
        expect(string_date_to_UTC(escrow["expires"]).day).to eq (utc_today.next_day(30).day)
      end
    end
  end

  describe "cancel" do
    context "without valid auth" do
      it do
        result = wrap_command %(cleos push action dacproposals cancel '{ "proposer": "proposeracc1", "proposal_id": "0", "dac_scope": "dacproposals"}' -p proposeracc2)
        expect(result.stderr).to include('missing authority of proposeracc1')
      end
    end
    context "with valid auth" do
      context "with invalid proposal id" do
        it do
          result = wrap_command %(cleos push action dacproposals cancel '{ "proposer": "proposeracc1", "proposal_id": "4", "dac_scope": "dacproposals"}' -p proposeracc1)
          expect(result.stderr).to include('Proposal not found')
        end
      end
      context "with valid proposal id" do
        it do
          result = wrap_command %(cleos push action dacproposals cancel '{ "proposer": "proposeracc1", "proposal_id": "0", "dac_scope": "dacproposals"}' -p proposeracc1)
          expect(result.stdout).to include('dacproposals <= dacproposals::cancel')
        end
      end
      context "with valid proposal id after successfully started work but before completing" do
        before(:all) do
          sleep 1
          run %(cleos push action dacproposals createprop '{"proposer": "proposeracc1", "title": "startwork_title", "summary": "startwork_summary", "arbitrator": "arbitrator11", "pay_amount": {"quantity": "101.0000 EOS", "contract": "eosio.token"}, "content_hash": "asdfasdfasdfasdfasdfasdfasdfzzzz", "id": 2, "category": 2, "dac_scope": "dacproposals" }' -p proposeracc1)
          run %(cleos push action dacproposals voteprop '{"custodian": "custodian1", "proposal_id": 2, "vote": 1, "dac_scope": "dacproposals" }' -p custodian1 -p dacauthority)
          run %(cleos push action dacproposals voteprop '{"custodian": "custodian2", "proposal_id": 2, "vote": 1, "dac_scope": "dacproposals" }' -p custodian2 -p dacauthority)
          run %(cleos push action dacproposals voteprop '{"custodian": "custodian3", "proposal_id": 2, "vote": 1, "dac_scope": "dacproposals" }' -p custodian3 -p dacauthority)
          run %(cleos push action dacproposals voteprop '{"custodian": "custodian4", "proposal_id": 2, "vote": 2, "dac_scope": "dacproposals" }' -p custodian4 -p dacauthority)
          run %(cleos push action dacproposals voteprop '{"custodian": "custodian5", "proposal_id": 2, "vote": 1, "dac_scope": "dacproposals" }' -p custodian5 -p dacauthority)
          run %(cleos push action dacproposals voteprop '{"custodian": "custodian11", "proposal_id": 2, "vote": 1, "dac_scope": "dacproposals" }' -p custodian11 -p dacauthority)
          run %(cleos push action dacproposals voteprop '{"custodian": "custodian12", "proposal_id": 2, "vote": 1, "dac_scope": "dacproposals" }' -p custodian12 -p dacauthority)
          run %(cleos push action dacproposals voteprop '{"custodian": "custodian13", "proposal_id": 2, "vote": 1, "dac_scope": "dacproposals" }' -p custodian13 -p dacauthority)
          run %(cleos push action dacproposals startwork '{ "proposer": "proposeracc1", "proposal_id": 2, "dac_scope": "dacproposals"}' -p proposeracc1)
        end
        it do
          result = wrap_command %(cleos push action dacproposals cancel '{ "proposer": "proposeracc1", "proposal_id": "2", "dac_scope": "dacproposals"}' -p proposeracc1)
          expect(result.stdout).to include('dacproposals <= dacproposals::cancel')
        end
      end
    end
    context "Read the proposals table after cancel" do
      it do
        result = wrap_command %(cleos get table dacproposals dacproposals proposals)
        json = JSON.parse(result.stdout)
        expect(json["rows"].count).to eq 1

        proposal = json["rows"].detect {|v| v["proposer"] == 'proposeracc2'}
        expect(proposal["key"]).to eq 16
        expect(proposal["proposer"]).to eq "proposeracc2"
        expect(proposal["arbitrator"]).to eq "arbitrator11"
        expect(proposal ["content_hash"]).to eq "asdfasdfasdfasdfasdfasdfasdfasdf"
      end
    end
    context "Read the escrow table after startwork" do
      it do
        result = wrap_command %(cleos get table dacescrow dacescrow escrows)
        json = JSON.parse(result.stdout)
        expect(json["rows"].count).to eq 2

        escrow = json["rows"].detect {|v| v["receiver"] == 'proposeracc1'}

        expect(escrow["key"]).to eq 0
        expect(escrow["sender"]).to eq 'eosdacthedac'
        expect(escrow["receiver"]).to eq 'proposeracc1'
        expect(escrow["arb"]).to eq 'arbitrator11'
        expect(escrow["approvals"]).to eq ["eosdacthedac"]
        expect(escrow["ext_asset"]["quantity"]).to eq "101.0000 EOS"
        expect(escrow["memo"]).to eq "proposeracc1:1:asdfasdfasdfasdfasdfasdfasdffdsa"
        expect(escrow["external_reference"]).to eq 1
        expect(string_date_to_UTC(escrow["expires"]).day).to eq (utc_today.next_day(30).day)

      end
    end
  end

  describe "delegate categories" do
    before(:all) do
      seed_dac_account("proposeracc3", issue: "100.0000 EOSDAC", memberreg: "New Latest terms", dac_scope: "dacproposals", dac_owner: "dacdirectory")
      run %(cleos push action dacproposals updateconfig '{"new_config": { "service_account": "dacescrow", "member_terms_account": "eosdactokens", "treasury_account": "eosdacthedac", "proposal_threshold": 7, "finalize_threshold": 5, "escrow_expiry": 2592000, "authority_account": "dacauthority", "approval_expiry": 200}, "dac_scope": "dacproposals"}' -p dacauthority)
    end
    context "Created a proposal but still needing one vote for approval for proposal" do
      before(:all) do
        run %(cleos push action dacproposals createprop '{"proposer": "proposeracc3", "title": "startwork_title", "summary": "startwork_summary", "arbitrator": "arbitrator11", "pay_amount": {"quantity": "102.0000 EOS", "contract": "eosio.token"}, "content_hash": "asdfasdfasdfasdfasdfasdfasdffttt", "id": 101, "category": 33, "dac_scope": "dacproposals" }' -p proposeracc3)

        run %(cleos push action dacproposals voteprop '{"custodian": "custodian1", "proposal_id": 101, "vote": 1, "dac_scope": "dacproposals" }' -p custodian1 -p dacauthority)
        run %(cleos push action dacproposals voteprop '{"custodian": "custodian2", "proposal_id": 101, "vote": 1, "dac_scope": "dacproposals" }' -p custodian2 -p dacauthority)
        run %(cleos push action dacproposals voteprop '{"custodian": "custodian3", "proposal_id": 101, "vote": 1, "dac_scope": "dacproposals" }' -p custodian3 -p dacauthority)
        run %(cleos push action dacproposals voteprop '{"custodian": "custodian4", "proposal_id": 101, "vote": 1, "dac_scope": "dacproposals" }' -p custodian4 -p dacauthority)
        run %(cleos push action dacproposals voteprop '{"custodian": "custodian5", "proposal_id": 101, "vote": 1, "dac_scope": "dacproposals" }' -p custodian5 -p dacauthority)
        run %(cleos push action dacproposals voteprop '{"custodian": "custodian11", "proposal_id": 101, "vote": 1, "dac_scope": "dacproposals" }' -p custodian11 -p dacauthority)
      end
      context "delegated category for voter with pre-existing vote for category should have no effect" do
        before(:all) do
          run %(cleos push action dacproposals delegatecat '{"custodian": "custodian11", "category": 33, "delegatee_custodian": "custodian5", "dac_scope": "dacproposals"}' -p custodian11 -p dacauthority)
        end
        it do
          result = wrap_command %(cleos push action dacproposals startwork '{ "proposal_id": 101, "dac_scope": "dacproposals"}' -p proposeracc3)
          expect(result.stderr).to include('ERR::STARTWORK_INSUFFICIENT_VOTES')
        end
      end
      context "delegated vote with non-matching category" do
        before(:all) do
          run %(cleos push action dacproposals delegatecat '{"custodian": "custodian13", "category": 32, "delegatee_custodian": "custodian11", "dac_scope": "dacproposals"}' -p custodian13 -p dacauthority)
        end
        it do
          result = wrap_command %(cleos push action dacproposals startwork '{ "proposal_id": 101, "dac_scope": "dacproposals"}' -p proposeracc3)
          expect(result.stderr).to include('ERR::STARTWORK_INSUFFICIENT_VOTES')
        end
      end
      context "delegated category with matching category" do
        before(:all) do
          run %(cleos push action dacproposals delegatecat '{"custodian": "custodian13", "category": 33, "delegatee_custodian": "custodian11", "dac_scope": "dacproposals"}' -p custodian13 -p dacauthority)
        end
        it do
          result = wrap_command %(cleos push action dacproposals startwork '{ "proposal_id": 101, "dac_scope": "dacproposals"}' -p proposeracc3)
          expect(result.stdout).to include('dacproposals <= dacproposals::startwork')
        end
      end
    end
    context "Created a proposal but still needing one vote for approval for categories" do
      before(:all) do
        run %(cleos push action dacproposals createprop '{"proposer": "proposeracc3", "title": "startwork_title", "summary": "startwork_summary", "arbitrator": "arbitrator11", "pay_amount": {"quantity": "102.0000 EOS", "contract": "eosio.token"}, "content_hash": "asdfasdfasdfasdfasdfasdfasdffttt", "id": 102, "category": 31, "dac_scope": "dacproposals" }' -p proposeracc3)

        run %(cleos push action dacproposals voteprop '{"custodian": "custodian1", "proposal_id": 102, "vote": 1, "dac_scope": "dacproposals" }' -p custodian1 -p dacauthority)
        run %(cleos push action dacproposals voteprop '{"custodian": "custodian2", "proposal_id": 102, "vote": 1, "dac_scope": "dacproposals" }' -p custodian2 -p dacauthority)
        run %(cleos push action dacproposals voteprop '{"custodian": "custodian3", "proposal_id": 102, "vote": 1, "dac_scope": "dacproposals" }' -p custodian3 -p dacauthority)
        run %(cleos push action dacproposals voteprop '{"custodian": "custodian4", "proposal_id": 102, "vote": 1, "dac_scope": "dacproposals" }' -p custodian4 -p dacauthority)
        run %(cleos push action dacproposals voteprop '{"custodian": "custodian5", "proposal_id": 102, "vote": 1, "dac_scope": "dacproposals" }' -p custodian5 -p dacauthority)
        run %(cleos push action dacproposals voteprop '{"custodian": "custodian11", "proposal_id": 102, "vote": 1, "dac_scope": "dacproposals" }' -p custodian11 -p dacauthority)
      end
      context "delegated category with already voted custodian should have no additional effect" do
        before(:all) do
          run %(cleos push action dacproposals delegatecat '{"custodian": "custodian11", "category": 31, "delegatee_custodian": "custodian5", "dac_scope": "dacproposals"}' -p custodian11 -p dacauthority)
        end
        it do
          result = wrap_command %(cleos push action dacproposals startwork '{ "proposal_id": 102, "dac_scope": "dacproposals"}' -p proposeracc3)
          expect(result.stderr).to include('ERR::STARTWORK_INSUFFICIENT_VOTES')
        end
      end
      context "delegated category with non-matching category" do
        before(:all) do
          run %(cleos push action dacproposals delegatecat '{"custodian": "custodian13", "category": 39, "delegatee_custodian": "custodian11", "dac_scope": "dacproposals"}' -p custodian13 -p dacauthority)
        end
        it do
          result = wrap_command %(cleos push action dacproposals startwork '{ "proposal_id": 102, "dac_scope": "dacproposals"}' -p proposeracc3)
          expect(result.stderr).to include('ERR::STARTWORK_INSUFFICIENT_VOTES')
        end
      end
      context "delegated category with matching category" do
        before(:all) do
          run %(cleos push action dacproposals delegatecat '{"custodian": "custodian13", "category": 31, "delegatee_custodian": "custodian11", "dac_scope": "dacproposals"}' -p custodian13 -p dacauthority)
          sleep 1
        end
        it do
          result = wrap_command %(cleos push action dacproposals startwork '{ "proposal_id": 102, "dac_scope": "dacproposals"}' -p proposeracc3)
          expect(result.stdout).to include('dacproposals <= dacproposals::startwork')
        end
      end
    end
    context "Created a proposal but still needing 2 votes for approval for complex case" do
      before(:all) do
        run %(cleos push action dacproposals createprop '{"proposer": "proposeracc3", "title": "startwork_title", "summary": "startwork_summary", "arbitrator": "arbitrator11", "pay_amount": {"quantity": "102.0000 EOS", "contract": "eosio.token"}, "content_hash": "asdfasdfasdfasdfasdfasdfasdffttt", "id": 103, "category": 32, "dac_scope": "dacproposals" }' -p proposeracc3)
        run %(cleos push action dacproposals voteprop '{"custodian": "custodian1", "proposal_id": 103, "vote": 1, "dac_scope": "dacproposals" }' -p custodian1 -p dacauthority)
        run %(cleos push action dacproposals voteprop '{"custodian": "custodian2", "proposal_id": 103, "vote": 1, "dac_scope": "dacproposals" }' -p custodian2 -p dacauthority)
        run %(cleos push action dacproposals voteprop '{"custodian": "custodian3", "proposal_id": 103, "vote": 1, "dac_scope": "dacproposals" }' -p custodian3 -p dacauthority)
        run %(cleos push action dacproposals voteprop '{"custodian": "custodian4", "proposal_id": 103, "vote": 1, "dac_scope": "dacproposals" }' -p custodian4 -p dacauthority)
        run %(cleos push action dacproposals voteprop '{"custodian": "custodian5", "proposal_id": 103, "vote": 1, "dac_scope": "dacproposals" }' -p custodian5 -p dacauthority)
      end
      context "delegated vote with matching proposal and category" do
        before(:all) do
          run %(cleos push action dacproposals delegatecat '{"custodian": "custodian11", "category": 32, "delegatee_custodian": "custodian5", "dac_scope": "dacproposals"}' -p custodian11 -p dacauthority)
          run %(cleos push action dacproposals delegatevote '{"custodian": "custodian13", "proposal_id": 103, "delegatee_custodian": "custodian5", "dac_scope": "dacproposals"}' -p custodian13 -p dacauthority)
        end
        it do
          result = wrap_command %(cleos push action dacproposals startwork '{ "proposal_id": 103, "dac_scope": "dacproposals"}' -p proposeracc3)
          expect(result.stdout).to include('dacproposals <= dacproposals::startwork')
        end
      end
    end
  end
  context "Read the propvotes table after finalizing" do
    it do
      result = wrap_command %(cleos get table dacproposals dacproposals propvotes --limit 40)
      expect(JSON.parse(result.stdout)).to eq JSON.parse <<~JSON
                        {
          "rows": [{
              "vote_id": 0,
              "voter": "custodian1",
              "proposal_id": 101,
              "category_id": null,
              "vote": 1,
              "delegatee": null,
              "comment_hash": null
            },{
              "vote_id": 1,
              "voter": "custodian2",
              "proposal_id": 101,
              "category_id": null,
              "vote": 1,
              "delegatee": null,
              "comment_hash": null
            },{
              "vote_id": 2,
              "voter": "custodian3",
              "proposal_id": 101,
              "category_id": null,
              "vote": 1,
              "delegatee": null,
              "comment_hash": null
            },{
              "vote_id": 3,
              "voter": "custodian4",
              "proposal_id": 101,
              "category_id": null,
              "vote": 1,
              "delegatee": null,
              "comment_hash": null
            },{
              "vote_id": 4,
              "voter": "custodian5",
              "proposal_id": 101,
              "category_id": null,
              "vote": 1,
              "delegatee": null,
              "comment_hash": null
            },{
              "vote_id": 5,
              "voter": "custodian11",
              "proposal_id": 101,
              "category_id": null,
              "vote": 1,
              "delegatee": null,
              "comment_hash": null
            },{
              "vote_id": 6,
              "voter": "custodian11",
              "proposal_id": null,
              "category_id": 33,
              "vote": null,
              "delegatee": "custodian5",
              "comment_hash": null
            },{
              "vote_id": 7,
              "voter": "custodian13",
              "proposal_id": null,
              "category_id": 32,
              "vote": null,
              "delegatee": "custodian11",
              "comment_hash": null
            },{
              "vote_id": 8,
              "voter": "custodian13",
              "proposal_id": null,
              "category_id": 33,
              "vote": null,
              "delegatee": "custodian11",
              "comment_hash": null
            },{
              "vote_id": 9,
              "voter": "custodian1",
              "proposal_id": 102,
              "category_id": null,
              "vote": 1,
              "delegatee": null,
              "comment_hash": null
            },{
              "vote_id": 10,
              "voter": "custodian2",
              "proposal_id": 102,
              "category_id": null,
              "vote": 1,
              "delegatee": null,
              "comment_hash": null
            },{
              "vote_id": 11,
              "voter": "custodian3",
              "proposal_id": 102,
              "category_id": null,
              "vote": 1,
              "delegatee": null,
              "comment_hash": null
            },{
              "vote_id": 12,
              "voter": "custodian4",
              "proposal_id": 102,
              "category_id": null,
              "vote": 1,
              "delegatee": null,
              "comment_hash": null
            },{
              "vote_id": 13,
              "voter": "custodian5",
              "proposal_id": 102,
              "category_id": null,
              "vote": 1,
              "delegatee": null,
              "comment_hash": null
            },{
              "vote_id": 14,
              "voter": "custodian11",
              "proposal_id": 102,
              "category_id": null,
              "vote": 1,
              "delegatee": null,
              "comment_hash": null
            },{
              "vote_id": 15,
              "voter": "custodian11",
              "proposal_id": null,
              "category_id": 31,
              "vote": null,
              "delegatee": "custodian5",
              "comment_hash": null
            },{
              "vote_id": 16,
              "voter": "custodian13",
              "proposal_id": null,
              "category_id": 39,
              "vote": null,
              "delegatee": "custodian11",
              "comment_hash": null
            },{
              "vote_id": 17,
              "voter": "custodian13",
              "proposal_id": null,
              "category_id": 31,
              "vote": null,
              "delegatee": "custodian11",
              "comment_hash": null
            },{
              "vote_id": 18,
              "voter": "custodian1",
              "proposal_id": 103,
              "category_id": null,
              "vote": 1,
              "delegatee": null,
              "comment_hash": null
            },{
              "vote_id": 19,
              "voter": "custodian2",
              "proposal_id": 103,
              "category_id": null,
              "vote": 1,
              "delegatee": null,
              "comment_hash": null
            },{
              "vote_id": 20,
              "voter": "custodian3",
              "proposal_id": 103,
              "category_id": null,
              "vote": 1,
              "delegatee": null,
              "comment_hash": null
            },{
              "vote_id": 21,
              "voter": "custodian4",
              "proposal_id": 103,
              "category_id": null,
              "vote": 1,
              "delegatee": null,
              "comment_hash": null
            },{
              "vote_id": 22,
              "voter": "custodian5",
              "proposal_id": 103,
              "category_id": null,
              "vote": 1,
              "delegatee": null,
              "comment_hash": null
            },{
              "vote_id": 23,
              "voter": "custodian11",
              "proposal_id": null,
              "category_id": 32,
              "vote": null,
              "delegatee": "custodian5",
              "comment_hash": null
            },{
              "vote_id": 24,
              "voter": "custodian13",
              "proposal_id": 103,
              "category_id": null,
              "vote": null,
              "delegatee": "custodian5",
              "comment_hash": null
            }
          ],
          "more": false
        }
      JSON
    end
  end
  context "undelegate vote" do
    context "with wrong auth" do
      it do
        result = wrap_command %(cleos push action dacproposals undelegateca '{ "custodian": "custodian13", "category": 32, "dac_scope": "dacproposals"}' -p custodian11)
        expect(result.stderr).to include('missing authority of custodian13')
      end
    end
    context "with correct auth" do
      it do
        result = wrap_command %(cleos push action dacproposals undelegateca '{ "custodian": "custodian13", "category": 32, "dac_scope": "dacproposals"}' -p custodian13)
        expect(result.stdout).to include('dacproposals <= dacproposals::undelegateca')
      end
    end
  end
  context "Read the propvotes table after finalizing" do
    it do
      result = wrap_command %(cleos get table dacproposals dacproposals propvotes --limit 40)
      expect(JSON.parse(result.stdout)).to eq JSON.parse <<~JSON
                        {
          "rows": [{
              "vote_id": 0,
              "voter": "custodian1",
              "proposal_id": 101,
              "category_id": null,
              "vote": 1,
              "delegatee": null,
              "comment_hash": null
            },{
              "vote_id": 1,
              "voter": "custodian2",
              "proposal_id": 101,
              "category_id": null,
              "vote": 1,
              "delegatee": null,
              "comment_hash": null
            },{
              "vote_id": 2,
              "voter": "custodian3",
              "proposal_id": 101,
              "category_id": null,
              "vote": 1,
              "delegatee": null,
              "comment_hash": null
            },{
              "vote_id": 3,
              "voter": "custodian4",
              "proposal_id": 101,
              "category_id": null,
              "vote": 1,
              "delegatee": null,
              "comment_hash": null
            },{
              "vote_id": 4,
              "voter": "custodian5",
              "proposal_id": 101,
              "category_id": null,
              "vote": 1,
              "delegatee": null,
              "comment_hash": null
            },{
              "vote_id": 5,
              "voter": "custodian11",
              "proposal_id": 101,
              "category_id": null,
              "vote": 1,
              "delegatee": null,
              "comment_hash": null
            },{
              "vote_id": 6,
              "voter": "custodian11",
              "proposal_id": null,
              "category_id": 33,
              "vote": null,
              "delegatee": "custodian5",
              "comment_hash": null
            },{
              "vote_id": 8,
              "voter": "custodian13",
              "proposal_id": null,
              "category_id": 33,
              "vote": null,
              "delegatee": "custodian11",
              "comment_hash": null
            },{
              "vote_id": 9,
              "voter": "custodian1",
              "proposal_id": 102,
              "category_id": null,
              "vote": 1,
              "delegatee": null,
              "comment_hash": null
            },{
              "vote_id": 10,
              "voter": "custodian2",
              "proposal_id": 102,
              "category_id": null,
              "vote": 1,
              "delegatee": null,
              "comment_hash": null
            },{
              "vote_id": 11,
              "voter": "custodian3",
              "proposal_id": 102,
              "category_id": null,
              "vote": 1,
              "delegatee": null,
              "comment_hash": null
            },{
              "vote_id": 12,
              "voter": "custodian4",
              "proposal_id": 102,
              "category_id": null,
              "vote": 1,
              "delegatee": null,
              "comment_hash": null
            },{
              "vote_id": 13,
              "voter": "custodian5",
              "proposal_id": 102,
              "category_id": null,
              "vote": 1,
              "delegatee": null,
              "comment_hash": null
            },{
              "vote_id": 14,
              "voter": "custodian11",
              "proposal_id": 102,
              "category_id": null,
              "vote": 1,
              "delegatee": null,
              "comment_hash": null
            },{
              "vote_id": 15,
              "voter": "custodian11",
              "proposal_id": null,
              "category_id": 31,
              "vote": null,
              "delegatee": "custodian5",
              "comment_hash": null
            },{
              "vote_id": 16,
              "voter": "custodian13",
              "proposal_id": null,
              "category_id": 39,
              "vote": null,
              "delegatee": "custodian11",
              "comment_hash": null
            },{
              "vote_id": 17,
              "voter": "custodian13",
              "proposal_id": null,
              "category_id": 31,
              "vote": null,
              "delegatee": "custodian11",
              "comment_hash": null
            },{
              "vote_id": 18,
              "voter": "custodian1",
              "proposal_id": 103,
              "category_id": null,
              "vote": 1,
              "delegatee": null,
              "comment_hash": null
            },{
              "vote_id": 19,
              "voter": "custodian2",
              "proposal_id": 103,
              "category_id": null,
              "vote": 1,
              "delegatee": null,
              "comment_hash": null
            },{
              "vote_id": 20,
              "voter": "custodian3",
              "proposal_id": 103,
              "category_id": null,
              "vote": 1,
              "delegatee": null,
              "comment_hash": null
            },{
              "vote_id": 21,
              "voter": "custodian4",
              "proposal_id": 103,
              "category_id": null,
              "vote": 1,
              "delegatee": null,
              "comment_hash": null
            },{
              "vote_id": 22,
              "voter": "custodian5",
              "proposal_id": 103,
              "category_id": null,
              "vote": 1,
              "delegatee": null,
              "comment_hash": null
            },{
              "vote_id": 23,
              "voter": "custodian11",
              "proposal_id": null,
              "category_id": 32,
              "vote": null,
              "delegatee": "custodian5",
              "comment_hash": null
            },{
              "vote_id": 24,
              "voter": "custodian13",
              "proposal_id": 103,
              "category_id": null,
              "vote": null,
              "delegatee": "custodian5",
              "comment_hash": null
            }
          ],
          "more": false
        }
      JSON
    end
  end
end
