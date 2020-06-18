// =====================================================
// WARNING: GENERATED FILE
//
// Any changes you make will be overwritten by Lamington
// =====================================================

import { Account, Contract, GetTableRowsOptions, ExtendedAsset, ExtendedSymbol, ActorPermission, TableRowsResult } from 'lamington';

// Table row types
export interface DistributionApprove {
	distri_id: string|number;
}

export interface DistributionClaim {
	distri_id: string|number;
	receiver: string|number;
}

export interface DistributionDistri {
	receiver: string|number;
	amount: string;
}

export interface DistributionDistriconf {
	distri_id: string|number;
	dac_id: string|number;
	owner: string|number;
	approved: boolean;
	distri_type: number;
	approver_account: string|number;
	total_amount: ExtendedAsset;
	total_sent: string;
	total_received: string;
	memo: string;
}

export interface DistributionDropdata {
	receiver: string|number;
	amount: string;
}

export interface DistributionEmpty {
	distri_id: string|number;
	batch_size: number;
}

export interface DistributionPopulate {
	distri_id: string|number;
	data: Array<string>;
	allow_modify: boolean;
}

export interface DistributionRegdistri {
	distri_id: string|number;
	dac_id: string|number;
	owner: string|number;
	approver_account: string|number;
	total_amount: ExtendedAsset;
	distri_type: number;
	memo: string;
}

export interface DistributionSend {
	distri_id: string|number;
	batch_size: number;
}

export interface DistributionUnregdistri {
	distri_id: string|number;
}

export interface Distribution extends Contract {
	// Actions
	approve(distri_id: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	claim(distri_id: string|number, receiver: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	empty(distri_id: string|number, batch_size: number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	populate(distri_id: string|number, data: Array<DistributionDropdata>, allow_modify: boolean, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	regdistri(distri_id: string|number, dac_id: string|number, owner: string|number, approver_account: string|number, total_amount: ExtendedAsset, distri_type: number, memo: string, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	send(distri_id: string|number, batch_size: number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	unregdistri(distri_id: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	
	// Tables
	districonfsTable(options?: GetTableRowsOptions): Promise<TableRowsResult<DistributionDistriconf>>;
	distrisTable(options?: GetTableRowsOptions): Promise<TableRowsResult<DistributionDistri>>;
}

