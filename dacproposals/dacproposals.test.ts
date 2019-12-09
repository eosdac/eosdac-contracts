import * as l from 'lamington';

import {
  SharedTestObjects,
  debugPromise,
  NUMBER_OF_CANDIDATES,
  Account_type,
} from '../TestHelpers';
import * as chai from 'chai';

import * as chaiAsPromised from 'chai-as-promised';

chai.use(chaiAsPromised);
import { factory } from '../LoggingConfig';
import { sleep } from 'lamington';

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

describe('Dacproposals', () => {
  let shared: SharedTestObjects;
  let otherAccount: l.Account;
  let proposer1Account: l.Account;
  let proposer2Account: l.Account;
  let arbitrator: l.Account;
  let propDacCustodians: string[];
  let members: l.Account[];
  let dacId: string;
  let delegateeCustodianName: string;

  before(async () => {
    shared = await SharedTestObjects.getInstance();
    dacId = shared.configured_dac_id;
    members = await shared.regMembers();
    otherAccount = members[1];
    arbitrator = members[2];
    proposer1Account = members[3];
    proposer2Account = members[4];

    let propDacCustodiansRaw = await shared.daccustodian_contract.custodiansTable(
      {
        scope: shared.configured_dac_id,
      }
    );

    propDacCustodians = propDacCustodiansRaw.rows.map(row => {
      let name = <string>row.cust_name;
      return name;
    });
    delegateeCustodianName = propDacCustodians[4];
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
            'jhsdfkjhsdfkjhkjsdf',
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
              'jhsdfkjhsdfkjhkjsdf',
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
              'jhsdfkjhsdfkjhkjsdf',
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
              'jhsdfkjhsdfkjhkjsdf',
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
              'jhsdfkjhsdfkjhkjsdf',
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
              'jhsdfkjhsdfkjhkjsdf',
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
              'jhsdfkjhsdfkjhkjsdf',
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
              'jhsdfkjhsdfkjhkjsdf',
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
              'jhsdfkjhsdfkjhkjsdf',
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
              'jhsdfkjhsdfkjhkjsdf',
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
        l.assertMissingAuthority(
          shared.dacproposals_contract.voteprop(
            propDacCustodians[0],
            0,
            VoteType.proposal_approve,
            dacId,
            {
              auths: [
                {
                  actor: propDacCustodians[1],
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
              propDacCustodians[0],
              15,
              VoteType.proposal_approve,
              dacId,
              {
                auths: [
                  {
                    actor: propDacCustodians[0],
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
                propDacCustodians[0],
                0,
                VoteType.proposal_approve,
                dacId,
                {
                  auths: [
                    {
                      actor: propDacCustodians[0],
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
                propDacCustodians[0],
                0,
                VoteType.proposal_deny,
                dacId,
                {
                  auths: [
                    {
                      actor: propDacCustodians[0],
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
                propDacCustodians[0],
                0,
                VoteType.proposal_approve,
                dacId,
                {
                  auths: [
                    {
                      actor: propDacCustodians[0],
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
                propDacCustodians[0],
                16,
                VoteType.proposal_approve,
                dacId,
                {
                  auths: [
                    {
                      actor: propDacCustodians[0],
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
                propDacCustodians[0],
                0,
                VoteType.proposal_deny,
                dacId,
                {
                  auths: [
                    {
                      actor: propDacCustodians[0],
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
            propDacCustodians[0],
            1, // proposal id
            delegateeCustodianName,
            dacId,
            {
              auths: [
                {
                  actor: propDacCustodians[1],
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
              propDacCustodians[1],
              15, // proposal id
              delegateeCustodianName,
              dacId,
              {
                auths: [
                  {
                    actor: propDacCustodians[1],
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
              propDacCustodians[0],
              1, // proposal id
              propDacCustodians[0],
              dacId,
              {
                auths: [
                  {
                    actor: propDacCustodians[0],
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
                propDacCustodians[0],
                1, // proposal id
                propDacCustodians[1],
                dacId,
                {
                  auths: [
                    {
                      actor: propDacCustodians[0],
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
            propDacCustodians[0],
            15,
            'some comment string',
            'some comment category',
            dacId,
            {
              auths: [
                {
                  actor: propDacCustodians[1],
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
              propDacCustodians[1],
              15, // proposal id
              'some comment',
              'a comment category',
              dacId,
              {
                auths: [
                  {
                    actor: propDacCustodians[1],
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
          propDacCustodians[3],
          1, // proposal id
          'some comment',
          'a comment category',
          dacId,
          {
            auths: [
              {
                actor: propDacCustodians[3],
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
                actor: propDacCustodians[4],
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
                    actor: propDacCustodians[1],
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
              custodian,
              0,
              VoteType.proposal_deny,
              dacId,
              {
                auths: [
                  {
                    actor: custodian,
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
            custodian,
            0,
            VoteType.proposal_approve,
            dacId,
            {
              auths: [
                {
                  actor: custodian,
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
      it('should change proposal state to ', async () => {});
    });
  });
});
