<h1 class="contract">
stprofile
</h1>

## ACTION: stprofile
**PARAMETERS:**
* __cand__ is an eosio account name. 
* __profile__ is a string that provides a hash of the details of the candidate.

**INTENT** The intent of stprofile is to record an update the user's profile. 
#### Warning: This action will store the content on the chain in the history logs and the data cannot be deleted later so therefore should only store a unidentifiable hash of content rather than human readable content. 

<h1 class="contract">
    stprofileuns
</h1>

## ACTION: stprofileuns
**PARAMETERS:**
* __cand__ is an eosio account name. 
* __profile__ is a string that provides a hash of the details of the candidate.

**INTENT:** 
The intent of stprofileuns is to record an update the user's profile.  ##Warning: This action will store the content on the chain in the history logs and the data cannot be deleted later.

<h1 class="contract">
updatebio
</h1>

## ACTION: updatebio
**PARAMETERS:**
* __cand__ is an eosio account name. 
* __profile__ is a string that provides a hash of the details of the candidate.

**INTENT:** 
The intent of updatebio is to record an update the user's bio. Unlike `stprofileuns` this action does not require auth of the cand to execute.
 ####Warning: This action will store the content on the chain in the history logs and the data cannot be deleted later. 
 
<h1 class="contract">
 firecust
</h1>

## ACTION: firecust
**PARAMETERS:**
* __cand__ is an eosio account name.

**INTENT:** The intent of firecust is to allow elected custodians to (where quorum and configured majorities are met) to remove a fellow custodian and lock up their tokens until the configured delay period has passed.
**TERM:** This action lasts for the duration of the time taken to process the transaction.
 
<h1 class="contract">
  resigncust
</h1>
 ## ACTION: resigncust
**PARAMETERS:**
* __cust__ is an eosio account name.

**INTENT:** The intent of resigncust is to remove an elected custodian. This action must be run by the resigning custodian and the outcome should remove the elected custodian and lock up their tokens until the delay period has passed so the tokens can be claimed with the unstake action.
**TERM:** This action lasts for the duration of the time taken to process the transaction.

<h1 class="contract">
  firecand
</h1>

## ACTION: firecand
**PARAMETERS:**
* __cand__ is an eosio account name. 
* __lockupStake__ is an indicator to show whether stake is being locked up or not

**INTENT:** 
The intent of forehand is to set a candidate to a state of inactive so they will be excluded from the next election round. This action may only be run by the by elected custodians (where quorum and configured majorities are met). There is an option to lock up the candidate's tokens until a delay period has passed based on the delay set in the config after which the tokens can be claimed with the unstake action. If the option passed is false and there is an existing lockup delay on the tokens then this lockup will continue to be active until the lock up time has passed.

**TERM:** This action lasts for the duration of the time taken to process the transaction.

<h1 class="contract">
  unstake
</h1>

## ACTION: unstake
**PARAMETERS:**
* __cand__ is an eosio account name.

**INTENT** The intent of unstake is to return staked tokens back to the candidate if the user is no longer an active candidate and there is no delay set on the candidate the staked tokens will be returned to the candidate.
**TERM:** This action lasts for the duration of the time taken to process the transaction.

<h1 class="contract">
  updateconfig
</h1>

 ## ACTION: updateconfig
**PARAMETERS:**
* __lockupasset__ is an asset to be locked up as part of the nominating process for a custodian passed to the action in the format: \"10.0000 EOSDAC\". default value: \"10.0000 EOSDAC\"
* __maxvotes__ is a integer to configure the maximum number of allowed votes for a nominated member in any single voting action. The default value is 5.
* __numelected__ is a integer to configure the number of candidates that will be elected as custodians of the DAC. default value is 12.
* __periodlength__ the length of office of a custodian vote (in seconds) before a new period . Default to 7 days. 
* __authaccount__ The authorised account to change the contract which should be protected via a multisig of custodians, 
* __tokenholder__ The account that controls the funds for the DAC. 
* __initial_vote_quorum_percent__ The percent of voters required to activate the DAC for the first election period. 
* __auth_threshold_high__ percentage of votes of custodians required to approve highest level actions. 
* __auth_threshold_mid__ percentage of votes of custodians required to approve medium level actions.
* __auth_threshold_low__ percentage of votes of custodians required to approve lowest level actions.
* __lockup_release_time_delay__ The time before locked up stake can be released back to the candidate using the unstake action.
* __asset requested_pay_max__ 

**INTENT:** The intent of {{ updateconfig }} is update the configuration for the running contract of selected parameters without needing change the source code. This requires a privileged account.
**TERM:** The action sets the configuration until it is set by a subsequent updateconfig action.

<h1 class="contract">
  nominatecand
</h1>

## ACTION: nominatecand
**PARAMETERS:**
* __cand__ is an account_name parameter for the nominating candidate.
* __requestedpay__ is an asset requested by the candidate as pay for being an elected custodian. It should be passed to the action in the format: \"10.0000 EOSDAC\".

