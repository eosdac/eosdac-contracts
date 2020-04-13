// =====================================================
// WARNING: GENERATED FILE
//
// Any changes you make will be overwritten by Lamington
// =====================================================

import { Account, Contract, GetTableRowsOptions, ExtendedAsset, ExtendedSymbol, ActorPermission, TableRowsResult } from 'lamington';

// Table row types
export interface DacescrowApprove {
	key: string|number;
	approver: string|number;
}

export interface DacescrowCancel {
	key: string|number;
}

export interface DacescrowClean {
}

export interface DacescrowDisapprove {
	key: string|number;
	disapprover: string|number;
}

export interface DacescrowDispute {
	key: string|number;
}

export interface DacescrowEscrowInfo {
	key: string|number;
	sender: string|number;
	receiver: string|number;
	arb: string|number;
	receiver_pay: ExtendedAsset;
	arbitrator_pay: ExtendedAsset;
	memo: string;
	expires: Date;
	disputed: boolean;
}

export interface DacescrowInit {
	sender: string|number;
	receiver: string|number;
	arb: string|number;
	expires: Date;
	memo: string;
	ext_reference: string|number;
}

export interface DacescrowRefund {
	key: string|number;
}

export interface Dacescrow extends Contract {
	// Actions
	approve(key: string|number, approver: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	cancel(key: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	clean(options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	disapprove(key: string|number, disapprover: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	dispute(key: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	init(sender: string|number, receiver: string|number, arb: string|number, expires: Date, memo: string, ext_reference: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	refund(key: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	
	// Tables
	escrowsTable(options?: GetTableRowsOptions): Promise<TableRowsResult<DacescrowEscrowInfo>>;
}

