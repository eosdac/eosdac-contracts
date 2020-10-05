import {
  Account,
  AccountManager,
  ContractDeployer,
  sleep,
  generateTypes,
  debugPromise,
  UpdateAuth,
  ContractLoader,
  EOSManager,
} from 'lamington';

// Dac contracts
import { Dacdirectory } from './dacdirectory/dacdirectory';
import { Daccustodian } from './daccustodian/daccustodian';
import { Eosdactokens } from './eosdactokens/eosdactokens';
// import { Dacmultisigs } from "./dacmultisigs/dacmultisigs";
import { Dacproposals } from './dacproposals/dacproposals';
import { Dacescrow } from './dacescrow/dacescrow';
import { EosioMsig } from '../external_contracts/eosio.msig/src/eosio.msig';
import { EosioToken } from '../external_contracts/eosio.token/eosio.token';

import * as fs from 'fs';
import * as path from 'path';
import { add_token_contract_permissions } from './UpdateAuths';

export var NUMBER_OF_REG_MEMBERS = 16;
export var NUMBER_OF_CANDIDATES = 7;

export type GetRegMembersOptions = {
  namePrefix?: string;
};

export class SharedTestObjects {
  // Shared Instances to use between tests.
  private static instance: SharedTestObjects;
  private constructor() {}

  auth_account: Account;
  treasury_account: Account;
  service_Account: Account;
  // === Dac Contracts
  dacdirectory_contract: Dacdirectory;
  daccustodian_contract: Daccustodian;
  dac_token_contract: Eosdactokens;
  dacproposals_contract: Dacproposals;
  dacescrow_contract: Dacescrow;
  // === System Contracts
  eosio_msig: EosioMsig;
  eosio_token: EosioToken;
  // === Shared Values
  configured_dac_memberterms: string;

  static async getInstance(): Promise<SharedTestObjects> {
    if (!SharedTestObjects.instance) {
      SharedTestObjects.instance = new SharedTestObjects();
      await SharedTestObjects.instance.initAndGetSharedObjects();
      await add_token_contract_permissions(SharedTestObjects.instance);
    }
    return SharedTestObjects.instance;
  }

  private async initAndGetSharedObjects() {
    console.log('Init eos blockchain');
    await sleep(500);
    EOSManager.initWithDefaults();
    await sleep(4500);

    this.auth_account = await debugPromise(
      AccountManager.createAccount('eosdacauth'),
      'create eosdacauth'
    );
    this.treasury_account = await debugPromise(
      AccountManager.createAccount('treasury'),
      'create treasury account'
    );
    this.service_Account = await debugPromise(
      AccountManager.createAccount('service'),
      'create service account'
    );
    // Deploy custom msig contract
    await debugPromise(
      ContractDeployer.deployToAccount(
        'external_contracts/eosio.msig/eosio.msig',
        new Account('eosio.msig')
      ),
      'deployed custom msig'
    );

    this.eosio_msig = await ContractLoader.at('eosio.msig');
    this.eosio_token = await ContractLoader.at('eosio.token');

    // Configure Dac contracts
    this.dacdirectory_contract = await ContractDeployer.deployWithName(
      'dac_contracts/dacdirectory/dacdirectory',
      'dacdirectory'
    );
    await sleep(1000);
    this.daccustodian_contract = await debugPromise(
      ContractDeployer.deployWithName(
        'dac_contracts/daccustodian/daccustodian',
        'daccustodian'
      ),
      'created daccustodian'
    );
    await sleep(1000);

    this.dac_token_contract = await debugPromise(
      ContractDeployer.deployWithName(
        'dac_contracts/eosdactokens/eosdactokens',
        'eosdactokens'
      ),
      'created eosdactokens'
    );
    await sleep(1000);

    this.dacproposals_contract = await debugPromise(
      ContractDeployer.deployWithName(
        'dac_contracts/dacproposals/dacproposals',
        'dacproposals'
      ),
      'created dacproposals'
    );
    this.dacescrow_contract = await debugPromise(
      ContractDeployer.deployWithName(
        'dac_contracts/dacescrow/dacescrow',
        'dacescrow'
      ),
      'created dacescrow'
    );

    // Other objects
    this.configured_dac_memberterms = 'AgreedMemberTermsHashValue';
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
    count: number = NUMBER_OF_REG_MEMBERS,
    options?: GetRegMembersOptions
  ): Promise<Account[]> {
    let _names: string[] = [];
    if (options && options.namePrefix) {
      for (let i = 0; i < count; i++) {
        _names.push(`${options.namePrefix}${i.toString(5)}`.replace('0', 'a'));
      }
    }
    let names = _names.length > 0 ? _names : null;
    let newMembers = await AccountManager.createAccounts(count, names, {
      privateKey: EOSManager.adminAccount.privateKey,
    });

    let termsPromises = newMembers
      .map((account) => {
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
        newMembers.map((account) => {
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
    count: number = NUMBER_OF_CANDIDATES,
    options?: GetRegMembersOptions
  ): Promise<Account[]> {
    let newCandidates = await this.getRegMembers(
      dacId,
      dacStakeAsset,
      count,
      options
    );
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
        { key: Account_type.SERVICE, value: this.service_Account.name },
      ],
      {
        auths: [
          { actor: this.auth_account.name, permission: 'active' },
          { actor: this.treasury_account.name, permission: 'active' },
        ],
      }
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
    `${__dirname}/../artifacts/compiled_contracts/${name}`
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
