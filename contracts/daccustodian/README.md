# `daccustodian` - Custodian Elections Contract

This contract will be in charge of custodian registration and voting for candidates. It will also contain a function which could be called periodically to update the custodian set, and allocate payments.

When a candidate registers, they need to provide a set of configuration variables which will include things like their requested pay. The system will select the median requested pay when choosing the actual pay.
The mean pay is to be paid to elected custodians at the end of each period. If an elected custodian resigns via the `withdrawcand` during a period a new candidate will be chosen to fill the gap on the custodian board from the votes ranking in the candidates at that moment.

Eg. 12 custodians are elected and their median `requestedpay` is 100 EOSDAC If one of the custodians resigns partially through a period they will not be paid for that partial period. The mean pay amount will be calculated based on the current elected custodians `requestedpay` value. If a candidate changes their requested pay it will not be included in the pay calculation until the next period if they are re-elected.

All of the active actions require a `dac_id (account_name)` parameter to be passed which is used to scope the DAC. This is the mechanism that the contracts use to facilitate hosting multiple DACs within the same codebase and enables all of these DACs to get all the future software updates instantly without having to copy and deploy their own version of the contract code.

## Tables

### candidates

- candidate_name (name) - Account name of the candidate (INDEX)
- isactive (int8) - Boolean indicating if the candidate is currently available for election. (INDEX)
- locked_tokens (asset) - An asset object representing the number of tokens locked when registering
- requestedpay (asset) - The amount of pay requested by the candidate to be paid if they were elected for the following period.
- total_votes (uint64) - Updated tally of the number of votes cast to a candidate. This is updated and used as part of the `newperiod` calculations. It is updated every time there is a vote change or a change of token balance for a voter for this candidate to facilitate live voting stats.

### custodians

- cust_name (name) - Account name of the custodian (INDEX)
- requestedpay - The amount of pay requested by the candidate to be paid as an elected custodian for the current period.
- total_votes - Tally of the number of votes cast to a custodian when they were elected in. This is updated as part of the `newperiod` action.

### votes

- voter (account_name) - The account name of the voter (INDEX)
- proxy (account_name) - Name of another voter used to proxy votes through. This should not have a value in both the proxy and candidates at the same time.
- candidates (account_name[]) - The candidates voted for, can supply up to the maximum number of votes (currently 5) - Can be configured via `updateconfig`

### pendingpay

- key (uint64) - auto incrementing id to identify a payment due to a custodian
- receiver (account_name) - The account name of the intended receiver.
- quantity (asset) - The amount for the payment.
- memo (string) - A string used in the memo to help the receiver identify it in logs.

### proxies

- proxy (name) - the EOS account name for a vaild proxy.
- total_weight (int64) - The current vote power that this has.

### configs

- lockupasset (extended_asset) - The amount of assets that are locked up by each candidate applying for election.
- maxvotes (int default=5) - The maximum number of votes that each member can make for a candidate.
- numelected (int) - Number of custodians to be elected for each election count.
- periodlength (uint32 = 7 _ 24 _ 60 \* 60) - Length of a period in seconds. Used for pay calculations if an early election is called and to trigger deferred `newperiod` calls.
- should_pay_via_service_provider (bool) - a toggle to indicate if the pay should go via a financial service provider or directly to the payee.
- initial_vote_quorum_percent (uint32) - Amount of token value in votes required to trigger the initial set of custodians
- vote_quorum_percent (uint32) - Amount of token value in votes required to trigger the allow a new set of custodians to be set after the initial threshold has been achieved.
- auth_threshold_high (uint8) - Number of custodians required to approve highest level actions.
- auth_threshold_mid (uint8) - Number of custodians required to approve highest level actions.
- auth_threshold_low (uint8) - Number of custodians required to approve highest level actions.
- lockup_release_time_delay (date) - The time before locked up stake can be released back to the candidate using the unstake action
- requested_pay_max (asset) - The max amount a custodian can requested as a candidate.

## Actions

---

### appointcust

##### Assertions:

##### Parameters:

    cust 	- Custodian account name
    dac_id	- The ID for the DAC that is appointing custodian

