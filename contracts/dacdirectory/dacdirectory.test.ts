import * as l from 'lamington';

import { SharedTestObjects } from '../TestHelpers';
import * as chai from 'chai';
import * as chaiAsPromised from 'chai-as-promised';
chai.use(chaiAsPromised);

describe('Dacdirectory', () => {
  let shared: SharedTestObjects;
  let legaldacid = 'legaldacid';

  before(async () => {
    shared = await SharedTestObjects.getInstance();
  });

  context('regdac', async () => {
    it('Should fail with `admin` for `dac_id`', async () => {
      await l.assertEOSErrorIncludesMessage(
        shared.dacdirectory_contract.regdac(
          shared.auth_account.name,
          'admin',
          { contract: shared.dac_token_contract.account.name, sym: '4,DAO' },
          'dactitle',
          [],
          [],
          {
            from: shared.auth_account,
          }
        ),
        'ERR::DAC_FORBIDDEN_NAME::DAC ID is forbid'
      );
    });
    it('Should fail with `builder` for `dac_id`', async () => {
      await l.assertEOSErrorIncludesMessage(
        shared.dacdirectory_contract.regdac(
          shared.auth_account.name,
          'builder',
          { contract: shared.dac_token_contract.account.name, sym: '4,DAO' },
          'dactitle',
          [],
          [],
          {
            from: shared.auth_account,
          }
        ),
        'ERR::DAC_FORBIDDEN_NAME'
      );
    });
    it('Should fail with `members` for `dac_id`', async () => {
      await l.assertEOSErrorIncludesMessage(
        shared.dacdirectory_contract.regdac(
          shared.auth_account.name,
          'members',
          { contract: shared.dac_token_contract.account.name, sym: '4,DAO' },
          'dactitle',
          [],
          [],
          {
            from: shared.auth_account,
          }
        ),
        'ERR::DAC_FORBIDDEN_NAME'
      );
    });
    it('Should fail with `dacauthority` for `dac_id`', async () => {
      await l.assertEOSErrorIncludesMessage(
        shared.dacdirectory_contract.regdac(
          shared.auth_account.name,
          'dacauthority',
          { contract: shared.dac_token_contract.account.name, sym: '4,DAO' },
          'dactitle',
          [],
          [],
          {
            from: shared.auth_account,
          }
        ),
        'ERR::DAC_FORBIDDEN_NAME'
      );
    });
    it('Should fail with `daccustodian` for `dac_id`', async () => {
      await l.assertEOSErrorIncludesMessage(
        shared.dacdirectory_contract.regdac(
          shared.auth_account.name,
          'daccustodian',
          { contract: shared.dac_token_contract.account.name, sym: '4,DAO' },
          'dactitle',
          [],
          [],
          {
            from: shared.auth_account,
          }
        ),
        'ERR::DAC_FORBIDDEN_NAME'
      );
    });
    it('Should fail with `eosdactokens` for `dac_id`', async () => {
      await l.assertEOSErrorIncludesMessage(
        shared.dacdirectory_contract.regdac(
          shared.auth_account.name,
          'eosdactokens',
          { contract: shared.dac_token_contract.account.name, sym: '4,DAO' },
          'dactitle',
          [],
          [],
          {
            from: shared.auth_account,
          }
        ),
        'ERR::DAC_FORBIDDEN_NAME'
      );
    });
    it('Should fail for a dac id with `.`', async () => {
      await l.assertEOSErrorIncludesMessage(
        shared.dacdirectory_contract.regdac(
          shared.auth_account.name,
          'ot.herdac',
          { contract: shared.dac_token_contract.account.name, sym: '4,DAO' },
          'dactitle',
          [],
          [],
          {
            from: shared.auth_account,
          }
        ),
        'ERR::DAC_ID_DOTS'
      );
    });
    it('Should fail for a dac id less than 5 characters', async () => {
      await l.assertEOSErrorIncludesMessage(
        shared.dacdirectory_contract.regdac(
          shared.auth_account.name,
          'othe',
          { contract: shared.dac_token_contract.account.name, sym: '4,DAO' },
          'dactitle',
          [],
          [],
          {
            from: shared.auth_account,
          }
        ),
        'ERR::DAC_ID_SHORT'
      );
    });
    it('Should fail if auth account is included with auth permission', async () => {
      await l.assertEOSErrorIncludesMessage(
        shared.dacdirectory_contract.regdac(
          shared.auth_account.name,
          'othe',
          { contract: shared.dac_token_contract.account.name, sym: '4,DAO' },
          'dactitle',
          [],
          [],
          {
            from: shared.auth_account,
          }
        ),
        'ERR::DAC_ID_SHORT'
      );
    });
    it('Should succeed for a new token', async () => {
      await shared.dacdirectory_contract.regdac(
        shared.auth_account.name,
        'legaldacid',
        { contract: shared.dac_token_contract.account.name, sym: '4,DAO' },
        'dactitle',
        [],
        [],
        {
          from: shared.auth_account,
        }
      );

      let result = await shared.dacdirectory_contract.dacsTable({
        scope: shared.dacdirectory_contract.account.name,
        lowerBound: 'legaldacid',
        limit: 1,
      });
      let dac = result.rows[0];
      chai.expect(dac.accounts).to.be.empty;
      chai.expect(dac.refs).to.be.empty;
      chai.expect(dac.dac_id).to.equal(legaldacid);
      chai.expect(dac.dac_state).to.equal(0);
      chai.expect(dac.owner).to.equal(shared.auth_account.name);
      chai
        .expect(dac.symbol.contract)
        .to.equal(shared.dac_token_contract.account.name);
      chai.expect(dac.symbol.sym).to.equal('4,DAO');
      chai.expect(dac.title).to.equal('dactitle');
    });
    it('Should fail for a token that already has a DAC', async () => {
      await shared.dacdirectory_contract.regdac(
        shared.auth_account.name,
        legaldacid,
        { contract: shared.dac_token_contract.account.name, sym: '4,DAO' },
        'dactitle',
        [],
        [],
        {
          from: shared.auth_account,
        }
      );

      await l.assertEOSErrorIncludesMessage(
        shared.dacdirectory_contract.regdac(
          shared.auth_account.name,
          'otherdac',
          { contract: shared.dac_token_contract.account.name, sym: '4,DAO' },
          'dactitle',
          [],
          [],
          {
            from: shared.auth_account,
          }
        ),
        'ERR::DAC_EXISTS_SYMBOL'
      );
    });
    it('Should fail if owner already owns a dac', async () => {
      await l.assertEOSErrorIncludesMessage(
        shared.dacdirectory_contract.regdac(
          shared.auth_account.name,
          'fjkds',
          { contract: shared.dac_token_contract.account.name, sym: '4,DAOY' },
          'dactitle',
          [],
          [],
          {
            from: shared.auth_account,
          }
        ),
        'already owns a dac'
      );
    });
  });
});
