# dacelections - Custodian Elections Contract
This contract will be in charge of custodian registration and voting for candidates.  It will also contain a function could will be called periodically to update the custodian set, and allocate payments.

When a candidate registers, they need to provide a set of configuration variables which will include things like their requested pay.  The system will select the median requested pay when choosing the actual pay.
The median pay is to be paid to elected custodians at the end of each period. If an elected custodian resigns via the `unregcand` during a period a new candidate will be chosen to fill the gap on the custodian board from the votes ranking in the candidates at that moment. 

Eg. 12 custodians are elected and their median `requestedpay` is 100 EOSDAC If one of the custodians resigns partially through a period they will not will not be paid for that partial period. The median pay amount will be calculated based on the current elected custodians `requestedpay` value. If a candidate changes their requested pay it will not be included in the pay calculation until the next period if they are re-elected.

## Tables

### Candidate

- candidate_name (name) - Account name of the candidate (INDEX)
- bio (hash) - Link to IPFS file containing structured data about the candidate (schema.org preferred)
- isactive (int8) - Boolean indicating if the candidate is currently available for election. (INDEX)
- locked_tokens (asset) - An asset object representing the number of tokens locked when registering
- requestedpay - The amount of pay requested by the candidate to be paid if they were elected for the following period.
- total_votes - Updated tally of the number of votes cast to a candidate. This is updated and used as part of the `newperiod` calculations. It is updated every time there is a vote change or a change of token balance for a voter for this candidate to facilitate live voting stats.

### Votes

- voter (account_name) - The account name of the voter (INDEX)
- proxy (account_name) - Name of another voter used to proxy votes through. This should not have a value in both the proxy and candidates at the same time.
- candidates (account_name[]) - The candidates voted for, can supply up to the maximum number of votes (currently 5) - Can be configured via `updateconfig`

## Actions

### regcandidate

Register to be a candidate, accounts must register as a candidate before they can be voted for.  The account must lock a configurable number of tokens when registering (configurable via `updateconfig`).


#### Message
`cand (account_name)
bio (ipfs_hash/url)
requested_pay`

This action asserts:

 - the message has the permission of the account registering.
 - the `cand` account has agreed to the membership agreement.
 - the candidate is not already registered.
 - `cand` account has transferred sufficient tokens to this contract to satisfy lockup configuration.

Then it inserts the candidate record into the database, making sure to set total_votes to 0 and is_active to true.
This action will assert that candidate is not already a candidate and if they that they are inactive. If they are inactive at the time their record will be made active again and the amount of locked up tokens will be required for the lockup.

### unregcand

Unregister as a candidate, if currently elected as a custodian this account will be removed from the custodian list and initiates the transfer of the locked up tokens back the `cand`.

#### Message
`cand (account_name)`

This action asserts:

 - the message has the permission of the account registering.
 - the `cand` account is currently registered.

Removes the candidate from the candidates table and prepares to transfer the locked up tokens back to the `cand` account.

Sets the candidate record to inactive. All votes cast to this candidate will remain in place but the votes will have not effect until the candidate becomes active again. 

### updatebio

Update the bio for this candidate / custodian. This will be available on the account immediately in preparation for the next election cycle.
#### Message
`cand (account_name)
bio (ipfs_hash/url)`

This action asserts:

 - the message has the permission of the account registering.
 - the account has agreed to the current terms.
 - the `cand` account is currently registered.

The length of the bio must be less than 256 characters.

### updatereqpay

Update the requested pay for this candidate. This will be available on the account in preparation for the next election cycle.

#### Message
`cand (account_name)
requestedpay (asset)`

This action asserts:

 - the message has the permission of the account registering.
 - the account has agreed to the current terms.
 - the `cand` account is currently registered.

Then the candidate's field for `requestedpay` is populated with the amount. If this candidate is elected for the next period this amount will be used as the pay amount for them as a custodian.

### votecust

Update the votes for a configurable number of custodian candidates using preference voting.  The votes supplied will overwrite all existing votes so to remove a vote, simply supply an updated list. An empty array will remove the vote record.

####Message
`voter (name), newvotes ([name])`

This action asserts:

 - the message has the permission of the account registering.
 - Each `cand` account is currently registered and active.
 - the account has agreed to the current terms.
 - Duplicate votes cannot be applied to the same candidate by the same voter.
 - the maximum number of votes is not more than the configured amount (as set by updateconfig).

Then sets the array of accounts for the users active votes which will be used for calculations for the `newperiod` call. Then each candidate's `total_votes` value will updated to reflect the vote change.

