import * as l from 'lamington';

import { SharedTestObjects, debugPromise, Action } from '../TestHelpers';
import * as chai from 'chai';

import * as chaiAsPromised from 'chai-as-promised';

chai.use(chaiAsPromised);
import { factory } from '../LoggingConfig';
import { sleep, EOSManager } from 'lamington';

const log = factory.getLogger('Custodian Tests');

enum VoteType {
  none = 0,
  // a vote type to indicate a custodian's approval of a worker proposal.
  proposal_approve,
  // a vote type to indicate a custodian's denial of a worker proposal.
  proposal_deny,
  // a vote type to indicate a custodian's acceptance of a worker proposal as completed.
  finalize_approve,
  // a vote type to indicate a custodian's rejection of a worker proposal as completed.
  finalize_deny,
}

enum ProposalState {
  ProposalStatePending_approval = 0,
  ProposalStateWork_in_progress,
  ProposalStatePending_finalize,
  ProposalStateHas_enough_approvals_votes,
  ProposalStateHas_enough_finalize_votes,
  ProposalStateExpired,
}

let proposalHash = 'jhsdfkjhsdfkjhkjsdf';

describe.only('Dacproposals', () => {
  let shared: SharedTestObjects;
  let otherAccount: l.Account;
  let proposer1Account: l.Account;
  let arbitrator: l.Account;
  let propDacCustodians: l.Account[];
  let regMembers: l.Account[];
  let dacId = 'popdac';
  let delegateeCustodian: l.Account;

  before(async () => {
    shared = await SharedTestObjects.getInstance();
    await shared.initDac(dacId, '4,PROPDAC', '1000000.0000 PROPDAC');
    await shared.updateconfig(dacId, '12.0000 PROPDAC');
    await shared.dac_token_contract.stakeconfig(
      { enabled: true, min_stake_time: 5, max_stake_time: 20 },
      '4,PROPDAC',
      { from: shared.auth_account }
    );

    regMembers = await shared.getRegMembers(dacId, '20000.0000 PROPDAC');
    propDacCustodians = await shared.getStakeObservedCandidates(
      dacId,
      '20.0000 PROPDAC'
    );
    await shared.voteForCustodians(regMembers, propDacCustodians, dacId);
    await shared.daccustodian_contract.newperiode('propDac', dacId, {
      from: regMembers[0],
    });

    otherAccount = regMembers[1];
    arbitrator = regMembers[2];
    proposer1Account = regMembers[3];
    delegateeCustodian = propDacCustodians[4];
  });
  context('updateconfig', async () => {
    context('without valid auth', async () => {
      it('should fail with auth error', async () => {
        await l.assertMissingAuthority(
          shared.dacproposals_contract.updateconfig(
            {
              proposal_threshold: 7,
              finalize_threshold: 5,
            },
            dacId,
            { from: otherAccount }
          )
        );
      });
    });
    context('with valid auth', async () => {
      it('should succeed', async () => {
        await shared.dacproposals_contract.updateconfig(
          {
            proposal_threshold: 4,
            finalize_threshold: 3,
          },
          dacId,
          { from: shared.auth_account }
        );
      });
      it('should have correct config in config table', async () => {
        await l.assertRowsEqual(
          shared.dacproposals_contract.configTable({ scope: dacId }),
          [
            {
              proposal_threshold: 4,
              finalize_threshold: 3,
            },
          ]
        );
      });
    });
  });
  context('create proposal', async () => {
    context('without valid permissions', async () => {
      it('should fail with auth error', async () => {
        await l.assertMissingAuthority(
          shared.dacproposals_contract.createprop(
            proposer1Account.name,
            'title',
            'summary',
            arbitrator.name,
            { quantity: '100.0000 EOS', contract: 'eosio.token' },
            proposalHash,
            0,
            2,
            130,
            150,
            dacId
          )
        );
      });
    });
    context('with valid auth', async () => {
      context('with invalid title', async () => {
        it('should fail with short title error', async () => {
          await l.assertEOSErrorIncludesMessage(
            shared.dacproposals_contract.createprop(
              proposer1Account.name,
              'ti',
              'summary',
              arbitrator.name,
              { quantity: '100.0000 EOS', contract: 'eosio.token' },
              proposalHash,
              0,
              2,
              130,
              150,
              dacId,
              { from: proposer1Account }
            ),
            'CREATEPROP_SHORT_TITLE'
          );
        });
      });
      context('with invalid summary', async () => {
        it('should fail with short summary error', async () => {
          await l.assertEOSErrorIncludesMessage(
            shared.dacproposals_contract.createprop(
              proposer1Account.name,
              'title',
              'su',
              arbitrator.name,
              { quantity: '100.0000 EOS', contract: 'eosio.token' },
              proposalHash,
              0,
              2,
              130,
              150,
              dacId,
              { from: proposer1Account }
            ),
            'CREATEPROP_SHORT_SUMMARY'
          );
        });
      });
      context('with invalid pay symbol', async () => {
        it('should fail with invalid pay symbol error', async () => {
          await l.assertEOSErrorIncludesMessage(
            shared.dacproposals_contract.createprop(
              proposer1Account.name,
              'title',
              'summary',
              arbitrator.name,
              { quantity: '100.0000 sdff', contract: 'eosio.token' },
              proposalHash,
              0,
              2,
              130,
              150,
              dacId,
              { from: proposer1Account }
            ),
            'CREATEPROP_INVALID_SYMBOL'
          );
        });
      });
      context('with no pay symbol', async () => {
        it('should fail with no pay symbol error', async () => {
          await l.assertEOSErrorIncludesMessage(
            shared.dacproposals_contract.createprop(
              proposer1Account.name,
              'title',
              'summary',
              arbitrator.name,
              { quantity: '100.0000', contract: 'eosio.token' },
              proposalHash,
              0,
              2,
              130,
              150,
              dacId,
              { from: proposer1Account }
            ),
            'CREATEPROP_INVALID_SYMBOL'
          );
        });
      });
      context('with negative amount', async () => {
        it('should fail with negative pay error', async () => {
          await l.assertEOSErrorIncludesMessage(
            shared.dacproposals_contract.createprop(
              proposer1Account.name,
              'title',
              'summary',
              arbitrator.name,
              { quantity: '-100.0000 EOS', contract: 'eosio.token' },
              proposalHash,
              0,
              2,
              130,
              150,
              dacId,
              { from: proposer1Account }
            ),
            'CREATEPROP_INVALID_PAY_AMOUNT'
          );
        });
      });
      context('with no arbitrator', async () => {
        it('should fail with invalid arbitrator error', async () => {
          await l.assertEOSErrorIncludesMessage(
            shared.dacproposals_contract.createprop(
              proposer1Account.name,
              'title',
              'summary',
              'randomname',
              { quantity: '100.0000 EOS', contract: 'eosio.token' },
              proposalHash,
              0,
              2,
              130,
              150,
              dacId,
              { from: proposer1Account }
            ),
            'CREATEPROP_INVALID_ARBITRATOR'
          );
        });
      });
      context('with valid params', async () => {
        it('should succeed', async () => {
          await chai.expect(
            shared.dacproposals_contract.createprop(
              proposer1Account.name,
              'title',
              'summary',
              arbitrator.name,
              { quantity: '100.0000 EOS', contract: 'eosio.token' },
              proposalHash,
              0,
              2,
              130,
              150,
              dacId,
              { from: proposer1Account }
            ),
            ''
          ).to.eventually.be.fulfilled;
        });
      });
      context('with duplicate id', async () => {
        it('should fail with short title error', async () => {
          await l.assertEOSErrorIncludesMessage(
            shared.dacproposals_contract.createprop(
              proposer1Account.name,
              'title',
              'summary',
              'randomname',
              {
                quantity: '100.0000 EOS',
                contract: 'eosio.token',
              },
              proposalHash,
              0,
              2,
              130,
              150,
              dacId,
              { from: proposer1Account }
            ),
            'CREATEPROP_DUPLICATE_ID'
          );
        });
      });
      context('with valid params as an additional proposal', async () => {
        it('should succeed', async () => {
          await chai.expect(
            shared.dacproposals_contract.createprop(
              proposer1Account.name,
              'title',
              'summary',
              arbitrator.name,
              { quantity: '100.0000 EOS', contract: 'eosio.token' },
              proposalHash,
              16,
              2,
              130,
              150,
              dacId,
              { from: proposer1Account }
            )
          ).to.eventually.be.fulfilled;
        });
      });
    });
  });
  context('voteprop', async () => {
    context('without valid auth', async () => {
      it('should fail with auth error', async () => {
        await l.assertMissingAuthority(
          shared.dacproposals_contract.voteprop(
            propDacCustodians[0].name,
            0,
            VoteType.proposal_approve,
            dacId,
            {
              auths: [
                {
                  actor: propDacCustodians[1].name,
                  permission: 'active',
                },
              ],
            }
          )
        );
      });
    });
    context('with valid auth', async () => {
      context('with invalid proposal id', async () => {
        it('should fail with proposal not found error', async () => {
          await l.assertEOSErrorIncludesMessage(
            shared.dacproposals_contract.voteprop(
              propDacCustodians[0].name,
              15,
              VoteType.proposal_approve,
              dacId,
              {
                auths: [
                  {
                    actor: propDacCustodians[0].name,
                    permission: 'active',
                  },
                  {
                    actor: shared.auth_account.name,
                    permission: 'active',
                  },
                ],
              }
            ),
            'VOTEPROP_PROPOSAL_NOT_FOUND'
          );
        });
      });
      context('proposal in pending approval state', async () => {
        context('proposal_approve vote', async () => {
          it('should succeed', async () => {
            await chai.expect(
              shared.dacproposals_contract.voteprop(
                propDacCustodians[0].name,
                0,
                VoteType.proposal_approve,
                dacId,
                {
                  auths: [
                    {
                      actor: propDacCustodians[0].name,
                      permission: 'active',
                    },
                    {
                      actor: shared.auth_account.name,
                      permission: 'active',
                    },
                  ],
                }
              )
            ).to.eventually.be.fulfilled;
          });
        });
        context('proposal_deny vote', async () => {
          it('should succeed', async () => {
            await chai.expect(
              shared.dacproposals_contract.voteprop(
                propDacCustodians[0].name,
                0,
                VoteType.proposal_deny,
                dacId,
                {
                  auths: [
                    {
                      actor: propDacCustodians[0].name,
                      permission: 'active',
                    },
                    {
                      actor: shared.auth_account.name,
                      permission: 'active',
                    },
                  ],
                }
              )
            ).to.eventually.be.fulfilled;
          });
        });
        context('proposal_approve vote', async () => {
          it('should succeed', async () => {
            await chai.expect(
              shared.dacproposals_contract.voteprop(
                propDacCustodians[0].name,
                0,
                VoteType.proposal_approve,
                dacId,
                {
                  auths: [
                    {
                      actor: propDacCustodians[0].name,
                      permission: 'active',
                    },
                    {
                      actor: shared.auth_account.name,
                      permission: 'active',
                    },
                  ],
                }
              )
            ).to.eventually.be.fulfilled;
          });
        });
        context('Extra proposal_approve vote', async () => {
          it('should succeed', async () => {
            await chai.expect(
              shared.dacproposals_contract.voteprop(
                propDacCustodians[0].name,
                16,
                VoteType.proposal_approve,
                dacId,
                {
                  auths: [
                    {
                      actor: propDacCustodians[0].name,
                      permission: 'active',
                    },
                    {
                      actor: shared.auth_account.name,
                      permission: 'active',
                    },
                  ],
                }
              )
            ).to.eventually.be.fulfilled;
          });
        });
        context('proposal_deny vote of existing vote', async () => {
          it('should succeed', async () => {
            await chai.expect(
              shared.dacproposals_contract.voteprop(
                propDacCustodians[0].name,
                0,
                VoteType.proposal_deny,
                dacId,
                {
                  auths: [
                    {
                      actor: propDacCustodians[0].name,
                      permission: 'active',
                    },
                    {
                      actor: shared.auth_account.name,
                      permission: 'active',
                    },
                  ],
                }
              )
            ).to.eventually.be.fulfilled;
          });
        });
      });
    });
  });
  context('delegate vote', async () => {
    context('without valid auth', async () => {
      before(async () => {
        await chai.expect(
          shared.dacproposals_contract.createprop(
            proposer1Account.name,
            'startwork_title',
            'startwork_summary',
            arbitrator.name,
            { quantity: '101.0000 EOS', contract: 'eosio.token' },
            'asdfasdfasdfasdfasdfasdfasdffdsa',
            1, // proposal id
            3,
            130, // job duration
            150, // approval duration
            dacId,
            { from: proposer1Account }
          ),
          ''
        ).to.eventually.be.fulfilled;
      });
      it('should fail with invalid auth error', async () => {
        await l.assertMissingAuthority(
          shared.dacproposals_contract.delegatevote(
            propDacCustodians[0].name,
            1, // proposal id
            delegateeCustodian.name,
            dacId,
            {
              auths: [
                {
                  actor: propDacCustodians[1].name,
                  permission: 'active',
                },
                {
                  actor: shared.auth_account.name,
                  permission: 'active',
                },
              ],
            }
          )
        );
      });
    });
    context('with valid auth', async () => {
      context('with invalid proposal id', async () => {
        it('should fail with proposal not found error', async () => {
          await l.assertEOSErrorIncludesMessage(
            shared.dacproposals_contract.delegatevote(
              propDacCustodians[1].name,
              15, // proposal id
              delegateeCustodian.name,
              dacId,
              {
                auths: [
                  {
                    actor: propDacCustodians[1].name,
                    permission: 'active',
                  },
                  {
                    actor: shared.auth_account.name,
                    permission: 'active',
                  },
                ],
              }
            ),
            'DELEGATEVOTE_PROPOSAL_NOT_FOUND'
          );
        });
      });
      context('delegating to self', async () => {
        it('should fail with Cannot delegate voting to yourself error', async () => {
          await l.assertEOSErrorIncludesMessage(
            shared.dacproposals_contract.delegatevote(
              propDacCustodians[0].name,
              1, // proposal id
              propDacCustodians[0].name,
              dacId,
              {
                auths: [
                  {
                    actor: propDacCustodians[0].name,
                    permission: 'active',
                  },
                  {
                    actor: shared.auth_account.name,
                    permission: 'active',
                  },
                ],
              }
            ),
            'DELEGATEVOTE_DELEGATE_SELF'
          );
        });
      });
      context('proposal in pending_approval state', async () => {
        context('delegate vote', async () => {
          it('should succeed', async () => {
            await chai.expect(
              shared.dacproposals_contract.delegatevote(
                propDacCustodians[0].name,
                1, // proposal id
                propDacCustodians[1].name,
                dacId,
                {
                  auths: [
                    {
                      actor: propDacCustodians[0].name,
                      permission: 'active',
                    },
                    {
                      actor: shared.auth_account.name,
                      permission: 'active',
                    },
                  ],
                }
              )
            ).eventually.be.fulfilled;
          });
        });
      });
    });
  });
  context('comment', async () => {
    context('without valid auth', async () => {
      it('should fail with invalid auth error', async () => {
        await l.assertMissingAuthority(
          shared.dacproposals_contract.comment(
            propDacCustodians[0].name,
            15,
            'some comment string',
            'some comment category',
            dacId,
            {
              auths: [
                {
                  actor: propDacCustodians[1].name,
                  permission: 'active',
                },
                {
                  actor: shared.auth_account.name,
                  permission: 'active',
                },
              ],
            }
          )
        );
      });
    });
    context('with valid auth', async () => {
      context('with invalid proposal id', async () => {
        it('should fail with proposal not found error', async () => {
          await l.assertEOSErrorIncludesMessage(
            shared.dacproposals_contract.comment(
              propDacCustodians[1].name,
              15, // proposal id
              'some comment',
              'a comment category',
              dacId,
              {
                auths: [
                  {
                    actor: propDacCustodians[1].name,
                    permission: 'active',
                  },
                  {
                    actor: shared.auth_account.name,
                    permission: 'active',
                  },
                ],
              }
            ),
            'DELEGATEVOTE_PROPOSAL_NOT_FOUND'
          );
        });
      });
    });
  });
  context('with custodian only auth', async () => {
    it('should succeed', async () => {
      await chai.expect(
        shared.dacproposals_contract.comment(
          propDacCustodians[3].name,
          1, // proposal id
          'some comment',
          'a comment category',
          dacId,
          {
            auths: [
              {
                actor: propDacCustodians[3].name,
                permission: 'active',
              },
              {
                actor: shared.auth_account.name,
                permission: 'active',
              },
            ],
          }
        )
      ).eventually.to.be.fulfilled;
    });
  });

  context('prepare for start work', async () => {
    context('without valid auth', async () => {
      it('should fail with invalid auth error', async () => {
        await l.assertMissingAuthority(
          shared.dacproposals_contract.startwork(1, dacId, {
            auths: [
              {
                actor: propDacCustodians[4].name,
                permission: 'active',
              },
              {
                actor: shared.auth_account.name,
                permission: 'active',
              },
            ],
          })
        );
      });
    });
    context('with valid auth', async () => {
      context('with invalid proposal id', async () => {
        it('should fail with proposal not found error', async () => {
          await l.assertEOSErrorIncludesMessage(
            shared.dacproposals_contract.startwork(
              15, // proposal id
              dacId,
              {
                auths: [
                  {
                    actor: propDacCustodians[1].name,
                    permission: 'active',
                  },
                  {
                    actor: shared.auth_account.name,
                    permission: 'active',
                  },
                ],
              }
            ),
            'ERR::DELEGATEVOTE_PROPOSAL_NOT_FOUND'
          );
        });
      });
    });
    context('proposal in pending_approval state', async () => {
      context('with insufficient votes', async () => {
        it('should fail with insuffient votes error', async () => {
          await l.assertEOSErrorIncludesMessage(
            shared.dacproposals_contract.startwork(
              0, // proposal id
              dacId,
              {
                auths: [
                  {
                    actor: proposer1Account.name,
                    permission: 'active',
                  },
                  {
                    actor: shared.auth_account.name,
                    permission: 'active',
                  },
                ],
              }
            ),
            'ERR::STARTWORK_INSUFFICIENT_VOTES'
          );
        });
      });
    });
    context('with more denied than approved votes', async () => {
      context('with insufficient votes', async () => {
        before(async () => {
          for (const custodian of propDacCustodians) {
            await shared.dacproposals_contract.voteprop(
              custodian.name,
              0,
              VoteType.proposal_deny,
              dacId,
              {
                auths: [
                  {
                    actor: custodian.name,
                    permission: 'active',
                  },
                  {
                    actor: shared.auth_account.name,
                    permission: 'active',
                  },
                ],
              }
            );
          }
        });
        it('should fail with insuffient votes error', async () => {
          await l.assertEOSErrorIncludesMessage(
            shared.dacproposals_contract.startwork(
              0, // proposal id
              dacId,
              {
                auths: [
                  {
                    actor: proposer1Account.name,
                    permission: 'active',
                  },
                  {
                    actor: shared.auth_account.name,
                    permission: 'active',
                  },
                ],
              }
            ),
            'ERR::STARTWORK_INSUFFICIENT_VOTES'
          );
        });
      });
    });
    context('with enough votes to approve the proposal', async () => {
      before(async () => {
        for (let index = 0; index < 4; index++) {
          const custodian = propDacCustodians[index];
          await shared.dacproposals_contract.voteprop(
            custodian.name,
            0,
            VoteType.proposal_approve,
            dacId,
            {
              auths: [
                {
                  actor: custodian.name,
                  permission: 'active',
                },
                {
                  actor: shared.auth_account.name,
                  permission: 'active',
                },
              ],
            }
          );
        }
      });
      context(
        'check updateVotes count on proposal before calling start work',
        async () => {
          it('should succeed to update prop votes', async () => {
            chai.expect(
              shared.dacproposals_contract.updpropvotes(0, dacId, {
                auths: [
                  {
                    actor: proposer1Account.name,
                    permission: 'active',
                  },
                  {
                    actor: shared.auth_account.name,
                    permission: 'active',
                  },
                ],
              })
            ).to.eventually.be.fulfilled;
          });
        }
      );
    });
    context('start work with enough votes', async () => {
      before(async () => {
        let action: Action = {
          account: 'eosio.token',
          name: 'transfer',
          authorization: [{ actor: 'eosio', permission: 'active' }],
          data: {
            from: 'eosio',
            to: shared.treasury_account.name,
            quantity: '100000.0000 EOS',
            memo: 'initial funds for proposal payments',
          },
        };
        await debugPromise(
          EOSManager.transact({ actions: [action] }),
          'failed to fund the treasuty account for dacproposals'
        );
      });
      it('should succeed', async () => {
        await chai.expect(
          shared.dacproposals_contract.startwork(
            0, // proposal id
            dacId,
            {
              auths: [
                {
                  actor: proposer1Account.name,
                  permission: 'active',
                },
                {
                  actor: shared.auth_account.name,
                  permission: 'active',
                },
              ],
            }
          )
        ).to.eventually.be.fulfilled;
      });
      it('should populate the escrow table', async () => {
        let proposalRow = await shared.dacescrow_contract.escrowsTable({
          scope: 'dacescrow',
        });
        let row = proposalRow.rows[0];
        chai.expect(row.key).to.eq(0);
        chai.expect(row.sender).to.eq('treasury');
        chai.expect(row.receiver).to.eq(proposer1Account.name);
        chai.expect(row.arb).to.eq(arbitrator.name);
        chai.expect(row.ext_asset.quantity).to.eq('0.0000 EOS');
        chai
          .expect(row.memo)
          .to.eq(`${proposer1Account.name}:0:${proposalHash}`);
        chai.expect(row.expires).to.be.afterTime(new Date(Date.now()));
        chai.expect(row.arb_payment).to.be.eq(0);
        await sleep(6000);
        proposalRow = await shared.dacescrow_contract.escrowsTable({
          scope: 'dacescrow',
        });
        row = proposalRow.rows[0];
        //wait for 5 seconds for the deferred transaction to run
        chai.expect(row.ext_asset.quantity).to.eq('100.0000 EOS');
      });
      it('should update the proposal state to in_progress', async () => {
        let proposalRow = await shared.dacproposals_contract.proposalsTable({
          scope: dacId,
          lowerBound: 0,
          upperBound: 0,
        });
        let row = proposalRow.rows[0];
        chai.expect(row.key).to.eq(0);
        chai.expect(row.arbitrator).to.eq(arbitrator.name);
        chai.expect(row.content_hash).to.eq(proposalHash);
        chai
          .expect(row.state)
          .to.eq(ProposalState.ProposalStateWork_in_progress);
      });
    });
    context('proposal not in pending_approval state', async () => {
      it('should fail with proposal is not in pensing approval state error', async () => {
        await l.assertEOSErrorIncludesMessage(
          shared.dacproposals_contract.startwork(
            0, // proposal id
            dacId,
            {
              auths: [
                {
                  actor: proposer1Account.name,
                  permission: 'active',
                },
                {
                  actor: shared.auth_account.name,
                  permission: 'active',
                },
              ],
            }
          ),
          'STARTWORK_WRONG_STATE'
        );
      });
    });
    context('proposal with short expiry', async () => {
      it('should create a proposal with a short expiry', async () => {
        await chai.expect(
          shared.dacproposals_contract.createprop(
            proposer1Account.name,
            'startwork_title',
            'startwork_summary',
            arbitrator.name,
            { quantity: '105.0000 EOS', contract: 'eosio.token' },
            'asdfasdfasdfasdfasdfasdfajjhjhjsdffdsa',
            5, // proposal id
            3,
            130, // job duration
            3, // approval duration. Specify short duration so that it expires for expired tests.
            dacId,
            { from: proposer1Account }
          ),
          ''
        ).to.eventually.be.fulfilled;
      });
      it('should allow a vote before expiry', async () => {
        await chai.expect(
          shared.dacproposals_contract.voteprop(
            propDacCustodians[0].name,
            5,
            VoteType.proposal_deny,
            dacId,
            {
              auths: [
                {
                  actor: propDacCustodians[0].name,
                  permission: 'active',
                },
                {
                  actor: shared.auth_account.name,
                  permission: 'active',
                },
              ],
            }
          )
        ).to.eventually.be.fulfilled;
      });
      context('startwork before expiry without enough votes', async () => {
        it('should fail with insufficient votes', async () => {
          await l.assertEOSErrorIncludesMessage(
            shared.dacproposals_contract.startwork(
              5, // proposal id
              dacId,
              {
                auths: [
                  {
                    actor: proposer1Account.name,
                    permission: 'active',
                  },
                  {
                    actor: shared.auth_account.name,
                    permission: 'active',
                  },
                ],
              }
            ),
            'ERR::STARTWORK_INSUFFICIENT_VOTES'
          );
        });
      });
      context('start work after expiry', async () => {
        before(async () => {
          await sleep(3000);
        });
        it('should fail with expired error', async () => {
          await l.assertEOSErrorIncludesMessage(
            shared.dacproposals_contract.startwork(
              5, // proposal id
              dacId,
              {
                auths: [
                  {
                    actor: proposer1Account.name,
                    permission: 'active',
                  },
                  {
                    actor: shared.auth_account.name,
                    permission: 'active',
                  },
                ],
              }
            ),
            'ERR::PROPOSAL_EXPIRED'
          );
        });
      });
    });
  });
  context('clear expired proposals', async () => {
    it('should have the 10 of votes before clearing', async () => {
      await l.assertRowCount(
        shared.dacproposals_contract.propvotesTable({
          scope: dacId,
          indexPosition: 3,
          keyType: 'i64',
          lowerBound: 5,
          upperBound: 5,
        }),
        1
      );
    });
    it('should have the correct number of proposals before clearing', async () => {
      await l.assertRowCount(
        shared.dacproposals_contract.proposalsTable({
          scope: dacId,
          lowerBound: 5,
          upperBound: 5,
        }),
        1
      );
    });
    it('should now allow to clear unexpired proposals', async () => {
      await l.assertEOSErrorIncludesMessage(
        shared.dacproposals_contract.clearexpprop(0, dacId, {
          from: proposer1Account,
        }),
        'ERR::PROPOSAL_NOT_EXPIRED'
      );
    });
    it('should clear the expired proposals', async () => {
      await chai.expect(shared.dacproposals_contract.clearexpprop(5, dacId)).to
        .eventually.fulfilled;
    });
    context('After clearing expired proposals', async () => {
      it('should have the correct number of proposals', async () => {
        await l.assertRowCount(
          shared.dacproposals_contract.proposalsTable({
            scope: dacId,
            lowerBound: 5,
            upperBound: 5,
          }),
          0
        );
      });
      it('should have the correct number of votes', async () => {
        await l.assertRowCount(
          shared.dacproposals_contract.propvotesTable({
            scope: dacId,
            indexPosition: 3,
            keyType: 'i64',
            lowerBound: 5,
            upperBound: 5,
          }),
          0
        );
      });
    });
  });

  context(
    'voteprop with valid auth and proposal in work_in_progress state',
    async () => {
      context('voteup', async () => {
        it('should fail with invalid state to accept votes', async () => {
          await l.assertEOSErrorIncludesMessage(
            shared.dacproposals_contract.voteprop(
              propDacCustodians[0].name,
              0,
              VoteType.proposal_approve,
              dacId,
              {
                auths: [
                  { actor: propDacCustodians[0].name, permission: 'active' },
                  {
                    actor: shared.auth_account.name,
                    permission: 'active',
                  },
                ],
              }
            ),
            'VOTEPROP_INVALID_PROPOSAL_STATE'
          );
        });
      });
      context('votedown', async () => {
        it('should fail with invalid state to accept votes', async () => {
          await l.assertEOSErrorIncludesMessage(
            shared.dacproposals_contract.voteprop(
              propDacCustodians[0].name,
              0,
              VoteType.proposal_deny,
              dacId,
              {
                auths: [
                  { actor: propDacCustodians[0].name, permission: 'active' },
                  {
                    actor: shared.auth_account.name,
                    permission: 'active',
                  },
                ],
              }
            ),
            'VOTEPROP_INVALID_PROPOSAL_STATE'
          );
        });
      });
    }
  );
  context('complete work', async () => {
    context('without existing proposal', async () => {
      it('should fail with proposal not found error', async () => {
        await l.assertEOSErrorIncludesMessage(
          shared.dacproposals_contract.completework(26, dacId, {
            from: proposer1Account,
          }),
          'PROPOSAL_NOT_FOUND'
        );
      });
    });
    context('with incorrect auth', async () => {
      it('should fail with auth error', async () => {
        await l.assertMissingAuthority(
          shared.dacproposals_contract.completework(1, dacId, {
            auths: [{ actor: propDacCustodians[1].name, permission: 'active' }],
          })
        );
      });
    });
    context('proposal in pending approval state', async () => {
      it('should fail with incorrect to state to complete error', async () => {
        await l.assertEOSErrorIncludesMessage(
          shared.dacproposals_contract.completework(1, dacId, {
            from: proposer1Account,
          }),
          'COMPLETEWORK_WRONG_STATE'
        );
      });
    });
    context('proposal in work_in_progress state', async () => {
      it('should allow completework', async () => {
        await chai.expect(
          shared.dacproposals_contract.completework(0, dacId, {
            from: proposer1Account,
          })
        ).to.eventually.be.fulfilled;
      });
    });
  });

  context('finalize', async () => {
    context('without valid auth', async () => {
      // Any auth is allowed
    });
    // context('with valid auth', async () => {
    context('with invalid proposal id', async () => {
      it('should fail with proposal not found error', async () => {
        await l.assertEOSErrorIncludesMessage(
          shared.dacproposals_contract.finalize(26, dacId, {
            from: proposer1Account,
          }),
          'PROPOSAL_NOT_FOUND'
        );
      });
    });
  });
  context('proposal in not in pending_finalize state', async () => {
    before(async () => {
      await shared.dacproposals_contract.updpropvotes(1, dacId, {
        from: proposer1Account,
      });
    });
    it('should fail with not in pending_finalize state error', async () => {
      await l.assertEOSErrorIncludesMessage(
        shared.dacproposals_contract.finalize(1, dacId, {
          from: proposer1Account,
        }),
        'FINALIZE_WRONG_STATE'
      );
    });
  });
  context('proposal is in pending_finalize state', async () => {
    before(async () => {
      await shared.dacproposals_contract.updpropvotes(0, dacId, {
        from: proposer1Account,
      });
    });
    context('without enough votes to approve the finalize', async () => {
      it('should fail to complete work with not enough votes error', async () => {
        await l.assertEOSErrorIncludesMessage(
          shared.dacproposals_contract.finalize(0, dacId, {
            from: proposer1Account,
          }),
          'FINALIZE_INSUFFICIENT_VOTES'
        );
      });
    });
    context('with enough votes to complete finalize with denial', async () => {
      context('update votes count', async () => {
        before(async () => {
          for (const custodian of propDacCustodians) {
            await shared.dacproposals_contract.voteprop(
              custodian.name,
              0,
              VoteType.finalize_approve,
              dacId,
              {
                auths: [
                  {
                    actor: custodian.name,
                    permission: 'active',
                  },
                  {
                    actor: shared.auth_account.name,
                    permission: 'active',
                  },
                ],
              }
            );
          }
        });
        it('should succeed', async () => {
          await chai.expect(
            shared.dacproposals_contract.finalize(0, dacId, {
              from: proposer1Account,
            })
          ).to.eventually.be.fulfilled;
        });
      });
    });
    context('Read the proposals table after finalize', async () => {
      it('should have removed the finalized proposal', async () => {
        await l.assertRowCount(
          shared.dacproposals_contract.proposalsTable({
            scope: dacId,
            lowerBound: 0,
            upperBound: 0,
          }),
          0
        );
      });
      it('escrow table should contain 0 row after finalize is done', async () => {
        await l.assertRowCount(
          shared.dacescrow_contract.escrowsTable({
            scope: 'dacescrow',
          }),
          0
        );
      });
    });
  });
  context('cancel', async () => {
    before(async () => {
      await chai.expect(
        shared.dacproposals_contract.createprop(
          proposer1Account.name,
          'startwork_title',
          'startwork_summary',
          arbitrator.name,
          { quantity: '106.0000 EOS', contract: 'eosio.token' },
          'asdfasdfasdfasdfasdfasdfajjhjhjsdffdsa',
          7, // proposal id
          3,
          130, // job duration
          3, // approval duration
          dacId,
          { from: proposer1Account }
        ),
        ''
      ).to.eventually.be.fulfilled;
      for (let index = 0; index < 4; index++) {
        const custodian = propDacCustodians[index];
        await debugPromise(
          shared.dacproposals_contract.voteprop(
            custodian.name,
            7, // proposal id
            VoteType.proposal_approve,
            dacId,
            {
              auths: [
                {
                  actor: custodian.name,
                  permission: 'active',
                },
                {
                  actor: shared.auth_account.name,
                  permission: 'active',
                },
              ],
            }
          ),
          'vote approve for proposal 7'
        );
      }
    });
    context('without valid auth', async () => {
      it('should fail with invalid auth error', async () => {
        await l.assertMissingAuthority(
          shared.dacproposals_contract.cancel(7, dacId, { from: otherAccount })
        );
      });
    });
    context('with valid auth', async () => {
      context('with invalid proposal id', async () => {
        it('should fail with proposal not found error', async () => {
          await l.assertEOSErrorIncludesMessage(
            shared.dacproposals_contract.cancel(8, dacId, {
              from: proposer1Account,
            }),
            'PROPOSAL_NOT_FOUND'
          );
        });
      });
      context('with valid proposal id', async () => {
        context('after starting work but before completing', async () => {
          before(async () => {
            await shared.dacproposals_contract.startwork(7, dacId, {
              from: proposer1Account,
            });
          });
          it('should initially contain proposal', async () => {
            await l.assertRowCount(
              shared.dacproposals_contract.proposalsTable({
                scope: dacId,
                lowerBound: 7,
                upperBound: 7,
              }),
              1
            );
          });
          it('should contain initial votes for proposal', async () => {
            let result = await shared.dacproposals_contract.propvotesTable({
              scope: dacId,
              indexPosition: 3,
              keyType: 'i64',
              lowerBound: 7,
              upperBound: 7,
            });
            console.log(`votttee: ${JSON.stringify(result)}`);
            chai.expect(result.rows.length).equal(4);
          });
          it('should succeed', async () => {
            await chai.expect(
              shared.dacproposals_contract.cancel(7, dacId, {
                from: proposer1Account,
              })
            ).to.eventually.be.fulfilled;
          });
          it('should not contain proposal', async () => {
            await l.assertRowCount(
              shared.dacproposals_contract.proposalsTable({
                scope: dacId,
                lowerBound: 7,
                upperBound: 7,
              }),
              0
            );
          });
          it('should not contain initial votes for proposal', async () => {
            await l.assertRowCount(
              shared.dacproposals_contract.propvotesTable({
                scope: dacId,
                indexPosition: 3,
                keyType: 'i64',
                lowerBound: 7,
                upperBound: 7,
              }),
              0
            );
          });
        });
        it('escrow table should contain expected rows', async () => {});
      });
    });
  });
});
// context('delegate categories', async () => {
//   context(
//     'created proposal but still needing a vote for approval',
//     async () => {
//       context(
//         'delegate category for a vote with pre-existing vote should have no effect',
//         async () => {
//           it('should fail with insufficient votes', async () => {});
//         }
//       );
//       context('delegated vote with non-matching category', async () => {
//         it('should fail with insufficient votes', async () => {});
//       });
//       context('delegated category with matching category', async () => {
//         it('should succeed to allow start work', async () => {});
//       });
//     }
//   );
//   context(
//     'created a proposal but still need one vote for approval for categories',
//     async () => {
//       context(
//         'delegated category with already voted custodian should have no effect',
//         async () => {
//           it('should fail with insufficient votes', async () => {});
//         }
//       );
//       context('delegated category with non-matching category', async () => {
//         it('should fail with insufficient votes', async () => {});
//       });
//       context('delegated category with matching category', async () => {
//         it('should succeed', async () => {});
//       });
//     }
//   );
//   context(
//     'created a proposal but still need 2 votes for approval for complex case',
//     async () => {
//       context(
//         'delegated vote with matching proposal and category',
//         async () => {
//           it('should succeed when attempting start work', async () => {});
//           it('propvotes should contain expected rows', async () => {});
//         }
//       );
//     }
//   );
//   context('undelegate vote', async () => {
//     context('with wrong auth', async () => {
//       it('should fail with wrong auth', async () => {});
//     });
//     context('with correct auth', async () => {
//       it('should succeed to undelegate', async () => {});
//       it('propvotes should have the correct rows', async () => {});
//     });
//   });
// });
