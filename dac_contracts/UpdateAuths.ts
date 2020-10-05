import { debugPromise, EOSManager, UpdateAuth } from 'lamington';
import { SharedTestObjects } from './TestHelpers';

export async function add_token_contract_permissions(
  sharedObjects: SharedTestObjects
) {
  await addNewPermissions(sharedObjects);
  await updateExistingPermissions(sharedObjects);
  await addDependentPermissions(sharedObjects);
  await linkAuthsToActions(sharedObjects);
}

async function addNewPermissions(sharedObjects: SharedTestObjects) {
  await debugPromise(
    UpdateAuth.execUpdateAuth(
      sharedObjects.dac_token_contract.account.active,
      sharedObjects.dac_token_contract.account.name,
      'issue',
      'active',
      UpdateAuth.AuthorityToSet.forContractCode(
        sharedObjects.dac_token_contract.account
      )
    ),
    'add issue auth'
  );

  await debugPromise(
    UpdateAuth.execUpdateAuth(
      sharedObjects.dac_token_contract.account.active,
      sharedObjects.dac_token_contract.account.name,
      'notify',
      'active',
      UpdateAuth.AuthorityToSet.forContractCode(
        sharedObjects.dac_token_contract.account
      )
    ),
    'add notify auth'
  );

  await debugPromise(
    UpdateAuth.execUpdateAuth(
      sharedObjects.dac_token_contract.account.active,
      sharedObjects.dac_token_contract.account.name,
      'xfer',
      'active',
      UpdateAuth.AuthorityToSet.forContractCode(
        sharedObjects.dac_token_contract.account
      )
    ),
    'add token@xfer auth to eosdactoken'
  );

  await debugPromise(
    UpdateAuth.execUpdateAuth(
      sharedObjects.daccustodian_contract.account.active,
      sharedObjects.daccustodian_contract.account.name,
      'codeexec',
      'active',
      UpdateAuth.AuthorityToSet.forContractCode(
        sharedObjects.daccustodian_contract.account
      )
    ),
    'Add daccustodian@codeexec for to daccustodian'
  );

  await debugPromise(
    UpdateAuth.execUpdateAuth(
      sharedObjects.dacproposals_contract.account.active,
      sharedObjects.dacproposals_contract.account.name,
      'codeexec',
      'active',
      UpdateAuth.AuthorityToSet.forContractCode(
        sharedObjects.dacproposals_contract.account
      )
    ),
    'Add dacproposals@codeexec for to dacproposals'
  );

  await debugPromise(
    UpdateAuth.execUpdateAuth(
      sharedObjects.treasury_account.active,
      sharedObjects.treasury_account.name,
      'escrow',
      'active',
      UpdateAuth.AuthorityToSet.forAccount(
        sharedObjects.dacproposals_contract.account,
        'codeexec'
      )
    ),
    'add dacproposals@codeexec for treasury escrow auth'
  );

  await debugPromise(
    UpdateAuth.execUpdateAuth(
      sharedObjects.treasury_account.active,
      sharedObjects.treasury_account.name,
      'xfer',
      'active',
      UpdateAuth.AuthorityToSet.explicitAuthorities(
        3,
        [
          {
            permission: {
              actor: sharedObjects.daccustodian_contract.account.name,
              permission: 'codeexec',
            },
            weight: 1,
          },
          {
            permission: {
              actor: sharedObjects.dacproposals_contract.account.name,
              permission: 'codeexec',
            },
            weight: 1,
          },
        ],
        undefined,
        [{ wait_sec: 30, weight: 2 }]
      )
    ),
    'add xfer to treasury'
  );

  await debugPromise(
    UpdateAuth.execUpdateAuth(
      sharedObjects.daccustodian_contract.account.active,
      sharedObjects.daccustodian_contract.account.name,
      'pay',
      'active',
      UpdateAuth.AuthorityToSet.explicitAuthorities(1, [
        {
          permission: {
            actor: sharedObjects.daccustodian_contract.account.name,
            permission: 'eosio.code',
          },
          weight: 1,
        },
        {
          permission: {
            actor: sharedObjects.dacproposals_contract.account.name,
            permission: 'eosio.code',
          },
          weight: 1,
        },
      ])
    ),
    'add pay auth to daccustodian'
  );

  await debugPromise(
    UpdateAuth.execUpdateAuth(
      sharedObjects.auth_account.owner,
      sharedObjects.auth_account.name,
      'high',
      'active',
      UpdateAuth.AuthorityToSet.forContractCode(
        sharedObjects.daccustodian_contract.account
      )
    ),
    'add high auth'
  );
}

