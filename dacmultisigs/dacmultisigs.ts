// =====================================================
// WARNING: GENERATED FILE
//
// Any changes you make will be overwritten by Lamington
// =====================================================

import { Account, Contract, GetTableRowsOptions, ExtendedAsset, ExtendedSymbol, ActorPermission, TableRowsResult } from 'lamington';

// Table row types
export interface DacmultisigsApproved {
	proposer: string|number;
	proposal_name: string|number;
	approver: string|number;
}

export interface DacmultisigsApprovede {
	proposer: string|number;
	proposal_name: string|number;
	approver: string|number;
	dac_id: string|number;
}

export interface DacmultisigsCancelled {
	proposer: string|number;
	proposal_name: string|number;
	canceler: string|number;
}

export interface DacmultisigsCancellede {
	proposer: string|number;
	proposal_name: string|number;
	canceler: string|number;
	dac_id: string|number;
}

export interface DacmultisigsClean {
	proposer: string|number;
	proposal_name: string|number;
}

export interface DacmultisigsCleane {
	proposer: string|number;
	proposal_name: string|number;
	dac_id: string|number;
}

export interface DacmultisigsExecuted {
	proposer: string|number;
	proposal_name: string|number;
	executer: string|number;
}

export interface DacmultisigsExecutede {
	proposer: string|number;
	proposal_name: string|number;
	executer: string|number;
	dac_id: string|number;
}

export interface DacmultisigsProposed {
	proposer: string|number;
	proposal_name: string|number;
	metadata: string;
}

export interface DacmultisigsProposede {
	proposer: string|number;
	proposal_name: string|number;
	metadata: string;
	dac_id: string|number;
}

export interface DacmultisigsStoredproposal {
	proposalname: string|number;
	proposer: string|number;
	transactionid: string;
	modifieddate: Date;
}

export interface DacmultisigsUnapproved {
	proposer: string|number;
	proposal_name: string|number;
	unapprover: string|number;
}

export interface DacmultisigsUnapprovede {
	proposer: string|number;
	proposal_name: string|number;
	unapprover: string|number;
	dac_id: string|number;
}

export interface Dacmultisigs extends Contract {
	// Actions
	approved(proposer: string|number, proposal_name: string|number, approver: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	approvede(proposer: string|number, proposal_name: string|number, approver: string|number, dac_id: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	cancelled(proposer: string|number, proposal_name: string|number, canceler: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	cancellede(proposer: string|number, proposal_name: string|number, canceler: string|number, dac_id: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	clean(proposer: string|number, proposal_name: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	cleane(proposer: string|number, proposal_name: string|number, dac_id: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	executed(proposer: string|number, proposal_name: string|number, executer: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	executede(proposer: string|number, proposal_name: string|number, executer: string|number, dac_id: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	proposed(proposer: string|number, proposal_name: string|number, metadata: string, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	proposede(proposer: string|number, proposal_name: string|number, metadata: string, dac_id: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	unapproved(proposer: string|number, proposal_name: string|number, unapprover: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	unapprovede(proposer: string|number, proposal_name: string|number, unapprover: string|number, dac_id: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	
	// Tables
	proposalsTable(options?: GetTableRowsOptions): Promise<TableRowsResult<DacmultisigsStoredproposal>>;
}

