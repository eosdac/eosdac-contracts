// =====================================================
// WARNING: GENERATED FILE
//
// Any changes you make will be overwritten by Lamington
// =====================================================

import { Account, Contract, GetTableRowsOptions, ActorPermission, ExtendedAsset, ExtendedSymbol, TableRowsResult } from 'lamington';

// Table row types
export interface DaccustodianAccountBalanceDelta {
	account: string|number;
	balance_delta: string;
}

export interface DaccustodianAccountStakeDelta {
	account: string|number;
	stake_delta: string;
}

export interface DaccustodianAccountWeightDelta {
	account: string|number;
	weight_delta: number;
}

export interface DaccustodianBalanceobsv {
	account_balance_deltas: Array<string>;
	dac_id: string|number;
}

export interface DaccustodianCandidate {
	candidate_name: string|number;
	requestedpay: string;
	locked_tokens: string;
	total_votes: number;
	is_active: number;
	custodian_end_time_stamp: Date;
}

export interface DaccustodianCandperm {
	cand: string|number;
	permission: string|number;
}

export interface DaccustodianCapturestake {
	from: string|number;
	quantity: string;
	dac_id: string|number;
}

export interface DaccustodianClaimpay {
	payid: number;
}

export interface DaccustodianClaimpaye {
	payid: number;
	dac_id: string|number;
}

export interface DaccustodianClearold {
	batch_size: number;
}

export interface DaccustodianClearstake {
	cand: string|number;
	new_value: string;
	dac_id: string|number;
}

export interface DaccustodianContrConfig {
	lockupasset: ExtendedAsset;
	maxvotes: number;
	numelected: number;
	periodlength: number;
	should_pay_via_service_provider: boolean;
	initial_vote_quorum_percent: number;
	vote_quorum_percent: number;
	auth_threshold_high: number;
	auth_threshold_mid: number;
	auth_threshold_low: number;
	lockup_release_time_delay: number;
	requested_pay_max: ExtendedAsset;
}

export interface DaccustodianContrState {
	lastperiodtime: Date;
	total_weight_of_votes: number;
	total_votes_on_candidates: number;
	number_active_candidates: number;
	met_initial_votes_threshold: boolean;
}

export interface DaccustodianCustodian {
	cust_name: string|number;
	requestedpay: string;
	total_votes: number;
}

export interface DaccustodianFirecand {
	cand: string|number;
	lockupStake: boolean;
}

export interface DaccustodianFirecande {
	cand: string|number;
	lockupStake: boolean;
	dac_id: string|number;
}

export interface DaccustodianFirecust {
	cust: string|number;
}

export interface DaccustodianFirecuste {
	cust: string|number;
	dac_id: string|number;
}

export interface DaccustodianMigrate {
	batch_size: number;
}

export interface DaccustodianNewperiod {
	message: string;
}

export interface DaccustodianNewperiode {
	message: string;
	dac_id: string|number;
}

export interface DaccustodianNominatecand {
	cand: string|number;
	requestedpay: string;
}

export interface DaccustodianNominatecane {
	cand: string|number;
	requestedpay: string;
	dac_id: string|number;
}

export interface DaccustodianPay {
	key: number;
	receiver: string|number;
	quantity: ExtendedAsset;
	due_date: Date;
}

export interface DaccustodianPayold {
	key: number;
	receiver: string|number;
	quantity: string;
	memo: string;
}

export interface DaccustodianRejectcuspay {
	payid: number;
	dac_id: string|number;
}

export interface DaccustodianRemovecuspay {
	payid: number;
	dac_id: string|number;
}

export interface DaccustodianResigncust {
	cust: string|number;
}

export interface DaccustodianResigncuste {
	cust: string|number;
	dac_id: string|number;
}

export interface DaccustodianRunnewperiod {
	message: string;
	dac_id: string|number;
}

export interface DaccustodianSetperm {
	cand: string|number;
	permission: string|number;
	dac_id: string|number;
}

export interface DaccustodianStakeobsv {
	account_stake_deltas: Array<string>;
	dac_id: string|number;
}

export interface DaccustodianStprofile {
	cand: string|number;
	profile: string;
	dac_id: string|number;
}

export interface DaccustodianStprofileuns {
	cand: string|number;
	profile: string;
}

export interface DaccustodianTempstake {
	sender: string|number;
	quantity: string;
	memo: string;
}

export interface DaccustodianTransferobsv {
	from: string|number;
	to: string|number;
	quantity: string;
	dac_id: string|number;
}

export interface DaccustodianUnstake {
	cand: string|number;
}

export interface DaccustodianUnstakee {
	cand: string|number;
	dac_id: string|number;
}

