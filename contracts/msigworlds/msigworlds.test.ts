import {
  ContractDeployer,
  assertRowsEqual,
  AccountManager,
  Account,
  assertRowCount,
  UpdateAuth,
  assertEOSErrorIncludesMessage,
  assertMissingAuthority,
} from 'lamington';
// import * as chai from 'chai';
// import * as chaiAsPromised from 'chai-as-promised';
// chai.use(chaiAsPromised);

import { Msigworlds } from './msigworlds';
import { EosioToken } from '../../external_contracts/eosio.token/eosio.token';

let landholders: Msigworlds;
let eosioToken: EosioToken;
let tokenIssuer: Account;
let owners: { [name: string]: Account } = {};

describe('msigworlds', () => {
  before(async () => {
    await seedAccounts();
    await configureAuths();
    await issueTokens();
  });
  context('with auth', async () => {
    it('should fail', async () => {
      assertEOSErrorIncludesMessage(
        landholders.cancel('prop1', owners['owner1'].name, 'dacid1'),
        'oh no!'
      );
    });
  });
});

async function configureAuths() {
  await UpdateAuth.execUpdateAuth(
    [{ actor: landholders.account.name, permission: 'active' }],
    landholders.account.name,
    'distribpay',
    'active',
    UpdateAuth.AuthorityToSet.forContractCode(landholders.account)
  );

  await UpdateAuth.execLinkAuth(
    landholders.account.active,
    landholders.account.name,
    eosioToken.account.name,
    'transfer',
    'distribpay'
  );
}

async function seedAccounts() {
  console.log('created first test account');

  landholders = await ContractDeployer.deployWithName<Msigworlds>(
    'contracts/msigworlds/msigworlds',
    'msigworlds'
  );
  console.log('set msig');

  eosioToken = await ContractDeployer.deployWithName<EosioToken>(
    'external_contracts/eosio.token/eosio.token',
    'alienworlds'
  );

  const names = ['owner1', 'owner2', 'owner3', 'owner4', 'owner5'];
  names.forEach(async (name) => {
    owners[name] = await AccountManager.createAccount(name);
  });
  console.log('created owners');
}

async function issueTokens() {
  tokenIssuer = await AccountManager.createAccount('tokenissuer');

  try {
    await eosioToken.create(tokenIssuer.name, '1000000000.0000 TLM', {
      from: eosioToken.account,
    });
    await eosioToken.issue(
      tokenIssuer.name,
      '10000000.0000 TLM',
      'initial deposit',
      {
        from: tokenIssuer,
      }
    );
  } catch (e) {
    if (e.json.error.what != 'eosio_assert_message assertion failure') {
      throw e;
    }
  }

  await eosioToken.transfer(
    tokenIssuer.name,
    landholders.account.name,
    '0.1000 TLM',
    'inital balance',
    { from: tokenIssuer }
  );
}
