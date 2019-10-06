import { Account, AccountManager, ContractDeployer, nextBlock, sleep, EOSManager, generateTypes } from 'lamington';

import { EosioToken } from './external_contracts/eosio.token/eosio.token';

// Dac contracts
import { Dacdirectory } from './dacdirectory/dacdirectory';
import { Daccustodian } from './daccustodian/daccustodian';
import { Eosdactokens } from './eosdactokens/eosdactokens';
// import { Dacescrow } from "./dacescrow/dacescrow";
// import { Dacmultisigs } from "./dacmultisigs/dacmultisigs";
// import { Dacproposals } from "./dacproposals/dacproposals";

import * as fs from 'fs';
import * as path from 'path';

// Shared Instances to use between tests.
let shared: SharedTestObjects;

let _regmembers: Account[];
let _candidates: Account[];

export interface SharedTestObjects {
  readonly dac_token_account: Account;
  readonly auth_account: Account;
  readonly daccustodian_account: Account;
  readonly directory_account: Account;
  readonly treasury_account: Account;
  readonly eosio_token_account: Account;
  // === Dac Contracts
  readonly dacdirectory_contract: Dacdirectory;
  readonly daccustodian_contract: Daccustodian;
  readonly dac_token_contract: Eosdactokens;
  readonly eosio_token_contract: EosioToken;
  // === Shared Values
  readonly dac_owner: Account;
  readonly configured_dac_id: string;
  readonly configured_dac_memberterms: string;
  // readonly regmembers: Array<Account>;
}

let sharedTestObjectsSemaphore = false;
export async function initAndGetSharedObjects(): Promise<SharedTestObjects> {
  if (!shared && !sharedTestObjectsSemaphore) {
    sharedTestObjectsSemaphore = true;
    await EOSManager.initWithDefaults();
    await sleep(1500);
    let token_account = await new_account('eodactoken');
    let auth_account = await new_account('eosdacauth');
    let custodian_account = await new_account('daccustodian');
    let directory_account = await new_account('dacdirectory');
    let treasury_account = await new_account('treasury');
    let eosio_token_account = await new_account('eosio.token');

    shared = {
      dac_token_account: token_account,
      auth_account: auth_account,
      daccustodian_account: custodian_account,
      directory_account: directory_account,
      treasury_account: treasury_account,
      eosio_token_account: eosio_token_account,
      // Configure Dac contracts
      dacdirectory_contract: await ContractDeployer.deployToAccount('dacdirectory/dacdirectory', directory_account),
      daccustodian_contract: await ContractDeployer.deployToAccount('daccustodian/daccustodian', custodian_account),
      dac_token_contract: await ContractDeployer.deployToAccount('eosdactokens/eosdactokens', token_account),
      eosio_token_contract: await ContractDeployer.deployToAccount('external_contracts/eosio.token/eosio.token', eosio_token_account),
      // Other objects
      dac_owner: await AccountManager.createAccount(),
      configured_dac_id: 'eosdacio',
      configured_dac_memberterms: 'AgreedMemberTermsHashValue'
    };
    // Further setup after the inital singleton object have been created.
    // nextBlock();
    await setup_tokens();
    await add_token_contract_permissions();
    await register_dac_with_directory();
    await setup_dac_memberterms();
  }
  return shared;
}

export async function regmembers(): Promise<Account[]> {
  return _regmembers || (_regmembers = await getRegMembers(5)) ? _regmembers : Promise.reject('Error occurred!!!');
}

async function getRegMembers(count: number): Promise<Account[]> {
  let newMembers = await AccountManager.createAccounts(count);
  for (const account of newMembers) {
    await shared.dac_token_contract
      .memberrege(account.name, shared.configured_dac_memberterms, shared.configured_dac_id, { from: account })
      // .then(value => {
      //   console.log('memberrege in getRegMembers : ' + value);
      // })
      .catch(rejectedReason => {
        console.error('memberrege in getRegMembers failed: ', rejectedReason);
      });

    await shared.dac_token_contract
      .transfer(shared.dac_token_account.name, account.name, '2000.0000 EOSDAC', '', { from: shared.dac_token_account })
      // .then(value => {
      //   console.log('transfer 2000 to member : ' + JSON.stringify(value));
      // })
      .catch(rejectedReason => {
        console.error('newMember failed druing transfer: ', rejectedReason);
      });
  }

  return newMembers;
}

