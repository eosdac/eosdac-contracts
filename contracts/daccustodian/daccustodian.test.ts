// import * as l from 'lamington';
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
  Asset,
} from 'lamington';
const _ = require('lodash');
import {
  SharedTestObjects,
  NUMBER_OF_CANDIDATES,
  Account_type,
} from '../TestHelpers';
import * as chai from 'chai';
const dayjs = require('dayjs');
const utc = require('dayjs/plugin/utc');
dayjs.extend(utc);
import { DaccustodianCandidate } from './daccustodian';
import * as deepEqualInAnyOrder from 'deep-equal-in-any-order';
chai.use(deepEqualInAnyOrder);
let shared: SharedTestObjects;

enum state_keys {
  total_weight_of_votes = 1,
  total_votes_on_candidates = 2,
  number_active_candidates = 3,
  met_initial_votes_threshold = 4,
  lastclaimbudgettime = 5,
  budget_percentage = 6,
}

const NFT_COLLECTION = 'alien.worlds';
const BUDGET_SCHEMA = 'budget';

describe('Daccustodian', () => {
  let second_nft_id: number;
  let somebody: Account;
  before(async () => {
    await sleep(20000);
    shared = await SharedTestObjects.getInstance();
    somebody = await AccountManager.createAccount();
  });

  context('fillstate', async () => {
    let dacId = 'migratedac';
    before(async () => {
      await shared.daccustodian_contract.fillstate(dacId);
    });
  });

  context('updateconfige', async () => {
    const dacId = 'custodiandac';
    before(async () => {
      await shared.initDac(dacId, '4,CUSDAC', '1000000.0000 CUSDAC');
    });
    it('Should fail for a dac_id without a dac', async () => {
      await assertEOSErrorIncludesMessage(
        shared.daccustodian_contract.updateconfige(
          {
            numelected: 5,
            maxvotes: 5,
            auth_threshold_mid: 6,
            requested_pay_max: { contract: 'sdfsdf', quantity: '12.0000 EOS' },
            periodlength: 37500,
            initial_vote_quorum_percent: 31,
            vote_quorum_percent: 15,
            auth_threshold_high: 4,
            auth_threshold_low: 3,
            lockupasset: { contract: 'sdfsdf', quantity: '12.0000 EOS' },
            should_pay_via_service_provider: false,
            lockup_release_time_delay: 1233,
            token_supply_theshold: 10000001,
          },
          'unknowndac',
          { from: shared.auth_account }
        ),
        'ERR::DAC_NOT_FOUND'
      );
      await assertRowsEqual(
        shared.daccustodian_contract.dacglobalsTable({
          scope: 'unknowndac',
          limit: 1,
        }),
        []
      );
    });
    it('Should fail for invalid high auth threshold', async () => {
      await assertEOSErrorIncludesMessage(
        shared.daccustodian_contract.updateconfige(
          {
            numelected: 5,
            maxvotes: 5,
            requested_pay_max: { contract: 'sdfsdf', quantity: '12.0000 EOS' },
            periodlength: 37500,
            initial_vote_quorum_percent: 31,
            vote_quorum_percent: 15,
            auth_threshold_high: 5,
            auth_threshold_mid: 6,
            auth_threshold_low: 3,
            lockupasset: { contract: 'sdfsdf', quantity: '12.0000 EOS' },
            should_pay_via_service_provider: false,
            lockup_release_time_delay: 1233,
            token_supply_theshold: 10000001,
          },
          dacId,
          { from: shared.auth_account }
        ),
        'ERR::UPDATECONFIG_INVALID_AUTH_HIGH_TO_NUM_ELECTED'
      );
      await assertRowsEqual(
        shared.daccustodian_contract.dacglobalsTable({
          scope: dacId,
          limit: 2,
        }),
        []
      );
    });
    it('Should fail for invalid mid auth threshold', async () => {
      await assertEOSErrorIncludesMessage(
        shared.daccustodian_contract.updateconfige(
          {
            numelected: 12,
            maxvotes: 5,
            requested_pay_max: { contract: 'sdfsdf', quantity: '12.0000 EOS' },
            periodlength: 37500,
            initial_vote_quorum_percent: 31,
            vote_quorum_percent: 15,
            auth_threshold_high: 9,
            auth_threshold_mid: 10,
            auth_threshold_low: 4,
            lockupasset: { contract: 'sdfsdf', quantity: '12.0000 EOS' },
            should_pay_via_service_provider: false,
            lockup_release_time_delay: 1233,
            token_supply_theshold: 10000001,
          },
          dacId,
          { from: shared.auth_account }
        ),
        'ERR::UPDATECONFIG_INVALID_AUTH_HIGH_TO_MID_AUTH'
      );
      await assertRowsEqual(
        shared.daccustodian_contract.dacglobalsTable({
          scope: dacId,
          limit: 2,
        }),
        []
      );
    });
    it('Should fail for invalid low auth threshold', async () => {
      await assertEOSErrorIncludesMessage(
        shared.daccustodian_contract.updateconfige(
          {
            numelected: 12,
            maxvotes: 5,
            requested_pay_max: { contract: 'sdfsdf', quantity: '12.0000 EOS' },
            periodlength: 5,
            initial_vote_quorum_percent: 31,
            vote_quorum_percent: 15,
            auth_threshold_high: 9,
            auth_threshold_mid: 7,
            auth_threshold_low: 8,
            lockupasset: { contract: 'sdfsdf', quantity: '12.0000 EOS' },
            should_pay_via_service_provider: false,
            lockup_release_time_delay: 1233,
            token_supply_theshold: 10000001,
          },
          dacId,
          { from: shared.auth_account }
        ),
        'ERR::UPDATECONFIG_INVALID_AUTH_MID_TO_LOW_AUTH'
      );
      await assertRowsEqual(
        shared.daccustodian_contract.dacglobalsTable({
          scope: dacId,
          limit: 2,
        }),
        []
      );
    });
    it('Should fail for invalid num elected', async () => {
      await assertEOSErrorIncludesMessage(
        shared.daccustodian_contract.updateconfige(
          {
            numelected: 68,
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
              quantity: '12.0000 CUSDAC',
            },
            should_pay_via_service_provider: false,
            lockup_release_time_delay: 1233,
            token_supply_theshold: 10000001,
          },
          dacId,
          { from: shared.auth_account }
        ),
        'ERR::UPDATECONFIG_INVALID_NUM_ELECTED'
      );
    });
    it('Should fail for invalid max votes', async () => {
      await assertEOSErrorIncludesMessage(
        shared.daccustodian_contract.updateconfige(
          {
            numelected: 12,
            maxvotes: 13,
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
              quantity: '12.0000 CUSDAC',
            },
            should_pay_via_service_provider: false,
            lockup_release_time_delay: 1233,
            token_supply_theshold: 10000001,
          },
          dacId,
          { from: shared.auth_account }
        ),
        'ERR::UPDATECONFIG_INVALID_MAX_VOTES'
      );
    });
    it('Should fail for invalid period length', async () => {
      await assertEOSErrorIncludesMessage(
        shared.daccustodian_contract.updateconfige(
          {
            numelected: 12,
            maxvotes: 5,
            requested_pay_max: {
              contract: 'eosio.token',
              quantity: '30.0000 EOS',
            },
            periodlength: 4 * 365 * 24 * 60 * 60,
            initial_vote_quorum_percent: 31,
            vote_quorum_percent: 15,
            auth_threshold_high: 4,
            auth_threshold_mid: 3,
            auth_threshold_low: 2,
            lockupasset: {
              contract: shared.dac_token_contract.account.name,
              quantity: '12.0000 CUSDAC',
            },
            should_pay_via_service_provider: false,
            lockup_release_time_delay: 1233,
            token_supply_theshold: 10000001,
          },
          dacId,
          { from: shared.auth_account }
        ),
        'ERR::UPDATECONFIG_PERIOD_LENGTH'
      );
    });
    it('Should fail for invalid initial quorum percent', async () => {
      await assertEOSErrorIncludesMessage(
        shared.daccustodian_contract.updateconfige(
          {
            numelected: 12,
            maxvotes: 5,
            requested_pay_max: {
              contract: 'eosio.token',
              quantity: '30.0000 EOS',
            },
            periodlength: 7 * 24 * 60 * 60,
            initial_vote_quorum_percent: 100,
            vote_quorum_percent: 15,
            auth_threshold_high: 4,
            auth_threshold_mid: 3,
            auth_threshold_low: 2,
            lockupasset: {
              contract: shared.dac_token_contract.account.name,
              quantity: '12.0000 CUSDAC',
            },
            should_pay_via_service_provider: false,
            lockup_release_time_delay: 1233,
            token_supply_theshold: 10000001,
          },
          dacId,
          { from: shared.auth_account }
        ),
        'ERR::UPDATECONFIG_INVALID_INITIAL_VOTE_QUORUM_PERCENT'
      );
    });
    it('Should fail for invalid quorum percent', async () => {
      await assertEOSErrorIncludesMessage(
        shared.daccustodian_contract.updateconfige(
          {
            numelected: 12,
            maxvotes: 5,
            requested_pay_max: {
              contract: 'eosio.token',
              quantity: '30.0000 EOS',
            },
            periodlength: 7 * 24 * 60 * 60,
            initial_vote_quorum_percent: 31,
            vote_quorum_percent: 101,
            auth_threshold_high: 4,
            auth_threshold_mid: 3,
            auth_threshold_low: 2,
            lockupasset: {
              contract: shared.dac_token_contract.account.name,
              quantity: '12.0000 CUSDAC',
            },
            should_pay_via_service_provider: false,
            lockup_release_time_delay: 1233,
            token_supply_theshold: 10000001,
          },
          dacId,
          { from: shared.auth_account }
        ),
        'ERR::UPDATECONFIG_INVALID_VOTE_QUORUM_PERCENT'
      );
    });
    it('Should fail for low token theshold', async () => {
      await assertEOSErrorIncludesMessage(
        shared.daccustodian_contract.updateconfige(
          {
            numelected: 12,
            maxvotes: 5,
            requested_pay_max: {
              contract: 'eosio.token',
              quantity: '30.0000 EOS',
            },
            periodlength: 7 * 24 * 60 * 60,
            initial_vote_quorum_percent: 31,
            vote_quorum_percent: 15,
            auth_threshold_high: 4,
            auth_threshold_mid: 3,
            auth_threshold_low: 2,
            lockupasset: {
              contract: shared.dac_token_contract.account.name,
              quantity: '12.0000 CUSDAC',
            },
            should_pay_via_service_provider: false,
            lockup_release_time_delay: 1233,
            token_supply_theshold: 1000000,
          },
          dacId,
          { from: shared.auth_account }
        ),
        'ERR::UPDATECONFIG_INVALID_INITIAL_TOKEN_THRESHOLD'
      );
    });
    it('Should succeed with valid params', async () => {
      await shared.daccustodian_contract.updateconfige(
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
            quantity: '12.0000 CUSDAC',
          },
          should_pay_via_service_provider: false,
          lockup_release_time_delay: 1233,
          token_supply_theshold: 10000001,
        },
        dacId,
        { from: shared.auth_account }
      );

      const resx = await shared.daccustodian_contract.dacglobalsTable({
        scope: dacId,
        limit: 1,
      });
      await assertRowsEqual(
        shared.daccustodian_contract.dacglobalsTable({
          scope: dacId,
          limit: 1,
        }),
        [
          {
            serial: 1,
            data: [
              {
                key: 'auth_threshold_high',
                value: ['uint8', 4],
              },
              {
                key: 'auth_threshold_low',
                value: ['uint8', 2],
              },
              {
                key: 'auth_threshold_mid',
                value: ['uint8', 3],
              },
              {
                key: 'initial_vote_quorum_percent',
                value: ['uint32', 31],
              },
              {
                key: 'lockup_release_time_delay',
                value: ['uint32', 1233],
              },
              {
                key: 'lockupasset',
                value: [
                  'extended_asset',
                  {
                    quantity: '12.0000 CUSDAC',
                    contract: shared.dac_token_contract.name,
                  },
                ],
              },
              {
                key: 'maxvotes',
                value: ['uint8', 4],
              },
              {
                key: 'numelected',
                value: ['uint8', 5],
              },
              {
                key: 'periodlength',
                value: ['uint32', 5],
              },
              {
                key: 'requested_pay_max',
                value: [
                  'extended_asset',
                  {
                    quantity: '30.0000 EOS',
                    contract: 'eosio.token',
                  },
                ],
              },
              {
                key: 'should_pay_via_service_provider',
                value: ['bool', 0],
              },
              {
                key: 'token_supply_theshold',
                value: ['uint64', 10000001],
              },
              {
                key: 'vote_quorum_percent',
                value: ['uint32', 15],
              },
            ],
          },
        ]
      );
    });
  });

  context('nominatecane', async () => {
    context('With a staking enabled DAC', async () => {
      const dacId = 'nomstakedac';
      let newUser1: Account;

      before(async () => {
        await shared.initDac(dacId, '2,NOMDAC', '1000000.00 NOMDAC');
        await shared.updateconfig(dacId, '12.00 NOMDAC');
        await shared.dac_token_contract.stakeconfig(
          { enabled: true, min_stake_time: 5, max_stake_time: 20 },
          '2,NOMDAC',
          { from: shared.auth_account }
        );
        newUser1 = await debugPromise(
          AccountManager.createAccount(),
          'create account for capture stake'
        );
      });

      context('with unregistered member', async () => {
        it('should fail with error', async () => {
          await assertEOSErrorIncludesMessage(
            shared.daccustodian_contract.nominatecane(
              newUser1.name,
              '25.0000 EOS',
              dacId,
              { from: newUser1 }
            ),
            'ERR::GENERAL_REG_MEMBER_NOT_FOUND'
          );
        });
      });
      context('with registered member', async () => {
        before(async () => {
          await shared.dac_token_contract.memberreg(
            newUser1.name,
            shared.configured_dac_memberterms,
            dacId,
            { from: newUser1 }
          );
        });
        context('with insufficient staked funds', async () => {
          it('should fail with error', async () => {
            await assertEOSErrorIncludesMessage(
              shared.daccustodian_contract.nominatecane(
                newUser1.name,
                '25.0000 EOS',
                dacId,
                { from: newUser1 }
              ),
              'VALIDATEMINSTAKE_NOT_ENOUGH'
            );
          });
        });
        context('wit insufficient staketime', async () => {
          before(async () => {
            await shared.daccustodian_contract.updateconfige(
              {
                numelected: 5,
                maxvotes: 4,
                requested_pay_max: {
                  contract: 'eosio.token',
                  quantity: '25.0000 EOS',
                },
                periodlength: 5,
                initial_vote_quorum_percent: 31,
                vote_quorum_percent: 15,
                auth_threshold_high: 4,
                auth_threshold_mid: 3,
                auth_threshold_low: 2,
                lockupasset: {
                  contract: shared.dac_token_contract.account.name,
                  quantity: '12.00 NOMDAC',
                },
                should_pay_via_service_provider: false,
                lockup_release_time_delay: 259201,
                token_supply_theshold: 10000001,
              },
              dacId,
              { from: shared.auth_account }
            );
            await debugPromise(
              shared.dac_token_contract.transfer(
                shared.tokenIssuer.name,
                newUser1.name,
                '1000.00 NOMDAC',
                '',
                { from: shared.tokenIssuer }
              ),
              'failed to preload the user with enough tokens for staking y'
            );
            await debugPromise(
              shared.dac_token_contract.stake(newUser1.name, '1000.00 NOMDAC', {
                from: newUser1,
              }),
              'failed staking'
            );
          });
          it('should fail with ERR::VALIDATEMINSTAKE_NOT_LONG_ENOUGH', async () => {
            await assertEOSErrorIncludesMessage(
              shared.daccustodian_contract.nominatecane(
                newUser1.name,
                '25.0000 EOS',
                dacId,
                { from: newUser1 }
              ),
              'ERR::VALIDATEMINSTAKE_NOT_LONG_ENOUGH'
            );
          });
          after(async () => {
            await shared.daccustodian_contract.updateconfige(
              {
                numelected: 5,
                maxvotes: 4,
                requested_pay_max: {
                  contract: 'eosio.token',
                  quantity: '25.0000 EOS',
                },
                periodlength: 5,
                initial_vote_quorum_percent: 31,
                vote_quorum_percent: 15,
                auth_threshold_high: 4,
                auth_threshold_mid: 3,
                auth_threshold_low: 2,
                lockupasset: {
                  contract: shared.dac_token_contract.account.name,
                  quantity: '12.00 NOMDAC',
                },
                should_pay_via_service_provider: false,
                lockup_release_time_delay: 5,
                token_supply_theshold: 10000001,
              },
              dacId,
              { from: shared.auth_account }
            );
          });
        });
        context('with sufficient staked funds', async () => {
          before(async () => {
            await debugPromise(
              shared.dac_token_contract.transfer(
                shared.tokenIssuer,
                newUser1.name,
                '12.00 NOMDAC',
                '',
                { from: shared.tokenIssuer }
              ),
              'failed to preload the user with enough tokens for staking x'
            );
            await debugPromise(
              shared.dac_token_contract.stake(newUser1.name, '12.00 NOMDAC', {
                from: newUser1,
              }),
              'failed staking'
            );
          });
          it('should succeed', async () => {
            const result = await shared.daccustodian_contract.dacglobalsTable({
              scope: dacId,
            });
            console.log('serial: ' + result.rows[0].serial);
            await shared.daccustodian_contract.nominatecane(
              newUser1.name,
              '25.0000 EOS',
              dacId,
              { from: newUser1 }
            );
          });
        });
      });
    });
    context('With a staking disabled DAC', async () => {
      let dacId = 'nomnostadac';
      let newUser1: Account;

      before(async () => {
        await shared.initDac(dacId, '0,NOSDAC', '1000000 NOSDAC');
        await shared.updateconfig(dacId, '0 NOSDAC');
        newUser1 = await debugPromise(
          AccountManager.createAccount(),
          'create account for capture stake'
        );
      });

      context('with unregistered member', async () => {
        it('should fail with error', async () => {
          await assertEOSErrorIncludesMessage(
            shared.daccustodian_contract.nominatecane(
              newUser1.name,
              '25.0000 EOS',
              dacId,
              { from: newUser1 }
            ),
            'ERR::GENERAL_REG_MEMBER_NOT_FOUND'
          );
        });
      });
      context('with registered member', async () => {
        before(async () => {
          await shared.dac_token_contract.memberreg(
            newUser1.name,
            shared.configured_dac_memberterms,
            dacId,
            { from: newUser1 }
          );
        });
        it('should succeed', async () => {
          await shared.daccustodian_contract.nominatecane(
            newUser1.name,
            '25.0000 EOS',
            dacId,
            { from: newUser1 }
          );
        });
        it('should fail to unstake', async () => {
          await assertEOSErrorIncludesMessage(
            shared.dac_token_contract.unstake(newUser1.name, '1 NOSDAC', {
              from: newUser1,
            }),
            'ERR::STAKING_NOT_ENABLED'
          );
        });
        it('should fail to unstake zero amount', async () => {
          await assertEOSErrorIncludesMessage(
            shared.dac_token_contract.unstake(newUser1.name, '0 NOSDAC', {
              from: newUser1,
            }),
            'ERR::STAKING_NOT_ENABLED'
          );
        });
      });
    });
  });

  context('avg_vote_time_stamp', async () => {
    let regMembers: Account[];
    let dacId = 'avgdac';
    let cands: Account[];
    before(async () => {
      await shared.initDac(dacId, '4,AVGDAC', '1000000.0000 AVGDAC');
      await shared.updateconfig(dacId, '12.0000 AVGDAC');
      await shared.dac_token_contract.stakeconfig(
        { enabled: true, min_stake_time: 5, max_stake_time: 20 },
        '4,AVGDAC',
        { from: shared.auth_account }
      );
      regMembers = await shared.getRegMembers(dacId, '1000.0000 AVGDAC');
      cands = await shared.getStakeObservedCandidates(dacId, '12.0000 AVGDAC');
    });
    context('with no votes', async () => {
      let currentCandidates: TableRowsResult<DaccustodianCandidate>;
      before(async () => {
        currentCandidates = await shared.daccustodian_contract.candidatesTable({
          scope: dacId,
          limit: 20,
        });
      });
      it('candidates should have 0 for avg_vote_time_stamp', async () => {
        chai
          .expect(currentCandidates.rows.length)
          .to.equal(NUMBER_OF_CANDIDATES);
        for (const cand of currentCandidates.rows) {
          chai.expect(cand).to.include({
            is_active: 1,
            total_vote_power: 0,
            number_voters: 0,
          });
          chai.expect(cand.avg_vote_time_stamp.getTime()).to.equal(0);
        }
      });
    });
    context('After voting', async () => {
      it('only candidates with votes have total_vote_power values 1', async () => {
        await vote_and_check(dacId, regMembers[0], cands[0]);
        await sleep(1000);

        await vote_and_check(dacId, regMembers[0], cands[0]);
        await sleep(1000);

        await vote_and_check(dacId, regMembers[1], cands[0]);
        await sleep(1000);

        await vote_and_check(dacId, regMembers[0], cands[0]);
      });
    });
  });

  context('candidates voting', async () => {
    let regMembers: Account[];
    let dacId = 'canddac';
    let cands: Account[];
    before(async () => {
      await shared.initDac(dacId, '4,CANDAC', '1000000.0000 CANDAC');
      await shared.updateconfig(dacId, '12.0000 CANDAC');
      await shared.dac_token_contract.stakeconfig(
        { enabled: true, min_stake_time: 5, max_stake_time: 20 },
        '4,CANDAC',
        { from: shared.auth_account }
      );
      regMembers = await shared.getRegMembers(dacId, '1000.0000 CANDAC');
      cands = await shared.getStakeObservedCandidates(dacId, '12.0000 CANDAC');
    });
    context('with no votes', async () => {
      let currentCandidates: TableRowsResult<DaccustodianCandidate>;
      before(async () => {
        currentCandidates = await shared.daccustodian_contract.candidatesTable({
          scope: dacId,
          limit: 20,
        });
      });
      it('candidates should have 0 for total_vote_power', async () => {
        chai
          .expect(currentCandidates.rows.length)
          .to.equal(NUMBER_OF_CANDIDATES);
        for (const cand of currentCandidates.rows) {
          chai.expect(cand).to.include({
            is_active: 1,
            total_vote_power: 0,
            number_voters: 0,
          });

          chai.expect(
            cand.requestedpay == '15.0000 EOS' ||
              cand.requestedpay == '20.0000 EOS' ||
              cand.requestedpay == '25.0000 EOS'
          ).to.be.true;
          chai.expect(cand).has.property('candidate_name');
        }
      });
      it('dacglobals should have 0 the total_weight_of_votes', async () => {
        let dacState = await shared.daccustodian_contract.dacglobalsTable({
          scope: dacId,
        });
        const res = dacState.rows[0].data.find(
          (x) => x.key === 'total_weight_of_votes'
        );
        chai.expect(res).to.be.undefined;
      });
    });
    context('After voting', async () => {
      const num_voters = 2;
      context('with first vote', async () => {
        before(async () => {
          // Place votes for even number candidates and leave odd number without votes.
          // Only vote with the first 2 members
          for (const member of regMembers.slice(0, num_voters)) {
            await debugPromise(
              shared.daccustodian_contract.votecust(
                member.name,
                [cands[0].name, cands[2].name],
                dacId,
                { from: member }
              ),
              'voting custodian'
            );
          }
        });
        it('votes table should have rows', async () => {
          const res = await shared.daccustodian_contract.votesTable({
            scope: dacId,
          });
          const rows = res.rows;
          chai
            .expect(rows.map((x) => x.voter))
            .to.deep.equalInAnyOrder(
              regMembers.slice(0, num_voters).map((x) => x.name)
            );

          chai
            .expect(rows[0].candidates)
            .deep.equal([cands[0].name, cands[2].name]);
          chai.expect(rows[0].proxy).to.equal('');
          chai.expect(rows[0].vote_count).to.equal(0);
          expect_recent(rows[0].vote_time_stamp);
          chai
            .expect(rows[1].candidates)
            .deep.equal([cands[0].name, cands[2].name]);
          chai.expect(rows[1].proxy).to.equal('');
          expect_recent(rows[1].vote_time_stamp);
          chai.expect(rows[1].vote_count).to.equal(0);
        });
        it('only candidates with votes have total_vote_power values 2', async () => {
          let unvotedCandidateResult =
            await shared.daccustodian_contract.candidatesTable({
              scope: dacId,
              limit: 1,
              lowerBound: cands[1].name,
            });

          chai
            .expect(unvotedCandidateResult.rows[0].total_vote_power)
            .to.equal(0);
          chai.expect(unvotedCandidateResult.rows[0].number_voters).to.equal(0);
          let votedCandidateResult =
            await shared.daccustodian_contract.candidatesTable({
              scope: dacId,
              limit: 1,
              lowerBound: cands[0].name,
            });

          chai.expect(votedCandidateResult.rows[0]).to.include({
            total_vote_power: 20_000_000,
          });
          chai
            .expect(votedCandidateResult.rows[0].number_voters)
            .to.equal(num_voters);
          await assertRowCount(
            shared.daccustodian_contract.votesTable({
              scope: dacId,
            }),
            num_voters
          );
        });
        it('state should have increased the total_weight_of_votes', async () => {
          const actual = await get_from_dacglobals(
            dacId,
            'total_weight_of_votes'
          );
          chai.expect(actual).to.equal(20_000_000);
        });
        it('state should have increased the total_votes_on_candidates', async () => {
          const actual = await get_from_dacglobals(
            dacId,
            'total_votes_on_candidates'
          );
          chai.expect(actual).to.equal(20_000_000);
        });
      });
      context('After same users voting again', async () => {
        before(async () => {
          // Place votes for even number candidates and leave odd number without votes.
          // Only vote with the first 2 members
          for (const member of regMembers.slice(0, num_voters)) {
            await debugPromise(
              shared.daccustodian_contract.votecust(
                member.name,
                [cands[0].name, cands[2].name],
                dacId,
                { from: member }
              ),
              'voting custodian'
            );
          }
        });
        it('votes table should have rows', async () => {
          const res = await shared.daccustodian_contract.votesTable({
            scope: dacId,
          });
          const rows = res.rows;
          chai
            .expect(rows.map((x) => x.voter))
            .to.deep.equalInAnyOrder(
              regMembers.slice(0, num_voters).map((x) => x.name)
            );

          chai
            .expect(rows[0].candidates)
            .deep.equal([cands[0].name, cands[2].name]);
          chai.expect(rows[0].proxy).to.equal('');
          chai.expect(rows[0].vote_count).to.equal(1);
          expect_recent(rows[0].vote_time_stamp);
          chai
            .expect(rows[1].candidates)
            .deep.equal([cands[0].name, cands[2].name]);
          chai.expect(rows[1].proxy).to.equal('');
          expect_recent(rows[1].vote_time_stamp);

          chai.expect(rows[1].vote_count).to.equal(1);
        });
        it('only candidates with votes have total_vote_power values 3', async () => {
          let unvotedCandidateResult =
            await shared.daccustodian_contract.candidatesTable({
              scope: dacId,
              limit: 1,
              lowerBound: cands[1].name,
            });

          chai
            .expect(unvotedCandidateResult.rows[0].total_vote_power)
            .to.equal(0);
          let votedCandidateResult =
            await shared.daccustodian_contract.candidatesTable({
              scope: dacId,
              limit: 1,
              lowerBound: cands[0].name,
            });

          chai.expect(votedCandidateResult.rows[0]).to.include({
            total_vote_power: 20_000_000,
            number_voters: num_voters,
          });
          await assertRowCount(
            shared.daccustodian_contract.votesTable({
              scope: dacId,
            }),
            num_voters
          );
        });
        it('state should not have increased the total_weight_of_votes', async () => {
          const actual = await get_from_dacglobals(
            dacId,
            'total_weight_of_votes'
          );
          chai.expect(actual).to.equal(20_000_000);
        });
        it('state should not have increased the total_votes_on_candidates', async () => {
          const actual = await get_from_dacglobals(
            dacId,
            'total_votes_on_candidates'
          );
          chai.expect(actual).to.equal(20_000_000);
        });
      });
    });
    context('After additional voting, then removing votes', async () => {
      let newVoter: Account;
      before(async () => {
        newVoter = regMembers[2];
      });
      context('After adding additional vote', async () => {
        before(async () => {
          await debugPromise(
            shared.daccustodian_contract.votecust(
              newVoter.name,
              [cands[0].name, cands[2].name],
              dacId,
              { from: newVoter }
            ),
            'voting custodian'
          );
        });
        it('votes table should have rows', async () => {
          const res = await shared.daccustodian_contract.votesTable({
            scope: dacId,
          });
          const rows = res.rows;
          chai
            .expect(rows.map((x) => x.voter))
            .to.deep.equalInAnyOrder(regMembers.slice(0, 3).map((x) => x.name));
        });

        it('only candidates with votes have total_vote_power values 4', async () => {
          let unvotedCandidateResult =
            await shared.daccustodian_contract.candidatesTable({
              scope: dacId,
              limit: 1,
              lowerBound: cands[1].name,
            });

          chai
            .expect(unvotedCandidateResult.rows[0].total_vote_power)
            .to.equal(0);
          chai.expect(unvotedCandidateResult.rows[0].number_voters).to.equal(0);
          let votedCandidateResult =
            await shared.daccustodian_contract.candidatesTable({
              scope: dacId,
              limit: 1,
              lowerBound: cands[0].name,
            });

          chai.expect(votedCandidateResult.rows[0]).to.include({
            total_vote_power: 30_000_000,
          });
          chai.expect(votedCandidateResult.rows[0].number_voters).to.equal(3);
          await assertRowCount(
            shared.daccustodian_contract.votesTable({
              scope: dacId,
            }),
            3
          );
        });
        it('state should have increased the total_weight_of_votes', async () => {
          const actual = await get_from_dacglobals(
            dacId,
            'total_weight_of_votes'
          );
          chai.expect(actual).to.equal(30_000_000);
        });
        it('state should have increased the total_votes_on_candidates', async () => {
          const actual = await get_from_dacglobals(
            dacId,
            'total_votes_on_candidates'
          );
          chai.expect(actual).to.equal(30_000_000);
        });
      });
      context('After removing additional vote', async () => {
        before(async () => {
          await shared.daccustodian_contract.votecust(
            newVoter.name,
            [],
            dacId,
            { from: newVoter }
          );
        });
        it('votes table should have rows', async () => {
          const res = await shared.daccustodian_contract.votesTable({
            scope: dacId,
          });
          const rows = res.rows;
          chai
            .expect(rows.map((x) => x.voter))
            .to.deep.equalInAnyOrder(regMembers.slice(0, 2).map((x) => x.name));
        });

        it('only candidates with votes have total_vote_power values 5', async () => {
          let unvotedCandidateResult =
            await shared.daccustodian_contract.candidatesTable({
              scope: dacId,
              limit: 1,
              lowerBound: cands[1].name,
            });

          chai
            .expect(unvotedCandidateResult.rows[0].total_vote_power)
            .to.equal(0);
          chai.expect(unvotedCandidateResult.rows[0].number_voters).to.equal(0);
          let votedCandidateResult =
            await shared.daccustodian_contract.candidatesTable({
              scope: dacId,
              limit: 1,
              lowerBound: cands[0].name,
            });

          chai.expect(votedCandidateResult.rows[0]).to.include({
            total_vote_power: 20_000_000,
          });
          chai.expect(votedCandidateResult.rows[0].number_voters).to.equal(2);
          await assertRowCount(
            shared.daccustodian_contract.votesTable({
              scope: dacId,
            }),
            2
          );
        });
        it('state should have increased the total_weight_of_votes', async () => {
          const actual = await get_from_dacglobals(
            dacId,
            'total_weight_of_votes'
          );
          chai.expect(actual).to.equal(20_000_000);
        });
        it('state should have increased the total_votes_on_candidates', async () => {
          const actual = await get_from_dacglobals(
            dacId,
            'total_votes_on_candidates'
          );
          chai.expect(actual).to.equal(20_000_000);
        });
      });
    });
    context('vote values after transfers', async () => {
      let initialNumVoters: number;
      it('assert preconditions for vote values for custodians', async () => {
        let votedCandidateResult =
          await shared.daccustodian_contract.candidatesTable({
            scope: dacId,
            limit: 20,
            lowerBound: cands[0].name,
          });
        let initialVoteValue = votedCandidateResult.rows[0].total_vote_power;
        chai.expect(initialVoteValue).to.equal(20_000_000);
        initialNumVoters = votedCandidateResult.rows[0].number_voters;
        chai.expect(initialNumVoters).to.equal(2);
      });
      it('total vote values on state before transfer', async () => {
        const actual = await get_from_dacglobals(
          dacId,
          'total_weight_of_votes'
        );
        chai.expect(actual).to.equal(20_000_000);
      });
      it('assert preconditions for total vote values on state', async () => {
        const actual = await get_from_dacglobals(
          dacId,
          'total_weight_of_votes'
        );
        chai.expect(actual).to.equal(20_000_000);
      });
      it('after transfer to non-voter values should reduce for candidates and total values but leave number of voters the same', async () => {
        await shared.dac_token_contract.transfer(
          regMembers[1].name,
          regMembers[4].name,
          '300.0000 CANDAC',
          '',
          { from: regMembers[1] }
        );
        let votedCandidateResult =
          await shared.daccustodian_contract.candidatesTable({
            scope: dacId,
            limit: 20,
            lowerBound: cands[0].name,
          });
        let updatedCandVoteValue =
          votedCandidateResult.rows[0].total_vote_power;
        chai.expect(updatedCandVoteValue).to.equal(17_000_000);
        const updatedNumVotersValue =
          votedCandidateResult.rows[0].number_voters;
        chai.expect(updatedNumVotersValue).to.equal(initialNumVoters);
      });
      it('total vote values on state should reduced as well', async () => {
        const actual = await get_from_dacglobals(
          dacId,
          'total_weight_of_votes'
        );
        chai.expect(actual).to.equal(17_000_000);
      });
    });
  });

  context('proxy voting', async () => {
    let regMembers: Account[];
    let dacId = 'proxydac';
    let cands: Account[];
    before(async () => {
      await shared.initDac(dacId, '4,PROXDAC', '1000000.0000 PROXDAC');
      await shared.updateconfig(dacId, '12.0000 PROXDAC');
      await shared.dac_token_contract.stakeconfig(
        { enabled: true, min_stake_time: 5, max_stake_time: 20 },
        '4,PROXDAC',
        { from: shared.auth_account }
      );
      regMembers = await shared.getRegMembers(dacId, '1000.0000 PROXDAC');
      cands = await shared.getStakeObservedCandidates(dacId, '12.0000 PROXDAC');
    });
    context('After voting but before proxy voting', async () => {
      before(async () => {
        // Place votes for even number candidates and leave odd number without votes.
        // Only vote with the first 2 members
        for (const member of regMembers.slice(0, 2)) {
          await debugPromise(
            shared.daccustodian_contract.votecust(
              member.name,
              [cands[0].name, cands[2].name],
              dacId,
              { from: member }
            ),
            'voting custodian'
          );
        }
      });
      it('votes table should have rows', async () => {
        const res = await shared.daccustodian_contract.votesTable({
          scope: dacId,
        });
        const rows = res.rows;
        chai
          .expect(rows.map((x) => x.voter))
          .to.deep.equalInAnyOrder(regMembers.slice(0, 2).map((x) => x.name));

        chai
          .expect(rows[0].candidates)
          .deep.equal([cands[0].name, cands[2].name]);
        chai.expect(rows[0].proxy).to.equal('');
        expect_recent(rows[0].vote_time_stamp);

        chai
          .expect(rows[1].candidates)
          .deep.equal([cands[0].name, cands[2].name]);
        chai.expect(rows[1].proxy).to.equal('');
        expect_recent(rows[1].vote_time_stamp);
      });
      it('only candidates with votes have total_vote_power values 6', async () => {
        let unvotedCandidateResult =
          await shared.daccustodian_contract.candidatesTable({
            scope: dacId,
            limit: 1,
            lowerBound: cands[1].name,
          });
        chai.expect(unvotedCandidateResult.rows[0]).to.include({
          total_vote_power: 0,
          number_voters: 0,
        });
        let votedCandidateResult =
          await shared.daccustodian_contract.candidatesTable({
            scope: dacId,
            limit: 1,
            lowerBound: cands[0].name,
          });
        chai.expect(votedCandidateResult.rows[0]).to.include({
          total_vote_power: 20_000_000,
          number_voters: 2,
        });
        await assertRowCount(
          shared.daccustodian_contract.votesTable({
            scope: dacId,
          }),
          2
        );
      });
      it('state should have increased the total_weight_of_votes', async () => {
        const actual = await get_from_dacglobals(
          dacId,
          'total_weight_of_votes'
        );
        chai.expect(actual).to.equal(20_000_000);
      });
    });
    context('Before registering as a proxy', async () => {
      it('voteproxy should fail with not registered error', async () => {
        await assertEOSErrorIncludesMessage(
          shared.daccustodian_contract.voteproxy(
            regMembers[3].name,
            regMembers[0].name,
            dacId,
            { from: regMembers[3] }
          ),
          'VOTEPROXY_PROXY_NOT_ACTIVE'
        );
      });
    });
    context('Registering as proxy', async () => {
      context('without correct auth', async () => {
        it('should fail with auth error', async () => {
          await assertMissingAuthority(
            shared.daccustodian_contract.regproxy(regMembers[0].name, dacId, {
              from: regMembers[3],
            })
          );
        });
      });
      context('with correct auth', async () => {
        it('should succeed', async () => {
          await shared.daccustodian_contract.regproxy(
            regMembers[0].name,
            dacId,
            {
              from: regMembers[0],
            }
          );
        });
      });
    });
    context('After proxy voting', async () => {
      before(async () => {
        for (const member of regMembers.slice(3, 4)) {
          await debugPromise(
            shared.daccustodian_contract.voteproxy(
              member.name,
              regMembers[0].name,
              dacId,
              { from: member }
            ),
            'voting proxy'
          );
        }
      });
      it('votes table should have rows', async () => {
        let votedCandidateResult =
          await shared.daccustodian_contract.votesTable({
            scope: dacId,
            lowerBound: regMembers[3].name,
            upperBound: regMembers[3].name,
          });
        let proxyVote = votedCandidateResult.rows[0];
        chai.expect(proxyVote.voter).to.equal(regMembers[3].name);
        chai.expect(proxyVote.candidates).to.be.empty;
        chai.expect(proxyVote.proxy).to.equal(regMembers[0].name);
      });
      it('only candidates with votes have total_vote_power values 7', async () => {
        let unvotedCandidateResult =
          await shared.daccustodian_contract.candidatesTable({
            scope: dacId,
            limit: 1,
            lowerBound: cands[1].name,
          });
        chai.expect(unvotedCandidateResult.rows[0]).to.include({
          total_vote_power: 0,
          number_voters: 0,
        });
        let votedCandidateResult =
          await shared.daccustodian_contract.candidatesTable({
            scope: dacId,
            limit: 1,
            lowerBound: cands[0].name,
          });
        chai.expect(votedCandidateResult.rows[0]).to.include({
          total_vote_power: 30_000_000,
          number_voters: 3,
        });
        await assertRowCount(
          shared.daccustodian_contract.votesTable({
            scope: dacId,
          }),
          3
        );
      });
      it('state should have increased the total_weight_of_votes', async () => {
        const actual = await get_from_dacglobals(
          dacId,
          'total_weight_of_votes'
        );
        chai.expect(actual).to.equal(30_000_000);
      });
      context('vote values after transfers', async () => {
        it('assert preconditions for vote values for custodians', async () => {
          let votedCandidateResult =
            await shared.daccustodian_contract.candidatesTable({
              scope: dacId,
              limit: 20,
              lowerBound: cands[0].name,
            });
          let initialVoteValue = votedCandidateResult.rows[0].total_vote_power;
          chai.expect(initialVoteValue).to.equal(30_000_000);
          const initialNumVoters = votedCandidateResult.rows[0].number_voters;
          chai.expect(initialNumVoters).to.equal(3);
        });
        it('assert preconditions for total vote values on state', async () => {
          const actual = await get_from_dacglobals(
            dacId,
            'total_weight_of_votes'
          );
          chai.expect(actual).to.equal(30_000_000);
        });
        it('after transfer to non-voter values should reduce for candidates and total values but keep number of voters the same', async () => {
          await shared.dac_token_contract.transfer(
            regMembers[3].name,
            regMembers[7].name,
            '300.0000 PROXDAC',
            '',
            { from: regMembers[3] }
          );
          let votedCandidateResult =
            await shared.daccustodian_contract.candidatesTable({
              scope: dacId,
              limit: 20,
              lowerBound: cands[0].name,
            });
          let updatedCandVoteValue =
            votedCandidateResult.rows[0].total_vote_power;
          chai.expect(updatedCandVoteValue).to.equal(27_000_000); // should be 27,000,000
          const updatedNumVoters = votedCandidateResult.rows[0].number_voters;
          chai.expect(updatedNumVoters).to.equal(3);
        });
        it('total vote values on state should have changed', async () => {
          const actual = await get_from_dacglobals(
            dacId,
            'total_weight_of_votes'
          );
          chai.expect(actual).to.equal(27_000_000);
        });
      });
      context('after unregproxy', async () => {
        context('with wrong auth', async () => {
          it('should fail', async () => {
            await assertMissingAuthority(
              shared.daccustodian_contract.unregproxy(
                regMembers[0].name,
                dacId,
                { from: regMembers[1] }
              )
            );
          });
        });
        context('with correct auth', async () => {
          it('should succeed', async () => {
            await shared.daccustodian_contract.unregproxy(
              regMembers[0].name,
              dacId,
              { from: regMembers[0] }
            );
          });
        });
      });
      context('with non proxy member', async () => {
        it('should fail', async () => {
          await assertEOSErrorIncludesMessage(
            shared.daccustodian_contract.unregproxy(regMembers[2].name, dacId, {
              from: regMembers[2],
            }),
            'UNREGPROXY_NOT_REGISTERED'
          );
        });
      });
      context(
        'values of votes after unregproxy should be updated.',
        async () => {
          it('should reduce vote weight for existing votes', async () => {
            let votedCandidateResult =
              await shared.daccustodian_contract.candidatesTable({
                scope: dacId,
                limit: 20,
                lowerBound: cands[0].name,
              });
            let updatedCandVoteValue =
              votedCandidateResult.rows[0].total_vote_power;
            chai.expect(updatedCandVoteValue).to.equal(20_000_000);
            const updatedNumVoters = votedCandidateResult.rows[0].number_voters;
            chai.expect(updatedNumVoters).to.equal(3);
          });
          it('total vote values on state should have changed', async () => {
            const actual = await get_from_dacglobals(
              dacId,
              'total_weight_of_votes'
            );
            chai.expect(actual).to.equal(20_000_000);
          });
        }
      );
    });
  });

  context('New Period Elections', async () => {
    let dacId = 'nperidac';
    let regMembers: Account[];
    let newUser1: Account;

    before(async () => {
      await shared.initDac(dacId, '4,PERDAC', '1000000.0000 PERDAC');
      await shared.updateconfig(dacId, '12.0000 PERDAC');
      await shared.dac_token_contract.stakeconfig(
        { enabled: true, min_stake_time: 5, max_stake_time: 20 },
        '4,PERDAC',
        { from: shared.auth_account }
      );
      newUser1 = await debugPromise(
        AccountManager.createAccount(),
        'create account for capture stake'
      );

      // With 16 voting members with 2000 each and a threshold of 31 percent
      // this will total to 320_000 vote value which will be enough to start the DAC
      regMembers = await shared.getRegMembers(dacId, '20000.0000 PERDAC');
    });
    context('without an activation account', async () => {
      context('before a dac has commenced periods', async () => {
        context('without enough INITIAL candidate value voting', async () => {
          it('should fail with voter engagement too low error', async () => {
            await assertEOSErrorIncludesMessage(
              shared.daccustodian_contract.newperiod(
                'initial new period',
                dacId,
                {
                  auths: [
                    {
                      actor: shared.daccustodian_contract.account.name,
                      permission: 'owner',
                    },
                  ],
                }
              ),
              'NEWPERIOD_VOTER_ENGAGEMENT_LOW_ACTIVATE'
            );
          });
        });
        context('with enough INITIAL candidate value voting', async () => {
          let candidates: Account[];
          before(async () => {
            candidates = await shared.getStakeObservedCandidates(
              dacId,
              '12.0000 PERDAC'
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
          context(
            'without enough candidates with > 0 votes to fill the configs',
            async () => {
              it('should fail with not enough candidates error', async () => {
                await assertEOSErrorIncludesMessage(
                  shared.daccustodian_contract.newperiod(
                    'initial new period',
                    dacId,
                    {
                      auths: [
                        {
                          actor: shared.daccustodian_contract.account.name,
                          permission: 'owner',
                        },
                      ],
                    }
                  ),
                  'NEWPERIOD_NOT_ENOUGH_CANDIDATES'
                );
              });
            }
          );
          context('with enough candidates to fill the configs', async () => {
            let candidates: Account[];
            let number_of_custodians = 5;
            before(async () => {
              candidates = await shared.getStakeObservedCandidates(
                dacId,
                '12.0000 PERDAC'
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
                    quantity: '12.0000 PERDAC',
                  },
                  should_pay_via_service_provider: false,
                  lockup_release_time_delay: 1233,
                  token_supply_theshold: 10000001,
                },
                dacId,
                { from: shared.auth_account }
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
                number_of_custodians
              );
            });
            it('Candidates bydecayed index should sort by rank descending', async () => {
              const res = await shared.daccustodian_contract.candidatesTable({
                scope: dacId,
                limit: 100,
                indexPosition: 6, // bydecayed index
                keyType: 'i64',
              });
              const unsorted = res.rows;
              const sorted = _.sortBy(res.rows, (x) => -x.rank);
              chai.expect(unsorted).to.deep.equal(sorted);
            });
            it('Should have highest ranked votes in custodians', async () => {
              let res1 = await shared.daccustodian_contract.candidatesTable({
                scope: dacId,
                limit: 100,
                indexPosition: 6, // bydecayed index
                keyType: 'i64',
              });

              let res2 = await shared.daccustodian_contract.custodiansTable({
                scope: dacId,
                limit: 100,
                indexPosition: 2, // bydecayed index
                keyType: 'i64',
              });

              const candidates = res1.rows.map((x) => {
                return {
                  cust_name: x.candidate_name,
                  requestedpay: x.requestedpay,
                  rank: x.rank,
                  total_vote_power: x.total_vote_power,
                  number_voters: x.number_voters,
                  avg_vote_time_stamp: x.avg_vote_time_stamp,
                };
              });

              console.log(
                'candidates.slice(0, 5): ',
                JSON.stringify(candidates.slice(0, 5), null, 2)
              );
              console.log('res2.rows: ', JSON.stringify(res2.rows, null, 2));
              chai.expect(res2.rows.length).to.equal(5);
              chai.expect(candidates.slice(0, 5)).to.deep.equal(res2.rows);
            });
            it('Custodians should not yet be paid', async () => {
              await assertRowCount(
                shared.daccustodian_contract.pendingpayTable({
                  scope: dacId,
                  limit: 12,
                }),
                0
              );
            });
            it('should set the auths', async () => {
              let account = await debugPromise(
                EOSManager.rpc.get_account(shared.auth_account.name),
                'get account info'
              );
              let permissions = account.permissions.sort(
                (a: { perm_name: string }, b: { perm_name: string }) =>
                  a.perm_name.localeCompare(b.perm_name)
              );

              const custodians =
                await shared.daccustodian_contract.custodiansTable({
                  scope: dacId,
                  limit: 20,
                });
              const expected_accounts = custodians.rows.map((row) => {
                return {
                  permission: {
                    actor: row.cust_name,
                    permission: 'active',
                  },
                  weight: 1,
                };
              });

              let ownerPermission = permissions[0];
              let ownerRequiredAuth = ownerPermission.required_auth;
              chai.expect(ownerPermission.parent).to.eq('owner');
              chai.expect(ownerPermission.perm_name).to.eq('active');
              chai.expect(ownerRequiredAuth.threshold).to.eq(1);
              chai.expect(ownerRequiredAuth.keys.length).to.eq(1);

              let adminPermission = permissions[1];
              let adminRequiredAuth = adminPermission.required_auth;
              chai.expect(adminPermission.parent).to.eq('one');
              chai.expect(adminPermission.perm_name).to.eq('admin');
              chai.expect(adminRequiredAuth.threshold).to.eq(1);
              chai.expect(adminRequiredAuth.accounts).to.deep.equal([
                {
                  permission: {
                    actor: shared.daccustodian_contract.account.name,
                    permission: 'eosio.code',
                  },
                  weight: 1,
                },
              ]);

              let highPermission = permissions[2];
              let highRequiredAuth = highPermission.required_auth;
              chai.expect(highPermission.parent).to.eq('active');
              chai.expect(highPermission.perm_name).to.eq('high');
              chai.expect(highRequiredAuth.threshold).to.eq(4);

              let highAccounts = highRequiredAuth.accounts;
              chai.expect(highAccounts).to.deep.equal(expected_accounts);

              let lowPermission = permissions[3];
              let lowRequiredAuth = lowPermission.required_auth;

              chai.expect(lowPermission.parent).to.eq('med');
              chai.expect(lowPermission.perm_name).to.eq('low');
              chai.expect(lowRequiredAuth.threshold).to.eq(2);

              let lowAccounts = lowRequiredAuth.accounts;
              chai.expect(lowAccounts).to.deep.equal(expected_accounts);

              let medPermission = permissions[4];
              let medRequiredAuth = medPermission.required_auth;

              chai.expect(medPermission.parent).to.eq('high');
              chai.expect(medPermission.perm_name).to.eq('med');
              chai.expect(medRequiredAuth.threshold).to.eq(3);

              let medAccounts = medRequiredAuth.accounts;
              chai.expect(medAccounts).to.deep.equal(expected_accounts);

              let onePermission = account.permissions[5];
              let oneRequiredAuth = onePermission.required_auth;

              chai.expect(onePermission.parent).to.eq('low');
              chai.expect(onePermission.perm_name).to.eq('one');
              chai.expect(oneRequiredAuth.threshold).to.eq(1);
              let oneAccounts = oneRequiredAuth.accounts;
              chai.expect(oneAccounts).to.deep.equal(expected_accounts);
            });
          });
          // it('should succeed setting up testuser', async () => {
          //   await setup_test_user(candidates[0], 'PERDAC');
          // });
        });
      });
    });

    context('with an activation account', async () => {
      before(async () => {
        await shared.dacdirectory_contract.regaccount(
          dacId,
          shared.activation_account.name,
          Account_type.ACTIVATION,
          {
            from: shared.auth_account,
          }
        );
      });
      context('without activation account auth', async () => {
        it('should fail with not authorized error', async () => {
          await assertMissingAuthority(
            shared.daccustodian_contract.newperiod('new period', dacId, {
              from: shared.auth_account,
            })
          );
        });
      });

      after(async () => {
        await shared.dacdirectory_contract.unregaccount(
          dacId,
          Account_type.ACTIVATION,
          {
            from: shared.auth_account,
          }
        );
      });
    });

    context('Calling newperiod before the next period is due', async () => {
      it('should fail with too calling newperiod too early error', async () => {
        await assertEOSErrorIncludesMessage(
          shared.daccustodian_contract.newperiod('initial new period', dacId, {
            from: shared.auth_account, // could be any account to auth this.
          }),
          'ERR::NEWPERIOD_EARLY'
        );
      });
    });
    context(
      'Calling new period after the period time has expired',
      async () => {
        context('but not enough tokens', () => {
          before(async () => {
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
                  quantity: '12.0000 PERDAC',
                },
                should_pay_via_service_provider: false,
                lockup_release_time_delay: 1233,
                token_supply_theshold: 100000000000,
              },
              dacId,
              { from: shared.auth_account }
            );
            // Removing 1000 EOSDAC from each member to get under the initial voting threshold
            // but still above the ongoing voting threshold to check the newperiod still succeeds.
            let transfers = regMembers.map((member) => {
              return shared.dac_token_contract.transfer(
                member.name,
                shared.dac_token_contract.account.name,
                '1000.0000 PERDAC',
                'removing PERDAC',
                { from: member }
              );
            });

            await debugPromise(
              Promise.all(transfers),
              'transferring 1000 PERDAC away for voting threshold'
            );
            await sleep(4_000);
          });
          it('should fail with NEWPERIOD_TOKEN_SUPPLY_TOO_LOW error', async () => {
            await assertEOSErrorIncludesMessage(
              shared.daccustodian_contract.newperiod(
                'initial new period',
                dacId,
                {
                  from: newUser1,
                }
              ),
              'ERR::NEWPERIOD_TOKEN_SUPPLY_TOO_LOW'
            );
          });
          after(async () => {
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
                  quantity: '12.0000 PERDAC',
                },
                should_pay_via_service_provider: false,
                lockup_release_time_delay: 1233,
                token_supply_theshold: 10000001,
              },
              dacId,
              { from: shared.auth_account }
            );
          });
        });
        context('with sufficient tokens', () => {
          before(async () => {
            // Removing 1000 EOSDAC from each member to get under the initial voting threshold
            // but still above the ongoing voting threshold to check the newperiod still succeeds.
            let transfers = regMembers.map((member) => {
              return shared.dac_token_contract.transfer(
                member.name,
                shared.dac_token_contract.account.name,
                '1000.0000 PERDAC',
                'removing PERDAC',
                { from: member }
              );
            });

            await debugPromise(
              Promise.all(transfers),
              'transferring 1000 PERDAC away for voting threshold'
            );
            await sleep(6_000);
          });
          it('should succeed', async () => {
            await shared.daccustodian_contract.newperiod(
              'initial new period',
              dacId,
              {
                from: newUser1,
              }
            );
          });
          it('custodians should have been paid', async () => {
            await assertRowCount(
              shared.daccustodian_contract.pendingpayTable({
                scope: dacId,
                limit: 12,
              }),
              5
            );
          });
          it('custodians should the mean pay from the valid requested pays. (Requested pay exceeding the max pay should be ignored from the mean.)', async () => {
            let custodianRows =
              await shared.daccustodian_contract.custodiansTable({
                scope: dacId,
                limit: 12,
              });
            let pays = custodianRows.rows
              .map((cand) => {
                return Number(cand.requestedpay.split(' ')[0]);
              })
              .filter((val) => {
                return val <= 23; // filter out pays that over 23 because they should be filtered by the requested pay calc.
              });

            let expectedAverage =
              pays.reduce((a, b) => {
                return a + b;
              }) / custodianRows.rows.length;

            let payRows = await shared.daccustodian_contract.pendingpayTable({
              scope: dacId,
              limit: 12,
            });

            let actualPaidAverage = Number(
              payRows.rows[0].quantity.quantity.split(' ')[0]
            );

            chai.expect(actualPaidAverage).to.equal(expectedAverage);
          });
          it("claimpay should fail without receiver's authority", async () => {
            let payRows = await shared.daccustodian_contract.pendingpayTable({
              scope: dacId,
              limit: 1,
            });

            const payId = payRows.rows[0].key;
            await assertMissingAuthority(
              shared.daccustodian_contract.claimpay(payId, dacId)
            );
          });
          it('claimpay should transfer the money', async () => {
            let payRows = await shared.daccustodian_contract.pendingpayTable({
              scope: dacId,
              limit: 12,
            });
            for (const payout of payRows.rows) {
              const payId = payout.key;
              const receiver = payout.receiver;
              const amount = payout.quantity;

              await shared.daccustodian_contract.claimpay(payId, dacId, {
                auths: [
                  {
                    actor: receiver,
                    permission: 'active',
                  },
                ],
              });

              // check if money did indeed arrive
              const results = await EOSManager.rpc.get_table_rows({
                code: amount.contract,
                scope: receiver,
                table: 'accounts',
              });
              chai.expect(results.rows[0].balance).to.equal(amount.quantity);
            }
            // After all payouts are made, the table should be empty
            await assertRowCount(
              shared.daccustodian_contract.pendingpayTable({
                scope: dacId,
                limit: 12,
              }),
              0
            );
          });
        });
      }
    );
  });
  context('Dac with 0 payment for custodians', async () => {
    let dacId = 'zeropaydac';
    let regMembers: Account[];
    let newUser1: Account;
    let candidates: Account[];

    before(async () => {
      await shared.initDac(dacId, '4,ZERODAC', '1000000.0000 ZERODAC');
      await shared.updateconfig(dacId, '12.0000 ZERODAC');
      await shared.dac_token_contract.stakeconfig(
        { enabled: true, min_stake_time: 5, max_stake_time: 20 },
        '4,ZERODAC',
        { from: shared.auth_account }
      );

      // With 16 voting members with 2000 each and a threshold of 31 percent
      // this will total to 320_000 vote value which will be enough to start the DAC
      regMembers = await shared.getRegMembers(dacId, '20000.0000 ZERODAC');
      candidates = await shared.getStakeObservedCandidates(
        dacId,
        '12.0000 ZERODAC'
      );
      await shared.voteForCustodians(regMembers, candidates, dacId);

      await shared.daccustodian_contract.updateconfige(
        {
          numelected: 5,
          maxvotes: 4,
          requested_pay_max: {
            contract: 'eosio.token',
            quantity: '0.0000 EOS',
          },
          periodlength: 5,
          initial_vote_quorum_percent: 31,
          vote_quorum_percent: 15,
          auth_threshold_high: 4,
          auth_threshold_mid: 3,
          auth_threshold_low: 2,
          lockupasset: {
            contract: shared.dac_token_contract.account.name,
            quantity: '12.0000 ZERODAC',
          },
          should_pay_via_service_provider: false,
          lockup_release_time_delay: 1233,
          token_supply_theshold: 10000001,
        },
        dacId,
        { from: shared.auth_account }
      );

      await shared.daccustodian_contract.newperiod(
        'initial new period',
        dacId,
        {
          from: regMembers[0], // Could be run by anyone.
        }
      );
      await sleep(6_000);
    });
    it('newperiod should succeed', async () => {
      await shared.daccustodian_contract.newperiod('second new period', dacId, {
        from: regMembers[0], // Could be run by anyone.
      });
    });
    it('custodians should not have been paid', async () => {
      await assertRowCount(
        shared.daccustodian_contract.pendingpayTable({
          scope: dacId,
          limit: 12,
        }),
        0
      );
    });
  });
  context('resign custodian', () => {
    let dacId = 'resigndac';
    let regMembers: Account[];
    let existing_candidates: Account[];
    before(async () => {
      await shared.initDac(dacId, '4,RESDAC', '1000000.0000 RESDAC');
      await shared.updateconfig(dacId, '12.0000 RESDAC');
      await shared.dac_token_contract.stakeconfig(
        { enabled: true, min_stake_time: 5, max_stake_time: 20 },
        '4,RESDAC',
        { from: shared.auth_account }
      );
      regMembers = await shared.getRegMembers(dacId, '20000.0000 RESDAC');
      existing_candidates = await shared.getStakeObservedCandidates(
        dacId,
        '12.0000 RESDAC'
      );

      await shared.voteForCustodians(regMembers, existing_candidates, dacId);
      await shared.daccustodian_contract.newperiod('resigndac', dacId, {
        from: regMembers[0],
      });
    });
    it('should fail with incorrect auth returning auth error', async () => {
      let electedCandidateToResign = existing_candidates[0];
      await assertMissingAuthority(
        shared.daccustodian_contract.resigncust(
          electedCandidateToResign.name,
          dacId,
          { from: existing_candidates[1] }
        )
      );
    });
    context('with correct auth', async () => {
      context('for a currently elected custodian', async () => {
        context('without enough elected candidates to replace', async () => {
          it('should fail with not enough candidates error', async () => {
            let electedCandidateToResign = existing_candidates[3];
            // The implementation of `voteForCustodians` only votes for enough to
            // satisfy the config that requires 5 candidates be voted for.
            // Therefore the `resigncust` would fail because a replacement candidate is not
            // available until another candiate has been voted for.
            await assertEOSErrorIncludesMessage(
              shared.daccustodian_contract.resigncust(
                electedCandidateToResign.name,
                dacId,
                {
                  auths: [
                    {
                      actor: electedCandidateToResign.name,
                      permission: 'active',
                    },
                    {
                      actor: shared.auth_account.name,
                      permission: 'active',
                    },
                  ],
                }
              ),
              'NEWPERIOD_NOT_ENOUGH_CANDIDATES'
            );
          });
          context(
            'with enough elected candidates to replace a removed candidate',
            async () => {
              let electedCandidateToResign: Account;
              before(async () => {
                electedCandidateToResign = existing_candidates[3];
                await debugPromise(
                  shared.daccustodian_contract.votecust(
                    regMembers[14].name,
                    [
                      existing_candidates[0].name,
                      existing_candidates[1].name,
                      existing_candidates[2].name,
                      existing_candidates[5].name,
                    ],
                    dacId,
                    { from: regMembers[14] }
                  ),
                  'voting for an extra candidate'
                );
              });
              it('should succeed', async () => {
                await shared.daccustodian_contract.resigncust(
                  electedCandidateToResign.name,
                  dacId,
                  {
                    auths: [
                      {
                        actor: electedCandidateToResign.name,
                        permission: 'active',
                      },
                      { actor: shared.auth_account.name, permission: 'active' },
                    ],
                  }
                );
              });
              it('should disable candidate', async () => {
                const res = await shared.daccustodian_contract.candidatesTable({
                  scope: dacId,
                  limit: 20,
                  lowerBound: electedCandidateToResign.name,
                  upperBound: electedCandidateToResign.name,
                });
                chai
                  .expect(res.rows[0].candidate_name)
                  .to.equal(electedCandidateToResign.name);
                chai.expect(res.rows[0].is_active).to.equal(0);
              });
            }
          );
        });
      });
      context('for an unelected candidate', async () => {
        it('should fail with not current custodian error', async () => {
          let unelectedCandidateToResign = existing_candidates[6];
          await assertEOSErrorIncludesMessage(
            shared.daccustodian_contract.resigncust(
              unelectedCandidateToResign.name,
              dacId,
              { from: unelectedCandidateToResign }
            ),
            'ERR::REMOVECUSTODIAN_NOT_CURRENT_CUSTODIAN'
          );
        });
      });
    });
  });
  context('withdraw candidate', () => {
    let dacId = 'withdrawdac';
    let unelectedCandidateToResign: Account;
    let electedCandidateToResign: Account;
    let unregisteredCandidate: Account;

    before(async () => {
      await shared.initDac(dacId, '4,WITHDAC', '1000000.0000 WITHDAC');
      await shared.updateconfig(dacId, '12.0000 WITHDAC');
      await shared.dac_token_contract.stakeconfig(
        { enabled: true, min_stake_time: 5, max_stake_time: 20 },
        '4,WITHDAC',
        { from: shared.auth_account }
      );

      let regMembers = await shared.getRegMembers(dacId, '20000.0000 WITHDAC');
      unregisteredCandidate = regMembers[0];
      let candidates = await shared.getStakeObservedCandidates(
        dacId,
        '12.0000 WITHDAC',
        NUMBER_OF_CANDIDATES + 1
      );
      await shared.voteForCustodians(regMembers, candidates, dacId);
      await shared.daccustodian_contract.newperiod(
        'initial new period',
        dacId,
        {
          from: regMembers[0], // Could be run by anyone.
        }
      );
      electedCandidateToResign = candidates[3];
      unelectedCandidateToResign = candidates[NUMBER_OF_CANDIDATES];
    });
    it('should fail for unregistered candidate with not current candidate error', async () => {
      await assertEOSErrorIncludesMessage(
        shared.daccustodian_contract.withdrawcane(
          unregisteredCandidate.name,
          dacId,
          { from: unregisteredCandidate }
        ),
        'REMOVECANDIDATE_NOT_CURRENT_CANDIDATE'
      );
    });
    it('should fail with incorrect auth returning auth error', async () => {
      await assertMissingAuthority(
        shared.daccustodian_contract.withdrawcane(
          unregisteredCandidate.name,
          dacId,
          { from: unelectedCandidateToResign }
        )
      );
    });
    context('with correct auth', async () => {
      context('for a currently elected custodian', async () => {
        it('before, candidate should be active', async () => {
          let candidates = await shared.daccustodian_contract.candidatesTable({
            scope: dacId,
            limit: 20,
            lowerBound: electedCandidateToResign.name,
            upperBound: electedCandidateToResign.name,
          });
          const cand = candidates.rows[0];
          chai
            .expect(cand.candidate_name)
            .to.equal(electedCandidateToResign.name);
          chai.expect(cand.is_active).to.equal(1);
        });
        it('should succeed', async () => {
          await shared.daccustodian_contract.withdrawcane(
            electedCandidateToResign.name,
            dacId,
            { from: electedCandidateToResign }
          );
        });
        it('should disable candidate', async () => {
          let candidates = await shared.daccustodian_contract.candidatesTable({
            scope: dacId,
            limit: 20,
            lowerBound: electedCandidateToResign.name,
            upperBound: electedCandidateToResign.name,
          });
          const cand = candidates.rows[0];
          chai
            .expect(cand.candidate_name)
            .to.equal(electedCandidateToResign.name);
          chai.expect(cand.is_active).to.equal(0);
        });
      });
      context('for an unelected candidate', async () => {
        it('should succeed', async () => {
          let numberActiveCandidatesBefore = await get_from_dacglobals(
            dacId,
            'number_active_candidates'
          );

          await shared.daccustodian_contract.withdrawcane(
            unelectedCandidateToResign.name,
            dacId,
            { from: unelectedCandidateToResign }
          );
          let candidates = await shared.daccustodian_contract.candidatesTable({
            scope: dacId,
            limit: 20,
            lowerBound: unelectedCandidateToResign.name,
            upperBound: unelectedCandidateToResign.name,
          });

          chai.expect(candidates.rows[0].is_active).to.be.equal(0);

          var numberActiveCandidatesAfter = await get_from_dacglobals(
            dacId,
            'number_active_candidates'
          );
          chai
            .expect(numberActiveCandidatesAfter)
            .to.be.equal(numberActiveCandidatesBefore - 1);
        });
        it('withdrawing the same candidate twice should fail', async () => {
          await assertEOSErrorIncludesMessage(
            shared.daccustodian_contract.withdrawcane(
              unelectedCandidateToResign.name,
              dacId,
              { from: unelectedCandidateToResign }
            ),
            'ERR::REMOVECANDIDATE_CANDIDATE_NOT_ACTIVE'
          );
        });
        it('should allow unstaking without a timelock error', async () => {
          await shared.dac_token_contract.unstake(
            unelectedCandidateToResign.name,
            '12.0000 WITHDAC',
            { from: unelectedCandidateToResign }
          );
        });
      });
    });
  });
  context('removecand', () => {
    let dacId = 'removecdac';
    let unelectedCandidateToResign: Account;
    let electedCandidateToResign: Account;
    let unregisteredCandidate: Account;

    before(async () => {
      await shared.initDac(dacId, '4,REMDAC', '1000000.0000 REMDAC');
      await shared.updateconfig(dacId, '12.0000 REMDAC');
      await shared.dac_token_contract.stakeconfig(
        { enabled: true, min_stake_time: 5, max_stake_time: 20 },
        '4,REMDAC',
        { from: shared.auth_account }
      );

      let regMembers = await shared.getRegMembers(dacId, '20000.0000 REMDAC');
      unregisteredCandidate = regMembers[0];
      let candidates = await shared.getStakeObservedCandidates(
        dacId,
        '12.0000 REMDAC',
        NUMBER_OF_CANDIDATES + 1
      );
      await shared.voteForCustodians(regMembers, candidates, dacId);
      await shared.daccustodian_contract.newperiod(
        'initial new period',
        dacId,
        {
          from: regMembers[0], // Could be run by anyone.
        }
      );
      electedCandidateToResign = candidates[3];
      unelectedCandidateToResign = candidates[NUMBER_OF_CANDIDATES];
    });
    it('should fail for unregistered candidate with not current candidate error', async () => {
      await assertEOSErrorIncludesMessage(
        shared.daccustodian_contract.removecand(
          unregisteredCandidate.name,
          dacId,
          { from: unregisteredCandidate }
        ),
        'REMOVECANDIDATE_NOT_CURRENT_CANDIDATE'
      );
    });
    it('should fail with incorrect auth returning auth error', async () => {
      await assertMissingAuthority(
        shared.daccustodian_contract.removecand(
          unregisteredCandidate.name,
          dacId,
          { from: unelectedCandidateToResign }
        )
      );
    });
    context('with correct auth', async () => {
      context('for a currently elected custodian', async () => {
        it('before, candidate should be active', async () => {
          let candidates = await shared.daccustodian_contract.candidatesTable({
            scope: dacId,
            limit: 20,
            lowerBound: electedCandidateToResign.name,
            upperBound: electedCandidateToResign.name,
          });
          const cand = candidates.rows[0];
          chai
            .expect(cand.candidate_name)
            .to.equal(electedCandidateToResign.name);
          chai.expect(cand.is_active).to.equal(1);
        });
        it('should fail with REMOVECANDIDATE_CANDIDATE_IS_ACTIVE error', async () => {
          await assertEOSErrorIncludesMessage(
            shared.daccustodian_contract.removecand(
              electedCandidateToResign.name,
              dacId,
              { from: electedCandidateToResign }
            ),
            'REMOVECANDIDATE_CANDIDATE_IS_ACTIVE'
          );
        });
        it('after withdrawing, should work', async () => {
          await shared.daccustodian_contract.withdrawcane(
            electedCandidateToResign.name,
            dacId,
            { from: electedCandidateToResign }
          );
          await shared.daccustodian_contract.removecand(
            electedCandidateToResign.name,
            dacId,
            { from: electedCandidateToResign }
          );
        });
        it('should remove candidate table entry', async () => {
          let candidates = await shared.daccustodian_contract.candidatesTable({
            scope: dacId,
            limit: 20,
            lowerBound: electedCandidateToResign.name,
            upperBound: electedCandidateToResign.name,
          });
          chai.expect(candidates.rows).to.be.empty;
        });
      });
      context('for an unelected candidate', async () => {
        before(async () => {
          await shared.daccustodian_contract.withdrawcane(
            unelectedCandidateToResign.name,
            dacId,
            { from: unelectedCandidateToResign }
          );
        });
        it('should succeed and not change the number of active candidates', async () => {
          let numberActiveCandidatesBefore = await get_from_dacglobals(
            dacId,
            'number_active_candidates'
          );

          await shared.daccustodian_contract.removecand(
            unelectedCandidateToResign.name,
            dacId,
            { from: unelectedCandidateToResign }
          );
          let candidates = await shared.daccustodian_contract.candidatesTable({
            scope: dacId,
            limit: 20,
            lowerBound: unelectedCandidateToResign.name,
            upperBound: unelectedCandidateToResign.name,
          });

          chai.expect(candidates.rows).to.be.empty;

          var numberActiveCandidatesAfter = await get_from_dacglobals(
            dacId,
            'number_active_candidates'
          );
          chai
            .expect(numberActiveCandidatesAfter)
            .to.be.equal(numberActiveCandidatesBefore);
        });
        it('removing the same candidate twice should fail', async () => {
          await assertEOSErrorIncludesMessage(
            shared.daccustodian_contract.removecand(
              unelectedCandidateToResign.name,
              dacId,
              { from: unelectedCandidateToResign }
            ),
            'ERR::REMOVECANDIDATE_NOT_CURRENT_CANDIDATE'
          );
        });
      });
    });
  });
  context('fire candidate', () => {
    let dacId = 'firedac';
    let unelectedCandidateToFire: Account;
    let electedCandidateToFire: Account;
    let unregisteredCandidate: Account;

    before(async () => {
      await shared.initDac(dacId, '4,FCANDAC', '1000000.0000 FCANDAC');
      await shared.updateconfig(dacId, '12.0000 FCANDAC');
      await shared.dac_token_contract.stakeconfig(
        { enabled: true, min_stake_time: 5, max_stake_time: 20 },
        '4,FCANDAC',
        { from: shared.auth_account }
      );

      unregisteredCandidate = await shared
        .getRegMembers(dacId, '12.0000 FCANDAC')
        .then((accounts) => {
          return accounts[1];
        });

      electedCandidateToFire = await shared
        .getStakeObservedCandidates(dacId, '12.0000 FCANDAC')
        .then((accounts) => {
          return accounts[0];
        });

      unelectedCandidateToFire = await shared
        .getStakeObservedCandidates(dacId, '12.0000 FCANDAC')
        .then((accounts) => {
          return accounts[0];
        });
    });
    it('should fail for unregistered candidate with not current candidate error', async () => {
      await assertEOSErrorIncludesMessage(
        shared.daccustodian_contract.firecand(
          unregisteredCandidate.name,
          true,
          dacId,
          { from: shared.auth_account }
        ),
        'REMOVECANDIDATE_NOT_CURRENT_CANDIDATE'
      );
    });
    it('should fail with incorrect auth returning auth error', async () => {
      await assertMissingAuthority(
        shared.daccustodian_contract.firecand(
          unregisteredCandidate.name,
          true,
          dacId,
          { from: electedCandidateToFire }
        )
      );
    });
    context('with correct auth', async () => {
      context('for a currently elected custodian', async () => {
        it('should succeed with lockup of stake active from previous election', async () => {
          await shared.daccustodian_contract.firecand(
            electedCandidateToFire.name,
            true,
            dacId,
            { from: shared.auth_account }
          );
        });

        it('should delete candidate table entries', async () => {
          let candidates = await shared.daccustodian_contract.candidatesTable({
            scope: dacId,
            limit: 20,
            lowerBound: electedCandidateToFire.name,
            upperBound: electedCandidateToFire.name,
          });
          chai.expect(candidates.rows).to.be.empty;
        });
      });
      context('for an unelected candidate', async () => {
        it('should succeed', async () => {
          var numberActiveCandidatesBefore = await get_from_dacglobals(
            dacId,
            'number_active_candidates'
          );

          await shared.daccustodian_contract.firecand(
            unelectedCandidateToFire.name,
            true,
            dacId,
            { from: shared.auth_account }
          );
          let candidates = await shared.daccustodian_contract.candidatesTable({
            scope: dacId,
            limit: 20,
            lowerBound: unelectedCandidateToFire.name,
            upperBound: unelectedCandidateToFire.name,
          });

          chai.expect(candidates.rows).to.be.empty;

          var numberActiveCandidatesAfter = await get_from_dacglobals(
            dacId,
            'number_active_candidates'
          );
          chai
            .expect(numberActiveCandidatesAfter)
            .to.be.equal(numberActiveCandidatesBefore - 1);
        });
      });
    });
  });
  context('fire custodian', () => {
    let dacId = 'firecustdac';

    let unelectedCandidateToFire: Account;
    let electedCandidateToFire: Account;
    let unregisteredCandidate: Account;
    let regMembers: Account[];
    let candidates: Account[];

    before(async () => {
      await shared.initDac(dacId, '4,CUSTDAC', '1000000.0000 CUSTDAC');
      await shared.updateconfig(dacId, '12.0000 CUSTDAC');
      await shared.dac_token_contract.stakeconfig(
        { enabled: true, min_stake_time: 5, max_stake_time: 20 },
        '4,CUSTDAC',
        { from: shared.auth_account }
      );
      regMembers = await shared.getRegMembers(dacId, '20000.0000 CUSTDAC');
      unregisteredCandidate = regMembers[0];
      candidates = await shared.getStakeObservedCandidates(
        dacId,
        '12.0000 CUSTDAC',
        NUMBER_OF_CANDIDATES + 1
      );
      await shared.voteForCustodians(regMembers, candidates, dacId);
      await shared.daccustodian_contract.newperiod(
        'initial new period',
        dacId,
        {
          from: regMembers[0], // Could be run by anyone.
        }
      );

      electedCandidateToFire = candidates[3];
      unelectedCandidateToFire = candidates[NUMBER_OF_CANDIDATES];
    });
    it('should fail with incorrect auth returning auth error', async () => {
      await assertMissingAuthority(
        shared.daccustodian_contract.firecust(
          unelectedCandidateToFire.name,
          dacId,
          { from: electedCandidateToFire }
        )
      );
    });
    context('with correct auth', async () => {
      context('for a currently elected custodian', async () => {
        before(async () => {
          // vote for another candidate to allow enough for replacement after firing
          await debugPromise(
            shared.daccustodian_contract.votecust(
              regMembers[14].name,
              [
                candidates[0].name,
                candidates[1].name,
                candidates[2].name,
                candidates[5].name,
              ],
              dacId,
              { from: regMembers[14] }
            ),
            'voting for an extra candidate'
          );
        });
        it('should succeed', async () => {
          await shared.daccustodian_contract.firecust(
            electedCandidateToFire.name,
            dacId,
            { from: shared.auth_account }
          );
          let candidates = await shared.daccustodian_contract.candidatesTable({
            scope: dacId,
            limit: 20,
            lowerBound: electedCandidateToFire.name,
            upperBound: electedCandidateToFire.name,
          });
        });
        it('should delete custodian table entry', async () => {
          const res = await shared.daccustodian_contract.custodiansTable({
            scope: dacId,
            limit: 20,
            lowerBound: electedCandidateToFire.name,
            upperBound: electedCandidateToFire.name,
          });
          chai.expect(res.rows).to.be.empty;
        });
        it('should delete candidate table entry', async () => {
          let candidates = await shared.daccustodian_contract.candidatesTable({
            scope: dacId,
            limit: 20,
            lowerBound: electedCandidateToFire.name,
            upperBound: electedCandidateToFire.name,
          });
          chai.expect(candidates.rows).to.be.empty;
        });
      });
      context('for an unelected candidate', async () => {
        it('should fail with not current custodian error', async () => {
          await assertEOSErrorIncludesMessage(
            shared.daccustodian_contract.firecust(
              unelectedCandidateToFire.name,
              dacId,
              { from: shared.auth_account }
            ),
            'ERR::REMOVECUSTODIAN_NOT_CURRENT_CUSTODIAN'
          );
        });
      });
    });
  });
  context('stakeobsv', async () => {
    let dacId = 'stakeobsdac';
    let lockedCandidateToUnstake: Account;

    before(async () => {
      await shared.initDac(dacId, '4,OBSDAC', '1000000.0000 OBSDAC');
      await shared.updateconfig(dacId, '12.0000 OBSDAC');
      await shared.dac_token_contract.stakeconfig(
        { enabled: true, min_stake_time: 5, max_stake_time: 20 },
        '4,OBSDAC',
        { from: shared.auth_account }
      );
      let regMembers = await shared.getRegMembers(dacId, '20000.0000 OBSDAC');
      let candidates = await shared.getStakeObservedCandidates(
        dacId,
        '12.0000 OBSDAC'
      );
      lockedCandidateToUnstake = candidates[3];
      await shared.voteForCustodians(regMembers, candidates, dacId);
      await shared.daccustodian_contract.newperiod(
        'initial new period',
        dacId,
        {
          from: regMembers[0], // Could be run by anyone.
        }
      );
      await shared.updateconfig(dacId, '14.0000 OBSDAC');
    });
    context(
      'with candidate in a registered candidate locked time',
      async () => {
        context('with less than the locked up quantity staked', async () => {
          it('should fail to unstake', async () => {
            await assertEOSErrorIncludesMessage(
              shared.dac_token_contract.unstake(
                lockedCandidateToUnstake.name,
                '10.0000 OBSDAC',
                { from: lockedCandidateToUnstake }
              ),
              'CANNOT_UNSTAKE'
            );
          });
        });
      }
    );
  });
  context('appoint custodian', async () => {
    let dacId = 'appointdac';
    let otherAccount: Account;
    let accountsToRegister: Account[];
    before(async () => {
      await shared.initDac(dacId, '4,APPDAC', '1000000.0000 APPDAC');
      await shared.updateconfig(dacId, '12.0000 APPDAC');
      await shared.dac_token_contract.stakeconfig(
        { enabled: true, min_stake_time: 5, max_stake_time: 20 },
        '4,APPDAC',
        { from: shared.auth_account }
      );

      otherAccount = await AccountManager.createAccount();
      accountsToRegister = await AccountManager.createAccounts(5);
      await sleep(600);
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
              quantity: '12.0000 APPDAC',
            },
            should_pay_via_service_provider: false,
            lockup_release_time_delay: 1233,
            token_supply_theshold: 10000001,
          },
          dacId,
          { from: shared.auth_account }
        ),
        'successfully updated configs for appointdac',
        'failed to update configs for appointdac'
      );
    });
    it('should fail without correct auth', async () => {
      await assertMissingAuthority(
        shared.daccustodian_contract.appointcust(
          accountsToRegister.map((account) => {
            return account.name;
          }),
          dacId,
          { from: otherAccount }
        )
      );
    });
    it('should succeed with correct auth', async () => {
      await shared.daccustodian_contract.appointcust(
        accountsToRegister.map((account) => {
          return account.name;
        }),
        dacId,
        { from: shared.auth_account }
      );
      let candidates = await shared.daccustodian_contract.candidatesTable({
        scope: dacId,
        limit: 20,
      });
      chai.expect(candidates.rows.length).equals(5);

      chai.expect(candidates.rows[0].requestedpay).to.equal('0.0000 EOS');
      chai.expect(candidates.rows[0].rank).to.equal(0);
      chai.expect(candidates.rows[0].number_voters).to.equal(0);
      chai.expect(candidates.rows[0].is_active).to.equal(1);

      let custodians = await shared.daccustodian_contract.custodiansTable({
        scope: dacId,
        limit: 20,
      });
      chai.expect(custodians.rows.length).equals(5);

      chai.expect(custodians.rows[0].requestedpay).to.equal('0.0000 EOS');
      chai.expect(custodians.rows[0].rank).to.equal(0);
    });
    it('should fail with existing custodians appointed', async () => {
      await assertEOSErrorIncludesMessage(
        shared.daccustodian_contract.appointcust(
          accountsToRegister.map((account) => {
            return account.name;
          }),
          dacId,
          { from: shared.auth_account }
        ),
        'ERR:CUSTODIANS_NOT_EMPTY'
      );
    });
  });
  context('period budget', async () => {
    let dacId = 'budgetdac';
    let regMembers: Account[];
    let newUser1: Account;
    let candidates: Account[];
    let tlm_token_contract: Account;

    before(async () => {
      await shared.initDac(dacId, '4,PERIDAC', '1000000.0000 PERIDAC');
      await shared.updateconfig(dacId, '12.0000 PERIDAC');
      await shared.dac_token_contract.stakeconfig(
        { enabled: true, min_stake_time: 5, max_stake_time: 20 },
        '4,PERIDAC',
        { from: shared.auth_account }
      );

      // With 16 voting members with 2000 each and a threshold of 31 percent
      // this will total to 320_000 vote value which will be enough to start the DAC
      regMembers = await shared.getRegMembers(dacId, '20000.0000 PERIDAC');
      candidates = await shared.getStakeObservedCandidates(
        dacId,
        '12.0000 PERIDAC'
      );
      await shared.voteForCustodians(regMembers, candidates, dacId);

      await shared.daccustodian_contract.updateconfige(
        {
          numelected: 5,
          maxvotes: 4,
          requested_pay_max: {
            contract: 'eosio.token',
            quantity: '0.0000 EOS',
          },
          periodlength: 1,
          initial_vote_quorum_percent: 31,
          vote_quorum_percent: 15,
          auth_threshold_high: 4,
          auth_threshold_mid: 3,
          auth_threshold_low: 2,
          lockupasset: {
            contract: shared.dac_token_contract.account.name,
            quantity: '12.0000 PERIDAC',
          },
          should_pay_via_service_provider: false,
          lockup_release_time_delay: 1233,
          token_supply_theshold: 10000001,
        },
        dacId,
        { from: shared.auth_account }
      );
    });
    context('without proper auth', async () => {
      it('claimbudget should fail with auth error', async () => {
        await assertMissingAuthority(
          shared.daccustodian_contract.claimbudget(dacId, { from: somebody })
        );
      });
    });
    context('with no budget NFTs', async () => {
      before(async () => {
        await shared.daccustodian_contract.newperiod(
          'initial new period',
          dacId,
          {
            from: regMembers[0],
          }
        );
        await sleep(1000);
      });
      it('claimbudget should fail', async () => {
        await assertEOSErrorIncludesMessage(
          shared.daccustodian_contract.claimbudget(dacId, {
            from: shared.auth_account,
          }),
          'Dac with ID budgetdac does not own any budget NFTs'
        );
      });
    });
    context('after initial logmint', async () => {
      before(async () => {
        await setup_nfts();
      });
      it('nftcache table should contain our NFT', async () => {
        const res = await shared.dacdirectory_contract.nftcacheTable({
          scope: dacId,
        });
        const rows = res.rows;
        chai.expect(rows[0].schema_name).to.equal(BUDGET_SCHEMA);
        chai.expect(rows[0].value).to.equal(400);
        chai.expect(rows[1].schema_name).to.equal(BUDGET_SCHEMA);
        chai.expect(rows[1].value).to.equal(500);
        chai.expect(rows[2].schema_name).to.equal(BUDGET_SCHEMA);
        chai.expect(rows[2].value).to.equal(300);
      });
    });
    context('when newperiod is called without claimbudget', async () => {
      before(async () => {
        await shared.eosio_token_contract.transfer(
          shared.tokenIssuer.name,
          shared.treasury_account.name,
          `50.0000 TLM`,
          'Some money for the treasury',
          { from: shared.tokenIssuer }
        );
        await shared.eosio_token_contract.transfer(
          shared.tokenIssuer.name,
          shared.auth_account.name,
          `100.0000 TLM`,
          'Some money for the authority',
          { from: shared.tokenIssuer }
        );

        await shared.daccustodian_contract.newperiod(
          'initial new period',
          dacId,
          {
            from: regMembers[0],
          }
        );
        await sleep(1000);
      });
      it('should not transfer budget', async () => {
        await assertBalanceEqual(
          shared.eosio_token_contract.accountsTable({
            scope: shared.treasury_account.name,
          }),
          '50.0000 TLM'
        );
        await assertBalanceEqual(
          shared.eosio_token_contract.accountsTable({
            scope: shared.auth_account.name,
          }),
          '100.0000 TLM'
        );
      });
    });
    context(
      'claimbudget when transfer amount is bigger than treasury',
      async () => {
        let expected_transfer_amount;
        let treasury_balance_before;
        let auth_balance_before;
        before(async () => {
          expected_transfer_amount = await expected_budget_transfer_amount(
            dacId,
            false
          );

          treasury_balance_before = await get_balance(
            shared.eosio_token_contract,
            shared.treasury_account,
            'TLM'
          );
          auth_balance_before = await get_balance(
            shared.eosio_token_contract,
            shared.auth_account,
            'TLM'
          );
          await shared.daccustodian_contract.claimbudget(dacId, {
            from: shared.auth_account,
          });
        });
        it('should only transfer treasury balance', async () => {
          const expected_treasury_balance_after =
            treasury_balance_before - expected_transfer_amount;
          const expected_auth_balance_after =
            auth_balance_before + expected_transfer_amount;

          const actual_treasury_balance = await get_balance(
            shared.eosio_token_contract,
            shared.treasury_account,
            'TLM'
          );
          const actual_auth_balance = await get_balance(
            shared.eosio_token_contract,
            shared.auth_account,
            'TLM'
          );
          chai
            .expect(actual_treasury_balance)
            .to.equal(expected_treasury_balance_after);
          chai
            .expect(actual_auth_balance)
            .to.equal(expected_auth_balance_after);
        });
        it('should update lastclaimbudgettime', async () => {
          const lastclaimbudgettime = await get_from_dacglobals(
            dacId,
            'lastclaimbudgettime'
          );
          chai
            .expect(dayjs.utc().unix() - dayjs.utc(lastclaimbudgettime).unix())
            .to.be.below(5);
        });
      }
    );
    context('calling claimbudget twice in the same period', async () =>
      it('should fail', async () => {
        await assertEOSErrorIncludesMessage(
          shared.daccustodian_contract.claimbudget(dacId, {
            from: shared.auth_account,
          }),
          'Claimbudget can only be called once per period'
        );
      })
    );
    context(
      'claimbudget when transfer amount smaller than treasury',
      async () => {
        let expected_transfer_amount;
        let treasury_balance_before;
        let auth_balance_before;
        before(async () => {
          await shared.eosio_token_contract.transfer(
            shared.tokenIssuer.name,
            shared.treasury_account.name,
            `1500.0000 TLM`,
            'Some money for the treasury',
            { from: shared.tokenIssuer }
          );
          await shared.daccustodian_contract.newperiod(
            'initial new period',
            dacId,
            {
              from: regMembers[0],
            }
          );

          treasury_balance_before = await get_balance(
            shared.eosio_token_contract,
            shared.treasury_account,
            'TLM'
          );
          auth_balance_before = await get_balance(
            shared.eosio_token_contract,
            shared.auth_account,
            'TLM'
          );
          expected_transfer_amount = await expected_budget_transfer_amount(
            dacId,
            false
          );
          await shared.daccustodian_contract.claimbudget(dacId, {
            from: shared.auth_account,
          });
        });
        it('should transfer amount according to formula', async () => {
          const expected_treasury_balance_after =
            treasury_balance_before - expected_transfer_amount;
          const expected_auth_balance_after =
            auth_balance_before + expected_transfer_amount;

          const actual_treasury_balance = await get_balance(
            shared.eosio_token_contract,
            shared.treasury_account,
            'TLM'
          );
          const actual_auth_balance = await get_balance(
            shared.eosio_token_contract,
            shared.auth_account,
            'TLM'
          );
          chai
            .expect(actual_treasury_balance)
            .to.equal(expected_treasury_balance_after);
          chai
            .expect(actual_auth_balance)
            .to.equal(expected_auth_balance_after);
        });
      }
    );
    context('setbudget', async () => {
      it('without self auth, should throw authentication error', async () => {
        await assertMissingAuthority(
          shared.daccustodian_contract.setbudget(dacId, 123, { from: somebody })
        );
      });
      it('should work', async () => {
        await shared.daccustodian_contract.setbudget(dacId, 123);
      });
      it('should set table entry', async () => {
        const budget_percentage = await get_from_dacglobals(
          dacId,
          'budget_percentage'
        );
        chai.expect(budget_percentage).to.equal(123);
      });
      it('setting again', async () => {
        await shared.daccustodian_contract.setbudget(dacId, 234);
      });
      it('should update existing table entry', async () => {
        const budget_percentage = await get_from_dacglobals(
          dacId,
          'budget_percentage'
        );
        chai.expect(budget_percentage).to.equal(234);
      });
      it('setting with different dac id should work', async () => {
        await shared.daccustodian_contract.setbudget('abcd', 345);
      });
      it('should create table entry', async () => {
        const budget_percentage = await get_from_dacglobals(
          'abcd',
          'budget_percentage'
        );
        chai.expect(budget_percentage).to.equal(345);
      });
      it("other dac's table entry should stay untouched", async () => {
        const budget_percentage = await get_from_dacglobals(
          dacId,
          'budget_percentage'
        );
        chai.expect(budget_percentage).to.equal(234);
      });
    });
    context('unsetbudget', async () => {
      it('without self auth, should throw authentication error', async () => {
        await assertMissingAuthority(
          shared.daccustodian_contract.unsetbudget(dacId, {
            from: somebody,
          })
        );
      });
      it('with non-existing dac id, should throw not exists error', async () => {
        await assertEOSErrorIncludesMessage(
          shared.daccustodian_contract.unsetbudget('notexist'),
          'Cannot unset budget_percentage, no value set'
        );
      });
      it('with existing dac id should work', async () => {
        await shared.daccustodian_contract.unsetbudget('abcd');
      });
      it('should remove table entry', async () => {
        const budget_percentage = await get_from_dacglobals(
          'abcd',
          'budget_percentage'
        );
        chai.expect(budget_percentage).to.be.undefined;
      });
      it('should should not delete anything else', async () => {
        const budget_percentage = await get_from_dacglobals(
          dacId,
          'budget_percentage'
        );
        chai.expect(budget_percentage).to.equal(234);
      });
    });
    context('claimbudget when budget percentage is set manually', async () => {
      let expected_transfer_amount;
      let treasury_balance_before;
      let auth_balance_before;
      before(async () => {
        await shared.daccustodian_contract.newperiod(
          'initial new period',
          dacId,
          {
            from: regMembers[0],
          }
        );

        await shared.daccustodian_contract.setbudget(dacId, 235); // 2.35 %

        treasury_balance_before = await get_balance(
          shared.eosio_token_contract,
          shared.treasury_account,
          'TLM'
        );
        auth_balance_before = await get_balance(
          shared.eosio_token_contract,
          shared.auth_account,
          'TLM'
        );
        expected_transfer_amount = await expected_budget_transfer_amount(
          dacId,
          true
        );
        await shared.daccustodian_contract.claimbudget(dacId, {
          from: shared.auth_account,
        });
      });
      it('should transfer amount according to formula', async () => {
        const expected_treasury_balance_after = round_to_decimals(
          treasury_balance_before - expected_transfer_amount,
          4
        );
        const expected_auth_balance_after = round_to_decimals(
          auth_balance_before + expected_transfer_amount,
          4
        );

        const actual_treasury_balance = await get_balance(
          shared.eosio_token_contract,
          shared.treasury_account,
          'TLM'
        );
        const actual_auth_balance = await get_balance(
          shared.eosio_token_contract,
          shared.auth_account,
          'TLM'
        );
        chai
          .expect(actual_treasury_balance)
          .to.equal(expected_treasury_balance_after);
        chai.expect(actual_auth_balance).to.equal(expected_auth_balance_after);
      });
    });
    context('logtransfer', async () => {
      it('should update nftcache table when transfering away', async () => {
        const res = await shared.dacdirectory_contract.nftcacheTable({
          scope: dacId,
          index_position: 2,
          lower_bound: shared.auth_account.name,
          upper_bound: shared.auth_account.name,
        });
        const nft_ids = res.rows.map((x) => x.nft_id);
        second_nft_id = nft_ids[1];
        await shared.atomicassets.transfer(
          shared.auth_account.name,
          'eosio',
          nft_ids,
          'move out of the way',
          { from: shared.auth_account }
        );
        await assertRowsEqual(
          shared.dacdirectory_contract.nftcacheTable({
            scope: dacId,
          }),
          []
        );
      });
      it('should update nftcache table when depositing', async () => {
        await shared.atomicassets.transfer(
          'eosio',
          shared.auth_account.name,
          [second_nft_id],
          'deposit nft',
          { from: new Account('eosio') }
        );
        const res = await shared.dacdirectory_contract.nftcacheTable({
          scope: dacId,
        });
        const rows = res.rows;
        chai.expect(rows[0].schema_name).to.equal(BUDGET_SCHEMA);
        chai.expect(rows[0].value).to.equal(500);
      });
    });
    context('index', async () => {
      it('should sort correctly', async () => {
        await shared.dacdirectory_contract.indextest();
      });
    });
    context('migraterank', async () => {
      const dacId = 'nperidac';
      let table_before;
      before(async () => {
        let res = await shared.daccustodian_contract.candidatesTable({
          scope: dacId,
        });
        table_before = res.rows;
        await shared.daccustodian_contract.clearrank(dacId);
        res = await shared.daccustodian_contract.candidatesTable({
          scope: dacId,
        });
        for (const row of res.rows) {
          chai.expect(row.rank).to.equal(314159);
        }
      });
      it('migraterank should work', async () => {
        await shared.daccustodian_contract.migraterank(dacId);
      });
      it('should update rank index', async () => {
        await assertRowsEqual(
          shared.daccustodian_contract.candidatesTable({
            scope: dacId,
          }),
          table_before
        );
      });
    });
  });
});

