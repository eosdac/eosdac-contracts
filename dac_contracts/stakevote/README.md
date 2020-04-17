# Extension to allow stake-time-weighted voting

Allows the eosDAC contracts to be extended to allow for stake-time weighted voting.

The `dacdirectory` contract should be configured by adding the account where this contract is installed in the 
`VOTE_WEIGHT` (8) type account.

## stakeobsv

When tokens are staked / unstaked or the stake time is changed, this contract will be sent an inline `stakeobsv` action 
from the token contract.  After receiving the action it will calculate the new vote weight and send a `weightobsv` 
notification to the custodian contract.

## balanceobsv

The contract implements a `balanceobsv` action but does not respond to it because they are for liquid balance deltas.

