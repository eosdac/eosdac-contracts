import {
  Account,
  AccountManager,
  ContractDeployer,
  sleep,
  EOSManager,
  generateTypes,
  debugPromise,
} from 'lamington';
import * as ecc from 'eosjs-ecc';
import * as assert from 'assert';

// Dac contracts
import { Dacdirectory } from './dacdirectory/dacdirectory';
import { Daccustodian } from './daccustodian/daccustodian';
import { Eosdactokens } from './eosdactokens/eosdactokens';
// import { Dacmultisigs } from "./dacmultisigs/dacmultisigs";
import { Dacproposals } from './dacproposals/dacproposals';
import { Dacescrow } from './dacescrow/dacescrow';

import * as fs from 'fs';
import * as path from 'path';

export var NUMBER_OF_REG_MEMBERS = 16;
export var NUMBER_OF_CANDIDATES = 7;

export type EosioAction = {
  account: string;
  name: string;
  authorization: { actor: string; permission: string }[];
  data: any;
};

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
    console.log('Init eos blockchain');
    await sleep(4500);
    EOSManager.initWithDefaults();

    await sleep(1600);

    this.auth_account = await new_account('eosdacauth');
    this.treasury_account = await debugPromise(
      new_account('treasury'),
      'create treasury account'
    );

    // Configure Dac contracts
    this.dacdirectory_contract = await ContractDeployer.deployWithName(
      'dacdirectory/dacdirectory',
      'dacdirectory'
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
    await sleep(2000);
    this.dacescrow_contract = await debugPromise(
      ContractDeployer.deployWithName('dacescrow/dacescrow', 'dacescrow'),
      'created dacescrow'
    );
    await sleep(2000);

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
          `Registered member: ${account.name}`
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

  /**
   *
   * @param authorizations that would be permitted to perform this action on the account.
   * @param account The account on which the auth is to changed.
   * @param permission The name of the new permission to set on the account
   * @param parent The new permission should a child of the parent permission.
   * @param authToSet The auth to be set as the controller auth for the new permission
   */
  private async updateAuth(
    authorizations: Authorization[],
    account: string,
    permission: string,
    parent: string,
    authToSet: Authority
  ) {
    const actions: EosioAction[] = [
      {
        account: 'eosio',
        name: 'updateauth',
        authorization: authorizations,
        data: {
          account: account,
          permission: permission,
          parent: parent,
          auth: authToSet,
        },
      },
    ];
    await EOSManager.transact({ actions });
  }

  /**
   *
   * @param authorizations The authorizations allowed to make this change
   * @param account The account to make the changes on
   * @param code The contract that hold the action for the link_auth to be affected on
   * @param type The action that should linked to this auth
   * @param requirement The permission name that should now perform the action
   */
  private async linkAuth(
    authorizations: Authorization[],
    account: string,
    code: string,
    type: string,
    requirement: string
  ) {
    const actions: EosioAction[] = [
      {
        account: 'eosio',
        name: 'linkauth',
        authorization: authorizations,
        data: {
          account: account,
          code: code,
          type: type,
          requirement: requirement,
        },
      },
    ];
    await EOSManager.transact({ actions });
  }

  private async add_token_contract_permissions() {
    await debugPromise(
      this.updateAuth(
        this.dac_token_contract.account.active,
        this.dac_token_contract.account.name,
        'issue',
        'active',
        eosio_dot_code_perm(this.dac_token_contract.account)
      ),
      'add issue auth'
    );

    await debugPromise(
      this.updateAuth(
        this.dac_token_contract.account.active,
        this.dac_token_contract.account.name,
        'notify',
        'active',
        eosio_dot_code_perm(this.dac_token_contract.account)
      ),
      'add notify auth'
    );

    await debugPromise(
      this.updateAuth(
        this.dac_token_contract.account.active,
        this.dac_token_contract.account.name,
        'xfer',
        'active',
        eosio_dot_code_perm(this.dac_token_contract.account)
      ),
      'add xfer auth to eosdactoken'
    );

    await debugPromise(
      this.updateAuth(
        this.treasury_account.active,
        this.treasury_account.name,
        'escrow',
        'active',
        eosio_dot_code_perm(this.dacproposals_contract.account)
      ),
      'add escrow auth'
    );

    await debugPromise(
      this.updateAuth(
        this.treasury_account.active,
        this.treasury_account.name,
        'xfer',
        'active',
        eosio_dot_code_perm(this.dacproposals_contract.account)
      ),
      'add xfer to treasury'
    );

    await debugPromise(
      this.updateAuth(
        this.daccustodian_contract.account.active,
        this.daccustodian_contract.account.name,
        'pay',
        'active',
        eosio_dot_code_perm(this.dacproposals_contract.account)
      ),
      'add pay auth to daccustodian'
    );

    await debugPromise(
      this.updateAuth(
        this.auth_account.owner,
        this.auth_account.name,
        'high',
        'active',
        eosio_dot_code_perm(this.daccustodian_contract.account)
      ),
      'add high auth'
    );

    await debugPromise(
      this.updateAuth(
        this.auth_account.owner,
        this.auth_account.name,
        'owner',
        '',
        eosio_dot_code_perm(this.daccustodian_contract.account)
      ),
      'change owner of auth_account'
    );

    await debugPromise(
      this.updateAuth(
        this.daccustodian_contract.account.owner,
        this.daccustodian_contract.account.name,
        'owner',
        '',
        singleAuthority(this.auth_account, 'active')
      ),
      'changing owner of daccustodian'
    );

    await debugPromise(
      this.updateAuth(
        this.daccustodian_contract.account.owner,
        this.daccustodian_contract.account.name,
        'active',
        'owner',
        singleAuthority(this.auth_account, 'active')
      ),
      'change active of daccustodian'
    );

    await debugPromise(
      this.updateAuth(
        this.dacescrow_contract.account.owner,
        this.dacescrow_contract.account.name,
        'active',
        'owner',
        eosio_dot_code_perm(this.dacescrow_contract.account)
      ),
      'change active of escrow to daccustodian'
    );

    await debugPromise(
      this.updateAuth(
        this.dacproposals_contract.account.owner,
        this.dacproposals_contract.account.name,
        'active',
        'owner',
        eosio_dot_code_perm(this.dacproposals_contract.account)
      ),
      'change active of escrow to dacproposals'
    );

    await debugPromise(
      this.updateAuth(
        this.auth_account.active,
        this.auth_account.name,
        'med',
        'high',
        eosio_dot_code_perm(this.daccustodian_contract.account)
      ),
      'add med auth'
    );

    await debugPromise(
      this.updateAuth(
        this.auth_account.active,
        this.auth_account.name,
        'low',
        'med',
        eosio_dot_code_perm(this.daccustodian_contract.account)
      ),
      'add low auth'
    );

    await debugPromise(
      this.updateAuth(
        this.auth_account.active,
        this.auth_account.name,
        'one',
        'low',
        eosio_dot_code_perm(this.daccustodian_contract.account)
      ),
      'add one auth'
    );

    await debugPromise(
      this.updateAuth(
        this.auth_account.active,
        this.auth_account.name,
        'admin',
        'one',
        eosio_dot_code_perm(this.daccustodian_contract.account)
      ),
      'add admin auth'
    );

    await debugPromise(
      this.updateAuth(
        this.daccustodian_contract.account.active,
        this.daccustodian_contract.account.name,
        'xfer',
        'active',
        authorities(
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
        )
      ),
      'add xfer to daccustodian'
    );

    await this.linkAuth(
      this.dac_token_contract.account.active,
      this.dac_token_contract.account.name,
      this.dac_token_contract.account.name,
      'issue',
      'issue'
    );

    await this.linkAuth(
      this.dac_token_contract.account.active,
      this.dac_token_contract.account.name,
      this.dac_token_contract.account.name,
      'weightobsv',
      'notify'
    );

    await this.linkAuth(
      this.treasury_account.active,
      this.treasury_account.name,
      this.dacescrow_contract.account.name,
      'init',
      'escrow'
    );

    await debugPromise(
      this.linkAuth(
        this.treasury_account.active,
        this.treasury_account.name,
        this.dacescrow_contract.account.name,
        'approve',
        'escrow'
      ),
      'linking escrow perm to treasury'
    );

    await this.linkAuth(
      this.treasury_account.active,
      this.treasury_account.name,
      'eosio.token',
      'transfer',
      'xfer'
    );

    await this.linkAuth(
      this.dac_token_contract.account.active,
      this.dac_token_contract.account.name,
      this.daccustodian_contract.account.name,
      'stakeobsv',
      'notify'
    );

    await this.linkAuth(
      this.dac_token_contract.account.active,
      this.dac_token_contract.account.name,
      this.dac_token_contract.account.name,
      'refund',
      'notify'
    );

    await this.linkAuth(
      this.dac_token_contract.account.active,
      this.dac_token_contract.account.name,
      this.daccustodian_contract.account.name,
      'balanceobsv',
      'notify'
    );

    await this.linkAuth(
      this.dac_token_contract.account.active,
      this.dac_token_contract.account.name,
      this.daccustodian_contract.account.name,
      'capturestake',
      'notify'
    );

    await this.linkAuth(
      this.dac_token_contract.account.active,
      this.dac_token_contract.account.name,
      this.dac_token_contract.account.name,
      'transfer',
      'xfer'
    );

    await this.linkAuth(
      this.daccustodian_contract.account.active,
      this.daccustodian_contract.account.name,
      this.dac_token_contract.account.name,
      'transfer',
      'xfer'
    );

    await this.linkAuth(
      this.daccustodian_contract.account.active,
      this.daccustodian_contract.account.name,
      this.daccustodian_contract.account.name,
      'clearstake',
      'pay'
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
  const privateKey = await ecc.unsafeRandomKey();

  const account = new Account(name, privateKey);
  await debugPromise(
    AccountManager.setupAccount(account),
    `Create new account ${name}`
  );
  return account;
}

export function eosio_dot_code_perm(account: Account): Authority {
  return singleAuthority(account, 'eosio.code');
}
export interface PermissionLevelWeight {
  name: string;
  permission: string;
  weight: number;
}

export interface Authority {
  permissionLevelWeights: PermissionLevelWeight[];
  weight: number;
}

export interface Authorization {
  actor: string;
  permission: string;
}

export function singleAuthority(
  account: Account,
  permission: string
): Authority {
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
