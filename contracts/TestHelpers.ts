import {
  Account,
  AccountManager,
  EOSManager,
  ContractDeployer,
  sleep,
  generateTypes,
  debugPromise,
  UpdateAuth,
  Asset,
} from 'lamington';

// Dac contracts
import { Dacdirectory } from './dacdirectory/dacdirectory';
import { Daccustodian } from './daccustodian/daccustodian';
import { Eosdactokens } from './eosdactokens/eosdactokens';
import { Msigworlds } from './msigworlds/msigworlds';
import { Dacproposals } from './dacproposals/dacproposals';
import { Dacescrow } from './dacescrow/dacescrow';
import { Referendum } from './referendum/referendum';
import { Stakevote } from './stakevote/stakevote';
import { EosioToken } from '../../external_contracts/eosio.token/eosio.token';
import { Atomicassets } from './atomicassets/atomicassets'; //'../external_contracts/atomicassets/atomicassets';
import * as chai from 'chai';

import * as fs from 'fs';
import * as path from 'path';
import { rename, stat } from 'node:fs/promises';

export var NUMBER_OF_CANDIDATES = 7;

export class SharedTestObjects {
  // Shared Instances to use between tests.
  private static instance: SharedTestObjects;

  auth_account: Account;
  treasury_account: Account;
  activation_account: Account;

  // === Dac Contracts
  dacdirectory_contract: Dacdirectory;
  daccustodian_contract: Daccustodian;
  dac_token_contract: Eosdactokens;
  dacproposals_contract: Dacproposals;
  dacescrow_contract: Dacescrow;
  msigworlds_contract: Msigworlds;
  eosio_token_contract: EosioToken;
  referendum_contract: Referendum;
  stakevote_contract: Stakevote;
  tokenIssuer: Account;
  atomicassets: Atomicassets;

  // === Shared Values
  configured_dac_memberterms: string;

  NFT_COLLECTION: string;
  NUMBER_OF_REG_MEMBERS = 16;

  constructor() {
    this.NFT_COLLECTION = 'alien.worlds';
  }

  static async getInstance(): Promise<SharedTestObjects> {
    if (!SharedTestObjects.instance) {
      SharedTestObjects.instance = new SharedTestObjects();
      await SharedTestObjects.instance.initAndGetSharedObjects();
    }
    return SharedTestObjects.instance;
  }

  private async initAndGetSharedObjects() {
    console.log('Init eos blockchain');
    await sleep(1000);
    this.tokenIssuer = await AccountManager.createAccount('federation');
    await this.configTokenContract();

    // EOSManager.initWithDefaults();

    this.auth_account = await debugPromise(
      AccountManager.createAccount('eosdacauth'),
      'create eosdacauth'
    );
    this.treasury_account = await debugPromise(
      AccountManager.createAccount('treasury'),
      'create treasury account'
    );

    // Configure Dac contracts
    this.dacdirectory_contract = await ContractDeployer.deployWithName(
      'dacdirectory',
      'index.worlds'
    );

    this.daccustodian_contract = await debugPromise(
      ContractDeployer.deployWithName('daccustodian', 'daccustodian'),
      'created daccustodian'
    );
    this.dac_token_contract = await debugPromise(
      ContractDeployer.deployWithName('eosdactokens', 'token.worlds'),
      'created eosdactokens'
    );
    this.dacproposals_contract = await debugPromise(
      ContractDeployer.deployWithName('dacproposals', 'dacproposals'),
      'created dacproposals'
    );
    this.dacescrow_contract = await debugPromise(
      ContractDeployer.deployWithName('dacescrow', 'dacescrow'),
      'created dacescrow'
    );
    this.msigworlds_contract = await debugPromise(
      ContractDeployer.deployWithName<Msigworlds>('msigworlds', 'msig.worlds'),
      'created msigworlds_contract'
    );

    this.referendum_contract = await debugPromise(
      ContractDeployer.deployWithName<Referendum>('referendum', 'referendum'),
      'created referendum_contract'
    );

    this.stakevote_contract = await debugPromise(
      ContractDeployer.deployWithName<Stakevote>('stakevote', 'stakevote'),
      'created stakevote_contract'
    );

    this.atomicassets = await ContractDeployer.deployWithName<Atomicassets>(
      'atomicassets',
      'atomicassets'
    );
    await this.atomicassets.account.addCodePermission();
    await this.atomicassets.init({ from: this.atomicassets.account });

    this.activation_account = await AccountManager.createAccount('activation');
    // Other objects
    this.configured_dac_memberterms = 'be2c9d0494417cf7522cd8d6f774477c';
    await this.add_auth_account_permissions();
    await this.add_token_contract_permissions();

    await EOSManager.transact({
      actions: [
        {
          account: 'eosio.token',
          name: 'transfer',
          authorization: [
            {
              actor: 'eosio',
              permission: 'active',
            },
          ],
          data: {
            from: 'eosio',
            to: 'treasury',
            quantity: '1000.0000 EOS',
            memo: 'Some money for the treasury',
          },
        },
      ],
    });
  }

