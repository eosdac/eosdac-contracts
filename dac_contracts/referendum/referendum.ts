// =====================================================
// WARNING: GENERATED FILE
//
// Any changes you make will be overwritten by Lamington
// =====================================================

import { Account, Contract, GetTableRowsOptions, ExtendedAsset, ExtendedSymbol, ActorPermission, TableRowsResult } from 'lamington';

// Table row types
export interface ReferendumAccountStakeDelta {
	account: string|number;
	stake_delta: string;
	unstake_delay: number;
}

export interface ReferendumAction {
	account: string|number;
	name: string|number;
	authorization: Array<string>;
	data: string;
}

export interface ReferendumCancel {
	referendum_id: string|number;
	dac_id: string|number;
}

export interface ReferendumClean {
	account: string|number;
	dac_id: string|number;
}

export interface ReferendumClearconfig {
	dac_id: string|number;
}

export interface ReferendumConfigItem {
	duration: number;
	fee: Array<string>;
	pass: Array<string>;
	quorum_token: Array<string>;
	quorum_account: Array<string>;
	allow_per_account_voting: Array<string>;
	allow_vote_type: Array<string>;
}

export interface ReferendumDepositInfo {
	account: string|number;
	deposit: ExtendedAsset;
}

export interface ReferendumExec {
	referendum_id: string|number;
	dac_id: string|number;
}

export interface ReferendumPairNameUint8 {
	key: string|number;
	value: number;
}

export interface ReferendumPairUint8ExtendedAsset {
	key: number;
	value: ExtendedAsset;
}

export interface ReferendumPairUint8Uint16 {
	key: number;
	value: number;
}

export interface ReferendumPairUint8Uint64 {
	key: number;
	value: number;
}

export interface ReferendumPairUint8Uint8 {
	key: number;
	value: number;
}

export interface ReferendumPermissionLevel {
	actor: string|number;
	permission: string|number;
}

export interface ReferendumPropose {
	proposer: string|number;
	referendum_id: string|number;
	type: number;
	voting_type: number;
	title: string;
	content: string;
	dac_id: string|number;
	acts: Array<string>;
}

export interface ReferendumReferendumData {
	referendum_id: string|number;
	proposer: string|number;
	type: number;
	voting_type: number;
	status: number;
	title: string;
	content_ref: string;
	token_votes: Array<string>;
	account_votes: Array<string>;
	expires: Date;
	acts: Array<string>;
}

export interface ReferendumRefund {
	account: string|number;
}

export interface ReferendumStakeobsv {
	stake_deltas: Array<string>;
	dac_id: string|number;
}

export interface ReferendumUpdateconfig {
	config: string;
	dac_id: string|number;
}

export interface ReferendumUpdatestatus {
	referendum_id: string|number;
	dac_id: string|number;
}

export interface ReferendumVote {
	voter: string|number;
	referendum_id: string|number;
	vote: number;
	dac_id: string|number;
}

export interface ReferendumVoteInfo {
	voter: string|number;
	votes: Array<string>;
}

export interface Referendum extends Contract {
	// Actions
	cancel(referendum_id: string|number, dac_id: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	clean(account: string|number, dac_id: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	clearconfig(dac_id: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	exec(referendum_id: string|number, dac_id: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	propose(proposer: string|number, referendum_id: string|number, type: number, voting_type: number, title: string, content: string, dac_id: string|number, acts: Array<ReferendumAction>, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	refund(account: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	stakeobsv(stake_deltas: Array<ReferendumAccountStakeDelta>, dac_id: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	updateconfig(config: ReferendumConfigItem, dac_id: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	updatestatus(referendum_id: string|number, dac_id: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	vote(voter: string|number, referendum_id: string|number, vote: number, dac_id: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	
	// Tables
	configTable(options?: GetTableRowsOptions): Promise<TableRowsResult<ReferendumConfigItem>>;
	depositsTable(options?: GetTableRowsOptions): Promise<TableRowsResult<ReferendumDepositInfo>>;
	referendumsTable(options?: GetTableRowsOptions): Promise<TableRowsResult<ReferendumReferendumData>>;
	votesTable(options?: GetTableRowsOptions): Promise<TableRowsResult<ReferendumVoteInfo>>;
}

