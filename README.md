# daccustodian - Custodian Elections Contract
This contract will be in charge of custodian registration and voting for candidates.  It will also contain a function could will be called periodically to update the custodian set, and allocate payments.

When a candidate registers, they need to provide a set of configuration variables which will include things like their requested pay.  The system will select the median requested pay when choosing the actual pay.
## Tables

### Candidate

- candidate_name (name) - Account name of the candidate (INDEX)
- bio (hash) - Link to IPFS file containing structured data about the candidate (schema.org preferred)
- is_custodian (int8) - Boolean indicating if the candidate is currently elected (INDEX)
- locked_tokens (asset) - An asset object representing the number of tokens locked when registering
- requestedpay - The amount of pay requested for this election period
- pendreqpay - The amount of pay requested for next election period. This will become `requestedpay` after `newperiod` is called.
- total_votes - Updated tally of the number of votes cast to a candidate. This is updated and used as part of the `newperiod` calculations then stored in the table until being refreshed on the next `newperiod` call.

### Votes

- voter (account_name) - The account name of the voter (INDEX)
- proxy (account_name) - Name of another voter used to proxy votes through. This should not have a value in both the proxy and candidates at the same time.
- candidates (account_name[]) - The candidates voted for, can supply up to the maximum number of votes (currently 5) - Can be configured via `updateconfig`
- weight - The amount of voting strength this voter has which is derived from the EOSDAC balance at the time `newperiod` is called.

## Actions

### regcandidate

Register to be a candidate, accounts must register as a candidate before they can be voted for.  The account must lock 1000 tokens when registering (configurable via `updateconfig`).


#### Message
`cand (account_name)
bio (ipfs_hash/url)
requested_pay`

This action asserts:

 - the message has the permission of the account registering.
 - the `cand` account has agreed to the membership agreement.
 - the candidate is not already registered.
 - `cand` account can transfer funds and that there is sufficient permission for this contract to transfer funds for lockup.

Then it insert the candidate record into the database, making sure to set elected to 0
 and transfer the configurable number of tokens which need to be locked to the contract account based on the amount set in `updateconfig`.

### unregcand

Unregister as a candidate, if currently elected as a custodian this account will be removed from the custodian list and initiates the transfer of the locked up tokens back the `cand`.

#### Message
`cand (account_name)`

This action asserts:

 - the message has the permission of the account registering.
 - the `cand` account is currently registered.

 Then removes the candidate from the candidates table and prepares to transfer the locked up tokens back to the `cand` account.

__Unsure about this:__ *If the candidate is currently elected then mark the existing record as resigned ## why?
Remove the candidate from the database if they are not currently elected, also remove all votes cast for them as well as votes by them for ongoing worker proposals

Send the staked tokens back to the account*

### updatebio

Update the bio for this candidate / custodian. This will be available on the account immediately in preparation for the next election cycle.
#### Message
`cand (account_name)
bio (ipfs_hash/url)`

This action asserts:

 - the message has the permission of the account registering.
 - the account has agreed to the current terms.
 - the `cand` account is currently registered.

__*Currently no validation on the bio field - to be determined??*__

### updatereqpay

Update the requested pay for this candidate / custodian. This will be available on the account immediately in preparation for the next election cycle.
#### Message
`cand (account_name)
requestedpay (asset)`

This action asserts:

 - the message has the permission of the account registering.
 - the account has agreed to the current terms.
 - the `cand` account is currently registered.

Then the candidate's field for `pendingreqpay` is populated with the amount. On the next `newperiod` call this amount is trandferred to the `requestedpay` field. The reason for this is to prevent candidates changing their requested pay after being elected but before getting paid. Voters would be able to see their requested amount for the next period via the `pendingreqpay`field. A candidate cannot update the `requestedpay` field directly.

### votecust

Update the votes for a configurable number of custodian candidates using preference voting.  The votes supplied will overwrite all existing votes so to remove a vote, simply supply an updated list.

####Message
`voter (name), newvotes ([name])`