async function updateExistingPermissions(sharedObjects: SharedTestObjects) {
  await debugPromise(
    UpdateAuth.execUpdateAuth(
      sharedObjects.auth_account.owner,
      sharedObjects.auth_account.name,
      'owner',
      '',
      UpdateAuth.AuthorityToSet.forContractCode(
        sharedObjects.daccustodian_contract.account
      )
    ),
    'change owner of auth_account'
  );

  await debugPromise(
    UpdateAuth.execUpdateAuth(
      sharedObjects.daccustodian_contract.account.owner,
      sharedObjects.daccustodian_contract.account.name,
      'owner',
      '',
      UpdateAuth.AuthorityToSet.forAccount(sharedObjects.auth_account, 'active')
    ),
    'changing owner of daccustodian'
  );

  await debugPromise(
    UpdateAuth.execUpdateAuth(
      sharedObjects.daccustodian_contract.account.owner,
      sharedObjects.daccustodian_contract.account.name,
      'active',
      'owner',
      UpdateAuth.AuthorityToSet.explicitAuthorities(
        1,
        [
          {
            permission: {
              actor: sharedObjects.auth_account.name,
              permission: 'active',
            },
            weight: 1,
          },
        ],
        [
          {
            key: 'EOS5AKE8tL7Pmiwc5odXb2gditwfuxyvbTJEjBh4PUD4two7AhhBE',
            weight: 1,
          },
        ]
      )
    ),
    'change active of daccustodian'
  );

  await debugPromise(
    UpdateAuth.execUpdateAuth(
      sharedObjects.dacescrow_contract.account.owner,
      sharedObjects.dacescrow_contract.account.name,
      'active',
      'owner',
      UpdateAuth.AuthorityToSet.explicitAuthorities(
        1,
        [
          {
            permission: {
              actor: sharedObjects.dacescrow_contract.account.name,
              permission: 'eosio.code',
            },
            weight: 1,
          },
        ],
        [
          {
            key: 'EOS5AKE8tL7Pmiwc5odXb2gditwfuxyvbTJEjBh4PUD4two7AhhBE',
            weight: 1,
          },
        ]
      )
    ),
    'change active of escrow to daccustodian'
  );

  await debugPromise(
    UpdateAuth.execUpdateAuth(
      sharedObjects.dacproposals_contract.account.owner,
      sharedObjects.dacproposals_contract.account.name,
      'active',
      'owner',
      UpdateAuth.AuthorityToSet.explicitAuthorities(
        1,
        [
          {
            permission: {
              actor: sharedObjects.dacproposals_contract.account.name,
              permission: 'codeexec',
            },
            weight: 1,
          },
        ],
        [
          {
            key: EOSManager.adminAccount.publicKey,
            weight: 1,
          },
        ]
      )
    ),
    'change active of dacproposals to codeexec and key'
  );
}

async function addDependentPermissions(sharedObjects: SharedTestObjects) {
  await debugPromise(
    UpdateAuth.execUpdateAuth(
      sharedObjects.auth_account.active,
      sharedObjects.auth_account.name,
      'med',
      'high',
      UpdateAuth.AuthorityToSet.forContractCode(
        sharedObjects.daccustodian_contract.account
      )
    ),
    'add med auth'
  );

  await debugPromise(
    UpdateAuth.execUpdateAuth(
      sharedObjects.auth_account.active,
      sharedObjects.auth_account.name,
      'low',
      'med',
      UpdateAuth.AuthorityToSet.forContractCode(
        sharedObjects.daccustodian_contract.account
      )
    ),
    'add low auth'
  );

  await debugPromise(
    UpdateAuth.execUpdateAuth(
      sharedObjects.auth_account.active,
      sharedObjects.auth_account.name,
      'one',
      'low',
      UpdateAuth.AuthorityToSet.forContractCode(
        sharedObjects.daccustodian_contract.account
      )
    ),
    'add one auth'
  );

  await debugPromise(
    UpdateAuth.execUpdateAuth(
      sharedObjects.auth_account.active,
      sharedObjects.auth_account.name,
      'admin',
      'one',
      UpdateAuth.AuthorityToSet.forContractCode(
        sharedObjects.daccustodian_contract.account
      )
    ),
    'add admin auth'
  );

  await debugPromise(
    UpdateAuth.execUpdateAuth(
      sharedObjects.daccustodian_contract.account.active,
      sharedObjects.daccustodian_contract.account.name,
      'xfer',
      'active',
      UpdateAuth.AuthorityToSet.explicitAuthorities(1, [
        {
          permission: {
            actor: sharedObjects.daccustodian_contract.account.name,
            permission: 'eosio.code',
          },
          weight: 1,
        },
        {
          permission: {
            actor: sharedObjects.auth_account.name,
            permission: 'med',
          },
          weight: 1,
        },
      ])
    ),
    'add xfer to daccustodian'
  );
}

