# Referendum Contract

This contract allows members of the DAC to propose a referendum for voting on by the token holders.

## Types

There are 3 types of referendum:

- **Binding** An action must be submitted with the proposal and this will be executed by the contract if the quorum and threshold are met.
- **Semi-Binding** Similar to a binding referendum, except the action will be proposed as a custodian to approve and execute.
- **Opinion** This type of referendum does not need to include an action to execute, it is simply a signal to the Custodians about the opinion of the token holders.

There are 2 types of counting method

- **Token** The staked token balance will be used
- **Account** There will be 1 vote per account.  Please note that this counting method can be subjected to Sybil attack.

## Configuration

The contract takes a number of configuration variables, most are sent as maps with the key being the type of referendum, this means we can have different fees and thresholds for different types of referendum.

- **fee** The amount to charge for submitting a proposal, must be an extended asset and can be 0.
- **pass** The pass percentage as an integer with 2 decimal places.  eg. 1000 = 10%
- **quorum_token** The quorum of token votes which must be met if the count type is token
- **quorum_account** The quorum of account votes which must be met if the count type is account
- **allow_per_account_voting** Set to 1 to allow account-based counting for each referendum type

## Voting

Members will be allowed to vote on up to 20 open proposals at any one time.

Voting for each proposal can be either yes, no or abstain.  Members will also be allowed to remove a vote entirely.

All votes count towards the quorum, if this is met then the percentage of yes votes is calculated and compared to the required limit.

Once the proposal has met the pass threshold the status will be changed and the proposal can be executed by anyone.

If a quorum is reached, but not the pass threshold then the status will be set to alert the custodians to it.

## Fees

A fee is configurable for each type of referendum, this must be sent to the referendum contract before proposing the referendum.  The fee can be in any currency, but the contract can only hold a single depoosit currency at a time while waiting for the proposal.  In most cases the payment and the proposal will be sent together so this will not matter.

## Permissions

When executing actions directly, the referendum contract must must satisfy those permissions by itself.

When submitting a multisig for approval to the custodians, the contract will use the permission `[authority]@admin`.  This is a permission that must be added under `@one` and be linked to `[dacmsig]::proposede`.

`cleos set account permission --add-code [custodian] admin [this contract] one`

The authority account have the premission `@referendum` which is satisfied by this contract and is linked to `eosio.msig::propose`.

`cleos set account permission --add-code [authority] referendum [this account] active`

`cleos set action permission [authority] eosio.msig propose referendum`

For all other actions which could be proposed in a semi-binding constitution, you must make sure that they can be satisfied by the contract `@eosio.code` permission.

The `@active` permission of this contract should be satisfyable by `@eosio.code`

`cleos set account permission --add-code [this account] active [this account] owner`