##### Post Condition:

### balanceobsv

##### Assertions:

##### Parameters:

    account_balance_deltas	-
    dac_id			-

##### Post Condition:

### capturestake

##### Assertions:

##### Parameters:

    from		-
    quantity	-
    dac_id		-

##### Post Condition:

### clearold

##### Assertions:

##### Parameters:

    batch_size	-

##### Post Condition:

### clearstake

##### Assertions:

##### Parameters:

    cand		- The account id for the candidate nominating.
    new_value	-
    dac_id		- The ID for the DAC

##### Post Condition:

### migrate

##### Assertions:

##### Parameters:

    batch_size	-

##### Post Condition:

### rejectcuspay

##### Assertions:

##### Parameters:

    payid 		-
    dac_id		-

##### Post Condition:

### removecuspay

##### Assertions:

##### Parameters:

    payid 		-
    dac_id		-

##### Post Condition:

### runnewperiod

##### Assertions:

##### Parameters:

    message		-
    dac_id		-

##### Post Condition:

### setperm

##### Assertions:

##### Parameters:

    cand		- The account id for the candidate nominating.
    permission	-
    dac_id		- The ID for the DAC

##### Post Condition:

### stakeobsv

##### Assertions:

##### Parameters:

    account_stake_deltas	-
    dac_id			- The ID for the DAC

##### Post Condition:

### stprofile

##### Assertions:

##### Parameters:

    cand		- The account id for the candidate nominating.
    profile		-
    dac_id		- The ID for the DAC

##### Post Condition:

### stprofileuns

##### Assertions:

##### Parameters:

    cand 		- The account id for the candidate nominating.
    profile		-

##### Post Condition:

### transferobsv

##### Assertions:

##### Parameters:

    from		-
    to		-
    quantity	-
    dac_id		- The ID for the DAC

##### Post Condition:

### weightobsv

##### Assertions:

##### Parameters:

    account_weight_deltas	-
    dac_id			- The ID for the DAC

##### Post Condition:

### nominatecand

### nominatecande

This action is used to nominate a candidate for custodian elections. It must be authorised by the candidate and the candidate must be an active member of the DAC, having agreed to the latest constitution. The candidate must have transferred a number of tokens (determined by a config setting - `lockupasset`) to the contract for staking before this action is executed. This could have been from a recent transfer with the contract name in the memo or from a previous time when this account had nominated, as long as the candidate had never `unstake`d those tokens.

##### Assertions:

- The account performing the action is authorised.
- The candidate is not already a nominated candidate.
- The requested pay amount is not more than the config max amount.
- The requested pay symbol type is the same from config max amount ( The contract supports only one token symbol for payment).
- The candidate is currently a member or has agreed to the latest constitution.
- The candidate has transferred sufficient funds for staking if they are a new candidate.
- The candidate has enough staked if they are re-nominating as a candidate and the required stake has changed since they last nominated.

##### Parameters:

    cand  			- The account id for the candidate nominating.
    requestedpay  	- The amount of pay the candidate would like to receive if they are elected as a custodian. This amount must not exceed the maximum allowed amount of the contract config parameter (`requested_pay_max`) and the symbol must also match.
    dac_id (name) - for DAC scoping

##### Post Condition:

The candidate should be present in the candidates table and be set to active. If they are a returning candidate they should be set to active again. The `locked_tokens` value should reflect the total of the tokens they have transferred to the contract for staking. The number of active candidates in the contract will be incremented.

---

### withdrawcande

This action is used to withdraw a candidate from being active for custodian elections.

#### Assertions:

- The account performing the action is authorised.
- The candidate is already a nominated candidate.

##### Parameters:

    cand  - The account id for the candidate nominating.
    dac_id (name) - for DAC scoping

##### Post Condition:

The candidate should still be present in the candidates table and be set to inactive. If the were recently an elected custodian there may be a time delay on when they can unstake their tokens from the contract. If not they will be able to unstake their tokens immediately using the unstake action.

---

### resigncust

This action is used to resign as a custodian.