async function linkAuthsToActions(sharedObjects: SharedTestObjects) {
  await UpdateAuth.execLinkAuth(
    sharedObjects.dac_token_contract.account.active,
    sharedObjects.dac_token_contract.account.name,
    sharedObjects.dac_token_contract.account.name,
    'issue',
    'issue'
  );

  await UpdateAuth.execLinkAuth(
    sharedObjects.dac_token_contract.account.active,
    sharedObjects.dac_token_contract.account.name,
    sharedObjects.dac_token_contract.account.name,
    'weightobsv',
    'notify'
  );

  await UpdateAuth.execLinkAuth(
    sharedObjects.treasury_account.active,
    sharedObjects.treasury_account.name,
    sharedObjects.dacescrow_contract.account.name,
    'init',
    'escrow'
  );

  await debugPromise(
    UpdateAuth.execLinkAuth(
      sharedObjects.treasury_account.active,
      sharedObjects.treasury_account.name,
      sharedObjects.dacescrow_contract.account.name,
      'approve',
      'escrow'
    ),
    'linking escrow perm to treasury'
  );

  await UpdateAuth.execLinkAuth(
    sharedObjects.treasury_account.active,
    sharedObjects.treasury_account.name,
    'eosio.token',
    'transfer',
    'xfer'
  );

  await UpdateAuth.execLinkAuth(
    sharedObjects.treasury_account.active,
    sharedObjects.treasury_account.name,
    sharedObjects.dac_token_contract.account.name,
    'transfer',
    'xfer'
  );

  await debugPromise(
    UpdateAuth.execLinkAuth(
      sharedObjects.daccustodian_contract.account.active,
      sharedObjects.daccustodian_contract.account.name,
      sharedObjects.daccustodian_contract.account.name,
      'removecuspay',
      'codeexec'
    ),
    'link auth for remove custodian pay in deferred transaction'
  );

  await UpdateAuth.execLinkAuth(
    sharedObjects.dac_token_contract.account.active,
    sharedObjects.dac_token_contract.account.name,
    sharedObjects.daccustodian_contract.account.name,
    'stakeobsv',
    'notify'
  );

  await UpdateAuth.execLinkAuth(
    sharedObjects.dac_token_contract.account.active,
    sharedObjects.dac_token_contract.account.name,
    sharedObjects.dac_token_contract.account.name,
    'refund',
    'notify'
  );

  await UpdateAuth.execLinkAuth(
    sharedObjects.dac_token_contract.account.active,
    sharedObjects.dac_token_contract.account.name,
    sharedObjects.daccustodian_contract.account.name,
    'balanceobsv',
    'notify'
  );

  await UpdateAuth.execLinkAuth(
    sharedObjects.dac_token_contract.account.active,
    sharedObjects.dac_token_contract.account.name,
    sharedObjects.daccustodian_contract.account.name,
    'capturestake',
    'notify'
  );

  await UpdateAuth.execLinkAuth(
    sharedObjects.dac_token_contract.account.active,
    sharedObjects.dac_token_contract.account.name,
    sharedObjects.dac_token_contract.account.name,
    'transfer',
    'xfer'
  );

  await UpdateAuth.execLinkAuth(
    sharedObjects.daccustodian_contract.account.active,
    sharedObjects.daccustodian_contract.account.name,
    'eosio.msig',
    'propose',
    'codeexec'
  );

  await UpdateAuth.execLinkAuth(
    sharedObjects.daccustodian_contract.account.active,
    sharedObjects.daccustodian_contract.account.name,
    'eosio.msig',
    'approve',
    'codeexec'
  );

  await debugPromise(
    UpdateAuth.execLinkAuth(
      sharedObjects.dacproposals_contract.account.active,
      sharedObjects.dacproposals_contract.account.name,
      'eosio.msig',
      'propose',
      'codeexec'
    ),
    'adding msig-propose to dacproposals'
  );

  await debugPromise(
    UpdateAuth.execLinkAuth(
      sharedObjects.dacproposals_contract.account.active,
      sharedObjects.dacproposals_contract.account.name,
      'eosio.msig',
      'approve',
      'codeexec'
    ),
    'adding msig-approve to dacproposals'
  );

  await debugPromise(
    UpdateAuth.execLinkAuth(
      sharedObjects.dacproposals_contract.account.active,
      sharedObjects.dacproposals_contract.account.name,
      sharedObjects.dacproposals_contract.account.name,
      'runstartwork',
      'codeexec'
    ),
    'adding msig-approve to dacproposals'
  );

  await UpdateAuth.execLinkAuth(
    sharedObjects.daccustodian_contract.account.active,
    sharedObjects.daccustodian_contract.account.name,
    sharedObjects.dac_token_contract.account.name,
    'transfer',
    'xfer'
  );

  await UpdateAuth.execLinkAuth(
    sharedObjects.daccustodian_contract.account.active,
    sharedObjects.daccustodian_contract.account.name,
    sharedObjects.daccustodian_contract.account.name,
    'clearstake',
    'pay'
  );
}
