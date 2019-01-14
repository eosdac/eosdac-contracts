<h1 class="contract">
createprop
</h1>

## ACTION: createprop
**PARAMETERS:**
* __proposer__ is an eosio account name.
* __title__ is a string that provides a title for the proposal.
* __summary__ is a string that provides a summary for the proposal.
* __arbitrator__ is an eosio account name for a nominated arbitrator on the proposal.
* __pay_amount__ is an eosio asset amount representing the requested pay amount for the worker proposal.
* __content_hash__ is a string that provides a hash of the details of the proposal.

**INTENT** The intent of createprop is to enter a new worker proposal.
#### Warning: This action will store the content on the chain in the history logs and the data cannot be deleted later so therefore should only store a unidentifiable hash of content rather than human readable content. 

<h1 class="contract">
    voteprop
</h1>

## ACTION: voteprop
**PARAMETERS:**
* __custodian__ is an eosio account name.
* __proposal_id__ is an integer id for an existing proposal for the custodian to vote on.
* __vote__ is an integer repesenting a vote type on the proposal.

**INTENT:** 
The intent of voteprop is to record a vote on an existing proposal.

<h1 class="contract">
startwork
</h1>

## ACTION: startwork
**PARAMETERS:**
* __proposer__ is an eosio account name.
* __proposal_id__ is an integer id for an existing proposal for the custodian to vote on.

**INTENT:** 
The intent of startwork is to indicate the intention for the proposer to start work on an existing proposal.

<h1 class="contract">
claim
</h1>

## ACTION: claim
 **PARAMETERS:**
 * __proposer__ is an eosio account name.
 * __proposal_id__ is an integer id for an existing proposal for the proposer to claim.

 **INTENT:**
 The intent of claim is to indicate the proposer has completed the required work for a worker proposal and would like to claim the escrowed funds as payment.

 <h1 class="contract">
 cancel
 </h1>

 ## ACTION: cancel
  **PARAMETERS:**
  * __proposer__ is an eosio account name.
  * __proposal_id__ is an integer id for an existing proposal for the proposer to cancel.

  **INTENT:**
  The intent of cancel is to cancel a proposal.

<h1 class="contract">
 updateconfig
</h1>

## ACTION: updateconfig
**PARAMETERS:**
* __new_config__ is a config_type object to update the settings for the contract.

**INTENT:** The intent of updateconfig is to update the contract settings within the contract.
The fields in the config object the their default values are:
* name service_account - The service account to manage the escrow funds for worker proposals.
* uint16_t proposal_threshold = 7 - The number of required votes to make a decision on approving a worker proposal submission.
* uint16_t proposal_approval_threshold_percent = 50 - The percent threshold required to approve a proposal submission.
* uint16_t claim_threshold = 5 - The number of required votes to make a decision on approving a claim for a worker proposal.
* uint16_t claim_approval_threshold_percent = 50 - The percent threshold required to approve for a proposal claim.

**TERM:** This action lasts for the duration of the time taken to process the transaction.