##### Assertions:

- The `cust` account performing the action is authorised to do so.
- The `cust` account is currently an elected custodian.

##### Parameters:

    cust  - The account id for the candidate nominating.
    dac_id (name) - for DAC scoping

##### Post Condition:

The custodian will be removed from the active custodians and should still be present in the candidates table but will be set to inactive. Their staked tokens will be locked up for the time delay added from the moment this action was called so they will not able to unstake until that time has passed. A replacement custodian will be selected from the candidates to fill the missing place (based on vote ranking) then the auths for the controlling DAC auth account will be set for the custodian board.

---

### updatebio

Update the bio for this candidate / custodian. This will be available on the account immediately in preparation for the next election cycle.

##### Assertions:

- the message has the permission of the account registering.
- the account has agreed to the current terms.
- the `cand` account is currently registered.
- the length of the bio must be less than 256 characters.

##### Parameters

    cand - The account id for updating profile
    bio - Bio content
    dac_id (name) - for DAC scoping

---

### updatereqpaye

This action is used to update the requested pay for a candidate.

##### Assertions:

- The `cand` account performing the action is authorised to do so.
- The candidate is currently registered as a candidate.
- The requestedpay is not more than the requested pay amount.

##### Parameters:

     cand          - The account id for the candidate nominating.
     requestedpay  - A string representing the asset they would like to be paid as custodian.
     dac_id (name) - for DAC scoping

##### Post Condition:

The requested pay for the candidate should be updated to the new asset.

---

### votecust

This action is to facilitate voting for candidates to become custodians of the DAC. Each member will be able to vote a configurable number of custodians set by the contract configuration. When a voter calls this action either a new vote will be recorded or the existing vote for that voter will be modified. If an empty array of candidates is passed to the action an existing vote for that voter will be removed.

##### Assertions:

- The voter account performing the action is authorised to do so.
- The voter account performing has agreed to the latest member terms for the DAC.
- The number of candidates in the newvotes vector is not greater than the number of allowed votes per voter as set by the contract config.
- Ensure there are no duplicate candidates in the voting vector.
- Ensure all the candidates in the vector are registered and active candidates.

#### Parameters:

    voter     - The account id for the voter account.
    newvotes  - A vector of account ids for the candidate that the voter is voting for.
    dac_id (name) - for DAC scoping

##### Post Condition:

An active vote record for the voter will have been created or modified to reflect the newvotes. Each of the candidates will have their total_votes amount updated to reflect the delta in voter's token balance. Eg. If a voter has 1000 tokens and votes for 5 candidates, each of those candidates will have their total_votes value increased by 1000. Then if they change their votes to now vote 2 different candidates while keeping the other 3 the same there would be a change of -1000 for 2 old candidates +1000 for 2 new candidates and the other 3 will remain unchanged.

---

### voteproxy

Create/update the active vote to proxy through another voter. This vote will overwrite any existing vote for either a custodian vote or proxy vote.

#### Message

```c
account (account_name)
proxy (account_name)
dac_id (account_name)
```

This action asserts:

- the message has the permission of the account registering.
- the `cand` account is currently registered.
- the account has agreed to the current terms.
- the vote is not proxying to themselves as a proxy.
- the vote is not proxying to another proxy.

Save the votes in the `votes` table, update if the voting account already has a record. Then upsert the vote values in the proxy table based on the balance of the voter and update the vote weight for the proxy's voted candidates.

---

### regproxy

Create a record in the proxies table for a new proxy with a proxy weight of 0.

#### Message

```c
proxy_member (account_name)
dac_id (account_name)
```

This action asserts:

- the message has the permission of the account registering.
- the `proxy_member` account is currently registered.
- the `proxy_member` has agreed to the current terms.
- the `proxy_member` is already a registered proxy.

If successful a new record should be added to the proxy table which is then used to track cumulative proxy weight from proxy voters.

---

### updateconfig

## unregproxy

Removes a proxy record from the proxy table and removes the proxy's vote weight from running candidates.

#### Message

```c
proxy_member (account_name)
dac_id (account_name)
```

