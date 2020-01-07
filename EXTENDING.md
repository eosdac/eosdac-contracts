# Extending the eosDAC Contracts

The eosDAC contracts are designed to be extensible to allow for different voting schemes, unlocking requirements and
to respond to various events (eg. a new period starting).  Currently external contracts 
can be configured to provide custom voting schemes and DAC unlocking methods.

## Changing the vote weight to a custom algorithm

By default the eosDAC contracts will use the liquid token balance as the vote weight for candidates.
If the VOTE_WEIGHT entry is set in the DAC directory then the custodian contract will respond
to `weightobsv` actions from this contract.  This means that you can override the vote
weight calculations to anything you like.

### Example

See the `stakevote` contract for an example of using staked balances for vote weight, 
this also uses the stake commitment time as a factor in the calculation.

#### `balanceobsv(vector<account_balance_delta> balance_deltas, name dac_id)`

When a balance changes, the token contract will check to see if the `VOTE_WEIGHT` account
 is set in the dacdirectory. If there is, then the inline action will be sent there, 
 otherwise it is sent to the custodian contract.

An external can then respond to these notifications and send a `weightobsv` inline action
to the custodian contract.

#### `weightobsv(vector<account_weight_delta> account_weight_deltas, name dac_id)`

Either the token contract or the vote weight contract may notify the custodian contract
of a weight delta change.  The contract that sends the notification must also have a 
table called `weights` which has the following structure.

```
struct [[eosio::table]] vote_weight {
    eosio::name     voter;
    uint64_t weight;

    uint64_t primary_key()const { return voter.value; }
};
typedef eosio::multi_index< "weights"_n, vote_weight > weights;
```