export interface DaccustodianUpdatebio {
	cand: string|number;
	bio: string;
}

export interface DaccustodianUpdatebioe {
	cand: string|number;
	bio: string;
	dac_id: string|number;
}

export interface DaccustodianUpdateconfig {
	newconfig: string;
}

export interface DaccustodianUpdateconfige {
	newconfig: string;
	dac_id: string|number;
}

export interface DaccustodianUpdatereqpae {
	cand: string|number;
	requestedpay: string;
	dac_id: string|number;
}

export interface DaccustodianUpdatereqpay {
	cand: string|number;
	requestedpay: string;
}

export interface DaccustodianVote {
	voter: string|number;
	proxy: string|number;
	candidates: Array<string|number>;
}

export interface DaccustodianVotecust {
	voter: string|number;
	newvotes: Array<string|number>;
}

export interface DaccustodianVotecuste {
	voter: string|number;
	newvotes: Array<string|number>;
	dac_id: string|number;
}

export interface DaccustodianWeightobsv {
	account_weight_deltas: Array<string>;
	dac_id: string|number;
}

export interface DaccustodianWithdrawcand {
	cand: string|number;
}

export interface DaccustodianWithdrawcane {
	cand: string|number;
	dac_id: string|number;
}

export interface Daccustodian extends Contract {
	// Actions
	balanceobsv(account_balance_deltas: Array<DaccustodianAccountBalanceDelta>, dac_id: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	capturestake(from: string|number, quantity: string, dac_id: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	claimpay(payid: number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	claimpaye(payid: number, dac_id: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	clearold(batch_size: number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	clearstake(cand: string|number, new_value: string, dac_id: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	firecand(cand: string|number, lockupStake: boolean, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	firecande(cand: string|number, lockupStake: boolean, dac_id: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	firecust(cust: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	firecuste(cust: string|number, dac_id: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	migrate(batch_size: number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	newperiod(message: string, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	newperiode(message: string, dac_id: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	nominatecand(cand: string|number, requestedpay: string, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	nominatecane(cand: string|number, requestedpay: string, dac_id: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	rejectcuspay(payid: number, dac_id: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	removecuspay(payid: number, dac_id: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	resigncust(cust: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	resigncuste(cust: string|number, dac_id: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	runnewperiod(message: string, dac_id: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	setperm(cand: string|number, permission: string|number, dac_id: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	stakeobsv(account_stake_deltas: Array<DaccustodianAccountStakeDelta>, dac_id: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	stprofile(cand: string|number, profile: string, dac_id: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	stprofileuns(cand: string|number, profile: string, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	transferobsv(from: string|number, to: string|number, quantity: string, dac_id: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	unstake(cand: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	unstakee(cand: string|number, dac_id: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	updatebio(cand: string|number, bio: string, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	updatebioe(cand: string|number, bio: string, dac_id: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	updateconfig(newconfig: DaccustodianContrConfig, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	updateconfige(newconfig: DaccustodianContrConfig, dac_id: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	updatereqpae(cand: string|number, requestedpay: string, dac_id: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	updatereqpay(cand: string|number, requestedpay: string, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	votecust(voter: string|number, newvotes: Array<string|number>, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	votecuste(voter: string|number, newvotes: Array<string|number>, dac_id: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	weightobsv(account_weight_deltas: Array<DaccustodianAccountWeightDelta>, dac_id: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	withdrawcand(cand: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	withdrawcane(cand: string|number, dac_id: string|number, options?: { from?: Account, auths?: ActorPermission[] }): Promise<any>;
	
	// Tables
	candidatesTable(options?: GetTableRowsOptions): Promise<TableRowsResult<DaccustodianCandidate>>;
	candpermsTable(options?: GetTableRowsOptions): Promise<TableRowsResult<DaccustodianCandperm>>;
	config2Table(options?: GetTableRowsOptions): Promise<TableRowsResult<DaccustodianContrConfig>>;
	custodiansTable(options?: GetTableRowsOptions): Promise<TableRowsResult<DaccustodianCustodian>>;
	pendingpayTable(options?: GetTableRowsOptions): Promise<TableRowsResult<DaccustodianPayold>>;
	pendingpay2Table(options?: GetTableRowsOptions): Promise<TableRowsResult<DaccustodianPay>>;
	pendingstakeTable(options?: GetTableRowsOptions): Promise<TableRowsResult<DaccustodianTempstake>>;
	stateTable(options?: GetTableRowsOptions): Promise<TableRowsResult<DaccustodianContrState>>;
	votesTable(options?: GetTableRowsOptions): Promise<TableRowsResult<DaccustodianVote>>;
}