  async setup_new_auth_account() {
    this.auth_account = await debugPromise(
      AccountManager.createAccount(),
      'create eosdacauth'
    );
    await this.add_auth_account_permissions();
  }

  async initDac(
    dacId: string,
    symbol: string,
    initialAsset: string,
    config?: any
  ) {
    await this.setup_new_auth_account();
    // Further setup after the inital singleton object have been created.
    await this.setup_tokens(initialAsset);
    await this.register_dac_with_directory(dacId, symbol, config);
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
        should_pay_via_service_provider: false,
        lockup_release_time_delay: 1233,
        token_supply_theshold: 10000001,
      },
      dacId,
      { from: this.auth_account }
    );
  }

  async getRegMembers(
    dacId: string,
    initialDacAsset: string | Asset,
    count: number = this.NUMBER_OF_REG_MEMBERS
  ): Promise<Account[]> {
    const newMembers = await AccountManager.createAccounts(count);

    const termsPromises = newMembers
      .map((account) => {
        return debugPromise(
          this.dac_token_contract.memberreg(
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
            this.tokenIssuer,
            account.name,
            initialDacAsset,
            '',
            { from: this.tokenIssuer }
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
    const newCandidates = await this.getRegMembers(dacId, dacStakeAsset, count);
    for (const { candidate, index } of newCandidates.map(
      (candidate, index) => ({
        candidate,
        index,
      })
    )) {
      await debugPromise(
        this.dac_token_contract.stake(candidate.name, dacStakeAsset, {
          from: candidate,
        }),
        'staking for candidate'
      );
      const indexOption = index % 3;
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

  private async setup_tokens(initialAsset: string) {
    await this.dac_token_contract.create(
      this.tokenIssuer.name,
      initialAsset,
      false,
      { from: this.dac_token_contract.account }
    );
    await this.dac_token_contract.issue(
      this.tokenIssuer.name,
      initialAsset,
      'Initial Token holder',
      { from: this.tokenIssuer }
    );
  }

  // tokenSymbol is the symbol in this format: '4,EOSDAC'
  private async register_dac_with_directory(
    dacId: string,
    tokenSymbol: string,
    config?: any
  ) {
    const accounts = [
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
      {
        key: Account_type.REFERENDUM,
        value: this.referendum_contract.account.name,
      },
    ];
    if (config && config.planet) {
      accounts.push({
        key: Account_type.MSIGOWNED,
        value: config.planet.name,
      });
    }
    if (config && config.vote_weight_account) {
      console.log('adding ', config.vote_weight_account.name);
      accounts.push({
        key: Account_type.VOTING,
        value: config.vote_weight_account.name,
      });
    }

    await this.dacdirectory_contract.regdac(
      this.auth_account.name,
      dacId,
      {
        contract: this.dac_token_contract.account.name,
        sym: tokenSymbol,
      },
      'dac_title',
      [],
      accounts,
      {
        auths: [
          { actor: this.auth_account.name, permission: 'active' },
          { actor: this.treasury_account.name, permission: 'active' },
        ],
      }
    );
  }

  private async add_token_contract_permissions() {
    await debugPromise(
      UpdateAuth.execUpdateAuth(
        this.dac_token_contract.account.active,
        this.dac_token_contract.account.name,
        'issue',
        'active',
        UpdateAuth.AuthorityToSet.forContractCode(
          this.dac_token_contract.account
        )
      ),
      'add issue auth'
    );

    await debugPromise(
      UpdateAuth.execUpdateAuth(
        this.dac_token_contract.account.active,
        this.dac_token_contract.account.name,
        'notify',
        'active',
        UpdateAuth.AuthorityToSet.forContractCode(
          this.dac_token_contract.account
        )
      ),
      'add notify auth'
    );

    await debugPromise(
      UpdateAuth.execUpdateAuth(
        this.activation_account.active,
        this.activation_account.name,
        'notify',
        'active',
        UpdateAuth.AuthorityToSet.forContractCode(
          this.daccustodian_contract.account
        )
      ),
      'add notify auth to daccustodian_contract'
    );

    await debugPromise(
      UpdateAuth.execUpdateAuth(
        this.dac_token_contract.account.active,
        this.dac_token_contract.account.name,
        'xfer',
        'active',
        UpdateAuth.AuthorityToSet.forContractCode(
          this.dac_token_contract.account
        )
      ),
      'add xfer auth to eosdactoken'
    );

    await debugPromise(
      UpdateAuth.execUpdateAuth(
        this.treasury_account.active,
        this.treasury_account.name,
        'escrow',
        'active',
        UpdateAuth.AuthorityToSet.forContractCode(
          this.dacproposals_contract.account
        )
      ),
      'add escrow auth'
    );

    await debugPromise(
      UpdateAuth.execUpdateAuth(
        this.treasury_account.active,
        this.treasury_account.name,
        'xfer',
        'active',
        UpdateAuth.AuthorityToSet.explicitAuthorities(
          1,
          [
            {
              permission: {
                actor: this.daccustodian_contract.account.name,
                permission: 'eosio.code',
              },
              weight: 1,
            },
            {
              permission: {
                actor: this.dacproposals_contract.account.name,
                permission: 'eosio.code',
              },
              weight: 1,
            },
          ],
          [],
          []
        )
      ),
      'add xfer to treasury'
    );

    await debugPromise(
      UpdateAuth.execUpdateAuth(
        this.daccustodian_contract.account.active,
        this.daccustodian_contract.account.name,
        'pay',
        'active',
        UpdateAuth.AuthorityToSet.forContractCode(
          this.dacproposals_contract.account
        )
      ),
      'add pay auth to daccustodian'
    );

    await debugPromise(
      UpdateAuth.execUpdateAuth(
        this.dacescrow_contract.account.owner,
        this.dacescrow_contract.account.name,
        'active',
        'owner',
        UpdateAuth.AuthorityToSet.forContractCode(
          this.dacescrow_contract.account
        )
      ),
      'change active of escrow to daccustodian'
    );

    await debugPromise(
      UpdateAuth.execUpdateAuth(
        this.dacproposals_contract.account.owner,
        this.dacproposals_contract.account.name,
        'active',
        'owner',
        UpdateAuth.AuthorityToSet.forContractCode(
          this.dacproposals_contract.account
        )
      ),
      'change active of escrow to dacproposals'
    );

    await UpdateAuth.execUpdateAuth(
      [{ actor: this.msigworlds_contract.account.name, permission: 'owner' }],
      this.msigworlds_contract.account.name,
      'active',
      'owner',
      UpdateAuth.AuthorityToSet.explicitAuthorities(
        1,
        [
          {
            permission: {
              actor: this.msigworlds_contract.account.name,
              permission: 'eosio.code',
            },
            weight: 1,
          },
        ],
        [
          {
            key: this.msigworlds_contract.account.publicKey,
            weight: 1,
          },
        ],
        []
      )
    );

    await UpdateAuth.execLinkAuth(
      this.dac_token_contract.account.active,
      this.dac_token_contract.account.name,
      this.dac_token_contract.account.name,
      'issue',
      'issue'
    );

    await UpdateAuth.execLinkAuth(
      this.dac_token_contract.account.active,
      this.dac_token_contract.account.name,
      this.dac_token_contract.account.name,
      'weightobsv',
      'notify'
    );

    await UpdateAuth.execLinkAuth(
      this.treasury_account.active,
      this.treasury_account.name,
      this.dacescrow_contract.account.name,
      'init',
      'escrow'
    );

    await debugPromise(
      UpdateAuth.execLinkAuth(
        this.treasury_account.active,
        this.treasury_account.name,
        this.dacescrow_contract.account.name,
        'approve',
        'escrow'
      ),
      'linking escrow perm to treasury'
    );

    await UpdateAuth.execLinkAuth(
      this.treasury_account.active,
      this.treasury_account.name,
      'eosio.token',
      'transfer',
      'xfer'
    );

    await UpdateAuth.execLinkAuth(
      this.treasury_account.active,
      this.treasury_account.name,
      this.dac_token_contract.account.name,
      'transfer',
      'xfer'
    );

    await UpdateAuth.execLinkAuth(
      this.treasury_account.active,
      this.treasury_account.name,
      this.eosio_token_contract.name,
      'transfer',
      'xfer'
    );

    await UpdateAuth.execLinkAuth(
      this.dac_token_contract.account.active,
      this.dac_token_contract.account.name,
      this.daccustodian_contract.account.name,
      'stakeobsv',
      'notify'
    );

    await UpdateAuth.execLinkAuth(
      this.dac_token_contract.account.active,
      this.dac_token_contract.account.name,
      this.referendum_contract.account.name,
      'stakeobsv',
      'notify'
    );

    await UpdateAuth.execLinkAuth(
      this.dac_token_contract.account.active,
      this.dac_token_contract.account.name,
      this.dac_token_contract.account.name,
      'refund',
      'notify'
    );

    await UpdateAuth.execLinkAuth(
      this.dac_token_contract.account.active,
      this.dac_token_contract.account.name,
      this.daccustodian_contract.account.name,
      'balanceobsv',
      'notify'
    );

    await UpdateAuth.execLinkAuth(
      this.dac_token_contract.account.active,
      this.dac_token_contract.account.name,
      this.daccustodian_contract.account.name,
      'capturestake',
      'notify'
    );

    await UpdateAuth.execLinkAuth(
      this.dac_token_contract.account.active,
      this.dac_token_contract.account.name,
      this.dac_token_contract.account.name,
      'transfer',
      'xfer'
    );

    await UpdateAuth.execLinkAuth(
      this.daccustodian_contract.account.active,
      this.daccustodian_contract.account.name,
      this.dac_token_contract.account.name,
      'transfer',
      'xfer'
    );

    await UpdateAuth.execLinkAuth(
      this.activation_account.active,
      this.activation_account.name,
      this.activation_account.name,
      'assertunlock',
      'notify'
    );

    await UpdateAuth.execLinkAuth(
      this.daccustodian_contract.account.active,
      this.daccustodian_contract.account.name,
      this.daccustodian_contract.account.name,
      'clearstake',
      'pay'
    );

    await this.referendum_contract.account.addCodePermission();
  }

  private async add_auth_account_permissions() {
    await debugPromise(
      UpdateAuth.execUpdateAuth(
        this.auth_account.owner,
        this.auth_account.name,
        'high',
        'active',
        UpdateAuth.AuthorityToSet.forContractCode(
          this.daccustodian_contract.account
        )
      ),
      'add high auth'
    );

    await debugPromise(
      UpdateAuth.execUpdateAuth(
        this.auth_account.owner,
        this.auth_account.name,
        'owner',
        '',
        UpdateAuth.AuthorityToSet.forContractCode(
          this.daccustodian_contract.account
        )
      ),
      'change owner of auth_account'
    );

    await debugPromise(
      UpdateAuth.execUpdateAuth(
        this.daccustodian_contract.account.owner,
        this.daccustodian_contract.account.name,
        'owner',
        '',
        UpdateAuth.AuthorityToSet.explicitAuthorities(
          1,
          [
            {
              permission: {
                actor: this.auth_account.name,
                permission: 'active',
              },
              weight: 1,
            },
          ],
          [
            {
              key: this.daccustodian_contract.account.publicKey,
              weight: 1,
            },
          ],
          []
        )
      ),
      'changing owner of daccustodian'
    );

    await debugPromise(
      UpdateAuth.execUpdateAuth(
        this.daccustodian_contract.account.owner,
        this.daccustodian_contract.account.name,
        'active',
        'owner',
        UpdateAuth.AuthorityToSet.explicitAuthorities(
          1,
          [
            {
              permission: {
                actor: this.auth_account.name,
                permission: 'active',
              },
              weight: 1,
            },
          ],
          [
            {
              key: this.daccustodian_contract.account.publicKey,
              weight: 1,
            },
          ],
          []
        )
      ),
      'change active of daccustodian'
    );

    await debugPromise(
      UpdateAuth.execUpdateAuth(
        this.auth_account.active,
        this.auth_account.name,
        'med',
        'high',
        UpdateAuth.AuthorityToSet.forContractCode(
          this.daccustodian_contract.account
        )
      ),
      'add med auth'
    );

    await debugPromise(
      UpdateAuth.execUpdateAuth(
        this.auth_account.active,
        this.auth_account.name,
        'low',
        'med',
        UpdateAuth.AuthorityToSet.forContractCode(
          this.daccustodian_contract.account
        )
      ),
      'add low auth'
    );

    await debugPromise(
      UpdateAuth.execUpdateAuth(
        this.auth_account.active,
        this.auth_account.name,
        'one',
        'low',
        UpdateAuth.AuthorityToSet.forContractCode(
          this.daccustodian_contract.account
        )
      ),
      'add one auth'
    );

    await debugPromise(
      UpdateAuth.execUpdateAuth(
        this.auth_account.active,
        this.auth_account.name,
        'admin',
        'one',
        UpdateAuth.AuthorityToSet.forContractCode(
          this.daccustodian_contract.account
        )
      ),
      'add admin auth'
    );

    await debugPromise(
      UpdateAuth.execUpdateAuth(
        this.auth_account.active,
        this.auth_account.name,
        'referendum',
        'active',
        UpdateAuth.AuthorityToSet.explicitAuthorities(1, [
          {
            permission: {
              actor: this.referendum_contract.account.name,
              permission: 'eosio.code',
            },
            weight: 1,
          },
        ])
      ),
      'add referendum to auth_account'
    );

    await debugPromise(
      UpdateAuth.execUpdateAuth(
        this.daccustodian_contract.account.active,
        this.daccustodian_contract.account.name,
        'xfer',
        'active',
        UpdateAuth.AuthorityToSet.explicitAuthorities(2, [
          {
            permission: {
              actor: this.daccustodian_contract.account.name,
              permission: 'eosio.code',
            },
            weight: 1,
          },
          {
            permission: {
              actor: this.auth_account.name,
              permission: 'med',
            },
            weight: 1,
          },
        ])
      ),
      'add xfer to daccustodian'
    );
  }

  async setup_dac_memberterms(dacId: string, dacAuth: Account) {
    await debugPromise(
      this.dac_token_contract.newmemterms(
        'https://raw.githubusercontent.com/eosdac/eosdac-constitution/master/constitution.md',
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
        this.daccustodian_contract.votecust(
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
        this.daccustodian_contract.votecust(
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

  async configTokenContract() {
    this.eosio_token_contract =
      await ContractDeployer.deployWithName<EosioToken>(
        'eosio.token',
        'alien.worlds'
      );

    try {
      await this.eosio_token_contract.create(
        this.tokenIssuer.name,
        '10000000000.0000 TLM',
        {
          from: this.eosio_token_contract.account,
        }
      );
      await this.eosio_token_contract.issue(
        this.tokenIssuer.name,
        '10000000.0000 TLM',
        'initial deposit',
        {
          from: this.tokenIssuer,
        }
      );
    } catch (e) {
      console.log(JSON.stringify(e, null, 2));
      if (!e.details[0].message.includes('token with symbol already exists')) {
        throw e;
      }
    }
  }
}

// Not used for now but could be useful later
async function setup_external(name: string) {
  const compiled_dir = path.normalize(
    `${__dirname}/./compiled_contracts/${name}`
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
  TREASURY = 1,
  CUSTODIAN = 2,
  MSIGOWNED = 3,
  SERVICE = 5,
  PROPOSALS = 6,
  ESCROW = 7,
  VOTING = 8,
  ACTIVATION = 9,
  REFERENDUM = 10,
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

// returns true if file exists, false otherwise
async function fileExists(path: string) {
  try {
    await stat(path);
    return true;
  } catch (err) {
    return false;
  }
}
