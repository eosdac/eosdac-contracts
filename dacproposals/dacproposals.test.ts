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
  // let propDacOwner: l.Account;
  let otherAccount: l.Account;
  let proposer1Account: l.Account;
  let proposer2Account: l.Account;
  let arbitrator: l.Account;
  let propDacCustodians: string[];
  let members: l.Account[];
  let dacId: string;

  before(async () => {
    shared = await SharedTestObjects.getInstance();
    dacId = shared.configured_dac_id;
  });

  context('allocate custodian', async () => {
    before(async () => {
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
      console.log('custodians is: ' + JSON.stringify(propDacCustodiansRaw));

      propDacCustodians = propDacCustodiansRaw.rows.map(row => {
        let name = <string>row.cust_name;
        console.log('name is: ' + name);
        return name;
      });
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
        it('should fail with invalid auth error', async () => {});
      });
      context('with valid auth', async () => {
        context('with invalid proposal id', async () => {
          it('should fail with proposal not found error', async () => {});
        });
        context('delegating to self', async () => {
          it('should fail with Cannot delegate voting to yourself error', async () => {});
        });
        context('proposal in pending_approval state', async () => {
          context('delegate vote', async () => {
            it('should succeed', async () => {});
          });
        });
      });
    });
    context('comment', async () => {
      context('without valid auth', async () => {
        it('should fail with invalid auth error', async () => {});
      });
      context('with valid auth', async () => {
        context('with invalid proposal id', async () => {
          it('should fail with proposal not found error', async () => {});
        });
      });
      context('with custodian only auth', async () => {
        it('should succeed', async () => {});
      });
    });
    context('prepare for start work', async () => {
      context('without valid auth', async () => {
        it('should fail with invalid auth error', async () => {});
      });
      context('with valid auth', async () => {
        context('with invalid proposal id', async () => {
          it('should fail with proposal not found error', async () => {});
        });
      });
      context('proposal in pending_approval state', async () => {
        context('with insufficient votes', async () => {
          it('should fail with insuffient votes error', async () => {});
        });
      });
      context('with more denied than approved votes', async () => {
        context('with insufficient votes', async () => {
          it('should fail with insuffient votes error', async () => {});
        });
      });
      context('with enough votes to approve the proposal', async () => {
        context(
          'check updateVotes count on proposal before calling start work',
          async () => {
            it('should succeed to update prop votes', async () => {});
          }
        );
      });
      context('start work with enough votes', async () => {
        it('should succeed', async () => {});
      });
      context('proposal not in pending_approval state', async () => {
        it('should fail with proposal is not in pensing approval state error', async () => {});
      });
      context('proposal has expired', async () => {
        before(async () => {});
        it('should have correct initial proposals before expiring', async () => {});
        context('start work after expiry', async () => {
          before(async () => {
            sleep(3);
          });
          it('should fail with expired error', async () => {});
        });
      });
    });
    context('clear expired proposals', async () => {
      it('should have the correct number before clearing', async () => {});
      it('should clear the expired proposals', async () => {});
      it('should have the correct number of proposals after clearing', async () => {});
      it('should have correctly populated the escrow table', async () => {});
    });
  });
  context(
    'voteprop with valid auth and proposal in work_in_progress state',
    async () => {
      context('voteup', async () => {
        it('should fail with invalid state to accept votes', async () => {});
      });
      context('votedown', async () => {
        it('should fail with invalid state to accept votes', async () => {});
      });
    }
  );
  context('complete work', async () => {
    context('proposal in pending approval state', async () => {
      it('should fail with incorrect to state to complete error', async () => {});
    });
  });
  context('finalize', async () => {
    context('without valid auth', async () => {
      it('should fail with invalid auth error', async () => {});
    });
    context('with valid auth', async () => {
      context('with invalid proposal id', async () => {
        it('should fail with proposal not found error', async () => {});
      });
      context('proposal in not in pending_finalize state', async () => {
        it('should fail with not in pending_finalize state error', async () => {});
      });
      context('proposal is in pending_finalize state', async () => {
        it('should fail to ompletework', async () => {});
        context('without enough votes to approve the finalize', async () => {
          it('should fail to complete work with not enough votes error', async () => {});
        });
        context(
          'with enough votes to complete finalize with denial',
          async () => {
            context('update votes count', async () => {
              before(async () => {});
              it('should succeed', async () => {});
            });
          }
        );
        context(
          'read the proposals table after creating prop before expiring',
          async () => {
            it('should contain expected rows', async () => {});
          }
        );
        context('finalize after updating vote count', async () => {
          it('should succeed', async () => {});
        });
        it('propvote table should contain expected rows', async () => {});
        it('proposals table should contain expected rows', async () => {});
        it('escrow table should contain expected rows', async () => {});
      });
    });
    context('cancel', async () => {
      context('without valid auth', async () => {
        it('should fail with invalid auth error', async () => {});
      });
      context('with valid auth', async () => {
        context('with invalid proposal id', async () => {
          it('should fail with proposal not found error', async () => {});
        });
        context('with valid proposal id', async () => {
          context('after starting work but before completing', async () => {
            before(async () => {});
            it('should succeed', async () => {});
            it('proposals table should contain expected rows', async () => {});
            it('escrow table should contain expected rows', async () => {});
          });
        });
      });
    });
  });
  context('delegate categories', async () => {
    context(
      'created proposal but still needing a vote for approval',
      async () => {
        context(
          'delegate category for a vote with pre-existing vote should have no effect',
          async () => {
            it('should fail with insufficient votes', async () => {});
          }
        );
        context('delegated vote with non-matching category', async () => {
          it('should fail with insufficient votes', async () => {});
        });
        context('delegated category with matching category', async () => {
          it('should succeed to allow start work', async () => {});
        });
      }
    );
    context(
      'created a proposal but still need one vote for approval for categories',
      async () => {
        context(
          'delegated category with already voted custodian should have no effect',
          async () => {
            it('should fail with insufficient votes', async () => {});
          }
        );
        context('delegated category with non-matching category', async () => {
          it('should fail with insufficient votes', async () => {});
        });
        context('delegated category with matching category', async () => {
          it('should succeed', async () => {});
        });
      }
    );
    context(
      'created a proposal but still need 2 votes for approval for complex case',
      async () => {
        context(
          'delegated vote with matching proposal and category',
          async () => {
            it('should succeed when attempting start work', async () => {});
            it('propvotes should contain expected rows', async () => {});
          }
        );
      }
    );
    context('undelegate vote', async () => {
      context('with wrong auth', async () => {
        it('should fail with wrong auth', async () => {});
      });
      context('with correct auth', async () => {
        it('should succeed to undelegate', async () => {});
        it('propvotes should have the correct rows', async () => {});
      });
    });
  });
});