This action asserts:

 - the message has the permission of the account registering.
 - the `cand` account is currently registered.
 - the account has agreed to the current terms.
 - the maximum number of votes is not more than the configured amount (as set by updateconfig).

Then sets the array of accounts as the users acitive votes which will be used for calcualtions when `newperiod` is called.

### updateconfig

Updates the contract configuration parameters to allow changes without needing to redeploy the source code.

####Message
 `lockupasset(asset), maxvotes (uint8_t), latestterms (string), numelected(uint16_t)`
 
This action asserts:

 - the message has the permission of the contract account.
 - the supplied asset symbol matches the current lockup symbol.

The paramters are:

- lockupasset(uint8_t) : defines the asset and amount required for a user to register as a candidate. This is the amount that will be locked up until the user calls `unregcand` in order to get the asset returned to them.
- maxvotes(asset) : Defines the maximum number of candidates a user can vote for at any given time.
- latestterms (string) : The hash for the current agreed terms that each member must have agreed to in order to participate in the dac actions.
- numelected(uint16_t) : The number of candidates to elect for custodians. This is used for the payment amount to custodians for median amount and to set the `is_custodian` to true for the top voted accounts.


#### Message
`account (account_name)`

Check the message has permission of the account
Check if there is a record in the CustodianReward table, if there is not then assert
If the account has an outstanding balance then send it to the account, otherwise assert
Remove the record in the CustodianReward table

### votecust

Create/update the votes for a configurable number of custodian candidates using preference voting. The votes supplied will overwrite all existing votes so to remove a vote, simply supply an updated list. This vote will overwrite any existing vote for either a custodian vote or proxy vote.


#### Message
`account (account_name)
votes (account_name[])`

This action asserts:

 - the message has the permission of the account registering.
 - the `cand` account is currently registered.
 - the account has agreed to the current terms.

__Unsure about this since each could be unregistered by the time `newperiod` is called.__ For each of the votes, check that the account names are registered as custodian candidates.  Assert if any of the accounts are not registered as candidates

Save the votes in the `Votes` table, update if the voting account already has a record.

### voteproxy

Create/update the active vote to proxy through another voter. This vote will overwrite any existing vote for either a custodian vote or proxy vote.

#### Message
`account (account_name)
proxy (account_name)`

This action asserts:

 - the message has the permission of the account registering.
 - the `cand` account is currently registered.
 - the account has agreed to the current terms.
 - the vote is not proxying to themselves as a proxy.
 - the vote is not proxying to another proxy.

Save the votes in the `Votes` table, update if the voting account already has a record.

### newperiod

This is an internal action which is designed to be called once every election period (24 hours initially).  It will do the following things:

- Distribute custodian pay based on the median of `requestedpay` for all currently elected candidates.
- Tally the current votes and prepare a list of the winning custodians for the next period based on the voter's and proxies current EOSDAC balances.
-  __Still to be decided on the details here__ This may include updating a multi-sig wallet which controls the funds in the DAC as well as updating DAC contract code.
-  Configures the contract for the next period by moving the `pendingreqpay` into the `requestedpay` for each candidate.
- Assigns the elected custodians after tallying the votes based on the top `numelected` votees. (set `is_custodian` to true).

This action asserts:

 - the message has the permission of the contract account.

This is deliberately not asserting on internal verifications because they would not be resolvable by the contract account and could prevent this from being called automatically and reliably. __Perhaps further discussion required for this__ 


### paypending

This is intended to process the pending payments that have accumulated after `newperiod` has finished processing. Also any staked tokens that need to be returned after a user has called unreg will be returned via this action. This explicit action is necessary since in order to transfer funds from the DAC a multi-sig permission should probably be requried.


## Tests

The repo includes automated tests to exercise the main action paths in the contract against a running local node.
The tests are included in the tests folder as `rspec` tests in Ruby. 

### Installation
To run the tests you would first need:
- `ruby 2.4.1` or later installed.
- Ruby gems as specified in the `Gemfile`. 
    - These can be installed by running `bundle install` from the project root directory.
Eos installed locally that can be launched via  `nodeos`

### To run the tests:
 run `rspec tests/contract_spec.rb` from the project root.