This action asserts:

- the message has the permission of the account registering.
- the `proxy_member` account is not currently registered.

If successful a the existing proxy record will be removed from the proxy table and the associated vote weight for that proxy will be removed from the candidates that the proxy has voted for.

---

### updateconfig

Updates the contract configuration parameters to allow changes without needing to redeploy the source code.

#### Message

updateconfig(<params>)

This action asserts:

- the message has the permission of the contract account.
- the supplied asset symbol matches the current lockup symbol if it has been previously set or that there have been no .

The parameters are:

- lockupasset(uint8_t) : defines the asset and amount required for a user to register as a candidate. This is the amount that will be locked up until the user calls `withdrawcand` in order to get the asset returned to them. If there are currently already registered candidates in the contract this cannot be changed to a different asset type because of introduced complexity of handling the staked amounts.
- maxvotes(asset) : Defines the maximum number of candidates a user can vote for at any given time.
- numelected(uint16_t) : The number of candidates to elect for custodians. This is used for the payment amount to custodians for median amount.
- periodlength(uint32_t) : The length of a period in seconds. This is used for the scheduling of the deferred `newperiod` actions at the end of processing the current one. Also is used as part of the partial payment to custodians in the case of an elected custodian resigning which would also trigger a `newperiod` action.
- initial_vote_quorum_percent (uint32) : The percent of voters required to activate the DAC for the first election period.
- vote_quorum_percent (uint32) : The percent of voters required to continue the DAC for the following election periods after the first one has activated the DAC.
- auth_threshold_high (uint8) : The number of custodians required to approve an action in the high permission category (exceptional change).
- auth_threshold_mid (uint8) : The number of custodians required to approve an action in the mid permission category ( extraordinary change).
- auth_threshold_low (uint8) : The number of custodians required to approve an action in the low permission category ( ordinary action such as a worker proposal).
- dac_id (name) - for DAC scoping

---

### newperiod

This action is to be run to end and begin each period in the DAC life cycle. It performs multiple tasks for the DAC including:

- Allocate custodians from the candidates tables based on those with most votes at the moment this action is run. -- This action removes and selects a full set of custodians each time it is successfully run selected from the candidates with the most votes weight. If there are not enough eligible candidates to satisfy the DAC config numbers the action adds the highest voted candidates as custodians as long their votes weight is greater than 0. At this time the held stake for the departing custodians is set to have a time delayed lockup to prevent the funds from releasing too soon after each custodian has been in office.
- Distribute pay for the existing custodians based on the configs into the pending pay table so it can be claimed by individual candidates. -- The pay is distributed as determined by the median pay of the currently elected custodians. Therefore all elected custodians receive the same pay amount.
- Set the DAC auths for the intended controlling accounts based on the configs thresholds with the newly elected custodians. This action asserts unless the following conditions have been met:
- The action cannot be called multiple times within the period since the last time it was previously run successfully. This minimum time between allowed calls is configured by the period length parameter in contract configs.
- To run for the first time a minimum threshold of voter engagement must be satisfied. This is configured by the `initial_vote_quorum_percent` field in the contract config with the percentage calculated from the amount of registered votes cast by voters against the max supply of tokens for DAC's primary currency.
- After the initial vote quorum percent has been reached subsequent calls to this action will require a minimum of `vote_quorum_percent` to vote for the votes to be considered sufficient to trigger a new period with new custodians.

##### Parameters:

##### Assertions:

##### Parameters:

     message 	- a string that is used to log a message in the chain history logs. It serves no function in the contract logic.
     dac_id  	- The ID for the DAC

##### Post Condition:

---

### claimpay

This action is to claim pay as a custodian.

##### Assertions:

- The caller to the action account performing the action is authorised to do so.
- The payid is for a valid pay record in the pending pay table.
- The caller account is the same as the intended destination account for the pay record.

##### Parameters:

     payid - The id for the pay record to claim from the pending pay table.
     dac_id (name) - for DAC scoping

Post Condition:

The quantity owed to the custodian as referred to by the pay record is transferred to the claimer and then the pay record is removed from the pending pay table.

