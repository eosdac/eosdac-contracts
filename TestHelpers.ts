import {
  Account,
  AccountManager,
  ContractDeployer,
  nextBlock,
  sleep,
  EOSManager,
  generateTypes,
  Contract,
} from 'lamington';
import * as ecc from 'eosjs-ecc';

import { factory } from './LoggingConfig';

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

const log = factory.getLogger('TestHelper');

export async function debugPromise<T>(
  promise: Promise<T>,
  successMessage: string,
  errorMessage?: string
) {
  let successString = 'debugPromise - ' + successMessage + ': ';

  let errorString = errorMessage
    ? 'debugPromise - ' + errorMessage + ': '
    : 'debugPromise - error - ' + successMessage + ': ';

  return promise
    .then(value => {
      log.info(successString + JSON.stringify(value, null, 4));
      return value;
    })
    .catch(err => {
      log.error(errorString + err);
      return err;
    });
}
// Shared Instances to use between tests.
let shared: SharedTestObjects;

let _regmembers: Account[];
let _candidates: Account[];

export interface SharedTestObjects {
  readonly auth_account: Account;
  readonly treasury_account: Account;
  // === Dac Contracts
  readonly dacdirectory_contract: Dacdirectory;
  readonly daccustodian_contract: Daccustodian;
  readonly dac_token_contract: Eosdactokens;
  // === Shared Values
  readonly dac_owner: Account;
  readonly configured_dac_id: string;
  readonly configured_dac_memberterms: string;
  // readonly regmembers: Array<Account>;
}

let shouldAllowCreateTestObjects = true;
export async function initAndGetSharedObjects(): Promise<SharedTestObjects> {
  log.info('Called initAndGetSharedObjects');
  if (shouldAllowCreateTestObjects) {
    shouldAllowCreateTestObjects = false;

    // log.info('Getting passed the if block');
    await sleep(1500);
    EOSManager.initWithDefaults();
    let auth_account = await new_account('eosdacauth');

    log.info('auth_account: ' + JSON.stringify(auth_account, null, 4));

    let treasury_account = await new_account('treasury');

    let dacdirectory: Dacdirectory = await ContractDeployer.deployWithName(
      'dacdirectory/dacdirectory',
      'dacdirectory'
    );
    let daccustodian: Daccustodian = await ContractDeployer.deployWithName(
      'daccustodian/daccustodian',
      'daccustodian'
    );
    let token: Eosdactokens = await ContractDeployer.deployWithName(
      'eosdactokens/eosdactokens',
      'eosdactokens'
    );
    let dacowner = await AccountManager.createAccount();

    let tempSharedObjects: SharedTestObjects = {
      auth_account: auth_account,

      treasury_account: treasury_account,
      // Configure Dac contracts
      dacdirectory_contract: dacdirectory,
      daccustodian_contract: daccustodian,
      dac_token_contract: token,
      // Other objects
      dac_owner: dacowner,
      configured_dac_id: 'eosdacio',
      configured_dac_memberterms: 'AgreedMemberTermsHashValue',
    };
    // Further setup after the inital singleton object have been created.
    await setup_tokens(tempSharedObjects);
    await add_token_contract_permissions(tempSharedObjects);
    await register_dac_with_directory(tempSharedObjects);
    await setup_dac_memberterms(tempSharedObjects);
    log.info('returning new shared');
    shared = tempSharedObjects;
    return shared;
  } else if (shared) {
    log.info('returning existing shared');
    return shared;
  }
}

export async function regmembers(): Promise<Account[]> {
  return _regmembers || (_regmembers = await getRegMembers(5))
    ? _regmembers
    : Promise.reject('Error occurred!!!');
}

async function getRegMembers(count: number): Promise<Account[]> {
  let newMembers = await AccountManager.createAccounts(count);

  let termsPromises = newMembers
    .map(account => {
      return shared.dac_token_contract.memberrege(
        account.name,
        shared.configured_dac_memberterms,
        shared.configured_dac_id,
        { from: account }
      );
    })
    .concat(
      newMembers.map(account => {
        return shared.dac_token_contract.transfer(
          shared.dac_token_contract.account.name,
          account.name,
          '2000.0000 EOSDAC',
          '',
          { from: shared.dac_token_contract.account }
        );
      })
    );

  await Promise.all(termsPromises);
  return newMembers;
}

