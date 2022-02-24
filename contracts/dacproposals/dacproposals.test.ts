import {
  Account,
  sleep,
  EOSManager,
  debugPromise,
  assertMissingAuthority,
  assertRowsEqual,
  assertEOSErrorIncludesMessage,
  assertRowCount,
  EosioAction,
  ContractLoader,
} from 'lamington';

import { EosioToken } from '../external_contracts/eosio.token/eosio.token';

import { SharedTestObjects } from '../TestHelpers';
import * as chai from 'chai';

import * as chaiAsPromised from 'chai-as-promised';

chai.use(chaiAsPromised);
let shared: SharedTestObjects;

enum VoteType {
  vote_abstain = 0,
  vote_approve,
  vote_deny,
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

describe('Dacproposals', () => {
  let otherAccount: Account;
  let proposer1Account: Account;
  let arbitrator: Account;
  let propDacCustodians: Account[];
  let regMembers: Account[];
  let dacId = 'popdac';
  let delegateeCustodian: Account;
  let proposeApproveTheshold = 4;
  let category = 3;
  let newpropid = 'newpropid';
  let notfoundpropid = 'notfoundid';
  let otherfoundpropid = 'otherid';
  let eosiotoken: EosioToken;

  before(async () => {
    shared = await chai.expect(SharedTestObjects.getInstance()).to.be.fulfilled;

    await shared.initDac(dacId, '4,PROPDAC', '1000000.0000 PROPDAC');
    await shared.updateconfig(dacId, '12.0000 PROPDAC');
    eosiotoken = await ContractLoader.at('eosio.token');
    await chai.expect(
      shared.dac_token_contract.stakeconfig(
        { enabled: true, min_stake_time: 5, max_stake_time: 20 },
        '4,PROPDAC',
        { from: shared.auth_account }
      )
    ).to.eventually.be.fulfilled;

    regMembers = await shared.getRegMembers(dacId, '20000.0000 PROPDAC');
    propDacCustodians = await shared.getStakeObservedCandidates(
      dacId,
      '20.0000 PROPDAC'
    );
    await shared.voteForCustodians(regMembers, propDacCustodians, dacId);
    await shared.daccustodian_contract.newperiod('propDac', dacId, {
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
        await assertMissingAuthority(
          shared.dacproposals_contract.updateconfig(
            {
              proposal_threshold: 7,
              finalize_threshold: 5,
              approval_duration: 130,
              transfer_delay: 3,
            },
            dacId,
            { from: otherAccount }
          )
        );
      });
    });
    context('with valid auth', async () => {
      it('should succeed', async () => {
        await chai.expect(
          shared.dacproposals_contract.updateconfig(
            {
              proposal_threshold: proposeApproveTheshold,
              finalize_threshold: 3,
              approval_duration: 130,
              transfer_delay: 3,
            },
            dacId,
            { from: shared.auth_account }
          )
        ).to.eventually.be.fulfilled;
      });
      it('should have correct config in config table', async () => {
        await assertRowsEqual(
          shared.dacproposals_contract.configTable({ scope: dacId }),
          [
            {
              proposal_threshold: proposeApproveTheshold,
              finalize_threshold: 3,
              approval_duration: 130,
              transfer_delay: 3,
            },
          ]
        );
      });
    });
  });
  context('create proposal', async () => {
    context('without valid permissions', async () => {
      it('should fail with auth error', async () => {
        await assertMissingAuthority(
          shared.dacproposals_contract.createprop(
            proposer1Account.name,
            'title',
            'summary',
            arbitrator.name,
            { quantity: '100.0000 EOS', contract: 'eosio.token' },
            { quantity: '10.0000 PROPDAC', contract: 'eosdactokens' },
            proposalHash,
            newpropid,
            category,
            150,
            dacId,
            { from: regMembers[0] }
          )
        );
      });
    });
    context('with valid auth', async () => {
      context('with invalid title', async () => {
        it('should fail with short title error', async () => {
          await assertEOSErrorIncludesMessage(
            shared.dacproposals_contract.createprop(
              proposer1Account.name,
              'ti',
              'summary',
              arbitrator.name,
              { quantity: '100.0000 EOS', contract: 'eosio.token' },
              { quantity: '10.0000 PROPDAC', contract: 'eosdactokens' },
              proposalHash,
              newpropid,
              category,
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
          await assertEOSErrorIncludesMessage(
            shared.dacproposals_contract.createprop(
              proposer1Account.name,
              'title',
              'su',
              arbitrator.name,
              { quantity: '100.0000 EOS', contract: 'eosio.token' },
              { quantity: '10.0000 PROPDAC', contract: 'eosdactokens' },
              proposalHash,
              newpropid,
              category,
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
          await assertEOSErrorIncludesMessage(
            shared.dacproposals_contract.createprop(
              proposer1Account.name,
              'title',
              'summary',
              arbitrator.name,
              { quantity: '100.0000 sdff', contract: 'eosio.token' },
              { quantity: '10.0000 PROPDAC', contract: 'eosdactokens' },
              proposalHash,
              newpropid,
              category,
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
          await assertEOSErrorIncludesMessage(
            shared.dacproposals_contract.createprop(
              proposer1Account.name,
              'title',
              'summary',
              arbitrator.name,
              { quantity: '100.0000', contract: 'eosio.token' },
              { quantity: '10.0000 PROPDAC', contract: 'eosdactokens' },
              proposalHash,
              newpropid,
              category,
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
          await assertEOSErrorIncludesMessage(
            shared.dacproposals_contract.createprop(
              proposer1Account.name,
              'title',
              'summary',
              arbitrator.name,
              { quantity: '-100.0000 EOS', contract: 'eosio.token' },
              { quantity: '10.0000 PROPDAC', contract: 'eosdactokens' },
              proposalHash,
              newpropid,
              category,
              150,
              dacId,
              { from: proposer1Account }
            ),
            'CREATEPROP_INVALID_proposal_pay'
          );
        });
      });
      context('with no arbitrator', async () => {
        it('should fail with invalid arbitrator error', async () => {
          await assertEOSErrorIncludesMessage(
            shared.dacproposals_contract.createprop(
              proposer1Account.name,
              'title',
              'summary',
              'randomname',
              { quantity: '100.0000 EOS', contract: 'eosio.token' },
              { quantity: '10.0000 PROPDAC', contract: 'eosdactokens' },
              proposalHash,
              newpropid,
              category,
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
              { quantity: '10.0000 PROPDAC', contract: 'eosdactokens' },
              proposalHash,
              newpropid,
              category,
              150,
              dacId,
              { from: proposer1Account }
            ),
            ''
          ).to.eventually.be.fulfilled;
        });
      });
      context('with duplicate id', async () => {
        it('should fail with duplicate ID error', async () => {
          await assertEOSErrorIncludesMessage(
            shared.dacproposals_contract.createprop(
              proposer1Account.name,
              'title',
              'summary',
              'randomname',
              {
                quantity: '100.0000 EOS',
                contract: 'eosio.token',
              },
              { quantity: '10.0000 PROPDAC', contract: 'eosdactokens' },

              proposalHash,
              newpropid,
              category,
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
              { quantity: '10.0000 PROPDAC', contract: 'eosdactokens' },
              proposalHash,
              otherfoundpropid,
              category,
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
        await assertMissingAuthority(
          shared.dacproposals_contract.voteprop(
            propDacCustodians[0].name,
            newpropid,
            VoteType.vote_approve,
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
          await assertEOSErrorIncludesMessage(
            shared.dacproposals_contract.voteprop(
              propDacCustodians[0].name,
              notfoundpropid,
              VoteType.vote_approve,
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
                newpropid,
                VoteType.vote_approve,
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
                newpropid,
                VoteType.vote_deny,
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
                newpropid,
                VoteType.vote_approve,
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
                otherfoundpropid,
                VoteType.vote_approve,
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
                newpropid,
                VoteType.vote_deny,
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
    let delgatepropid = 'delegateprop';
    context('without valid auth', async () => {
      before(async () => {
        await chai.expect(
          shared.dacproposals_contract.createprop(
            proposer1Account.name,
            'startwork_title',
            'startwork_summary',
            arbitrator.name,
            { quantity: '101.0000 EOS', contract: 'eosio.token' },
            { quantity: '10.0000 PROPDAC', contract: 'eosdactokens' },
            'asdfasdfasdfasdfasdfasdfasdffdsa',
            delgatepropid, // proposal id
            category,
            150, // approval duration
            dacId,
            { from: proposer1Account }
          ),
          ''
        ).to.eventually.be.fulfilled;
      });
      it('should fail with invalid auth error', async () => {
        await assertMissingAuthority(
          shared.dacproposals_contract.delegatevote(
            propDacCustodians[0].name,
            delgatepropid, // proposal id
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
          await assertEOSErrorIncludesMessage(
            shared.dacproposals_contract.delegatevote(
              propDacCustodians[1].name,
              notfoundpropid, // proposal id
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
            'PROPOSAL_NOT_FOUND'
          );
        });
      });
      context('delegating to self', async () => {
        it('should fail with Cannot delegate voting to yourself error', async () => {
          await assertEOSErrorIncludesMessage(
            shared.dacproposals_contract.delegatevote(
              propDacCustodians[0].name,
              delgatepropid, // proposal id
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
                delgatepropid, // proposal id
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
    let commentPropId = 'commentprop';
    before(async () => {
      await chai.expect(
        shared.dacproposals_contract.createprop(
          proposer1Account.name,
          'title',
          'summary',
          arbitrator.name,
          { quantity: '100.0000 EOS', contract: 'eosio.token' },
          { quantity: '10.0000 PROPDAC', contract: 'eosdactokens' },
          proposalHash,
          commentPropId,
          category,
          150,
          dacId,
          { from: proposer1Account }
        ),
        ''
      ).to.eventually.be.fulfilled;
    });
    context('without valid auth', async () => {
      it('should fail with invalid auth error', async () => {
        await assertMissingAuthority(
          shared.dacproposals_contract.comment(
            propDacCustodians[0].name,
            notfoundpropid,
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
          await assertEOSErrorIncludesMessage(
            shared.dacproposals_contract.comment(
              propDacCustodians[1].name,
              notfoundpropid, // proposal id
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
            'PROPOSAL_NOT_FOUND'
          );
        });
      });
    });

    context('with custodian only auth', async () => {
      it('should succeed', async () => {
        await chai.expect(
          shared.dacproposals_contract.comment(
            propDacCustodians[3].name,
            commentPropId, // proposal id
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
  });

  context('prepare for start work', async () => {
    //`require_auth` now happens later in the startwork function which cause this test to fail
    context('with valid auth', async () => {
      context('with invalid proposal id', async () => {
        it('should fail with proposal not found error', async () => {
          await assertEOSErrorIncludesMessage(
            shared.dacproposals_contract.startwork(
              notfoundpropid, // proposal id
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
            'PROPOSAL_NOT_FOUND'
          );
        });
      });
    });
    context('proposal in pending_approval state', async () => {
      context('with insufficient votes', async () => {
        it('should fail with insuffient votes error', async () => {
          await assertEOSErrorIncludesMessage(
            shared.dacproposals_contract.startwork(
              newpropid, // proposal id
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
              newpropid,
              VoteType.vote_deny,
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
          await assertEOSErrorIncludesMessage(
            shared.dacproposals_contract.startwork(
              newpropid, // proposal id
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
        for (let index = 0; index < proposeApproveTheshold; index++) {
          const custodian = propDacCustodians[index];
          await shared.dacproposals_contract.voteprop(
            custodian.name,
            newpropid,
            VoteType.vote_approve,
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
            await shared.dacproposals_contract.updpropvotes(newpropid, dacId, {
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
            });
          });
        }
      );
    });
    context('without valid auth', async () => {
      it('should fail with invalid auth error', async () => {
        await assertMissingAuthority(
          shared.dacproposals_contract.startwork(newpropid, dacId, {
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
    context('start work with enough votes', async () => {
      before(async () => {
        let eosLoadAction: EosioAction = {
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
        let propLoadAction: EosioAction = {
          account: shared.dac_token_contract.account.name,
          name: 'transfer',
          authorization: [
            {
              actor: shared.dac_token_contract.account.name,
              permission: 'active',
            },
          ],
          data: {
            from: shared.dac_token_contract.account.name,
            to: shared.treasury_account.name,
            quantity: '100000.0000 PROPDAC',
            memo: 'initial funds for proposal payments',
          },
        };
        await EOSManager.transact({ actions: [eosLoadAction, propLoadAction] });
      });

      it('should succeed', async () => {
        await chai.expect(
          shared.dacproposals_contract.startwork(
            newpropid, // proposal id
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
      context('Without delay', async () => {
        it('should populate the escrow table', async () => {
          let proposalRow = await shared.dacescrow_contract.escrowsTable({
            scope: 'dacescrow',
          });
          let row = proposalRow.rows[0];
          chai.expect(row.key).to.eq(newpropid);
          chai.expect(row.sender).to.eq('treasury');
          chai.expect(row.receiver).to.eq(proposer1Account.name);
          chai.expect(row.arb).to.eq(arbitrator.name);
          chai.expect(row.receiver_pay.quantity).to.eq('100.0000 EOS');
          chai
            .expect(row.memo)
            .to.eq(`${proposer1Account.name}:${newpropid}:${proposalHash}`);
          chai.expect(row.expires).to.be.afterTime(new Date(Date.now()));
          chai.expect(row.arbitrator_pay.quantity).to.eq('10.0000 PROPDAC');
        });
        it('should update the proposal state to in_progress', async () => {
          let proposalRow = await shared.dacproposals_contract.proposalsTable({
            scope: dacId,
            lowerBound: newpropid,
            upperBound: newpropid,
          });
          let row = proposalRow.rows[0];
          chai.expect(row.proposal_id).to.eq(newpropid);
          chai.expect(row.arbitrator).to.eq(arbitrator.name);
          chai.expect(row.content_hash).to.eq(proposalHash);
          chai
            .expect(row.state)
            .to.eq(ProposalState.ProposalStateWork_in_progress);
        });
      });
    });
    context('proposal not in pending_approval state', async () => {
      it('should fail with proposal is not in pensing approval state error', async () => {
        await assertEOSErrorIncludesMessage(
          shared.dacproposals_contract.startwork(
            newpropid, // proposal id
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
      let propId = 'shortexpprop';
      it('should create a proposal with a short expiry', async () => {
        await chai.expect(
          shared.dacproposals_contract.updateconfig(
            {
              proposal_threshold: proposeApproveTheshold,
              finalize_threshold: 5,
              approval_duration: 3, // set short for expiry of the
              transfer_delay: 3,
            },
            dacId,
            { from: shared.auth_account }
          )
        ).to.eventually.be.fulfilled;
        await chai.expect(
          shared.dacproposals_contract.createprop(
            proposer1Account.name,
            'startwork_title',
            'startwork_summary',
            arbitrator.name,
            { quantity: '105.0000 EOS', contract: 'eosio.token' },
            { quantity: '10.0000 PROPDAC', contract: 'eosdactokens' },
            'asdfasdfasdfasdfasdfasdfajjhjhjsdffdsa',
            propId, // proposal id
            category,
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
            propId,
            VoteType.vote_deny,
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
          await assertEOSErrorIncludesMessage(
            shared.dacproposals_contract.startwork(
              propId, // proposal id
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
          await assertEOSErrorIncludesMessage(
            shared.dacproposals_contract.startwork(
              propId, // proposal id
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
      context('clear expired proposals', async () => {
        it('should have the 1 of votes before clearing for the proposal', async () => {
          await assertRowCount(
            shared.dacproposals_contract.propvotesTable({
              scope: dacId,
              indexPosition: 3,
              keyType: 'i64',
              lowerBound: propId,
              upperBound: propId,
            }),
            1
          );
        });
        it('should have a proposal record before clearing', async () => {
          await assertRowCount(
            shared.dacproposals_contract.proposalsTable({
              scope: dacId,
              lowerBound: propId,
              upperBound: propId,
            }),
            1
          );
        });
        it('should not allow to clear unexpired proposals', async () => {
          await assertEOSErrorIncludesMessage(
            shared.dacproposals_contract.clearexpprop(newpropid, dacId, {
              from: proposer1Account,
            }),
            'ERR::PROPOSAL_NOT_EXPIRED'
          );
        });
        it('should clear the expired proposals', async () => {
          await chai.expect(
            shared.dacproposals_contract.clearexpprop(propId, dacId, {
              from: shared.auth_account,
            })
          ).to.eventually.fulfilled;
        });
        context('After clearing expired proposals', async () => {
          it('should remove the related proposal', async () => {
            await assertRowCount(
              shared.dacproposals_contract.proposalsTable({
                scope: dacId,
                lowerBound: propId,
                upperBound: propId,
              }),
              0
            );
          });
          it('should remove the related votes for the proposal', async () => {
            await assertRowCount(
              shared.dacproposals_contract.propvotesTable({
                scope: dacId,
                indexPosition: 3,
                keyType: 'i64',
                lowerBound: propId,
                upperBound: propId,
              }),
              0
            );
          });
        });
      });
    });
  });

  context(
    'voteprop with valid auth and proposal in work_in_progress state',
    async () => {
      context('voteup', async () => {
        it('should fail with invalid state to accept votes', async () => {
          await assertEOSErrorIncludesMessage(
            shared.dacproposals_contract.voteprop(
              propDacCustodians[0].name,
              newpropid,
              VoteType.vote_approve,
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
          await assertEOSErrorIncludesMessage(
            shared.dacproposals_contract.voteprop(
              propDacCustodians[0].name,
              newpropid,
              VoteType.vote_deny,
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
        await assertEOSErrorIncludesMessage(
          shared.dacproposals_contract.completework(notfoundpropid, dacId, {
            from: proposer1Account,
          }),
          'PROPOSAL_NOT_FOUND'
        );
      });
    });
    context('with incorrect auth', async () => {
      it('should fail with auth error', async () => {
        await assertMissingAuthority(
          shared.dacproposals_contract.completework(newpropid, dacId, {
            auths: [{ actor: propDacCustodians[1].name, permission: 'active' }],
          })
        );
      });
    });
    context('proposal in pending approval state', async () => {
      let wrongStateProp = 'wrongpropid';
      before(async () => {
        await chai.expect(
          shared.dacproposals_contract.createprop(
            proposer1Account.name,
            'startwork_title',
            'startwork_summary',
            arbitrator.name,
            { quantity: '101.0000 EOS', contract: 'eosio.token' },
            { quantity: '10.0000 PROPDAC', contract: 'eosdactokens' },
            'asdfasdfasdfasdfasdfasdfasdffdsa',
            wrongStateProp, // proposal id
            category,
            150, // approval duration
            dacId,
            { from: proposer1Account }
          ),
          ''
        ).to.eventually.be.fulfilled;
      });
      it('should fail with incorrect to state to complete error', async () => {
        await assertEOSErrorIncludesMessage(
          shared.dacproposals_contract.completework(wrongStateProp, dacId, {
            from: proposer1Account,
          }),
          'COMPLETEWORK_WRONG_STATE'
        );
      });
    });
    context('proposal in work_in_progress state', async () => {
      it('should allow completework', async () => {
        await chai.expect(
          shared.dacproposals_contract.completework(newpropid, dacId, {
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
        await assertEOSErrorIncludesMessage(
          shared.dacproposals_contract.finalize(notfoundpropid, dacId, {
            from: proposer1Account,
          }),
          'PROPOSAL_NOT_FOUND'
        );
      });
    });

    context('proposal not in pending_finalize state', async () => {
      let wrongFinProp = 'wrongfinid';
      before(async () => {
        await chai.expect(
          shared.dacproposals_contract.createprop(
            proposer1Account.name,
            'startwork_title',
            'startwork_summary',
            arbitrator.name,
            { quantity: '101.0000 EOS', contract: 'eosio.token' },
            { quantity: '10.0000 PROPDAC', contract: 'eosdactokens' },
            'asdfasdfasdfasdfasdfasdfasdffdsa',
            wrongFinProp, // proposal id
            category,
            150, // approval duration
            dacId,
            { from: proposer1Account }
          ),
          ''
        ).to.eventually.be.fulfilled;
      });
      before(async () => {
        await shared.dacproposals_contract.updpropvotes(wrongFinProp, dacId, {
          from: proposer1Account,
        });
      });
      it('should fail with not in pending_finalize state error', async () => {
        await assertEOSErrorIncludesMessage(
          shared.dacproposals_contract.finalize(wrongFinProp, dacId, {
            from: proposer1Account,
          }),
          'FINALIZE_WRONG_STATE'
        );
      });
    });
    context('proposal in pending_finalize state', async () => {
      before(async () => {
        await shared.dacproposals_contract.updpropvotes(newpropid, dacId, {
          from: proposer1Account,
        });
      });
      context('without enough votes to approve the finalize', async () => {
        it('should fail to complete work with not enough votes error', async () => {
          await assertEOSErrorIncludesMessage(
            shared.dacproposals_contract.finalize(newpropid, dacId, {
              from: proposer1Account,
            }),
            'FINALIZE_INSUFFICIENT_VOTES'
          );
        });
      });
      context(
        'with enough votes to complete finalize with denial',
        async () => {
          context('before finalize is run', async () => {
            it('proposer should not yet have been paid', async () => {
              await assertRowCount(
                eosiotoken.accountsTable({
                  scope: proposer1Account.name,
                }),
                0
              );
            });
            it('arb should not yet have been paid', async () => {
              await assertRowsEqual(
                shared.dac_token_contract.accountsTable({
                  scope: arbitrator.name,
                }),
                [{ balance: '20000.0000 PROPDAC' }]
              );
            });
            it('dacescrow should be loaded with arbitrator funds', async () => {
              await assertRowsEqual(
                shared.dac_token_contract.accountsTable({
                  scope: shared.dacescrow_contract.account.name,
                }),
                [{ balance: '10.0000 PROPDAC' }]
              );
            });
            it('treasury should sent funds to escrow', async () => {
              await assertRowsEqual(
                shared.dac_token_contract.accountsTable({
                  scope: shared.treasury_account.name,
                }),
                [{ balance: '99990.0000 PROPDAC' }]
              );
            });
          });
          context('with enough finalize_approve votes to approve', async () => {
            before(async () => {
              for (const custodian of propDacCustodians) {
                await shared.dacproposals_contract.votepropfin(
                  custodian.name,
                  newpropid,
                  VoteType.vote_approve,
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
            it('finalize should succeed', async () => {
              await chai.expect(
                shared.dacproposals_contract.finalize(newpropid, dacId, {
                  from: proposer1Account,
                })
              ).to.eventually.be.fulfilled;
            });
          });
          context('after finalize is run', async () => {
            it('proposer should have been paid', async () => {
              await assertRowsEqual(
                eosiotoken.accountsTable({
                  scope: proposer1Account.name,
                }),
                [{ balance: '100.0000 EOS' }]
              );
            });
            it('arb should not have been paid', async () => {
              await assertRowsEqual(
                shared.dac_token_contract.accountsTable({
                  scope: proposer1Account.name,
                }),
                [{ balance: '20000.0000 PROPDAC' }]
              );
            });
            it('dacescrow should have returned the arbitrator funds', async () => {
              await assertRowsEqual(
                shared.dac_token_contract.accountsTable({
                  scope: arbitrator.name,
                }),
                [{ balance: '20000.0000 PROPDAC' }]
              );
            });
            it('dacescrow arbitrator funds should be returned to treasury', async () => {
              await assertRowsEqual(
                shared.dac_token_contract.accountsTable({
                  scope: shared.treasury_account.name,
                }),
                [{ balance: '100000.0000 PROPDAC' }]
              );
            });
          });
          context('Read the proposals table after finalize', async () => {
            it('should have removed the finalized proposal', async () => {
              await assertRowCount(
                shared.dacproposals_contract.proposalsTable({
                  scope: dacId,
                  lowerBound: newpropid,
                  upperBound: newpropid,
                }),
                0
              );
            });
            it('escrow table should contain 0 row after finalize is done', async () => {
              await assertRowCount(
                shared.dacescrow_contract.escrowsTable({
                  scope: 'dacescrow',
                }),
                0
              );
            });
          });
        }
      );
    });
  });

  context('arbapprove', async () => {
    let arbApproveId = 'arbapproveid';
    context('with invalid prop', async () => {
      it('should fail with proposal not found error', async () => {
        await assertEOSErrorIncludesMessage(
          shared.dacproposals_contract.arbapprove(
            arbitrator.name,
            notfoundpropid,
            dacId,
            { from: arbitrator }
          ),
          'ERR::PROPOSAL_NOT_FOUND'
        );
      });
    });
    context('with valid prop id', async () => {
      before(async () => {
        await shared.dacproposals_contract.updateconfig(
          {
            proposal_threshold: proposeApproveTheshold,
            finalize_threshold: 5,
            approval_duration: 30,
            transfer_delay: 3,
          },
          dacId,
          { from: shared.auth_account }
        );
        await chai.expect(
          shared.dacproposals_contract.createprop(
            proposer1Account.name,
            'title',
            'summary',
            arbitrator.name,
            { quantity: '100.0000 EOS', contract: 'eosio.token' },
            { quantity: '10.0000 PROPDAC', contract: 'eosdactokens' },
            proposalHash,
            arbApproveId,
            category,
            150,
            dacId,
            { from: proposer1Account }
          ),
          ''
        ).to.eventually.be.fulfilled;

        for (let index = 0; index < proposeApproveTheshold; index++) {
          const custodian = propDacCustodians[index];
          await shared.dacproposals_contract.voteprop(
            custodian.name,
            arbApproveId,
            VoteType.vote_approve,
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
        await chai.expect(
          shared.dacproposals_contract.updpropvotes(arbApproveId, dacId, {
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

        await chai.expect(
          shared.dacproposals_contract.startwork(arbApproveId, dacId, {
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
        await sleep(6000);
      });
      context('called by user other than arbitrator', async () => {
        it('It should not arbitrator error', async () => {
          await assertEOSErrorIncludesMessage(
            shared.dacproposals_contract.arbapprove(
              proposer1Account.name,
              arbApproveId,
              dacId,
              { from: proposer1Account }
            ),
            'ERR::NOT_ARBITRATOR'
          );
        });
      });
      context('With a currently active escrow', async () => {
        it('It should fail with escrow still active error', async () => {
          await assertEOSErrorIncludesMessage(
            shared.dacproposals_contract.arbapprove(
              arbitrator.name,
              arbApproveId,
              dacId,
              { from: arbitrator }
            ),
            'ERR::ESCROW_STILL_ACTIVE'
          );
        });
      });
      context('Without escrow and proposal in dispute', async () => {
        before(async () => {
          //First complete work on WP
          await chai.expect(
            shared.dacproposals_contract.completework(arbApproveId, dacId, {
              from: proposer1Account,
            })
          ).to.eventually.be.fulfilled;
        });
        it('It should prevent arbapprove with wrong state error.', async () => {
          let escrowAction: EosioAction = {
            account: shared.dacescrow_contract.account.name,
            name: 'approve',
            authorization: [{ actor: arbitrator.name, permission: 'active' }],
            data: {
              key: arbApproveId,
              approver: arbitrator.name,
            },
          };
          let proposalAction: EosioAction = {
            account: shared.dacproposals_contract.account.name,
            name: 'arbapprove',
            authorization: [{ actor: arbitrator.name, permission: 'active' }],
            data: {
              arbitrator: arbitrator.name,
              proposal_id: arbApproveId,
              dac_id: dacId,
            },
          };
          await assertEOSErrorIncludesMessage(
            EOSManager.transact({ actions: [escrowAction, proposalAction] }),
            'ERR::ESCROW_IS_NOT_LOCKED'
          );
        });
      });
      context('before escrow arb approve', async () => {
        it('proposer should not yet have been paid', async () => {
          await assertRowsEqual(
            eosiotoken.accountsTable({
              scope: proposer1Account.name,
            }),
            [{ balance: '100.0000 EOS' }]
          );
        });
        it('arbitrator should not have been paid', async () => {
          await assertRowsEqual(
            shared.dac_token_contract.accountsTable({
              scope: arbitrator.name,
            }),
            [{ balance: '20000.0000 PROPDAC' }]
          );
        });
        it('dacescrow should be loaded with arbitrator funds', async () => {
          await assertRowsEqual(
            shared.dac_token_contract.accountsTable({
              scope: shared.dacescrow_contract.account.name,
            }),
            [{ balance: '10.0000 PROPDAC' }]
          );
        });
        it('treasury should sent funds to escrow', async () => {
          await assertRowsEqual(
            shared.dac_token_contract.accountsTable({
              scope: shared.treasury_account.name,
            }),
            [{ balance: '99990.0000 PROPDAC' }]
          );
        });
      });
      context('After the escrow and proposal have been disputed', async () => {
        before(async () => {
          // Dispute the proposal for not getting approved.
          let escrowAction: EosioAction = {
            account: shared.dacescrow_contract.account.name,
            name: 'dispute',
            authorization: [
              { actor: proposer1Account.name, permission: 'active' },
            ],
            data: {
              key: arbApproveId,
            },
          };
          let proposalAction: EosioAction = {
            account: shared.dacproposals_contract.account.name,
            name: 'dispute',
            authorization: [
              { actor: proposer1Account.name, permission: 'active' },
            ],
            data: {
              proposal_id: arbApproveId,
              dac_id: dacId,
            },
          };
          await chai.expect(
            EOSManager.transact({ actions: [escrowAction, proposalAction] })
          ).to.eventually.be.fulfilled;
        });
        it('It should succeed to allow arbapprove', async () => {
          let escrowAction: EosioAction = {
            account: shared.dacescrow_contract.account.name,
            name: 'approve',
            authorization: [{ actor: arbitrator.name, permission: 'active' }],
            data: {
              key: arbApproveId,
              approver: arbitrator.name,
            },
          };
          let proposalAction: EosioAction = {
            account: shared.dacproposals_contract.account.name,
            name: 'arbapprove',
            authorization: [{ actor: arbitrator.name, permission: 'active' }],
            data: {
              arbitrator: arbitrator.name,
              proposal_id: arbApproveId,
              dac_id: dacId,
            },
          };
          await chai.expect(
            EOSManager.transact({ actions: [escrowAction, proposalAction] })
          ).to.eventually.be.fulfilled;
        });
      });
      context('after arb approve is run', async () => {
        it('proposer should have been paid', async () => {
          await assertRowsEqual(
            eosiotoken.accountsTable({
              scope: proposer1Account.name,
            }),
            [{ balance: '200.0000 EOS' }]
          );
        });
        it('arbitrator should have been paid', async () => {
          await assertRowsEqual(
            shared.dac_token_contract.accountsTable({
              scope: arbitrator.name,
            }),
            [{ balance: '20010.0000 PROPDAC' }]
          );
        });

        it('dacescrow arbitrator funds should not be returned to treasury', async () => {
          await assertRowsEqual(
            shared.dac_token_contract.accountsTable({
              scope: shared.treasury_account.name,
            }),
            [{ balance: '99990.0000 PROPDAC' }]
          );
        });
      });
    });
  });
  context('arbdeny', async () => {
    let arbDenyId = 'arbdenyid';
    context('with invalid prop', async () => {
      it('should fail with proposal not found error', async () => {
        await assertEOSErrorIncludesMessage(
          shared.dacproposals_contract.arbapprove(
            arbitrator.name,
            notfoundpropid,
            dacId,
            { from: arbitrator }
          ),
          'ERR::PROPOSAL_NOT_FOUND'
        );
      });
    });
    context('with valid prop id', async () => {
      before(async () => {
        await shared.dacproposals_contract.updateconfig(
          {
            proposal_threshold: proposeApproveTheshold,
            finalize_threshold: 5,
            approval_duration: 30,
            transfer_delay: 3,
          },
          dacId,
          { from: shared.auth_account }
        );
        await chai.expect(
          shared.dacproposals_contract.createprop(
            proposer1Account.name,
            'title',
            'summary',
            arbitrator.name,
            { quantity: '100.0000 EOS', contract: 'eosio.token' },
            { quantity: '10.0000 PROPDAC', contract: 'eosdactokens' },
            proposalHash,
            arbDenyId,
            category,
            150,
            dacId,
            { from: proposer1Account }
          ),
          ''
        ).to.eventually.be.fulfilled;

        for (let index = 0; index < proposeApproveTheshold; index++) {
          const custodian = propDacCustodians[index];
          await shared.dacproposals_contract.voteprop(
            custodian.name,
            arbDenyId,
            VoteType.vote_approve,
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
        await chai.expect(
          shared.dacproposals_contract.updpropvotes(arbDenyId, dacId, {
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

        await chai.expect(
          shared.dacproposals_contract.startwork(arbDenyId, dacId, {
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
        await sleep(6000);
      });
      context('called by user other than arbitrator', async () => {
        it('It should not arbitrator error', async () => {
          await assertEOSErrorIncludesMessage(
            shared.dacproposals_contract.arbdeny(
              proposer1Account.name,
              arbDenyId,
              dacId,
              { from: proposer1Account }
            ),
            'ERR::NOT_ARBITRATOR'
          );
        });
      });
      context('With a currently active escrow', async () => {
        it('It should fail with escrow still active error', async () => {
          await assertEOSErrorIncludesMessage(
            shared.dacproposals_contract.arbdeny(
              arbitrator.name,
              arbDenyId,
              dacId,
              { from: arbitrator }
            ),
            'ERR::ESCROW_STILL_ACTIVE'
          );
        });
      });
      context('Without escrow and proposal in dispute', async () => {
        before(async () => {
          //First complete work on WP
          await chai.expect(
            shared.dacproposals_contract.completework(arbDenyId, dacId, {
              from: proposer1Account,
            })
          ).to.eventually.be.fulfilled;
        });
        it('It should prevent arbdeny with wrong state error.', async () => {
          let escrowAction: EosioAction = {
            account: shared.dacescrow_contract.account.name,
            name: 'disapprove',
            authorization: [{ actor: arbitrator.name, permission: 'active' }],
            data: {
              key: arbDenyId,
              disapprover: arbitrator.name,
            },
          };
          let proposalAction: EosioAction = {
            account: shared.dacproposals_contract.account.name,
            name: 'arbdeny',
            authorization: [{ actor: arbitrator.name, permission: 'active' }],
            data: {
              arbitrator: arbitrator.name,
              proposal_id: arbDenyId,
              dac_id: dacId,
            },
          };
          await assertEOSErrorIncludesMessage(
            EOSManager.transact({ actions: [escrowAction, proposalAction] }),
            'ERR::ESCROW_IS_NOT_LOCKED'
          );
        });
      });
      context('After the escrow and proposal have been disputed', async () => {
        context('before escrow arb deny', async () => {
          it('proposer should have been paid', async () => {
            await assertRowsEqual(
              eosiotoken.accountsTable({
                scope: proposer1Account.name,
              }),
              [{ balance: '200.0000 EOS' }]
            );
          });
          it('arbitrator should have been paid', async () => {
            await assertRowsEqual(
              shared.dac_token_contract.accountsTable({
                scope: arbitrator.name,
              }),
              [{ balance: '20020.0000 PROPDAC' }]
            );
          });
          it('dacescrow should be sent arbitrator funds', async () => {
            await assertRowsEqual(
              shared.dac_token_contract.accountsTable({
                scope: shared.dacescrow_contract.account.name,
              }),
              [{ balance: '0.0000 PROPDAC' }]
            );
          });
          it('treasury should sent funds to escrow', async () => {
            await assertRowsEqual(
              shared.dac_token_contract.accountsTable({
                scope: shared.treasury_account.name,
              }),
              [{ balance: '99980.0000 PROPDAC' }]
            );
          });
        });
        before(async () => {
          // Dispute the proposal for not getting approved.
          let escrowAction: EosioAction = {
            account: shared.dacescrow_contract.account.name,
            name: 'dispute',
            authorization: [
              { actor: proposer1Account.name, permission: 'active' },
            ],
            data: {
              key: arbDenyId,
            },
          };
          let proposalAction: EosioAction = {
            account: shared.dacproposals_contract.account.name,
            name: 'dispute',
            authorization: [
              { actor: proposer1Account.name, permission: 'active' },
            ],
            data: {
              proposal_id: arbDenyId,
              dac_id: dacId,
            },
          };
          await chai.expect(
            EOSManager.transact({ actions: [escrowAction, proposalAction] })
          ).to.eventually.be.fulfilled;
        });
        it('It should succeed to allow arbdeny', async () => {
          let escrowAction: EosioAction = {
            account: shared.dacescrow_contract.account.name,
            name: 'disapprove',
            authorization: [{ actor: arbitrator.name, permission: 'active' }],
            data: {
              key: arbDenyId,
              disapprover: arbitrator.name,
            },
          };
          let proposalAction: EosioAction = {
            account: shared.dacproposals_contract.account.name,
            name: 'arbdeny',
            authorization: [{ actor: arbitrator.name, permission: 'active' }],
            data: {
              arbitrator: arbitrator.name,
              proposal_id: arbDenyId,
              dac_id: dacId,
            },
          };
          await chai.expect(
            EOSManager.transact({ actions: [escrowAction, proposalAction] })
          ).to.eventually.be.fulfilled;
        });
        context('after arbdeny is run', async () => {
          it('proposer should have been paid', async () => {
            await assertRowsEqual(
              eosiotoken.accountsTable({
                scope: proposer1Account.name,
              }),
              [{ balance: '200.0000 EOS' }]
            );
          });
          it('arbitrator should have been paid', async () => {
            await assertRowsEqual(
              shared.dac_token_contract.accountsTable({
                scope: arbitrator.name,
              }),
              [{ balance: '20020.0000 PROPDAC' }]
            );
          });

          it('dacescrow arbitrator funds should be returned to treasury', async () => {
            await assertRowsEqual(
              shared.dac_token_contract.accountsTable({
                scope: shared.treasury_account.name,
              }),
              [{ balance: '99980.0000 PROPDAC' }]
            );
          });
        });
      });
    });
  });
  context('cancelwip tests', async () => {
    let cancelpropid = 'cancelwipid';
    before(async () => {
      await shared.dacproposals_contract.updateconfig(
        {
          proposal_threshold: proposeApproveTheshold,
          finalize_threshold: 5,
          approval_duration: 30,
          transfer_delay: 3,
        },
        dacId,
        { from: shared.auth_account }
      );
      await chai.expect(
        shared.dacproposals_contract.createprop(
          proposer1Account.name,
          'startwork_title',
          'startwork_summary',
          arbitrator.name,
          { quantity: '106.0000 EOS', contract: 'eosio.token' },
          { quantity: '10.0000 PROPDAC', contract: 'eosdactokens' },
          'asdfasdfasdfasdfasdfasdfajjhjhjsdffdsa',
          cancelpropid, // proposal id
          category,
          130, // job duration
          dacId,
          { from: proposer1Account }
        ),
        ''
      ).to.eventually.be.fulfilled;
      for (let index = 0; index < proposeApproveTheshold; index++) {
        const custodian = propDacCustodians[index];
        await debugPromise(
          shared.dacproposals_contract.voteprop(
            custodian.name,
            cancelpropid, // proposal id
            VoteType.vote_approve,
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
        await assertMissingAuthority(
          shared.dacproposals_contract.cancelprop(cancelpropid, dacId, {
            from: otherAccount,
          })
        );
      });
    });
    context('with valid auth', async () => {
      context('with invalid proposal id', async () => {
        it('should fail with proposal not found error', async () => {
          await assertEOSErrorIncludesMessage(
            shared.dacproposals_contract.cancelprop(notfoundpropid, dacId, {
              from: proposer1Account,
            }),
            'PROPOSAL_NOT_FOUND'
          );
        });
      });
      context('with valid proposal id', async () => {
        context('after starting work but before completing', async () => {
          before(async () => {
            await shared.dacproposals_contract.startwork(cancelpropid, dacId, {
              from: proposer1Account,
            });
            await sleep(6000); // wait for the escrow to be loaded.
          });
          it('should initially contain proposal', async () => {
            await assertRowCount(
              shared.dacproposals_contract.proposalsTable({
                scope: dacId,
                lowerBound: cancelpropid,
                upperBound: cancelpropid,
              }),
              1
            );
          });
          it('should contain initial votes for proposal', async () => {
            let result = await shared.dacproposals_contract.propvotesTable({
              scope: dacId,
              indexPosition: 3,
              keyType: 'i64',
              lowerBound: cancelpropid,
              upperBound: cancelpropid,
            });
            chai.expect(result.rows.length).equal(proposeApproveTheshold);
          });
          it('cancelprop should fail with active escrow error', async () => {
            await assertEOSErrorIncludesMessage(
              shared.dacproposals_contract.cancelprop(cancelpropid, dacId, {
                from: proposer1Account,
              }),
              'ERR::CANCELPROP_WRONG_STATE'
            );
          });
          it('should succeed', async () => {
            await chai.expect(
              shared.dacproposals_contract.cancelwip(cancelpropid, dacId, {
                from: proposer1Account,
              })
            ).to.eventually.be.fulfilled;
          });
          it('should not contain proposal', async () => {
            await assertRowCount(
              shared.dacproposals_contract.proposalsTable({
                scope: dacId,
                lowerBound: cancelpropid,
                upperBound: cancelpropid,
              }),
              0
            );
          });
          it('should not contain initial votes for proposal', async () => {
            await assertRowCount(
              shared.dacproposals_contract.propvotesTable({
                scope: dacId,
                indexPosition: 3,
                keyType: 'i64',
                lowerBound: cancelpropid,
                upperBound: cancelpropid,
              }),
              0
            );
          });
        });
        it('escrow table should contain expected rows', async () => {});
      });
    });
  });
  context('cancelprop tests', async () => {
    let cancelpropid = 'cancelpropid';
    before(async () => {
      await shared.dacproposals_contract.updateconfig(
        {
          proposal_threshold: proposeApproveTheshold,
          finalize_threshold: 5,
          approval_duration: 30,
          transfer_delay: 3,
        },
        dacId,
        { from: shared.auth_account }
      );
      await chai.expect(
        shared.dacproposals_contract.createprop(
          proposer1Account.name,
          'startwork_title',
          'startwork_summary',
          arbitrator.name,
          { quantity: '106.0000 EOS', contract: 'eosio.token' },
          { quantity: '10.0000 PROPDAC', contract: 'eosdactokens' },
          'asdfasdfasdfasdfasdfasdfajjhjhjsdffdsa',
          cancelpropid, // proposal id
          category,
          130, // job duration
          dacId,
          { from: proposer1Account }
        ),
        ''
      ).to.eventually.be.fulfilled;
    });
    context('without valid auth', async () => {
      it('should fail with invalid auth error', async () => {
        await assertMissingAuthority(
          shared.dacproposals_contract.cancelprop(cancelpropid, dacId, {
            from: otherAccount,
          })
        );
      });
    });
    context('with valid auth', async () => {
      context('with invalid proposal id', async () => {
        it('should fail with proposal not found error', async () => {
          await assertEOSErrorIncludesMessage(
            shared.dacproposals_contract.cancelprop(notfoundpropid, dacId, {
              from: proposer1Account,
            }),
            'PROPOSAL_NOT_FOUND'
          );
        });
      });
      context('with valid proposal id', async () => {
        context('after starting work but before completing', async () => {
          it('should initially contain proposal', async () => {
            await assertRowCount(
              shared.dacproposals_contract.proposalsTable({
                scope: dacId,
                lowerBound: cancelpropid,
                upperBound: cancelpropid,
              }),
              1
            );
          });
          it('cancelwip should fail with escrow error', async () => {
            await assertEOSErrorIncludesMessage(
              shared.dacproposals_contract.cancelwip(cancelpropid, dacId, {
                from: proposer1Account,
              }),
              'ERR::CANCELWIP_WRONG_STATE'
            );
          });
          it('should succeed', async () => {
            await chai.expect(
              shared.dacproposals_contract.cancelprop(cancelpropid, dacId, {
                from: proposer1Account,
              })
            ).to.eventually.be.fulfilled;
          });
          it('should not contain proposal', async () => {
            await assertRowCount(
              shared.dacproposals_contract.proposalsTable({
                scope: dacId,
                lowerBound: cancelpropid,
                upperBound: cancelpropid,
              }),
              0
            );
          });
          it('should not contain initial votes for proposal', async () => {
            await assertRowCount(
              shared.dacproposals_contract.propvotesTable({
                scope: dacId,
                indexPosition: 3,
                keyType: 'i64',
                lowerBound: cancelpropid,
                upperBound: cancelpropid,
              }),
              0
            );
          });
        });
        it('escrow table should contain expected rows', async () => {});
      });
    });
  });
  context('delegate categories', async () => {
    let propId = 'delegateid2';
    context(
      'created proposal but still needing one vote for approval',
      async () => {
        before(async () => {
          await shared.dacproposals_contract.updateconfig(
            {
              proposal_threshold: proposeApproveTheshold,
              finalize_threshold: 5,
              approval_duration: 130,
              transfer_delay: 3,
            },
            dacId,
            { from: shared.auth_account }
          );
          await chai.expect(
            shared.dacproposals_contract.createprop(
              proposer1Account.name,
              'delegate categories_title',
              'delegate categories_summary',
              arbitrator.name,
              { quantity: '106.0000 EOS', contract: 'eosio.token' },
              { quantity: '10.0000 PROPDAC', contract: 'eosdactokens' },
              'asdfasdfasdfasdfasdfasdfajjhjhjsdffdsa',
              propId, // proposal id
              category, // category number
              130, // job duration
              dacId,
              { from: proposer1Account }
            ),
            ''
          ).to.eventually.be.fulfilled;
          for (let index = 0; index < proposeApproveTheshold - 1; index++) {
            const custodian = propDacCustodians[index];
            await debugPromise(
              shared.dacproposals_contract.voteprop(
                custodian.name,
                propId, // proposal id
                VoteType.vote_approve,
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
              `vote approve for proposal ${propId}`
            );
          }
        });
        context(
          'delegate category for a vote with pre-existing vote should have no effect',
          async () => {
            before(async () => {
              await debugPromise(
                shared.dacproposals_contract.delegatecat(
                  propDacCustodians[1].name,
                  category,
                  propDacCustodians[2].name,
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
                'delegate category for voter with a pre-exisiting direct vote'
              );
            });
            it('should fail with insufficient votes', async () => {
              await assertEOSErrorIncludesMessage(
                shared.dacproposals_contract.startwork(
                  propId, // proposal id
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
          }
        );
        context('delegated vote with non-matching category', async () => {
          before(async () => {
            await debugPromise(
              shared.dacproposals_contract.delegatecat(
                propDacCustodians[3].name,
                90, // non-matching category
                propDacCustodians[2].name,
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
              ),
              'delegate category to a non-mathing category'
            );
          });
          it('should fail with insufficient votes', async () => {
            await assertEOSErrorIncludesMessage(
              shared.dacproposals_contract.startwork(
                propId, // proposal id
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
        context('delegated category with matching category', async () => {
          before(async () => {
            await debugPromise(
              shared.dacproposals_contract.delegatecat(
                propDacCustodians[3].name,
                category, // non-matching category
                propDacCustodians[2].name,
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
              ),
              'delegate matching category to an existing voter'
            );
          });
          it('should succeed to allow start work', async () => {
            await shared.dacproposals_contract.startwork(
              propId, // proposal id
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
            );
          });
        });
      }
    );
    // context(
    //   'created a proposal but still need one vote for approval for categories',
    //   async () => {
    //     context(
    //       'delegated category with already voted custodian should have no effect',
    //       async () => {
    //         it('should fail with insufficient votes', async () => {
    //           chai.expect(false).to.eq(true);
    //         });
    //       }
    //     );
    //     context('delegated category with non-matching category', async () => {
    //       it('should fail with insufficient votes', async () => {});
    //     });
    //     context('delegated category with matching category', async () => {
    //       it('should succeed', async () => {});
    //     });
    //   }
    // );
    context(
      'created a proposal but still need 2 votes for approval for complex case',
      async () => {
        let propId = 'complexprop';
        before(async () => {
          await chai.expect(
            shared.dacproposals_contract.createprop(
              proposer1Account.name,
              'delegate complex title',
              'delegate complex_summary',
              arbitrator.name,
              { quantity: '106.0000 EOS', contract: 'eosio.token' },
              { quantity: '10.0000 PROPDAC', contract: 'eosdactokens' },
              'asdfasdfasdfasdfasdfasdfajjhjhjsdffdsa',
              propId, // proposal id
              category, // category number
              130, // job duration
              dacId,
              { from: proposer1Account }
            ),
            ''
          ).to.eventually.be.fulfilled;
          for (let index = 0; index < proposeApproveTheshold - 2; index++) {
            const custodian = propDacCustodians[index];
            await debugPromise(
              shared.dacproposals_contract.voteprop(
                custodian.name,
                propId, // proposal id
                VoteType.vote_approve,
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
              `vote approve for proposal ${propId}`
            );
          }
        });
        context(
          'delegated vote with matching proposal and category',
          async () => {
            before(async () => {
              await chai.expect(
                shared.dacproposals_contract.delegatecat(
                  propDacCustodians[2].name,
                  category, // matching category
                  propDacCustodians[1].name,
                  dacId,
                  {
                    auths: [
                      {
                        actor: propDacCustodians[2].name,
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

              await chai.expect(
                shared.dacproposals_contract.delegatevote(
                  propDacCustodians[3].name,
                  propId,
                  propDacCustodians[1].name,
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
              ).eventually.be.fulfilled;
            });
            it('should succeed when attempting start work', async () => {
              await shared.dacproposals_contract.startwork(
                propId, // proposal id
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
              );
            });
            it('propvotes should contain 3 votes for this proposal - one as a delegated vote', async () => {
              await assertRowCount(
                shared.dacproposals_contract.propvotesTable({
                  scope: dacId,
                  indexPosition: 3,
                  keyType: 'i64',
                  lowerBound: propId,
                  upperBound: propId,
                }),
                3
              );
            });
          }
        );
      }
    );
    context('undelegate vote', async () => {
      context('with wrong auth', async () => {
        it('should fail with wrong auth', async () => {
          await assertMissingAuthority(
            shared.dacproposals_contract.undelegateca(
              propDacCustodians[2].name,
              category, // matching category
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
        it('should contain the delegated category votes', async () => {
          await assertRowCount(
            shared.dacproposals_contract.propvotesTable({
              scope: dacId,
              indexPosition: 4,
              keyType: 'i64',
              lowerBound: category,
              upperBound: category,
            }),
            3
          );
        });
      });
    });
    context('with correct auth', async () => {
      it('should succeed to undelegate', async () => {
        await shared.dacproposals_contract.undelegateca(
          propDacCustodians[2].name,
          category, // matching category
          dacId,
          {
            auths: [
              {
                actor: propDacCustodians[2].name,
                permission: 'active',
              },
              {
                actor: shared.auth_account.name,
                permission: 'active',
              },
            ],
          }
        );
      });
      it('should have removed the delegated category votes', async () => {
        await assertRowCount(
          shared.dacproposals_contract.propvotesTable({
            scope: dacId,
            indexPosition: 4,
            keyType: 'i64',
            lowerBound: category,
            upperBound: category,
          }),
          2
        );
      });
      it('should succeed setting up testuser', async () => {
        await setup_test_user(propDacCustodians[0], 'PROPDAC');
      });
    });
  });
});

async function setup_test_user(testuser: Account, tokenSymbol: string) {
  // const testuser = await AccountManager.createAccount('clienttest');
  console.log(`testuser: ${JSON.stringify(testuser, null, 2)}`);
  await shared.dac_token_contract.transfer(
    shared.dac_token_contract.account.name,
    testuser.name,
    `1200.0000 ${tokenSymbol}`,
    '',
    { from: shared.dac_token_contract.account }
  );
}
