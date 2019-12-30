// =====================================================
// WARNING: GENERATED FILE
//
// Any changes you make will be overwritten by Lamington
// =====================================================

import { Account, Contract, GetTableRowsOptions, ExtendedAsset, ExtendedSymbol, TableRowsResult } from 'lamington';

// Table row types
export interface EosdactokensAccount {
	balance: string;
}

export interface EosdactokensBurn {
	from: string|number;
	quantity: string;
}

export interface EosdactokensCancel {
	unstake_id: number;
	token_symbol: string;
}

export interface EosdactokensClearold {
	batch_size: number;
}

export interface EosdactokensClose {
	owner: string|number;
	symbol: string;
}

export interface EosdactokensCreate {
	issuer: string|number;
	maximum_supply: string;
	transfer_locked: boolean;
}

export interface EosdactokensCurrencyStats {
	supply: string;
	max_supply: string;
	issuer: string|number;
	transfer_locked: boolean;
}

export interface EosdactokensIssue {
	to: string|number;
	quantity: string;
	memo: string;
}

export interface EosdactokensMember {
	sender: string|number;
	agreedtermsversion: number;
}

export interface EosdactokensMemberreg {
	sender: string|number;
	agreedterms: string;
}

export interface EosdactokensMemberrege {
	sender: string|number;
	agreedterms: string;
	dac_id: string|number;
}

export interface EosdactokensMemberunreg {
	sender: string|number;
}

export interface EosdactokensMemberunrege {
	sender: string|number;
	dac_id: string|number;
}

export interface EosdactokensMigrate {
	batch: number;
}

export interface EosdactokensNewmemterms {
	terms: string;
	hash: string;
}

export interface EosdactokensNewmemtermse {
	terms: string;
	hash: string;
	dac_id: string|number;
}

export interface EosdactokensRefund {
	unstake_id: number;
	token_symbol: string;
}

export interface EosdactokensStake {
	account: string|number;
	quantity: string;
}

export interface EosdactokensStakeConfig {
	enabled: boolean;
	min_stake_time: number;
	max_stake_time: number;
}

export interface EosdactokensStakeInfo {
	account: string|number;
	stake: string;
}

export interface EosdactokensStakeconfig {
	config: string;
	token_symbol: string;
}

export interface EosdactokensStaketime {
	account: string|number;
	unstake_time: number;
	token_symbol: string;
}

export interface EosdactokensStaketimeInfo {
	account: string|number;
	delay: number;
}

export interface EosdactokensTermsinfo {
	terms: string;
	hash: string;
	version: number;
}

export interface EosdactokensTransfer {
	from: string|number;
	to: string|number;
	quantity: string;
	memo: string;
}

export interface EosdactokensUnlock {
	unlock: string;
}

export interface EosdactokensUnstake {
	account: string|number;
	quantity: string;
}

export interface EosdactokensUnstakeInfo {
	key: number;
	account: string|number;
	stake: string;
	release_time: Date;
}

export interface EosdactokensUpdateterms {
	termsid: number;
	terms: string;
}

export interface EosdactokensUpdatetermse {
	termsid: number;
	terms: string;
	dac_id: string|number;
}

export interface EosdactokensXferstake {
	from: string|number;
	to: string|number;
	quantity: string;
	memo: string;
}

export interface Eosdactokens extends Contract {
	// Actions
	burn(from: string|number, quantity: string, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	cancel(unstake_id: number, token_symbol: string, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	clearold(batch_size: number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	close(owner: string|number, symbol: string, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	create(issuer: string|number, maximum_supply: string, transfer_locked: boolean, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	issue(to: string|number, quantity: string, memo: string, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	memberreg(sender: string|number, agreedterms: string, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	memberrege(sender: string|number, agreedterms: string, dac_id: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	memberunreg(sender: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	memberunrege(sender: string|number, dac_id: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	migrate(batch: number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	newmemterms(terms: string, hash: string, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	newmemtermse(terms: string, hash: string, dac_id: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	refund(unstake_id: number, token_symbol: string, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	stake(account: string|number, quantity: string, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	stakeconfig(config: EosdactokensStakeConfig, token_symbol: string, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	staketime(account: string|number, unstake_time: number, token_symbol: string, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	transfer(from: string|number, to: string|number, quantity: string, memo: string, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	unlock(unlock: string, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	unstake(account: string|number, quantity: string, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	updateterms(termsid: number, terms: string, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	updatetermse(termsid: number, terms: string, dac_id: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	xferstake(from: string|number, to: string|number, quantity: string, memo: string, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	
	// Tables
	accountsTable(options?: GetTableRowsOptions): Promise<TableRowsResult<EosdactokensAccount>>;
	membersTable(options?: GetTableRowsOptions): Promise<TableRowsResult<EosdactokensMember>>;
	membertermsTable(options?: GetTableRowsOptions): Promise<TableRowsResult<EosdactokensTermsinfo>>;
	stakeconfigTable(options?: GetTableRowsOptions): Promise<TableRowsResult<EosdactokensStakeConfig>>;
	stakesTable(options?: GetTableRowsOptions): Promise<TableRowsResult<EosdactokensStakeInfo>>;
	staketimeTable(options?: GetTableRowsOptions): Promise<TableRowsResult<EosdactokensStaketimeInfo>>;
	statTable(options?: GetTableRowsOptions): Promise<TableRowsResult<EosdactokensCurrencyStats>>;
	unstakesTable(options?: GetTableRowsOptions): Promise<TableRowsResult<EosdactokensUnstakeInfo>>;
}

