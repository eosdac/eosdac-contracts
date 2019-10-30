import * as l from 'lamington';

import {
  SharedTestObjects,
  initAndGetSharedObjects,
  candidates,
  regmembers,
  Account_type,
} from '../TestHelpers';
import * as chai from 'chai';
chai.use(require('chai-datetime'));

// import { equalDate } from 'chai-datetime';
import { EosdactokensStakeConfig } from './eosdactokens';

describe('EOSDacTokens', () => {
  let shared: SharedTestObjects;
  let issuer: l.Account;
  let otherAccount: l.Account;

  before(async () => {
    shared = await initAndGetSharedObjects();
    issuer = await l.AccountManager.createAccount();
    otherAccount = await l.AccountManager.createAccount();
  });

  context('create token', async () => {
    it('with invalid token symbol should fail with invalid symbol error', async () => {
      await l.assertEOSErrorIncludesMessage(
        shared.dac_token_contract.create(
          issuer.name,
          '10000.0000 asdf',
          false,
          { from: issuer }
        ),
        'ERR::CREATE_INVALID_SYMBOL'
      );
    });
    it('with negative token quantity should fail with invalid supply error', async () => {
      await l.assertEOSErrorIncludesMessage(
        shared.dac_token_contract.create(
          issuer.name,
          `${2 ** 62 + 10} ABC`,
          false,
          { from: issuer }
        ),
        'ERR::CREATE_INVALID_SUPPLY'
      );
    });
    it('with negative token quantity should fail with supply must be positive error', async () => {
      await l.assertEOSErrorIncludesMessage(
        shared.dac_token_contract.create(
          issuer.name,
          '-10000.0000 ABC',
          false,
          { from: issuer }
        ),
        'ERR::CREATE_MAX_SUPPLY_MUST_BE_POSITIVE'
      );
    });
    it('with valid asset should succeed', async () => {
      await shared.dac_token_contract.create(
        issuer.name,
        '100000.0000 ABC',
        false,
        { from: issuer }
      );
    });
    it('with existing token should fail with existing token error', async () => {
      await l.assertEOSErrorIncludesMessage(
        shared.dac_token_contract.create(
          issuer.name,
          '1000000.0000 ABC',
          false,
          { from: issuer }
        ),
        'ERR::CREATE_EXISITNG_SYMBOL'
      );
    });
  });
  context('issue token', async () => {
    it('with invalid token symbol should fail with invalid symbol error', async () => {
      await l.assertEOSErrorIncludesMessage(
        shared.dac_token_contract.issue(
          issuer.name,
          '10000.0000 sdasd',
          'some memo',
          { from: issuer }
        ),
        'ERR::ISSUE_INVALID_SYMBOL'
      );
    });
    it('with non existing token should fail with non-existing token error', async () => {
      await l.assertEOSErrorIncludesMessage(
        shared.dac_token_contract.issue(
          issuer.name,
          '10000.0000 CBA',
          'some memo',
          { from: issuer }
        ),
        'ERR::ISSUE_NON_EXISTING_SYMBOL:'
      );
    });
    it('with invalid quantity should fail with invalid quantity error', async () => {
      await l.assertEOSErrorIncludesMessage(
        shared.dac_token_contract.issue(
          issuer.name,
          `${2 ** 62 + 10} ABC`,
          'some memo',
          { from: issuer }
        ),
        'ERR::ISSUE_INVALID_QUANTITY:'
      );
    });
    it('with negative quantity should fail with non-positive issue error', async () => {
      await l.assertEOSErrorIncludesMessage(
        shared.dac_token_contract.issue(
          issuer.name,
          `-1000.0000 ABC`,
          'some memo',
          { from: issuer }
        ),
        'ERR::ISSUE_NON_POSITIVE'
      );
    });
    it('with invalid precision should fail with invalid precsion error', async () => {
      await l.assertEOSErrorIncludesMessage(
        shared.dac_token_contract.issue(
          issuer.name,
          `1000.00 ABC`,
          'some memo',
          { from: issuer }
        ),
        'ERR::ISSUE_INVALID_PRECISION:'
      );
    });
    it('to issuer should increase the issuer balance', async () => {
      shared.dac_token_contract.issue(
        issuer.name,
        `1000.0000 ABC`,
        'some memo',
        { from: issuer }
      );
      await l.assertRowsEqual(
        shared.dac_token_contract.statTable({ scope: '4,ABC' }),
        []
      );

      await l.assertRowsEqual(
        shared.dac_token_contract.accountsTable({ scope: issuer.name }),
        [{ balance: '1000.0000 ABC' }]
      );
    });
    context('to other', async () => {
      context('without a dac', async () => {
        it('should fail with DAC not found for symbol error', async () => {
          await l.assertEOSErrorIncludesMessage(
            shared.dac_token_contract.issue(
              otherAccount.name,
              `1200.0000 ABC`,
              'some memo',
              { from: issuer }
            ),
            'ERR::DAC_NOT_FOUND_SYMBOL'
          );
        });
      });
      context('with a dac', async () => {
        before(async () => {
          await shared.dacdirectory_contract.regdac(
            shared.auth_account.name,
            'abcdac',
            {
              contract: shared.dac_token_contract.account.name,
              symbol: '4,ABC',
            },
            'abc dac_title',
            [],
            [
              { key: Account_type.AUTH, value: shared.auth_account.name },
              {
                key: Account_type.CUSTODIAN,
                value: shared.daccustodian_contract.account.name,
              },
            ],
            {
              auths: [
                { actor: shared.auth_account.name, permission: 'active' },
              ],
            }
          );
        });
        it('should increase the other balance', async () => {
          await shared.dac_token_contract.issue(
            otherAccount.name,
            `1200.0000 ABC`,
            'some memo',
            { from: issuer }
          );
          await l.assertRowsEqual(
            shared.dac_token_contract.statTable({ scope: '4,ABC' }),
            []
          );

          await l.assertRowsEqual(
            shared.dac_token_contract.accountsTable({
              scope: otherAccount.name,
            }),
            [{ balance: '1200.0000 ABC' }]
          );
        });
      });
    });
  });
  context('Staking', async () => {
    let staker: l.Account;
    before(async () => {
      staker = await l.AccountManager.createAccount();
      await shared.dac_token_contract.issue(
        staker.name,
        '1000.0000 ABC',
        'initial issued tokens',
        { from: issuer }
      );
    });
    context('stake', async () => {
      context('stake without staking enabled', async () => {
        it('should fail with staking not enabled error', async () => {
          await l.assertEOSErrorIncludesMessage(
            shared.dac_token_contract.stake(staker.name, '100.0000 ABC', {
              from: staker,
            }),
            'ERR::STAKING_NOT_ENABLED'
          );
        });
      });
      context('with staking enabled', async () => {
        before(async () => {
          shared.dac_token_contract.stakeconfig(
            { enabled: true, min_stake_time: 13, max_stake_time: 20 },
            '4,ABC',
            { from: shared.auth_account }
          );
        });
        it('with invalid quantity should fail with dac not found for symbol error', async () => {
          await l.assertEOSErrorIncludesMessage(
            shared.dac_token_contract.stake(
              staker.name,
              `${10 + 2 ** 62}` + ' ABC',
              { from: staker }
            ),
            'DAC_NOT_FOUND_SYMBOL'
          ); // This is not testable because a DAC cannot be found with in invalid quantity first
        });
        it('with negative quantity should fail with non-posistive error', async () => {
          await l.assertEOSErrorIncludesMessage(
            shared.dac_token_contract.stake(staker.name, `-1000.0000 ABC`, {
              from: staker,
            }),
            'STAKE_NON_POSITIVE_QTY'
          );
        });
        it('with more than available balance should fail with more than liquid error', async () => {
          await l.assertEOSErrorIncludesMessage(
            shared.dac_token_contract.stake(staker.name, `1001.0000 ABC`, {
              from: staker,
            }),
            'ERR::STAKE_MORE_LIQUID'
          );
        });
        it('with correct amount should succeed', async () => {
          await shared.dac_token_contract.stake(staker.name, '100.0000 ABC', {
            from: staker,
          });
          await l.assertRowsEqual(
            shared.dac_token_contract.stakesTable({ scope: 'abcdac' }),
            [{ account: staker.name, stake: '100.0000 ABC' }]
          );
        });
        it('staking again should add more', async () => {
          await shared.dac_token_contract.stake(staker.name, '50.0000 ABC', {
            from: staker,
          });
          await l.assertRowsEqual(
            shared.dac_token_contract.stakesTable({ scope: 'abcdac' }),
            [{ account: staker.name, stake: '150.0000 ABC' }]
          );
        });
        it('again with more than liquid balance should fail with more than liquid error', async () => {
          await l.assertEOSErrorIncludesMessage(
            shared.dac_token_contract.stake(staker.name, `851.0000 ABC`, {
              from: staker,
            }),
            'ERR::STAKE_MORE_LIQUID:'
          );
        });
      });
    });
    context('unstake', async () => {
      context(
        'without staking enabled with staking not enabled error',
        async () => {
          before(async () => {
            await shared.dac_token_contract.stakeconfig(
              { enabled: false, min_stake_time: 13, max_stake_time: 20 },
              '4,ABC',
              { from: shared.auth_account }
            );
          });
          it('should fail', async () => {
            await l.assertEOSErrorIncludesMessage(
              shared.dac_token_contract.unstake(staker.name, '75.0000 ABC', {
                from: staker,
              }),
              'STAKING_NOT_ENABLED'
            );
          });
        }
      );
      context('with staking enabled', async () => {
        before(async () => {
          await shared.dac_token_contract.stakeconfig(
            { enabled: true, min_stake_time: 5, max_stake_time: 20 },
            '4,ABC',
            { from: shared.auth_account }
          );
        });
        it('should fail for negative quantity with non positive error', async () => {
          await l.assertEOSErrorIncludesMessage(
            shared.dac_token_contract.unstake(staker.name, '-75.0000 ABC', {
              from: staker,
            }),
            'UNSTAKE_NON_POSITIVE_QTY'
          );
        });
        it('should fail for amount in excess of stake with unstake over staked amount error', async () => {
          await l.assertEOSErrorIncludesMessage(
            shared.dac_token_contract.unstake(staker.name, '151.0000 ABC', {
              from: staker,
            }),
            'UNSTAKE_OVER'
          );
        });
        it('should fail for no stake with no stake found error', async () => {
          await l.assertEOSErrorIncludesMessage(
            shared.dac_token_contract.unstake(
              otherAccount.name,
              '75.0000 ABC',
              { from: otherAccount }
            ),
            'NO_STAKE_FOUND'
          );
        });
        it('should succeed', async () => {
          await shared.dac_token_contract.unstake(staker.name, '74.0000 ABC', {
            from: staker,
          });
          await shared.dac_token_contract.unstake(staker.name, '30.0000 ABC', {
            from: staker,
          });
          await l.assertRowsEqual(
            shared.dac_token_contract.stakesTable({ scope: 'abcdac' }),
            [{ account: staker.name, stake: '46.0000 ABC' }]
          );
          let unstakeRow = await shared.dac_token_contract.unstakesTable({
            scope: 'abcdac',
          });
          let releaseDate = unstakeRow.rows[0].release_time;

          chai
            .expect(unstakeRow.rows[0])
            .to.include({ account: staker.name, stake: '74.0000 ABC', key: 0 });
          let nowDate = new Date();
          let futureDate = new Date();
          nowDate.setTime(nowDate.getTime() - 20000);
          futureDate.setTime(futureDate.getTime() + 20000);
          chai.expect(releaseDate).afterTime(nowDate);
          chai.expect(releaseDate).beforeTime(futureDate);
          chai.expect(unstakeRow.rows.length).to.equal(2);
        });
      });
    });
  });

  context('transfer', async () => {
    let sender: l.Account;
    let receiver: l.Account;
    before(async () => {
      sender = await l.AccountManager.createAccount();
      receiver = await l.AccountManager.createAccount();
      await shared.dac_token_contract.issue(
        sender.name,
        '1000.0000 ABC',
        'initial issued tokens',
        { from: issuer }
      );
    });
    context('with staking enabled', async () => {
      context('with nothing staked from sender', async () => {
        it('should succeed', async () => {
          await shared.dac_token_contract.transfer(
            sender.name,
            receiver.name,
            '10.0000 ABC',
            'memo',
            { from: sender }
          );
        });
      });
      context(
        'with some staked but not enough liquid for transfer',
        async () => {
          before(async () => {
            await shared.dac_token_contract.stake(sender.name, '100.0000 ABC', {
              from: sender,
            });
          });
          it('should fail', async () => {
            l.assertEOSErrorIncludesMessage(
              shared.dac_token_contract.transfer(
                sender.name,
                receiver.name,
                '900.0000 ABC',
                'memo',
                { from: sender }
              ),
              'ERR::BALANCE_STAKED'
            );
          });
        }
      );
      context('with some staked but enough liquid for transfer', async () => {
        it('should succeed', async () => {
          await shared.dac_token_contract.transfer(
            sender.name,
            receiver.name,
            '100.0000 ABC',
            'memo',
            { from: sender }
          );
        });
      });
      context(
        'with some staked and exactly enough liquid for transfer',
        async () => {
          it('should succeed', async () => {
            await shared.dac_token_contract.transfer(
              sender.name,
              receiver.name,
              '790.0000 ABC',
              'memo',
              { from: sender }
            );
          });
        }
      );
    });
  });
});

