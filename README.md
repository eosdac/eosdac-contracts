# daccustodian - Custodian Elections Contract
This contract will be in charge of custodian registration and voting for candidates.  It will also contain a function which will be called periodically to update the custodian set, and allocate payments.

When a candidate registers, they need to provide a set of configuration variables which will include things like their requested pay.  The system will select the median requested pay when choosing the actual pay.
## Tables

### Candidate

- name (account_name) - Account name of the candidate (INDEX)
- bio (hash) - Link to IPFS file containing structured data about the candidate (schema.org preferred)
- custodian (int8) - Boolean indicating if the candidate is currently elected (INDEX)
- locked (asset) - An asset object representing the number of tokens locked when registering
- requested_pay - The amount of pay requested for this election period
- total_votes - Updated tally of the number of votes cast to a candidate

### CandidateVote

- voter (account_name) - The account name of the voter (INDEX)
- candidates (account_name[]) - The candidates voted for, can supply up to the maximum number of votes (currently 5)
- stake - The amount staked for this voter

## Actions

### regcandidate

Register to be a candidate, accounts must register as a candidate before they can be voted for.  The account must lock 1000 tokens when registering (configurable).

#### Message
`account (account_name)
bio (ipfs_hash/url)
requested_pay`

Check the message has the permission of the account registering, and that account has agreed to the membership agreement
Query the candidate table to see if the account is already registered. If the candidate is already registered then check if new_config is present
Insert the candidate record into the database, making sure to set elected to 0
Check that the message has permission to transfer tokens, assert if not
Transfer the configurable number of tokens which need to be locked to the contract account and assert if this fails

### unregcand

Unregister as a candidate, if currently elected as a custodian this account will be removed from the custodian list.

#### Message
`account (account_name)`

Check the message has permission of the account unregistering
Check that the candidate is in the table, if it is not then assert here
If the candidate is currently elected then mark the existing record as resigned
Remove the candidate from the database if they are not currently elected, also remove all votes cast for them as well as votes by them for ongoing worker proposals
Send the staked tokens back to the account

### updatecustodian

Update the the configuration for this candidate / custodian.  Updated config will take effect from the beginning of the next election cycle.

#### Message
`account (account_name)
bio (ipfs_hash/url)
requested_pay`

Check the message has permission of the account
Check if the custodian is elected, if they are then set new_config to the supplied config object
If they are not elected then update config
If bio is not empty then update the bio

### claimpay

Serving custodians must regularly claim their pay, this will send all the accumulated pay owed to the sender.

#### Message
`account (account_name)`

Check the message has permission of the account
Check if there is a record in the CustodianReward table, if there is not then assert
If the account has an outstanding balance then send it to the account, otherwise assert
Remove the record in the CustodianReward table

### votecust

Update the votes for a configurable number of custodian candidates using preference voting.  The votes supplied will overwrite all existing votes so to remove a vote, simply supply an updated list.

#### Message
`account (account_name)
proxy (account_name)
votes (account_name[])`

Check that the message has voting permission of account 
If proxy is not null then set that account as a proxy for all votes from account
If proxy is NOT set, then for each of the votes, check that the account names are registered as custodian candidates.  Assert if any of the accounts are not registered as candidates
Save the votes in the CandidateVotes table, update if the voting account already has a record

### newperiod

This is an internal action which is designed to be called once every election period (24 hours initially).  It will do the following things;

Distribute custodian pay based on the median of requested pay for all currently elected candidates
Tally the current votes and prepare a list of the winning custodians
Assigns the custodians, this may include updating a multi-sig wallet which controls the funds in the DAC as well as updating DAC contract code

