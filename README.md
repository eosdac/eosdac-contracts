# dacmultisigs
eosDAC multi-signature proposal contract management

##Tables:

### proposals

* proposalid (uint64) - auto-incrementing integer id.
* transactionid (string) - transaction id for a proposed multisig proposal.
* proposer (name) - account name for the user making the proposal
* proposalname (name) - name for the proposal (should follow the character limitations similar to the account names on EOS) 

## Actions

### stproposal
This action is to used to store a pending multisig proposal in a table.

##### Assertions:
* The action must be authorised by the `proposer`

##### Parameters:
    transactionid (string) - transaction id for a proposed multisig proposal.
    proposer (name)        - account name for the user making the proposal
    proposalname (name)    - name for the proposal (should follow the character limitations similar to the account names on EOS)

##### Postconditions:
After success a new proposal will be added to the `proposals` table in this contract.
The proposal id will be derived from an auto-incrementing id in the action. 