/*


  it('Registering as a member', async function() {
    let terms_hash: string = '1df37bdb72c0be963ef2bdfe9b7ef10b';
    const terms_url: string =
      'https://raw.githubusercontent.com/eosdac/eosdac-constitution/master/boilerplate_constitution.md';
    const terms_incorrect = '19254f2be00396b63c713e5b06e7dd36';

    await dao_token_contract.newmemtermse(terms_url, terms_hash, dac_id, {
      from: sharedTestObjects.auth_account
    });

    await l.assertEOSError(
      dao_token_contract.memberrege(donor1.name, terms_hash, dac_id, {
        from: donor1
      }),
      'eosio_assert_message_exception',
      'Attempt to register with no hash asserts'
    );

    await l.assertEOSError(
      dao_token_contract.memberrege(donor1.name, terms_hash, dac_id, {
        from: donor1
      }),
      'eosio_assert_message_exception',
      'Attempt to register with no member terms configured asserts'
    );

    await l.assertEOSError(
      dao_token_contract.memberrege(donor1.name, terms_incorrect, dac_id, {
        from: donor1
      }),
      'eosio_assert_message_exception',
      'Attempt to register with incorrect hash asserts'
    );

    // registration should succeed
    await dao_token_contract.memberrege(donor1.name, terms_hash, dac_id, {
      from: donor1
    });
  });
});
*/
