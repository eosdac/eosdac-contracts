<h1 class="contract">
init
</h1>

## ACTION: init
**PARAMETERS:**
* __sender__ is an eosio account name. 
* __receiver__ is an eosio account name. 
* __arb__ is an eosio account name. 
* __expires__ The date/time after which the escrow amount can be refunded by the sender. 
* __memo__ is a memo to send as the eventual transfer memo at the end of the escrow contract. 
* __ext_reference__ is a reference to to external id held my another contract or entity as opposed to the internal auto-incrementing key.

**INTENT** The intent of init is to create an empty escrow payment agreement for safe and secure funds transfer protecting both sender and receiver for a determined amount of time. 
#### Warning: This action will store the content on the chain in the history logs and the data cannot be deleted later so therefore should only store a unidentifiable hash of content rather than human readable content. 

<h1 class="contract">
    transfer
</h1>

## ACTION: transfer
**PARAMETERS:**
* __from__ is an eosio account name. 
* __to__ is an eosio account name. 
* __quantity__ is an eosio asset name. 
* __memo__ is a string that provides a memo for the transfer action.

**INTENT:** 
The intent of transfer is to listen and react to the eosio.token contract's transfer action and ensure the correct parameters have been included in the transfer action.
##Warning: This action will store the content on the chain in the history logs and the data cannot be deleted later.

<h1 class="contract">
approve
</h1>

## ACTION: approve
**PARAMETERS:**
* __key__ is a unique identifying integer for an escrow entry. 
* __approver__ is an eosio account name. 

**INTENT:** 
The intent of approve is to approve the release of funds to the intended receiver.  Only the arbitrator or the sender can call this action, the receiver is assumed to always approve of the release of funds.
 ####Warning: This action will store the content on the chain in the history logs and the data cannot be deleted later.

<h1 class="contract">
 disapprove
</h1>

## ACTION: disapprove
**PARAMETERS:**
* __key__ is a unique identifying integer for an escrow entry. 
* __disapprover__ is an eosio account name. 

**INTENT:** 
The intent of disapprove is to disapprove the release of funds to the intended receiver. Only the appointed arbitrator can call this action and the result will be that the funds contained in the escrow will be returned to the sender, less any arbitration fee.
 ####Warning: This action will store the content on the chain in the history logs and the data cannot be deleted later. 

<h1 class="contract">
  refund
</h1>

## ACTION: refund

**PARAMETERS:**
* __key__ is a unique identifying integer for an escrow entry. 

**INTENT:** The intent of refund is to return the escrowed funds back to the original sender. This action can only be run after the contract has passed the intended expiry time.
**TERM:** This action lasts for the duration of the time taken to process the transaction.


<h1 class="contract">
  cancel
</h1>

## ACTION: cancel

**PARAMETERS:**
* __key__ is a unique identifying integer for an escrow entry. 

**INTENT:** The intent of cancel is to cancel an escrow agreement. This action can only be performed by the sender as long as no funds have already been transferred for the escrow agreement. Otherwise they would need to wait for the expiry time and then use the refund action.
**TERM:** This action lasts for the duration of the time taken to process the transaction.

<h1 class="contract">
  clean
</h1>

## ACTION: clean

**INTENT:** The intent of clean is remove all existing escrow agreements for developer purposes. This can only be run with _self permission of the contract which would be unavailable on the main net once the contract permissions are removed for the contract account.
**TERM:** This action lasts for the duration of the time taken to process the transaction.




