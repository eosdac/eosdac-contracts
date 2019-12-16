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

// Dac contracts
import { Dacdirectory } from './dacdirectory/dacdirectory';
import { Daccustodian } from './daccustodian/daccustodian';
import { Eosdactokens } from './eosdactokens/eosdactokens';
// import { Dacmultisigs } from "./dacmultisigs/dacmultisigs";
import { Dacproposals } from './dacproposals/dacproposals';
import { Dacescrow } from './dacescrow/dacescrow';

import * as fs from 'fs';
import * as path from 'path';

const log = factory.getLogger('TestHelper');

export var NUMBER_OF_REG_MEMBERS = 16;
export var NUMBER_OF_CANDIDATES = 7;

export type Action = {
  account: string;
  name: string;
  authorization: { actor: string; permission: string }[];
  data: any;
};

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

export class SharedTestObjects {
  // Shared Instances to use between tests.
  private static instance: SharedTestObjects;
  private constructor() {}

  private _regmembers: Account[];
  private _candidates: Account[];

  auth_account: Account;
  treasury_account: Account;
  // === Dac Contracts
  dacdirectory_contract: Dacdirectory;
  daccustodian_contract: Daccustodian;
  dac_token_contract: Eosdactokens;
  dacproposals_contract: Dacproposals;
  dacescrow_contract: Dacescrow;
  // === Shared Values
  configured_dac_id: string;
  configured_dac_memberterms: string;

  static async getInstance(): Promise<SharedTestObjects> {
    if (!SharedTestObjects.instance) {
      SharedTestObjects.instance = new SharedTestObjects();
      await SharedTestObjects.instance.initAndGetSharedObjects();
    }
    return SharedTestObjects.instance;
  }

  private async initAndGetSharedObjects() {
    // await sleep(4500);
    EOSManager.initWithDefaults();
    await sleep(6000);

    this.auth_account = await debugPromise(
      new_account('eosdacauth'),
      'create eosdacauth'
    );
    this.treasury_account = await debugPromise(
      new_account('treasury'),
      'create treasury account'
    );

    // Configure Dac contracts
    this.dacdirectory_contract = await debugPromise(
      ContractDeployer.deployWithName(
        'dacdirectory/dacdirectory',
        'dacdirectory'
      ),
      'Created dadirecrtory'
    );
    this.daccustodian_contract = await await debugPromise(
      ContractDeployer.deployWithName(
        'daccustodian/daccustodian',
        'daccustodian'
      ),
      'created daccustodian'
    );
    this.dac_token_contract = await await debugPromise(
      ContractDeployer.deployWithName(
        'eosdactokens/eosdactokens',
        'eosdactokens'
      ),
      'created eosdactokens'
    );
    this.dacproposals_contract = await await debugPromise(
      ContractDeployer.deployWithName(
        'dacproposals/dacproposals',
        'dacproposals'
      ),
      'created dacproposals'
    );
    this.dacescrow_contract = await await debugPromise(
      ContractDeployer.deployWithName('dacescrow/dacescrow', 'dacescrow'),
      'created dacescrow'
    );
    // Other objects
    this.configured_dac_id = 'eosdacio';
    this.configured_dac_memberterms = 'AgreedMemberTermsHashValue';

    // Further setup after the inital singleton object have been created.
    await this.setup_tokens('100000.0000 EOSDAC');
    await this.add_token_contract_permissions();
    await this.register_dac_with_directory();
    await this.setup_dac_memberterms(this.configured_dac_id, this.auth_account);
  }

  async regMembers(): Promise<Account[]> {
    if (this._regmembers) {
      return this._regmembers;
    }
    this._regmembers = await this.getRegMembers(
      NUMBER_OF_REG_MEMBERS,
      this.configured_dac_id
    );
    return this._regmembers;
  }

  async candidates(): Promise<Account[]> {
    if (this._candidates) {
      return this._candidates;
    }
    this._candidates = await this.getCandidates(NUMBER_OF_CANDIDATES);

    return this._candidates;
  }

