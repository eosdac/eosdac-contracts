import {
  Account,
  AccountManager,
  debugPromise,
  assertEOSErrorIncludesMessage,
  assertRowCount,
  assertRowsEqual,
  UpdateAuth,
  Asset,
  sleep,
} from 'lamington';
import { SharedTestObjects, NUMBER_OF_CANDIDATES } from '../TestHelpers';
import * as chai from 'chai';
import _ = require('lodash');

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

let shared: SharedTestObjects;

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
    let default_staketime = 2 * days;
    let max_stake_time = 7776000;
    let time_multiplier = 4;
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
          min_stake_time: 2 * days,
          max_stake_time,
        },
        `${precision},${symbol}`,
        { from: shared.auth_account }
      );
      regMembers = await shared.getRegMembers(dacId, stake_amount);

      await shared.stakevote_contract.updateconfig(
        { time_multiplier: 10 ** 8 },
        dacId,
        { from: shared.auth_account }
      );
    });
    context('staking', async () => {
      before(async () => {
        staker = await AccountManager.createAccount('staker1');
        await shared.dac_token_contract.staketime(
          staker,
          default_staketime,
          '4,' + stake_amount.symbol,
          { from: staker }
        );

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
          shared.tokenIssuer.name,
          staker.name,
          stake_amount,
          '',
          { from: shared.tokenIssuer }
        );

        await shared.dac_token_contract.stake(staker.name, stake_amount, {
          from: staker,
        });
      });
      it('before voting, total_weight_of_votes should be zero', async () => {
        const x = await get_from_dacglobals(dacId, 'total_weight_of_votes');
        chai.expect(x).to.equal(0);
      });
      it('should create weights table entries', async () => {
        const expected_weight = await get_expected_vote_weight(
          staker,
          stake_amount.amount_raw(),
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
        await shared.stakevote_contract.clearweights(100, dacId);
        await shared.stakevote_contract.collectwts(100, dacId, false);
      });
      it('should work', async () => {
        await shared.dac_token_contract.unstake(staker.name, stake_amount, {
          from: staker,
        });
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
            min_stake_time: 2 * days,
            max_stake_time,
          },
          `${precision},${symbol}`,
          { from: shared.auth_account }
        );
      });
    });
    context('staking and unstaking repeatedly', async () => {
      it('should work', async () => {
        await shared.dac_token_contract.transfer(
          shared.tokenIssuer.name,
          staker.name,
          '1000.0000 STADAC',
          '',
          { from: shared.tokenIssuer }
        );

        await shared.dac_token_contract.stake(staker.name, '1.0000 STADAC', {
          from: staker,
        });

        await shared.dac_token_contract.unstake(staker.name, '0.0005 STADAC', {
          from: staker,
        });

        await shared.dac_token_contract.staketime(
          staker.name,
          4 * days,
          '4,STADAC',
          {
            from: staker,
          }
        );

        await shared.dac_token_contract.unstake(staker.name, '0.0001 STADAC', {
          from: staker,
        });
        await shared.dac_token_contract.unstake(staker.name, '0.0002 STADAC', {
          from: staker,
        });
        await shared.dac_token_contract.unstake(staker.name, '0.0003 STADAC', {
          from: staker,
        });
        await shared.dac_token_contract.unstake(staker.name, '0.0004 STADAC', {
          from: staker,
        });
        await shared.dac_token_contract.stake(staker.name, '0.0005 STADAC', {
          from: staker,
        });
        await shared.dac_token_contract.staketime(
          staker.name,
          20 * days,
          '4,STADAC',
          {
            from: staker,
          }
        );
        await shared.dac_token_contract.unstake(staker.name, '0.9983 STADAC', {
          from: staker,
        });
        await shared.dac_token_contract.unstake(staker.name, '0.0007 STADAC', {
          from: staker,
        });
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
                  stake_amount,
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
                  indexPosition: 2,
                  keyType: 'i64',
                });
              let rs = rowsResult.rows;
              for (const i of _.range(5)) {
                chai
                  .expect(parseInt(rs[i].rank, 10), 'chai 1')
                  .to.equal(
                    await get_expected_rank(
                      new Account(rs[i].cust_name),
                      stake_amount.amount_raw(),
                      dacId
                    )
                  );
              }
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
        await stake(voter, stake_amount);
      });
      context('for 1 candidate', async () => {
        let total_weight_of_votes_before: number;
        let total_votes_on_candidates_before: number;
        it('stakeconfig should be set correctly', async () => {
          const res = await shared.dac_token_contract.stakeconfigTable({
            scope: dacId,
          });

          const max_stake_time = res.rows[0].max_stake_time;
          chai.expect(max_stake_time).to.equal(max_stake_time);
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
            parseInt(total_votes_on_candidates_before, 10) +
            (await get_expected_vote_weight(
              voter,
              stake_amount.amount_raw(),
              dacId
            ));
          const x = await get_from_dacglobals(
            dacId,
            'total_votes_on_candidates'
          );
          chai.expect(parseInt(x, 10)).to.equal(expected);
        });
      });
      context('staking and unstaking repeatedly', async () => {
        it('should work', async () => {
          await sleep(1000);
          await shared.dac_token_contract.transfer(
            shared.tokenIssuer.name,
            voter.name,
            '2000.0000 STADAC',
            '',
            { from: shared.tokenIssuer }
          );

          await shared.dac_token_contract.stake(
            voter.name,
            '1000.0000 STADAC',
            {
              from: voter,
            }
          );

          await shared.dac_token_contract.unstake(voter.name, '0.0005 STADAC', {
            from: voter,
          });

          await shared.dac_token_contract.staketime(
            voter.name,
            4 * days,
            '4,STADAC',
            {
              from: voter,
            }
          );

          await shared.dac_token_contract.unstake(voter.name, '0.0001 STADAC', {
            from: voter,
          });
          await shared.dac_token_contract.unstake(voter.name, '0.0002 STADAC', {
            from: voter,
          });
          await shared.dac_token_contract.unstake(voter.name, '0.0003 STADAC', {
            from: voter,
          });
          await shared.dac_token_contract.unstake(voter.name, '0.0004 STADAC', {
            from: voter,
          });
          await shared.dac_token_contract.stake(voter.name, '0.0005 STADAC', {
            from: voter,
          });
          await shared.dac_token_contract.staketime(
            voter.name,
            20 * days,
            '4,STADAC',
            {
              from: voter,
            }
          );
          await shared.dac_token_contract.unstake(voter.name, '0.9989 STADAC', {
            from: voter,
          });
          await shared.dac_token_contract.unstake(
            voter.name,
            '1998.9994 STADAC',
            {
              from: voter,
            }
          );
          await shared.dac_token_contract.unstake(voter.name, '0.0007 STADAC', {
            from: voter,
          });

          await stake(voter, stake_amount);
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
      context('changing 2nd candidate', async () => {
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
          const cust3 = candidates[2];
          await shared.daccustodian_contract.votecust(
            voter.name,
            [cust1.name, cust3.name],
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
          chai.expect(expected - x).to.be.lessThanOrEqual(1); // account for rounding errors
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
    shared.tokenIssuer.name,
    user.name,
    amount,
    '',
    { from: shared.tokenIssuer }
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

async function get_staketime(account: Account, dac_id: string) {
  const res = await shared.dac_token_contract.stakeconfigTable({
    scope: dac_id,
  });

  const min_stake_time = res.rows[0].min_stake_time;
  res = await shared.dac_token_contract.staketimeTable({
    scope: dac_id,
    lowerBound: account.name,
  });
  const existing_staketime = res.rows.find((x) => x.account == account);
  const x = existing_staketime ? existing_staketime.delay : min_stake_time;
  return x;
}

async function get_expected_vote_weight(
  account: Account,
  stake_delta: number,
  dac_id: string
) {
  const config = (
    await shared.stakevote_contract.configTable({ scope: dac_id })
  ).rows[0];
  const time_multiplier = config.time_multiplier;
  const res = await shared.dac_token_contract.stakeconfigTable({
    scope: dac_id,
  });
  const max_stake_time = res.rows[0].max_stake_time;

  const unstake_delay = await get_staketime(account, dac_id);

  return Math.floor(
    stake_delta * (1 + (unstake_delay * time_multiplier) / max_stake_time)
  );
}

async function get_expected_rank(
  account: Account | string,
  stake_delta: number,
  dac_id: string
) {
  /* 
                const auto scaling_factor = S{10000.0}; // to improve accuracy of index when converting double to uint64_t

            // log(0) is -infinity, so we always add 1. This does not change the order of the index.
            const auto log_arg = S{total_vote_power} + S{1ull};
            const auto log     = log2(log_arg.to<double>());
            const auto x =
                (S{log} + S{avg_vote_time_stamp.sec_since_epoch()}.to<double>() / S{SECONDS_TO_DOUBLE}.to<double>()) *
                scaling_factor;
            return x.to<uint64_t>();


            static constexpr uint32_t MINUTES{60};
static constexpr uint32_t HOURS{60 * MINUTES};
static constexpr uint32_t DAYS{24 * HOURS};
static constexpr uint32_t MONTHS{30 * DAYS};
static constexpr uint32_t YEARS{12 * MONTHS};

// TODO: Fill in final value for SECONDS_TO_DOUBLE
static constexpr uint32_t SECONDS_TO_DOUBLE{30 * DAYS};
            */
  const minutes = 60;
  const hours = 60 * minutes;
  const days = 24 * hours;
  const SECONDS_TO_DOUBLE = 30 * days;
  const res = await shared.daccustodian_contract.candidatesTable({
    scope: dac_id,
    lowerBound: account.name,
    upperBound: account.name,
  });
  const candidate = res.rows.find((x) => (x.candidate_name = account.name));
  const avg_vote_time_stamp = candidate.avg_vote_time_stamp.getTime();
  const scaling_factor = 10000;
  const total_vote_power = candidate.total_vote_power;
  const log = Math.log2(total_vote_power + 1);
  const x =
    (log + (avg_vote_time_stamp * scaling_factor) / SECONDS_TO_DOUBLE) *
    scaling_factor;
  return Math.floor(x);
}
