// =====================================================
// WARNING: GENERATED FILE
//
// Any changes you make will be overwritten by Lamington
// =====================================================

import { Account, Contract, GetTableRowsOptions, ExtendedAsset, ExtendedSymbol, ActorPermission, TableRowsResult } from 'lamington';

// Table row types
export interface DaccustodianCustodian {
	cust_name: string|number;
	requestedpay: string;
	total_votes: number;
}

export interface DaccustodianUpdatecust {
	custodians: Array<string|number>;
	dac_id: string|number;
}

export interface Daccustodian extends Contract {
	// Actions
	updatecust(custodians: Array<string|number>, dac_id: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	
	// Tables
	custodiansTable(options?: GetTableRowsOptions): Promise<TableRowsResult<DaccustodianCustodian>>;
}

