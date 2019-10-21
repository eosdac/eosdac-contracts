import * as l from 'lamington';

import { SharedTestObjects, initAndGetSharedObjects } from '../TestHelpers';

describe('Dacdirectory', () => {
  let shared: SharedTestObjects;
  let legaldacid = 'legaldacid';

  before(async () => {
    shared = await initAndGetSharedObjects();
  });

  context('regdac', async () => {
    it('Should fail with `admin` for `dac_id`', async () => {
      await l.assertEOSErrorIncludesMessage(
        shared.dacdirectory_contract.regdac(shared.dac_owner.name, 'admin', { contract: shared.dac_token_contract.account.name, symbol: '4,DAO' }, 'dactitle', [], [], {
          from: shared.dac_owner
        }),
        'ERR::DAC_FORBIDDEN_NAME::DAC ID is forbid'
      );
    });
    it('Should fail with `builder` for `dac_id`', async () => {
      await l.assertEOSErrorIncludesMessage(
        shared.dacdirectory_contract.regdac(shared.dac_owner.name, 'builder', { contract: shared.dac_token_contract.account.name, symbol: '4,DAO' }, 'dactitle', [], [], {
          from: shared.dac_owner
        }),
        'ERR::DAC_FORBIDDEN_NAME'
      );
    });
    it('Should fail with `members` for `dac_id`', async () => {
      await l.assertEOSErrorIncludesMessage(
        shared.dacdirectory_contract.regdac(shared.dac_owner.name, 'members', { contract: shared.dac_token_contract.account.name, symbol: '4,DAO' }, 'dactitle', [], [], {
          from: shared.dac_owner
        }),
        'ERR::DAC_FORBIDDEN_NAME'
      );
    });
    it('Should fail with `dacauthority` for `dac_id`', async () => {
      await l.assertEOSErrorIncludesMessage(
        shared.dacdirectory_contract.regdac(shared.dac_owner.name, 'dacauthority', { contract: shared.dac_token_contract.account.name, symbol: '4,DAO' }, 'dactitle', [], [], {
          from: shared.dac_owner
        }),
        'ERR::DAC_FORBIDDEN_NAME'
      );
    });
    it('Should fail with `daccustodian` for `dac_id`', async () => {
      await l.assertEOSErrorIncludesMessage(
        shared.dacdirectory_contract.regdac(shared.dac_owner.name, 'daccustodian', { contract: shared.dac_token_contract.account.name, symbol: '4,DAO' }, 'dactitle', [], [], {
          from: shared.dac_owner
        }),
        'ERR::DAC_FORBIDDEN_NAME'
      );
    });
    it('Should fail with `eosdactokens` for `dac_id`', async () => {
      await l.assertEOSErrorIncludesMessage(
        shared.dacdirectory_contract.regdac(shared.dac_owner.name, 'eosdactokens', { contract: shared.dac_token_contract.account.name, symbol: '4,DAO' }, 'dactitle', [], [], {
          from: shared.dac_owner
        }),
        'ERR::DAC_FORBIDDEN_NAME'
      );
    });
    it('Should fail for a dac id with `.`', async () => {
      await l.assertEOSErrorIncludesMessage(
        shared.dacdirectory_contract.regdac(shared.dac_owner.name, 'ot.herdac', { contract: shared.dac_token_contract.account.name, symbol: '4,DAO' }, 'dactitle', [], [], {
          from: shared.dac_owner
        }),
        'ERR::DAC_ID_DOTS'
      );
    });
    it('Should fail for a dac id less than 5 characters', async () => {
      await l.assertEOSErrorIncludesMessage(
        shared.dacdirectory_contract.regdac(shared.dac_owner.name, 'othe', { contract: shared.dac_token_contract.account.name, symbol: '4,DAO' }, 'dactitle', [], [], {
          from: shared.dac_owner
        }),
        'ERR::DAC_ID_SHORT'
      );
    });
    it('Should fail if auth account is included with auth permission', async () => {
      await l.assertEOSErrorIncludesMessage(
        shared.dacdirectory_contract.regdac(shared.dac_owner.name, 'othe', { contract: shared.dac_token_contract.account.name, symbol: '4,DAO' }, 'dactitle', [], [], {
          from: shared.dac_owner
        }),
        'ERR::DAC_ID_SHORT'
      );
    });
    it('Should succeed for a new token', async () => {
      await shared.dacdirectory_contract.regdac(shared.dac_owner.name, 'legaldacid', { contract: shared.dac_token_contract.account.name, symbol: '4,DAO' }, 'dactitle', [], [], {
        from: shared.dac_owner
      });

      await l.assertRowsEqual(shared.dacdirectory_contract.dacsTable({ scope: shared.dacdirectory_contract.account.name, lowerBound: 'legaldacid', limit: 1 }), [
        {
          accounts: [],
          dac_id: legaldacid,
          dac_state: 0,
          owner: shared.dac_owner.name,
          refs: [],
          symbol: {
            contract: shared.dac_token_contract.account.name,
            symbol: '4,DAO'
          },
          title: 'dactitle'
        }
      ]);
    });
    it('Should fail for a token that already has a DAC', async () => {
      await shared.dacdirectory_contract.regdac(shared.dac_owner.name, legaldacid, { contract: shared.dac_token_contract.account.name, symbol: '4,DAO' }, 'dactitle', [], [], {
        from: shared.dac_owner
      });

      await l.assertEOSErrorIncludesMessage(
        shared.dacdirectory_contract.regdac(shared.dac_owner.name, 'otherdac', { contract: shared.dac_token_contract.account.name, symbol: '4,DAO' }, 'dactitle', [], [], {
          from: shared.dac_owner
        }),
        'ERR::DAC_EXISTS_SYMBOL'
      );
    });
  });
});
