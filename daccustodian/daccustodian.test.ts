import * as l from 'lamington';

import {
  SharedTestObjects,
  initAndGetSharedObjects,
  candidates,
  regmembers,
  debugPromise,
  NUMBER_OF_CANDIDATES,
} from '../TestHelpers';
import * as chai from 'chai';

import * as chaiAsPromised from 'chai-as-promised';

chai.use(chaiAsPromised);
import { factory } from '../LoggingConfig';

const log = factory.getLogger('Custodian Tests');

describe('Daccustodian', () => {
  let shared: SharedTestObjects;
  let newUser1: l.Account;

  before(async () => {
    shared = await debugPromise(
      initAndGetSharedObjects(),
      'init and get shared objects'
    );
  });

  context('updateconfige', async () => {
    it('Should fail for a dac_id without a dac', async () => {
      await l.assertEOSErrorIncludesMessage(
        shared.daccustodian_contract.updateconfige(
          {
            numelected: 5,
            maxvotes: 5,
            auth_threshold_mid: 6,
            requested_pay_max: { contract: 'sdfsdf', quantity: '12.0000 EOS' },
            periodlength: 37500,
            initial_vote_quorum_percent: 31,
            vote_quorum_percent: 15,
            auth_threshold_high: 4,
            auth_threshold_low: 3,
            lockupasset: { contract: 'sdfsdf', quantity: '12.0000 EOS' },
            should_pay_via_service_provider: true,
            lockup_release_time_delay: 1233,
          },
          'unknowndac',
          { from: shared.auth_account }
        ),
        'ERR::DAC_NOT_FOUND'
      );
      await l.assertRowsEqual(
        shared.daccustodian_contract.config2Table({
          scope: 'unknowndac',
          limit: 1,
        }),
        []
      );
    });
    it('Should fail for invalid high auth threshold', async () => {
      await l.assertEOSErrorIncludesMessage(
        shared.daccustodian_contract.updateconfige(
          {
            numelected: 5,
            maxvotes: 5,
            requested_pay_max: { contract: 'sdfsdf', quantity: '12.0000 EOS' },
            periodlength: 37500,
            initial_vote_quorum_percent: 31,
            vote_quorum_percent: 15,
            auth_threshold_high: 5,
            auth_threshold_mid: 6,
            auth_threshold_low: 3,
            lockupasset: { contract: 'sdfsdf', quantity: '12.0000 EOS' },
            should_pay_via_service_provider: true,
            lockup_release_time_delay: 1233,
          },
          shared.configured_dac_id,
          { from: shared.auth_account }
        ),
        'ERR::UPDATECONFIG_INVALID_AUTH_HIGH_TO_NUM_ELECTED'
      );
      await l.assertRowsEqual(
        shared.daccustodian_contract.config2Table({
          scope: shared.configured_dac_id,
          limit: 2,
        }),
        []
      );
    });
    it('Should fail for invalid mid auth threshold', async () => {
      await l.assertEOSErrorIncludesMessage(
        shared.daccustodian_contract.updateconfige(
          {
            numelected: 12,
            maxvotes: 5,
            requested_pay_max: { contract: 'sdfsdf', quantity: '12.0000 EOS' },
            periodlength: 37500,
            initial_vote_quorum_percent: 31,
            vote_quorum_percent: 15,
            auth_threshold_high: 9,
            auth_threshold_mid: 10,
            auth_threshold_low: 4,
            lockupasset: { contract: 'sdfsdf', quantity: '12.0000 EOS' },
            should_pay_via_service_provider: true,
            lockup_release_time_delay: 1233,
          },
          shared.configured_dac_id,
          { from: shared.auth_account }
        ),
        'ERR::UPDATECONFIG_INVALID_AUTH_HIGH_TO_MID_AUTH'
      );
      await l.assertRowsEqual(
        shared.daccustodian_contract.config2Table({
          scope: shared.configured_dac_id,
          limit: 2,
        }),
        []
      );
    });
    it('Should fail for invalid low auth threshold', async () => {
      await l.assertEOSErrorIncludesMessage(
        shared.daccustodian_contract.updateconfige(
          {
            numelected: 12,
            maxvotes: 5,
            requested_pay_max: { contract: 'sdfsdf', quantity: '12.0000 EOS' },
            periodlength: 5,
            initial_vote_quorum_percent: 31,
            vote_quorum_percent: 15,
            auth_threshold_high: 9,
            auth_threshold_mid: 7,
            auth_threshold_low: 8,
            lockupasset: { contract: 'sdfsdf', quantity: '12.0000 EOS' },
            should_pay_via_service_provider: true,
            lockup_release_time_delay: 1233,
          },
          shared.configured_dac_id,
          { from: shared.auth_account }
        ),
        'ERR::UPDATECONFIG_INVALID_AUTH_MID_TO_LOW_AUTH'
      );
      await l.assertRowsEqual(
        shared.daccustodian_contract.config2Table({
          scope: shared.configured_dac_id,
          limit: 2,
        }),
        []
      );
    });
    it('Should succeed with valid params', async () => {
      await shared.daccustodian_contract.updateconfige(
        {
          numelected: 5,
          maxvotes: 4,
          requested_pay_max: {
            contract: 'eosio.token',
            quantity: '30.0000 EOS',
          },
          periodlength: 5,
          initial_vote_quorum_percent: 31,
          vote_quorum_percent: 15,
          auth_threshold_high: 4,
          auth_threshold_mid: 3,
          auth_threshold_low: 2,
          lockupasset: {
            contract: shared.dac_token_contract.account.name,
            quantity: '12.0000 EOSDAC',
          },
          should_pay_via_service_provider: true,
          lockup_release_time_delay: 1233,
        },
        shared.configured_dac_id,
        { from: shared.auth_account }
      );
      await l.assertRowsEqual(
        shared.daccustodian_contract.config2Table({
          scope: shared.configured_dac_id,
          limit: 1,
        }),
        [
          {
            numelected: 5,
            maxvotes: 4,
            requested_pay_max: {
              contract: 'eosio.token',
              quantity: '30.0000 EOS',
            },
            periodlength: 5,
            initial_vote_quorum_percent: 31,
            vote_quorum_percent: 15,
            auth_threshold_high: 4,
            auth_threshold_mid: 3,
            auth_threshold_low: 2,
            lockupasset: {
              contract: shared.dac_token_contract.account.name,
              quantity: '12.0000 EOSDAC',
            },
            should_pay_via_service_provider: true,
            lockup_release_time_delay: 1233,
          },
        ]
      );
    });
  });
  context('Capture stake for a new member', async () => {
    before(async () => {
      newUser1 = await debugPromise(
        l.AccountManager.createAccount(),
        'create account for capture stake'
      );
      await debugPromise(
        shared.dac_token_contract.transfer(
          shared.dac_token_contract.account.name,
          newUser1.name,
          '1000.0000 EOSDAC',
          '',
          { from: shared.dac_token_contract.account }
        ),
        'transfer for capture stake'
      );
    });
    context('before the sender is a candidate', async () => {
      it('pending stake is inserted or has amount appended', async () => {
        await shared.dac_token_contract.transfer(
          newUser1.name,
          shared.daccustodian_contract.account.name,
          '3.0000 EOSDAC',
          '',
          { auths: [{ actor: newUser1.name, permission: 'active' }] }
        );
        await shared.dac_token_contract.transfer(
          newUser1.name,
          shared.daccustodian_contract.account.name,
          '7.0000 EOSDAC',
          '',
          { auths: [{ actor: newUser1.name, permission: 'active' }] }
        );

        await l.assertRowsEqual(
          shared.daccustodian_contract.pendingstakeTable({
            scope: shared.configured_dac_id,
          }),
          [{ memo: '', quantity: '10.0000 EOSDAC', sender: newUser1.name }]
        );
        await l.assertRowsEqual(
          shared.dac_token_contract.accountsTable({
            scope: shared.daccustodian_contract.account.name,
          }),
          [
            {
              balance: '10.0000 EOSDAC',
            },
          ]
        );
      });
    });
  });
  context('nominatecane', async () => {
    context('with unregistered member', async () => {
      it('should fail with error', async () => {
        await l.assertEOSErrorIncludesMessage(
          shared.daccustodian_contract.nominatecane(
            newUser1.name,
            '25.0000 EOS',
            shared.configured_dac_id,
            { from: newUser1 }
          ),
          'ERR::GENERAL_REG_MEMBER_NOT_FOUND'
        );
      });
    });
    context('with registered member', async () => {
      before(async () => {
        await shared.dac_token_contract.memberrege(
          newUser1.name,
          shared.configured_dac_memberterms,
          shared.configured_dac_id,
          { from: newUser1 }
        );
      });
      context('with insufficient staked funds', async () => {
        it('should fail with error', async () => {
          await l.assertEOSErrorIncludesMessage(
            shared.daccustodian_contract.nominatecane(
              newUser1.name,
              '25.0000 EOS',
              shared.configured_dac_id,
              { from: newUser1 }
            ),
            'ERR::NOMINATECAND_STAKING_FUNDS_INCOMPLETE'
          );
        });
      });
      context('with sufficient staked funds', async () => {
        before(async () => {
          await shared.dac_token_contract.transfer(
            newUser1.name,
            shared.daccustodian_contract.account.name,
            '2.0000 EOSDAC',
            '',
            { from: newUser1 }
          );
        });

        it('should succeed', async () => {
          // pending stake should be populated before nominatecane
          await l.assertRowsEqual(
            shared.daccustodian_contract.pendingstakeTable({
              scope: shared.configured_dac_id,
            }),
            [{ memo: '', quantity: '12.0000 EOSDAC', sender: newUser1.name }]
          );

          await shared.daccustodian_contract.nominatecane(
            newUser1.name,
            '25.0000 EOS',
            shared.configured_dac_id,
            { from: newUser1 }
          );

          // pending stake should be empty after nominatecane
          await l.assertRowsEqual(
            shared.daccustodian_contract.pendingstakeTable({
              scope: shared.configured_dac_id,
            }),
            []
          );
        });
      });
    });
  });

  context('candidates', async () => {
    let cands: l.Account[];
    context('with no votes', async () => {
      let currentCandidates: l.TableRowsResult<DaccustodianCandidate>;
      before(async () => {
        cands = await candidates();
        currentCandidates = await shared.daccustodian_contract.candidatesTable({
          scope: shared.configured_dac_id,
          limit: 20,
        });
      });
      it('candidates should have 0 for total_votes', async () => {
        chai
          .expect(currentCandidates.rows.length)
          .to.equal(NUMBER_OF_CANDIDATES + 1);
        for (const cand of currentCandidates.rows) {
          chai.expect(cand).to.include({
            // custodian_end_time_stamp: new Date(0),
            is_active: 1,
            locked_tokens: '12.0000 EOSDAC',
            total_votes: 0,
          });

          chai.expect(
            cand.requestedpay == '15.0000 EOS' ||
              cand.requestedpay == '20.0000 EOS' ||
              cand.requestedpay == '25.0000 EOS'
          ).to.be.true;
          chai.expect(cand.custodian_end_time_stamp).to.equalDate(new Date(0));
          chai.expect(cand).has.property('candidate_name');
        }
      });
      it('state should have 0 the total_weight_of_votes', async () => {
        let dacState = await shared.daccustodian_contract.stateTable({
          scope: shared.configured_dac_id,
        });
        chai.expect(dacState.rows[0]).to.include({
          total_weight_of_votes: 0,
        });
      });
    });
    context('After voting', async () => {
      before(async () => {
        // Place votes for even number candidates and leave odd number without votes.
        let members = await regmembers();
        // Only vote with the first 2 members
        for (const member of members.slice(0, 2)) {
          await debugPromise(
            shared.daccustodian_contract.votecuste(
              member.name,
              [cands[0].name, cands[2].name],
              shared.configured_dac_id,
              { from: member }
            ),
            'voting custodian'
          );
        }
      });
      it('votes table should have rows', async () => {
        let members = await regmembers();
        let votedCandidateResult = shared.daccustodian_contract.votesTable({
          scope: shared.configured_dac_id,
        });
        await l.assertRowsEqual(votedCandidateResult, [
          {
            candidates: [cands[0].name, cands[2].name],
            proxy: '',
            voter: members[0].name,
          },
          {
            candidates: [
              cands[0].name,
              cands[2].name,
              // cands[4].name
            ],
            proxy: '',
            voter: members[1].name,
          },
        ]);
      });
      it('only candidates with votes have total_votes values', async () => {
        let votedCandidateResult = await shared.daccustodian_contract.candidatesTable(
          {
            scope: shared.configured_dac_id,
            limit: 1,
            lowerBound: cands[1].name,
          }
        );
        chai.expect(votedCandidateResult.rows[0]).to.include({
          total_votes: 0,
        });
        let unvotedCandidateResult = await shared.daccustodian_contract.candidatesTable(
          {
            scope: shared.configured_dac_id,
            limit: 1,
            lowerBound: cands[0].name,
          }
        );
        chai.expect(unvotedCandidateResult.rows[0]).to.include({
          total_votes: 20_000_000,
        });
        await l.assertRowCount(
          shared.daccustodian_contract.votesTable({
            scope: shared.configured_dac_id,
          }),
          2
        );
      });
      it('state should have increased the total_weight_of_votes', async () => {
        let dacState = await shared.daccustodian_contract.stateTable({
          scope: shared.configured_dac_id,
        });
        chai.expect(dacState.rows[0]).to.include({
          total_weight_of_votes: 20_000_000,
        });
      });
    });
    context('vote values after transfers', async () => {
      it('assert preconditions for vote values for custodians', async () => {
        let votedCandidateResult = await shared.daccustodian_contract.candidatesTable(
          {
            scope: shared.configured_dac_id,
            limit: 20,
            lowerBound: cands[0].name,
          }
        );
        let initialVoteValue = votedCandidateResult.rows[0].total_votes;
        chai.expect(initialVoteValue).to.equal(20_000_000);
      });
      it('assert preconditions for total vote values on state', async () => {
        let dacState = await shared.daccustodian_contract.stateTable({
          scope: shared.configured_dac_id,
        });
        chai.expect(dacState.rows[0]).to.include({
          total_weight_of_votes: 20_000_000,
        });
      });
      it('after transfer to non-voter values should reduce for candidates and total values', async () => {
        let members = await regmembers();
        await shared.dac_token_contract.transfer(
          members[1].name,
          members[4].name,
          '300.0000 EOSDAC',
          '',
          { from: members[1] }
        );
        let votedCandidateResult = await shared.daccustodian_contract.candidatesTable(
          {
            scope: shared.configured_dac_id,
            limit: 20,
            lowerBound: cands[0].name,
          }
        );
        let updatedCandVoteValue = votedCandidateResult.rows[0].total_votes;
        chai.expect(updatedCandVoteValue).to.equal(17_000_000);
      });
      it('total vote values on state should have changed', async () => {
        let dacState = await shared.daccustodian_contract.stateTable({
          scope: shared.configured_dac_id,
        });
        chai.expect(dacState.rows[0]).to.include({
          total_weight_of_votes: 17_000_000,
        });
      });
    });
  });
  context('New Period Elections', async () => {
    context('without an activation account', async () => {
      context('before a dac has commenced periods', async () => {
        context('without enough INITIAL candidate value voting', async () => {
          it('should fail with voter engagement too low error', async () => {
            await l.assertEOSErrorIncludesMessage(
              shared.daccustodian_contract.newperiode(
                'initial new period',
                shared.configured_dac_id,
                {
                  auths: [
                    {
                      actor: shared.daccustodian_contract.account.name,
                      permission: 'owner',
                    },
                  ],
                }
              ),
              'NEWPERIOD_VOTER_ENGAGEMENT_LOW_ACTIVATE'
            );
          });
        });
        context('with enough INITIAL candidate value voting', async () => {
          let members: l.Account[];
          let cands: l.Account[];
          before(async () => {
            members = await regmembers();
            cands = await candidates();

            // Transfer an additional 1000 EODAC to member to get over the initial voting threshold
            let transfers = members.map(member => {
              return shared.dac_token_contract.transfer(
                shared.dac_token_contract.account.name,
                member.name,
                '1000.0000 EOSDAC',
                'additional EOSDAC',
                { from: shared.dac_token_contract.account }
              );
            });

            await debugPromise(
              Promise.all(transfers),
              'transferring an additonal 1000 EOSDAC for voting threshold'
            );

            for (const member of members) {
              await debugPromise(
                shared.daccustodian_contract.votecuste(
                  member.name,
                  [cands[0].name, cands[2].name],
                  shared.configured_dac_id,
                  { from: member }
                ),
                'voting custodian for new period'
              );
            }
          });
          context(
            'without enough candidates with > 0 votes to fill the configs',
            async () => {
              it('should fail with not enough candidates error', async () => {
                await l.assertEOSErrorIncludesMessage(
                  shared.daccustodian_contract.newperiode(
                    'initial new period',
                    shared.configured_dac_id,
                    {
                      auths: [
                        {
                          actor: shared.daccustodian_contract.account.name,
                          permission: 'owner',
                        },
                      ],
                    }
                  ),
                  'NEWPERIOD_NOT_ENOUGH_CANDIDATES'
                );
              });
            }
          );
          context('with enough candidates to fill the configs', async () => {
            let members: l.Account[];
            let cands: l.Account[];
            before(async () => {
              members = await regmembers();
              cands = await candidates();

              var index = 0;
              let candidateSize = cands.length;
              function nextCandIndex(): number {
                let nextIdx = ++index % candidateSize;
                return nextIdx;
              }

              for (const member of members) {
                await debugPromise(
                  shared.daccustodian_contract.votecuste(
                    member.name,
                    [cands[nextCandIndex()].name, cands[nextCandIndex()].name],
                    shared.configured_dac_id,
                    { from: member }
                  ),
                  'voting custodian for new period'
                );
              }
            });
            it('should succeed with custodians populated', async () => {
              await shared.daccustodian_contract.newperiode(
                'initial new period',
                shared.configured_dac_id,
                {
                  from: members[0],
                }
              );

              await l.assertRowCount(
                shared.daccustodian_contract.custodiansTable({
                  scope: shared.configured_dac_id,
                  limit: 12,
                }),
                5
              );
            });
            it('Should have highest ranked votes in custodians', async () => {
              let rowsResult = await shared.daccustodian_contract.custodiansTable(
                {
                  scope: shared.configured_dac_id,
                  limit: 14,
                  indexPosition: 3,
                  keyType: 'i64',
                }
              );
              let rows = rowsResult.rows;
              rows
                .sort((a, b) => {
                  return a.total_votes < b.total_votes
                    ? -1
                    : a.total_votes == b.total_votes
                    ? 0
                    : 1;
                })
                .reverse();
              chai.expect(rows[0].total_votes).to.equal(60_000_000);
              chai.expect(rows[1].total_votes).to.equal(60_000_000);
              chai.expect(rows[2].total_votes).to.equal(57_000_000);
              chai.expect(rows[3].total_votes).to.equal(57_000_000);
              chai.expect(rows[4].total_votes).to.equal(43_000_000);
            });
            it('Custodians should not yet be paid', async () => {
              await l.assertRowCount(
                shared.daccustodian_contract.pendingpay2Table({
                  scope: shared.configured_dac_id,
                  limit: 12,
                }),
                0
              );
            });
            it('should set the auths', async () => {
              let account = await debugPromise(
                l.EOSManager.rpc.get_account(shared.auth_account.name),
                'get account info'
              );
              let permissions = account.permissions.sort((a, b) =>
                a.perm_name.localeCompare(b.perm_name)
              );

              let ownerPermission = permissions[0];
              let ownerRequiredAuth = ownerPermission.required_auth;
              chai.expect(ownerPermission.parent).to.eq('owner');
              chai.expect(ownerPermission.perm_name).to.eq('active');
              chai.expect(ownerRequiredAuth.threshold).to.eq(1);

              let adminPermission = permissions[1];
              let adminRequiredAuth = adminPermission.required_auth;
              chai.expect(adminPermission.parent).to.eq('one');
              chai.expect(adminPermission.perm_name).to.eq('admin');
              chai.expect(adminRequiredAuth.threshold).to.eq(1);

              let highPermission = permissions[2];
              let highRequiredAuth = highPermission.required_auth;
              chai.expect(highPermission.parent).to.eq('active');
              chai.expect(highPermission.perm_name).to.eq('high');
              chai.expect(highRequiredAuth.threshold).to.eq(4);

              let highAccounts = highRequiredAuth.accounts;
              chai.expect(highAccounts.length).to.eq(5);
              chai.expect(highAccounts[0].weight).to.eq(1);

              let lowPermission = permissions[3];
              let lowRequiredAuth = lowPermission.required_auth;

              chai.expect(lowPermission.parent).to.eq('med');
              chai.expect(lowPermission.perm_name).to.eq('low');
              chai.expect(lowRequiredAuth.threshold).to.eq(2);

              let lowAccounts = lowRequiredAuth.accounts;
              chai.expect(lowAccounts.length).to.eq(5);
              chai.expect(lowAccounts[0].weight).to.eq(1);

              let medPermission = permissions[4];
              let medRequiredAuth = medPermission.required_auth;

              chai.expect(medPermission.parent).to.eq('high');
              chai.expect(medPermission.perm_name).to.eq('med');
              chai.expect(medRequiredAuth.threshold).to.eq(3);

              let medAccounts = medRequiredAuth.accounts;
              chai.expect(medAccounts.length).to.eq(5);
              chai.expect(medAccounts[0].weight).to.eq(1);

              let onePermission = account.permissions[5];
              let oneRequiredAuth = onePermission.required_auth;

              chai.expect(onePermission.parent).to.eq('low');
              chai.expect(onePermission.perm_name).to.eq('one');
              chai.expect(oneRequiredAuth.threshold).to.eq(1);

              let oneAccounts = oneRequiredAuth.accounts;
              chai.expect(oneAccounts.length).to.eq(5);
              chai.expect(oneAccounts[0].weight).to.eq(1);
            });
          });
        });
      });
    });
    context('Calling newperiode before the next period is due', async () => {
      it('should fail with too calling newperiod too early error', async () => {
        await l.assertEOSErrorIncludesMessage(
          shared.daccustodian_contract.newperiode(
            'initial new period',
            shared.configured_dac_id,
            {
              from: newUser1,
            }
          ),
          'ERR::NEWPERIOD_EARLY'
        );
      });
    });
    context(
      'Calling new period after the period time has expired',
      async () => {
        before(async () => {
          let members = await regmembers();

          // Removing 1000 EOSDAC from each member to get under the initial voting threshold
          // but still above the ongoing voting threshold to check the newperiode still succeeds.
          let transfers = members.map(member => {
            return shared.dac_token_contract.transfer(
              member.name,
              shared.dac_token_contract.account.name,
              '1000.0000 EOSDAC',
              'removing EOSDAC',
              { from: member }
            );
          });

          await debugPromise(
            Promise.all(transfers),
            'transferring 1000 EOSDAC away for voting threshold'
          );
          await l.sleep(4_000);
        });
        it('should succeed', async () => {
          await chai.expect(
            shared.daccustodian_contract.newperiode(
              'initial new period',
              shared.configured_dac_id,
              {
                from: newUser1,
              }
            )
          ).to.eventually.be.fulfilled;
        });
        it('custodians should have been paid', async () => {
          await l.assertRowCount(
            shared.daccustodian_contract.pendingpay2Table({
              scope: shared.configured_dac_id,
              limit: 12,
            }),
            5
          );
        });
        it('custodians should the mean pay', async () => {
          let custodianRows = await shared.daccustodian_contract.custodiansTable(
            {
              scope: shared.configured_dac_id,
              limit: 12,
            }
          );
          let pays = custodianRows.rows.map(cand => {
            return Number(cand.requestedpay.split(' ')[0]);
          });
          let expectedAverage =
            pays.reduce((a, b) => {
              return a + b;
            }) / pays.length;

          let payRows = await shared.daccustodian_contract.pendingpay2Table({
            scope: shared.configured_dac_id,
            limit: 12,
          });

          let actualPaidAverage = Number(
            payRows.rows[0].quantity.quantity.split(' ')[0]
          );

          chai.expect(actualPaidAverage).to.equal(expectedAverage);
        });
      }
    );
    context('with an activation account', async () => {
      it('should fail with ');
    });
  });
  context('stakeobsv', async () => {
    context(
      'with candidate in a registered candidate locked time',
      async () => {
        context('with less than the locked up quantity staked', async () => {
          it('should fail to unstake', async () => {});
        });
        context('with more than the locked up quantity staked', async () => {
          it('should allow unstaking of funds', async () => {});
        });
      }
    );
    context('with some staked amounts', async () => {
      it('should allow unstaking of funds', async () => {});
    });
  });
});
