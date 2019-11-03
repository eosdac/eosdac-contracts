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
// import { Dacmultisigs } from "./dacmultisigs/dacmultisigs";
// import { Dacproposals } from "./dacproposals/dacproposals";

import * as fs from 'fs';
import * as path from 'path';

const log = factory.getLogger('TestHelper');

export var NUMBER_OF_REG_MEMBERS = 16;
export var NUMBER_OF_CANDIDATES = 14;

export async function debugPromise<T>(
  promise: Promise<T>,
  successMessage: string,
  errorMessage?: string
) {
  let debugPrefix = 'debugPromise - ';
  let successString = debugPrefix + successMessage + ': ';

  let errorString = errorMessage
    ? debugPrefix + errorMessage + ': '
    : debugPrefix + 'error - ' + successMessage + ': ';

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
  readonly configured_dac_id: string;
  readonly configured_dac_memberterms: string;
  readonly eosiotoken_contract: EosioToken;
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
    let tempSharedObjects: SharedTestObjects = {
      auth_account: await new_account('eosdacauth'),

      treasury_account: await new_account('treasury'),
      // Configure Dac contracts
      dacdirectory_contract: await ContractDeployer.deployWithName(
        'dacdirectory/dacdirectory',
        'dacdirectory'
      ),
      daccustodian_contract: await ContractDeployer.deployWithName(
        'daccustodian/daccustodian',
        'daccustodian'
      ),
      dac_token_contract: await ContractDeployer.deployWithName(
        'eosdactokens/eosdactokens',
        'eosdactokens'
      ),
      // Other objects
      configured_dac_id: 'eosdacio',
      configured_dac_memberterms: 'AgreedMemberTermsHashValue',
      eosiotoken_contract: await ContractDeployer.deployWithName(
        './external_contracts/eosio.token/eosio.token',
        'eosio.token'
      ),
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
  return _regmembers ||
    (_regmembers = await getRegMembers(NUMBER_OF_REG_MEMBERS))
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

  await debugPromise(
    Promise.all(termsPromises),
    'running `getRegMembers`: ' + count
  );
  newMembers.forEach(member => {
    log.info('created member: ' + member.name);
  });
  return newMembers;
}

export async function candidates(): Promise<Account[]> {
  return _candidates ||
    (_candidates = await getCandidates(NUMBER_OF_CANDIDATES))
    ? _candidates
    : Promise.reject('Error occurred!!!');
}

async function getCandidates(count: number): Promise<Account[]> {
  let newCandidates = await getRegMembers(count);
  for (let { candidate, index } of newCandidates.map((candidate, index) => ({
    candidate,
    index,
  }))) {
    await debugPromise(
      shared.dac_token_contract.transfer(
        candidate.name,
        shared.daccustodian_contract.account.name,
        '12.0000 EOSDAC',
        '',
        {
          from: candidate,
        }
      ),
      'sending candidate funds for staking'
    );
    let indexOption = index % 3;
    let payAmount = '';
    if (indexOption == 0) {
      payAmount = '15.0000 EOS';
    } else if (indexOption == 1) {
      payAmount = '20.0000 EOS';
    } else {
      payAmount = '25.0000 EOS';
    }
    await debugPromise(
      shared.daccustodian_contract.nominatecane(
        candidate.name,
        payAmount,
        shared.configured_dac_id,
        {
          from: candidate,
        }
      ),
      'nominate candidate'
    );
  }
  return newCandidates;
}

async function setup_tokens(tempSharedObjects: SharedTestObjects) {
  await tempSharedObjects.dac_token_contract.create(
    tempSharedObjects.dac_token_contract.account.name,
    '100000.0000 EOSDAC',
    false,
    { from: tempSharedObjects.dac_token_contract.account }
  );
  await tempSharedObjects.dac_token_contract.issue(
    tempSharedObjects.dac_token_contract.account.name,
    '100000.0000 EOSDAC',
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

  await debugPromise(
    generateTypes(`contracts/external_contracts/${name}/${name}`),
    'generating types for external contract: ' + name
  );
}

export async function new_account(name: string): Promise<Account> {
  log.info('About to create account: ' + name);
  const privateKey = await ecc.unsafeRandomKey();

  const account = new Account(name, privateKey);
  await AccountManager.setupAccount(account);
  return account;
}

export function eosio_dot_code_perm(account: Account): any {
  return customAuthority(account, 'eosio.code');
}

export function customAuthority(account: Account, permission: string): any {
  return {
    threshold: 1,
    accounts: [
      {
        permission: { actor: account.name, permission: permission },
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
    {
      account: 'eosio',
      name: 'updateauth',
      authorization: tempSharedObjects.auth_account.owner,
      data: {
        account: tempSharedObjects.auth_account.name,
        permission: 'owner',
        parent: '',
        auth: eosio_dot_code_perm(
          tempSharedObjects.daccustodian_contract.account
        ),
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
  await debugPromise(EOSManager.transact({ actions }), 'Add auth actions');

  await EOSManager.transact({
    actions: [
      {
        account: 'eosio',
        name: 'updateauth',
        authorization: tempSharedObjects.auth_account.active,
        data: {
          account: tempSharedObjects.auth_account.name,
          permission: 'high',
          parent: 'active',
          auth: eosio_dot_code_perm(
            tempSharedObjects.daccustodian_contract.account
          ),
        },
      },
    ],
  });
  await EOSManager.transact({
    actions: [
      {
        account: 'eosio',
        name: 'updateauth',
        authorization: tempSharedObjects.auth_account.active,
        data: {
          account: tempSharedObjects.auth_account.name,
          permission: 'med',
          parent: 'high',
          auth: eosio_dot_code_perm(
            tempSharedObjects.daccustodian_contract.account
          ),
        },
      },
    ],
  });
  await EOSManager.transact({
    actions: [
      {
        account: 'eosio',
        name: 'updateauth',
        authorization: tempSharedObjects.auth_account.active,
        data: {
          account: tempSharedObjects.auth_account.name,
          permission: 'low',
          parent: 'med',
          auth: eosio_dot_code_perm(
            tempSharedObjects.daccustodian_contract.account
          ),
        },
      },
    ],
  });
  await EOSManager.transact({
    actions: [
      {
        account: 'eosio',
        name: 'updateauth',
        authorization: tempSharedObjects.auth_account.active,
        data: {
          account: tempSharedObjects.auth_account.name,
          permission: 'one',
          parent: 'low',
          auth: eosio_dot_code_perm(
            tempSharedObjects.daccustodian_contract.account
          ),
        },
      },
    ],
  });
  await EOSManager.transact({
    actions: [
      {
        account: 'eosio',
        name: 'updateauth',
        authorization: tempSharedObjects.auth_account.active,
        data: {
          account: tempSharedObjects.auth_account.name,
          permission: 'admin',
          parent: 'one',
          auth: eosio_dot_code_perm(
            tempSharedObjects.daccustodian_contract.account
          ),
        },
      },
    ],
  });

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
