import {
  Account,
  AccountManager,
  debugPromise,
  assertEOSErrorIncludesMessage,
  assertRowCount,
  assertRowsEqual,
  UpdateAuth,
} from 'lamington';

enum state_keys {
  total_weight_of_votes = 1,
  total_votes_on_candidates = 2,
  number_active_candidates = 3,
  met_initial_votes_threshold = 4,
  lastclaimbudgettime = 5,
  budget_percentage = 6,
}
const minutes = 60;
const hours = 60 * minutes;
const days = 24 * hours;
const months = 30 * days;
const years = 12 * months;

const STAKE_DURATION_FACTOR = 10;

import { SharedTestObjects, NUMBER_OF_CANDIDATES } from '../TestHelpers';
import * as chai from 'chai';
let shared: SharedTestObjects;

/* Asset class to be moved to lamginton later */
class Asset {
  amount: number;
  symbol: string;
  precision: number;
  constructor(amount, symbol, precision = 4) {
    this.amount = amount;
    this.symbol = symbol;
    this.precision = precision;
  }
  toString() {
    return `${this.amount.toFixed(this.precision)} ${this.symbol}`;
  }
  amount_raw() {
    return this.amount * 10 ** this.precision;
  }
}

describe('Stakevote', () => {
  before(async () => {
    shared = await SharedTestObjects.getInstance();
    await setup_permissions();
  });

  context('XXX', async () => {
    let dacId = 'stakedac';
    let symbol = 'STADAC';
    let precision = 4;
    let supply = `30000.0000 ${symbol}`;
    // let stake_amount = `1000.0000 ${symbol}`;
    let stake_amount = new Asset(1000, symbol);
    let stake_delay = 2 * years;
    let time_multiplier = 10000;
    let regMembers: Account[];
    let candidates: Account[];
    let staker: Account;

    before(async () => {
      await shared.initDac(dacId, `${precision},${symbol}`, supply, {
        vote_weight_account: shared.stakevote_contract,
      });
      await shared.updateconfig(dacId, `12.0000 ${symbol}`);
      await shared.dac_token_contract.stakeconfig(
        {
          enabled: true,
          min_stake_time: stake_delay,
          max_stake_time: stake_delay,
        },
        `${precision},${symbol}`,
        { from: shared.auth_account }
      );

      regMembers = await shared.getRegMembers(dacId, stake_amount.toString());

      await shared.stakevote_contract.updateconfig(
        { time_multiplier: 10 ** 8 },
        dacId,
        { from: shared.auth_account }
      );
    });
    context('staking', async () => {
      before(async () => {
        staker = await AccountManager.createAccount('staker1');
        const x = await get_from_dacglobals(
          dacId,
          state_keys.total_weight_of_votes
        );
        await shared.stakevote_contract.updateconfig(
          { time_multiplier },
          dacId,
          { from: shared.auth_account }
        );
      });
      it('should work', async () => {
        await shared.dac_token_contract.transfer(
          shared.dac_token_contract.account.name,
          staker.name,
          stake_amount.toString(),
          '',
          { from: shared.dac_token_contract.account }
        );

        await shared.dac_token_contract.stake(
          staker.name,
          stake_amount.toString(),
          {
            from: staker,
          }
        );
      });
      it('before voting, total_weight_of_votes should be zero', async () => {
        const x = await get_from_dacglobals(dacId, 'total_weight_of_votes');
        chai.expect(x).to.equal(0);
      });
      it('should create weights table entries', async () => {
        const expected_weight = await get_expected_vote_weight(
          stake_amount.amount_raw(),
          stake_delay,
          dacId
        );

        await assertRowsEqual(
          shared.stakevote_contract.weightsTable({
            scope: dacId,
          }),
          [
            {
              voter: 'staker1',
              weight: expected_weight,
              weight_quorum: 10000000,
            },
          ]
        );
      });
    });
    context('unstaking', async () => {
      before(async () => {
        await shared.dac_token_contract.stakeconfig(
          {
            enabled: true,
            min_stake_time: 1,
            max_stake_time: 1,
          },
          `${precision},${symbol}`,
          { from: shared.auth_account }
        );
      });
      it('should work', async () => {
        await shared.dac_token_contract.unstake(
          staker.name,
          stake_amount.toString(),
          {
            from: staker,
          }
        );
      });
      it('should remove weights table entries', async () => {
        await assertRowCount(
          shared.stakevote_contract.weightsTable({
            scope: dacId,
          }),
          0
        );
      });
      after(async () => {
        await shared.dac_token_contract.stakeconfig(
          {
            enabled: true,
            min_stake_time: stake_delay,
            max_stake_time: stake_delay,
          },
          `${precision},${symbol}`,
          { from: shared.auth_account }
        );
      });
    });
    context('without an activation account', async () => {
      context('before a dac has commenced periods', async () => {
        context('with enough INITIAL candidate value voting', async () => {
          before(async () => {
            candidates = await shared.getStakeObservedCandidates(
              dacId,
              `12.0000 ${symbol}`
            );
            for (const member of regMembers) {
              await debugPromise(
                shared.daccustodian_contract.votecust(
                  member.name,
                  [candidates[0].name, candidates[1].name],
                  dacId,
                  { from: member }
                ),
                'voting custodian for new period'
              );
            }
          });

          context('with enough candidates to fill the configs', async () => {
            let candidates: Account[];
            before(async () => {
              candidates = await shared.getStakeObservedCandidates(
                dacId,
                `12.0000 ${symbol}`
              );
              await shared.voteForCustodians(regMembers, candidates, dacId);

              // Change the config to a lower requestedPayMax to affect average pay tests after `newperiod` succeeds.
              // This change to `23.0000 EOS` should cause the requested pays of 25.0000 EOS to be fitered from the mean pay.
              await shared.daccustodian_contract.updateconfige(
                {
                  numelected: 5,
                  maxvotes: 4,
                  requested_pay_max: {
                    contract: 'eosio.token',
                    quantity: '23.0000 EOS',
                  },
                  periodlength: 5,
                  initial_vote_quorum_percent: 31,
                  vote_quorum_percent: 15,
                  auth_threshold_high: 4,
                  auth_threshold_mid: 3,
                  auth_threshold_low: 2,
                  token_supply_theshold: 10000001,
                  lockupasset: {
                    contract: shared.dac_token_contract.account.name,
                    quantity: `12.0000 ${symbol}`,
                  },
                  should_pay_via_service_provider: false,
                  lockup_release_time_delay: 1233,
                },
                dacId,
                { from: shared.auth_account }
              );
            });
            it('should throw NEWPERIOD_VOTER_ENGAGEMENT_LOW_ACTIVATE error', async () => {
              await assertEOSErrorIncludesMessage(
                shared.daccustodian_contract.newperiod(
                  'initial new period',
                  dacId,
                  {
                    from: regMembers[0], // Could be run by anyone.
                  }
                ),
                'NEWPERIOD_VOTER_ENGAGEMENT_LOW_ACTIVATE'
              );
            });
            it('staking', async () => {
              for (const member of regMembers) {
                await shared.dac_token_contract.stake(
                  member.name,
                  stake_amount.toString(),
                  {
                    from: member,
                  }
                );
              }
            });
            it('staking should update vote_weight', async () => {
              const expected_weight_of_votes =
                shared.NUMBER_OF_REG_MEMBERS * 10000000;
              const x = await get_from_dacglobals(
                dacId,
                'total_weight_of_votes'
              );
              chai.expect(x).to.equal(expected_weight_of_votes);
            });
            it('should succeed with custodians populated', async () => {
              await shared.daccustodian_contract.newperiod(
                'initial new period',
                dacId,
                {
                  from: regMembers[0], // Could be run by anyone.
                }
              );

              await assertRowCount(
                shared.daccustodian_contract.custodiansTable({
                  scope: dacId,
                  limit: 20,
                }),
                5
              );
            });
            it('Should have highest ranked votes in custodians', async () => {
              let rowsResult =
                await shared.daccustodian_contract.custodiansTable({
                  scope: dacId,
                  limit: 14,
                  indexPosition: 3,
                  keyType: 'i64',
                });
              let rs = rowsResult.rows;
              rs.sort((a, b) => {
                return a.total_votes < b.total_votes
                  ? -1
                  : a.total_votes == b.total_votes
                  ? 0
                  : 1;
              }).reverse();

              const single_voter_weight = await get_expected_vote_weight(
                stake_amount.amount_raw(),
                stake_delay,
                dacId
              );

              chai
                .expect(rs[0].total_votes)
                .to.equal(shared.NUMBER_OF_REG_MEMBERS * single_voter_weight);
              chai
                .expect(rs[1].total_votes)
                .to.equal(shared.NUMBER_OF_REG_MEMBERS * single_voter_weight);
              chai
                .expect(rs[2].total_votes)
                .to.equal(shared.NUMBER_OF_REG_MEMBERS * single_voter_weight);
              chai
                .expect(rs[3].total_votes)
                .to.equal(
                  (shared.NUMBER_OF_REG_MEMBERS * single_voter_weight) / 2
                );
              chai
                .expect(rs[4].total_votes)
                .to.equal(
                  (shared.NUMBER_OF_REG_MEMBERS * single_voter_weight) / 2
                );
            });
          });
        });
      });
    });
    context('stakevoting voting', async () => {
      let voter: Account;
      let total_weight_of_votes_beginning: number;
      let total_votes_on_candidates_beginning: number;
      before(async () => {
        voter = await AccountManager.createAccount();
        await shared.dac_token_contract.memberreg(
          voter.name,
          shared.configured_dac_memberterms,
          dacId,
          { from: voter }
        );
        await stake(voter, stake_amount.toString());
      });
      context('for 1 candidate', async () => {
        let total_weight_of_votes_before: number;
        let total_votes_on_candidates_before: number;
        it('stakeconfig should be set correctly', async () => {
          const res = await shared.dac_token_contract.stakeconfigTable({
            scope: dacId,
          });

          const max_stake_time = res.rows[0].max_stake_time;
          chai.expect(max_stake_time).to.equal(stake_delay);
        });
        it('before voting: total_weight_of_votes', async () => {
          total_weight_of_votes_before = await get_from_dacglobals(
            dacId,
            'total_weight_of_votes'
          );
          total_weight_of_votes_beginning = total_weight_of_votes_before;
        });
        it('before voting: total_votes_on_candidates', async () => {
          total_votes_on_candidates_before = await get_from_dacglobals(
            dacId,
            'total_votes_on_candidates'
          );
          total_votes_on_candidates_beginning =
            total_votes_on_candidates_before;
        });
        it('should work', async () => {
          const cust1 = candidates[0];
          await shared.daccustodian_contract.votecust(
            voter.name,
            [cust1.name],
            dacId,
            {
              from: voter,
            }
          );
        });
        it('should update total_weight_of_votes', async () => {
          const expected =
            total_weight_of_votes_before + stake_amount.amount_raw();
          const x = await get_from_dacglobals(dacId, 'total_weight_of_votes');
          chai.expect(x).to.equal(expected);
        });
        it('should update total_votes_on_candidates', async () => {
          const expected =
            total_votes_on_candidates_before +
            (await get_expected_vote_weight(
              stake_amount.amount_raw(),
              stake_delay,
              dacId
            ));
          const x = await get_from_dacglobals(
            dacId,
            'total_votes_on_candidates'
          );
          chai.expect(parseInt(x, 10)).to.equal(expected);
        });
      });
      context('for 2nd candidate', async () => {
        let total_weight_of_votes_before: number;
        let total_votes_on_candidates_before: number;
        it('before voting: total_weight_of_votes', async () => {
          total_weight_of_votes_before = await get_from_dacglobals(
            dacId,
            'total_weight_of_votes'
          );
        });
        it('before voting: total_votes_on_candidates', async () => {
          total_votes_on_candidates_before = await get_from_dacglobals(
            dacId,
            'total_votes_on_candidates'
          );
        });
        it('should work', async () => {
          const cust1 = candidates[0];
          const cust2 = candidates[1];
          await shared.daccustodian_contract.votecust(
            voter.name,
            [cust1.name, cust2.name],
            dacId,
            {
              from: voter,
            }
          );
        });
        it('should not increase total_weight_of_votes', async () => {
          const expected = total_weight_of_votes_before;
          const x = await get_from_dacglobals(dacId, 'total_weight_of_votes');
          chai.expect(x).to.equal(expected);
        });
        it('should not increase total_votes_on_candidates', async () => {
          const expected = total_votes_on_candidates_before;
          const x = await get_from_dacglobals(
            dacId,
            'total_votes_on_candidates'
          );
          chai.expect(x).to.equal(expected);
        });
      });
      context('removing vote', async () => {
        let total_weight_of_votes_before: number;
        let total_votes_on_candidates_before: number;
        it('before voting: total_weight_of_votes', async () => {
          total_weight_of_votes_before = await get_from_dacglobals(
            dacId,
            'total_weight_of_votes'
          );
        });
        it('before voting: total_votes_on_candidates', async () => {
          total_votes_on_candidates_before = await get_from_dacglobals(
            dacId,
            'total_votes_on_candidates'
          );
        });
        it('should work', async () => {
          const cust1 = candidates[0];
          await shared.daccustodian_contract.votecust(
            voter.name,
            [cust1.name],
            dacId,
            {
              from: voter,
            }
          );
        });
        it('should not decrease total_weight_of_votes', async () => {
          const expected = total_weight_of_votes_before;
          const x = await get_from_dacglobals(dacId, 'total_weight_of_votes');
          chai.expect(x).to.equal(expected);
        });
        it('should not decrease total_votes_on_candidates', async () => {
          const expected = total_votes_on_candidates_before;
          const x = await get_from_dacglobals(
            dacId,
            'total_votes_on_candidates'
          );
          chai.expect(x).to.equal(expected);
        });
      });
      context('removing all votes', async () => {
        let total_weight_of_votes_before;
        let total_votes_on_candidates_before;
        it('before voting: total_weight_of_votes', async () => {
          total_weight_of_votes_before = await get_from_dacglobals(
            dacId,
            'total_weight_of_votes'
          );
        });
        it('before voting: total_votes_on_candidates', async () => {
          total_votes_on_candidates_before = await get_from_dacglobals(
            dacId,
            'total_votes_on_candidates'
          );
        });
        it('should work', async () => {
          // const cust1 = candidates[0];
          await shared.daccustodian_contract.votecust(voter.name, [], dacId, {
            from: voter,
          });
        });
        it('should restore original total_weight_of_votes', async () => {
          const expected = total_weight_of_votes_beginning;
          const x = await get_from_dacglobals(dacId, 'total_weight_of_votes');
          chai.expect(x).to.equal(expected);
        });
        it('should restore original total_votes_on_candidates', async () => {
          const expected = total_votes_on_candidates_beginning;
          const x = await get_from_dacglobals(
            dacId,
            'total_votes_on_candidates'
          );
          chai.expect(x).to.equal(expected);
        });
      });
    });
  });
});