export async function candidates(): Promise<Account[]> {
  return _candidates || (_candidates = await getCandidates(6)) ? _candidates : Promise.reject('Error occurred!!!');
}

async function getCandidates(count: number): Promise<Account[]> {
  let newCandidates = await getRegMembers(count);
  for (let candidate of newCandidates) {
    await shared.dac_token_contract.transfer(candidate.name, shared.daccustodian_account.name, '12.0000 EOSDAC', '', { from: candidate }).catch(rejectedReason => {
      console.error('candidate failed to transfer: ', rejectedReason);
    });
    await shared.daccustodian_contract.nominatecane(candidate.name, '25.0000 EOS', shared.configured_dac_id, { from: candidate }).catch(rejectedReason => {
      console.error('candidate failed to nominate: ', rejectedReason);
    });
  }
  return newCandidates;
}

async function setup_tokens() {
  await shared.eosio_token_contract.create(shared.eosio_token_account.name, '10000000000.0000 EOS', { from: shared.eosio_token_account });
  await shared.eosio_token_contract.issue(shared.eosio_token_account.name, '100000000.0000 EOS', 'Initial Token holder', { from: shared.eosio_token_account });

  await shared.dac_token_contract.create(shared.dac_token_account.name, '10000000000.0000 EOSDAC', false, { from: shared.dac_token_account });
  await shared.dac_token_contract.issue(shared.dac_token_account.name, '100000000.0000 EOSDAC', 'Initial Token holder', { from: shared.dac_token_account });
  // await shared.dac_token_contract.accountsTable({ scope: shared.dac_token_account.name }).then(value => {
  //   console.log('dac token balance : ' + JSON.stringify(value));
  // });
}

// Not used for now but could be useful later
async function setup_external(name: string) {
  const compiled_dir = path.normalize(`${__dirname}/../.lamington/compiled_contracts/${name}`);

  if (!fs.existsSync(compiled_dir)) {
    fs.mkdirSync(compiled_dir);
  }

  fs.copyFileSync(`${__dirname}/external_contracts/${name}.wasm`, `${compiled_dir}/${name}.wasm`);
  fs.copyFileSync(`${__dirname}/external_contracts/${name}.abi`, `${compiled_dir}/${name}.abi`);

  await generateTypes(`contracts/external_contracts/${name}/${name}`);
}

export async function new_account(name: string) {
  const act = new Account(name, '5KQwrPbwdL6PhXujxW37FSSQZ1JiwsST4cqQzDeyXtP79zkvFD3');
  await AccountManager.setupAccount(act);
  await EOSManager.addSigningAccountIfMissing(act);
  return act;
}

export function eosio_dot_code_perm(account: Account): any {
  return {
    threshold: 1,
    accounts: [
      {
        permission: { actor: account.name, permission: 'eosio.code' },
        weight: 1
      }
    ],
    keys: [],
    waits: []
  };
}

async function register_dac_with_directory() {
  await shared.dacdirectory_contract.regdac(
    shared.auth_account.name,
    shared.configured_dac_id,
    { contract: shared.dac_token_account.name, symbol: '4,EOSDAC' },
    'dac_title',
    [],
    [{ key: Account_type.AUTH, value: shared.auth_account.name }, { key: Account_type.CUSTODIAN, value: shared.daccustodian_account.name }],
    {
      auths: [{ actor: shared.auth_account.name, permission: 'active' }]
    }
  );
}

