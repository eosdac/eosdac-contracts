// =====================================================
// WARNING: GENERATED FILE
//
// Any changes you make will be overwritten by Lamington
// =====================================================

import { Account, Contract, GetTableRowsOptions, ExtendedAsset, ExtendedSymbol, ActorPermission } from 'lamington';

// Table row types
export interface MsigworldsAction {
	account: string|number;
	name: string|number;
	authorization: Array<MsigworldsPermissionLevel>;
	data: string;
}

export interface MsigworldsApprove {
	proposal_name: string|number;
	level: MsigworldsPermissionLevel;
	dac_id: string|number;
	proposal_hash: string;
}

export interface MsigworldsCancel {
	proposal_name: string|number;
	canceler: string|number;
	dac_id: string|number;
}

export interface MsigworldsCleanup {
	proposal_name: string|number;
	dac_id: string|number;
}

export interface MsigworldsExec {
	proposal_name: string|number;
	executer: string|number;
	dac_id: string|number;
}

export interface MsigworldsExtension {
	type: number;
	data: string;
}

export interface MsigworldsInvalidate {
	account: string|number;
	dac_id: string|number;
}

export interface MsigworldsPairStringString {
	key: string;
	value: string;
}

export interface MsigworldsPermissionLevel {
	actor: string|number;
	permission: string|number;
}

export interface MsigworldsPropose {
	proposer: string|number;
	proposal_name: string|number;
	requested: Array<MsigworldsPermissionLevel>;
	dac_id: string|number;
	metadata: Array<{ first: string; second: string }>;
	trx: MsigworldsTransaction;
}

export interface MsigworldsTransaction extends MsigworldsTransactionHeader {
	context_free_actions: Array<MsigworldsAction>;
	actions: Array<MsigworldsAction>;
	transaction_extensions: Array<MsigworldsExtension>;
}

export interface MsigworldsTransactionHeader {
	expiration: Date;
	ref_block_num: number;
	ref_block_prefix: number;
	max_net_usage_words: string;
	max_cpu_usage_ms: number;
	delay_sec: string;
}

export interface MsigworldsUnapprove {
	proposal_name: string|number;
	level: MsigworldsPermissionLevel;
	dac_id: string|number;
}

// Added Types

// Variants

export interface Msigworlds extends Contract {
	// Actions
	approve(proposal_name: string|number, level: MsigworldsPermissionLevel, dac_id: string|number, proposal_hash: string, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	cancel(proposal_name: string|number, canceler: string|number, dac_id: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	cleanup(proposal_name: string|number, dac_id: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	exec(proposal_name: string|number, executer: string|number, dac_id: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	invalidate(account: string|number, dac_id: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	propose(proposer: string|number, proposal_name: string|number, requested: Array<MsigworldsPermissionLevel>, dac_id: string|number, metadata: Array<{ first: string; second: string }>, trx: MsigworldsTransaction, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	unapprove(proposal_name: string|number, level: MsigworldsPermissionLevel, dac_id: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	// Actions with object params. (This is WIP and not ready for use)
	approveO(params: {proposal_name: string|number, level: MsigworldsPermissionLevel, dac_id: string|number, proposal_hash: string}, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	cancelO(params: {proposal_name: string|number, canceler: string|number, dac_id: string|number}, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	cleanupO(params: {proposal_name: string|number, dac_id: string|number}, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	execO(params: {proposal_name: string|number, executer: string|number, dac_id: string|number}, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	invalidateO(params: {account: string|number, dac_id: string|number}, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	proposeO(params: {proposer: string|number, proposal_name: string|number, requested: Array<MsigworldsPermissionLevel>, dac_id: string|number, metadata: Array<{ first: string; second: string }>, trx: MsigworldsTransaction}, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	unapproveO(params: {proposal_name: string|number, level: MsigworldsPermissionLevel, dac_id: string|number}, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	
	// Tables
}