async function add_custom_permission(
  account: any,
  name: string,
  parent = 'active'
) {
  if (account.account) {
    account = account.account;
  }
  await UpdateAuth.execUpdateAuth(
    account.active,
    account.name,
    name,
    parent,
    UpdateAuth.AuthorityToSet.forContractCode(account)
  );
}
async function linkauth(
  permission_owner: any,
  permission_name: string,
  action_owner: any,
  action_names: string | string[]
) {
  if (permission_owner.account) {
    permission_owner = permission_owner.account;
  }
  if (action_owner.account) {
    action_owner = action_owner.account;
  }
  if (!Array.isArray(action_names)) {
    action_names = [action_names];
  }
  for (const action_name of action_names) {
    await UpdateAuth.execLinkAuth(
      permission_owner.active,
      permission_owner.name,
      action_owner.name,
      action_name,
      permission_name
    );
  }
}
async function add_custom_permission_and_link(
  permission_owner: string,
  permission_name: string,
  action_owner: string,
  action_names: string
) {
  await add_custom_permission(permission_owner, permission_name);
  await linkauth(permission_owner, permission_name, action_owner, action_names);
}

async function setup_permissions() {
  await linkauth(
    shared.dac_token_contract.account,
    'notify',
    shared.stakevote_contract.account,
    ['balanceobsv', 'stakeobsv']
  );

  await add_custom_permission_and_link(
    shared.stakevote_contract,
    'notify',
    shared.daccustodian_contract,
    ['stakeobsv', 'weightobsv']
  );
}

