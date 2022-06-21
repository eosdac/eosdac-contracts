import {
  Account,
  AccountManager,
  sleep,
  EOSManager,
  debugPromise,
  assertEOSErrorIncludesMessage,
  assertRowCount,
  assertMissingAuthority,
  assertRowsEqual,
  TableRowsResult,
  assertBalanceEqual,
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

import { SharedTestObjects, NUMBER_OF_CANDIDATES } from '../TestHelpers';
import * as chai from 'chai';

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
    let regMembers: Account[];

    before(async () => {
      await shared.initDac(
        dacId,
        `${precision},${symbol}`,
        `3000.0000 ${symbol}`,
        {
          vote_weight_account: shared.stakevote_contract,
        }
      );
      await shared.updateconfig(dacId, `12.0000 ${symbol}`);
      await shared.dac_token_contract.stakeconfig(
        { enabled: true, min_stake_time: 5, max_stake_time: 20 },
        `${precision},${symbol}`,
        { from: shared.auth_account }
      );

      regMembers = await shared.getRegMembers(dacId, `100.0000 ${symbol}`);
    });
    context('staking', async () => {
      let staker;
      before(async () => {
        staker = await AccountManager.createAccount();
        const x = await get_from_state2(
          dacId,
          state_keys.total_weight_of_votes
        );
        console.log('total_weight_of_votes before: ', x);
      });
      it('should work', async () => {
        await shared.dac_token_contract.transfer(
          shared.dac_token_contract.account.name,
          staker.name,
          `100.0000 ${symbol}`,
          '',
          { from: shared.dac_token_contract.account }
        );

        await shared.dac_token_contract.stake(
          staker.name,
          `100.0000 ${symbol}`,
          {
            from: staker,
          }
        );
      });
      it('should update vote_weight', async () => {
        const x = await get_from_state2(
          dacId,
          state_keys.total_weight_of_votes
        );
        console.log('total_weight_of_votes after: ', x);
        // chai.expect(x).to.equal(32);
      });
    });
    context('without an activation account', async () => {
      context('before a dac has commenced periods', async () => {
        context('with enough INITIAL candidate value voting', async () => {
          let candidates: Account[];
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
                  `100.0000 ${symbol}`,
                  {
                    from: member,
                  }
                );
              }
            });
            it('staking should update vote_weight', async () => {
              const expected_weight_of_votes =
                shared.NUMBER_OF_REG_MEMBERS * 1000000;
              const x = await get_from_state2(
                dacId,
                state_keys.total_weight_of_votes
              );
              console.log(
                'staking should update vote_weight total_weight_of_votes: ',
                x
              );
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
              let rowsResult = await shared.daccustodian_contract.custodiansTable(
                {
                  scope: dacId,
                  limit: 14,
                  indexPosition: 3,
                  keyType: 'i64',
                }
              );
              let rs = rowsResult.rows;
              rs.sort((a, b) => {
                return a.total_votes < b.total_votes
                  ? -1
                  : a.total_votes == b.total_votes
                  ? 0
                  : 1;
              }).reverse();
              console.log('rs: ', JSON.stringify(rs, null, 2));
              chai.expect(rs[0].total_votes).to.equal(80000000);
              chai.expect(rs[1].total_votes).to.equal(80000000);
              chai.expect(rs[2].total_votes).to.equal(80000000);
              chai.expect(rs[3].total_votes).to.equal(40000000);
              chai.expect(rs[4].total_votes).to.equal(40000000);
            });
          });
        });
      });
    });
  });
});

async function add_custom_permission(account, name, parent = 'active') {
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
  permission_owner,
  permission_name,
  action_owner,
  action_names
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
  permission_owner,
  permission_name,
  action_owner,
  action_names
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

async function stake(user, amount) {
  await shared.dac_token_contract.transfer(
    shared.dac_token_contract.account.name,
    newUser1.name,
    amount,
    '',
    { from: shared.dac_token_contract.account }
  );
  await shared.dac_token_contract.stake(user.name, amount, {
    from: user,
  });
}

async function get_from_state2(dacId, key) {
  const res = await shared.daccustodian_contract.state2Table({
    scope: dacId,
  });
  const data = res.rows[0].data;
  for (const x of data) {
    if (x.key == key) {
      return x.value[1];
    }
  }
}
