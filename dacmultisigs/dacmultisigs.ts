// =====================================================
// WARNING: GENERATED FILE
//
// Any changes you make will be overwritten by Lamington
// =====================================================

import { Account, Contract, GetTableRowsOptions, TableRowsResult } from 'lamington';

// Table row types
export interface DacmultisigsProposals {
	proposalname: string|number;
	proposer: string|number;
	transactionid: string;
	modifieddate: string;
}

export interface Dacmultisigs extends Contract {
	// Actions
	approved(proposer: string|number, proposal_name: string|number, approver: string|number, options?: { from?: Account }): Promise<any>;
	approvede(proposer: string|number, proposal_name: string|number, approver: string|number, dac_id: string|number, options?: { from?: Account }): Promise<any>;
	cancelled(proposer: string|number, proposal_name: string|number, canceler: string|number, options?: { from?: Account }): Promise<any>;
	cancellede(proposer: string|number, proposal_name: string|number, canceler: string|number, dac_id: string|number, options?: { from?: Account }): Promise<any>;
	clean(proposer: string|number, proposal_name: string|number, options?: { from?: Account }): Promise<any>;
	cleane(proposer: string|number, proposal_name: string|number, dac_id: string|number, options?: { from?: Account }): Promise<any>;
	executed(proposer: string|number, proposal_name: string|number, executer: string|number, options?: { from?: Account }): Promise<any>;
	executede(proposer: string|number, proposal_name: string|number, executer: string|number, dac_id: string|number, options?: { from?: Account }): Promise<any>;
	proposed(proposer: string|number, proposal_name: string|number, metadata: string, options?: { from?: Account }): Promise<any>;
	proposede(proposer: string|number, proposal_name: string|number, metadata: string, dac_id: string|number, options?: { from?: Account }): Promise<any>;
	unapproved(proposer: string|number, proposal_name: string|number, unapprover: string|number, options?: { from?: Account }): Promise<any>;
	unapprovede(proposer: string|number, proposal_name: string|number, unapprover: string|number, dac_id: string|number, options?: { from?: Account }): Promise<any>;
	
	// Tables
	proposals(options?: GetTableRowsOptions): Promise<TableRowsResult<DacmultisigsProposals>>;
}

