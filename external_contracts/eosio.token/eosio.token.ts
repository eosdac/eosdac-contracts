// =====================================================
// WARNING: GENERATED FILE
//
// Any changes you make will be overwritten by Lamington
// =====================================================

import { Account, Contract, GetTableRowsOptions, ExtendedAsset, ExtendedSymbol, TableRowsResult } from 'lamington';

// Table row types
export interface EosioTokenAccount {
	balance: string;
}

export interface EosioTokenClose {
	owner: string|number;
	symbol: string;
}

export interface EosioTokenCreate {
	issuer: string|number;
	maximum_supply: string;
}

export interface EosioTokenCurrencyStats {
	supply: string;
	max_supply: string;
	issuer: string|number;
}

export interface EosioTokenIssue {
	to: string|number;
	quantity: string;
	memo: string;
}

export interface EosioTokenOpen {
	owner: string|number;
	symbol: string;
	ram_payer: string|number;
}

export interface EosioTokenRetire {
	quantity: string;
	memo: string;
}

export interface EosioTokenTransfer {
	from: string|number;
	to: string|number;
	quantity: string;
	memo: string;
}

export interface EosioToken extends Contract {
	// Actions
	close(owner: string|number, symbol: string, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	create(issuer: string|number, maximum_supply: string, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	issue(to: string|number, quantity: string, memo: string, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	open(owner: string|number, symbol: string, ram_payer: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	retire(quantity: string, memo: string, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	transfer(from: string|number, to: string|number, quantity: string, memo: string, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	
	// Tables
	accountsTable(options?: GetTableRowsOptions): Promise<TableRowsResult<EosioTokenAccount>>;
	statTable(options?: GetTableRowsOptions): Promise<TableRowsResult<EosioTokenCurrencyStats>>;
}

