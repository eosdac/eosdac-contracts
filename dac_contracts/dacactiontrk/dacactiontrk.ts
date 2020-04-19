// =====================================================
// WARNING: GENERATED FILE
//
// Any changes you make will be overwritten by Lamington
// =====================================================

import { Account, Contract, GetTableRowsOptions, ExtendedAsset, ExtendedSymbol, ActorPermission, TableRowsResult } from 'lamington';

// Table row types
export interface DacactiontrkConfigItem {
	startingScore: number;
	newperiodAdjustment: number;
	numberOmittedPeriods: number;
}

export interface DacactiontrkCustodianScore {
	custodian: string|number;
	score: number;
	periods_omitted: number;
}

export interface DacactiontrkPeriodend {
	currentCustodians: Array<string|number>;
	dacId: string|number;
}

export interface DacactiontrkPeriodstart {
	newCustodians: Array<string|number>;
	dacId: string|number;
}

export interface DacactiontrkTrackevent {
	custodian: string|number;
	score: number;
	dacId: string|number;
}

export interface DacactiontrkUpdateconfig {
	new_config: string;
	dacId: string|number;
}

export interface Dacactiontrk extends Contract {
	// Actions
	periodend(currentCustodians: Array<string|number>, dacId: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	periodstart(newCustodians: Array<string|number>, dacId: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	trackevent(custodian: string|number, score: number, dacId: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	updateconfig(new_config: DacactiontrkConfigItem, dacId: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	
	// Tables
	configTable(options?: GetTableRowsOptions): Promise<TableRowsResult<DacactiontrkConfigItem>>;
	scoresTable(options?: GetTableRowsOptions): Promise<TableRowsResult<DacactiontrkCustodianScore>>;
}