export async function candidates(): Promise<Account[]> {
  return _candidates || (_candidates = await getCandidates(6))
    ? _candidates
    : Promise.reject('Error occurred!!!');
}

async function getCandidates(count: number): Promise<Account[]> {
  let newCandidates = await getRegMembers(count);
  for (let candidate of newCandidates) {
    await shared.dac_token_contract
      .transfer(
        candidate.name,
        shared.daccustodian_contract.account.name,
        '12.0000 EOSDAC',
        '',
        { from: candidate }
      )
      .catch(rejectedReason => {
        console.error('candidate failed to transfer: ', rejectedReason);
      });
    await shared.daccustodian_contract
      .nominatecane(candidate.name, '25.0000 EOS', shared.configured_dac_id, {
        from: candidate,
      })
      .catch(rejectedReason => {
        console.error('candidate failed to nominate: ', rejectedReason);
      });
  }
  return newCandidates;
}

async function setup_tokens(tempSharedObjects: SharedTestObjects) {
  await tempSharedObjects.dac_token_contract.create(
    tempSharedObjects.dac_token_contract.account.name,
    '10000000000.0000 EOSDAC',
    false,
    { from: tempSharedObjects.dac_token_contract.account }
  );
  await tempSharedObjects.dac_token_contract.issue(
    tempSharedObjects.dac_token_contract.account.name,
    '100000000.0000 EOSDAC',
    'Initial Token holder',
    { from: tempSharedObjects.dac_token_contract.account }
  );
}

// Not used for now but could be useful later
async function setup_external(name: string) {
  const compiled_dir = path.normalize(
    `${__dirname}/../.lamington/compiled_contracts/${name}`
  );

  if (!fs.existsSync(compiled_dir)) {
    fs.mkdirSync(compiled_dir);
  }

  fs.copyFileSync(
    `${__dirname}/external_contracts/${name}.wasm`,
    `${compiled_dir}/${name}.wasm`
  );
  fs.copyFileSync(
    `${__dirname}/external_contracts/${name}.abi`,
    `${compiled_dir}/${name}.abi`
  );

  await generateTypes(`contracts/external_contracts/${name}/${name}`);
}

export async function new_account(name: string): Promise<Account> {
  log.info('About to create account: ' + name);
  const privateKey = await ecc.unsafeRandomKey();

  const account = new Account(name, privateKey);
  await AccountManager.setupAccount(account);
  return account;
}

export function eosio_dot_code_perm(account: Account): any {
  return {
    threshold: 1,
    accounts: [
      {
        permission: { actor: account.name, permission: 'eosio.code' },
        weight: 1,
      },
    ],
    keys: [],
    waits: [],
  };
}

async function register_dac_with_directory(
  tempSharedObjects: SharedTestObjects
) {
  await tempSharedObjects.dacdirectory_contract.regdac(
    tempSharedObjects.auth_account.name,
    tempSharedObjects.configured_dac_id,
    {
      contract: tempSharedObjects.dac_token_contract.account.name,
      symbol: '4,EOSDAC',
    },
    'dac_title',
    [],
    [
      { key: Account_type.AUTH, value: tempSharedObjects.auth_account.name },
      {
        key: Account_type.CUSTODIAN,
        value: tempSharedObjects.daccustodian_contract.account.name,
      },
    ],
    {
      auths: [
        { actor: tempSharedObjects.auth_account.name, permission: 'active' },
      ],
    }
  );
}