### updateconfig

Updates the contract configuration parameters to allow changes without needing to redeploy the source code.

####Message
updateconfig(<params>)
 
This action asserts:

 - the message has the permission of the contract account.
 - the supplied asset symbol matches the current lockup symbol if it has been previously set or that there have been no 	.

The paramters are:

- lockupasset(uint8_t) : defines the asset and amount required for a user to register as a candidate. This is the amount that will be locked up until the user calls `unregcand` in order to get the asset returned to them. If there are currently already registered candidates in the contract this cannot be changed to a different asset type because of introduced complexity of handling the staked amounts.
- maxvotes(asset) : Defines the maximum number of candidates a user can vote for at any given time.
- numelected(uint16_t) : The number of candidates to elect for custodians. This is used for the payment amount to custodians for median amount.
- periodlength(uint32_t) : The length of a period in seconds. This is used for the scheduling of the deferred `newperiod` actions at the end of processing the current one. Also is used as part of the partial payment to custodians in the case of an elected custodian resigning which would also trigger a `newperiod` action.
- tokcontr(name) : The token contract used to manage the tokens for the DAC.
- authaccount(name) : The managing account that controls the whole DAC.
- initial_vote_quorum_percent (uint32) : The percent of voters required to activate the DAC for the first election period. 
- vote_quorum_percent (uint32) : The percent of voters required to continue the DAC for the following election periods after the first one has activated the DAC. 
- auth_threshold_high (uint8) : The number of custodians required to approve an action in the high permission category (exceptional change).
- auth_threshold_mid (uint8) : The number of custodians required to approve an action in the mid permission category ( extraordinary change).
- auth_threshold_low (uint8) : The number of custodians required to approve an action in the low permission category ( ordinary action such as a worker proposal).

### votecust

Create/update the votes for a configurable number of custodian candidates using preference voting. The votes supplied will overwrite all existing votes so to remove a vote, simply supply an updated list. This vote will overwrite any existing vote for either a custodian vote or proxy vote. Supplying an empty array of candidates will remove an existing vote.

#### Message
`account (account_name)
votes (account_name[])`

This action asserts:

 - the message has the permission of the account registering.
 - the `cand` account is currently registered.
 - the account has agreed to the current terms.

For each of the candidates in the votes array, check that the account names are registered as custodian candidates and they are all active.  Assert if any of the accounts are not registered as candidates or are set as inactive.

Save the votes in the `Votes` table, update if the voting account already has a record.
Then update the total votes count for each candidate by removing the voter's token balance from a candidates vote for the old votes (if they exist) and add the voter's token balance to each of the new candidates. 

### voteproxy ( inactive development at the moment to reduce scope for the initial release)

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

This is an action which is designed to be called once every election period (7 day initially).  It will do the following things:

- Distribute custodian pay based on the median of `requestedpay` for all currently elected custodians.
- Prepare a list of the winning custodians for the next period based on the top ranked candidates in the candidates table.
- Update a multi-sig permissions for the controlling DAC account, as set by `authaccount` field in `updateconfig` for the High, Medium and Low permissions.

This action asserts:
- The the action has not been called too soon after the last `newperiod` ran successfully as set by the `periodlength` config in seconds.
- If the `initialvotequorum_percent` has not been met then asserts that enough people have voted to satify the initial quorum.
- After the initial quorum has been reached and the DAC has had a suucessful `newperiod` run it checks the `votequorumpercent` hs been satisfied for ongoing election periods. The percentages are based on the token balance balances of all active votes / `max_supply`

### paypending

This is intended to process the pending payments that have accumulated after `newperiod` has finished processing. Also any staked tokens that need to be returned after a user has called unreg will be returned via this action. This may be redundant now that there is `claimpay` action.


## Tests

The repo includes automated tests to exercise the main action paths in the contract against a running local node.
The tests are included in the tests folder as `rspec` tests in Ruby. 

### Installation
To run the tests you would first need:
- `ruby 2.4.1` or later installed.
- Ruby gems as specified in the `Gemfile`. 
    - These can be installed by running `bundle install` from the project root directory.
Eos installed locally that can be launched via  `nodeos`

There is one action that requires `ttab` which is a nodejs module but this can be easily avoided by a small modification to the rspec tests as detailed in the file. The purpose of using ttab is to start a second tab running nodeos to help diagnose bugs during the test run. 

### To run the tests:
 run `rspec tests/contract_spec.rb` from the project root.
