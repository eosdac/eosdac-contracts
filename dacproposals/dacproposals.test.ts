import * as l from 'lamington';

import {
  SharedTestObjects,
  initAndGetSharedObjects,
  candidates,
  regmembers,
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

describe.only('Dacproposals', () => {
  let shared: SharedTestObjects;
  let propDacOwner: l.Account;
  let propDacCustodians: l.Account[];
  let dacId = 'propdac';

  before(async () => {
    shared = await debugPromise(
      initAndGetSharedObjects(),
      'init and get shared objects'
    );
  });

  context('allocate custodian', async () => {
    before(async () => {
      propDacOwner = await l.AccountManager.createAccount();
      propDacCustodians = await l.AccountManager.createAccounts(12);
      await debugPromise(
        shared.dacdirectory_contract.regdac(
          propDacOwner.name,
          dacId,
          {
            contract: shared.dac_token_contract.account.name,
            symbol: '4,PROP',
          },
          'appointdactitle',
          [],
          [
            {
              key: Account_type.AUTH,
              value: propDacOwner.name,
            },
            {
              key: Account_type.CUSTODIAN,
              value: shared.daccustodian_contract.account.name,
            },
          ],
          {
            from: propDacOwner,
          }
        ),
        'successfully registered dac',
        'failed to register dac'
      );
      await debugPromise(
        shared.daccustodian_contract.updateconfige(
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
              quantity: '12.0000 PROP',
            },
            should_pay_via_service_provider: true,
            lockup_release_time_delay: 1233,
          },
          dacId,
          { from: propDacOwner }
        ),
        'successfully updated configs for appointdac',
        'failed to update configs for appointdac'
      );
      await shared.daccustodian_contract.appointcust(
        propDacCustodians.map(account => {
          return account.name;
        }),
        dacId,
        { from: propDacOwner }
      );
    });
    context('updateconfig', async () => {
      context('without valid auth', async () => {
        it('should fail with auth error', async () => {});
      });
      context('with valid auth', async () => {
        it('should succeed', async () => {});
      });
    });
    context('create proposal', async () => {
      context('without valid permissions', async () => {
        it('should fail with auth error', async () => {});
      });
      context('with valid auth', async () => {
        context('with invalid title', async () => {});
        context('with invalid summary', async () => {});
        context('with invalid pay symbol', async () => {});
        context('with no pay symbol', async () => {});
        context('with negative amount', async () => {});
        context('with no arbitrator', async () => {});
        context('with valid params', async () => {});
        context('with duplicate id', async () => {});
        context('with valid params as an additional proposal', async () => {});
      });
    });
    context('voteprop', async () => {
      context('without valid auth', async () => {
        it('should fail with auth error', async () => {});
      });
      context('with valid auth', async () => {
        context('with invalid proposal id', async () => {
          it('should fail with proposal not found error', async () => {});
        });
        context('proposal in pending approval state', async () => {
          context('finalize_approve vote', async () => {
            it('should succeed', async () => {});
          });
          context('final_deny vote', async () => {
            it('should succeed', async () => {});
          });
          context('proposal_approve vote', async () => {
            it('should succeed', async () => {});
          });
          context('Extra proposal_approve vote', async () => {
            it('should succeed', async () => {});
          });
          context('proposal_deny vote of existing vote', async () => {
            it('should succeed', async () => {});
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
