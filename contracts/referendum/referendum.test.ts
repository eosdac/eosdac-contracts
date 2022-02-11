import {
  Account,
  sleep,
  EOSManager,
  debugPromise,
  assertMissingAuthority,
  assertRowsEqual,
  assertEOSErrorIncludesMessage,
  assertRowCount,
  assertBalanceEqual,
  EosioAction,
  ContractLoader,
  AccountManager,
  UpdateAuth,
} from 'lamington';
import { SharedTestObjects } from '../TestHelpers';
import { Msigworlds } from '../msigworlds/msigworlds';
import { currentHeadTimeWithAddedSeconds } from '../msigworlds/msigworlds.test';
const api = EOSManager.api;

import * as chai from 'chai';

let shared: SharedTestObjects;
let referendum: Referendum;

let user1: Account;
let user2: Account;

let dacId = 'refdac';

enum vote_type {
  TYPE_BINDING = 0,
  TYPE_SEMI_BINDING = 1,
  TYPE_OPINION = 2,
  TYPE_INVALID = 3,
}
enum count_type {
  COUNT_TOKEN = 0,
  COUNT_ACCOUNT = 1,
  COUNT_INVALID = 2,
}

const seconds = 1;
const minutes = 60 * seconds;

let serialized_actions: any;
let delegateeCustodian: Account;
let regMembers: Account[];
let candidates: Account[];
let otherAccount: Account;
let proposer1Account: Account;
let arbitrator: Account;
let planet: Account;

describe('referendum', () => {
  before(async () => {
    shared = await SharedTestObjects.getInstance();
    referendum = shared.referendum_contract;

    user1 = await AccountManager.createAccount('user1');
    user2 = await AccountManager.createAccount('user2');
    planet = await AccountManager.createAccount('omicrontheta');

    await shared.initDac(dacId, '4,REF', '1000000.0000 REF', planet);
    await shared.updateconfig(dacId, '12.0000 REF');
    await setup_token();

    candidates = await shared.getStakeObservedCandidates(dacId, '20.0000 REF');
    regMembers = await shared.getRegMembers(dacId, '20000.0000 REF');
    await shared.voteForCustodians(regMembers, candidates, dacId);

    await configureAuths();

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
  });
  context('updateconfig', async () => {
    it('without auth, should fail', async () => {
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
          dacId
        )
      );
    });
    it('with proper auth, should work', async () => {
      await referendum.updateconfig(
        {
          duration: 5 * minutes,
          fee: [
            {
              key: 0,
              value: {
                contract: shared.dac_token_contract.account.name,
                quantity: '1.0000 REF',
              },
            },
            {
              key: 1,
              value: {
                contract: shared.dac_token_contract.account.name,
                quantity: '1.0000 REF',
              },
            },
            {
              key: 2,
              value: {
                contract: shared.dac_token_contract.account.name,
                quantity: '1.0000 REF',
              },
            },
          ],
          pass: [
            {
              key: 0,
              value: 1000,
            },
            {
              key: 1,
              value: 1000,
            },
            {
              key: 2,
              value: 1000,
            },
          ],
          quorum_token: [
            {
              key: 0,
              value: 1000,
            },
            {
              key: 1,
              value: 1000,
            },
            {
              key: 2,
              value: 1000,
            },
          ],
          quorum_account: [
            {
              key: 0,
              value: 1000,
            },
            {
              key: 1,
              value: 1000,
            },
            {
              key: 2,
              value: 1000,
            },
          ],
          allow_per_account_voting: [
            {
              key: 0,
              value: 1,
            },
            {
              key: 1,
              value: 1,
            },
            {
              key: 2,
              value: 1,
            },
          ],
          allow_vote_type: [
            {
              key: 0,
              value: 1,
            },
            {
              key: 1,
              value: 1,
            },
            {
              key: 2,
              value: 1,
            },
          ],
        },
        dacId,
        { from: shared.auth_account }
      );
    });
  });
  context('propose', async () => {
    it('without auth, should fail', async () => {
      await assertMissingAuthority(
        referendum.propose(
          user1.name,
          'ref1',
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
          'ref1',
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
            'ref1',
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
        it('should work', async () => {
          await referendum.propose(
            user1.name,
            'ref1',
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
      await referendum.vote(user1.name, 'ref1', 1, dacId, { from: user1 });
    });
  });
  context('exec', async () => {
    it('should work', async () => {
      await referendum.exec('ref1', dacId);

      await shared.msigworlds_contract.approve(
        'ref1',
        { actor: candidates[0].name, permission: 'active' },
        dacId,
        null,
        { from: candidates[0] }
      );

      await shared.msigworlds_contract.approve(
        'ref1',
        { actor: candidates[1].name, permission: 'active' },
        dacId,
        null,
        { from: candidates[1] }
      );

      await shared.msigworlds_contract.approve(
        'ref1',
        { actor: candidates[2].name, permission: 'active' },
        dacId,
        null,
        { from: candidates[2] }
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
    it('should work', async () => {
      await shared.msigworlds_contract.exec('ref1', candidates[0].name, dacId, {
        from: candidates[0],
      });
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

async function setup_token() {
  await shared.dac_token_contract.transfer(
    shared.dac_token_contract.account.name,
    user1.name,
    '1100.0000 REF',
    'starter blanace.',
    { from: shared.dac_token_contract.account }
  );
  await shared.dac_token_contract.transfer(
    shared.dac_token_contract.account.name,
    planet.name,
    '1100.0000 REF',
    'starter blanace.',
    { from: shared.dac_token_contract.account }
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