/* Use a fresh instance to prevent caching of results */
function get_atomic() {
  const { RpcApi } = require('atomicassets');
  const fetch = require('node-fetch');

  return new RpcApi('http://localhost:8888', 'atomicassets', {
    fetch,
  });
}

async function getTemplateId(schema_name: string, name: string) {
  const atomic = get_atomic();
  const templates = await atomic.getCollectionTemplates(NFT_COLLECTION);
  const objects = await Promise.all(templates.map((x) => x.toObject()));
  return parseInt(
    objects.find((x) => {
      return (
        x.schema.schema_name == schema_name && x.immutableData.name == name
      );
    }).template_id,
    10
  );
}
async function setup_nfts() {
  const atomic = get_atomic();
  try {
    const collection = await atomic.getCollection(NFT_COLLECTION);
    await shared.atomicassets.addnotifyacc(
      NFT_COLLECTION,
      shared.dacdirectory_contract.name,
      { from: shared.eosio_token_contract.account }
    );
  } catch (e) {
    if (!String(e).includes('Error: Row not found for')) {
      // raise unknown errors
      throw e;
    }
    await shared.atomicassets.createcol(
      shared.eosio_token_contract.account.name,
      NFT_COLLECTION,
      true,
      [
        shared.eosio_token_contract.account.name,
        shared.daccustodian_contract.name,
      ],
      [shared.dacdirectory_contract.name],
      '0.01',
      '',
      { from: shared.eosio_token_contract.account }
    );
  }

  await shared.atomicassets.createschema(
    shared.eosio_token_contract.account.name,
    NFT_COLLECTION,
    BUDGET_SCHEMA,
    [
      { name: 'cardid', type: 'uint16' },
      { name: 'name', type: 'string' },
      { name: 'percentage', type: 'uint16' },
    ],
    { from: shared.eosio_token_contract.account }
  );

  await shared.atomicassets.createtempl(
    shared.eosio_token_contract.account.name,
    NFT_COLLECTION,
    BUDGET_SCHEMA,
    true,
    true,
    100,
    [{ key: 'name', value: ['string', 'budget_nft'] }],
    { from: shared.eosio_token_contract.account }
  );

  const template_id = await getTemplateId(BUDGET_SCHEMA, 'budget_nft');

  await shared.atomicassets.mintasset(
    shared.eosio_token_contract.account.name,
    NFT_COLLECTION,
    BUDGET_SCHEMA,
    template_id,
    shared.auth_account.name,
    [
      { key: 'cardid', value: ['uint16', 1] },
      { key: 'name', value: ['string', 'xxx'] },
      { key: 'percentage', value: ['uint16', 400] }, // 4%
    ] as any,
    [],
    [],
    { from: shared.eosio_token_contract.account }
  );

  await shared.atomicassets.mintasset(
    shared.eosio_token_contract.account.name,
    NFT_COLLECTION,
    BUDGET_SCHEMA,
    template_id,
    shared.auth_account.name,
    [
      { key: 'cardid', value: ['uint16', 1] },
      { key: 'name', value: ['string', 'xxx'] },
      { key: 'percentage', value: ['uint16', 500] }, // 5%
    ] as any,
    '',
    [],
    { from: shared.eosio_token_contract.account }
  );
  await shared.atomicassets.mintasset(
    shared.eosio_token_contract.account.name,
    NFT_COLLECTION,
    BUDGET_SCHEMA,
    template_id,
    shared.auth_account.name,
    [
      { key: 'cardid', value: ['uint16', 1] },
      { key: 'name', value: ['string', 'xxx'] },
      { key: 'percentage', value: ['uint16', 300] }, // 3%
    ] as any,
    '',
    [],
    { from: shared.eosio_token_contract.account }
  );
}
async function setup_test_user(testuser: Account, tokenSymbol: string) {
  // const testuser = await AccountManager.createAccount('clienttest');
  await shared.dac_token_contract.transfer(
    shared.dac_token_contract.account.name,
    testuser.name,
    `1200.0000 ${tokenSymbol}`,
    '',
    { from: shared.dac_token_contract.account }
  );
}

