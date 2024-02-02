import {
  Account,
  sleep,
  EOSManager,
  debugPromise,
  assertMissingAuthority,
  assertEOSErrorIncludesMessage,
  assertRowCount,
  assertBalanceEqual,
  AccountManager,
  UpdateAuth,
} from 'lamington';
import { SharedTestObjects } from '../TestHelpers';
import { Referendum } from './referendum';
const api = EOSManager.api;

let shared: SharedTestObjects;
let referendum: Referendum;

let user1: Account;
let user2: Account;

let dacId = 'refdac';

enum vote_type {
  TYPE_BINDING = 'binding',
  TYPE_SEMI_BINDING = 'semibinding',
  TYPE_OPINION = 'opinion',
}

enum count_type {
  COUNT_TOKEN = 'token',
  COUNT_ACCOUNT = 'account',
  COUNT_INVALID = 2,
}

enum voting_type {
  VOTE_PROP_REMOVE = 'remove',
  VOTE_PROP_YES = 'yes',
  VOTE_PROP_NO = 'no',
  VOTE_PROP_ABSTAIN = 'abstain',
}

const seconds = 1;
const minutes = 60 * seconds;

let serialized_actions: any;
let serialized_actions_outside_dao: any;
let regMembers: Account[];
let candidates: Account[];
// let otherAccount: Account;
// let proposer1Account: Account;
let planet: Account;