async function add_token_contract_permissions(
  tempSharedObjects: SharedTestObjects
) {
  // Construct the update actions
  const actions: any = [
    // Add the issue permission as a child of active to dac_token
    {
      account: 'eosio',
      name: 'updateauth',
      authorization: tempSharedObjects.dac_token_contract.account.active,
      data: {
        account: tempSharedObjects.dac_token_contract.account.name,
        permission: 'issue',
        parent: 'active',
        auth: eosio_dot_code_perm(tempSharedObjects.dac_token_contract.account),
      },
    },
    // Add the notify permission as a child of active to dac_token
    {
      account: 'eosio',
      name: 'updateauth',
      authorization: tempSharedObjects.dac_token_contract.account.active,
      data: {
        account: tempSharedObjects.dac_token_contract.account.name,
        permission: 'notify',
        parent: 'active',
        auth: eosio_dot_code_perm(tempSharedObjects.dac_token_contract.account),
      },
    },
    // Add the xfer permission as a child of active to provided account
    {
      account: 'eosio',
      name: 'updateauth',
      authorization: tempSharedObjects.dac_token_contract.account.active,
      data: {
        account: tempSharedObjects.dac_token_contract.account.name,
        permission: 'xfer',
        parent: 'active',
        auth: eosio_dot_code_perm(tempSharedObjects.dac_token_contract.account),
      },
    },
  ];
  const link_actions: any = [
    // Link issue permission of account to the issue action of account.
    {
      account: 'eosio',
      name: 'linkauth',
      authorization: tempSharedObjects.dac_token_contract.account.active,
      data: {
        account: tempSharedObjects.dac_token_contract.account.name,
        code: tempSharedObjects.dac_token_contract.account.name,
        type: 'issue',
        requirement: 'issue',
      },
    },
    // Link the notify permission of account to the weightobsv action of custodian
    {
      account: 'eosio',
      name: 'linkauth',
      authorization: tempSharedObjects.dac_token_contract.account.active,
      data: {
        account: tempSharedObjects.dac_token_contract.account.name,
        code: tempSharedObjects.daccustodian_contract.account.name,
        type: 'weightobsv',
        requirement: 'notify',
      },
    },
    // Link the notify permission of account to the stakeobsv action of custodian
    {
      account: 'eosio',
      name: 'linkauth',
      authorization: tempSharedObjects.dac_token_contract.account.active,
      data: {
        account: tempSharedObjects.dac_token_contract.account.name,
        code: tempSharedObjects.daccustodian_contract.account.name,
        type: 'stakeobsv',
        requirement: 'notify',
      },
    },
    // Link the notify permission of account to the refund action of dac token
    {
      account: 'eosio',
      name: 'linkauth',
      authorization: tempSharedObjects.dac_token_contract.account.active,
      data: {
        account: tempSharedObjects.dac_token_contract.account.name,
        code: tempSharedObjects.dac_token_contract.account.name,
        type: 'refund',
        requirement: 'notify',
      },
    },
    // Link the notify permission of dac_token to the balanceobsv action of voting.
    {
      account: 'eosio',
      name: 'linkauth',
      authorization: tempSharedObjects.dac_token_contract.account.active,
      data: {
        account: tempSharedObjects.dac_token_contract.account.name,
        code: tempSharedObjects.daccustodian_contract.account.name, // or should be voting account
        type: 'balanceobsv',
        requirement: 'notify',
      },
    },
    {
      account: 'eosio',
      name: 'linkauth',
      authorization: tempSharedObjects.dac_token_contract.account.active,
      data: {
        account: tempSharedObjects.dac_token_contract.account.name,
        code: tempSharedObjects.daccustodian_contract.account.name, // or should be voting account
        type: 'capturestake',
        requirement: 'notify',
      },
    },
    // Link the xfer permission of account to the transfer action of account.
    {
      account: 'eosio',
      name: 'linkauth',
      authorization: tempSharedObjects.dac_token_contract.account.active,
      data: {
        account: tempSharedObjects.dac_token_contract.account.name,
        code: tempSharedObjects.dac_token_contract.account.name,
        type: 'transfer',
        requirement: 'xfer',
      },
    },
  ];
  // Execute the transaction actions
  await debugPromise(
    EOSManager.transact({ actions }),
    'Add auth actions',
    'Add auth actions'
  );
  await debugPromise(
    EOSManager.transact({ actions: link_actions }),
    'Linking actions'
  );
}

async function setup_dac_memberterms(tempSharedObjects: SharedTestObjects) {
  await debugPromise(
    tempSharedObjects.dac_token_contract.newmemtermse(
      'teermsstring',
      tempSharedObjects.configured_dac_memberterms,
      tempSharedObjects.configured_dac_id,
      { from: tempSharedObjects.auth_account }
    ),
    'setting member terms'
  );
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
  OTHER = 255,
}

enum ref_type {
  HOMEPAGE = 0,
  LOGO_URL = 1,
  DESCRIPTION = 2,
  LOGO_NOTEXT_URL = 3,
  BACKGROUND_URL = 4,
  COLORS = 5,
  CLIENT_EXTENSION = 6,
}

enum dac_state_type {
  dac_state_typeINACTIVE = 0,
  dac_state_typeACTIVE = 1,
}
