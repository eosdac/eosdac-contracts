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
  ContractDeployer,
} from 'lamington';

import * as chai from 'chai';

let contract;

describe('Safemath', () => {
  before(async () => {
    contract = await ContractDeployer.deployWithName(
      'contracts/safemath/safemath',
      'safemath'
    );
  });
  it('testuint should work', async () => {
    await contract.testuint();
  });
  it('testint should work', async () => {
    await contract.testint();
  });
  it('testfloat should work', async () => {
    await contract.testfloat();
  });
  it('smoverflow should throw multiplication overflow error', async () => {
    await assertEOSErrorIncludesMessage(
      contract.smoverflow(),
      'signed multiplication overflow'
    );
  });
  it('umoverflow should throw multiplication overflow error', async () => {
    await assertEOSErrorIncludesMessage(
      contract.umoverflow(),
      'unsigned multiplication overflow'
    );
  });
  it('aoverflow should throw addition overflow error', async () => {
    await assertEOSErrorIncludesMessage(
      contract.aoverflow(),
      'signed addition overflow'
    );
  });
  it('auoverflow should throw addition overflow error', async () => {
    await assertEOSErrorIncludesMessage(contract.auoverflow(), 'unsigned wrap');
  });
  it('uunderflow should throw invalid unsigned subtraction error', async () => {
    await assertEOSErrorIncludesMessage(
      contract.uunderflow(),
      'invalid unsigned subtraction: result would be negative'
    );
  });
  it('usdivzero should throw invalid unsigned subtraction error', async () => {
    await assertEOSErrorIncludesMessage(
      contract.usdivzero(),
      'division by zero'
    );
  });
  it('sdivzero should throw division by zero error', async () => {
    await assertEOSErrorIncludesMessage(
      contract.sdivzero(),
      'division by zero'
    );
  });
  it('fdivzero should throw division by zero error', async () => {
    await assertEOSErrorIncludesMessage(
      contract.fdivzero(),
      'division by zero'
    );
  });

  it('sdivoverflow should throw division by zero error', async () => {
    await assertEOSErrorIncludesMessage(
      contract.sdivoverflow(),
      'division overflow'
    );
  });
  it('infinity should infinity error', async () => {
    await assertEOSErrorIncludesMessage(contract.infinity(), 'infinity');
  });
  it('nan should throw NaN error', async () => {
    await assertEOSErrorIncludesMessage(contract.nan(), 'NaN');
  });
});