describe('Referendum', () => {
  before(async () => {
    shared = await SharedTestObjects.getInstance();
    referendum = shared.referendum_contract;

    user1 = await AccountManager.createAccount('user1');
    user2 = await AccountManager.createAccount('user2');
    planet = await AccountManager.createAccount('omicrontheta');

    await shared.initDac(dacId, '4,REF', '1000000.0000 REF', { planet });
    await shared.updateconfig(dacId, '12.0000 REF');
    await setup_token();

    candidates = await shared.getStakeObservedCandidates(dacId, '20.0000 REF');
    regMembers = await shared.getRegMembers(dacId, '20000.0000 REF');
    await shared.voteForCustodians(regMembers, candidates, dacId);

    await configureAuths();
    await linkPermissions();

    await shared.daccustodian_contract.newperiod(dacId, dacId, {
      from: regMembers[0],
    });
    await sleep(6_000);
    await shared.daccustodian_contract.newperiod(dacId, dacId, {
      from: regMembers[0],
    });

    serialized_actions = await api.serializeActions([
      {
        account: shared.dac_token_contract.name,
        authorization: [{ actor: planet.name, permission: 'active' }],
        name: 'transfer',
        data: {
          from: planet.name,
          to: user1.name,
          quantity: '10.1234 REF',
          memo: 'testing',
        },
      },
    ]);

    serialized_actions_outside_dao = await api.serializeActions([
      {
        account: shared.dac_token_contract.name,
        authorization: [
          { actor: shared.daccustodian_contract.name, permission: 'active' },
        ],
        name: 'transfer',
        data: {
          from: shared.daccustodian_contract.name,
          to: user1.name,
          quantity: '10.1234 REF',
          memo: 'testing',
        },
      },
    ]);
  });
  context('updateconfig', async () => {
    it('without auth, should fail', async () => {
      let anybody = await AccountManager.createAccount();
      await assertMissingAuthority(
        referendum.updateconfig(
          {
            duration: 1,
            fee: [],
            pass: [],
            quorum_token: [],
            quorum_account: [],
            allow_per_account_voting: [],
            allow_vote_type: [],
          },
          dacId,
          { from: anybody }
        )
      );
    });
    it('with proper auth, should work', async () => {
      await referendum.updateconfig(
        {
          duration: 5 * minutes,
          fee: [
            {
              key: vote_type.TYPE_BINDING,
              value: {
                contract: shared.dac_token_contract.account.name,
                quantity: '1.0000 REF',
              },
            },
            {
              key: vote_type.TYPE_SEMI_BINDING,
              value: {
                contract: shared.dac_token_contract.account.name,
                quantity: '1.0000 REF',
              },
            },
            {
              key: vote_type.TYPE_OPINION,
              value: {
                contract: shared.dac_token_contract.account.name,
                quantity: '1.0000 REF',
              },
            },
          ],
          pass: [
            {
              key: vote_type.TYPE_BINDING,
              value: 1000,
            },
            {
              key: vote_type.TYPE_SEMI_BINDING,
              value: 1000,
            },
            {
              key: vote_type.TYPE_OPINION,
              value: 1000,
            },
          ],
          quorum_token: [
            {
              key: vote_type.TYPE_BINDING,
              value: 1000,
            },
            {
              key: vote_type.TYPE_SEMI_BINDING,
              value: 1000,
            },
            {
              key: vote_type.TYPE_OPINION,
              value: 1000,
            },
          ],
          quorum_account: [
            {
              key: vote_type.TYPE_BINDING,
              value: 1000,
            },
            {
              key: vote_type.TYPE_SEMI_BINDING,
              value: 1000,
            },
            {
              key: vote_type.TYPE_OPINION,
              value: 1000,
            },
          ],
          allow_per_account_voting: [
            {
              key: vote_type.TYPE_BINDING,
              value: true,
            },
            {
              key: vote_type.TYPE_SEMI_BINDING,
              value: true,
            },
            {
              key: vote_type.TYPE_OPINION,
              value: true,
            },
          ],
          allow_vote_type: [
            {
              key: vote_type.TYPE_BINDING,
              value: true,
            },
            {
              key: vote_type.TYPE_SEMI_BINDING,
              value: true,
            },
            {
              key: vote_type.TYPE_OPINION,
              value: true,
            },
          ],
        },
        dacId,
        { from: shared.auth_account }
      );
    });
  });
  context('semibinding proposal', async () => {
    context('propose', async () => {
      it('without auth, should fail', async () => {
        await assertMissingAuthority(
          referendum.propose(
            user1.name,
            vote_type.TYPE_SEMI_BINDING,
            count_type.COUNT_TOKEN,
            'title',
            'content',
            dacId,
            serialized_actions
          )
        );
      });
      it('if proposer is not member, should fail', async () => {
        await assertEOSErrorIncludesMessage(
          referendum.propose(
            user1.name,
            vote_type.TYPE_SEMI_BINDING,
            count_type.COUNT_TOKEN,
            'title',
            'content',
            dacId,
            serialized_actions,
            { from: user1 }
          ),
          'GENERAL_REG_MEMBER_NOT_FOUND'
        );
      });
      context('with registered member', async () => {
        before(async () => {
          await shared.dac_token_contract.memberreg(
            user1.name,
            shared.configured_dac_memberterms,
            dacId,
            { from: user1 }
          );
        });
        it('without deposit, should fail', async () => {
          await assertEOSErrorIncludesMessage(
            referendum.propose(
              user1.name,
              vote_type.TYPE_SEMI_BINDING,
              count_type.COUNT_TOKEN,
              'title',
              'content',
              dacId,
              serialized_actions,
              { from: user1 }
            ),
            'ERR::FEE_REQUIRED'
          );
        });
        context('when deposited enough money', async () => {
          before(async () => {
            await shared.dac_token_contract.transfer(
              user1.name,
              referendum.account.name,
              '100.0000 REF',
              'fee deposit',
              { from: user1 }
            );
          });
          it('with actions outside dao should fail', async () => {
            await assertEOSErrorIncludesMessage(
              referendum.propose(
                user1.name,
                vote_type.TYPE_SEMI_BINDING,
                count_type.COUNT_TOKEN,
                'title',
                'content',
                dacId,
                serialized_actions_outside_dao,
                { from: user1 }
              ),
              'ERR::REQUESTED_AUTHS_FOR_ACTIONS_OUTSIDE_DAO::'
            );
          });
          it('should work', async () => {
            await referendum.propose(
              user1.name,
              vote_type.TYPE_SEMI_BINDING,
              count_type.COUNT_TOKEN,
              'title',
              'content',
              dacId,
              serialized_actions,
              { from: user1 }
            );
          });
          it('should have transferred the fee to treasury', async () => {
            await assertBalanceEqual(
              shared.dac_token_contract.accountsTable({
                scope: shared.treasury_account.name,
              }),
              '1.0000 REF'
            );
          });
        });
      });
    });
    context('vote', async () => {
      it('should work', async () => {
        await referendum.vote(user1.name, 1, voting_type.VOTE_PROP_YES, dacId, {
          from: user1,
        });
      });
    });
    context('exec', async () => {
      it('should have referendum in the table before execution', async () => {
        await assertRowCount(
          shared.referendum_contract.referendumsTable({ scope: dacId }),
          1
        );
      });
      it('should work', async () => {
        await referendum.exec('1', dacId);
      });
      it('Should not erase the referendum after execution', async () => {
        await assertRowCount(
          shared.referendum_contract.referendumsTable({ scope: dacId }),
          1
        );
      });
      it('should create the proposal', async () => {
        await assertRowCount(
          shared.msigworlds_contract.proposalsTable({ scope: dacId }),
          1
        );
      });
    });
    context('msig exec', async () => {
      context('high with only 3 approvals', async () => {
        before(async () => {
          await shared.msigworlds_contract.approve(
            '............1',
            { actor: candidates[0].name, permission: 'active' },
            dacId,
            null,
            { from: candidates[0] }
          );

          await shared.msigworlds_contract.approve(
            '............1',
            { actor: candidates[1].name, permission: 'active' },
            dacId,
            null,
            { from: candidates[1] }
          );

          await shared.msigworlds_contract.approve(
            '............1',
            { actor: candidates[2].name, permission: 'active' },
            dacId,
            null,
            { from: candidates[2] }
          );
        });

        it('should fail', async () => {
          await assertEOSErrorIncludesMessage(
            shared.msigworlds_contract.exec(
              '............1',
              candidates[0].name,
              dacId,
              {
                from: candidates[0],
              }
            ),
            'msigworlds::exec transaction authorization failed'
          );
        });
      });
      context('high with 4 approvals', async () => {
        before(async () => {
          await shared.msigworlds_contract.approve(
            '............1',
            { actor: candidates[3].name, permission: 'active' },
            dacId,
            null,
            { from: candidates[3] }
          );
        });
        it('should work', async () => {
          await shared.msigworlds_contract.exec(
            '............1',
            candidates[0].name,
            dacId,
            {
              from: candidates[0],
            }
          );
        });
        it('should have transferred the token', async () => {
          await assertBalanceEqual(
            shared.dac_token_contract.accountsTable({
              scope: user1.name,
            }),
            '1010.1234 REF'
          );
        });
      });
    });
  });
  context('binding proposal', async () => {
    context('propose', async () => {
      context('with registered member', async () => {
        before(async () => {
          await shared.dac_token_contract.memberreg(
            user1.name,
            shared.configured_dac_memberterms,
            dacId,
            { from: user1 }
          );
        });
        context('when deposited enough money', async () => {
          before(async () => {
            await shared.dac_token_contract.transfer(
              user1.name,
              referendum.account.name,
              '2.0000 REF',
              'fee deposit',
              { from: user1 }
            );
          });
          it('should work', async () => {
            await referendum.propose(
              user1.name,
              vote_type.TYPE_BINDING,
              count_type.COUNT_TOKEN,
              'title',
              'content',
              dacId,
              serialized_actions,
              { from: user1 }
            );
          });
          it('should have transferred the fee to treasury', async () => {
            await assertBalanceEqual(
              shared.dac_token_contract.accountsTable({
                scope: shared.treasury_account.name,
              }),
              '2.0000 REF'
            );
          });
        });
      });
    });
    context('vote', async () => {
      it('should work', async () => {
        await referendum.vote(user1.name, 2, voting_type.VOTE_PROP_YES, dacId, {
          from: user1,
        });
      });
    });
    context('exec', async () => {
      it('should work', async () => {
        await referendum.exec('2', dacId);
      });
      it('should create the proposal', async () => {
        await assertRowCount(
          shared.msigworlds_contract.proposalsTable({ scope: dacId }),
          1
        );
      });
    });
  });
});

