require_relative '../../_test_helpers/CommonTestHelpers'

# Configure the initial state for the contracts for elements that are assumed to work from other contracts already.
def configure_contracts_for_tests

  run %(cleos system newaccount --stake-cpu "10.0000 EOS" --stake-net "10.0000 EOS" --transfer --buy-ram-kbytes 2024 eosio dacowner #{CONTRACT_PUBLIC_KEY} #{CONTRACT_PUBLIC_KEY})

  run %(cleos push action dacdirectory regdac '{"owner": "dacowner", "dac_name": "escrowdac", "dac_symbol": "4,EOSDAC", "title": "Dac Title", "refs": [], "accounts": [[2,"daccustodian"], [5,"dacescrow"], [7,"dacescrow"], [0, "dacowner"], [4, "eosdactokens"], [1, "eosdacthedac"] ]}' -p dacowner)
  run %(cleos push action eosdactokens create '{ "issuer": "dacowner", "maximum_supply": "100000.0000 EOSDAC", "transfer_locked": false}' -p dacowner)

  run %(cleos push action eosdactokens issue '{ "to": "dacowner", "quantity": "78337.0000 EOSDAC", "memo": "Initial amount of tokens for you."}' -p dacowner)
  run %(cleos push action eosio.token issue '{ "to": "eosdacthedac", "quantity": "100000.0000 EOS", "memo": "Initial EOS amount."}' -p eosio)

  run %(cleos push action daccustodian updateconfig '{"newconfig": { "lockupasset": "10.0000 EOSDAC", "maxvotes": 5, "periodlength": 604800 , "numelected": 12, "should_pay_via_service_provider": 1, "auththresh": 3, "initial_vote_quorum_percent": 15, "vote_quorum_percent": 10, "auth_threshold_high": 11, "auth_threshold_mid": 7, "auth_threshold_low": 3, "lockup_release_time_delay": 10, "requested_pay_max": "450.0000 EOS"}, "dac_scope": "escrowdac"}' -p dacowner)

  run %(cleos set account permission dacescrow active '{"threshold": 1,"keys": [{"key": "#{CONTRACT_PUBLIC_KEY}","weight": 1}],"accounts": [{"permission":{"actor":"dacescrow","permission":"eosio.code"},"weight":1}]}' owner -p dacescrow)

  # Ensure terms are registered in the token contract
  run %(cleos push action eosdactokens newmemtermse '{ "terms": "normallegalterms", "hash": "New Latest terms", "dac_id": "escrowdac"}' -p dacowner)

  #create users

  seed_dac_account("sender1", issue: "100.0000 EOSDAC", memberreg: "New Latest terms", dac_scope: "escrowdac", dac_owner: "dacowner")
  seed_dac_account("sender2", issue: "100.0000 EOSDAC", memberreg: "New Latest terms", dac_scope: "escrowdac", dac_owner: "dacowner")
  seed_dac_account("sender3", issue: "100.0000 EOSDAC", memberreg: "New Latest terms", dac_scope: "escrowdac", dac_owner: "dacowner")
  seed_dac_account("sender4", issue: "100.0000 EOSDAC", memberreg: "New Latest terms", dac_scope: "escrowdac", dac_owner: "dacowner")
  seed_dac_account("receiver1", issue: "100.0000 EOSDAC", memberreg: "New Latest terms", dac_scope: "escrowdac", dac_owner: "dacowner")
  seed_dac_account("arb1", issue: "100.0000 EOSDAC", memberreg: "New Latest terms", dac_scope: "escrowdac", dac_owner: "dacowner")
  seed_dac_account("arb2", issue: "100.0000 EOSDAC", memberreg: "New Latest terms", dac_scope: "escrowdac", dac_owner: "dacowner")

  run %(cleos push action eosio.token issue '{ "to": "sender1", "quantity": "1000.0000 EOS", "memo": "Initial EOS amount."}' -p eosio)
  run %(cleos push action eosio.token issue '{ "to": "sender2", "quantity": "1000.0000 EOS", "memo": "Initial EOS amount."}' -p eosio)
  run %(cleos push action eosio.token issue '{ "to": "sender3", "quantity": "1000.0000 EOS", "memo": "Initial EOS amount."}' -p eosio)
  run %(cleos push action eosio.token issue '{ "to": "sender4", "quantity": "1000.0000 EOS", "memo": "Initial EOS amount."}' -p eosio)
end

describe "dacescrow" do
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

  context "Using internal key" do

    describe "init" do
      context "Without valid permission" do
        context "with valid and registered member" do
          it do
            result = wrap_command %(cleos push action dacescrow init '{"sender": "sender1", "receiver": "receiver1", "arb": "arb1", "expires": "2019-01-20T23:21:43.528", "memo": "some memo", "ext_reference": null}' -p sender2)
            expect(result.stderr).to include('missing authority of sender1')
          end
        end
      end

      context "with valid auth" do
        it do
          result = wrap_command %(cleos push action dacescrow init '{"sender": "sender1", "receiver": "receiver1", "arb": "arb1", "expires": "2019-01-20T23:21:43.528", "memo": "some memo", "ext_reference": null}' -p sender1)
          expect(result.stdout).to include('dacescrow <= dacescrow::init')
        end
      end
      context "with an existing escrow entry" do
        it do
          result = wrap_command %(cleos push action dacescrow init '{"sender": "sender1", "receiver": "receiver1", "arb": "arb1", "expires": "2019-01-20T23:21:43.528", "memo": "some other memo", "ext_reference": null}' -p sender1)
          expect(result.stderr).to include('You already have an empty escrow.  Either fill it or delete it')
        end
      end
      context "Read the escrow table after init" do
        it do
          result = wrap_command %(cleos get table dacescrow dacescrow escrows)
          expect(JSON.parse(result.stdout)).to eq JSON.parse <<~JSON
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
        it do
          result = wrap_command %(cleos push action eosio.token transfer '{"from": "sender1", "to": "dacescrow", "quantity": "5.0000 EOS", "memo": "here is a memo" }' -p sender2)
          expect(result.stderr).to include('missing authority of sender1')
        end
      end
      context "without a valid escrow" do
        it do
          result = wrap_command %(cleos push action eosio.token transfer '{"from": "sender2", "to": "dacescrow", "quantity": "5.0000 EOS", "memo": "here is a memo" }' -p sender2)
          expect(result.stderr).to include('Could not find existing escrow to deposit to, transfer cancelled')
        end
      end
      context "balance should not have reduced from 1000.0000 EOS" do
        it do
          result = wrap_command %(cleos get currency balance eosio.token sender1 EOS)
          expect(result.stdout).to eq <<~JSON
            1000.0000 EOS
          JSON
        end
      end
      context "with a valid escrow" do
        it do
          result = wrap_command %(cleos push action eosio.token transfer '{"from": "sender1", "to": "dacescrow", "quantity": "5.0000 EOS", "memo": "here is a memo" }' -p sender1)
          expect(result.stdout).to include('dacescrow <= eosio.token::transfer')
        end
      end
      context "balance should have reduced to 995.0000 EOS" do
        it do
          result = wrap_command %(cleos get currency balance eosio.token sender1 EOS)
          expect(result.stdout).to eq <<~JSON
            995.0000 EOS
          JSON
        end
      end
      context "balance of dacescrow should have increased by 5.0000 EOS" do
        it do
          result = wrap_command %(cleos get currency balance eosio.token dacescrow EOS)
          expect(result.stdout).to eq <<~JSON
            5.0000 EOS
          JSON
        end
      end
      context "Read the escrow table after init" do
        it do
          result = wrap_command %(cleos get table dacescrow dacescrow escrows)
          expect(JSON.parse(result.stdout)).to eq JSON.parse <<~JSON
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
        it do
          result = wrap_command %(cleos push action dacescrow approve '{ "key": 0, "approver": "arb1"}' -p sender2)
          expect(result.stderr).to include('missing authority of arb1')
        end
      end
      context "with valid auth" do
        context "with invalid escrow key" do
          it do
            result = wrap_command %(cleos push action dacescrow approve '{ "key": 4, "approver": "arb1"}' -p arb1)
            expect(result.stderr).to include('Could not find escrow with that index')
          end
        end
        context "with valid escrow id" do
          context "before a corresponding transfer has been made" do
            before(:all) do
              run %(cleos push action dacescrow init '{"sender": "sender2", "receiver": "receiver1", "arb": "arb1", "expires": "2019-01-20T23:21:43.528", "memo": "another empty escrow", "ext_reference": null}' -p sender2)
            end
            it do
              result = wrap_command %(cleos push action dacescrow approve '{ "key": 1, "approver": "arb1"}' -p arb1)
              expect(result.stderr).to include('This has not been initialized with a transfer')
            end
          end
          context "with a valid escrow for approval" do
            context "with uninvolved approver" do
              it do
                result = wrap_command %(cleos push action dacescrow approve '{ "key": 0, "approver": "arb2"}' -p arb2)
                expect(result.stderr).to include('You are not allowed to approve this escrow.')
              end
            end
            context "with involved approver" do
              it do
                result = wrap_command %(cleos push action dacescrow approve '{ "key": 0, "approver": "arb1"}' -p arb1)
                expect(result.stdout).to include('dacescrow <= dacescrow::approve')
              end
            end
            context "with already approved escrow" do
              before(:all) {sleep 1}
              it do
                result = wrap_command %(cleos push action dacescrow approve '{ "key": 0, "approver": "arb1", "none": "anything"}' -p arb1)
                expect(result.stderr).to include('You have already approved this escrow')
              end
            end

          end
          context "Read the escrow table after approve" do
            it do
              result = wrap_command %(cleos get table dacescrow dacescrow escrows)
              expect(JSON.parse(result.stdout)).to eq JSON.parse <<~JSON
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
        it do
          result = wrap_command %(cleos push action dacescrow unapprove '{ "key": 0, "unapprover": "arb1"}' -p sender2)
          expect(result.stderr).to include('missing authority of arb1')
        end
      end
      context "with valid auth" do
        context "with invalid escrow key" do
          it do
            result = wrap_command %(cleos push action dacescrow unapprove '{ "key": 4, "unapprover": "arb1"}' -p arb1)
            expect(result.stderr).to include('Could not find escrow with that index')
          end
        end
        context "with valid escrow id" do
          context "before the escrow has been previously approved" do
            it do
              result = wrap_command %(cleos push action dacescrow unapprove '{ "key": 1, "unapprover": "arb1"}' -p arb1)
              expect(result.stderr).to include('You have NOT approved this escrow')
            end
          end
          context "with a valid escrow for unapproval" do
            context "with uninvolved approver" do
              it do
                result = wrap_command %(cleos push action dacescrow unapprove '{ "key": 0, "unapprover": "arb2"}' -p arb2)
                expect(result.stderr).to include('You have NOT approved this escrow')
              end
            end
            context "with involved approver" do
              before(:all) do
                run %(cleos push action dacescrow approve '{ "key": 0, "approver": "sender1"}' -p sender1)
              end
              it do
                result = wrap_command %(cleos push action dacescrow unapprove '{ "key": 0, "unapprover": "arb1"}' -p arb1)
                expect(result.stdout).to include('dacescrow <= dacescrow::unapprove')
              end
            end
            context "with already approved escrow" do
              before(:all) {sleep 1}
              it do
                result = wrap_command %(cleos push action dacescrow unapprove '{ "key": 0, "unapprover": "arb1"}' -p arb1)
                expect(result.stderr).to include('You have NOT approved this escrow')
              end
            end
          end
          context "Read the escrow table after unapprove" do
            it do
              result = wrap_command %(cleos get table dacescrow dacescrow escrows)
              expect(JSON.parse(result.stdout)).to eq JSON.parse <<~JSON
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
        it do
          result = wrap_command %(cleos push action dacescrow claim '{ "key": 0}' -p sender2)
          expect(result.stderr).to include('Missing required authority')
        end
      end
      context "with valid auth" do
        context "with invalid escrow key" do
          it do
            result = wrap_command %(cleos push action dacescrow claim '{ "key": 4}' -p arb1)
            expect(result.stderr).to include('Could not find escrow with that index')
          end
        end
        context "with valid escrow id" do
          context "before a corresponding transfer has been made" do
            it do
              result = wrap_command %(cleos push action dacescrow claim '{ "key": 1 }' -p receiver1)
              expect(result.stderr).to include('This has not been initialized with a transfer')
            end
          end
          context "without enough approvals for a claim" do
            before(:all) do
              run %(cleos push action dacescrow unapprove '{ "key": 0, "unapprover": "sender1"}' -p sender1)
            end
            it do
              result = wrap_command %(cleos push action dacescrow claim '{ "key": 0 }' -p receiver1)
              expect(result.stderr).to include('This escrow has not received the required approvals to claim')
            end
          end
          context "with enough approvals" do
            before(:all) do
              run %(cleos push action dacescrow approve '{ "key": 0, "approver": "arb1"}' -p arb1)
            end
            it do
              result = wrap_command %(cleos push action dacescrow claim '{ "key": 0 }' -p receiver1)
              expect(result.stdout).to include('dacescrow <= dacescrow::claim')
            end
          end
          context "with already approved escrow" do
            before(:all) {sleep 1}
            it do
              result = wrap_command %(cleos push action dacescrow claim '{ "key": 0}' -p receiver1)
              expect(result.stderr).to include('Could not find escrow with that index')
            end
          end
        end
      end
      context "Read the escrow table after approve" do
        it do
          result = wrap_command %(cleos get table dacescrow dacescrow escrows)
          expect(JSON.parse(result.stdout)).to eq JSON.parse <<~JSON
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
        it do
          result = wrap_command %(cleos push action dacescrow cancel '{ "key": 1}' -p sender1)
          expect(result.stderr).to include('missing authority of sender2')
        end
      end
      context "with valid auth" do
        context "with invalid escrow key" do
          it do
            result = wrap_command %(cleos push action dacescrow cancel '{ "key": 4}' -p sender1)
            expect(result.stderr).to include('Could not find escrow with that index')
          end
        end
        context "with valid escrow id" do
          context "after a transfer has been made" do
            before(:all) do
              run %(cleos push action eosio.token transfer '{"from": "sender2", "to": "dacescrow", "quantity": "6.0000 EOS", "memo": "here is a second memo" }' -p sender2)
            end
            it do
              result = wrap_command %(cleos push action dacescrow cancel '{ "key": 1}' -p sender2)
              expect(result.stderr).to include('Amount is not zero, this escrow is locked down')
            end
          end
          context "before a transfer has been made" do
            before(:all) do
              run %(cleos push action dacescrow init '{"sender": "sender1", "receiver": "receiver1", "arb": "arb2", "expires": "2019-01-20T23:21:43.528", "memo": "third memo", "ext_reference": null}' -p sender1)
            end
            it do
              result = wrap_command %(cleos push action dacescrow cancel '{ "key": 2}' -p sender1)
              expect(result.stdout).to include('dacescrow <= dacescrow::cancel')
            end
          end
          context "Read the escrow table after approve" do
            it do
              result = wrap_command %(cleos get table dacescrow dacescrow escrows)
              expect(JSON.parse(result.stdout)).to eq JSON.parse <<~JSON
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
        it do
          result = wrap_command %(cleos push action dacescrow refund '{ "key": 4}' -p arb1)
          expect(result.stderr).to include('Could not find escrow with that index')
        end
      end
      context "with valid escrow id" do
        context "with invalid auth" do
          it do
            result = wrap_command %(cleos push action dacescrow refund '{ "key": 1}' -p arb1)
            expect(result.stderr).to include('missing authority of sender2')
          end
        end
        context "with valid auth" do
          context "before a corresponding transfer has been made" do
            before(:all) do
              run %(cleos push action dacescrow init '{"sender": "sender1", "receiver": "receiver1", "arb": "arb2", "expires": "2019-01-20T23:21:43.528", "memo": "some empty memo", "ext_reference": null}' -p sender1)
            end
            it do
              result = wrap_command %(cleos push action dacescrow refund '{ "key": 2 }' -p sender1)
              expect(result.stderr).to include('This has not been initialized with a transfer')
            end
          end
          context "after a transfer has been made" do
            context "before the escrow has expired" do
              before(:all) do
                run %(cleos push action dacescrow init '{"sender": "sender4", "receiver": "receiver1", "arb": "arb2", "expires": "2035-01-20T23:21:43.528", "memo": "distant future escrow", "ext_reference": null}' -p sender4)
                run %(cleos push action eosio.token transfer '{"from": "sender4", "to": "dacescrow", "quantity": "5.0000 EOS", "memo": "here is a memo" }' -p sender4)
                run %(cleos push action dacescrow approve '{ "key": 3, "approver": "sender4"}' -p sender4)
              end
              it do
                result = wrap_command %(cleos push action dacescrow refund '{ "key": 3 }' -p sender4)
                expect(result.stderr).to include('Escrow has not expired')
              end
            end
          end
          context "balance of escrow should be set before preparing the escrow with a known balance starting point" do
            it do
              result = wrap_command %(cleos get currency balance eosio.token dacescrow EOS)
              expect(result.stdout).to eq <<~JSON
                11.0000 EOS
              JSON
            end
          end
          context "balance of escrow should be set before preparing the escrow with a known balance starting point" do
            it do
              result = wrap_command %(cleos get currency balance eosio.token sender3 EOS)
              expect(result.stdout).to eq <<~JSON
                1000.0000 EOS
              JSON
            end
          end
          context "after the escrow has expired" do
            before(:all) do
              run %(cleos push action dacescrow init '{"sender": "sender3", "receiver": "receiver1", "arb": "arb2", "expires": "2019-01-19T23:21:43.528", "memo": "some expired memo", "ext_reference": null}' -p sender3)
              run %(cleos push action eosio.token transfer '{"from": "sender3", "to": "dacescrow", "quantity": "5.0000 EOS", "memo": "here is a memo" }' -p sender3)
              run %(cleos push action dacescrow approve '{ "key": 4, "approver": "sender3"}' -p sender3)
            end
            context "balance of dacescrow should have adjusted after preparing the escrow" do
              it do
                result = wrap_command %(cleos get currency balance eosio.token dacescrow EOS)
                expect(result.stdout).to eq <<~JSON
                  16.0000 EOS
                JSON
              end
            end
            context "balance of sender3 should have adjusted after preparing the escrow" do
              it do
                result = wrap_command %(cleos get currency balance eosio.token sender3 EOS)
                expect(result.stdout).to eq <<~JSON
                  995.0000 EOS
                JSON
              end
            end
            context "after refund succeeds" do
              it do
                result = wrap_command %(cleos push action dacescrow refund '{ "key": 4 }' -p sender3)
                expect(result.stdout).to include('dacescrow <= dacescrow::refund')
              end
            end
            context "balance of dacescrow should have changed back after refunding an escrow" do
              it do
                result = wrap_command %(cleos get currency balance eosio.token dacescrow EOS)
                expect(result.stdout).to eq <<~JSON
                  11.0000 EOS
                JSON
              end
            end
            context "balance of sender3 should have changed back after refunding an escrow" do
              it do
                result = wrap_command %(cleos get currency balance eosio.token sender3 EOS)
                expect(result.stdout).to eq <<~JSON
                  1000.0000 EOS
                JSON
              end
            end
          end
        end
      end
      context "Read the escrow table after refund" do
        it do
          result = wrap_command %(cleos get table dacescrow dacescrow escrows)
          expect(JSON.parse(result.stdout)).to eq JSON.parse <<~JSON
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
        run %(cleos push action dacescrow clean '{}' -p dacescrow)
      end
      context "Without valid permission" do
        context "with valid and registered member" do
          it do
            result = wrap_command %(cleos push action dacescrow init '{"sender": "sender1", "receiver": "receiver1", "arb": "arb1", "expires": "2019-01-20T23:21:43.528", "memo": "some memo", "ext_reference": 23}' -p sender2)
            expect(result.stderr).to include('missing authority of sender1')
          end
        end
      end

      context "with valid auth" do
        it do
          result = wrap_command %(cleos push action dacescrow init '{"sender": "sender1", "receiver": "receiver1", "arb": "arb1", "expires": "2019-01-20T23:21:43.528", "memo": "some memo", "ext_reference": 23}' -p sender1)
          expect(result.stdout).to include('dacescrow <= dacescrow::init')
        end
      end
      context "with an existing escrow entry" do
        it do
          result = wrap_command %(cleos push action dacescrow init '{"sender": "sender1", "receiver": "receiver1", "arb": "arb1", "expires": "2019-01-20T23:21:43.528", "memo": "some other memo", "ext_reference": 23}' -p sender1)
          expect(result.stderr).to include('You already have an empty escrow.  Either fill it or delete it')
        end
      end
      context "Read the escrow table after init" do
        it do
          result = wrap_command %(cleos get table dacescrow dacescrow escrows)
          expect(JSON.parse(result.stdout)).to eq JSON.parse <<~JSON
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
        it do
          result = wrap_command %(cleos push action eosio.token transfer '{"from": "sender1", "to": "dacescrow", "quantity": "5.0000 EOS", "memo": "here is a memo" }' -p sender2)
          expect(result.stderr).to include('missing authority of sender1')
        end
      end
      context "without a valid escrow" do
        it do
          result = wrap_command %(cleos push action eosio.token transfer '{"from": "sender2", "to": "dacescrow", "quantity": "5.0000 EOS", "memo": "here is a memo" }' -p sender2)
          expect(result.stderr).to include('Could not find existing escrow to deposit to, transfer cancelled')
        end
      end
      context "balance should not have reduced from 1000.0000 EOS" do
        it do
          result = wrap_command %(cleos get currency balance eosio.token sender1 EOS)
          expect(result.stdout).to eq <<~JSON
            1000.0000 EOS
          JSON
        end
      end
      context "with a valid escrow" do
        it do
          result = wrap_command %(cleos push action eosio.token transfer '{"from": "sender1", "to": "dacescrow", "quantity": "5.0000 EOS", "memo": "here is a memo" }' -p sender1)
          expect(result.stdout).to include('dacescrow <= eosio.token::transfer')
        end
      end
      context "balance should have reduced to 995.0000 EOS" do
        it do
          result = wrap_command %(cleos get currency balance eosio.token sender1 EOS)
          expect(result.stdout).to eq <<~JSON
            995.0000 EOS
          JSON
        end
      end
      context "balance of dacescrow should have increased by 5.0000 EOS" do
        it do
          result = wrap_command %(cleos get currency balance eosio.token dacescrow EOS)
          expect(result.stdout).to eq <<~JSON
            16.0000 EOS
          JSON
        end
      end
      context "Read the escrow table after init" do
        it do
          result = wrap_command %(cleos get table dacescrow dacescrow escrows)
          expect(JSON.parse(result.stdout)).to eq JSON.parse <<~JSON
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
        it do
          result = wrap_command %(cleos push action dacescrow approveext '{ "ext_key": 23, "approver": "arb1"}' -p sender2)
          expect(result.stderr).to include('missing authority of arb1')
        end
      end
      context "with valid auth" do
        context "with invalid escrow key" do
          it do
            result = wrap_command %(cleos push action dacescrow approveext '{ "ext_key": 45, "approver": "arb1"}' -p arb1)
            expect(result.stderr).to include('No escrow exists for this external key.')
          end
        end
        context "with valid escrow id" do
          context "before a corresponding transfer has been made" do
            before(:all) do
              run %(cleos push action dacescrow init '{"sender": "sender2", "receiver": "receiver1", "arb": "arb1", "expires": "2019-01-20T23:21:43.528", "memo": "another empty escrow", "ext_reference": "666"}' -p sender2)
            end
            it do
              result = wrap_command %(cleos push action dacescrow approveext '{ "ext_key": 666, "approver": "arb1"}' -p arb1)
              expect(result.stderr).to include('This has not been initialized with a transfer')
            end
          end
          context "with a valid escrow for approval" do
            context "with uninvolved approver" do
              it do
                result = wrap_command %(cleos push action dacescrow approveext '{ "ext_key": 23, "approver": "arb2"}' -p arb2)
                expect(result.stderr).to include('You are not allowed to approve this escrow.')
              end
            end
            context "with involved approver" do
              it do
                result = wrap_command %(cleos push action dacescrow approveext '{ "ext_key": 23, "approver": "arb1"}' -p arb1)
                expect(result.stdout).to include('dacescrow <= dacescrow::approve')
              end
            end
            context "with already approved escrow" do
              before(:all) {sleep 1}
              it do
                result = wrap_command %(cleos push action dacescrow approveext '{ "ext_key": 23, "approver": "arb1", "none": "anything"}' -p arb1)
                expect(result.stderr).to include('You have already approved this escrow')
              end
            end
          end
          context "Read the escrow table after approve" do
            it do
              result = wrap_command %(cleos get table dacescrow dacescrow escrows)
              expect(JSON.parse(result.stdout)).to eq JSON.parse <<~JSON
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
        it do
          result = wrap_command %(cleos push action dacescrow unapproveext '{ "ext_key": 23, "unapprover": "arb1"}' -p sender2)
          expect(result.stderr).to include('missing authority of arb1')
        end
      end
      context "with valid auth" do
        context "with invalid escrow key" do
          it do
            result = wrap_command %(cleos push action dacescrow unapproveext '{ "ext_key": 45, "unapprover": "arb1"}' -p arb1)
            expect(result.stderr).to include('No escrow exists for this external key.')
          end
        end
        context "with valid escrow id" do
          context "before the escrow has been previously approved" do
            it do
              result = wrap_command %(cleos push action dacescrow unapproveext '{ "ext_key": 666, "unapprover": "arb1"}' -p arb1)
              expect(result.stderr).to include('You have NOT approved this escrow')
            end
          end
          context "with a valid escrow for unapproval" do
            context "with uninvolved approver" do
              it do
                result = wrap_command %(cleos push action dacescrow unapproveext '{ "ext_key": 23, "unapprover": "arb2"}' -p arb2)
                expect(result.stderr).to include('You have NOT approved this escrow')
              end
            end
            context "with involved approver" do
              before(:all) do
                run %(cleos push action dacescrow approveext '{ "ext_key": 23, "approver": "sender1"}' -p sender1)
              end
              it do
                result = wrap_command %(cleos push action dacescrow unapproveext '{ "ext_key": 23, "unapprover": "arb1"}' -p arb1)
                expect(result.stdout).to include('dacescrow <= dacescrow::unapprove')
              end
            end
            context "with already unapproved escrow" do
              before(:all) {sleep 1}
              it do
                result = wrap_command %(cleos push action dacescrow unapproveext '{ "ext_key": 23, "unapprover": "arb1"}' -p arb1)
                expect(result.stderr).to include('You have NOT approved this escrow')
              end
            end
          end
          context "Read the escrow table after unapproveext" do
            it do
              result = wrap_command %(cleos get table dacescrow dacescrow escrows)
              expect(JSON.parse(result.stdout)).to eq JSON.parse <<~JSON
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
        it do
          result = wrap_command %(cleos push action dacescrow claimext '{ "ext_key": 23}' -p sender2)
          expect(result.stderr).to include('Missing required authority')
        end
      end
      context "with valid auth" do
        context "with invalid escrow key" do
          it do
            result = wrap_command %(cleos push action dacescrow claimext '{ "ext_key": 45}' -p arb1)
            expect(result.stderr).to include('No escrow exists for this external key.')
          end
        end
        context "with valid escrow id" do
          context "before a corresponding transfer has been made" do
            it do
              result = wrap_command %(cleos push action dacescrow claimext '{ "ext_key": 666 }' -p receiver1)
              expect(result.stderr).to include('This has not been initialized with a transfer')
            end
          end
          context "with enough approvals" do
            before(:all) do
              run %(cleos push action dacescrow approveext '{ "ext_key": 23, "approver": "arb1"}' -p arb1)
            end
            it do
              result = wrap_command %(cleos push action dacescrow claimext '{ "ext_key": 23 }' -p receiver1)
              expect(result.stdout).to include('dacescrow <= dacescrow::claim')
            end
          end
          context "with already claimed escrow" do
            before(:all) {sleep 1}
            it do
              result = wrap_command %(cleos push action dacescrow claimext '{ "ext_key": 23}' -p receiver1)
              expect(result.stderr).to include('No escrow exists for this external key.')
            end
          end
        end
      end
      context "Read the escrow table after approve" do
        it do
          result = wrap_command %(cleos get table dacescrow dacescrow escrows)
          expect(JSON.parse(result.stdout)).to eq JSON.parse <<~JSON
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
        it do
          result = wrap_command %(cleos push action dacescrow cancelext '{ "ext_key": 666}' -p sender1)
          expect(result.stderr).to include('missing authority of sender2')
        end
      end
      context "with valid auth" do
        context "with invalid escrow key" do
          it do
            result = wrap_command %(cleos push action dacescrow cancelext '{ "ext_key": 45}' -p sender1)
            expect(result.stderr).to include('No escrow exists for this external key.')
          end
        end
        context "with valid escrow id" do
          context "after a transfer has been made" do
            before(:all) do
              run %(cleos push action eosio.token transfer '{"from": "sender2", "to": "dacescrow", "quantity": "6.0000 EOS", "memo": "here is a second memo" }' -p sender2)
            end
            it do
              result = wrap_command %(cleos push action dacescrow cancelext '{ "ext_key": 666}' -p sender2)
              expect(result.stderr).to include('Amount is not zero, this escrow is locked down')
            end
          end
          context "before a transfer has been made" do
            before(:all) do
              run %(cleos push action dacescrow init '{"sender": "sender1", "receiver": "receiver1", "arb": "arb2", "expires": "2019-01-20T23:21:43.528", "memo": "third memo", "ext_reference": 777}' -p sender1)
            end
            it do
              result = wrap_command %(cleos push action dacescrow cancelext '{ "ext_key": 777}' -p sender1)
              expect(result.stdout).to include('dacescrow <= dacescrow::cancel')
            end
          end
          context "Read the escrow table after approve" do
            it do
              result = wrap_command %(cleos get table dacescrow dacescrow escrows)
              expect(JSON.parse(result.stdout)).to eq JSON.parse <<~JSON
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
        it do
          result = wrap_command %(cleos push action dacescrow refundext '{ "ext_key": 777}' -p arb1)
          expect(result.stderr).to include('No escrow exists for this external key.')
        end
      end
      context "with valid escrow id" do
        context "with invalid auth" do
          it do
            result = wrap_command %(cleos push action dacescrow refundext '{ "ext_key": 666}' -p arb1)
            expect(result.stderr).to include('missing authority of sender2')
          end
        end
        context "with valid auth" do
          context "before a corresponding transfer has been made" do
            before(:all) do
              run %(cleos push action dacescrow init '{"sender": "sender1", "receiver": "receiver1", "arb": "arb2", "expires": "2019-01-20T23:21:43.528", "memo": "some empty memo", "ext_reference": 821}' -p sender1)
            end
            it do
              result = wrap_command %(cleos push action dacescrow refundext '{ "ext_key": 821 }' -p sender1)
              expect(result.stderr).to include('This has not been initialized with a transfer')
            end
          end
          context "after a transfer has been made" do
            context "before the escrow has expired" do
              before(:all) do
                run %(cleos push action dacescrow init '{"sender": "sender4", "receiver": "receiver1", "arb": "arb2", "expires": "2035-01-20T23:21:43.528", "memo": "distant future escrow", "ext_reference": 123}' -p sender4)
                run %(cleos push action eosio.token transfer '{"from": "sender4", "to": "dacescrow", "quantity": "5.0000 EOS", "memo": "here is a memo" }' -p sender4)
                run %(cleos push action dacescrow approveext '{ "ext_key": 123, "approver": "sender4"}' -p sender4)
              end
              it do
                result = wrap_command %(cleos push action dacescrow refundext '{ "ext_key": 123 }' -p sender4)
                expect(result.stderr).to include('Escrow has not expired')
              end
            end
          end
          context "balance of escrow should be set before preparing the escrow with a known balance starting point" do
            it do
              result = wrap_command %(cleos get currency balance eosio.token dacescrow EOS)
              expect(result.stdout).to eq <<~JSON
                22.0000 EOS
              JSON
            end
          end
          context "balance of escrow should be set before preparing the escrow with a known balance starting point" do
            it do
              result = wrap_command %(cleos get currency balance eosio.token sender3 EOS)
              expect(result.stdout).to eq <<~JSON
                1000.0000 EOS
              JSON
            end
          end
          context "after the escrow has expired" do
            before(:all) do
              run %(cleos push action dacescrow init '{"sender": "sender3", "receiver": "receiver1", "arb": "arb2", "expires": "2019-01-19T23:21:43.528", "memo": "some expired memo", "ext_reference": 456}' -p sender3)
              run %(cleos push action eosio.token transfer '{"from": "sender3", "to": "dacescrow", "quantity": "5.0000 EOS", "memo": "here is a memo" }' -p sender3)
              run %(cleos push action dacescrow approveext '{ "ext_key": 456, "approver": "sender3"}' -p sender3)
            end
            context "balance of dacescrow should have adjusted after preparing the escrow" do
              it do
                result = wrap_command %(cleos get currency balance eosio.token dacescrow EOS)
                expect(result.stdout).to eq <<~JSON
                  27.0000 EOS
                JSON
              end
            end
            context "balance of sender3 should have adjusted after preparing the escrow" do
              it do
                result = wrap_command %(cleos get currency balance eosio.token sender3 EOS)
                expect(result.stdout).to eq <<~JSON
                  995.0000 EOS
                JSON
              end
            end
            context "after refund succeeds" do
              it do
                result = wrap_command %(cleos push action dacescrow refundext '{ "ext_key": 456 }' -p sender3)
                expect(result.stdout).to include('dacescrow <= dacescrow::refund')
              end
            end
            context "balance of dacescrow should have changed back after refunding an escrow" do
              it do
                result = wrap_command %(cleos get currency balance eosio.token dacescrow EOS)
                expect(result.stdout).to eq <<~JSON
                  22.0000 EOS
                JSON
              end
            end
            context "balance of sender3 should have changed back after refunding an escrow" do
              it do
                result = wrap_command %(cleos get currency balance eosio.token sender3 EOS)
                expect(result.stdout).to eq <<~JSON
                  1000.0000 EOS
                JSON
              end
            end
          end
        end
      end
      context "Read the escrow table after refund" do
        it do
          result = wrap_command %(cleos get table dacescrow dacescrow escrows)
          expect(JSON.parse(result.stdout)).to eq JSON.parse <<~JSON
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
