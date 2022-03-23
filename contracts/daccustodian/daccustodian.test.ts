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
} from 'lamington';

import { SharedTestObjects, NUMBER_OF_CANDIDATES } from '../TestHelpers';
import * as chai from 'chai';
import * as chaiAsPromised from 'chai-as-promised';
import { DaccustodianCandidate } from './daccustodian';
chai.use(chaiAsPromised);
let shared: SharedTestObjects;

const NFT_COLLECTION = 'alien.worlds';
const BUDGET_SCHEMA = 'budget';

describe('Daccustodian', () => {
  let second_nft_id: Number;

  before(async () => {
    shared = await SharedTestObjects.getInstance();
  });

  context('updateconfige', async () => {
    let dacId = 'custodiandac';
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
          },
          'unknowndac',
          { from: shared.auth_account }
        ),
        'ERR::DAC_NOT_FOUND'
      );
      await assertRowsEqual(
        shared.daccustodian_contract.config2Table({
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
          },
          dacId,
          { from: shared.auth_account }
        ),
        'ERR::UPDATECONFIG_INVALID_AUTH_HIGH_TO_NUM_ELECTED'
      );
      await assertRowsEqual(
        shared.daccustodian_contract.config2Table({
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
          },
          dacId,
          { from: shared.auth_account }
        ),
        'ERR::UPDATECONFIG_INVALID_AUTH_HIGH_TO_MID_AUTH'
      );
      await assertRowsEqual(
        shared.daccustodian_contract.config2Table({
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
          },
          dacId,
          { from: shared.auth_account }
        ),
        'ERR::UPDATECONFIG_INVALID_AUTH_MID_TO_LOW_AUTH'
      );
      await assertRowsEqual(
        shared.daccustodian_contract.config2Table({
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
          },
          dacId,
          { from: shared.auth_account }
        ),
        'ERR::UPDATECONFIG_INVALID_VOTE_QUORUM_PERCENT'
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
        },
        dacId,
        { from: shared.auth_account }
      );
      await assertRowsEqual(
        shared.daccustodian_contract.config2Table({
          scope: dacId,
          limit: 1,
        }),
        [
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
          },
        ]
      );
    });
  });

  context('nominatecane', async () => {
    context('With a staking enabled DAC', async () => {
      let dacId = 'nomstakedac';
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
        context('with sufficient staked funds', async () => {
          before(async () => {
            await debugPromise(
              shared.dac_token_contract.transfer(
                shared.dac_token_contract.account.name,
                newUser1.name,
                '1000.00 NOMDAC',
                '',
                { from: shared.dac_token_contract.account }
              ),
              'failed to preload the user with enough tokens for staking'
            );
            await debugPromise(
              shared.dac_token_contract.stake(newUser1.name, '12.00 NOMDAC', {
                from: newUser1,
              }),
              'failed staking'
            );
          });
          it('should succeed', async () => {
            await chai.expect(
              shared.daccustodian_contract.nominatecane(
                newUser1.name,
                '25.0000 EOS',
                dacId,
                { from: newUser1 }
              )
            ).eventually.be.fulfilled;
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
          await chai.expect(
            shared.daccustodian_contract.nominatecane(
              newUser1.name,
              '25.0000 EOS',
              dacId,
              { from: newUser1 }
            )
          ).eventually.be.fulfilled;
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
      it('candidates should have 0 for total_votes', async () => {
        chai
          .expect(currentCandidates.rows.length)
          .to.equal(NUMBER_OF_CANDIDATES);
        for (const cand of currentCandidates.rows) {
          chai.expect(cand).to.include({
            is_active: 1,
            locked_tokens: '0.0000 CANDAC',
            total_votes: 0,
          });

          chai.expect(
            cand.requestedpay == '15.0000 EOS' ||
              cand.requestedpay == '20.0000 EOS' ||
              cand.requestedpay == '25.0000 EOS'
          ).to.be.true;
          chai.expect(cand.custodian_end_time_stamp).to.equalDate(new Date(0));
          chai.expect(cand).has.property('candidate_name');
        }
      });
      it('state should have 0 the total_weight_of_votes', async () => {
        let dacState = await shared.daccustodian_contract.stateTable({
          scope: dacId,
        });
        chai.expect(dacState.rows[0]).to.include({
          total_weight_of_votes: 0,
        });
      });
    });
    context('After voting', async () => {
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
        let votedCandidateResult = shared.daccustodian_contract.votesTable({
          scope: dacId,
        });
        await assertRowsEqual(votedCandidateResult, [
          {
            candidates: [cands[0].name, cands[2].name],
            proxy: '',
            voter: regMembers[0].name,
          },
          {
            candidates: [cands[0].name, cands[2].name],
            proxy: '',
            voter: regMembers[1].name,
          },
        ]);
      });
      it('only candidates with votes have total_votes values', async () => {
        let votedCandidateResult = await shared.daccustodian_contract.candidatesTable(
          {
            scope: dacId,
            limit: 1,
            lowerBound: cands[1].name,
          }
        );
        chai.expect(votedCandidateResult.rows[0]).to.include({
          total_votes: 0,
        });
        let unvotedCandidateResult = await shared.daccustodian_contract.candidatesTable(
          {
            scope: dacId,
            limit: 1,
            lowerBound: cands[0].name,
          }
        );
        chai.expect(unvotedCandidateResult.rows[0]).to.include({
          total_votes: 20_000_000,
        });
        await assertRowCount(
          shared.daccustodian_contract.votesTable({
            scope: dacId,
          }),
          2
        );
      });
      it('state should have increased the total_weight_of_votes', async () => {
        let dacState = await shared.daccustodian_contract.stateTable({
          scope: dacId,
        });
        chai.expect(dacState.rows[0]).to.include({
          total_weight_of_votes: 20_000_000,
        });
      });
    });
    context('vote values after transfers', async () => {
      it('assert preconditions for vote values for custodians', async () => {
        let votedCandidateResult = await shared.daccustodian_contract.candidatesTable(
          {
            scope: dacId,
            limit: 20,
            lowerBound: cands[0].name,
          }
        );
        let initialVoteValue = votedCandidateResult.rows[0].total_votes;
        chai.expect(initialVoteValue).to.equal(20_000_000);
      });
      it('assert preconditions for total vote values on state', async () => {
        let dacState = await shared.daccustodian_contract.stateTable({
          scope: dacId,
        });
        chai.expect(dacState.rows[0]).to.include({
          total_weight_of_votes: 20_000_000,
        });
      });
      it('after transfer to non-voter values should reduce for candidates and total values', async () => {
        await shared.dac_token_contract.transfer(
          regMembers[1].name,
          regMembers[4].name,
          '300.0000 CANDAC',
          '',
          { from: regMembers[1] }
        );
        let votedCandidateResult = await shared.daccustodian_contract.candidatesTable(
          {
            scope: dacId,
            limit: 20,
            lowerBound: cands[0].name,
          }
        );
        let updatedCandVoteValue = votedCandidateResult.rows[0].total_votes;
        chai.expect(updatedCandVoteValue).to.equal(17_000_000);
      });
      it('total vote values on state should have changed', async () => {
        let dacState = await shared.daccustodian_contract.stateTable({
          scope: dacId,
        });
        chai.expect(dacState.rows[0]).to.include({
          total_weight_of_votes: 17_000_000,
        });
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
        let votedCandidateResult = shared.daccustodian_contract.votesTable({
          scope: dacId,
        });
        await assertRowsEqual(votedCandidateResult, [
          {
            candidates: [cands[0].name, cands[2].name],
            proxy: '',
            voter: regMembers[0].name,
          },
          {
            candidates: [cands[0].name, cands[2].name],
            proxy: '',
            voter: regMembers[1].name,
          },
        ]);
      });
      it('only candidates with votes have total_votes values', async () => {
        let unvotedCandidateResult = await shared.daccustodian_contract.candidatesTable(
          {
            scope: dacId,
            limit: 1,
            lowerBound: cands[1].name,
          }
        );
        chai.expect(unvotedCandidateResult.rows[0]).to.include({
          total_votes: 0,
        });
        let votedCandidateResult = await shared.daccustodian_contract.candidatesTable(
          {
            scope: dacId,
            limit: 1,
            lowerBound: cands[0].name,
          }
        );
        chai.expect(votedCandidateResult.rows[0]).to.include({
          total_votes: 20_000_000,
        });
        await assertRowCount(
          shared.daccustodian_contract.votesTable({
            scope: dacId,
          }),
          2
        );
      });
      it('state should have increased the total_weight_of_votes', async () => {
        let dacState = await shared.daccustodian_contract.stateTable({
          scope: dacId,
        });
        chai.expect(dacState.rows[0]).to.include({
          total_weight_of_votes: 20_000_000,
        });
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
          await chai.expect(
            shared.daccustodian_contract.regproxy(regMembers[0].name, dacId, {
              from: regMembers[0],
            })
          ).to.eventually.be.fulfilled;
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
        let votedCandidateResult = await shared.daccustodian_contract.votesTable(
          {
            scope: dacId,
            lowerBound: regMembers[3].name,
            upperBound: regMembers[3].name,
          }
        );
        let proxyVote = votedCandidateResult.rows[0];
        chai.expect(proxyVote.voter).to.equal(regMembers[3].name);
        chai.expect(proxyVote.candidates).to.be.empty;
        chai.expect(proxyVote.proxy).to.equal(regMembers[0].name);
      });
      it('only candidates with votes have total_votes values', async () => {
        let unvotedCandidateResult = await shared.daccustodian_contract.candidatesTable(
          {
            scope: dacId,
            limit: 1,
            lowerBound: cands[1].name,
          }
        );
        chai.expect(unvotedCandidateResult.rows[0]).to.include({
          total_votes: 0,
        });
        let votedCandidateResult = await shared.daccustodian_contract.candidatesTable(
          {
            scope: dacId,
            limit: 1,
            lowerBound: cands[0].name,
          }
        );
        chai.expect(votedCandidateResult.rows[0]).to.include({
          total_votes: 30_000_000,
        });
        await assertRowCount(
          shared.daccustodian_contract.votesTable({
            scope: dacId,
          }),
          3
        );
      });
      it('state should have increased the total_weight_of_votes', async () => {
        let dacState = await shared.daccustodian_contract.stateTable({
          scope: dacId,
        });
        chai.expect(dacState.rows[0]).to.include({
          total_weight_of_votes: 30_000_000, // SHould be 30,000,000 I think
        });
      });
      context('vote values after transfers', async () => {
        it('assert preconditions for vote values for custodians', async () => {
          let votedCandidateResult = await shared.daccustodian_contract.candidatesTable(
            {
              scope: dacId,
              limit: 20,
              lowerBound: cands[0].name,
            }
          );
          let initialVoteValue = votedCandidateResult.rows[0].total_votes;
          chai.expect(initialVoteValue).to.equal(30_000_000);
        });
        it('assert preconditions for total vote values on state', async () => {
          let dacState = await shared.daccustodian_contract.stateTable({
            scope: dacId,
          });
          chai.expect(dacState.rows[0]).to.include({
            total_weight_of_votes: 30_000_000,
          });
        });
        it('after transfer to non-voter values should reduce for candidates and total values', async () => {
          await shared.dac_token_contract.transfer(
            regMembers[3].name,
            regMembers[7].name,
            '300.0000 PROXDAC',
            '',
            { from: regMembers[3] }
          );
          let votedCandidateResult = await shared.daccustodian_contract.candidatesTable(
            {
              scope: dacId,
              limit: 20,
              lowerBound: cands[0].name,
            }
          );
          let updatedCandVoteValue = votedCandidateResult.rows[0].total_votes;
          chai.expect(updatedCandVoteValue).to.equal(27_000_000); // should be 27,000,000
        });
        it('total vote values on state should have changed', async () => {
          let dacState = await shared.daccustodian_contract.stateTable({
            scope: dacId,
          });
          chai.expect(dacState.rows[0]).to.include({
            total_weight_of_votes: 27_000_000,
          });
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
            await chai.expect(
              shared.daccustodian_contract.unregproxy(
                regMembers[0].name,
                dacId,
                { from: regMembers[0] }
              )
            ).to.eventually.be.fulfilled;
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
            let votedCandidateResult = await shared.daccustodian_contract.candidatesTable(
              {
                scope: dacId,
                limit: 20,
                lowerBound: cands[0].name,
              }
            );
            let updatedCandVoteValue = votedCandidateResult.rows[0].total_votes;
            chai.expect(updatedCandVoteValue).to.equal(20_000_000);
          });
          it('total vote values on state should have changed', async () => {
            let dacState = await shared.daccustodian_contract.stateTable({
              scope: dacId,
            });
            chai.expect(dacState.rows[0]).to.include({
              total_weight_of_votes: 20_000_000,
            });
          });
        }
      );
    });
  });

  context('New Period Elections', async () => {
    let dacId = 'newperioddac';
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
            before(async () => {
              candidates = await shared.getStakeObservedCandidates(
                dacId,
                '12.0000 PERDAC'
              );
              await shared.voteForCustodians(regMembers, candidates, dacId);

              // Change the config to a lower requestedPayMax to affect average pay tests after `newperiod` succeeds.
              // This change to `23.0000 EOS` should cause the requested pays of 25.0000 EOS to be fitered from the mean pay.
              await chai.expect(
                shared.daccustodian_contract.updateconfige(
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
                  },
                  dacId,
                  { from: shared.auth_account }
                )
              ).to.eventually.be.fulfilled;
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
              chai.expect(rs[0].total_votes).to.equal(3200000000);
              chai.expect(rs[1].total_votes).to.equal(3200000000);
              chai.expect(rs[2].total_votes).to.equal(3200000000);
              chai.expect(rs[3].total_votes).to.equal(1600000000);
              chai.expect(rs[4].total_votes).to.equal(1600000000);
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

              let ownerPermission = permissions[0];
              let ownerRequiredAuth = ownerPermission.required_auth;
              chai.expect(ownerPermission.parent).to.eq('owner');
              chai.expect(ownerPermission.perm_name).to.eq('active');
              chai.expect(ownerRequiredAuth.threshold).to.eq(1);

              let adminPermission = permissions[1];
              let adminRequiredAuth = adminPermission.required_auth;
              chai.expect(adminPermission.parent).to.eq('one');
              chai.expect(adminPermission.perm_name).to.eq('admin');
              chai.expect(adminRequiredAuth.threshold).to.eq(1);

              let highPermission = permissions[2];
              let highRequiredAuth = highPermission.required_auth;
              chai.expect(highPermission.parent).to.eq('active');
              chai.expect(highPermission.perm_name).to.eq('high');
              chai.expect(highRequiredAuth.threshold).to.eq(4);

              let highAccounts = highRequiredAuth.accounts;
              chai.expect(highAccounts.length).to.eq(5);
              chai.expect(highAccounts[0].weight).to.eq(1);

              let lowPermission = permissions[3];
              let lowRequiredAuth = lowPermission.required_auth;

              chai.expect(lowPermission.parent).to.eq('med');
              chai.expect(lowPermission.perm_name).to.eq('low');
              chai.expect(lowRequiredAuth.threshold).to.eq(2);

              let lowAccounts = lowRequiredAuth.accounts;
              chai.expect(lowAccounts.length).to.eq(5);
              chai.expect(lowAccounts[0].weight).to.eq(1);

              let medPermission = permissions[4];
              let medRequiredAuth = medPermission.required_auth;

              chai.expect(medPermission.parent).to.eq('high');
              chai.expect(medPermission.perm_name).to.eq('med');
              chai.expect(medRequiredAuth.threshold).to.eq(3);

              let medAccounts = medRequiredAuth.accounts;
              chai.expect(medAccounts.length).to.eq(5);
              chai.expect(medAccounts[0].weight).to.eq(1);

              let onePermission = account.permissions[5];
              let oneRequiredAuth = onePermission.required_auth;

              chai.expect(onePermission.parent).to.eq('low');
              chai.expect(onePermission.perm_name).to.eq('one');
              chai.expect(oneRequiredAuth.threshold).to.eq(1);

              let oneAccounts = oneRequiredAuth.accounts;
              chai.expect(oneAccounts.length).to.eq(5);
              chai.expect(oneAccounts[0].weight).to.eq(1);
            });
          });
          // it('should succeed setting up testuser', async () => {
          //   await setup_test_user(candidates[0], 'PERDAC');
          // });
        });
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
          await sleep(4_000);
        });
        it('should succeed', async () => {
          await chai.expect(
            shared.daccustodian_contract.newperiod(
              'initial new period',
              dacId,
              {
                from: newUser1,
              }
            )
          ).to.eventually.be.fulfilled;
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
          let custodianRows = await shared.daccustodian_contract.custodiansTable(
            {
              scope: dacId,
              limit: 12,
            }
          );
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
              before(async () => {
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
              it('should succeed with lockup of stake', async () => {
                let electedCandidateToResign = existing_candidates[3];

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
                let candidates = await shared.daccustodian_contract.candidatesTable(
                  {
                    scope: dacId,
                    limit: 20,
                    lowerBound: electedCandidateToResign.name,
                    upperBound: electedCandidateToResign.name,
                  }
                );
                chai
                  .expect(candidates.rows[0].custodian_end_time_stamp)
                  .to.be.greaterThan(new Date(Date.now()));
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
        it('should succeed with lockup of stake active from previous election', async () => {
          await shared.daccustodian_contract.withdrawcane(
            electedCandidateToResign.name,
            dacId,
            { from: electedCandidateToResign }
          );
          let candidates = await shared.daccustodian_contract.candidatesTable({
            scope: dacId,
            limit: 20,
            lowerBound: electedCandidateToResign.name,
            upperBound: electedCandidateToResign.name,
          });
          chai
            .expect(candidates.rows[0].custodian_end_time_stamp)
            .to.be.afterTime(new Date(Date.now()));
        });
      });
      context('for an unelected candidate', async () => {
        it('should succeed', async () => {
          let beforeState = await shared.daccustodian_contract.stateTable({
            scope: dacId,
            limit: 1,
          });

          var numberActiveCandidatesBefore =
            beforeState.rows[0].number_active_candidates;

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
          chai
            .expect(candidates.rows[0].custodian_end_time_stamp)
            .to.be.equalDate(new Date(0));
          chai.expect(candidates.rows[0].is_active).to.be.equal(0);
          let afterState = await shared.daccustodian_contract.stateTable({
            scope: dacId,
            limit: 1,
          });
          chai
            .expect(afterState.rows[0].number_active_candidates)
            .to.be.equal(numberActiveCandidatesBefore - 1);
        });
        it('should allow unstaking without a timelock error', async () => {
          await chai.expect(
            shared.dac_token_contract.unstake(
              unelectedCandidateToResign.name,
              '12.0000 WITHDAC',
              { from: unelectedCandidateToResign }
            )
          ).to.eventually.be.fulfilled;
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
          let candidates = await shared.daccustodian_contract.candidatesTable({
            scope: dacId,
            limit: 20,
            lowerBound: electedCandidateToFire.name,
            upperBound: electedCandidateToFire.name,
          });
          chai
            .expect(candidates.rows[0].custodian_end_time_stamp)
            .to.be.afterTime(new Date(Date.now()));
        });
      });
      context('for an unelected candidate', async () => {
        it('should succeed', async () => {
          let beforeState = await shared.daccustodian_contract.stateTable({
            scope: dacId,
            limit: 1,
          });

          var numberActiveCandidatesBefore =
            beforeState.rows[0].number_active_candidates;

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
          chai
            .expect(candidates.rows[0].custodian_end_time_stamp)
            .to.be.afterDate(new Date(0));
          chai.expect(candidates.rows[0].is_active).to.be.equal(0);
          let afterState = await shared.daccustodian_contract.stateTable({
            scope: dacId,
            limit: 1,
          });
          chai
            .expect(afterState.rows[0].number_active_candidates)
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
      await shared.initDac(dacId, '4,FCUSTDAC', '1000000.0000 FCUSTDAC');
      await shared.updateconfig(dacId, '12.0000 FCUSTDAC');
      await shared.dac_token_contract.stakeconfig(
        { enabled: true, min_stake_time: 5, max_stake_time: 20 },
        '4,FCUSTDAC',
        { from: shared.auth_account }
      );

      regMembers = await shared.getRegMembers(dacId, '20000.0000 FCUSTDAC');
      unregisteredCandidate = regMembers[0];
      candidates = await shared.getStakeObservedCandidates(
        dacId,
        '12.0000 FCUSTDAC',
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
        it('should succeed with lockup of stake', async () => {
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
          chai
            .expect(candidates.rows[0].custodian_end_time_stamp)
            .to.be.afterTime(new Date(Date.now()));
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
      await chai.expect(
        shared.daccustodian_contract.appointcust(
          accountsToRegister.map((account) => {
            return account.name;
          }),
          dacId,
          { from: shared.auth_account }
        )
      ).to.eventually.be.fulfilled;
      let candidates = await shared.daccustodian_contract.candidatesTable({
        scope: dacId,
        limit: 20,
      });
      chai.expect(candidates.rows.length).equals(5);
      chai
        .expect(candidates.rows[0].custodian_end_time_stamp)
        .to.be.equalDate(new Date(0));

      chai.expect(candidates.rows[0].requestedpay).to.equal('0.0000 EOS');
      chai.expect(candidates.rows[0].locked_tokens).to.equal('0.0000 APPDAC');
      chai.expect(candidates.rows[0].total_votes).to.equal(0);
      chai.expect(candidates.rows[0].is_active).to.equal(1);

      let custodians = await shared.daccustodian_contract.custodiansTable({
        scope: dacId,
        limit: 20,
      });
      chai.expect(custodians.rows.length).equals(5);

      chai.expect(custodians.rows[0].requestedpay).to.equal('0.0000 EOS');
      chai.expect(custodians.rows[0].total_votes).to.equal(0);
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
      await shared.initDac(dacId, '4,PERIODDAC', '1000000.0000 PERIODDAC');
      await shared.updateconfig(dacId, '12.0000 PERIODDAC');
      await shared.dac_token_contract.stakeconfig(
        { enabled: true, min_stake_time: 5, max_stake_time: 20 },
        '4,PERIODDAC',
        { from: shared.auth_account }
      );

      // With 16 voting members with 2000 each and a threshold of 31 percent
      // this will total to 320_000 vote value which will be enough to start the DAC
      regMembers = await shared.getRegMembers(dacId, '20000.0000 PERIODDAC');
      candidates = await shared.getStakeObservedCandidates(
        dacId,
        '12.0000 PERIODDAC'
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
            quantity: '12.0000 PERIODDAC',
          },
          should_pay_via_service_provider: false,
          lockup_release_time_delay: 1233,
        },
        dacId,
        { from: shared.auth_account }
      );

      await setup_nfts();
    });
    context('after initial logmint', async () => {
      it('nftcache table should contain our NFT', async () => {
        await assertRowsEqual(
          shared.dacdirectory_contract.nftcacheTable({
            scope: dacId,
          }),
          [
            {
              nft_id: '1099511627776',
              schema_name: BUDGET_SCHEMA,
              value: 400,
            },
            {
              nft_id: '1099511627777',
              schema_name: BUDGET_SCHEMA,
              value: 500,
            },
            {
              nft_id: '1099511627778',
              schema_name: BUDGET_SCHEMA,
              value: 300,
            },
          ]
        );
      });
    });
    context(
      'newperiod when transfer amount is bigger than treasury',
      async () => {
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
        it('should only transfer treasury balance', async () => {
          await assertBalanceEqual(
            shared.eosio_token_contract.accountsTable({
              scope: shared.treasury_account.name,
            }),
            '0.0000 TLM'
          );
          await assertBalanceEqual(
            shared.eosio_token_contract.accountsTable({
              scope: shared.auth_account.name,
            }),
            '150.0000 TLM'
          );
        });
      }
    );
    context(
      'newperiod when transfer amount smaller than treasury',
      async () => {
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
        });
        it('should transfer amount according to formula', async () => {
          await assertBalanceEqual(
            shared.eosio_token_contract.accountsTable({
              scope: shared.treasury_account.name,
            }),
            '1425.0000 TLM'
          );
          await assertBalanceEqual(
            shared.eosio_token_contract.accountsTable({
              scope: shared.auth_account.name,
            }),
            '225.0000 TLM'
          );
        });
      }
    );
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
        await assertRowsEqual(
          shared.dacdirectory_contract.nftcacheTable({
            scope: dacId,
          }),
          [
            {
              schema_name: BUDGET_SCHEMA,
              nft_id: '1099511627777',
              value: 500,
            },
          ]
        );
      });
    });
    context('index', async () => {
      it('should sort correctly', async () => {
        await shared.dacdirectory_contract.indextest();
      });
    });
  });
});

/* Use a fresh instance to prevent caching of results */
function get_atomic() {
  return new RpcApi('http://localhost:8888', 'atomicassets', {
    fetch,
  });
}

async function setup_nfts() {
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
    '',
    { from: shared.eosio_token_contract.account }
  );

  await shared.atomicassets.mintasset(
    shared.eosio_token_contract.account.name,
    NFT_COLLECTION,
    BUDGET_SCHEMA,
    1,
    shared.auth_account.name,
    [
      { key: 'cardid', value: ['uint16', 1] },
      { key: 'name', value: ['string', 'xxx'] },
      { key: 'percentage', value: ['uint16', 400] }, // 4%
    ] as any,
    '',
    [],
    { from: shared.eosio_token_contract.account }
  );
  await shared.atomicassets.mintasset(
    shared.eosio_token_contract.account.name,
    NFT_COLLECTION,
    BUDGET_SCHEMA,
    1,
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
    1,
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
  console.log(`testuser: ${JSON.stringify(testuser, null, 2)}`);
  await shared.dac_token_contract.transfer(
    shared.dac_token_contract.account.name,
    testuser.name,
    `1200.0000 ${tokenSymbol}`,
    '',
    { from: shared.dac_token_contract.account }
  );
}