async function setup_token() {
  await shared.dac_token_contract.transfer(
    shared.tokenIssuer.name,
    user1.name,
    '1100.0000 REF',
    'starter blanace.',
    { from: shared.tokenIssuer }
  );
  await shared.dac_token_contract.transfer(
    shared.tokenIssuer.name,
    planet.name,
    '1100.0000 REF',
    'starter blanace.',
    { from: shared.tokenIssuer }
  );
  await shared.dac_token_contract.stakeconfig(
    { enabled: true, min_stake_time: 5, max_stake_time: 20 },
    '4,REF',
    { from: shared.auth_account }
  );
  await shared.dac_token_contract.stake(user1.name, '1000.0000 REF', {
    from: user1,
  });
}

async function configureAuths() {
  /* Even though these custom permissions will be added from within the contract in the newperiod action,
   * we need to create them beforehand because you cannot reference a parent permission
   * that was created within the same transaction. That means you cannot add high and then med with parent high in the same transaction unless the high perm has existed already.
   */
  await debugPromise(
    UpdateAuth.execUpdateAuth(
      planet.owner,
      planet.name,
      'high',
      'active',
      UpdateAuth.AuthorityToSet.forContractCode(planet)
    ),
    'add high auth to planet'
  );

  await debugPromise(
    UpdateAuth.execUpdateAuth(
      planet.owner,
      planet.name,
      'med',
      'high',
      UpdateAuth.AuthorityToSet.forContractCode(planet)
    ),
    'add med auth to planet'
  );

  await debugPromise(
    UpdateAuth.execUpdateAuth(
      planet.owner,
      planet.name,
      'low',
      'med',
      UpdateAuth.AuthorityToSet.forContractCode(planet)
    ),
    'add low auth to planet'
  );

  await debugPromise(
    UpdateAuth.execUpdateAuth(
      planet.owner,
      planet.name,
      'one',
      'low',
      UpdateAuth.AuthorityToSet.forContractCode(planet)
    ),
    'add one auth to planet'
  );

  await debugPromise(
    UpdateAuth.execUpdateAuth(
      planet.owner,
      planet.name,
      'active',
      'owner',
      UpdateAuth.AuthorityToSet.explicitAuthorities(
        1,
        [
          code_permission_level(1, shared.referendum_contract.name),
          { weight: 1, permission: { actor: planet.name, permission: 'high' } },
        ],
        [{ weight: 1, key: planet.publicKey }],
        []
      )
    ),
    'make daccustodian the owner of the planet'
  );

  /* The daccustodian contract will need to make eosio::updateauth calls on
   * behalf of the planet, so we need to add a custom permission to allow this
   */
  await debugPromise(
    UpdateAuth.execUpdateAuth(
      planet.owner,
      planet.name,
      'owner',
      '',
      UpdateAuth.AuthorityToSet.forContractCode(
        shared.daccustodian_contract.account
      )
    ),
    'make daccustodian the owner of the planet'
  );
}

async function linkPermissions() {
  /* Link the high, medium, low, one custom permissions to whatever they
   * should be allowed to execute here
   */
  await UpdateAuth.execLinkAuth(
    planet.active,
    planet.name,
    shared.dac_token_contract.name,
    'transfer',
    'high'
  );
}

//This could be usefuly to put into Lamington's `UpdateAuth.AuthorityToSet`
function code_permission_level(weight: number, account: string) {
  return {
    weight,
    permission: { actor: account, permission: 'eosio.code' },
  };
}
