<h1 class="contract">
regdac
</h1>

## ACTION: <regdac>
**PARAMETERS:**
* __owner__ is an eosio account name for the owner account of the DAC. 
* __dac_name__ is an eosio account name uniquely identifying the DAC. 
* __dac_symbol__ is an eosio symbol name representing the primary token used in the DAC. 
*  __title__ is a string that for the title of the DAC.
* __refs__
* __accounts__ a map of the key accounts used in the DAC
s
**INTENT** The intent of regdac register a new DAC with all the required key accounts 
#### Warning: This action will store the content on the chain in the history logs and the data cannot be deleted later so therefore should only store a unidentifiable hash of content rather than human readable content. 

<h1 class="contract">
    unregdac
</h1>

## ACTION: unregdac
**PARAMETERS:**
* __dac_name__ is an eosio account name uniquely identifying the DAC. 

**INTENT:** 
The intent of unregdac is to unregister the DAC from the directory.

<h1 class="contract">
regaccount
</h1>

## ACTION: regaccount
**PARAMETERS:**
* __dac_name__ is an eosio account name uniquely identifying the DAC. 
* __account__ is an eosio account name to be associated with the DAC
* __type__ a number representing type of the association with the DAC

**INTENT:** 
The intent of regaccount is create a releationship between an eosio account and the DAC for a particular purpose.
 ####Warning: This action will store the content on the chain in the history logs and the data cannot be deleted later. 
 
<h1 class="contract">
 unregaccount
</h1>

## ACTION: unregaccount
**PARAMETERS:**
* __dac_name__ is an eosio account name uniquely identifying the DAC. 
* __type__ a number representing type of the association with the DAC

**INTENT:** The intent of unregaccount is remove a relationship between an account and a DAC.
**TERM:** This action lasts for the duration of the time taken to process the transaction.

<h1 class="contract">
regref
</h1>

## ACTION: regref
**PARAMETERS:**
* __dac_name__ is an eosio account name uniquely identifying the DAC. 
* __account__ a string, format depends on the type and is not validated by the contract
* __type__ a number representing type of the association with the DAC

**INTENT:** 
The intent of regref is to register an arbitratry piece of data about a particular DAC.
 ####Warning: This action will store the content on the chain in the history logs and the data cannot be deleted later. 
 
<h1 class="contract">
 unregref
</h1>

## ACTION: unregref
**PARAMETERS:**
* __dac_name__ is an eosio account name uniquely identifying the DAC. 
* __type__ a number representing type of the association with the DAC

**INTENT:** The intent of unregref is remove a remove a reference from the DAC data.
**TERM:** This action lasts for the duration of the time taken to process the transaction.
 
<h1 class="contract">
  setowner
</h1>

 ## ACTION: setowner
**PARAMETERS:**
* __dac_name__ is an eosio account name uniquely identifying the DAC.
* __account__ is an eosio account name to used as the owner of the DAC

**INTENT:** The intent of setowner change the owner account for a DAC.
**TERM:** This action lasts for the duration of the time taken to process the transaction.