async function stake(user: Account, amount: string) {
  await shared.dac_token_contract.transfer(
    shared.dac_token_contract.account.name,
    user.name,
    amount,
    '',
    { from: shared.dac_token_contract.account }
  );
  await shared.dac_token_contract.stake(user.name, amount, {
    from: user,
  });
}

async function get_from_dacglobals(dacId: string, key: string) {
  const res = await shared.daccustodian_contract.dacglobalsTable({
    scope: dacId,
  });
  const data = res.rows[0].data;
  for (const x of data) {
    if (x.key == key) {
      return x.value[1];
    }
  }
}

async function get_expected_vote_weight(
  stake_delta: number,
  unstake_delay: number,
  dac_id: string
) {
  const time_divisor = 100000000;
  const config = (
    await shared.stakevote_contract.configTable({ scope: dac_id })
  ).rows[0];
  const time_multiplier = config.time_multiplier;
  const res = await shared.dac_token_contract.stakeconfigTable({
    scope: dac_id,
  });
  const max_stake_time = res.rows[0].max_stake_time;

  return Math.floor(
    stake_delta *
      (1 +
        Math.floor(
          (STAKE_DURATION_FACTOR * unstake_delay * time_multiplier) /
            time_divisor /
            max_stake_time
        ))
  );
}
