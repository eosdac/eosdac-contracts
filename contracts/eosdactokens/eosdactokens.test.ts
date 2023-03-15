import * as l from 'lamington';

import { SharedTestObjects, Account_type } from '../TestHelpers';
import * as chai from 'chai';
chai.use(require('chai-datetime'));

import { EosdactokensStakeConfig } from './eosdactokens';

describe('EOSDacTokens', () => {
  let shared: SharedTestObjects;
  let issuer: l.Account;
  let otherAccount: l.Account;
  let validAuths: { auths: { actor: string; permission: string }[] };

  before(async () => {
    shared = await SharedTestObjects.getInstance();
    issuer = await l.AccountManager.createAccount();
    otherAccount = await l.AccountManager.createAccount();
    validAuths = {
      auths: [
        { actor: issuer.name, permission: 'active' },
        {
          actor: shared.dac_token_contract.account.name,
          permission: 'active',
        },
      ],
    };
  });

  context('create token', async () => {
    it('with negative token quantity should fail with invalid supply error', async () => {
      await l.assertEOSErrorIncludesMessage(
        shared.dac_token_contract.create(
          issuer.name,
          `${2 ** 62 + 10} ABC`,
          false,
          validAuths
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
          validAuths
        ),
        'ERR::CREATE_MAX_SUPPLY_MUST_BE_POSITIVE'
      );
    });
    it('with valid asset should succeed', async () => {
      await shared.dac_token_contract.create(
        issuer.name,
        '100000.0000 ABC',
        false,
        validAuths
      );
    });
    it('with existing token should fail with existing token error', async () => {
      await l.assertEOSErrorIncludesMessage(
        shared.dac_token_contract.create(
          issuer.name,
          '1000000.0000 ABC',
          false,
          validAuths
        ),
        'ERR::CREATE_EXISITNG_SYMBOL'
      );
    });
  });
  context('issue token', async () => {
    it('with non existing token should fail with non-existing token error', async () => {
      await l.assertEOSErrorIncludesMessage(
        shared.dac_token_contract.issue(
          issuer.name,
          '10000.0000 CBA',
          'some memo',
          validAuths
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
          validAuths
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
          validAuths
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
          validAuths
        ),
        'ERR::ISSUE_INVALID_PRECISION:'
      );
    });
    it('to issuer should increase the issuer balance', async () => {
      await shared.dac_token_contract.issue(
        issuer.name,
        `1000.0000 ABC`,
        'some memo',
        validAuths
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
    context('to account other than the issuer', async () => {
      it('should fail with assertion', async () => {
        await l.assertEOSErrorIncludesMessage(
          shared.dac_token_contract.issue(
            otherAccount.name,
            `1200.0000 ABC`,
            'some memo',
            validAuths
          ),
          'tokens can only be issued to issuer account'
        );
      });
    });
    context('to other', async () => {
      context('without a dac', async () => {
        it('should fail with DAC not found for symbol error', async () => {
          await shared.dac_token_contract.issue(
            issuer.name,
            `1200.0000 ABC`,
            'some memo',
            validAuths
          );
          await l.assertEOSErrorIncludesMessage(
            shared.dac_token_contract.transfer(
              issuer.name,
              otherAccount.name,
              `1200.0000 ABC`,
              'some memo',
              validAuths
            ),
            'ERR::DAC_NOT_FOUND_SYMBOL'
          );
        });
      });
      context('with a dac', async () => {
        before(async () => {
          await shared.setup_new_auth_account();
          await shared.dacdirectory_contract.regdac(
            shared.auth_account.name,
            'abcdac',
            {
              contract: shared.dac_token_contract.account.name,
              sym: '4,ABC',
            },
            'abc dac_title',
            [],
            [
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
            issuer.name,
            `1200.0001 ABC`,
            'some memo',
            validAuths
          );
          await shared.dac_token_contract.transfer(
            issuer.name,
            otherAccount.name,
            `1200.0001 ABC`,
            'some memo',
            validAuths
          );
          await l.assertRowsEqual(
            shared.dac_token_contract.statTable({ scope: '4,ABC' }),
            []
          );

          await l.assertRowsEqual(
            shared.dac_token_contract.accountsTable({
              scope: otherAccount.name,
            }),
            [{ balance: '1200.0001 ABC' }]
          );
        });
      });
    });
  });
  context('Staking', async () => {
    let staker1: l.Account;
    let staker2: l.Account;
    before(async () => {
      staker1 = await l.AccountManager.createAccount('abcstaker1');
      staker2 = await l.AccountManager.createAccount('abcstaker2');
      await shared.dac_token_contract.issue(
        issuer.name,
        '30000.0000 ABC',
        'initial issued tokens',
        validAuths
      );
      await shared.dac_token_contract.transfer(
        issuer.name,
        staker1.name,
        '15000.0000 ABC',
        'please take these tokens for staking',
        validAuths
      );
      await shared.dac_token_contract.transfer(
        issuer.name,
        staker2.name,
        '15000.0000 ABC',
        'please take these tokens for staking',
        validAuths
      );
    });
    context('stakeconfig', async () => {
      let dacowner: Account;
      before(async () => {
        dacowner = await l.AccountManager.createAccount();
        await shared.dacdirectory_contract.regdac(
          dacowner.name,
          'stakeconfig',
          {
            contract: shared.dac_token_contract.account.name,
            sym: '4,STA',
          },
          'abc dac_title',
          [],
          [
            {
              key: Account_type.CUSTODIAN,
              value: shared.daccustodian_contract.account.name,
            },
          ],
          {
            auths: [{ actor: dacowner.name, permission: 'active' }],
          }
        );
      });
      it('should work', async () => {
        await shared.dac_token_contract.stakeconfig(
          { enabled: true, min_stake_time: 123, max_stake_time: 456 },
          '4,STA',
          { from: dacowner }
        );
      });
      it('should set the config values', async () => {
        const res = await shared.dac_token_contract.stakeconfigTable({
          scope: 'stakeconfig',
        });
        chai.expect(res.rows).to.deep.equal([
          {
            enabled: true,
            min_stake_time: 123,
            max_stake_time: 456,
          },
        ]);
      });
    });
    context('stake', async () => {
      context('stake without staking enabled', async () => {
        it('should fail with staking not enabled error', async () => {
          await l.assertEOSErrorIncludesMessage(
            shared.dac_token_contract.stake(staker1.name, '100.0000 ABC', {
              from: staker1,
            }),
            'ERR::STAKING_NOT_ENABLED'
          );
        });
      });
      context('with staking enabled', async () => {
        before(async () => {
          await shared.dac_token_contract.stakeconfig(
            { enabled: true, min_stake_time: 13, max_stake_time: 20 },
            '4,ABC',
            { from: shared.auth_account }
          );
        });
        it('with invalid quantity should fail with dac not found for symbol error', async () => {
          await l.assertEOSErrorIncludesMessage(
            shared.dac_token_contract.stake(
              staker1.name,
              `${10 + 2 ** 62}` + ' ABC',
              {
                from: staker1,
              }
            ),
            'ERR::STAKE_INVALID_QTY'
          ); // Since all matching token codes (ABC) will match in dacdirectory this will be found even with the wrong precision.
        });
        it('with negative quantity should fail with non-posistive error', async () => {
          await l.assertEOSErrorIncludesMessage(
            shared.dac_token_contract.stake(staker1.name, `-1000.0000 ABC`, {
              from: staker1,
            }),
            'STAKE_NON_POSITIVE_QTY'
          );
        });
        it('with more than available balance should fail with more than liquid error', async () => {
          await l.assertEOSErrorIncludesMessage(
            shared.dac_token_contract.stake(staker1.name, `15001.0000 ABC`, {
              from: staker1,
            }),
            'ERR::STAKE_MORE_LIQUID'
          );
        });
        it('with correct amount should succeed', async () => {
          await shared.dac_token_contract.stake(staker1.name, '4000.0000 ABC', {
            from: staker1,
          });

          await shared.dac_token_contract.stake(staker2.name, '6000.0000 ABC', {
            from: staker2,
          });

          await l.assertRowsEqual(
            shared.dac_token_contract.stakesTable({ scope: 'abcdac' }),
            [
              { account: staker1.name, stake: '4000.0000 ABC' },
              { account: staker2.name, stake: '6000.0000 ABC' },
            ]
          );
        });
        it('staking again should add more', async () => {
          await shared.dac_token_contract.stake(staker1.name, '1000.0000 ABC', {
            from: staker1,
          });
          await l.assertRowsEqual(
            shared.dac_token_contract.stakesTable({ scope: 'abcdac' }),
            [
              { account: staker1.name, stake: '5000.0000 ABC' },
              { account: staker2.name, stake: '6000.0000 ABC' },
            ]
          );
        });
        it('again with more than liquid balance should fail with more than liquid error', async () => {
          await l.assertEOSErrorIncludesMessage(
            shared.dac_token_contract.stake(staker1.name, `10001.0000 ABC`, {
              from: staker1,
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
              shared.dac_token_contract.unstake(staker1.name, '75.0000 ABC', {
                from: staker1,
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
            shared.dac_token_contract.unstake(staker1.name, '-75.0000 ABC', {
              from: staker1,
            }),
            'UNSTAKE_NON_POSITIVE_QTY'
          );
        });
        it('should fail for amount in excess of stake with unstake over staked amount error', async () => {
          await l.assertEOSErrorIncludesMessage(
            shared.dac_token_contract.unstake(staker1.name, '5001.0000 ABC', {
              from: staker1,
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
          await shared.dac_token_contract.unstake(
            staker1.name,
            '4500.0000 ABC',
            {
              from: staker1,
            }
          );
          await shared.dac_token_contract.unstake(
            staker1.name,
            '500.0000 ABC',
            {
              from: staker1,
            }
          );
          await shared.dac_token_contract.unstake(
            staker2.name,
            '6000.0000 ABC',
            {
              from: staker2,
            }
          );
          await l.assertRowsEqual(
            shared.dac_token_contract.stakesTable({ scope: 'abcdac' }),
            []
          );
          let unstakeRow = await shared.dac_token_contract.unstakesTable({
            scope: 'abcdac',
          });
          console.log('unstakeRow: ', JSON.stringify(unstakeRow, null, 2));
          let releaseDate = unstakeRow.rows[0].release_time;

          chai.expect(unstakeRow.rows[0]).to.include({
            account: staker1.name,
            stake: '4500.0000 ABC',
            key: 0,
          });
          let nowDate = new Date();
          let futureDate = new Date();
          nowDate.setTime(nowDate.getTime() - 20000);
          futureDate.setTime(futureDate.getTime() + 20000);
          chai.expect(releaseDate).afterTime(nowDate);
          chai.expect(releaseDate).beforeTime(futureDate);
          chai.expect(unstakeRow.rows.length).to.equal(3);
        });

        it('staking while unstaking should work', async () => {
          await shared.dac_token_contract.stake(
            staker1.name,
            '10000.0000 ABC',
            {
              from: staker1,
            }
          );
          await shared.dac_token_contract.stake(staker2.name, '9000.0000 ABC', {
            from: staker2,
          });
        });
        it('claimunstkes should do nothing if unstake is not yet released', async () => {
          await shared.dac_token_contract.claimunstkes(staker1.name, '4,ABC', {
            from: staker1,
          });
          let unstakeRow = await shared.dac_token_contract.unstakesTable({
            scope: 'abcdac',
          });
          chai.expect(unstakeRow.rows[0]).to.include({
            account: staker1.name,
            stake: '4500.0000 ABC',
            key: 0,
          });
        });
        it('transfer should fail if not yet released', async () => {
          const receiver = await l.AccountManager.createAccount();
          await l.assertEOSErrorIncludesMessage(
            shared.dac_token_contract.transfer(
              staker1.name,
              receiver.name,
              '5000.0000 ABC',
              'memo',
              { from: staker1 }
            ),
            'ERR::BALANCE_STAKED'
          );
        });
        it('claimunstkes should erase unstake if released', async () => {
          await l.sleep(6000);
          let unstakeRow = await shared.dac_token_contract.unstakesTable({
            scope: 'abcdac',
          });

          await shared.dac_token_contract.claimunstkes(staker1.name, '4,ABC', {
            from: staker1,
          });
          unstakeRow = await shared.dac_token_contract.unstakesTable({
            scope: 'abcdac',
          });

          chai.expect(unstakeRow.rows[0]).to.not.include({
            account: staker1.name,
            stake: '4500.0000 ABC',
            key: 0,
          });
        });
        it('transfer should succeed once released', async () => {
          const receiver = await l.AccountManager.createAccount();
          await shared.dac_token_contract.transfer(
            staker1.name,
            receiver.name,
            '5000.0000 ABC',
            'memo 2',
            { from: staker1 }
          );
        });
      });
    });
  });
  context('resetstakes', async () => {
    let user1: Account;
    let user2: Account;
    before(async () => {
      user1 = await l.AccountManager.createAccount('abcuser1');
      user2 = await l.AccountManager.createAccount('abcuser2');
      await shared.dac_token_contract.issue(
        issuer.name,
        '200.0000 ABC',
        'initial issued tokens',
        { from: issuer }
      );
      await shared.dac_token_contract.transfer(
        issuer.name,
        user1.name,
        '100.0000 ABC',
        'please take these tokens for staking',
        validAuths
      );
      await shared.dac_token_contract.transfer(
        issuer.name,
        user2.name,
        '100.0000 ABC',
        'please take these tokens for staking',
        validAuths
      );
    });
    context('staketime', async () => {
      it('should populate staketimesTable', async () => {
        await shared.dac_token_contract.staketime(user1, 14, '4,ABC', {
          from: user1,
        });
        await shared.dac_token_contract.staketime(user2, 14, '4,ABC', {
          from: user2,
        });
        await l.assertRowsEqual(
          shared.dac_token_contract.staketimeTable({ scope: 'abcdac' }),
          [
            {
              account: user1.name,
              delay: 14,
            },
            {
              account: user2.name,
              delay: 14,
            },
          ]
        );
      });
      it('staking and unstaking', async () => {
        await shared.dac_token_contract.stake(user1.name, '10.0000 ABC', {
          from: user1,
        });
        await shared.dac_token_contract.unstake(user1.name, '4.0000 ABC', {
          from: user1,
        });
        // await l.sleep(10_000);
        await shared.dac_token_contract.unstake(user1.name, '6.0000 ABC', {
          from: user1,
        });
        await l.assertRowsEqual(
          shared.dac_token_contract.staketimeTable({ scope: 'abcdac' }),
          [
            {
              account: user1.name,
              delay: 14,
            },
            {
              account: user2.name,
              delay: 14,
            },
          ]
        );
      });
      it('unstake 1 should not reset staketime', async () => {
        await l.sleep(4_000);
        await shared.dac_token_contract.claimunstkes(user1.name, '4,ABC', {
          from: user1,
        });

        await l.assertRowsEqual(
          shared.dac_token_contract.staketimeTable({ scope: 'abcdac' }),
          [
            {
              account: user1.name,
              delay: 14,
            },
            {
              account: user2.name,
              delay: 14,
            },
          ]
        );
      });
      it('unstake 2nd should reset staketime', async () => {
        await l.sleep(10_000);

        await shared.dac_token_contract.claimunstkes(user1.name, '4,ABC', {
          from: user1,
        });
        await l.assertRowsEqual(
          shared.dac_token_contract.staketimeTable({ scope: 'abcdac' }),
          [
            {
              account: user2.name,
              delay: 14,
            },
          ]
        );
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
        issuer.name,
        '1000.0000 ABC',
        'initial issued tokens',
        { from: issuer }
      );
      await shared.dac_token_contract.transfer(
        issuer.name,
        sender.name,
        '1000.0000 ABC',
        'here are your issued tokens',
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
            await l.assertEOSErrorIncludesMessage(
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