**INTENT:** The intent of {{ nominatecand }} is to nominates a candidate to custodian election, Accounts must nominate as a candidate before they can be voted for. The candidate must lock a configurable number of tokens before trying to nominate (configurable via {{ updateconfig }} in the parameter lockupasset which will be sent from the token contract as defined and set in the code of the contract. If a user previously been a candidate they may have enough staked tokens to not require further staking but will otherwise need to transfer the difference to meet the required stake. 

**TERM:** A candidate remains a candidate until they are removed from candidate status by a subsequent transaction.

<h1 class="contract">
  withdrawcand
</h1>

## ACTION: withdrawcand
**PARAMETERS:**
* __cand__ is an account_name parameter for the nominating candidate.

**INTENT:** The intent of withdrawcand is to withdraw a candidate for becoming an elected custodian. The action ensures the {{ cand }} account is currently nominated. On success the amount of tokens that was locked up via the {{ nominatecand }} action will be added to a list of pending transactions to transfer back to the {{ cand }} account. The actual transfer would be performed by a separate action due to the auth requirement for sending funds from the contract's account.

**TERM:** The account will no longer be a candidate unless they it is nominated again.

## ACTION: updatebio
**PARAMETERS:**
* __cand__ is an account_name parameter for the nominating candidate.
* __bio__ is a string representing a bio for candidate. This should be a hash or a link where data is under the control of the individual.

**INTENT:** The intent of updatebio is to allow a candidate update their bio information after they have nominated. The action ensures the user has agreed to the latest terms and conditions, has the correct authorization of the {{ cand }} to perform the action and is already nominated as a candidate. Then the bio information for the candidate will be updated leaving all other data of the candidate unchanged.

**WARNING:** The action records information on the blockchain and hence should not include directly entered personally identifiable information. Instead hashes or links under the control of the individual should be used.

<h1 class="contract">
  updatereqpay
</h1>

## ACTION: updatereqpay
**PARAMETERS:**
* __cand__ is an account_name parameter for the nominating candidate.
* __requestedpay__ is an asset requested by the candidate as pay for being an elected custodian. It should be passed to the action in the format: \"10.0000 EOSDAC\".

**INTENT:** The intent of updatereqpay is to allow a candidate update their requested pay after they have nominated. The action ensures the user has agreed to the latest terms and conditions, has the correct authorization of the {{ cand }} to perform the action and is already nominated as a candidate.  All other data of the candidate will remain unchanged. If the custodian is elected, this requested pay is used along with other elected custodians requested pay to determine the level of pay for custodians

**TERM:** The action changes the values until superseded by another action.

<h1 class="contract">
  votecust
</h1>

## ACTION: votecust
**PARAMETERS:**
* __voter__ is an eosio account_name parameter for the voting member.
* __newvotes__ is an array of nominated candidates account names that the voter intends to vote for with a maximum number of votes as configured by the contract.

**INTENT:** The intent of votecust is to allow a member of the DAC to vote for candidates that are eligible become custodians after the next call to {{ newperiod }}. The action ensures the user has agreed to the latest terms and conditions and has the correct authorization of the account: {{ voter }} to place or change an active vote. Upon success this action will either update an existing vote with a new set of candidates or create a new active vote for the {{ voter }} for candidates eligible for election. This action will replace an existing vote for a proxy for {{ voter }} if one exists. 

**TERM:** The action changes the preferred custodians for an account until superseded by another action.

<h1 class="contract">
  voteproxy
</h1>

## ACTION: voteproxy
**PARAMETERS:**
* __voter__ is an eosio account_name .
* __proxy__ is an account name that the voter intends to vote for with a maximum number of votes as configured by the contract.

**INTENT:** The intent of voteproxy is to vote another single voter account that may vote with {{ voter }} weight for custodians as a proxy. The action ensures the {{ voter }} has agreed to the latest terms and conditions and has the correct authorization of the {{ voter }} to place or change an active vote. Upon success this action will either update an existing {{ proxy }} vote or create a new active vote for {{ proxy }}. This action will replace an existing vote for a custodians as created by the votecust action if one exists. This action will fail if {{ voter }} attempts to vote for a user who is already voting for a proxy or if they attempt to proxy vote for themselves.

**TERM:** The action changes the proxy until superseded by another action.

<h1 class="contract">
  newperiod
</h1>

## ACTION: newperiod
**PARAMETERS:**
* __message__ is string used only for logging in the blockchain history and serves no purpose in the action contract logic.

**INTENT:** The intent of {{ newperiod }} is to signal the end of one election period and commence the next. It performs several actions after the following conditions are met:
 * The action is not called before the period should have ended
 * Enough voter value has participated to trigger the initial running of the DAC
 * After the Dac has started enough voter value has continued engagement with the dac voting process. 
1. Calculate the mean `requestedpay` of all the currently elected custodians.
2. Distribute the median pay amount to all the currently elected custodians. This is achieved by adding a record to the `pendingpay` table with the custodian and the amount payable in preparation for an authorised action to `claimpay`.
3. Captures the highest voted candidates to set them as the custodians for the next period based on the accumulated vote weight.
4. Set the permissions for the elected custodians so they have sufficient permission to run the dac according to the constitution and technical permissions design.
5. Set the time for the beginning of the next period to mark the reset anniversary for the dac. 

**TERM:** The action changes the relevant contract data until a subsequent newperiod is called.

<h1 class="contract">
  claimpay
</h1>

## ACTION: claimpay
**PARAMETERS:**
* __claimer__ account claiming the pay. This account must match the destination account for which the claim is for.

**INTENT:** The intent of {{ claimpay }} is to allow an account to claim pending payment amounts due to the account. The pay claim they are claiming needs to be visible in the `pendingpay` table. transfers to the claimer via an inline transfer on the eosdactoken contract and then removes the pending payment record from the `pending_pay` table. The active auth of this claimer is required to complete this action.

**TERM:** This action lasts for the duration of the time taken to process the transaction.
