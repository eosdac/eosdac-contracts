# dacmultisigs
eosDAC multi-signature proposal contract management.  This contract keeps a record of system-level multisig proposals which are of interest to the custodians of a DAC.  At the same time (preferably in the same transaction) as the initial eosio.msig proposal, the custodian should call the `proposed` action with some metadata about the proposal.  The `proposed` action will record the details about the proposal as well as the transaction id in the `proposals` table.

Off-chain processes can then read the transaction id from the database and then fetch the transaction referenced and read the metadata.

Approvals, cancellations etc must also be notified, this will update the `modifieddate` entry in the database.  Proposals without any activity in 2 weeks can be removed from the database to free RAM using the `clean` action.

## Tables:

### proposals
Stored in the scope of the respective

* `proposalname` (name) - name for the proposal (should follow the character limitations similar to the account names on EOS)
* `transactionid` (string) - transaction id containing the metadata for a proposal.
* `modifieddate` (uint32) - timestamp of last activity on this proposal, used to allow cleaning of abandoned proposals

## Actions

### proposed
Should be called after proposing to the system multisig contract, the metadata will be ignored and the current transaction id will be stored so that external tools can fetch the metadata.

##### Assertions:
* The action must be authorised by the `proposer` and `dacauthority@one` (ie they must be a currently elected custodian).  There must be an entry in the eosio.msig `proposal` table with the scope of the proposer and primary key of the `proposal_name`

##### Parameters:
* `proposer` (name)        - account name for the user making the proposal
* `proposal_name` (name)    - name for the proposal (should follow the character limitations similar to the account names on EOS, but can be less than 12 characters)
* `metadata` (string)      - JSON string with metadata about the proposal.  Currently the metadata should be a JSON string with `name` and `description` properties.

##### Postconditions:

After success a new proposal will be added to the `proposals` table in this contract, with the current transaction id.

### approved
Signals that a proposal has been approved on the system msig contract.

#### Assertions:
* The action must be authorised by the `approver` and `dacauthority@one` (ie they must be a currently elected custodian).  There must be an entry in the eosio.msig `proposal` table with the scope of the proposer and primary key of the `proposal_name`.

##### Parameters:
* `proposer` (name)        - account name for the user making the proposal
* `proposal_name` (name)   - name for the proposal (should follow the character limitations similar to the account names on EOS, but can be less than 12 characters)
* `approver` (name)        - account name which approved the proposal

##### Postconditions:
The `modifieddate` will be updated for this proposal.

### unapproved
Signals that a proposal has been unapproved on the system msig contract.

#### Assertions:
* The action must be authorised by the `unapprover` and `dacauthority@one` (ie they must be a currently elected custodian).  There must be an entry in the eosio.msig `proposal` table with the scope of the proposer and primary key of the `proposal_name`.

##### Parameters:
* `proposer` (name)        - account name for the user making the proposal
* `proposal_name` (name)   - name for the proposal (should follow the character limitations similar to the account names on EOS, but can be less than 12 characters)
* `unapprover` (name)      - account name which unapproved the proposal

##### Postconditions:
The `modifieddate` will be updated for this proposal.

### executed
Notify the contract that you executed a proposal.

#### Assertions:
* The action must be authorised by the `unapprover` and `dacauthority@one` (ie they must be a currently elected custodian).  There must *NOT* be an entry in the eosio.msig `proposal` table with the scope of the proposer and primary key of the `proposal_name`.

##### Parameters:
* `proposer` (name)        - account name for the user making the proposal
* `proposal_name` (name)   - name for the proposal (should follow the character limitations similar to the account names on EOS, but can be less than 12 characters)
* `executer` (name)        - account name which executed the proposal

##### Postconditions:
The proposal will be removed from the database.

### cancelled
Notify the contract that you cancelled a proposal.

#### Assertions:
* The action must be authorised by the `unapprover` and `dacauthority@one` (ie they must be a currently elected custodian).  There must *NOT* be an entry in the eosio.msig `proposal` table with the scope of the proposer and primary key of the `proposal_name`.

##### Parameters:
* `proposer` (name)        - account name for the user making the proposal
* `proposal_name` (name)   - name for the proposal (should follow the character limitations similar to the account names on EOS, but can be less than 12 characters)
* `canceler` (name)        - account name which cancelled the proposal

##### Postconditions:
The proposal will be removed from the database.

### clean
Will remove a proposal from the database to free RAM.

#### Assertions:
* The proposal being cleaned from the database must have a `modifieddate` more than 2 weeks in the past.  Transaction must provide `dacauthority` permission.

##### Parameters:
* `proposer` (name)        - account name for the user making the proposal
* `proposal_name` (name)   - name for the proposal (should follow the character limitations similar to the account names on EOS, but can be less than 12 characters)

##### Postconditions:
The proposal will be removed from the database.