  async getRegMembers(
    count: number,
    dacId: string = this.configured_dac_id,
    initialDacAsset: string = '1000.0000 EOSDAC'
  ): Promise<Account[]> {
    let newMembers = await AccountManager.createAccounts(count);

    let termsPromises = newMembers
      .map(account => {
        return debugPromise(
          this.dac_token_contract.memberrege(
            account.name,
            this.configured_dac_memberterms,
            dacId,
            { from: account }
          ),
          'successfully registered member'
        );
      })
      .concat(
        newMembers.map(account => {
          return this.dac_token_contract.transfer(
            this.dac_token_contract.account.name,
            account.name,
            initialDacAsset,
            '',
            { from: this.dac_token_contract.account }
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

  async getCandidates(count: number): Promise<Account[]> {
    let newCandidates = await this.getRegMembers(count);
    for (let { candidate, index } of newCandidates.map((candidate, index) => ({
      candidate,
      index,
    }))) {
      await debugPromise(
        this.dac_token_contract.transfer(
          candidate.name,
          this.daccustodian_contract.account.name,
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
        this.daccustodian_contract.nominatecane(
          candidate.name,
          payAmount,
          this.configured_dac_id,
          {
            from: candidate,
          }
        ),
        'nominate candidate'
      );
    }
    return newCandidates;
  }

  async setup_tokens(initialAsset: string) {
    await this.dac_token_contract.create(
      this.dac_token_contract.account.name,
      initialAsset,
      false,
      { from: this.dac_token_contract.account }
    );
    await this.dac_token_contract.issue(
      this.dac_token_contract.account.name,
      initialAsset,
      'Initial Token holder',
      { from: this.dac_token_contract.account }
    );
  }

  private async register_dac_with_directory() {
    await this.dacdirectory_contract.regdac(
      this.auth_account.name,
      this.configured_dac_id,
      {
        contract: this.dac_token_contract.account.name,
        symbol: '4,EOSDAC',
      },
      'dac_title',
      [],
      [
        { key: Account_type.AUTH, value: this.auth_account.name },
        {
          key: Account_type.CUSTODIAN,
          value: this.daccustodian_contract.account.name,
        },
        {
          key: Account_type.ESCROW,
          value: this.dacescrow_contract.account.name,
        },
        {
          key: Account_type.TREASURY,
          value: this.treasury_account.name,
        },
        { key: Account_type.SERVICE, value: '' },
      ],
      {
        auths: [
          { actor: this.auth_account.name, permission: 'active' },
          { actor: this.treasury_account.name, permission: 'active' },
        ],
      }
    );
  }

  private async add_token_contract_permissions() {
    // Construct the update actions
    const actions: Action[] = [
      // Add the issue permission as a child of active to dac_token
      {
        account: 'eosio',
        name: 'updateauth',
        authorization: this.dac_token_contract.account.active,
        data: {
          account: this.dac_token_contract.account.name,
          permission: 'issue',
          parent: 'active',
          auth: eosio_dot_code_perm(this.dac_token_contract.account),
        },
      },
      // Add the notify permission as a child of active to dac_token
      {
        account: 'eosio',
        name: 'updateauth',
        authorization: this.dac_token_contract.account.active,
        data: {
          account: this.dac_token_contract.account.name,
          permission: 'notify',
          parent: 'active',
          auth: eosio_dot_code_perm(this.dac_token_contract.account),
        },
      },
      // Add the xfer permission as a child of active to provided account
      {
        account: 'eosio',
        name: 'updateauth',
        authorization: this.dac_token_contract.account.active,
        data: {
          account: this.dac_token_contract.account.name,
          permission: 'xfer',
          parent: 'active',
          auth: eosio_dot_code_perm(this.dac_token_contract.account),
        },
      },
      {
        account: 'eosio',
        name: 'updateauth',
        authorization: this.treasury_account.active,
        data: {
          account: this.treasury_account.name,
          permission: 'escrow',
          parent: 'active',
          auth: eosio_dot_code_perm(this.dacproposals_contract.account),
        },
      },
      {
        account: 'eosio',
        name: 'updateauth',
        authorization: this.treasury_account.active,
        data: {
          account: this.treasury_account.name,
          permission: 'xfer',
          parent: 'active',
          auth: eosio_dot_code_perm(this.dacproposals_contract.account),
        },
      },
      {
        account: 'eosio',
        name: 'updateauth',
        authorization: this.daccustodian_contract.account.active,
        data: {
          account: this.daccustodian_contract.account.name,
          permission: 'pay',
          parent: 'active',
          auth: eosio_dot_code_perm(this.daccustodian_contract.account),
        },
      },
      {
        account: 'eosio',
        name: 'updateauth',
        authorization: this.auth_account.owner,
        data: {
          account: this.auth_account.name,
          permission: 'owner',
          parent: '',
          auth: eosio_dot_code_perm(this.daccustodian_contract.account),
        },
      },
      {
        account: 'eosio',
        name: 'updateauth',
        authorization: this.daccustodian_contract.account.owner,
        data: {
          account: this.daccustodian_contract.account.name,
          permission: 'owner',
          parent: '',
          auth: singleAuthority(this.auth_account, 'active'),
        },
      },
      {
        account: 'eosio',
        name: 'updateauth',
        authorization: this.daccustodian_contract.account.owner,
        data: {
          account: this.daccustodian_contract.account.name,
          permission: 'active',
          parent: 'owner',
          auth: singleAuthority(this.auth_account, 'active'),
        },
      },
    ];
    const link_actions: Action[] = [
      // Link issue permission of account to the issue action of account.
      {
        account: 'eosio',
        name: 'linkauth',
        authorization: this.dac_token_contract.account.active,
        data: {
          account: this.dac_token_contract.account.name,
          code: this.dac_token_contract.account.name,
          type: 'issue',
          requirement: 'issue',
        },
      },
      // Link the notify permission of account to the weightobsv action of custodian
      {
        account: 'eosio',
        name: 'linkauth',
        authorization: this.dac_token_contract.account.active,
        data: {
          account: this.dac_token_contract.account.name,
          code: this.daccustodian_contract.account.name,
          type: 'weightobsv',
          requirement: 'notify',
        },
      },
      {
        account: 'eosio',
        name: 'linkauth',
        authorization: this.treasury_account.active,
        data: {
          account: this.treasury_account.name,
          code: this.dacescrow_contract.account.name,
          type: 'init',
          requirement: 'escrow',
        },
      },
      {
        account: 'eosio',
        name: 'linkauth',
        authorization: this.treasury_account.active,
        data: {
          account: this.treasury_account.name,
          code: 'eosio.token',
          type: 'transfer',
          requirement: 'xfer',
        },
      },
      // Link the notify permission of account to the stakeobsv action of custodian
      {
        account: 'eosio',
        name: 'linkauth',
        authorization: this.dac_token_contract.account.active,
        data: {
          account: this.dac_token_contract.account.name,
          code: this.daccustodian_contract.account.name,
          type: 'stakeobsv',
          requirement: 'notify',
        },
      },
      // Link the notify permission of account to the refund action of dac token
      {
        account: 'eosio',
        name: 'linkauth',
        authorization: this.dac_token_contract.account.active,
        data: {
          account: this.dac_token_contract.account.name,
          code: this.dac_token_contract.account.name,
          type: 'refund',
          requirement: 'notify',
        },
      },
      // Link the notify permission of dac_token to the balanceobsv action of voting.
      {
        account: 'eosio',
        name: 'linkauth',
        authorization: this.dac_token_contract.account.active,
        data: {
          account: this.dac_token_contract.account.name,
          code: this.daccustodian_contract.account.name, // or should be voting account
          type: 'balanceobsv',
          requirement: 'notify',
        },
      },
      {
        account: 'eosio',
        name: 'linkauth',
        authorization: this.dac_token_contract.account.active,
        data: {
          account: this.dac_token_contract.account.name,
          code: this.daccustodian_contract.account.name, // or should be voting account
          type: 'capturestake',
          requirement: 'notify',
        },
      },
      // Link the xfer permission of account to the transfer action of account.
      {
        account: 'eosio',
        name: 'linkauth',
        authorization: this.dac_token_contract.account.active,
        data: {
          account: this.dac_token_contract.account.name,
          code: this.dac_token_contract.account.name,
          type: 'transfer',
          requirement: 'xfer',
        },
      },
      // Link the xfer permission of account to the transfer action of account.
      {
        account: 'eosio',
        name: 'linkauth',
        authorization: this.daccustodian_contract.account.active,
        data: {
          account: this.daccustodian_contract.account.name,
          code: this.dac_token_contract.account.name,
          type: 'transfer',
          requirement: 'xfer',
        },
      },
      {
        account: 'eosio',
        name: 'linkauth',
        authorization: this.daccustodian_contract.account.active,
        data: {
          account: this.daccustodian_contract.account.name,
          code: this.daccustodian_contract.account.name,
          type: 'clearstake',
          requirement: 'pay',
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
          authorization: this.auth_account.active,
          data: {
            account: this.auth_account.name,
            permission: 'high',
            parent: 'active',
            auth: eosio_dot_code_perm(this.daccustodian_contract.account),
          },
        },
      ],
    });
    await EOSManager.transact({
      actions: [
        {
          account: 'eosio',
          name: 'updateauth',
          authorization: this.auth_account.active,
          data: {
            account: this.auth_account.name,
            permission: 'med',
            parent: 'high',
            auth: eosio_dot_code_perm(this.daccustodian_contract.account),
          },
        },
      ],
    });
    await EOSManager.transact({
      actions: [
        {
          account: 'eosio',
          name: 'updateauth',
          authorization: this.auth_account.active,
          data: {
            account: this.auth_account.name,
            permission: 'low',
            parent: 'med',
            auth: eosio_dot_code_perm(this.daccustodian_contract.account),
          },
        },
      ],
    });
    await EOSManager.transact({
      actions: [
        {
          account: 'eosio',
          name: 'updateauth',
          authorization: this.auth_account.active,
          data: {
            account: this.auth_account.name,
            permission: 'one',
            parent: 'low',
            auth: eosio_dot_code_perm(this.daccustodian_contract.account),
          },
        },
      ],
    });
    await EOSManager.transact({
      actions: [
        {
          account: 'eosio',
          name: 'updateauth',
          authorization: this.auth_account.active,
          data: {
            account: this.auth_account.name,
            permission: 'admin',
            parent: 'one',
            auth: eosio_dot_code_perm(this.daccustodian_contract.account),
          },
        },
      ],
    });
    await EOSManager.transact({
      actions: [
        {
          account: 'eosio',
          name: 'updateauth',
          authorization: this.daccustodian_contract.account.active,
          data: {
            account: this.daccustodian_contract.account.name,
            permission: 'xfer',
            parent: 'active',
            auth: authorities(
              [
                {
                  name: this.daccustodian_contract.account.name,
                  permission: 'eosio.code',
                  weight: 1,
                },
                {
                  name: this.auth_account.name,
                  permission: 'med',
                  weight: 1,
                },
              ],
              2
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

  async setup_dac_memberterms(dacId: string, dacAuth: Account) {
    await debugPromise(
      this.dac_token_contract.newmemtermse(
        'teermsstring',
        this.configured_dac_memberterms,
        dacId,
        { from: dacAuth }
      ),
      'setting member terms'
    );
  }
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
  return singleAuthority(account, 'eosio.code');
}
export interface PermissionLevelWeight {
  name: string;
  permission: string;
  weight: number;
}

export function singleAuthority(account: Account, permission: string): any {
  return authorities([
    { name: account.name, permission: permission, weight: 1 },
  ]);
}

export function authorities(
  permissionLevelWeights: PermissionLevelWeight[],
  threshold: number = 1
): any {
  return {
    threshold: threshold,
    accounts: permissionLevelWeights.map(permLevelWeight => {
      return {
        permission: {
          actor: permLevelWeight.name,
          permission: permLevelWeight.permission,
        },
        weight: permLevelWeight.weight,
      };
    }),
    keys: [],
    waits: [],
  };
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