async function expected_budget_transfer_amount(
  dacId: string,
  assert_manual: bool
) {
  const treasury_balance = await get_balance(
    shared.eosio_token_contract,
    shared.treasury_account,
    'TLM'
  );

  let percentage = await get_from_dacglobals(dacId, 'budget_percentage');
  if (percentage !== undefined) {
    // we have manually set budget percentage
    chai.expect(assert_manual).to.be.true;
  } else {
    chai.expect(assert_manual).to.be.false;
    const nft_res = await shared.dacdirectory_contract.nftcacheTable({
      scope: dacId,
    });
    const budget_nfts = nft_res.rows.filter(
      (x) => x.schema_name == BUDGET_SCHEMA
    );
    budget_nfts.sort((a, b) => b.value - a.value); // sort by value descending
    const nft_with_highest_value = budget_nfts[0];
    percentage = nft_with_highest_value.value;
  }
  const allocation_for_period = (treasury_balance * percentage) / 10000;
  const rounded_allocation = Math.max(allocation_for_period, 10);
  const transfer_amount = Math.max(
    0,
    Math.min(treasury_balance, rounded_allocation)
  );
  return round_to_decimals(transfer_amount, 4);
}

function round_to_decimals(number, decimals) {
  return Math.round(number * Math.pow(10, decimals)) / Math.pow(10, decimals);
}