async function add_token_contract_permissions() {
  // Construct the update actions
  const actions: any = [
    // Add the issue permission as a child of active to dac_token
    {
      account: 'eosio',
      name: 'updateauth',
      authorization: shared.dac_token_account.active,
      data: {
        account: shared.dac_token_account.name,
        permission: 'issue',
        parent: 'active',
        auth: eosio_dot_code_perm(shared.dac_token_account)
      }
    },
    // Add the notify permission as a child of active to dac_token
    {
      account: 'eosio',
      name: 'updateauth',
      authorization: shared.dac_token_account.active,
      data: {
        account: shared.dac_token_account.name,
        permission: 'notify',
        parent: 'active',
        auth: eosio_dot_code_perm(shared.dac_token_account)
      }
    },
    // Add the xfer permission as a child of active to provided account
    {
      account: 'eosio',
      name: 'updateauth',
      authorization: shared.dac_token_account.active,
      data: {
        account: shared.dac_token_account.name,
        permission: 'xfer',
        parent: 'active',
        auth: eosio_dot_code_perm(shared.dac_token_account)
      }
    }
  ];
  const link_actions: any = [
    // Link issue permission of account to the issue action of account.
    {
      account: 'eosio',
      name: 'linkauth',
      authorization: shared.dac_token_account.active,
      data: {
        account: shared.dac_token_account.name,
        code: shared.dac_token_account.name,
        type: 'issue',
        requirement: 'issue'
      }
    },
    // Link the notify permission of account to the weightobsv action of custodian
    {
      account: 'eosio',
      name: 'linkauth',
      authorization: shared.dac_token_account.active,
      data: {
        account: shared.dac_token_account.name,
        code: shared.daccustodian_account.name,
        type: 'weightobsv',
        requirement: 'notify'
      }
    },
    // Link the notify permission of account to the stakeobsv action of custodian
    {
      account: 'eosio',
      name: 'linkauth',
      authorization: shared.dac_token_account.active,
      data: {
        account: shared.dac_token_account.name,
        code: shared.daccustodian_account.name,
        type: 'stakeobsv',
        requirement: 'notify'
      }
    },
    // Link the notify permission of account to the refund action of dac token
    {
      account: 'eosio',
      name: 'linkauth',
      authorization: shared.dac_token_account.active,
      data: {
        account: shared.dac_token_account.name,
        code: shared.dac_token_account.name,
        type: 'refund',
        requirement: 'notify'
      }
    },
    // Link the notify permission of dac_token to the balanceobsv action of voting.
    {
      account: 'eosio',
      name: 'linkauth',
      authorization: shared.dac_token_account.active,
      data: {
        account: shared.dac_token_account.name,
        code: shared.daccustodian_account.name, // or should be voting account
        type: 'balanceobsv',
        requirement: 'notify'
      }
    },
    {
      account: 'eosio',
      name: 'linkauth',
      authorization: shared.dac_token_account.active,
      data: {
        account: shared.dac_token_account.name,
        code: shared.daccustodian_account.name, // or should be voting account
        type: 'capturestake',
        requirement: 'notify'
      }
    },
    // Link the xfer permission of account to the transfer action of account.
    {
      account: 'eosio',
      name: 'linkauth',
      authorization: shared.dac_token_account.active,
      data: {
        account: shared.dac_token_account.name,
        code: shared.dac_token_account.name,
        type: 'transfer',
        requirement: 'xfer'
      }
    }
  ];
  // Execute the transaction actions
  await EOSManager.transact({ actions });
  await EOSManager.transact({ actions: link_actions });
  nextBlock();
}

async function setup_dac_memberterms() {
  await shared.dac_token_contract.newmemtermse('teermsstring', shared.configured_dac_memberterms, shared.configured_dac_id, { from: shared.auth_account }).then(value => {
    console.log('setting member terms: ' + JSON.stringify(value));
  });
}

export enum Account_type {
  AUTH = 0,
  TREASURY = 1,
  CUSTODIAN = 2,
  MSIGS = 3,
  SERVICE = 5,
  PROPOSALS = 6,
  ESCROW = 7,
  VOTING = 8,
  EXTERNAL = 254,
  OTHER = 255
}

enum ref_type {
  HOMEPAGE = 0,
  LOGO_URL = 1,
  DESCRIPTION = 2,
  LOGO_NOTEXT_URL = 3,
  BACKGROUND_URL = 4,
  COLORS = 5,
  CLIENT_EXTENSION = 6
}

enum dac_state_type {
  dac_state_typeINACTIVE = 0,
  dac_state_typeACTIVE = 1
}
