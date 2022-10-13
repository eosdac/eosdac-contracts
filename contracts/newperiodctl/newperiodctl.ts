// =====================================================
// WARNING: GENERATED FILE
//
// Any changes you make will be overwritten by Lamington
// =====================================================

import { Account, Contract, GetTableRowsOptions, ExtendedAsset, ExtendedSymbol, ActorPermission } from 'lamington';

// Table row types
export interface NewperiodctlAssertunlock {
	dac_id: string|number;
}

// Added Types

// Variants

export interface Newperiodctl extends Contract {
	// Actions
	assertunlock(dac_id: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	// Actions with object params. (This is WIP and not ready for use)
	assertunlock_object_params(params: {dac_id: string|number}, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	
	// Tables
}

