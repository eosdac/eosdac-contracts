// =====================================================
// WARNING: GENERATED FILE
//
// Any changes you make will be overwritten by Lamington
// =====================================================

import { Account, Contract, GetTableRowsOptions, ExtendedAsset, ExtendedSymbol, ActorPermission, TableRowsResult } from 'lamington';

// Table row types
export interface DacdirectoryDac {
	owner: string|number;
	dac_id: string|number;
	title: string;
	symbol: ExtendedSymbol;
	refs: Array<string>;
	accounts: Array<string>;
	dac_state: number;
}

export interface DacdirectoryExtendedSymbol {
	symbol: string;
	contract: string|number;
}

export interface DacdirectoryPairUint8Name {
	key: number;
	value: string|number;
}

export interface DacdirectoryPairUint8String {
	key: number;
	value: string;
}

export interface DacdirectoryRegaccount {
	dac_id: string|number;
	account: string|number;
	type: number;
}

export interface DacdirectoryRegdac {
	owner: string|number;
	dac_id: string|number;
	dac_symbol: ExtendedSymbol;
	title: string;
	refs: Array<string>;
	accounts: Array<string>;
}

export interface DacdirectoryRegref {
	dac_id: string|number;
	value: string;
	type: number;
}

export interface DacdirectorySetowner {
	dac_id: string|number;
	new_owner: string|number;
}

export interface DacdirectorySetstatus {
	dac_id: string|number;
	value: number;
}

export interface DacdirectoryUnregaccount {
	dac_id: string|number;
	type: number;
}

export interface DacdirectoryUnregdac {
	dac_id: string|number;
}

export interface DacdirectoryUnregref {
	dac_id: string|number;
	type: number;
}

export interface Dacdirectory extends Contract {
	// Actions
	regaccount(dac_id: string|number, account: string|number, type: number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	regdac(owner: string|number, dac_id: string|number, dac_symbol: DacdirectoryExtendedSymbol, title: string, refs: Array<DacdirectoryPairUint8String>, accounts: Array<DacdirectoryPairUint8Name>, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	regref(dac_id: string|number, value: string, type: number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	setowner(dac_id: string|number, new_owner: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	setstatus(dac_id: string|number, value: number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	unregaccount(dac_id: string|number, type: number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	unregdac(dac_id: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	unregref(dac_id: string|number, type: number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	
	// Tables
	dacsTable(options?: GetTableRowsOptions): Promise<TableRowsResult<DacdirectoryDac>>;
}

