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

  auth_account: Account;
  treasury_account: Account;
  // === Dac Contracts
  dacdirectory_contract: Dacdirectory;
  daccustodian_contract: Daccustodian;
  dac_token_contract: Eosdactokens;
  dacproposals_contract: Dacproposals;
  dacescrow_contract: Dacescrow;
  // === Shared Values
  configured_dac_memberterms: string;

  static async getInstance(): Promise<SharedTestObjects> {
    if (!SharedTestObjects.instance) {
      SharedTestObjects.instance = new SharedTestObjects();
      await SharedTestObjects.instance.initAndGetSharedObjects();
    }
    return SharedTestObjects.instance;
  }

  private async initAndGetSharedObjects() {
    console.log('init eos blockchain');
    await sleep(4500);
    EOSManager.initWithDefaults();
    // console.log('after init eos blockchain');

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
    this.daccustodian_contract = await debugPromise(
      ContractDeployer.deployWithName(
        'daccustodian/daccustodian',
        'daccustodian'
      ),
      'created daccustodian'
    );
    this.dac_token_contract = await debugPromise(
      ContractDeployer.deployWithName(
        'eosdactokens/eosdactokens',
        'eosdactokens'
      ),
      'created eosdactokens'
    );
    this.dacproposals_contract = await debugPromise(
      ContractDeployer.deployWithName(
        'dacproposals/dacproposals',
        'dacproposals'
      ),
      'created dacproposals'
    );
    this.dacescrow_contract = await debugPromise(
      ContractDeployer.deployWithName('dacescrow/dacescrow', 'dacescrow'),
      'created dacescrow'
    );
    // Other objects
    this.configured_dac_memberterms = 'AgreedMemberTermsHashValue';
    await this.add_token_contract_permissions();
  }

  async initDac(dacId: string, symbol: string, initialAsset: string) {
    // Further setup after the inital singleton object have been created.
    await this.setup_tokens(initialAsset);
    await this.register_dac_with_directory(dacId, symbol);
    await this.setup_dac_memberterms(dacId, this.auth_account);
  }

  async updateconfig(dacId: string, lockupAsset: string) {
    await this.daccustodian_contract.updateconfige(
      {
        numelected: 5,
        maxvotes: 4,
        requested_pay_max: {
          contract: 'eosio.token',
          quantity: '30.0000 EOS',
        },
        periodlength: 5,
        initial_vote_quorum_percent: 31,
        vote_quorum_percent: 15,
        auth_threshold_high: 4,
        auth_threshold_mid: 3,
        auth_threshold_low: 2,
        lockupasset: {
          contract: this.dac_token_contract.account.name,
          quantity: lockupAsset,
        },
        should_pay_via_service_provider: true,
        lockup_release_time_delay: 1233,
      },
      dacId,
      { from: this.auth_account }
    );
  }

  async getRegMembers(
    dacId: string,
    initialDacAsset: string,
    count: number = NUMBER_OF_REG_MEMBERS
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

  async getStakeObservedCandidates(
    dacId: string,
    dacStakeAsset: string,
    count: number = NUMBER_OF_CANDIDATES
  ): Promise<Account[]> {
    let newCandidates = await this.getRegMembers(dacId, dacStakeAsset, count);
    for (let { candidate, index } of newCandidates.map((candidate, index) => ({
      candidate,
      index,
    }))) {
      await debugPromise(
        this.dac_token_contract.stake(candidate.name, dacStakeAsset, {
          from: candidate,
        }),
        'staking for candidate'
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
          dacId,
          {
            from: candidate,
          }
        ),
        'nominate candidate'
      );
    }
    return newCandidates;
  }

  async configureCustodianConfig(lockupAsset: string, dacId: string) {
    await this.daccustodian_contract.updateconfige(
      {
        numelected: 5,
        maxvotes: 4,
        requested_pay_max: {
          contract: 'eosio.token',
          quantity: '30.0000 EOS',
        },
        periodlength: 5,
        initial_vote_quorum_percent: 31,
        vote_quorum_percent: 15,
        auth_threshold_high: 4,
        auth_threshold_mid: 3,
        auth_threshold_low: 2,
        lockupasset: {
          contract: this.dac_token_contract.account.name,
          quantity: lockupAsset,
        },
        should_pay_via_service_provider: true,
        lockup_release_time_delay: 1233,
      },
      dacId,
      { from: this.auth_account }
    );
  }

  private async setup_tokens(initialAsset: string) {
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

  // tokenSymbol is the symbol in this format: '4,EOSDAC'
  private async register_dac_with_directory(
    dacId: string,
    tokenSymbol: string
  ) {
    await this.dacdirectory_contract.regdac(
      this.auth_account.name,
      dacId,
      {
        contract: this.dac_token_contract.account.name,
        symbol: tokenSymbol,
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
      {
        account: 'eosio',
        name: 'updateauth',
        authorization: this.dacescrow_contract.account.owner,
        data: {
          account: this.dacescrow_contract.account.name,
          permission: 'active',
          parent: 'owner',
          auth: eosio_dot_code_perm(this.dacescrow_contract.account),
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
          code: this.dacescrow_contract.account.name,
          type: 'approve',
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

  async voteForCustodians(
    regMembers: Account[],
    electedCandidates: Account[],
    dacId: string
  ) {
    // Running 2 loops through different sections of members to spread 4 votes each over at least 5 candidates.

    for (let index = 0; index < 8; index++) {
      const mbr = regMembers[index];
      await debugPromise(
        this.daccustodian_contract.votecuste(
          mbr.name,
          [
            electedCandidates[0].name,
            electedCandidates[1].name,
            electedCandidates[2].name,
            electedCandidates[3].name,
          ],
          dacId,
          { from: mbr }
        ),
        'voting custodian for new period'
      );
    }
    for (let index = 8; index < 16; index++) {
      const mbr = regMembers[index];
      await debugPromise(
        this.daccustodian_contract.votecuste(
          mbr.name,
          [
            electedCandidates[0].name,
            electedCandidates[1].name,
            electedCandidates[2].name,
            electedCandidates[4].name,
          ],
          dacId,
          { from: mbr }
        ),
        'voting custodian for new period'
      );
    }
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