---

### unstakee

This action is used to unstake a candidates tokens and have them transferred to their account.

##### Assertions:

- The candidate was a nominated candidate at some point in the past.
- The candidate is not already a nominated candidate.
- The tokens held under candidate's account are not currently locked in a time delay.

##### Parameters:

    cand  - The account id for the candidate nominating.
    dac_id (name) - for DAC scoping

##### Post Condition:

The candidate should still be present in the candidates table and should be still set to inactive. The candidates tokens will be transferred back to their account and their `locked_tokens` value will be reduced to 0.

---

### firecand

This action is used to remove a candidate from being a candidate for custodian elections.

##### Assertions:

- The action is authorised by the mid level permission the auth account for the contract.
- The candidate is already a nominated candidate.

##### Parameters

     cand	 - The account id for the candidate nominating.
     lockupStake - if true the stake will be locked up for a time period as set by the contract config `lockup_release_time_delay`
     dac_id (name) - for DAC scoping

##### Post Condition:

The candidate should still be present in the candidates table and be set to inactive. If the `lockupstake` parameter is true the stake will be locked until the time delay has passed. If not the candidate will be able to unstake their tokens immediately using the unstake action to have them returned.

---

### firecust

This action is used to remove a custodian.

##### Assertions:

- The action is authorised by the mid level of the auth account (currently elected custodian board).
- The `cust` account is currently an elected custodian.

##### Parameters:

     cand - The account id for the candidate nominating.
     dac_id (name) - for DAC scoping

##### Post Condition:

The custodian will be removed from the active custodians and should still be present in the candidates table but will be set to inactive. Their staked tokens will be locked up for the time delay added from the moment this action was called so they will not able to unstake until that time has passed. A replacement custodian will be selected from the candidates to fill the missing place (based on vote ranking) then the auths for the controlling dac auth account will be set for the custodian board.

---

### paycpu

This action does nothing except check that it has the authorisation of the authority account and that the `max_cpu_usage_ms` of the transaction is less than 5 but not 0.

##### Assertions:

- The action is authorised by the authority account.
- 0 < `max_cpu_usage_ms` <= 5

##### Parameters:

     dac_id - The dac_id, the action must provide authorisation of the authority account of this DAC.

##### Post Condition:

If this action is the first in a transaction then the authority account of the DAC will be billed for the CPU / NET of the transaction.

---

# Compile

The contract code has some compile time constants used for configuration. As a compile time constant the code has more flexibility for reuse on other DACs, and an extra layer of safety over exposing another configuration variable which could be changed after the code has been set and the ability to unit test the code without needing to modify the source just for testing.
The available compile time flags are:

- TOKENCONTRACT (default = "eosdactokens") - This is to set the associated token contract to inter-operate with for tracking voting weights, registered members and staking.
- VOTING_DISABLED (default = false) - Setting this flag will disable the ability for anyone to vote for custodians by disabling the vote action.
- TRANSFER_DELAY (default = 60 \* 60) - for configuring the time delay on token transfers from the contract

When put all together a compile command with all the bells and whistles might look like:

```bash
eosio-cpp -DTRANSFER_DELAY=3600 -DVOTING_DISABLED -o daccustodian.wasm daccustodian.cpp
```

> **Note:** Since there are default values for the above flags they do not all need to be included to compile successfully.

---

# Tests

The tests have been re-written to run with lamington in typescript. This provides a much better type-safety since the typescript objects that intereact with the contract and generated from the installed contract ABI and the test actions run through EOSJS which is a more common real life usecase than using `cleos` as the ruby tests were doing.

### Installation

Due to some customisations I have made to Lamington to suit my needs to tests use a local version of Lamington which is hosted in EOSDAC at https://github.com/eosdac/lamington. The changes will soon be updated so it can run via a normal npm install either original Lamington source or via a forked npm module. In the mean time check out Lamington locally from EOSDAC and run the local version as if a Lamington contributer would using npm link (further docs for this are available in the Lamington docs)

### Run the tests from the project root with:

```bash
`npm run-script test verbose`
```
