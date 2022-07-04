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
  it('convert1 should throw conversion overflow error', async () => {
    await assertEOSErrorIncludesMessage(
      contract.convert1(),
      'conversion overflow'
    );
  });
  it('convert2 should throw Cannot convert negative value to unsigned error', async () => {
    await assertEOSErrorIncludesMessage(
      contract.convert2(),
      'Cannot convert negative value to unsigned'
    );
  });
  it('convert3 should throw conversion overflow error', async () => {
    await assertEOSErrorIncludesMessage(
      contract.convert3(),
      'conversion overflow'
    );
  });
  it('convert4 should throw conversion overflow error', async () => {
    await assertEOSErrorIncludesMessage(
      contract.convert4(),
      'conversion overflow'
    );
  });
  it('xxx1 should throw conversion overflow error', async () => {
    await assertEOSErrorIncludesMessage(
      contract.xxx1(),
      'invalid unsigned subtraction'
    );
  });
  it('xxx2 should work', async () => {
    await contract.xxx2();
  });
  it('xxx3 should work', async () => {
    await contract.xxx3();
  });
  it('xxx4 should throw signed subtraction underflow error', async () => {
    await assertEOSErrorIncludesMessage(
      contract.xxx4(),
      'signed subtraction underflow'
    );
  });
  it('xxx5 should throw signed subtraction underflow error', async () => {
    await assertEOSErrorIncludesMessage(
      contract.xxx5(),
      'signed subtraction overflow'
    );
  });
  it('yyy1 should throw overflow error', async () => {
    await assertEOSErrorIncludesMessage(contract.yyy1(), 'overflow');
  });
  it('yyy2 should throw overflow error', async () => {
    await assertEOSErrorIncludesMessage(
      contract.yyy2(),
      'invalid unsigned subtraction'
    );
  });
});