async function get_balance(
  token_contract: Account,
  account: Account,
  search_symbol: string
) {
  const res = await token_contract.accountsTable({
    scope: account.name,
  });
  for (const row of res.rows) {
    const bal = new Asset(row.balance);
    if (bal.symbol == search_symbol) {
      return bal.amount;
    }
  }
  return 0.0;
}

async function get_from_dacglobals(dacId, key) {
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

function now() {
  return dayjs.utc().toDate();
}

function expect_recent(datetime) {
  chai.expect(datetime).closeToTime(now(), 5);
}

async function get_expected_avg_vote_time_stamp(
  dacId: string,
  voter: Account,
  candidate: Account
) {
  // get vote weight of voter (number of dac tokens)
  // get dac token from dacdirectory
  let res = await shared.dacdirectory_contract.dacsTable();
  const mydac = res.rows.find((x) => x.dac_id == dacId);
  const mysymbol = mydac.symbol.sym;
  const token_name = mysymbol.split(',')[1];
  const vote_weight =
    (await get_balance(shared.dac_token_contract, voter, token_name)) * 10000;

  // get avg_vote_time_stamp of candidate
  res = await shared.daccustodian_contract.candidatesTable({ scope: dacId });
  const mycand = res.rows.find((x) => x.candidate_name == candidate.name);
  let avg_vote_time_stamp = mycand.avg_vote_time_stamp;
  let total_vote_power = mycand.total_vote_power;

  // see if there is an exisiting vote and deduct
  res = await shared.daccustodian_contract.votesTable({
    scope: dacId,
    limit: 1,
    lowerBound: voter.name,
  });
  const ourvote = res.rows.find((x) => x.voter == voter.name);
  const now = new Date();

  // reduce
  if (ourvote) {
    total_vote_power -= vote_weight;
    if (total_vote_power == 0) {
      avg_vote_time_stamp = new Date(0);
    } else {
      const delta_milliseconds =
        (Math.abs(
          ourvote.vote_time_stamp.getTime() - avg_vote_time_stamp.getTime()
        ) *
          (-1 * vote_weight)) /
        total_vote_power;
      let new_milliseconds = Math.floor(
        avg_vote_time_stamp.getTime() + delta_milliseconds
      );

      avg_vote_time_stamp = new Date(new_milliseconds);
    }
  }
  total_vote_power += vote_weight;
  const delta_milliseconds =
    (Math.abs(now.getTime() - avg_vote_time_stamp.getTime()) * vote_weight) /
    total_vote_power;
  let new_milliseconds = Math.floor(
    avg_vote_time_stamp.getTime() + delta_milliseconds
  );

  return new Date(new_milliseconds);
}

async function vote_and_check(dacId, voter, candidate) {
  const expected_avg_vote_time_stamp = await get_expected_avg_vote_time_stamp(
    dacId,
    voter,
    candidate
  );
  await shared.daccustodian_contract.votecust(
    voter.name,
    [candidate.name],
    dacId,
    { from: voter }
  );
  let votedCandidateResult = await shared.daccustodian_contract.candidatesTable(
    {
      scope: dacId,
      limit: 1,
      lowerBound: candidate.name,
    }
  );
  chai
    .expect(votedCandidateResult.rows[0].candidate_name)
    .to.equal(candidate.name);
  chai
    .expect(votedCandidateResult.rows[0].avg_vote_time_stamp)
    .to.closeToTime(expected_avg_vote_time_stamp, 1);
}
