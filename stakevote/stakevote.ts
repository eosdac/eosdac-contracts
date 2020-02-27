// =====================================================
// WARNING: GENERATED FILE
//
// Any changes you make will be overwritten by Lamington
// =====================================================

import { Account, Contract, GetTableRowsOptions, ExtendedAsset, ExtendedSymbol, ActorPermission, TableRowsResult } from 'lamington';

// Table row types
export interface StakevoteAccountBalanceDelta {
	account: string|number;
	balance_delta: string;
}

export interface StakevoteAccountStakeDelta {
	account: string|number;
	stake_delta: string;
	unstake_delay: number;
}

export interface StakevoteBalanceobsv {
	balance_deltas: Array<string>;
	dac_id: string|number;
}

export interface StakevoteConfigItem {
	time_multiplier: number;
}

export interface StakevoteStakeobsv {
	stake_deltas: Array<string>;
	dac_id: string|number;
}

export interface StakevoteUpdateconfig {
	new_config: string;
	dac_id: string|number;
}

export interface StakevoteVoteWeight {
	voter: string|number;
	weight: number;
}

export interface Stakevote extends Contract {
	// Actions
	balanceobsv(balance_deltas: Array<StakevoteAccountBalanceDelta>, dac_id: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	stakeobsv(stake_deltas: Array<StakevoteAccountStakeDelta>, dac_id: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	updateconfig(new_config: StakevoteConfigItem, dac_id: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	
	// Tables
	configTable(options?: GetTableRowsOptions): Promise<TableRowsResult<StakevoteConfigItem>>;
	weightsTable(options?: GetTableRowsOptions): Promise<TableRowsResult<StakevoteVoteWeight>>;
}

