import * as l from 'lamington';

import {
  SharedTestObjects,
  initAndGetSharedObjects,
  candidates,
  regmembers,
} from '../TestHelpers';
import * as chai from 'chai';
import { factory } from '../LoggingConfig';

const log = factory.getLogger('Custodian Tests');

describe('Daccustodian', () => {
  let shared: SharedTestObjects;
  let newUser1: l.Account;

  before(async () => {
    shared = await initAndGetSharedObjects()
      .then(value => {
        log.info('created shared objects: ' + value);
        return value;
      })
      .catch(err => {
        log.info('erro occured while getting chared objects: ' + err, err);
        return err;
      });
  });

  context('updateconfige', async () => {
    it('Should fail for a dac_id without a dac', async () => {
      await l.assertEOSErrorIncludesMessage(
        shared.daccustodian_contract.updateconfige(
          {
            numelected: 5,
            maxvotes: 5,
            auth_threshold_mid: 6,
            requested_pay_max: { contract: 'sdfsdf', quantity: '12.0000 EOS' },
            periodlength: 37500,
            initial_vote_quorum_percent: 34,
            vote_quorum_percent: 12,
            auth_threshold_high: 4,
            auth_threshold_low: 3,
            lockupasset: { contract: 'sdfsdf', quantity: '12.0000 EOS' },
            should_pay_via_service_provider: true,
            lockup_release_time_delay: 1233,
          },
          'unknowndac',
          { from: shared.dac_owner }
        ),
        'ERR::DAC_NOT_FOUND'
      );
      await l.assertRowsEqual(
        shared.daccustodian_contract.config2Table({
          scope: 'unknowndac',
          limit: 1,
        }),
        []
      );
    });
    it('Should fail for invalid high auth threshold', async () => {
      await l.assertEOSErrorIncludesMessage(
        shared.daccustodian_contract.updateconfige(
          {
            numelected: 5,
            maxvotes: 5,
            requested_pay_max: { contract: 'sdfsdf', quantity: '12.0000 EOS' },
            periodlength: 37500,
            initial_vote_quorum_percent: 34,
            vote_quorum_percent: 12,
            auth_threshold_high: 5,
            auth_threshold_mid: 6,
            auth_threshold_low: 3,
            lockupasset: { contract: 'sdfsdf', quantity: '12.0000 EOS' },
            should_pay_via_service_provider: true,
            lockup_release_time_delay: 1233,
          },
          shared.configured_dac_id,
          { from: shared.auth_account }
        ),
        'ERR::UPDATECONFIG_INVALID_AUTH_HIGH_TO_NUM_ELECTED'
      );
      await l.assertRowsEqual(
        shared.daccustodian_contract.config2Table({
          scope: shared.configured_dac_id,
          limit: 2,
        }),
        []
      );
    });
    it('Should fail for invalid mid auth threshold', async () => {
      await l.assertEOSErrorIncludesMessage(
        shared.daccustodian_contract.updateconfige(
          {
            numelected: 12,
            maxvotes: 5,
            requested_pay_max: { contract: 'sdfsdf', quantity: '12.0000 EOS' },
            periodlength: 37500,
            initial_vote_quorum_percent: 34,
            vote_quorum_percent: 12,
            auth_threshold_high: 9,
            auth_threshold_mid: 10,
            auth_threshold_low: 4,
            lockupasset: { contract: 'sdfsdf', quantity: '12.0000 EOS' },
            should_pay_via_service_provider: true,
            lockup_release_time_delay: 1233,
          },
          shared.configured_dac_id,
          { from: shared.auth_account }
        ),
        'ERR::UPDATECONFIG_INVALID_AUTH_HIGH_TO_MID_AUTH'
      );
      await l.assertRowsEqual(
        shared.daccustodian_contract.config2Table({
          scope: shared.configured_dac_id,
          limit: 2,
        }),
        []
      );
    });
    it('Should fail for invalid mid auth threshold', async () => {
      await l.assertEOSErrorIncludesMessage(
        shared.daccustodian_contract.updateconfige(
          {
            numelected: 12,
            maxvotes: 5,
            requested_pay_max: { contract: 'sdfsdf', quantity: '12.0000 EOS' },
            periodlength: 37500,
            initial_vote_quorum_percent: 34,
            vote_quorum_percent: 12,
            auth_threshold_high: 9,
            auth_threshold_mid: 7,
            auth_threshold_low: 8,
            lockupasset: { contract: 'sdfsdf', quantity: '12.0000 EOS' },
            should_pay_via_service_provider: true,
            lockup_release_time_delay: 1233,
          },
          shared.configured_dac_id,
          { from: shared.auth_account }
        ),
        'ERR::UPDATECONFIG_INVALID_AUTH_MID_TO_LOW_AUTH'
      );
      await l.assertRowsEqual(
        shared.daccustodian_contract.config2Table({
          scope: shared.configured_dac_id,
          limit: 2,
        }),
        []
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
          periodlength: 37500,
          initial_vote_quorum_percent: 34,
          vote_quorum_percent: 12,
          auth_threshold_high: 4,
          auth_threshold_mid: 3,
          auth_threshold_low: 2,
          lockupasset: {
            contract: shared.dac_token_contract.account.name,
            quantity: '12.0000 EOSDAC',
          },
          should_pay_via_service_provider: true,
          lockup_release_time_delay: 1233,
        },
        shared.configured_dac_id,
        { from: shared.auth_account }
      );
      await l.assertRowsEqual(
        shared.daccustodian_contract.config2Table({
          scope: shared.configured_dac_id,
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
            periodlength: 37500,
            initial_vote_quorum_percent: 34,
            vote_quorum_percent: 12,
            auth_threshold_high: 4,
            auth_threshold_mid: 3,
            auth_threshold_low: 2,
            lockupasset: {
              contract: shared.dac_token_contract.account.name,
              quantity: '12.0000 EOSDAC',
            },
            should_pay_via_service_provider: true,
            lockup_release_time_delay: 1233,
          },
        ]
      );
    });
  });
  context('Capture stake for a new member', async () => {
    before(async () => {
      newUser1 = await l.AccountManager.createAccount()
        .then(value => {
          log.info('created user : ' + JSON.stringify(value));
          return value;
        })
        .catch(error => {
          log.error('while creating user: ', error);
          return error;
        });
      l.nextBlock();
      await shared.dac_token_contract
        .transfer(
          shared.dac_token_contract.account.name,
          newUser1.name,
          '1000.0000 EOSDAC',
          '',
          { from: shared.dac_token_contract.account }
        )
        .then(value => {
          log.info('transfer : ' + JSON.stringify(value));
          return value;
        })
        .catch(error => {
          log.error('while transferring to user: ', error);
          return error;
        });
    });
    context('before the sender is a candidate', async () => {
      it('pending stake is inserted or has amount appended', async () => {
        await shared.dac_token_contract.transfer(
          newUser1.name,
          shared.daccustodian_contract.account.name,
          '3.0000 EOSDAC',
          '',
          { auths: [{ actor: newUser1.name, permission: 'active' }] }
        );
        await shared.dac_token_contract.transfer(
          newUser1.name,
          shared.daccustodian_contract.account.name,
          '7.0000 EOSDAC',
          '',
          { auths: [{ actor: newUser1.name, permission: 'active' }] }
        );

        await l.assertRowsEqual(
          shared.daccustodian_contract.pendingstakeTable({
            scope: shared.configured_dac_id,
          }),
          [{ memo: '', quantity: '10.0000 EOSDAC', sender: newUser1.name }]
        );
        await l.assertRowsEqual(
          shared.dac_token_contract.accountsTable({
            scope: shared.daccustodian_contract.account.name,
          }),
          [
            {
              balance: '10.0000 EOSDAC',
            },
          ]
        );
      });
    });
  });
  context('nominatecane', async () => {
    context('with unregistered member', async () => {
      it('should fail with error', async () => {
        await l.assertEOSErrorIncludesMessage(
          shared.daccustodian_contract.nominatecane(
            newUser1.name,
            '25.0000 EOS',
            shared.configured_dac_id,
            { from: newUser1 }
          ),
          'ERR::GENERAL_REG_MEMBER_NOT_FOUND'
        );
      });
    });
    context('with registered member', async () => {
      before(async () => {
        await shared.dac_token_contract.memberrege(
          newUser1.name,
          shared.configured_dac_memberterms,
          shared.configured_dac_id,
          { from: newUser1 }
        );
      });
      context('with insufficient staked funds', async () => {
        it('should fail with error', async () => {
          await l.assertEOSErrorIncludesMessage(
            shared.daccustodian_contract.nominatecane(
              newUser1.name,
              '25.0000 EOS',
              shared.configured_dac_id,
              { from: newUser1 }
            ),
            'ERR::NOMINATECAND_STAKING_FUNDS_INCOMPLETE'
          );
        });
      });
      context('with sufficient staked funds', async () => {
        before(async () => {
          await shared.dac_token_contract.transfer(
            newUser1.name,
            shared.daccustodian_contract.account.name,
            '2.0000 EOSDAC',
            '',
            { from: newUser1 }
          );
        });

        it('should succeed', async () => {
          // pending stake should be populated before nominatecane
          await l.assertRowsEqual(
            shared.daccustodian_contract.pendingstakeTable({
              scope: shared.configured_dac_id,
            }),
            [{ memo: '', quantity: '12.0000 EOSDAC', sender: newUser1.name }]
          );

          await shared.daccustodian_contract.nominatecane(
            newUser1.name,
            '25.0000 EOS',
            shared.configured_dac_id,
            { from: newUser1 }
          );

          // pending stake should be empty after nominatecane
          await l.assertRowsEqual(
            shared.daccustodian_contract.pendingstakeTable({
              scope: shared.configured_dac_id,
            }),
            []
          );
        });
      });
    });
  });

  context('candidates', async () => {
    let cands: l.Account[];
    before(async () => {});
    context('with no votes', async () => {
      it('candidates should have 0 for total_votes', async () => {
        cands = await candidates();
        await l.nextBlock();
        let currentCandidates = await shared.daccustodian_contract.candidatesTable(
          { scope: shared.configured_dac_id, limit: 10 }
        );
        chai.expect(currentCandidates.rows.length).to.equal(7);
        for (const cand of currentCandidates.rows) {
          // console.log('cand: ' + JSON.stringify(cand));
          chai.expect(cand).to.include({
            // custodian_end_time_stamp: new Date(0),
            is_active: 1,
            locked_tokens: '12.0000 EOSDAC',
            requestedpay: '25.0000 EOS',
            total_votes: 0,
          });
          chai.expect(cand.custodian_end_time_stamp).to.equalDate(new Date(0));
          chai.expect(cand).has.property('candidate_name');
        }
      });
      it('state should have 0 the total_weight_of_votes', async () => {
        let votedCandidateResult = await shared.daccustodian_contract.stateTable(
          { scope: shared.configured_dac_id }
        );
        chai.expect(votedCandidateResult.rows[0]).to.include({
          total_weight_of_votes: 0,
        });
      });
    });
    context('After voting', async () => {
      before(async () => {
        // Place votes for even number candidates and leave odd number without votes.
        let members = await regmembers();
        // console.log('members:: ' + JSON.stringify(members));
        // Only vote with the first 2 members
        for (const member of members.slice(0, 2)) {
          // console.log('voting:: ' + JSON.stringify(member));

          await shared.daccustodian_contract.votecuste(
            member.name,
            [cands[0].name, cands[2].name, cands[4].name],
            shared.configured_dac_id,
            { from: member }
          );
        }
      });
      it('votes table should have rows', async () => {
        let members = await regmembers();
        let votedCandidateResult = shared.daccustodian_contract.votesTable({
          scope: shared.configured_dac_id,
        });
        await l.assertRowsEqual(votedCandidateResult, [
          {
            candidates: [cands[0].name, cands[2].name, cands[4].name],
            proxy: '',
            voter: members[0].name,
          },
          {
            candidates: [cands[0].name, cands[2].name, cands[4].name],
            proxy: '',
            voter: members[1].name,
          },
        ]);
      });
      it('only candidates with votes have total_votes values', async () => {
        let votedCandidateResult = await shared.daccustodian_contract.candidatesTable(
          {
            scope: shared.configured_dac_id,
            limit: 1,
            lowerBound: cands[0].name,
          }
        );
        chai.expect(votedCandidateResult.rows[0]).to.include({
          total_votes: 40000000,
        });
        let unvotedCandidateResult = await shared.daccustodian_contract.candidatesTable(
          {
            scope: shared.configured_dac_id,
            limit: 1,
            lowerBound: cands[1].name,
          }
        );
        chai.expect(unvotedCandidateResult.rows[0]).to.include({
          total_votes: 0,
        });
        await l.assertRowCount(
          shared.daccustodian_contract.votesTable({
            scope: shared.configured_dac_id,
          }),
          2
        );
      });
      it('state should have increased the total_weight_of_votes', async () => {
        let votedCandidateResult = await shared.daccustodian_contract.stateTable(
          { scope: shared.configured_dac_id }
        );
        chai.expect(votedCandidateResult.rows[0]).to.include({
          total_weight_of_votes: 40000000,
        });
      });
    });
    context('after transfer', async () => {
      before(async () => {
        let members = await regmembers();
        await shared.dac_token_contract.transfer(
          members[0].name,
          members[3].name,
          '300.0000 EOSDAC',
          '',
          { from: members[0] }
        );
      });
      it('vote values for existing custodians should reduce', async () => {
        let votedCandidateResult = await shared.daccustodian_contract.candidatesTable(
          {
            scope: shared.configured_dac_id,
            limit: 2,
            lowerBound: cands[0].name,
          }
        );
        chai.expect(votedCandidateResult.rows[0]).to.include({
          total_votes: 37000000,
        });
      });
      it('state shoild have updated for the total_weight_of_votes', async () => {
        let votedCandidateResult = await shared.daccustodian_contract.stateTable(
          { scope: shared.configured_dac_id }
        );
        chai.expect(votedCandidateResult.rows[0]).to.include({
          total_weight_of_votes: 37000000,
        });
      });
    });
  });
  context('when stakeobsv is called', async () => {});
});
