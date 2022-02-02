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
  AccountManager,
  UpdateAuth,
} from 'lamington';
import { SharedTestObjects } from '../TestHelpers';
import { Msigworlds } from '../msigworlds/msigworlds';
import { Dacmultisigs } from '../dacmultisigs/dacmultisigs';
import { currentHeadTimeWithAddedSeconds } from '../msigworlds/msigworlds.test';
const api = EOSManager.api;

import * as chai from 'chai';

let shared: SharedTestObjects;
let msigworlds: Msigworlds;
let dacmultisigs: Dacmultisigs;

let user1: Account;
let user2: Account;
let msigowned: Account;

let dacId = 'dacmultisig';

describe('dacmultisigs', () => {
  let modifieddate: string;

  let propose = async (name: string) => {
    await msigworlds.propose(
      user1.name,
      name,
      [
        { actor: user1.name, permission: 'active' },
        { actor: user2.name, permission: 'active' },
      ],
      dacId,
      [],
      {
        actions: await api.serializeActions([
          {
            account: 'alienworlds',
            authorization: [{ actor: msigowned.name, permission: 'active' }],
            name: 'transfer',
            data: {
              from: msigowned.name,
              to: user2.name,
              quantity: '10.0000 TLM',
              memo: 'testing',
            },
          },
        ]),
        context_free_actions: [],
        delay_sec: '0',
        expiration: await currentHeadTimeWithAddedSeconds(3600),
        max_cpu_usage_ms: 0,
        max_net_usage_words: '0',
        ref_block_num: 12345,
        ref_block_prefix: 123,
        transaction_extensions: [],
      },
      { from: user1 }
    );
  };
  before(async () => {
    shared = await SharedTestObjects.getInstance();
    msigworlds = shared.msigworlds_contract;
    dacmultisigs = shared.dacmultisigs_contract;

    user1 = await AccountManager.createAccount('user1');
    user2 = await AccountManager.createAccount('user2');
    msigowned = await AccountManager.createAccount('msigowned2');

    await shared.initDac(dacId, '4,DMS', '1000000.0000 DMS');
    await configureAuths();

    await shared.eosio_token_contract.transfer(
      shared.tokenIssuer.name,
      msigowned.name,
      '100000.0000 TLM',
      'starter blanace.',
      { from: shared.tokenIssuer }
    );
  });

  context('proposed', async () => {
    before(async () => {
      await propose('prop1');
    });
    it('with non-existing proposal should fail', async () => {
      await assertEOSErrorIncludesMessage(
        dacmultisigs.proposed(user1.name, 'noprop', 'some metadata', dacId, {
          auths: [
            {
              actor: shared.auth_account.name,
              permission: 'active',
            },
            {
              actor: user1.name,
              permission: 'active',
            },
          ],
        }),
        'ERR::PROPOSAL_NOT_FOUND_MSIG'
      );
    });
    it('should work', async () => {
      await dacmultisigs.proposed(user1.name, 'prop1', 'some metadata', dacId, {
        auths: [
          {
            actor: shared.auth_account.name,
            permission: 'active',
          },
          {
            actor: user1.name,
            permission: 'active',
          },
        ],
      });
    });
    it('should have added table entry', async () => {
      const res = await dacmultisigs.proposalsTable({ scope: dacId });
      const row = res.rows[0];
      modifieddate = row.modifieddate;
      chai.expect(row.proposalname).to.equal('prop1');
      chai.expect(row.proposer).to.equal(user1.name);
    });
  });
  context('approved', async () => {
    it('should work', async () => {
      await dacmultisigs.approved(user1.name, 'prop1', user2.name, dacId, {
        auths: [
          {
            actor: shared.auth_account.name,
            permission: 'active',
          },
          {
            actor: user2.name,
            permission: 'active',
          },
        ],
      });
    });
    it('should have updated the table entry', async () => {
      const res = await dacmultisigs.proposalsTable({ scope: dacId });
      const row = res.rows[0];
      chai.expect(row.modifieddate).to.not.equal(modifieddate);
    });
  });
  context('unapproved', async () => {
    it('should work', async () => {
      await dacmultisigs.unapproved(user1.name, 'prop1', user2.name, dacId, {
        auths: [
          {
            actor: shared.auth_account.name,
            permission: 'active',
          },
          {
            actor: user2.name,
            permission: 'active',
          },
        ],
      });
    });
    it('should have updated the table entry', async () => {
      const res = await dacmultisigs.proposalsTable({ scope: dacId });
      const row = res.rows[0];
      chai.expect(row.modifieddate).to.not.equal(modifieddate);
    });
  });
  context('cancelled', async () => {
    context('with proposal not cancelled', async () => {
      it('should fail', async () => {
        await assertEOSErrorIncludesMessage(
          dacmultisigs.cancelled(user1.name, 'prop1', user2.name, dacId, {
            auths: [
              {
                actor: shared.auth_account.name,
                permission: 'active',
              },
              {
                actor: user2.name,
                permission: 'active',
              },
            ],
          }),
          'proposal is not really cancelled'
        );
      });
    });
    context('with proposal cancelled', async () => {
      before(async () => {
        await msigworlds.cancel('prop1', user1.name, dacId, {
          from: user1,
        });
      });
      it('should work', async () => {
        await dacmultisigs.cancelled(user1.name, 'prop1', user2.name, dacId, {
          auths: [
            {
              actor: shared.auth_account.name,
              permission: 'active',
            },
            {
              actor: user2.name,
              permission: 'active',
            },
          ],
        });
      });
      it('should have erased the table entry', async () => {
        await assertRowCount(dacmultisigs.proposalsTable({ scope: dacId }), 0);
      });
    });
  });
  context('executed', async () => {
    before(async () => {
      await propose('prop2');
    });
    context('when proposal is not really executed', async () => {
      it('should fail', async () => {
        await assertEOSErrorIncludesMessage(
          dacmultisigs.executed(user1.name, 'prop2', user2.name, dacId, {
            auths: [
              {
                actor: shared.auth_account.name,
                permission: 'active',
              },
              {
                actor: user2.name,
                permission: 'active',
              },
            ],
          }),
          'proposal is not really executed'
        );
      });
    });
    context('when proposal is executed', async () => {
      before(async () => {
        await dacmultisigs.proposed(
          user1.name,
          'prop2',
          'some metadata',
          dacId,
          {
            auths: [
              {
                actor: shared.auth_account.name,
                permission: 'active',
              },
              {
                actor: user1.name,
                permission: 'active',
              },
            ],
          }
        );

        await debugPromise(
          msigworlds.approve(
            'prop2',
            { actor: user1.name, permission: 'active' },
            dacId,
            null,
            { from: user1 }
          ),
          'approve 1'
        );

        await debugPromise(
          msigworlds.approve(
            'prop2',
            { actor: user2.name, permission: 'active' },
            dacId,
            null,
            { from: user2 }
          ),
          'approve 2'
        );

        await dacmultisigs.approved(user1.name, 'prop2', user1.name, dacId, {
          auths: [
            {
              actor: shared.auth_account.name,
              permission: 'active',
            },
            {
              actor: user1.name,
              permission: 'active',
            },
          ],
        });

        await dacmultisigs.approved(user1.name, 'prop2', user2.name, dacId, {
          auths: [
            {
              actor: shared.auth_account.name,
              permission: 'active',
            },
            {
              actor: user2.name,
              permission: 'active',
            },
          ],
        });

        await debugPromise(
          msigworlds.exec('prop2', user1.name, dacId, {
            from: user1,
          }),
          'exec'
        );
      });
      it('should work', async () => {
        await dacmultisigs.executed(user1.name, 'prop2', user2.name, dacId, {
          auths: [
            {
              actor: shared.auth_account.name,
              permission: 'active',
            },
            {
              actor: user2.name,
              permission: 'active',
            },
          ],
        });
      });
      it('should have erased the table entry', async () => {
        const res = await assertRowCount(
          dacmultisigs.proposalsTable({ scope: dacId }),
          0
        );
      });
    });
  });
  context('clean', async () => {
    before(async () => {
      await propose('prop3');
      await dacmultisigs.proposed(user1.name, 'prop3', 'some metadata', dacId, {
        auths: [
          {
            actor: shared.auth_account.name,
            permission: 'active',
          },
          {
            actor: user1.name,
            permission: 'active',
          },
        ],
      });
      const res = await assertRowCount(
        dacmultisigs.proposalsTable({ scope: dacId }),
        1
      );
    });
    it('too soon, should fail', async () => {
      await assertEOSErrorIncludesMessage(
        dacmultisigs.clean(user1.name, 'prop3', dacId, {
          from: shared.auth_account,
        }),
        'This proposal is still active'
      );
    });
    it('without proper authorization, should fail', async () => {
      await assertMissingAuthority(
        dacmultisigs.clean(user1.name, 'prop3', dacId)
      );
    });
    it('with proper parameters, should work', async () => {
      await sleep(6000);
      await dacmultisigs.clean(user1.name, 'prop3', dacId, {
        from: shared.auth_account,
      });
    });
    it('should have cleaned the table', async () => {
      const res = await assertRowCount(
        dacmultisigs.proposalsTable({ scope: dacId }),
        0
      );
    });
  });
});

