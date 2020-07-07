// =====================================================
// WARNING: GENERATED FILE
//
// Any changes you make will be overwritten by Lamington
// =====================================================

import { Account, Contract, GetTableRowsOptions, ExtendedAsset, ExtendedSymbol, ActorPermission, TableRowsResult } from 'lamington';

// Table row types
export interface EosioMsigAction {
	account: string|number;
	name: string|number;
	authorization: Array<string>;
	data: string;
}

export interface EosioMsigApproval {
	level: string;
	time: string;
}

export interface EosioMsigApprovalsInfo {
	version: number;
	proposal_name: string|number;
	requested_approvals: Array<string>;
	provided_approvals: Array<string>;
}

export interface EosioMsigApprove {
	proposer: string|number;
	proposal_name: string|number;
	level: string;
	proposal_hash: string;
}

export interface EosioMsigCancel {
	proposer: string|number;
	proposal_name: string|number;
	canceler: string|number;
}

export interface EosioMsigExec {
	proposer: string|number;
	proposal_name: string|number;
	executer: string|number;
}

export interface EosioMsigExtension {
	type: number;
	data: string;
}

export interface EosioMsigInvalidate {
	account: string|number;
}

export interface EosioMsigInvalidation {
	account: string|number;
	last_invalidation_time: string;
}

export interface EosioMsigOldApprovalsInfo {
	proposal_name: string|number;
	requested_approvals: Array<string>;
	provided_approvals: Array<string>;
}

export interface EosioMsigPermissionLevel {
	actor: string|number;
	permission: string|number;
}

export interface EosioMsigProposal {
	proposal_name: string|number;
	packed_transaction: string;
}

export interface EosioMsigPropose {
	proposer: string|number;
	proposal_name: string|number;
	requested: Array<string>;
	trx: string;
}

export interface EosioMsigTransaction {
	context_free_actions: Array<string>;
	actions: Array<string>;
	transaction_extensions: Array<string>;
}

export interface EosioMsigTransactionHeader {
	expiration: Date;
	ref_block_num: number;
	ref_block_prefix: number;
	max_net_usage_words: string;
	max_cpu_usage_ms: number;
	delay_sec: string;
}

export interface EosioMsigUnapprove {
	proposer: string|number;
	proposal_name: string|number;
	level: string;
}

export interface EosioMsig extends Contract {
	// Actions
	approve(proposer: string|number, proposal_name: string|number, level: EosioMsigPermissionLevel, proposal_hash: string, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	cancel(proposer: string|number, proposal_name: string|number, canceler: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	exec(proposer: string|number, proposal_name: string|number, executer: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	invalidate(account: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	propose(proposer: string|number, proposal_name: string|number, requested: Array<EosioMsigPermissionLevel>, trx: EosioMsigTransaction, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	unapprove(proposer: string|number, proposal_name: string|number, level: EosioMsigPermissionLevel, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	
	// Tables
	approvalsTable(options?: GetTableRowsOptions): Promise<TableRowsResult<EosioMsigOldApprovalsInfo>>;
	approvals2Table(options?: GetTableRowsOptions): Promise<TableRowsResult<EosioMsigApprovalsInfo>>;
	invalsTable(options?: GetTableRowsOptions): Promise<TableRowsResult<EosioMsigInvalidation>>;
	proposalTable(options?: GetTableRowsOptions): Promise<TableRowsResult<EosioMsigProposal>>;
}

