// =====================================================
// WARNING: GENERATED FILE
//
// Any changes you make will be overwritten by Lamington
// =====================================================

import { Account, Contract, GetTableRowsOptions } from 'lamington';

// Table row types
export interface Dacdirtester extends Contract {
	// Actions
	assertdacid(dac_name: string|number, id: number, options?: { from?: Account }): Promise<any>;
	assertdacsym(sym: string, id: number, options?: { from?: Account }): Promise<any>;
	
	// Tables
}