async function configureAuths() {
  await UpdateAuth.execUpdateAuth(
    [{ actor: msigowned.name, permission: 'owner' }],
    msigowned.name,
    'active',
    'owner',
    UpdateAuth.AuthorityToSet.explicitAuthorities(
      3,
      [
        {
          permission: {
            actor: msigworlds.account.name,
            permission: 'active',
          },
          weight: 3,
        },
        { permission: { actor: user1.name, permission: 'active' }, weight: 1 },
        { permission: { actor: user2.name, permission: 'active' }, weight: 2 },
      ],
      [
        //   {
        //     key: owner1.publicKey,
        //     weight: 2,
        //   },
        //   {
        //     key: owner2.publicKey,
        //     weight: 1,
        //   },
        // ].sort((a, b) => {
        //   // ensure keys are sorted alphabetically to avoid invalid auth error.
        //   return a.key < b.key ? -1 : 1;
        // }),
      ],
      []
    )
  );

  await UpdateAuth.execUpdateAuth(
    [{ actor: msigworlds.account.name, permission: 'owner' }],
    msigworlds.account.name,
    'active',
    'owner',
    UpdateAuth.AuthorityToSet.explicitAuthorities(
      1,
      [
        {
          permission: {
            actor: msigworlds.account.name,
            permission: 'eosio.code',
          },
          weight: 1,
        },
      ],
      [
        {
          key: msigworlds.account.publicKey,
          weight: 1,
        },
      ],
      []
    )
  );
}
