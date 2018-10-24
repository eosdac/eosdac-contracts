	.text
	.file	"eosio.msig.bc"
	.hidden	_ZeqRK11checksum256S1_
	.globl	_ZeqRK11checksum256S1_
	.type	_ZeqRK11checksum256S1_,@function
_ZeqRK11checksum256S1_:
	.param  	i32, i32
	.result 	i32
	i32.const	$push0=, 32
	i32.call	$push1=, memcmp@FUNCTION, $0, $1, $pop0
	i32.eqz 	$push2=, $pop1
	.endfunc
.Lfunc_end0:
	.size	_ZeqRK11checksum256S1_, .Lfunc_end0-_ZeqRK11checksum256S1_

	.hidden	_ZeqRK11checksum160S1_
	.globl	_ZeqRK11checksum160S1_
	.type	_ZeqRK11checksum160S1_,@function
_ZeqRK11checksum160S1_:
	.param  	i32, i32
	.result 	i32
	i32.const	$push0=, 32
	i32.call	$push1=, memcmp@FUNCTION, $0, $1, $pop0
	i32.eqz 	$push2=, $pop1
	.endfunc
.Lfunc_end1:
	.size	_ZeqRK11checksum160S1_, .Lfunc_end1-_ZeqRK11checksum160S1_

	.hidden	_ZneRK11checksum160S1_
	.globl	_ZneRK11checksum160S1_
	.type	_ZneRK11checksum160S1_,@function
_ZneRK11checksum160S1_:
	.param  	i32, i32
	.result 	i32
	i32.const	$push0=, 32
	i32.call	$push1=, memcmp@FUNCTION, $0, $1, $pop0
	i32.const	$push2=, 0
	i32.ne  	$push3=, $pop1, $pop2
	.endfunc
.Lfunc_end2:
	.size	_ZneRK11checksum160S1_, .Lfunc_end2-_ZneRK11checksum160S1_

	.hidden	now
	.globl	now
	.type	now,@function
now:
	.result 	i32
	i64.call	$push1=, current_time@FUNCTION
	i64.const	$push0=, 1000000
	i64.div_u	$push2=, $pop1, $pop0
	i32.wrap/i64	$push3=, $pop2
	.endfunc
.Lfunc_end3:
	.size	now, .Lfunc_end3-now

	.hidden	_ZN5eosio12require_authERKNS_16permission_levelE
	.globl	_ZN5eosio12require_authERKNS_16permission_levelE
	.type	_ZN5eosio12require_authERKNS_16permission_levelE,@function
_ZN5eosio12require_authERKNS_16permission_levelE:
	.param  	i32
	i64.load	$push1=, 0($0)
	i64.load	$push0=, 8($0)
	call    	require_auth2@FUNCTION, $pop1, $pop0
	.endfunc
.Lfunc_end4:
	.size	_ZN5eosio12require_authERKNS_16permission_levelE, .Lfunc_end4-_ZN5eosio12require_authERKNS_16permission_levelE

	.hidden	_ZN5eosio31check_transaction_authorizationERKNS_11transactionERKNSt3__13setINS_16permission_levelENS3_4lessIS5_EENS3_9allocatorIS5_EEEERKNS4_I10public_keyNS6_ISD_EENS8_ISD_EEEE
	.globl	_ZN5eosio31check_transaction_authorizationERKNS_11transactionERKNSt3__13setINS_16permission_levelENS3_4lessIS5_EENS3_9allocatorIS5_EEEERKNS4_I10public_keyNS6_ISD_EENS8_ISD_EEEE
	.type	_ZN5eosio31check_transaction_authorizationERKNS_11transactionERKNSt3__13setINS_16permission_levelENS3_4lessIS5_EENS3_9allocatorIS5_EEEERKNS4_I10public_keyNS6_ISD_EENS8_ISD_EEEE,@function
_ZN5eosio31check_transaction_authorizationERKNS_11transactionERKNSt3__13setINS_16permission_levelENS3_4lessIS5_EENS3_9allocatorIS5_EEEERKNS4_I10public_keyNS6_ISD_EENS8_ISD_EEEE:
	.param  	i32, i32, i32
	.result 	i32
	.local  	i32, i32, i64, i32, i32, i32, i32, i32, i32, i32
	i32.const	$push30=, 0
	i32.const	$push27=, 0
	i32.load	$push28=, __stack_pointer($pop27)
	i32.const	$push29=, 48
	i32.sub 	$push43=, $pop28, $pop29
	tee_local	$push42=, $12=, $pop43
	i32.store	__stack_pointer($pop30), $pop42
	i32.const	$push34=, 16
	i32.add 	$push35=, $12, $pop34
	call    	_ZN5eosio4packINS_11transactionEEENSt3__16vectorIcNS2_9allocatorIcEEEERKT_@FUNCTION, $pop35, $0
	i32.const	$11=, 0
	i32.const	$9=, 0
	i32.const	$10=, 0
	block   	
	i32.load	$push41=, 8($2)
	tee_local	$push40=, $3=, $pop41
	i32.eqz 	$push109=, $pop40
	br_if   	0, $pop109
	i32.const	$6=, 0
	i32.const	$push45=, 0
	i32.store	8($12), $pop45
	i64.const	$push44=, 0
	i64.store	0($12), $pop44
	i64.extend_u/i32	$5=, $3
.LBB5_2:
	loop    	
	i32.const	$push50=, 1
	i32.add 	$6=, $6, $pop50
	i64.const	$push49=, 7
	i64.shr_u	$push48=, $5, $pop49
	tee_local	$push47=, $5=, $pop48
	i64.const	$push46=, 0
	i64.ne  	$push0=, $pop47, $pop46
	br_if   	0, $pop0
	end_loop
	block   	
	block   	
	block   	
	i32.load	$push54=, 0($2)
	tee_local	$push53=, $7=, $pop54
	i32.const	$push1=, 4
	i32.add 	$push52=, $2, $pop1
	tee_local	$push51=, $4=, $pop52
	i32.eq  	$push2=, $pop53, $pop51
	br_if   	0, $pop2
.LBB5_5:
	loop    	
	block   	
	block   	
	copy_local	$push58=, $7
	tee_local	$push57=, $8=, $pop58
	i32.load	$push56=, 4($pop57)
	tee_local	$push55=, $0=, $pop56
	i32.eqz 	$push110=, $pop55
	br_if   	0, $pop110
.LBB5_6:
	loop    	
	copy_local	$push62=, $0
	tee_local	$push61=, $7=, $pop62
	i32.load	$push60=, 0($pop61)
	tee_local	$push59=, $0=, $pop60
	br_if   	0, $pop59
	br      	2
.LBB5_7:
	end_loop
	end_block
	i32.load	$push64=, 8($8)
	tee_local	$push63=, $7=, $pop64
	i32.load	$push3=, 0($pop63)
	i32.eq  	$push4=, $pop3, $8
	br_if   	0, $pop4
	i32.const	$push65=, 8
	i32.add 	$8=, $8, $pop65
.LBB5_9:
	loop    	
	i32.load	$push70=, 0($8)
	tee_local	$push69=, $0=, $pop70
	i32.const	$push68=, 8
	i32.add 	$8=, $pop69, $pop68
	i32.load	$push67=, 8($0)
	tee_local	$push66=, $7=, $pop67
	i32.load	$push5=, 0($pop66)
	i32.ne  	$push6=, $0, $pop5
	br_if   	0, $pop6
.LBB5_10:
	end_loop
	end_block
	i32.const	$push71=, 34
	i32.add 	$6=, $6, $pop71
	i32.ne  	$push7=, $7, $4
	br_if   	0, $pop7
	end_loop
	i32.eqz 	$push111=, $6
	br_if   	1, $pop111
.LBB5_12:
	end_block
	call    	_ZNSt3__16vectorIcNS_9allocatorIcEEE8__appendEj@FUNCTION, $12, $6
	i32.load	$7=, 4($12)
	i32.load	$0=, 0($12)
	br      	1
.LBB5_13:
	end_block
	i32.const	$7=, 0
	i32.const	$0=, 0
.LBB5_14:
	end_block
	i32.store	36($12), $0
	i32.store	32($12), $0
	i32.store	40($12), $7
	i32.const	$push36=, 32
	i32.add 	$push37=, $12, $pop36
	i32.call	$drop=, _ZN5eosiolsINS_10datastreamIPcEE10public_keyEERT_S6_RKNSt3__13setIT0_NS7_4lessIS9_EENS7_9allocatorIS9_EEEE@FUNCTION, $pop37, $2
	i32.load	$9=, 4($12)
	i32.load	$10=, 0($12)
.LBB5_15:
	end_block
	i32.const	$0=, 0
	block   	
	i32.load	$push73=, 8($1)
	tee_local	$push72=, $2=, $pop73
	i32.eqz 	$push112=, $pop72
	br_if   	0, $pop112
	i32.const	$6=, 0
	i32.const	$push75=, 0
	i32.store	8($12), $pop75
	i64.const	$push74=, 0
	i64.store	0($12), $pop74
	i64.extend_u/i32	$5=, $2
.LBB5_17:
	loop    	
	i32.const	$push80=, 1
	i32.add 	$6=, $6, $pop80
	i64.const	$push79=, 7
	i64.shr_u	$push78=, $5, $pop79
	tee_local	$push77=, $5=, $pop78
	i64.const	$push76=, 0
	i64.ne  	$push8=, $pop77, $pop76
	br_if   	0, $pop8
	end_loop
	block   	
	block   	
	block   	
	i32.load	$push84=, 0($1)
	tee_local	$push83=, $7=, $pop84
	i32.const	$push9=, 4
	i32.add 	$push82=, $1, $pop9
	tee_local	$push81=, $4=, $pop82
	i32.eq  	$push10=, $pop83, $pop81
	br_if   	0, $pop10
.LBB5_20:
	loop    	
	block   	
	block   	
	copy_local	$push88=, $7
	tee_local	$push87=, $8=, $pop88
	i32.load	$push86=, 4($pop87)
	tee_local	$push85=, $0=, $pop86
	i32.eqz 	$push113=, $pop85
	br_if   	0, $pop113
.LBB5_21:
	loop    	
	copy_local	$push92=, $0
	tee_local	$push91=, $7=, $pop92
	i32.load	$push90=, 0($pop91)
	tee_local	$push89=, $0=, $pop90
	br_if   	0, $pop89
	br      	2
.LBB5_22:
	end_loop
	end_block
	i32.load	$push94=, 8($8)
	tee_local	$push93=, $7=, $pop94
	i32.load	$push11=, 0($pop93)
	i32.eq  	$push12=, $pop11, $8
	br_if   	0, $pop12
	i32.const	$push95=, 8
	i32.add 	$8=, $8, $pop95
.LBB5_24:
	loop    	
	i32.load	$push100=, 0($8)
	tee_local	$push99=, $0=, $pop100
	i32.const	$push98=, 8
	i32.add 	$8=, $pop99, $pop98
	i32.load	$push97=, 8($0)
	tee_local	$push96=, $7=, $pop97
	i32.load	$push13=, 0($pop96)
	i32.ne  	$push14=, $0, $pop13
	br_if   	0, $pop14
.LBB5_25:
	end_loop
	end_block
	i32.const	$push101=, 16
	i32.add 	$6=, $6, $pop101
	i32.ne  	$push15=, $7, $4
	br_if   	0, $pop15
	end_loop
	i32.eqz 	$push114=, $6
	br_if   	1, $pop114
.LBB5_27:
	end_block
	call    	_ZNSt3__16vectorIcNS_9allocatorIcEEE8__appendEj@FUNCTION, $12, $6
	i32.load	$7=, 4($12)
	i32.load	$0=, 0($12)
	br      	1
.LBB5_28:
	end_block
	i32.const	$7=, 0
	i32.const	$0=, 0
.LBB5_29:
	end_block
	i32.store	36($12), $0
	i32.store	32($12), $0
	i32.store	40($12), $7
	i32.const	$push38=, 32
	i32.add 	$push39=, $12, $pop38
	i32.call	$drop=, _ZN5eosiolsINS_10datastreamIPcEENS_16permission_levelEEERT_S6_RKNSt3__13setIT0_NS7_4lessIS9_EENS7_9allocatorIS9_EEEE@FUNCTION, $pop39, $1
	i32.load	$11=, 4($12)
	i32.load	$0=, 0($12)
.LBB5_30:
	end_block
	i32.load	$push106=, 16($12)
	tee_local	$push105=, $7=, $pop106
	i32.load	$push23=, 20($12)
	i32.sub 	$push24=, $pop23, $7
	i32.const	$push16=, 0
	i32.select	$push18=, $10, $pop16, $3
	i32.sub 	$push21=, $9, $10
	i32.const	$push104=, 0
	i32.select	$push22=, $pop21, $pop104, $3
	i32.const	$push103=, 0
	i32.select	$push17=, $0, $pop103, $2
	i32.sub 	$push19=, $11, $0
	i32.const	$push102=, 0
	i32.select	$push20=, $pop19, $pop102, $2
	i32.call	$7=, check_transaction_authorization@FUNCTION, $pop105, $pop24, $pop18, $pop22, $pop17, $pop20
	block   	
	i32.eqz 	$push115=, $0
	br_if   	0, $pop115
	call    	_ZdlPv@FUNCTION, $0
.LBB5_32:
	end_block
	block   	
	i32.eqz 	$push116=, $10
	br_if   	0, $pop116
	call    	_ZdlPv@FUNCTION, $10
.LBB5_34:
	end_block
	block   	
	i32.load	$push108=, 16($12)
	tee_local	$push107=, $0=, $pop108
	i32.eqz 	$push117=, $pop107
	br_if   	0, $pop117
	i32.store	20($12), $0
	call    	_ZdlPv@FUNCTION, $0
.LBB5_36:
	end_block
	i32.const	$push33=, 0
	i32.const	$push31=, 48
	i32.add 	$push32=, $12, $pop31
	i32.store	__stack_pointer($pop33), $pop32
	i32.const	$push25=, 0
	i32.gt_s	$push26=, $7, $pop25
	.endfunc
.Lfunc_end5:
	.size	_ZN5eosio31check_transaction_authorizationERKNS_11transactionERKNSt3__13setINS_16permission_levelENS3_4lessIS5_EENS3_9allocatorIS5_EEEERKNS4_I10public_keyNS6_ISD_EENS8_ISD_EEEE, .Lfunc_end5-_ZN5eosio31check_transaction_authorizationERKNS_11transactionERKNSt3__13setINS_16permission_levelENS3_4lessIS5_EENS3_9allocatorIS5_EEEERKNS4_I10public_keyNS6_ISD_EENS8_ISD_EEEE

	.section	.text._ZN5eosio4packINS_11transactionEEENSt3__16vectorIcNS2_9allocatorIcEEEERKT_,"axG",@progbits,_ZN5eosio4packINS_11transactionEEENSt3__16vectorIcNS2_9allocatorIcEEEERKT_,comdat
	.hidden	_ZN5eosio4packINS_11transactionEEENSt3__16vectorIcNS2_9allocatorIcEEEERKT_
	.weak	_ZN5eosio4packINS_11transactionEEENSt3__16vectorIcNS2_9allocatorIcEEEERKT_
	.type	_ZN5eosio4packINS_11transactionEEENSt3__16vectorIcNS2_9allocatorIcEEEERKT_,@function
_ZN5eosio4packINS_11transactionEEENSt3__16vectorIcNS2_9allocatorIcEEEERKT_:
	.param  	i32, i32
	.local  	i32, i32, i32
	i32.const	$push14=, 0
	i32.const	$push11=, 0
	i32.load	$push12=, __stack_pointer($pop11)
	i32.const	$push13=, 16
	i32.sub 	$push23=, $pop12, $pop13
	tee_local	$push22=, $4=, $pop23
	i32.store	__stack_pointer($pop14), $pop22
	i32.const	$3=, 0
	i32.const	$push21=, 0
	i32.store	8($0), $pop21
	i64.const	$push0=, 0
	i64.store	0($0):p2align=2, $pop0
	i32.const	$push20=, 0
	i32.store	0($4), $pop20
	i32.call	$drop=, _ZN5eosiolsINS_10datastreamIjEEEERT_S4_RKNS_11transactionE@FUNCTION, $4, $1
	block   	
	block   	
	i32.load	$push19=, 0($4)
	tee_local	$push18=, $2=, $pop19
	i32.eqz 	$push24=, $pop18
	br_if   	0, $pop24
	call    	_ZNSt3__16vectorIcNS_9allocatorIcEEE8__appendEj@FUNCTION, $0, $2
	i32.const	$push1=, 4
	i32.add 	$push2=, $0, $pop1
	i32.load	$3=, 0($pop2)
	i32.load	$0=, 0($0)
	br      	1
.LBB6_2:
	end_block
	i32.const	$0=, 0
.LBB6_3:
	end_block
	i32.store	4($4), $0
	i32.store	0($4), $0
	i32.store	8($4), $3
	i32.call	$drop=, _ZN5eosiolsINS_10datastreamIPcEEEERT_S5_RKNS_18transaction_headerE@FUNCTION, $4, $1
	i32.const	$push5=, 24
	i32.add 	$push6=, $1, $pop5
	i32.call	$push7=, _ZN5eosiolsINS_10datastreamIPcEENS_6actionEEERT_S6_RKNSt3__16vectorIT0_NS7_9allocatorIS9_EEEE@FUNCTION, $4, $pop6
	i32.const	$push3=, 36
	i32.add 	$push4=, $1, $pop3
	i32.call	$push8=, _ZN5eosiolsINS_10datastreamIPcEENS_6actionEEERT_S6_RKNSt3__16vectorIT0_NS7_9allocatorIS9_EEEE@FUNCTION, $pop7, $pop4
	i32.const	$push9=, 48
	i32.add 	$push10=, $1, $pop9
	i32.call	$drop=, _ZN5eosiolsINS_10datastreamIPcEENSt3__15tupleIJtNS4_6vectorIcNS4_9allocatorIcEEEEEEEEERT_SC_RKNS6_IT0_NS7_ISD_EEEE@FUNCTION, $pop8, $pop10
	i32.const	$push17=, 0
	i32.const	$push15=, 16
	i32.add 	$push16=, $4, $pop15
	i32.store	__stack_pointer($pop17), $pop16
	.endfunc
.Lfunc_end6:
	.size	_ZN5eosio4packINS_11transactionEEENSt3__16vectorIcNS2_9allocatorIcEEEERKT_, .Lfunc_end6-_ZN5eosio4packINS_11transactionEEENSt3__16vectorIcNS2_9allocatorIcEEEERKT_

	.section	.text._ZNSt3__16vectorIcNS_9allocatorIcEEE8__appendEj,"axG",@progbits,_ZNSt3__16vectorIcNS_9allocatorIcEEE8__appendEj,comdat
	.hidden	_ZNSt3__16vectorIcNS_9allocatorIcEEE8__appendEj
	.weak	_ZNSt3__16vectorIcNS_9allocatorIcEEE8__appendEj
	.type	_ZNSt3__16vectorIcNS_9allocatorIcEEE8__appendEj,@function
_ZNSt3__16vectorIcNS_9allocatorIcEEE8__appendEj:
	.param  	i32, i32
	.local  	i32, i32, i32, i32, i32
	block   	
	block   	
	block   	
	block   	
	block   	
	i32.load	$push19=, 8($0)
	tee_local	$push18=, $2=, $pop19
	i32.load	$push17=, 4($0)
	tee_local	$push16=, $6=, $pop17
	i32.sub 	$push0=, $pop18, $pop16
	i32.ge_u	$push1=, $pop0, $1
	br_if   	0, $pop1
	i32.load	$push25=, 0($0)
	tee_local	$push24=, $5=, $pop25
	i32.sub 	$push23=, $6, $pop24
	tee_local	$push22=, $3=, $pop23
	i32.add 	$push21=, $pop22, $1
	tee_local	$push20=, $4=, $pop21
	i32.const	$push4=, -1
	i32.le_s	$push5=, $pop20, $pop4
	br_if   	2, $pop5
	i32.const	$6=, 2147483647
	block   	
	i32.sub 	$push27=, $2, $5
	tee_local	$push26=, $2=, $pop27
	i32.const	$push6=, 1073741822
	i32.gt_u	$push7=, $pop26, $pop6
	br_if   	0, $pop7
	i32.const	$push8=, 1
	i32.shl 	$push31=, $2, $pop8
	tee_local	$push30=, $6=, $pop31
	i32.lt_u	$push9=, $6, $4
	i32.select	$push29=, $4, $pop30, $pop9
	tee_local	$push28=, $6=, $pop29
	i32.eqz 	$push52=, $pop28
	br_if   	2, $pop52
.LBB7_4:
	end_block
	i32.call	$2=, _Znwj@FUNCTION, $6
	br      	3
.LBB7_5:
	end_block
	i32.const	$push2=, 4
	i32.add 	$0=, $0, $pop2
.LBB7_6:
	loop    	
	i32.const	$push51=, 0
	i32.store8	0($6), $pop51
	i32.load	$push3=, 0($0)
	i32.const	$push50=, 1
	i32.add 	$push49=, $pop3, $pop50
	tee_local	$push48=, $6=, $pop49
	i32.store	0($0), $pop48
	i32.const	$push47=, -1
	i32.add 	$push46=, $1, $pop47
	tee_local	$push45=, $1=, $pop46
	br_if   	0, $pop45
	br      	4
.LBB7_7:
	end_loop
	end_block
	i32.const	$6=, 0
	i32.const	$2=, 0
	br      	1
.LBB7_8:
	end_block
	call    	_ZNKSt3__120__vector_base_commonILb1EE20__throw_length_errorEv@FUNCTION, $0
	unreachable
.LBB7_9:
	end_block
	i32.add 	$4=, $2, $6
	i32.add 	$push33=, $2, $3
	tee_local	$push32=, $5=, $pop33
	copy_local	$6=, $pop32
.LBB7_10:
	loop    	
	i32.const	$push38=, 0
	i32.store8	0($6), $pop38
	i32.const	$push37=, 1
	i32.add 	$6=, $6, $pop37
	i32.const	$push36=, -1
	i32.add 	$push35=, $1, $pop36
	tee_local	$push34=, $1=, $pop35
	br_if   	0, $pop34
	end_loop
	i32.const	$push10=, 4
	i32.add 	$push44=, $0, $pop10
	tee_local	$push43=, $3=, $pop44
	i32.load	$push11=, 0($pop43)
	i32.load	$push42=, 0($0)
	tee_local	$push41=, $1=, $pop42
	i32.sub 	$push40=, $pop11, $pop41
	tee_local	$push39=, $2=, $pop40
	i32.sub 	$5=, $5, $pop39
	block   	
	i32.const	$push12=, 1
	i32.lt_s	$push13=, $2, $pop12
	br_if   	0, $pop13
	i32.call	$drop=, memcpy@FUNCTION, $5, $1, $2
	i32.load	$1=, 0($0)
.LBB7_13:
	end_block
	i32.store	0($0), $5
	i32.store	0($3), $6
	i32.const	$push14=, 8
	i32.add 	$push15=, $0, $pop14
	i32.store	0($pop15), $4
	i32.eqz 	$push53=, $1
	br_if   	0, $pop53
	call    	_ZdlPv@FUNCTION, $1
	return
.LBB7_15:
	end_block
	.endfunc
.Lfunc_end7:
	.size	_ZNSt3__16vectorIcNS_9allocatorIcEEE8__appendEj, .Lfunc_end7-_ZNSt3__16vectorIcNS_9allocatorIcEEE8__appendEj

	.section	.text._ZN5eosiolsINS_10datastreamIPcEE10public_keyEERT_S6_RKNSt3__13setIT0_NS7_4lessIS9_EENS7_9allocatorIS9_EEEE,"axG",@progbits,_ZN5eosiolsINS_10datastreamIPcEE10public_keyEERT_S6_RKNSt3__13setIT0_NS7_4lessIS9_EENS7_9allocatorIS9_EEEE,comdat
	.hidden	_ZN5eosiolsINS_10datastreamIPcEE10public_keyEERT_S6_RKNSt3__13setIT0_NS7_4lessIS9_EENS7_9allocatorIS9_EEEE
	.weak	_ZN5eosiolsINS_10datastreamIPcEE10public_keyEERT_S6_RKNSt3__13setIT0_NS7_4lessIS9_EENS7_9allocatorIS9_EEEE
	.type	_ZN5eosiolsINS_10datastreamIPcEE10public_keyEERT_S6_RKNSt3__13setIT0_NS7_4lessIS9_EENS7_9allocatorIS9_EEEE,@function
_ZN5eosiolsINS_10datastreamIPcEE10public_keyEERT_S6_RKNSt3__13setIT0_NS7_4lessIS9_EENS7_9allocatorIS9_EEEE:
	.param  	i32, i32
	.result 	i32
	.local  	i32, i32, i64, i32, i32, i32, i32, i32
	i32.const	$push25=, 0
	i32.const	$push22=, 0
	i32.load	$push23=, __stack_pointer($pop22)
	i32.const	$push24=, 80
	i32.sub 	$push40=, $pop23, $pop24
	tee_local	$push39=, $9=, $pop40
	i32.store	__stack_pointer($pop25), $pop39
	i32.load	$5=, 4($0)
	i64.load32_u	$4=, 8($1)
	i32.const	$push3=, 8
	i32.add 	$3=, $0, $pop3
	i32.const	$push7=, 4
	i32.add 	$7=, $0, $pop7
.LBB8_1:
	loop    	
	i32.wrap/i64	$6=, $4
	i64.const	$push54=, 7
	i64.shr_u	$push53=, $4, $pop54
	tee_local	$push52=, $4=, $pop53
	i64.const	$push51=, 0
	i64.ne  	$push50=, $pop52, $pop51
	tee_local	$push49=, $8=, $pop50
	i32.const	$push48=, 7
	i32.shl 	$push1=, $pop49, $pop48
	i32.const	$push47=, 127
	i32.and 	$push0=, $6, $pop47
	i32.or  	$push2=, $pop1, $pop0
	i32.store8	40($9), $pop2
	i32.load	$push4=, 0($3)
	i32.sub 	$push5=, $pop4, $5
	i32.const	$push46=, 0
	i32.gt_s	$push6=, $pop5, $pop46
	i32.const	$push45=, .L.str.11
	call    	eosio_assert@FUNCTION, $pop6, $pop45
	i32.load	$push8=, 0($7)
	i32.const	$push29=, 40
	i32.add 	$push30=, $9, $pop29
	i32.const	$push44=, 1
	i32.call	$drop=, memcpy@FUNCTION, $pop8, $pop30, $pop44
	i32.load	$push9=, 0($7)
	i32.const	$push43=, 1
	i32.add 	$push42=, $pop9, $pop43
	tee_local	$push41=, $5=, $pop42
	i32.store	0($7), $pop41
	br_if   	0, $8
	end_loop
	block   	
	i32.load	$push59=, 0($1)
	tee_local	$push58=, $6=, $pop59
	i32.const	$push57=, 4
	i32.add 	$push56=, $1, $pop57
	tee_local	$push55=, $1=, $pop56
	i32.eq  	$push10=, $pop58, $pop55
	br_if   	0, $pop10
	i32.const	$push61=, 8
	i32.add 	$2=, $0, $pop61
	i32.const	$push60=, 4
	i32.add 	$3=, $0, $pop60
.LBB8_4:
	loop    	
	i32.const	$push31=, 6
	i32.add 	$push32=, $9, $pop31
	copy_local	$push74=, $6
	tee_local	$push73=, $8=, $pop74
	i32.const	$push72=, 13
	i32.add 	$push11=, $pop73, $pop72
	i32.const	$push71=, 34
	i32.call	$drop=, memcpy@FUNCTION, $pop32, $pop11, $pop71
	i32.const	$push33=, 40
	i32.add 	$push34=, $9, $pop33
	i32.const	$push35=, 6
	i32.add 	$push36=, $9, $pop35
	i32.const	$push70=, 34
	i32.call	$drop=, memcpy@FUNCTION, $pop34, $pop36, $pop70
	i32.load	$push12=, 0($2)
	i32.sub 	$push13=, $pop12, $5
	i32.const	$push69=, 33
	i32.gt_s	$push14=, $pop13, $pop69
	i32.const	$push68=, .L.str.11
	call    	eosio_assert@FUNCTION, $pop14, $pop68
	i32.load	$push15=, 0($3)
	i32.const	$push37=, 40
	i32.add 	$push38=, $9, $pop37
	i32.const	$push67=, 34
	i32.call	$drop=, memcpy@FUNCTION, $pop15, $pop38, $pop67
	i32.load	$push16=, 0($3)
	i32.const	$push66=, 34
	i32.add 	$push65=, $pop16, $pop66
	tee_local	$push64=, $5=, $pop65
	i32.store	0($3), $pop64
	block   	
	block   	
	i32.load	$push63=, 4($8)
	tee_local	$push62=, $7=, $pop63
	i32.eqz 	$push87=, $pop62
	br_if   	0, $pop87
.LBB8_5:
	loop    	
	copy_local	$push78=, $7
	tee_local	$push77=, $6=, $pop78
	i32.load	$push76=, 0($pop77)
	tee_local	$push75=, $7=, $pop76
	br_if   	0, $pop75
	br      	2
.LBB8_6:
	end_loop
	end_block
	i32.load	$push80=, 8($8)
	tee_local	$push79=, $6=, $pop80
	i32.load	$push17=, 0($pop79)
	i32.eq  	$push18=, $pop17, $8
	br_if   	0, $pop18
	i32.const	$push81=, 8
	i32.add 	$8=, $8, $pop81
.LBB8_8:
	loop    	
	i32.load	$push86=, 0($8)
	tee_local	$push85=, $7=, $pop86
	i32.const	$push84=, 8
	i32.add 	$8=, $pop85, $pop84
	i32.load	$push83=, 8($7)
	tee_local	$push82=, $6=, $pop83
	i32.load	$push19=, 0($pop82)
	i32.ne  	$push20=, $7, $pop19
	br_if   	0, $pop20
.LBB8_9:
	end_loop
	end_block
	i32.ne  	$push21=, $6, $1
	br_if   	0, $pop21
.LBB8_10:
	end_loop
	end_block
	i32.const	$push28=, 0
	i32.const	$push26=, 80
	i32.add 	$push27=, $9, $pop26
	i32.store	__stack_pointer($pop28), $pop27
	copy_local	$push88=, $0
	.endfunc
.Lfunc_end8:
	.size	_ZN5eosiolsINS_10datastreamIPcEE10public_keyEERT_S6_RKNSt3__13setIT0_NS7_4lessIS9_EENS7_9allocatorIS9_EEEE, .Lfunc_end8-_ZN5eosiolsINS_10datastreamIPcEE10public_keyEERT_S6_RKNSt3__13setIT0_NS7_4lessIS9_EENS7_9allocatorIS9_EEEE

	.section	.text._ZN5eosiolsINS_10datastreamIPcEENS_16permission_levelEEERT_S6_RKNSt3__13setIT0_NS7_4lessIS9_EENS7_9allocatorIS9_EEEE,"axG",@progbits,_ZN5eosiolsINS_10datastreamIPcEENS_16permission_levelEEERT_S6_RKNSt3__13setIT0_NS7_4lessIS9_EENS7_9allocatorIS9_EEEE,comdat
	.hidden	_ZN5eosiolsINS_10datastreamIPcEENS_16permission_levelEEERT_S6_RKNSt3__13setIT0_NS7_4lessIS9_EENS7_9allocatorIS9_EEEE
	.weak	_ZN5eosiolsINS_10datastreamIPcEENS_16permission_levelEEERT_S6_RKNSt3__13setIT0_NS7_4lessIS9_EENS7_9allocatorIS9_EEEE
	.type	_ZN5eosiolsINS_10datastreamIPcEENS_16permission_levelEEERT_S6_RKNSt3__13setIT0_NS7_4lessIS9_EENS7_9allocatorIS9_EEEE,@function
_ZN5eosiolsINS_10datastreamIPcEENS_16permission_levelEEERT_S6_RKNSt3__13setIT0_NS7_4lessIS9_EENS7_9allocatorIS9_EEEE:
	.param  	i32, i32
	.result 	i32
	.local  	i32, i64, i32, i32, i32, i32, i32
	i32.const	$push31=, 0
	i32.const	$push28=, 0
	i32.load	$push29=, __stack_pointer($pop28)
	i32.const	$push30=, 16
	i32.sub 	$push38=, $pop29, $pop30
	tee_local	$push37=, $8=, $pop38
	i32.store	__stack_pointer($pop31), $pop37
	i32.load	$4=, 4($0)
	i64.load32_u	$3=, 8($1)
	i32.const	$push3=, 8
	i32.add 	$2=, $0, $pop3
	i32.const	$push7=, 4
	i32.add 	$6=, $0, $pop7
.LBB9_1:
	loop    	
	i32.wrap/i64	$5=, $3
	i64.const	$push52=, 7
	i64.shr_u	$push51=, $3, $pop52
	tee_local	$push50=, $3=, $pop51
	i64.const	$push49=, 0
	i64.ne  	$push48=, $pop50, $pop49
	tee_local	$push47=, $7=, $pop48
	i32.const	$push46=, 7
	i32.shl 	$push1=, $pop47, $pop46
	i32.const	$push45=, 127
	i32.and 	$push0=, $5, $pop45
	i32.or  	$push2=, $pop1, $pop0
	i32.store8	15($8), $pop2
	i32.load	$push4=, 0($2)
	i32.sub 	$push5=, $pop4, $4
	i32.const	$push44=, 0
	i32.gt_s	$push6=, $pop5, $pop44
	i32.const	$push43=, .L.str.11
	call    	eosio_assert@FUNCTION, $pop6, $pop43
	i32.load	$push8=, 0($6)
	i32.const	$push35=, 15
	i32.add 	$push36=, $8, $pop35
	i32.const	$push42=, 1
	i32.call	$drop=, memcpy@FUNCTION, $pop8, $pop36, $pop42
	i32.load	$push9=, 0($6)
	i32.const	$push41=, 1
	i32.add 	$push40=, $pop9, $pop41
	tee_local	$push39=, $4=, $pop40
	i32.store	0($6), $pop39
	br_if   	0, $7
	end_loop
	block   	
	i32.load	$push57=, 0($1)
	tee_local	$push56=, $5=, $pop57
	i32.const	$push55=, 4
	i32.add 	$push54=, $1, $pop55
	tee_local	$push53=, $1=, $pop54
	i32.eq  	$push10=, $pop56, $pop53
	br_if   	0, $pop10
	i32.const	$push58=, 4
	i32.add 	$2=, $0, $pop58
.LBB9_4:
	loop    	
	i32.const	$push79=, 8
	i32.add 	$push78=, $0, $pop79
	tee_local	$push77=, $6=, $pop78
	i32.load	$push11=, 0($pop77)
	i32.sub 	$push12=, $pop11, $4
	i32.const	$push76=, 7
	i32.gt_s	$push13=, $pop12, $pop76
	i32.const	$push75=, .L.str.11
	call    	eosio_assert@FUNCTION, $pop13, $pop75
	i32.load	$push15=, 0($2)
	copy_local	$push74=, $5
	tee_local	$push73=, $7=, $pop74
	i32.const	$push72=, 16
	i32.add 	$push14=, $pop73, $pop72
	i32.const	$push71=, 8
	i32.call	$drop=, memcpy@FUNCTION, $pop15, $pop14, $pop71
	i32.load	$push16=, 0($2)
	i32.const	$push70=, 8
	i32.add 	$push69=, $pop16, $pop70
	tee_local	$push68=, $5=, $pop69
	i32.store	0($2), $pop68
	i32.load	$push17=, 0($6)
	i32.sub 	$push18=, $pop17, $5
	i32.const	$push67=, 7
	i32.gt_s	$push19=, $pop18, $pop67
	i32.const	$push66=, .L.str.11
	call    	eosio_assert@FUNCTION, $pop19, $pop66
	i32.load	$push21=, 0($2)
	i32.const	$push65=, 24
	i32.add 	$push20=, $7, $pop65
	i32.const	$push64=, 8
	i32.call	$drop=, memcpy@FUNCTION, $pop21, $pop20, $pop64
	i32.load	$push22=, 0($2)
	i32.const	$push63=, 8
	i32.add 	$push62=, $pop22, $pop63
	tee_local	$push61=, $4=, $pop62
	i32.store	0($2), $pop61
	block   	
	block   	
	i32.load	$push60=, 4($7)
	tee_local	$push59=, $6=, $pop60
	i32.eqz 	$push92=, $pop59
	br_if   	0, $pop92
.LBB9_5:
	loop    	
	copy_local	$push83=, $6
	tee_local	$push82=, $5=, $pop83
	i32.load	$push81=, 0($pop82)
	tee_local	$push80=, $6=, $pop81
	br_if   	0, $pop80
	br      	2
.LBB9_6:
	end_loop
	end_block
	i32.load	$push85=, 8($7)
	tee_local	$push84=, $5=, $pop85
	i32.load	$push23=, 0($pop84)
	i32.eq  	$push24=, $pop23, $7
	br_if   	0, $pop24
	i32.const	$push86=, 8
	i32.add 	$7=, $7, $pop86
.LBB9_8:
	loop    	
	i32.load	$push91=, 0($7)
	tee_local	$push90=, $6=, $pop91
	i32.const	$push89=, 8
	i32.add 	$7=, $pop90, $pop89
	i32.load	$push88=, 8($6)
	tee_local	$push87=, $5=, $pop88
	i32.load	$push25=, 0($pop87)
	i32.ne  	$push26=, $6, $pop25
	br_if   	0, $pop26
.LBB9_9:
	end_loop
	end_block
	i32.ne  	$push27=, $5, $1
	br_if   	0, $pop27
.LBB9_10:
	end_loop
	end_block
	i32.const	$push34=, 0
	i32.const	$push32=, 16
	i32.add 	$push33=, $8, $pop32
	i32.store	__stack_pointer($pop34), $pop33
	copy_local	$push93=, $0
	.endfunc
.Lfunc_end9:
	.size	_ZN5eosiolsINS_10datastreamIPcEENS_16permission_levelEEERT_S6_RKNSt3__13setIT0_NS7_4lessIS9_EENS7_9allocatorIS9_EEEE, .Lfunc_end9-_ZN5eosiolsINS_10datastreamIPcEENS_16permission_levelEEERT_S6_RKNSt3__13setIT0_NS7_4lessIS9_EENS7_9allocatorIS9_EEEE

	.section	.text._ZN5eosiolsINS_10datastreamIjEEEERT_S4_RKNS_11transactionE,"axG",@progbits,_ZN5eosiolsINS_10datastreamIjEEEERT_S4_RKNS_11transactionE,comdat
	.hidden	_ZN5eosiolsINS_10datastreamIjEEEERT_S4_RKNS_11transactionE
	.weak	_ZN5eosiolsINS_10datastreamIjEEEERT_S4_RKNS_11transactionE
	.type	_ZN5eosiolsINS_10datastreamIjEEEERT_S4_RKNS_11transactionE,@function
_ZN5eosiolsINS_10datastreamIjEEEERT_S4_RKNS_11transactionE:
	.param  	i32, i32
	.result 	i32
	.local  	i32, i32, i32, i32, i32, i32, i64
	i32.load	$push52=, 0($0)
	tee_local	$push51=, $6=, $pop52
	i32.const	$push0=, 10
	i32.add 	$push1=, $pop51, $pop0
	i32.store	0($0), $pop1
	i32.const	$push2=, 11
	i32.add 	$6=, $6, $pop2
	i64.load32_u	$8=, 12($1)
.LBB10_1:
	loop    	
	i32.const	$push57=, 1
	i32.add 	$6=, $6, $pop57
	i64.const	$push56=, 7
	i64.shr_u	$push55=, $8, $pop56
	tee_local	$push54=, $8=, $pop55
	i64.const	$push53=, 0
	i64.ne  	$push3=, $pop54, $pop53
	br_if   	0, $pop3
	end_loop
	i32.store	0($0), $6
	i64.load32_u	$8=, 20($1)
.LBB10_3:
	loop    	
	i32.const	$push62=, 1
	i32.add 	$6=, $6, $pop62
	i64.const	$push61=, 7
	i64.shr_u	$push60=, $8, $pop61
	tee_local	$push59=, $8=, $pop60
	i64.const	$push58=, 0
	i64.ne  	$push4=, $pop59, $pop58
	br_if   	0, $pop4
	end_loop
	i32.store	0($0), $6
	i32.const	$push5=, 28
	i32.add 	$push6=, $1, $pop5
	i32.load	$push66=, 0($pop6)
	tee_local	$push65=, $2=, $pop66
	i32.load	$push64=, 24($1)
	tee_local	$push63=, $7=, $pop64
	i32.sub 	$push7=, $pop65, $pop63
	i32.const	$push8=, 40
	i32.div_s	$push9=, $pop7, $pop8
	i64.extend_u/i32	$8=, $pop9
.LBB10_5:
	loop    	
	i32.const	$push71=, 1
	i32.add 	$6=, $6, $pop71
	i64.const	$push70=, 7
	i64.shr_u	$push69=, $8, $pop70
	tee_local	$push68=, $8=, $pop69
	i64.const	$push67=, 0
	i64.ne  	$push10=, $pop68, $pop67
	br_if   	0, $pop10
	end_loop
	i32.store	0($0), $6
	block   	
	i32.eq  	$push11=, $7, $2
	br_if   	0, $pop11
.LBB10_8:
	loop    	
	i32.const	$push80=, 16
	i32.add 	$6=, $6, $pop80
	i32.const	$push79=, 20
	i32.add 	$push12=, $7, $pop79
	i32.load	$push78=, 0($pop12)
	tee_local	$push77=, $3=, $pop78
	i32.load	$push76=, 16($7)
	tee_local	$push75=, $4=, $pop76
	i32.sub 	$push74=, $pop77, $pop75
	tee_local	$push73=, $5=, $pop74
	i32.const	$push72=, 4
	i32.shr_s	$push13=, $pop73, $pop72
	i64.extend_u/i32	$8=, $pop13
.LBB10_9:
	loop    	
	i32.const	$push85=, 1
	i32.add 	$6=, $6, $pop85
	i64.const	$push84=, 7
	i64.shr_u	$push83=, $8, $pop84
	tee_local	$push82=, $8=, $pop83
	i64.const	$push81=, 0
	i64.ne  	$push14=, $pop82, $pop81
	br_if   	0, $pop14
	end_loop
	block   	
	i32.eq  	$push15=, $4, $3
	br_if   	0, $pop15
	i32.const	$push86=, -16
	i32.and 	$push16=, $5, $pop86
	i32.add 	$6=, $pop16, $6
.LBB10_12:
	end_block
	i32.const	$push91=, 32
	i32.add 	$push17=, $7, $pop91
	i32.load	$push90=, 0($pop17)
	tee_local	$push89=, $3=, $pop90
	i32.add 	$push18=, $6, $pop89
	i32.load	$push88=, 28($7)
	tee_local	$push87=, $4=, $pop88
	i32.sub 	$6=, $pop18, $pop87
	i32.sub 	$push19=, $3, $4
	i64.extend_u/i32	$8=, $pop19
.LBB10_13:
	loop    	
	i32.const	$push96=, 1
	i32.add 	$6=, $6, $pop96
	i64.const	$push95=, 7
	i64.shr_u	$push94=, $8, $pop95
	tee_local	$push93=, $8=, $pop94
	i64.const	$push92=, 0
	i64.ne  	$push20=, $pop93, $pop92
	br_if   	0, $pop20
	end_loop
	i32.const	$push99=, 40
	i32.add 	$push98=, $7, $pop99
	tee_local	$push97=, $7=, $pop98
	i32.ne  	$push21=, $pop97, $2
	br_if   	0, $pop21
	end_loop
	i32.store	0($0), $6
.LBB10_16:
	end_block
	i32.const	$push22=, 40
	i32.add 	$push23=, $1, $pop22
	i32.load	$push104=, 0($pop23)
	tee_local	$push103=, $2=, $pop104
	i32.load	$push102=, 36($1)
	tee_local	$push101=, $7=, $pop102
	i32.sub 	$push24=, $pop103, $pop101
	i32.const	$push100=, 40
	i32.div_s	$push25=, $pop24, $pop100
	i64.extend_u/i32	$8=, $pop25
.LBB10_17:
	loop    	
	i32.const	$push109=, 1
	i32.add 	$6=, $6, $pop109
	i64.const	$push108=, 7
	i64.shr_u	$push107=, $8, $pop108
	tee_local	$push106=, $8=, $pop107
	i64.const	$push105=, 0
	i64.ne  	$push26=, $pop106, $pop105
	br_if   	0, $pop26
	end_loop
	i32.store	0($0), $6
	block   	
	i32.eq  	$push27=, $7, $2
	br_if   	0, $pop27
.LBB10_20:
	loop    	
	i32.const	$push118=, 16
	i32.add 	$6=, $6, $pop118
	i32.const	$push117=, 20
	i32.add 	$push28=, $7, $pop117
	i32.load	$push116=, 0($pop28)
	tee_local	$push115=, $3=, $pop116
	i32.load	$push114=, 16($7)
	tee_local	$push113=, $4=, $pop114
	i32.sub 	$push112=, $pop115, $pop113
	tee_local	$push111=, $5=, $pop112
	i32.const	$push110=, 4
	i32.shr_s	$push29=, $pop111, $pop110
	i64.extend_u/i32	$8=, $pop29
.LBB10_21:
	loop    	
	i32.const	$push123=, 1
	i32.add 	$6=, $6, $pop123
	i64.const	$push122=, 7
	i64.shr_u	$push121=, $8, $pop122
	tee_local	$push120=, $8=, $pop121
	i64.const	$push119=, 0
	i64.ne  	$push30=, $pop120, $pop119
	br_if   	0, $pop30
	end_loop
	block   	
	i32.eq  	$push31=, $4, $3
	br_if   	0, $pop31
	i32.const	$push124=, -16
	i32.and 	$push32=, $5, $pop124
	i32.add 	$6=, $pop32, $6
.LBB10_24:
	end_block
	i32.const	$push129=, 32
	i32.add 	$push33=, $7, $pop129
	i32.load	$push128=, 0($pop33)
	tee_local	$push127=, $3=, $pop128
	i32.add 	$push34=, $6, $pop127
	i32.load	$push126=, 28($7)
	tee_local	$push125=, $4=, $pop126
	i32.sub 	$6=, $pop34, $pop125
	i32.sub 	$push35=, $3, $4
	i64.extend_u/i32	$8=, $pop35
.LBB10_25:
	loop    	
	i32.const	$push134=, 1
	i32.add 	$6=, $6, $pop134
	i64.const	$push133=, 7
	i64.shr_u	$push132=, $8, $pop133
	tee_local	$push131=, $8=, $pop132
	i64.const	$push130=, 0
	i64.ne  	$push36=, $pop131, $pop130
	br_if   	0, $pop36
	end_loop
	i32.const	$push137=, 40
	i32.add 	$push136=, $7, $pop137
	tee_local	$push135=, $7=, $pop136
	i32.ne  	$push37=, $pop135, $2
	br_if   	0, $pop37
	end_loop
	i32.store	0($0), $6
.LBB10_28:
	end_block
	i32.const	$push38=, 52
	i32.add 	$push39=, $1, $pop38
	i32.load	$push141=, 0($pop39)
	tee_local	$push140=, $5=, $pop141
	i32.load	$push139=, 48($1)
	tee_local	$push138=, $7=, $pop139
	i32.sub 	$push40=, $pop140, $pop138
	i32.const	$push41=, 4
	i32.shr_s	$push42=, $pop40, $pop41
	i64.extend_u/i32	$8=, $pop42
.LBB10_29:
	loop    	
	i32.const	$push146=, 1
	i32.add 	$6=, $6, $pop146
	i64.const	$push145=, 7
	i64.shr_u	$push144=, $8, $pop145
	tee_local	$push143=, $8=, $pop144
	i64.const	$push142=, 0
	i64.ne  	$push43=, $pop143, $pop142
	br_if   	0, $pop43
	end_loop
	i32.store	0($0), $6
	block   	
	i32.eq  	$push44=, $7, $5
	br_if   	0, $pop44
.LBB10_32:
	loop    	
	i32.const	$push152=, 8
	i32.add 	$push45=, $7, $pop152
	i32.load	$push151=, 0($pop45)
	tee_local	$push150=, $3=, $pop151
	i32.add 	$push46=, $6, $pop150
	i32.const	$push149=, 2
	i32.add 	$push47=, $pop46, $pop149
	i32.load	$push148=, 4($7)
	tee_local	$push147=, $4=, $pop148
	i32.sub 	$6=, $pop47, $pop147
	i32.sub 	$push48=, $3, $4
	i64.extend_u/i32	$8=, $pop48
.LBB10_33:
	loop    	
	i32.const	$push157=, 1
	i32.add 	$6=, $6, $pop157
	i64.const	$push156=, 7
	i64.shr_u	$push155=, $8, $pop156
	tee_local	$push154=, $8=, $pop155
	i64.const	$push153=, 0
	i64.ne  	$push49=, $pop154, $pop153
	br_if   	0, $pop49
	end_loop
	i32.const	$push160=, 16
	i32.add 	$push159=, $7, $pop160
	tee_local	$push158=, $7=, $pop159
	i32.ne  	$push50=, $pop158, $5
	br_if   	0, $pop50
	end_loop
	i32.store	0($0), $6
.LBB10_36:
	end_block
	copy_local	$push161=, $0
	.endfunc
.Lfunc_end10:
	.size	_ZN5eosiolsINS_10datastreamIjEEEERT_S4_RKNS_11transactionE, .Lfunc_end10-_ZN5eosiolsINS_10datastreamIjEEEERT_S4_RKNS_11transactionE

	.section	.text._ZN5eosiolsINS_10datastreamIPcEEEERT_S5_RKNS_18transaction_headerE,"axG",@progbits,_ZN5eosiolsINS_10datastreamIPcEEEERT_S5_RKNS_18transaction_headerE,comdat
	.hidden	_ZN5eosiolsINS_10datastreamIPcEEEERT_S5_RKNS_18transaction_headerE
	.weak	_ZN5eosiolsINS_10datastreamIPcEEEERT_S5_RKNS_18transaction_headerE
	.type	_ZN5eosiolsINS_10datastreamIPcEEEERT_S5_RKNS_18transaction_headerE,@function
_ZN5eosiolsINS_10datastreamIPcEEEERT_S5_RKNS_18transaction_headerE:
	.param  	i32, i32
	.result 	i32
	.local  	i32, i32, i32, i32, i64, i32
	i32.const	$push49=, 0
	i32.const	$push46=, 0
	i32.load	$push47=, __stack_pointer($pop46)
	i32.const	$push48=, 16
	i32.sub 	$push76=, $pop47, $pop48
	tee_local	$push75=, $7=, $pop76
	i32.store	__stack_pointer($pop49), $pop75
	i32.load	$push1=, 8($0)
	i32.load	$push0=, 4($0)
	i32.sub 	$push2=, $pop1, $pop0
	i32.const	$push3=, 3
	i32.gt_s	$push4=, $pop2, $pop3
	i32.const	$push74=, .L.str.11
	call    	eosio_assert@FUNCTION, $pop4, $pop74
	i32.load	$push5=, 4($0)
	i32.const	$push73=, 4
	i32.call	$drop=, memcpy@FUNCTION, $pop5, $1, $pop73
	i32.load	$push6=, 4($0)
	i32.const	$push72=, 4
	i32.add 	$push71=, $pop6, $pop72
	tee_local	$push70=, $4=, $pop71
	i32.store	4($0), $pop70
	i32.load	$push7=, 8($0)
	i32.sub 	$push8=, $pop7, $4
	i32.const	$push69=, 1
	i32.gt_s	$push9=, $pop8, $pop69
	i32.const	$push68=, .L.str.11
	call    	eosio_assert@FUNCTION, $pop9, $pop68
	i32.load	$push11=, 4($0)
	i32.const	$push67=, 4
	i32.add 	$push10=, $1, $pop67
	i32.const	$push12=, 2
	i32.call	$drop=, memcpy@FUNCTION, $pop11, $pop10, $pop12
	i32.load	$push13=, 4($0)
	i32.const	$push66=, 2
	i32.add 	$push65=, $pop13, $pop66
	tee_local	$push64=, $4=, $pop65
	i32.store	4($0), $pop64
	i32.load	$push14=, 8($0)
	i32.sub 	$push15=, $pop14, $4
	i32.const	$push63=, 3
	i32.gt_s	$push16=, $pop15, $pop63
	i32.const	$push62=, .L.str.11
	call    	eosio_assert@FUNCTION, $pop16, $pop62
	i32.load	$push18=, 4($0)
	i32.const	$push61=, 8
	i32.add 	$push17=, $1, $pop61
	i32.const	$push60=, 4
	i32.call	$drop=, memcpy@FUNCTION, $pop18, $pop17, $pop60
	i32.load	$push19=, 4($0)
	i32.const	$push59=, 4
	i32.add 	$push58=, $pop19, $pop59
	tee_local	$push57=, $5=, $pop58
	i32.store	4($0), $pop57
	i64.load32_u	$6=, 12($1)
.LBB11_1:
	loop    	
	i32.wrap/i64	$4=, $6
	i64.const	$push94=, 7
	i64.shr_u	$push93=, $6, $pop94
	tee_local	$push92=, $6=, $pop93
	i64.const	$push91=, 0
	i64.ne  	$push90=, $pop92, $pop91
	tee_local	$push89=, $2=, $pop90
	i32.const	$push88=, 7
	i32.shl 	$push21=, $pop89, $pop88
	i32.const	$push87=, 127
	i32.and 	$push20=, $4, $pop87
	i32.or  	$push22=, $pop21, $pop20
	i32.store8	14($7), $pop22
	i32.const	$push86=, 8
	i32.add 	$push23=, $0, $pop86
	i32.load	$push24=, 0($pop23)
	i32.sub 	$push25=, $pop24, $5
	i32.const	$push85=, 0
	i32.gt_s	$push26=, $pop25, $pop85
	i32.const	$push84=, .L.str.11
	call    	eosio_assert@FUNCTION, $pop26, $pop84
	i32.const	$push83=, 4
	i32.add 	$push82=, $0, $pop83
	tee_local	$push81=, $4=, $pop82
	i32.load	$push27=, 0($pop81)
	i32.const	$push53=, 14
	i32.add 	$push54=, $7, $pop53
	i32.const	$push80=, 1
	i32.call	$drop=, memcpy@FUNCTION, $pop27, $pop54, $pop80
	i32.load	$push28=, 0($4)
	i32.const	$push79=, 1
	i32.add 	$push78=, $pop28, $pop79
	tee_local	$push77=, $5=, $pop78
	i32.store	0($4), $pop77
	br_if   	0, $2
	end_loop
	i32.const	$push29=, 8
	i32.add 	$push104=, $0, $pop29
	tee_local	$push103=, $3=, $pop104
	i32.load	$push30=, 0($pop103)
	i32.sub 	$push31=, $pop30, $5
	i32.const	$push102=, 0
	i32.gt_s	$push32=, $pop31, $pop102
	i32.const	$push101=, .L.str.11
	call    	eosio_assert@FUNCTION, $pop32, $pop101
	i32.const	$push35=, 4
	i32.add 	$push100=, $0, $pop35
	tee_local	$push99=, $4=, $pop100
	i32.load	$push36=, 0($pop99)
	i32.const	$push33=, 16
	i32.add 	$push34=, $1, $pop33
	i32.const	$push98=, 1
	i32.call	$drop=, memcpy@FUNCTION, $pop36, $pop34, $pop98
	i32.load	$push37=, 0($4)
	i32.const	$push97=, 1
	i32.add 	$push96=, $pop37, $pop97
	tee_local	$push95=, $5=, $pop96
	i32.store	0($4), $pop95
	i64.load32_u	$6=, 20($1)
.LBB11_3:
	loop    	
	i32.wrap/i64	$2=, $6
	i64.const	$push118=, 7
	i64.shr_u	$push117=, $6, $pop118
	tee_local	$push116=, $6=, $pop117
	i64.const	$push115=, 0
	i64.ne  	$push114=, $pop116, $pop115
	tee_local	$push113=, $1=, $pop114
	i32.const	$push112=, 7
	i32.shl 	$push39=, $pop113, $pop112
	i32.const	$push111=, 127
	i32.and 	$push38=, $2, $pop111
	i32.or  	$push40=, $pop39, $pop38
	i32.store8	15($7), $pop40
	i32.load	$push41=, 0($3)
	i32.sub 	$push42=, $pop41, $5
	i32.const	$push110=, 0
	i32.gt_s	$push43=, $pop42, $pop110
	i32.const	$push109=, .L.str.11
	call    	eosio_assert@FUNCTION, $pop43, $pop109
	i32.load	$push44=, 0($4)
	i32.const	$push55=, 15
	i32.add 	$push56=, $7, $pop55
	i32.const	$push108=, 1
	i32.call	$drop=, memcpy@FUNCTION, $pop44, $pop56, $pop108
	i32.load	$push45=, 0($4)
	i32.const	$push107=, 1
	i32.add 	$push106=, $pop45, $pop107
	tee_local	$push105=, $5=, $pop106
	i32.store	0($4), $pop105
	br_if   	0, $1
	end_loop
	i32.const	$push52=, 0
	i32.const	$push50=, 16
	i32.add 	$push51=, $7, $pop50
	i32.store	__stack_pointer($pop52), $pop51
	copy_local	$push119=, $0
	.endfunc
.Lfunc_end11:
	.size	_ZN5eosiolsINS_10datastreamIPcEEEERT_S5_RKNS_18transaction_headerE, .Lfunc_end11-_ZN5eosiolsINS_10datastreamIPcEEEERT_S5_RKNS_18transaction_headerE

	.section	.text._ZN5eosiolsINS_10datastreamIPcEENS_6actionEEERT_S6_RKNSt3__16vectorIT0_NS7_9allocatorIS9_EEEE,"axG",@progbits,_ZN5eosiolsINS_10datastreamIPcEENS_6actionEEERT_S6_RKNSt3__16vectorIT0_NS7_9allocatorIS9_EEEE,comdat
	.hidden	_ZN5eosiolsINS_10datastreamIPcEENS_6actionEEERT_S6_RKNSt3__16vectorIT0_NS7_9allocatorIS9_EEEE
	.weak	_ZN5eosiolsINS_10datastreamIPcEENS_6actionEEERT_S6_RKNSt3__16vectorIT0_NS7_9allocatorIS9_EEEE
	.type	_ZN5eosiolsINS_10datastreamIPcEENS_6actionEEERT_S6_RKNSt3__16vectorIT0_NS7_9allocatorIS9_EEEE,@function
_ZN5eosiolsINS_10datastreamIPcEENS_6actionEEERT_S6_RKNSt3__16vectorIT0_NS7_9allocatorIS9_EEEE:
	.param  	i32, i32
	.result 	i32
	.local  	i32, i32, i32, i64, i32, i32, i32
	i32.const	$push36=, 0
	i32.const	$push33=, 0
	i32.load	$push34=, __stack_pointer($pop33)
	i32.const	$push35=, 16
	i32.sub 	$push43=, $pop34, $pop35
	tee_local	$push42=, $8=, $pop43
	i32.store	__stack_pointer($pop36), $pop42
	i32.load	$push1=, 4($1)
	i32.load	$push0=, 0($1)
	i32.sub 	$push2=, $pop1, $pop0
	i32.const	$push3=, 40
	i32.div_s	$push4=, $pop2, $pop3
	i64.extend_u/i32	$5=, $pop4
	i32.load	$6=, 4($0)
	i32.const	$push8=, 8
	i32.add 	$3=, $0, $pop8
	i32.const	$push12=, 4
	i32.add 	$4=, $0, $pop12
.LBB12_1:
	loop    	
	i32.wrap/i64	$7=, $5
	i64.const	$push57=, 7
	i64.shr_u	$push56=, $5, $pop57
	tee_local	$push55=, $5=, $pop56
	i64.const	$push54=, 0
	i64.ne  	$push53=, $pop55, $pop54
	tee_local	$push52=, $2=, $pop53
	i32.const	$push51=, 7
	i32.shl 	$push6=, $pop52, $pop51
	i32.const	$push50=, 127
	i32.and 	$push5=, $7, $pop50
	i32.or  	$push7=, $pop6, $pop5
	i32.store8	15($8), $pop7
	i32.load	$push9=, 0($3)
	i32.sub 	$push10=, $pop9, $6
	i32.const	$push49=, 0
	i32.gt_s	$push11=, $pop10, $pop49
	i32.const	$push48=, .L.str.11
	call    	eosio_assert@FUNCTION, $pop11, $pop48
	i32.load	$push13=, 0($4)
	i32.const	$push40=, 15
	i32.add 	$push41=, $8, $pop40
	i32.const	$push47=, 1
	i32.call	$drop=, memcpy@FUNCTION, $pop13, $pop41, $pop47
	i32.load	$push14=, 0($4)
	i32.const	$push46=, 1
	i32.add 	$push45=, $pop14, $pop46
	tee_local	$push44=, $6=, $pop45
	i32.store	0($4), $pop44
	br_if   	0, $2
	end_loop
	block   	
	i32.load	$push62=, 0($1)
	tee_local	$push61=, $7=, $pop62
	i32.const	$push60=, 4
	i32.add 	$push15=, $1, $pop60
	i32.load	$push59=, 0($pop15)
	tee_local	$push58=, $3=, $pop59
	i32.eq  	$push16=, $pop61, $pop58
	br_if   	0, $pop16
	i32.const	$push63=, 4
	i32.add 	$4=, $0, $pop63
.LBB12_4:
	loop    	
	i32.const	$push82=, 8
	i32.add 	$push81=, $0, $pop82
	tee_local	$push80=, $2=, $pop81
	i32.load	$push17=, 0($pop80)
	i32.sub 	$push18=, $pop17, $6
	i32.const	$push79=, 7
	i32.gt_s	$push19=, $pop18, $pop79
	i32.const	$push78=, .L.str.11
	call    	eosio_assert@FUNCTION, $pop19, $pop78
	i32.load	$push20=, 0($4)
	i32.const	$push77=, 8
	i32.call	$drop=, memcpy@FUNCTION, $pop20, $7, $pop77
	i32.load	$push21=, 0($4)
	i32.const	$push76=, 8
	i32.add 	$push75=, $pop21, $pop76
	tee_local	$push74=, $6=, $pop75
	i32.store	0($4), $pop74
	i32.load	$push22=, 0($2)
	i32.sub 	$push23=, $pop22, $6
	i32.const	$push73=, 7
	i32.gt_s	$push24=, $pop23, $pop73
	i32.const	$push72=, .L.str.11
	call    	eosio_assert@FUNCTION, $pop24, $pop72
	i32.load	$push26=, 0($4)
	i32.const	$push71=, 8
	i32.add 	$push25=, $7, $pop71
	i32.const	$push70=, 8
	i32.call	$drop=, memcpy@FUNCTION, $pop26, $pop25, $pop70
	i32.load	$push27=, 0($4)
	i32.const	$push69=, 8
	i32.add 	$push28=, $pop27, $pop69
	i32.store	0($4), $pop28
	i32.const	$push68=, 16
	i32.add 	$push30=, $7, $pop68
	i32.call	$push31=, _ZN5eosiolsINS_10datastreamIPcEENS_16permission_levelEEERT_S6_RKNSt3__16vectorIT0_NS7_9allocatorIS9_EEEE@FUNCTION, $0, $pop30
	i32.const	$push67=, 28
	i32.add 	$push29=, $7, $pop67
	i32.call	$drop=, _ZN5eosiolsINS_10datastreamIPcEEEERT_S5_RKNSt3__16vectorIcNS6_9allocatorIcEEEE@FUNCTION, $pop31, $pop29
	i32.const	$push66=, 40
	i32.add 	$push65=, $7, $pop66
	tee_local	$push64=, $7=, $pop65
	i32.eq  	$push32=, $pop64, $3
	br_if   	1, $pop32
	i32.load	$6=, 0($4)
	br      	0
.LBB12_6:
	end_loop
	end_block
	i32.const	$push39=, 0
	i32.const	$push37=, 16
	i32.add 	$push38=, $8, $pop37
	i32.store	__stack_pointer($pop39), $pop38
	copy_local	$push83=, $0
	.endfunc
.Lfunc_end12:
	.size	_ZN5eosiolsINS_10datastreamIPcEENS_6actionEEERT_S6_RKNSt3__16vectorIT0_NS7_9allocatorIS9_EEEE, .Lfunc_end12-_ZN5eosiolsINS_10datastreamIPcEENS_6actionEEERT_S6_RKNSt3__16vectorIT0_NS7_9allocatorIS9_EEEE

	.section	.text._ZN5eosiolsINS_10datastreamIPcEENSt3__15tupleIJtNS4_6vectorIcNS4_9allocatorIcEEEEEEEEERT_SC_RKNS6_IT0_NS7_ISD_EEEE,"axG",@progbits,_ZN5eosiolsINS_10datastreamIPcEENSt3__15tupleIJtNS4_6vectorIcNS4_9allocatorIcEEEEEEEEERT_SC_RKNS6_IT0_NS7_ISD_EEEE,comdat
	.hidden	_ZN5eosiolsINS_10datastreamIPcEENSt3__15tupleIJtNS4_6vectorIcNS4_9allocatorIcEEEEEEEEERT_SC_RKNS6_IT0_NS7_ISD_EEEE
	.weak	_ZN5eosiolsINS_10datastreamIPcEENSt3__15tupleIJtNS4_6vectorIcNS4_9allocatorIcEEEEEEEEERT_SC_RKNS6_IT0_NS7_ISD_EEEE
	.type	_ZN5eosiolsINS_10datastreamIPcEENSt3__15tupleIJtNS4_6vectorIcNS4_9allocatorIcEEEEEEEEERT_SC_RKNS6_IT0_NS7_ISD_EEEE,@function
_ZN5eosiolsINS_10datastreamIPcEENSt3__15tupleIJtNS4_6vectorIcNS4_9allocatorIcEEEEEEEEERT_SC_RKNS6_IT0_NS7_ISD_EEEE:
	.param  	i32, i32
	.result 	i32
	.local  	i32, i32, i32, i64, i32, i32
	i32.const	$push27=, 0
	i32.const	$push24=, 0
	i32.load	$push25=, __stack_pointer($pop24)
	i32.const	$push26=, 16
	i32.sub 	$push35=, $pop25, $pop26
	tee_local	$push34=, $7=, $pop35
	i32.store	__stack_pointer($pop27), $pop34
	i32.load	$push1=, 4($1)
	i32.load	$push0=, 0($1)
	i32.sub 	$push2=, $pop1, $pop0
	i32.const	$push33=, 4
	i32.shr_s	$push3=, $pop2, $pop33
	i64.extend_u/i32	$5=, $pop3
	i32.load	$6=, 4($0)
	i32.const	$push7=, 8
	i32.add 	$3=, $0, $pop7
.LBB13_1:
	loop    	
	i32.wrap/i64	$4=, $5
	i64.const	$push52=, 7
	i64.shr_u	$push51=, $5, $pop52
	tee_local	$push50=, $5=, $pop51
	i64.const	$push49=, 0
	i64.ne  	$push48=, $pop50, $pop49
	tee_local	$push47=, $2=, $pop48
	i32.const	$push46=, 7
	i32.shl 	$push5=, $pop47, $pop46
	i32.const	$push45=, 127
	i32.and 	$push4=, $4, $pop45
	i32.or  	$push6=, $pop5, $pop4
	i32.store8	15($7), $pop6
	i32.load	$push8=, 0($3)
	i32.sub 	$push9=, $pop8, $6
	i32.const	$push44=, 0
	i32.gt_s	$push10=, $pop9, $pop44
	i32.const	$push43=, .L.str.11
	call    	eosio_assert@FUNCTION, $pop10, $pop43
	i32.const	$push42=, 4
	i32.add 	$push41=, $0, $pop42
	tee_local	$push40=, $4=, $pop41
	i32.load	$push11=, 0($pop40)
	i32.const	$push31=, 15
	i32.add 	$push32=, $7, $pop31
	i32.const	$push39=, 1
	i32.call	$drop=, memcpy@FUNCTION, $pop11, $pop32, $pop39
	i32.load	$push12=, 0($4)
	i32.const	$push38=, 1
	i32.add 	$push37=, $pop12, $pop38
	tee_local	$push36=, $6=, $pop37
	i32.store	0($4), $pop36
	br_if   	0, $2
	end_loop
	block   	
	i32.load	$push57=, 0($1)
	tee_local	$push56=, $4=, $pop57
	i32.const	$push55=, 4
	i32.add 	$push13=, $1, $pop55
	i32.load	$push54=, 0($pop13)
	tee_local	$push53=, $2=, $pop54
	i32.eq  	$push14=, $pop56, $pop53
	br_if   	0, $pop14
	i32.const	$push15=, 8
	i32.add 	$3=, $0, $pop15
.LBB13_4:
	loop    	
	i32.load	$push16=, 0($3)
	i32.sub 	$push17=, $pop16, $6
	i32.const	$push68=, 1
	i32.gt_s	$push18=, $pop17, $pop68
	i32.const	$push67=, .L.str.11
	call    	eosio_assert@FUNCTION, $pop18, $pop67
	i32.const	$push66=, 4
	i32.add 	$push65=, $0, $pop66
	tee_local	$push64=, $6=, $pop65
	i32.load	$push19=, 0($pop64)
	i32.const	$push63=, 2
	i32.call	$drop=, memcpy@FUNCTION, $pop19, $4, $pop63
	i32.load	$push20=, 0($6)
	i32.const	$push62=, 2
	i32.add 	$push21=, $pop20, $pop62
	i32.store	0($6), $pop21
	i32.const	$push61=, 4
	i32.add 	$push22=, $4, $pop61
	i32.call	$drop=, _ZN5eosiolsINS_10datastreamIPcEEEERT_S5_RKNSt3__16vectorIcNS6_9allocatorIcEEEE@FUNCTION, $0, $pop22
	i32.const	$push60=, 16
	i32.add 	$push59=, $4, $pop60
	tee_local	$push58=, $4=, $pop59
	i32.eq  	$push23=, $pop58, $2
	br_if   	1, $pop23
	i32.load	$6=, 0($6)
	br      	0
.LBB13_6:
	end_loop
	end_block
	i32.const	$push30=, 0
	i32.const	$push28=, 16
	i32.add 	$push29=, $7, $pop28
	i32.store	__stack_pointer($pop30), $pop29
	copy_local	$push69=, $0
	.endfunc
.Lfunc_end13:
	.size	_ZN5eosiolsINS_10datastreamIPcEENSt3__15tupleIJtNS4_6vectorIcNS4_9allocatorIcEEEEEEEEERT_SC_RKNS6_IT0_NS7_ISD_EEEE, .Lfunc_end13-_ZN5eosiolsINS_10datastreamIPcEENSt3__15tupleIJtNS4_6vectorIcNS4_9allocatorIcEEEEEEEEERT_SC_RKNS6_IT0_NS7_ISD_EEEE

	.section	.text._ZN5eosiolsINS_10datastreamIPcEEEERT_S5_RKNSt3__16vectorIcNS6_9allocatorIcEEEE,"axG",@progbits,_ZN5eosiolsINS_10datastreamIPcEEEERT_S5_RKNSt3__16vectorIcNS6_9allocatorIcEEEE,comdat
	.hidden	_ZN5eosiolsINS_10datastreamIPcEEEERT_S5_RKNSt3__16vectorIcNS6_9allocatorIcEEEE
	.weak	_ZN5eosiolsINS_10datastreamIPcEEEERT_S5_RKNSt3__16vectorIcNS6_9allocatorIcEEEE
	.type	_ZN5eosiolsINS_10datastreamIPcEEEERT_S5_RKNSt3__16vectorIcNS6_9allocatorIcEEEE,@function
_ZN5eosiolsINS_10datastreamIPcEEEERT_S5_RKNSt3__16vectorIcNS6_9allocatorIcEEEE:
	.param  	i32, i32
	.result 	i32
	.local  	i32, i32, i32, i32, i32, i64, i32
	i32.const	$push28=, 0
	i32.const	$push25=, 0
	i32.load	$push26=, __stack_pointer($pop25)
	i32.const	$push27=, 16
	i32.sub 	$push35=, $pop26, $pop27
	tee_local	$push34=, $8=, $pop35
	i32.store	__stack_pointer($pop28), $pop34
	i32.load	$push1=, 4($1)
	i32.load	$push0=, 0($1)
	i32.sub 	$push2=, $pop1, $pop0
	i64.extend_u/i32	$7=, $pop2
	i32.load	$6=, 4($0)
	i32.const	$push6=, 8
	i32.add 	$4=, $0, $pop6
	i32.const	$push10=, 4
	i32.add 	$5=, $0, $pop10
.LBB14_1:
	loop    	
	i32.wrap/i64	$2=, $7
	i64.const	$push49=, 7
	i64.shr_u	$push48=, $7, $pop49
	tee_local	$push47=, $7=, $pop48
	i64.const	$push46=, 0
	i64.ne  	$push45=, $pop47, $pop46
	tee_local	$push44=, $3=, $pop45
	i32.const	$push43=, 7
	i32.shl 	$push4=, $pop44, $pop43
	i32.const	$push42=, 127
	i32.and 	$push3=, $2, $pop42
	i32.or  	$push5=, $pop4, $pop3
	i32.store8	15($8), $pop5
	i32.load	$push7=, 0($4)
	i32.sub 	$push8=, $pop7, $6
	i32.const	$push41=, 0
	i32.gt_s	$push9=, $pop8, $pop41
	i32.const	$push40=, .L.str.11
	call    	eosio_assert@FUNCTION, $pop9, $pop40
	i32.load	$push11=, 0($5)
	i32.const	$push32=, 15
	i32.add 	$push33=, $8, $pop32
	i32.const	$push39=, 1
	i32.call	$drop=, memcpy@FUNCTION, $pop11, $pop33, $pop39
	i32.load	$push12=, 0($5)
	i32.const	$push38=, 1
	i32.add 	$push37=, $pop12, $pop38
	tee_local	$push36=, $6=, $pop37
	i32.store	0($5), $pop36
	br_if   	0, $3
	end_loop
	i32.const	$push16=, 8
	i32.add 	$push17=, $0, $pop16
	i32.load	$push18=, 0($pop17)
	i32.sub 	$push19=, $pop18, $6
	i32.const	$push13=, 4
	i32.add 	$push14=, $1, $pop13
	i32.load	$push15=, 0($pop14)
	i32.load	$push56=, 0($1)
	tee_local	$push55=, $2=, $pop56
	i32.sub 	$push54=, $pop15, $pop55
	tee_local	$push53=, $5=, $pop54
	i32.ge_s	$push20=, $pop19, $pop53
	i32.const	$push21=, .L.str.11
	call    	eosio_assert@FUNCTION, $pop20, $pop21
	i32.const	$push52=, 4
	i32.add 	$push51=, $0, $pop52
	tee_local	$push50=, $6=, $pop51
	i32.load	$push22=, 0($pop50)
	i32.call	$drop=, memcpy@FUNCTION, $pop22, $2, $5
	i32.load	$push23=, 0($6)
	i32.add 	$push24=, $pop23, $5
	i32.store	0($6), $pop24
	i32.const	$push31=, 0
	i32.const	$push29=, 16
	i32.add 	$push30=, $8, $pop29
	i32.store	__stack_pointer($pop31), $pop30
	copy_local	$push57=, $0
	.endfunc
.Lfunc_end14:
	.size	_ZN5eosiolsINS_10datastreamIPcEEEERT_S5_RKNSt3__16vectorIcNS6_9allocatorIcEEEE, .Lfunc_end14-_ZN5eosiolsINS_10datastreamIPcEEEERT_S5_RKNSt3__16vectorIcNS6_9allocatorIcEEEE

	.section	.text._ZN5eosiolsINS_10datastreamIPcEENS_16permission_levelEEERT_S6_RKNSt3__16vectorIT0_NS7_9allocatorIS9_EEEE,"axG",@progbits,_ZN5eosiolsINS_10datastreamIPcEENS_16permission_levelEEERT_S6_RKNSt3__16vectorIT0_NS7_9allocatorIS9_EEEE,comdat
	.hidden	_ZN5eosiolsINS_10datastreamIPcEENS_16permission_levelEEERT_S6_RKNSt3__16vectorIT0_NS7_9allocatorIS9_EEEE
	.weak	_ZN5eosiolsINS_10datastreamIPcEENS_16permission_levelEEERT_S6_RKNSt3__16vectorIT0_NS7_9allocatorIS9_EEEE
	.type	_ZN5eosiolsINS_10datastreamIPcEENS_16permission_levelEEERT_S6_RKNSt3__16vectorIT0_NS7_9allocatorIS9_EEEE,@function
_ZN5eosiolsINS_10datastreamIPcEENS_16permission_levelEEERT_S6_RKNSt3__16vectorIT0_NS7_9allocatorIS9_EEEE:
	.param  	i32, i32
	.result 	i32
	.local  	i32, i32, i64, i32, i32, i32
	i32.const	$push30=, 0
	i32.const	$push27=, 0
	i32.load	$push28=, __stack_pointer($pop27)
	i32.const	$push29=, 16
	i32.sub 	$push38=, $pop28, $pop29
	tee_local	$push37=, $7=, $pop38
	i32.store	__stack_pointer($pop30), $pop37
	i32.load	$push1=, 4($1)
	i32.load	$push0=, 0($1)
	i32.sub 	$push2=, $pop1, $pop0
	i32.const	$push36=, 4
	i32.shr_s	$push3=, $pop2, $pop36
	i64.extend_u/i32	$4=, $pop3
	i32.load	$5=, 4($0)
	i32.const	$push7=, 8
	i32.add 	$2=, $0, $pop7
.LBB15_1:
	loop    	
	i32.wrap/i64	$3=, $4
	i64.const	$push55=, 7
	i64.shr_u	$push54=, $4, $pop55
	tee_local	$push53=, $4=, $pop54
	i64.const	$push52=, 0
	i64.ne  	$push51=, $pop53, $pop52
	tee_local	$push50=, $6=, $pop51
	i32.const	$push49=, 7
	i32.shl 	$push5=, $pop50, $pop49
	i32.const	$push48=, 127
	i32.and 	$push4=, $3, $pop48
	i32.or  	$push6=, $pop5, $pop4
	i32.store8	15($7), $pop6
	i32.load	$push8=, 0($2)
	i32.sub 	$push9=, $pop8, $5
	i32.const	$push47=, 0
	i32.gt_s	$push10=, $pop9, $pop47
	i32.const	$push46=, .L.str.11
	call    	eosio_assert@FUNCTION, $pop10, $pop46
	i32.const	$push45=, 4
	i32.add 	$push44=, $0, $pop45
	tee_local	$push43=, $3=, $pop44
	i32.load	$push11=, 0($pop43)
	i32.const	$push34=, 15
	i32.add 	$push35=, $7, $pop34
	i32.const	$push42=, 1
	i32.call	$drop=, memcpy@FUNCTION, $pop11, $pop35, $pop42
	i32.load	$push12=, 0($3)
	i32.const	$push41=, 1
	i32.add 	$push40=, $pop12, $pop41
	tee_local	$push39=, $5=, $pop40
	i32.store	0($3), $pop39
	br_if   	0, $6
	end_loop
	block   	
	i32.load	$push60=, 0($1)
	tee_local	$push59=, $6=, $pop60
	i32.const	$push58=, 4
	i32.add 	$push13=, $1, $pop58
	i32.load	$push57=, 0($pop13)
	tee_local	$push56=, $1=, $pop57
	i32.eq  	$push14=, $pop59, $pop56
	br_if   	0, $pop14
	i32.const	$push61=, 4
	i32.add 	$3=, $0, $pop61
.LBB15_4:
	loop    	
	i32.const	$push80=, 8
	i32.add 	$push79=, $0, $pop80
	tee_local	$push78=, $2=, $pop79
	i32.load	$push15=, 0($pop78)
	i32.sub 	$push16=, $pop15, $5
	i32.const	$push77=, 7
	i32.gt_s	$push17=, $pop16, $pop77
	i32.const	$push76=, .L.str.11
	call    	eosio_assert@FUNCTION, $pop17, $pop76
	i32.load	$push18=, 0($3)
	i32.const	$push75=, 8
	i32.call	$drop=, memcpy@FUNCTION, $pop18, $6, $pop75
	i32.load	$push19=, 0($3)
	i32.const	$push74=, 8
	i32.add 	$push73=, $pop19, $pop74
	tee_local	$push72=, $5=, $pop73
	i32.store	0($3), $pop72
	i32.load	$push20=, 0($2)
	i32.sub 	$push21=, $pop20, $5
	i32.const	$push71=, 7
	i32.gt_s	$push22=, $pop21, $pop71
	i32.const	$push70=, .L.str.11
	call    	eosio_assert@FUNCTION, $pop22, $pop70
	i32.load	$push24=, 0($3)
	i32.const	$push69=, 8
	i32.add 	$push23=, $6, $pop69
	i32.const	$push68=, 8
	i32.call	$drop=, memcpy@FUNCTION, $pop24, $pop23, $pop68
	i32.load	$push25=, 0($3)
	i32.const	$push67=, 8
	i32.add 	$push66=, $pop25, $pop67
	tee_local	$push65=, $5=, $pop66
	i32.store	0($3), $pop65
	i32.const	$push64=, 16
	i32.add 	$push63=, $6, $pop64
	tee_local	$push62=, $6=, $pop63
	i32.ne  	$push26=, $pop62, $1
	br_if   	0, $pop26
.LBB15_5:
	end_loop
	end_block
	i32.const	$push33=, 0
	i32.const	$push31=, 16
	i32.add 	$push32=, $7, $pop31
	i32.store	__stack_pointer($pop33), $pop32
	copy_local	$push81=, $0
	.endfunc
.Lfunc_end15:
	.size	_ZN5eosiolsINS_10datastreamIPcEENS_16permission_levelEEERT_S6_RKNSt3__16vectorIT0_NS7_9allocatorIS9_EEEE, .Lfunc_end15-_ZN5eosiolsINS_10datastreamIPcEENS_16permission_levelEEERT_S6_RKNSt3__16vectorIT0_NS7_9allocatorIS9_EEEE

	.text
	.hidden	_ZN5eosio30check_permission_authorizationEyyRKNSt3__13setI10public_keyNS0_4lessIS2_EENS0_9allocatorIS2_EEEERKNS1_INS_16permission_levelENS3_ISA_EENS5_ISA_EEEEy
	.globl	_ZN5eosio30check_permission_authorizationEyyRKNSt3__13setI10public_keyNS0_4lessIS2_EENS0_9allocatorIS2_EEEERKNS1_INS_16permission_levelENS3_ISA_EENS5_ISA_EEEEy
	.type	_ZN5eosio30check_permission_authorizationEyyRKNSt3__13setI10public_keyNS0_4lessIS2_EENS0_9allocatorIS2_EEEERKNS1_INS_16permission_levelENS3_ISA_EENS5_ISA_EEEEy,@function
_ZN5eosio30check_permission_authorizationEyyRKNSt3__13setI10public_keyNS0_4lessIS2_EENS0_9allocatorIS2_EEEERKNS1_INS_16permission_levelENS3_ISA_EENS5_ISA_EEEEy:
	.param  	i64, i64, i32, i32, i64
	.result 	i32
	.local  	i32, i32, i64, i32, i32, i32, i32, i32, i32, i32, i32
	i32.const	$push28=, 0
	i32.const	$push25=, 0
	i32.load	$push26=, __stack_pointer($pop25)
	i32.const	$push27=, 32
	i32.sub 	$push39=, $pop26, $pop27
	tee_local	$push38=, $15=, $pop39
	i32.store	__stack_pointer($pop28), $pop38
	i32.const	$14=, 0
	i32.const	$12=, 0
	i32.const	$13=, 0
	block   	
	i32.load	$push37=, 8($2)
	tee_local	$push36=, $5=, $pop37
	i32.eqz 	$push101=, $pop36
	br_if   	0, $pop101
	i32.const	$8=, 0
	i32.const	$push41=, 0
	i32.store	8($15), $pop41
	i64.const	$push40=, 0
	i64.store	0($15), $pop40
	i64.extend_u/i32	$7=, $5
.LBB16_2:
	loop    	
	i32.const	$push46=, 1
	i32.add 	$8=, $8, $pop46
	i64.const	$push45=, 7
	i64.shr_u	$push44=, $7, $pop45
	tee_local	$push43=, $7=, $pop44
	i64.const	$push42=, 0
	i64.ne  	$push0=, $pop43, $pop42
	br_if   	0, $pop0
	end_loop
	block   	
	block   	
	block   	
	i32.load	$push50=, 0($2)
	tee_local	$push49=, $9=, $pop50
	i32.const	$push1=, 4
	i32.add 	$push48=, $2, $pop1
	tee_local	$push47=, $6=, $pop48
	i32.eq  	$push2=, $pop49, $pop47
	br_if   	0, $pop2
.LBB16_5:
	loop    	
	block   	
	block   	
	copy_local	$push54=, $9
	tee_local	$push53=, $11=, $pop54
	i32.load	$push52=, 4($pop53)
	tee_local	$push51=, $10=, $pop52
	i32.eqz 	$push102=, $pop51
	br_if   	0, $pop102
.LBB16_6:
	loop    	
	copy_local	$push58=, $10
	tee_local	$push57=, $9=, $pop58
	i32.load	$push56=, 0($pop57)
	tee_local	$push55=, $10=, $pop56
	br_if   	0, $pop55
	br      	2
.LBB16_7:
	end_loop
	end_block
	i32.load	$push60=, 8($11)
	tee_local	$push59=, $9=, $pop60
	i32.load	$push3=, 0($pop59)
	i32.eq  	$push4=, $pop3, $11
	br_if   	0, $pop4
	i32.const	$push61=, 8
	i32.add 	$11=, $11, $pop61
.LBB16_9:
	loop    	
	i32.load	$push66=, 0($11)
	tee_local	$push65=, $10=, $pop66
	i32.const	$push64=, 8
	i32.add 	$11=, $pop65, $pop64
	i32.load	$push63=, 8($10)
	tee_local	$push62=, $9=, $pop63
	i32.load	$push5=, 0($pop62)
	i32.ne  	$push6=, $10, $pop5
	br_if   	0, $pop6
.LBB16_10:
	end_loop
	end_block
	i32.const	$push67=, 34
	i32.add 	$8=, $8, $pop67
	i32.ne  	$push7=, $9, $6
	br_if   	0, $pop7
	end_loop
	i32.eqz 	$push103=, $8
	br_if   	1, $pop103
.LBB16_12:
	end_block
	call    	_ZNSt3__16vectorIcNS_9allocatorIcEEE8__appendEj@FUNCTION, $15, $8
	i32.load	$9=, 4($15)
	i32.load	$10=, 0($15)
	br      	1
.LBB16_13:
	end_block
	i32.const	$9=, 0
	i32.const	$10=, 0
.LBB16_14:
	end_block
	i32.store	20($15), $10
	i32.store	16($15), $10
	i32.store	24($15), $9
	i32.const	$push32=, 16
	i32.add 	$push33=, $15, $pop32
	i32.call	$drop=, _ZN5eosiolsINS_10datastreamIPcEE10public_keyEERT_S6_RKNSt3__13setIT0_NS7_4lessIS9_EENS7_9allocatorIS9_EEEE@FUNCTION, $pop33, $2
	i32.load	$12=, 4($15)
	i32.load	$13=, 0($15)
.LBB16_15:
	end_block
	i32.const	$10=, 0
	block   	
	i32.load	$push69=, 8($3)
	tee_local	$push68=, $2=, $pop69
	i32.eqz 	$push104=, $pop68
	br_if   	0, $pop104
	i32.const	$8=, 0
	i32.const	$push71=, 0
	i32.store	8($15), $pop71
	i64.const	$push70=, 0
	i64.store	0($15), $pop70
	i64.extend_u/i32	$7=, $2
.LBB16_17:
	loop    	
	i32.const	$push76=, 1
	i32.add 	$8=, $8, $pop76
	i64.const	$push75=, 7
	i64.shr_u	$push74=, $7, $pop75
	tee_local	$push73=, $7=, $pop74
	i64.const	$push72=, 0
	i64.ne  	$push8=, $pop73, $pop72
	br_if   	0, $pop8
	end_loop
	block   	
	block   	
	block   	
	i32.load	$push80=, 0($3)
	tee_local	$push79=, $9=, $pop80
	i32.const	$push9=, 4
	i32.add 	$push78=, $3, $pop9
	tee_local	$push77=, $6=, $pop78
	i32.eq  	$push10=, $pop79, $pop77
	br_if   	0, $pop10
.LBB16_20:
	loop    	
	block   	
	block   	
	copy_local	$push84=, $9
	tee_local	$push83=, $11=, $pop84
	i32.load	$push82=, 4($pop83)
	tee_local	$push81=, $10=, $pop82
	i32.eqz 	$push105=, $pop81
	br_if   	0, $pop105
.LBB16_21:
	loop    	
	copy_local	$push88=, $10
	tee_local	$push87=, $9=, $pop88
	i32.load	$push86=, 0($pop87)
	tee_local	$push85=, $10=, $pop86
	br_if   	0, $pop85
	br      	2
.LBB16_22:
	end_loop
	end_block
	i32.load	$push90=, 8($11)
	tee_local	$push89=, $9=, $pop90
	i32.load	$push11=, 0($pop89)
	i32.eq  	$push12=, $pop11, $11
	br_if   	0, $pop12
	i32.const	$push91=, 8
	i32.add 	$11=, $11, $pop91
.LBB16_24:
	loop    	
	i32.load	$push96=, 0($11)
	tee_local	$push95=, $10=, $pop96
	i32.const	$push94=, 8
	i32.add 	$11=, $pop95, $pop94
	i32.load	$push93=, 8($10)
	tee_local	$push92=, $9=, $pop93
	i32.load	$push13=, 0($pop92)
	i32.ne  	$push14=, $10, $pop13
	br_if   	0, $pop14
.LBB16_25:
	end_loop
	end_block
	i32.const	$push97=, 16
	i32.add 	$8=, $8, $pop97
	i32.ne  	$push15=, $9, $6
	br_if   	0, $pop15
	end_loop
	i32.eqz 	$push106=, $8
	br_if   	1, $pop106
.LBB16_27:
	end_block
	call    	_ZNSt3__16vectorIcNS_9allocatorIcEEE8__appendEj@FUNCTION, $15, $8
	i32.load	$9=, 4($15)
	i32.load	$10=, 0($15)
	br      	1
.LBB16_28:
	end_block
	i32.const	$9=, 0
	i32.const	$10=, 0
.LBB16_29:
	end_block
	i32.store	20($15), $10
	i32.store	16($15), $10
	i32.store	24($15), $9
	i32.const	$push34=, 16
	i32.add 	$push35=, $15, $pop34
	i32.call	$drop=, _ZN5eosiolsINS_10datastreamIPcEENS_16permission_levelEEERT_S6_RKNSt3__13setIT0_NS7_4lessIS9_EENS7_9allocatorIS9_EEEE@FUNCTION, $pop35, $3
	i32.load	$14=, 4($15)
	i32.load	$10=, 0($15)
.LBB16_30:
	end_block
	i32.const	$push16=, 0
	i32.select	$push18=, $13, $pop16, $5
	i32.sub 	$push21=, $12, $13
	i32.const	$push100=, 0
	i32.select	$push22=, $pop21, $pop100, $5
	i32.const	$push99=, 0
	i32.select	$push17=, $10, $pop99, $2
	i32.sub 	$push19=, $14, $10
	i32.const	$push98=, 0
	i32.select	$push20=, $pop19, $pop98, $2
	i32.call	$9=, check_permission_authorization@FUNCTION, $0, $1, $pop18, $pop22, $pop17, $pop20, $4
	block   	
	i32.eqz 	$push107=, $10
	br_if   	0, $pop107
	call    	_ZdlPv@FUNCTION, $10
.LBB16_32:
	end_block
	block   	
	i32.eqz 	$push108=, $13
	br_if   	0, $pop108
	call    	_ZdlPv@FUNCTION, $13
.LBB16_34:
	end_block
	i32.const	$push31=, 0
	i32.const	$push29=, 32
	i32.add 	$push30=, $15, $pop29
	i32.store	__stack_pointer($pop31), $pop30
	i32.const	$push23=, 0
	i32.gt_s	$push24=, $9, $pop23
	.endfunc
.Lfunc_end16:
	.size	_ZN5eosio30check_permission_authorizationEyyRKNSt3__13setI10public_keyNS0_4lessIS2_EENS0_9allocatorIS2_EEEERKNS1_INS_16permission_levelENS3_ISA_EENS5_ISA_EEEEy, .Lfunc_end16-_ZN5eosio30check_permission_authorizationEyyRKNSt3__13setI10public_keyNS0_4lessIS2_EENS0_9allocatorIS2_EEEERKNS1_INS_16permission_levelENS3_ISA_EENS5_ISA_EEEEy

	.hidden	_ZN5eosio8multisig7proposeEv
	.globl	_ZN5eosio8multisig7proposeEv
	.type	_ZN5eosio8multisig7proposeEv,@function
_ZN5eosio8multisig7proposeEv:
	.param  	i32
	.local  	i32, i32, i64, i32, i32, i64, i32
	i32.const	$push115=, 0
	i32.const	$push112=, 0
	i32.load	$push113=, __stack_pointer($pop112)
	i32.const	$push114=, 240
	i32.sub 	$push193=, $pop113, $pop114
	tee_local	$push192=, $2=, $pop193
	i32.store	__stack_pointer($pop115), $pop192
	copy_local	$push191=, $2
	tee_local	$push190=, $7=, $pop191
	i32.call	$push189=, action_data_size@FUNCTION
	tee_local	$push188=, $5=, $pop189
	i32.store	200($pop190), $pop188
	block   	
	block   	
	i32.const	$push0=, 513
	i32.lt_u	$push1=, $5, $pop0
	br_if   	0, $pop1
	i32.call	$2=, malloc@FUNCTION, $5
	br      	1
.LBB17_2:
	end_block
	i32.const	$push111=, 0
	i32.const	$push2=, 15
	i32.add 	$push3=, $5, $pop2
	i32.const	$push4=, -16
	i32.and 	$push5=, $pop3, $pop4
	i32.sub 	$push195=, $2, $pop5
	tee_local	$push194=, $2=, $pop195
	copy_local	$push187=, $pop194
	i32.store	__stack_pointer($pop111), $pop187
.LBB17_3:
	end_block
	i32.store	196($7), $2
	i32.call	$drop=, read_action_data@FUNCTION, $2, $5
	i64.const	$push219=, 0
	i64.store	176($7), $pop219
	i32.const	$5=, 0
	i32.const	$push218=, 0
	i32.store	168($7), $pop218
	i64.const	$push217=, 0
	i64.store	160($7), $pop217
	i64.call	$6=, current_time@FUNCTION
	i32.const	$push216=, 0
	i32.store	148($7), $pop216
	i32.const	$push215=, 0
	i32.store8	152($7), $pop215
	i32.const	$push214=, 0
	i32.store	156($7), $pop214
	i64.const	$push6=, 1000000
	i64.div_u	$push7=, $6, $pop6
	i32.wrap/i64	$push8=, $pop7
	i32.const	$push9=, 60
	i32.add 	$push10=, $pop8, $pop9
	i32.store	136($7), $pop10
	i32.load	$push213=, 196($7)
	tee_local	$push212=, $2=, $pop213
	i32.store	124($7), $pop212
	i32.load	$1=, 200($7)
	i32.store	120($7), $2
	i32.add 	$push11=, $2, $1
	i32.store	128($7), $pop11
	i32.const	$push12=, 7
	i32.gt_u	$push13=, $1, $pop12
	i32.const	$push14=, .L.str.12
	call    	eosio_assert@FUNCTION, $pop13, $pop14
	i32.const	$push119=, 184
	i32.add 	$push120=, $7, $pop119
	i32.load	$push16=, 124($7)
	i32.const	$push15=, 8
	i32.call	$drop=, memcpy@FUNCTION, $pop120, $pop16, $pop15
	i32.load	$push17=, 124($7)
	i32.const	$push211=, 8
	i32.add 	$push210=, $pop17, $pop211
	tee_local	$push209=, $2=, $pop210
	i32.store	124($7), $pop209
	i32.load	$push18=, 128($7)
	i32.sub 	$push19=, $pop18, $2
	i32.const	$push208=, 7
	i32.gt_u	$push20=, $pop19, $pop208
	i32.const	$push207=, .L.str.12
	call    	eosio_assert@FUNCTION, $pop20, $pop207
	i32.const	$push121=, 176
	i32.add 	$push122=, $7, $pop121
	i32.load	$push21=, 124($7)
	i32.const	$push206=, 8
	i32.call	$drop=, memcpy@FUNCTION, $pop122, $pop21, $pop206
	i32.load	$push22=, 124($7)
	i32.const	$push205=, 8
	i32.add 	$push23=, $pop22, $pop205
	i32.store	124($7), $pop23
	i32.const	$push123=, 120
	i32.add 	$push124=, $7, $pop123
	i32.const	$push125=, 160
	i32.add 	$push126=, $7, $pop125
	i32.call	$drop=, _ZN5eosiorsINS_10datastreamIPKcEENS_16permission_levelEEERT_S7_RNSt3__16vectorIT0_NS8_9allocatorISA_EEEE@FUNCTION, $pop124, $pop126
	i32.load	$push25=, 124($7)
	i32.load	$push24=, 120($7)
	i32.sub 	$push26=, $pop25, $pop24
	i32.store	116($7), $pop26
	i32.const	$push127=, 120
	i32.add 	$push128=, $7, $pop127
	i32.const	$push129=, 136
	i32.add 	$push130=, $7, $pop129
	i32.call	$drop=, _ZN5eosiorsINS_10datastreamIPKcEEEERT_S6_RNS_18transaction_headerE@FUNCTION, $pop128, $pop130
	i64.load	$push27=, 184($7)
	call    	require_auth@FUNCTION, $pop27
	i64.call	$6=, current_time@FUNCTION
	i32.load	$push30=, 136($7)
	i64.const	$push204=, 1000000
	i64.div_u	$push28=, $6, $pop204
	i32.wrap/i64	$push29=, $pop28
	i32.ge_u	$push31=, $pop30, $pop29
	i32.const	$push32=, .L.str
	call    	eosio_assert@FUNCTION, $pop31, $pop32
	i64.load	$6=, 184($7)
	i64.load	$push203=, 0($0)
	tee_local	$push202=, $3=, $pop203
	i64.store	72($7), $pop202
	i64.const	$push33=, -1
	i64.store	88($7), $pop33
	i32.const	$push201=, 0
	i32.store	96($7), $pop201
	i64.store	80($7), $6
	i32.const	$push34=, 100
	i32.add 	$push35=, $7, $pop34
	i32.const	$push200=, 0
	i32.store	0($pop35), $pop200
	i32.const	$push36=, 104
	i32.add 	$push37=, $7, $pop36
	i32.const	$push199=, 0
	i32.store	0($pop37), $pop199
	i32.const	$2=, 0
	block   	
	i64.const	$push39=, -5915097263704637440
	i64.load	$push38=, 176($7)
	i32.call	$push198=, db_find_i64@FUNCTION, $3, $6, $pop39, $pop38
	tee_local	$push197=, $1=, $pop198
	i32.const	$push196=, 0
	i32.lt_s	$push40=, $pop197, $pop196
	br_if   	0, $pop40
	i32.const	$push183=, 72
	i32.add 	$push184=, $7, $pop183
	i32.call	$push221=, _ZNK5eosio11multi_indexILy12531646810004914176ENS_8multisig8proposalEJEE31load_object_by_primary_iteratorEl@FUNCTION, $pop184, $1
	tee_local	$push220=, $2=, $pop221
	i32.load	$push41=, 20($pop220)
	i32.const	$push185=, 72
	i32.add 	$push186=, $7, $pop185
	i32.eq  	$push42=, $pop41, $pop186
	i32.const	$push43=, .L.str.14
	call    	eosio_assert@FUNCTION, $pop42, $pop43
.LBB17_5:
	end_block
	i32.eqz 	$push44=, $2
	i32.const	$push45=, .L.str.1
	call    	eosio_assert@FUNCTION, $pop44, $pop45
	i64.const	$push229=, 0
	i64.store	56($7), $pop229
	i32.const	$push228=, 0
	i32.store	64($7), $pop228
	i32.load	$push227=, 164($7)
	tee_local	$push226=, $2=, $pop227
	i32.load	$push225=, 160($7)
	tee_local	$push224=, $1=, $pop225
	i32.sub 	$push223=, $pop226, $pop224
	tee_local	$push222=, $4=, $pop223
	i32.const	$push46=, 4
	i32.shr_s	$push47=, $pop222, $pop46
	i64.extend_u/i32	$6=, $pop47
.LBB17_6:
	loop    	
	i32.const	$push234=, -1
	i32.add 	$5=, $5, $pop234
	i64.const	$push233=, 7
	i64.shr_u	$push232=, $6, $pop233
	tee_local	$push231=, $6=, $pop232
	i64.const	$push230=, 0
	i64.ne  	$push48=, $pop231, $pop230
	br_if   	0, $pop48
	end_loop
	block   	
	block   	
	block   	
	block   	
	i32.eq  	$push50=, $1, $2
	br_if   	0, $pop50
	i32.const	$push51=, -16
	i32.and 	$push236=, $4, $pop51
	tee_local	$push235=, $2=, $pop236
	i32.ne  	$push52=, $pop235, $5
	br_if   	1, $pop52
	i32.const	$2=, 0
	i32.const	$5=, 0
	br      	3
.LBB17_10:
	end_block
	i32.const	$push49=, 0
	i32.sub 	$5=, $pop49, $5
	br      	1
.LBB17_11:
	end_block
	i32.sub 	$5=, $2, $5
.LBB17_12:
	end_block
	i32.const	$push131=, 56
	i32.add 	$push132=, $7, $pop131
	call    	_ZNSt3__16vectorIcNS_9allocatorIcEEE8__appendEj@FUNCTION, $pop132, $5
	i32.load	$2=, 60($7)
	i32.load	$5=, 56($7)
.LBB17_13:
	end_block
	i32.store	20($7), $5
	i32.store	16($7), $5
	i32.store	24($7), $2
	i32.const	$push133=, 16
	i32.add 	$push134=, $7, $pop133
	i32.const	$push135=, 160
	i32.add 	$push136=, $7, $pop135
	i32.call	$drop=, _ZN5eosiolsINS_10datastreamIPcEENS_16permission_levelEEERT_S6_RKNSt3__16vectorIT0_NS7_9allocatorIS9_EEEE@FUNCTION, $pop134, $pop136
	i32.load	$push57=, 196($7)
	i32.load	$push256=, 116($7)
	tee_local	$push255=, $5=, $pop256
	i32.add 	$push58=, $pop57, $pop255
	i32.load	$push55=, 200($7)
	i32.sub 	$push56=, $pop55, $5
	i32.const	$push254=, 0
	i32.const	$push253=, 0
	i32.load	$push252=, 56($7)
	tee_local	$push251=, $5=, $pop252
	i32.load	$push53=, 60($7)
	i32.sub 	$push54=, $pop53, $5
	i32.call	$push59=, check_transaction_authorization@FUNCTION, $pop58, $pop56, $pop254, $pop253, $pop251, $pop54
	i32.const	$push250=, 0
	i32.gt_s	$push60=, $pop59, $pop250
	i32.const	$push61=, .L.str.2
	call    	eosio_assert@FUNCTION, $pop60, $pop61
	i64.load	$6=, 184($7)
	i32.const	$push137=, 196
	i32.add 	$push138=, $7, $pop137
	i32.store	20($7), $pop138
	i32.const	$push139=, 176
	i32.add 	$push140=, $7, $pop139
	i32.store	16($7), $pop140
	i32.const	$push141=, 116
	i32.add 	$push142=, $7, $pop141
	i32.store	24($7), $pop142
	i32.const	$push143=, 200
	i32.add 	$push144=, $7, $pop143
	i32.store	28($7), $pop144
	i64.store	232($7), $6
	i64.load	$push62=, 72($7)
	i64.call	$push63=, current_receiver@FUNCTION
	i64.eq  	$push64=, $pop62, $pop63
	i32.const	$push65=, .L.str.16
	call    	eosio_assert@FUNCTION, $pop64, $pop65
	i32.const	$push145=, 16
	i32.add 	$push146=, $7, $pop145
	i32.store	212($7), $pop146
	i32.const	$push147=, 72
	i32.add 	$push148=, $7, $pop147
	i32.store	208($7), $pop148
	i32.const	$push149=, 232
	i32.add 	$push150=, $7, $pop149
	i32.store	216($7), $pop150
	i32.const	$push66=, 32
	i32.call	$push249=, _Znwj@FUNCTION, $pop66
	tee_local	$push248=, $5=, $pop249
	i64.const	$push67=, 0
	i64.store	0($pop248), $pop67
	i64.const	$push247=, 0
	i64.store	8($5):p2align=2, $pop247
	i32.const	$push246=, 0
	i32.store	16($5), $pop246
	i32.const	$push151=, 72
	i32.add 	$push152=, $7, $pop151
	i32.store	20($5), $pop152
	i32.const	$push153=, 208
	i32.add 	$push154=, $7, $pop153
	call    	_ZZN5eosio11multi_indexILy12531646810004914176ENS_8multisig8proposalEJEE7emplaceIZNS1_7proposeEvE3$_0EENS3_14const_iteratorEyOT_ENKUlRS7_E_clINS3_4itemEEEDaS9_@FUNCTION, $pop154, $5
	i32.store	8($7), $5
	i64.load	$push245=, 0($5)
	tee_local	$push244=, $6=, $pop245
	i64.store	208($7), $pop244
	i32.load	$push243=, 24($5)
	tee_local	$push242=, $1=, $pop243
	i32.store	224($7), $pop242
	block   	
	block   	
	i32.const	$push70=, 100
	i32.add 	$push241=, $7, $pop70
	tee_local	$push240=, $4=, $pop241
	i32.load	$push239=, 0($pop240)
	tee_local	$push238=, $2=, $pop239
	i32.const	$push155=, 72
	i32.add 	$push156=, $7, $pop155
	i32.const	$push237=, 32
	i32.add 	$push68=, $pop156, $pop237
	i32.load	$push69=, 0($pop68)
	i32.ge_u	$push71=, $pop238, $pop69
	br_if   	0, $pop71
	i64.store	8($2), $6
	i32.store	16($2), $1
	i32.const	$push257=, 0
	i32.store	8($7), $pop257
	i32.store	0($2), $5
	i32.const	$push74=, 24
	i32.add 	$push75=, $2, $pop74
	i32.store	0($4), $pop75
	br      	1
.LBB17_15:
	end_block
	i32.const	$push72=, 96
	i32.add 	$push73=, $7, $pop72
	i32.const	$push177=, 8
	i32.add 	$push178=, $7, $pop177
	i32.const	$push179=, 208
	i32.add 	$push180=, $7, $pop179
	i32.const	$push181=, 224
	i32.add 	$push182=, $7, $pop181
	call    	_ZNSt3__16vectorIN5eosio11multi_indexILy12531646810004914176ENS1_8multisig8proposalEJEE8item_ptrENS_9allocatorIS6_EEE24__emplace_back_slow_pathIJNS_10unique_ptrINS5_4itemENS_14default_deleteISC_EEEERyRlEEEvDpOT_@FUNCTION, $pop73, $pop178, $pop180, $pop182
.LBB17_16:
	end_block
	i32.load	$5=, 8($7)
	i32.const	$push258=, 0
	i32.store	8($7), $pop258
	block   	
	i32.eqz 	$push318=, $5
	br_if   	0, $pop318
	block   	
	i32.load	$push260=, 8($5)
	tee_local	$push259=, $2=, $pop260
	i32.eqz 	$push319=, $pop259
	br_if   	0, $pop319
	i32.const	$push76=, 12
	i32.add 	$push77=, $5, $pop76
	i32.store	0($pop77), $2
	call    	_ZdlPv@FUNCTION, $2
.LBB17_19:
	end_block
	call    	_ZdlPv@FUNCTION, $5
.LBB17_20:
	end_block
	i64.const	$push78=, -1
	i64.store	32($7), $pop78
	i32.const	$push280=, 0
	i32.store	40($7), $pop280
	i64.load	$6=, 184($7)
	i64.load	$push279=, 0($0)
	tee_local	$push278=, $3=, $pop279
	i64.store	16($7), $pop278
	i64.store	24($7), $6
	i32.const	$push79=, 44
	i32.add 	$push277=, $7, $pop79
	tee_local	$push276=, $2=, $pop277
	i32.const	$push275=, 0
	i32.store	0($pop276), $pop275
	i32.const	$push80=, 48
	i32.add 	$push274=, $7, $pop80
	tee_local	$push273=, $1=, $pop274
	i32.const	$push272=, 0
	i32.store	0($pop273), $pop272
	i32.const	$push157=, 160
	i32.add 	$push158=, $7, $pop157
	i32.store	12($7), $pop158
	i32.const	$push159=, 176
	i32.add 	$push160=, $7, $pop159
	i32.store	8($7), $pop160
	i64.store	232($7), $6
	i64.call	$push81=, current_receiver@FUNCTION
	i64.eq  	$push82=, $3, $pop81
	i32.const	$push83=, .L.str.16
	call    	eosio_assert@FUNCTION, $pop82, $pop83
	i32.const	$push161=, 8
	i32.add 	$push162=, $7, $pop161
	i32.store	212($7), $pop162
	i32.const	$push163=, 16
	i32.add 	$push164=, $7, $pop163
	i32.store	208($7), $pop164
	i32.const	$push165=, 232
	i32.add 	$push166=, $7, $pop165
	i32.store	216($7), $pop166
	i32.const	$push84=, 48
	i32.call	$push271=, _Znwj@FUNCTION, $pop84
	tee_local	$push270=, $5=, $pop271
	i64.const	$push85=, 0
	i64.store	0($pop270), $pop85
	i64.const	$push269=, 0
	i64.store	8($5):p2align=2, $pop269
	i64.const	$push268=, 0
	i64.store	16($5):p2align=2, $pop268
	i64.const	$push267=, 0
	i64.store	24($5):p2align=2, $pop267
	i32.const	$push167=, 16
	i32.add 	$push168=, $7, $pop167
	i32.store	32($5), $pop168
	i32.const	$push169=, 208
	i32.add 	$push170=, $7, $pop169
	call    	_ZZN5eosio11multi_indexILy3849304914312298496ENS_8multisig14approvals_infoEJEE7emplaceIZNS1_7proposeEvE3$_1EENS3_14const_iteratorEyOT_ENKUlRS7_E_clINS3_4itemEEEDaS9_@FUNCTION, $pop170, $5
	i32.store	224($7), $5
	i64.load	$push266=, 0($5)
	tee_local	$push265=, $6=, $pop266
	i64.store	208($7), $pop265
	i32.load	$push264=, 36($5)
	tee_local	$push263=, $4=, $pop264
	i32.store	204($7), $pop263
	block   	
	block   	
	i32.load	$push262=, 0($2)
	tee_local	$push261=, $0=, $pop262
	i32.load	$push86=, 0($1)
	i32.ge_u	$push87=, $pop261, $pop86
	br_if   	0, $pop87
	i64.store	8($0), $6
	i32.store	16($0), $4
	i32.const	$push90=, 0
	i32.store	224($7), $pop90
	i32.store	0($0), $5
	i32.const	$push91=, 24
	i32.add 	$push92=, $0, $pop91
	i32.store	0($2), $pop92
	br      	1
.LBB17_22:
	end_block
	i32.const	$push88=, 40
	i32.add 	$push89=, $7, $pop88
	i32.const	$push171=, 224
	i32.add 	$push172=, $7, $pop171
	i32.const	$push173=, 208
	i32.add 	$push174=, $7, $pop173
	i32.const	$push175=, 204
	i32.add 	$push176=, $7, $pop175
	call    	_ZNSt3__16vectorIN5eosio11multi_indexILy3849304914312298496ENS1_8multisig14approvals_infoEJEE8item_ptrENS_9allocatorIS6_EEE24__emplace_back_slow_pathIJNS_10unique_ptrINS5_4itemENS_14default_deleteISC_EEEERyRlEEEvDpOT_@FUNCTION, $pop89, $pop172, $pop174, $pop176
.LBB17_23:
	end_block
	i32.load	$5=, 224($7)
	i32.const	$push93=, 0
	i32.store	224($7), $pop93
	block   	
	i32.eqz 	$push320=, $5
	br_if   	0, $pop320
	block   	
	i32.load	$push282=, 20($5)
	tee_local	$push281=, $0=, $pop282
	i32.eqz 	$push321=, $pop281
	br_if   	0, $pop321
	i32.const	$push94=, 24
	i32.add 	$push95=, $5, $pop94
	i32.store	0($pop95), $0
	call    	_ZdlPv@FUNCTION, $0
.LBB17_26:
	end_block
	block   	
	i32.load	$push284=, 8($5)
	tee_local	$push283=, $0=, $pop284
	i32.eqz 	$push322=, $pop283
	br_if   	0, $pop322
	i32.const	$push96=, 12
	i32.add 	$push97=, $5, $pop96
	i32.store	0($pop97), $0
	call    	_ZdlPv@FUNCTION, $0
.LBB17_28:
	end_block
	call    	_ZdlPv@FUNCTION, $5
.LBB17_29:
	end_block
	block   	
	i32.load	$push286=, 40($7)
	tee_local	$push285=, $1=, $pop286
	i32.eqz 	$push323=, $pop285
	br_if   	0, $pop323
	block   	
	block   	
	i32.const	$push98=, 44
	i32.add 	$push290=, $7, $pop98
	tee_local	$push289=, $4=, $pop290
	i32.load	$push288=, 0($pop289)
	tee_local	$push287=, $0=, $pop288
	i32.eq  	$push99=, $pop287, $1
	br_if   	0, $pop99
.LBB17_32:
	loop    	
	i32.const	$push294=, -24
	i32.add 	$push293=, $0, $pop294
	tee_local	$push292=, $0=, $pop293
	i32.load	$5=, 0($pop292)
	i32.const	$push291=, 0
	i32.store	0($0), $pop291
	block   	
	i32.eqz 	$push324=, $5
	br_if   	0, $pop324
	block   	
	i32.load	$push296=, 20($5)
	tee_local	$push295=, $2=, $pop296
	i32.eqz 	$push325=, $pop295
	br_if   	0, $pop325
	i32.const	$push297=, 24
	i32.add 	$push100=, $5, $pop297
	i32.store	0($pop100), $2
	call    	_ZdlPv@FUNCTION, $2
.LBB17_35:
	end_block
	block   	
	i32.load	$push299=, 8($5)
	tee_local	$push298=, $2=, $pop299
	i32.eqz 	$push326=, $pop298
	br_if   	0, $pop326
	i32.const	$push300=, 12
	i32.add 	$push101=, $5, $pop300
	i32.store	0($pop101), $2
	call    	_ZdlPv@FUNCTION, $2
.LBB17_37:
	end_block
	call    	_ZdlPv@FUNCTION, $5
.LBB17_38:
	end_block
	i32.ne  	$push102=, $1, $0
	br_if   	0, $pop102
	end_loop
	i32.const	$push103=, 40
	i32.add 	$push104=, $7, $pop103
	i32.load	$5=, 0($pop104)
	br      	1
.LBB17_40:
	end_block
	copy_local	$5=, $1
.LBB17_41:
	end_block
	i32.store	0($4), $1
	call    	_ZdlPv@FUNCTION, $5
.LBB17_42:
	end_block
	block   	
	i32.load	$push302=, 56($7)
	tee_local	$push301=, $5=, $pop302
	i32.eqz 	$push327=, $pop301
	br_if   	0, $pop327
	i32.store	60($7), $5
	call    	_ZdlPv@FUNCTION, $5
.LBB17_44:
	end_block
	block   	
	i32.load	$push304=, 96($7)
	tee_local	$push303=, $1=, $pop304
	i32.eqz 	$push328=, $pop303
	br_if   	0, $pop328
	block   	
	block   	
	i32.const	$push105=, 100
	i32.add 	$push308=, $7, $pop105
	tee_local	$push307=, $4=, $pop308
	i32.load	$push306=, 0($pop307)
	tee_local	$push305=, $5=, $pop306
	i32.eq  	$push106=, $pop305, $1
	br_if   	0, $pop106
.LBB17_47:
	loop    	
	i32.const	$push312=, -24
	i32.add 	$push311=, $5, $pop312
	tee_local	$push310=, $5=, $pop311
	i32.load	$0=, 0($pop310)
	i32.const	$push309=, 0
	i32.store	0($5), $pop309
	block   	
	i32.eqz 	$push329=, $0
	br_if   	0, $pop329
	block   	
	i32.load	$push314=, 8($0)
	tee_local	$push313=, $2=, $pop314
	i32.eqz 	$push330=, $pop313
	br_if   	0, $pop330
	i32.const	$push315=, 12
	i32.add 	$push107=, $0, $pop315
	i32.store	0($pop107), $2
	call    	_ZdlPv@FUNCTION, $2
.LBB17_50:
	end_block
	call    	_ZdlPv@FUNCTION, $0
.LBB17_51:
	end_block
	i32.ne  	$push108=, $1, $5
	br_if   	0, $pop108
	end_loop
	i32.const	$push109=, 96
	i32.add 	$push110=, $7, $pop109
	i32.load	$5=, 0($pop110)
	br      	1
.LBB17_53:
	end_block
	copy_local	$5=, $1
.LBB17_54:
	end_block
	i32.store	0($4), $1
	call    	_ZdlPv@FUNCTION, $5
.LBB17_55:
	end_block
	block   	
	i32.load	$push317=, 160($7)
	tee_local	$push316=, $5=, $pop317
	i32.eqz 	$push331=, $pop316
	br_if   	0, $pop331
	i32.store	164($7), $5
	call    	_ZdlPv@FUNCTION, $5
.LBB17_57:
	end_block
	i32.const	$push118=, 0
	i32.const	$push116=, 240
	i32.add 	$push117=, $7, $pop116
	i32.store	__stack_pointer($pop118), $pop117
	.endfunc
.Lfunc_end17:
	.size	_ZN5eosio8multisig7proposeEv, .Lfunc_end17-_ZN5eosio8multisig7proposeEv

	.section	.text._ZN5eosiorsINS_10datastreamIPKcEENS_16permission_levelEEERT_S7_RNSt3__16vectorIT0_NS8_9allocatorISA_EEEE,"axG",@progbits,_ZN5eosiorsINS_10datastreamIPKcEENS_16permission_levelEEERT_S7_RNSt3__16vectorIT0_NS8_9allocatorISA_EEEE,comdat
	.hidden	_ZN5eosiorsINS_10datastreamIPKcEENS_16permission_levelEEERT_S7_RNSt3__16vectorIT0_NS8_9allocatorISA_EEEE
	.weak	_ZN5eosiorsINS_10datastreamIPKcEENS_16permission_levelEEERT_S7_RNSt3__16vectorIT0_NS8_9allocatorISA_EEEE
	.type	_ZN5eosiorsINS_10datastreamIPKcEENS_16permission_levelEEERT_S7_RNSt3__16vectorIT0_NS8_9allocatorISA_EEEE,@function
_ZN5eosiorsINS_10datastreamIPKcEENS_16permission_levelEEERT_S7_RNSt3__16vectorIT0_NS8_9allocatorISA_EEEE:
	.param  	i32, i32
	.result 	i32
	.local  	i32, i32, i32, i64, i32, i32
	i32.load	$7=, 4($0)
	i32.const	$6=, 0
	i64.const	$5=, 0
	i32.const	$push0=, 8
	i32.add 	$2=, $0, $pop0
	i32.const	$push3=, 4
	i32.add 	$3=, $0, $pop3
.LBB18_1:
	loop    	
	i32.load	$push1=, 0($2)
	i32.lt_u	$push2=, $7, $pop1
	i32.const	$push42=, .L.str.13
	call    	eosio_assert@FUNCTION, $pop2, $pop42
	i32.load	$push41=, 0($3)
	tee_local	$push40=, $7=, $pop41
	i32.load8_u	$4=, 0($pop40)
	i32.const	$push39=, 1
	i32.add 	$push38=, $7, $pop39
	tee_local	$push37=, $7=, $pop38
	i32.store	0($3), $pop37
	i32.const	$push36=, 127
	i32.and 	$push4=, $4, $pop36
	i32.const	$push35=, 255
	i32.and 	$push34=, $6, $pop35
	tee_local	$push33=, $6=, $pop34
	i32.shl 	$push5=, $pop4, $pop33
	i64.extend_u/i32	$push6=, $pop5
	i64.or  	$5=, $pop6, $5
	i32.const	$push32=, 7
	i32.add 	$6=, $6, $pop32
	i32.const	$push31=, 7
	i32.shr_u	$push7=, $4, $pop31
	br_if   	0, $pop7
	end_loop
	block   	
	block   	
	block   	
	i32.wrap/i64	$push51=, $5
	tee_local	$push50=, $4=, $pop51
	i32.load	$push49=, 4($1)
	tee_local	$push48=, $2=, $pop49
	i32.load	$push47=, 0($1)
	tee_local	$push46=, $7=, $pop47
	i32.sub 	$push8=, $pop48, $pop46
	i32.const	$push45=, 4
	i32.shr_s	$push44=, $pop8, $pop45
	tee_local	$push43=, $6=, $pop44
	i32.le_u	$push9=, $pop50, $pop43
	br_if   	0, $pop9
	i32.sub 	$push14=, $4, $6
	call    	_ZNSt3__16vectorIN5eosio16permission_levelENS_9allocatorIS2_EEE8__appendEj@FUNCTION, $1, $pop14
	i32.load	$push56=, 0($1)
	tee_local	$push55=, $7=, $pop56
	i32.const	$push54=, 4
	i32.add 	$push15=, $1, $pop54
	i32.load	$push53=, 0($pop15)
	tee_local	$push52=, $2=, $pop53
	i32.ne  	$push16=, $pop55, $pop52
	br_if   	1, $pop16
	br      	2
.LBB18_4:
	end_block
	block   	
	i32.ge_u	$push10=, $4, $6
	br_if   	0, $pop10
	i32.const	$push11=, 4
	i32.add 	$push12=, $1, $pop11
	i32.const	$push59=, 4
	i32.shl 	$push13=, $4, $pop59
	i32.add 	$push58=, $7, $pop13
	tee_local	$push57=, $2=, $pop58
	i32.store	0($pop12), $pop57
.LBB18_6:
	end_block
	i32.eq  	$push17=, $7, $2
	br_if   	1, $pop17
.LBB18_7:
	end_block
	i32.const	$push18=, 4
	i32.add 	$push61=, $0, $pop18
	tee_local	$push60=, $4=, $pop61
	i32.load	$6=, 0($pop60)
.LBB18_8:
	loop    	
	i32.const	$push80=, 8
	i32.add 	$push79=, $0, $pop80
	tee_local	$push78=, $3=, $pop79
	i32.load	$push19=, 0($pop78)
	i32.sub 	$push20=, $pop19, $6
	i32.const	$push77=, 7
	i32.gt_u	$push21=, $pop20, $pop77
	i32.const	$push76=, .L.str.12
	call    	eosio_assert@FUNCTION, $pop21, $pop76
	i32.load	$push22=, 0($4)
	i32.const	$push75=, 8
	i32.call	$drop=, memcpy@FUNCTION, $7, $pop22, $pop75
	i32.load	$push23=, 0($4)
	i32.const	$push74=, 8
	i32.add 	$push73=, $pop23, $pop74
	tee_local	$push72=, $6=, $pop73
	i32.store	0($4), $pop72
	i32.load	$push24=, 0($3)
	i32.sub 	$push25=, $pop24, $6
	i32.const	$push71=, 7
	i32.gt_u	$push26=, $pop25, $pop71
	i32.const	$push70=, .L.str.12
	call    	eosio_assert@FUNCTION, $pop26, $pop70
	i32.const	$push69=, 8
	i32.add 	$push27=, $7, $pop69
	i32.load	$push28=, 0($4)
	i32.const	$push68=, 8
	i32.call	$drop=, memcpy@FUNCTION, $pop27, $pop28, $pop68
	i32.load	$push29=, 0($4)
	i32.const	$push67=, 8
	i32.add 	$push66=, $pop29, $pop67
	tee_local	$push65=, $6=, $pop66
	i32.store	0($4), $pop65
	i32.const	$push64=, 16
	i32.add 	$push63=, $7, $pop64
	tee_local	$push62=, $7=, $pop63
	i32.ne  	$push30=, $pop62, $2
	br_if   	0, $pop30
.LBB18_9:
	end_loop
	end_block
	copy_local	$push81=, $0
	.endfunc
.Lfunc_end18:
	.size	_ZN5eosiorsINS_10datastreamIPKcEENS_16permission_levelEEERT_S7_RNSt3__16vectorIT0_NS8_9allocatorISA_EEEE, .Lfunc_end18-_ZN5eosiorsINS_10datastreamIPKcEENS_16permission_levelEEERT_S7_RNSt3__16vectorIT0_NS8_9allocatorISA_EEEE

	.section	.text._ZN5eosiorsINS_10datastreamIPKcEEEERT_S6_RNS_18transaction_headerE,"axG",@progbits,_ZN5eosiorsINS_10datastreamIPKcEEEERT_S6_RNS_18transaction_headerE,comdat
	.hidden	_ZN5eosiorsINS_10datastreamIPKcEEEERT_S6_RNS_18transaction_headerE
	.weak	_ZN5eosiorsINS_10datastreamIPKcEEEERT_S6_RNS_18transaction_headerE
	.type	_ZN5eosiorsINS_10datastreamIPKcEEEERT_S6_RNS_18transaction_headerE,@function
_ZN5eosiorsINS_10datastreamIPKcEEEERT_S6_RNS_18transaction_headerE:
	.param  	i32, i32
	.result 	i32
	.local  	i32, i32, i32, i64, i32, i32
	i32.load	$push1=, 8($0)
	i32.load	$push0=, 4($0)
	i32.sub 	$push2=, $pop1, $pop0
	i32.const	$push3=, 3
	i32.gt_u	$push4=, $pop2, $pop3
	i32.const	$push5=, .L.str.12
	call    	eosio_assert@FUNCTION, $pop4, $pop5
	i32.load	$push6=, 4($0)
	i32.const	$push59=, 4
	i32.call	$drop=, memcpy@FUNCTION, $1, $pop6, $pop59
	i32.load	$push7=, 4($0)
	i32.const	$push58=, 4
	i32.add 	$push57=, $pop7, $pop58
	tee_local	$push56=, $2=, $pop57
	i32.store	4($0), $pop56
	i32.load	$push8=, 8($0)
	i32.sub 	$push9=, $pop8, $2
	i32.const	$push55=, 1
	i32.gt_u	$push10=, $pop9, $pop55
	i32.const	$push54=, .L.str.12
	call    	eosio_assert@FUNCTION, $pop10, $pop54
	i32.const	$push53=, 4
	i32.add 	$push11=, $1, $pop53
	i32.load	$push12=, 4($0)
	i32.const	$push13=, 2
	i32.call	$drop=, memcpy@FUNCTION, $pop11, $pop12, $pop13
	i32.load	$push14=, 4($0)
	i32.const	$push52=, 2
	i32.add 	$push51=, $pop14, $pop52
	tee_local	$push50=, $2=, $pop51
	i32.store	4($0), $pop50
	i32.load	$push15=, 8($0)
	i32.sub 	$push16=, $pop15, $2
	i32.const	$push49=, 3
	i32.gt_u	$push17=, $pop16, $pop49
	i32.const	$push48=, .L.str.12
	call    	eosio_assert@FUNCTION, $pop17, $pop48
	i32.const	$push47=, 8
	i32.add 	$push18=, $1, $pop47
	i32.load	$push19=, 4($0)
	i32.const	$push46=, 4
	i32.call	$drop=, memcpy@FUNCTION, $pop18, $pop19, $pop46
	i32.load	$push20=, 4($0)
	i32.const	$push45=, 4
	i32.add 	$push44=, $pop20, $pop45
	tee_local	$push43=, $4=, $pop44
	i32.store	4($0), $pop43
	i32.const	$6=, 0
	i64.const	$5=, 0
.LBB19_1:
	loop    	
	i32.const	$push75=, 8
	i32.add 	$push21=, $0, $pop75
	i32.load	$push22=, 0($pop21)
	i32.lt_u	$push23=, $4, $pop22
	i32.const	$push74=, .L.str.13
	call    	eosio_assert@FUNCTION, $pop23, $pop74
	i32.const	$push73=, 4
	i32.add 	$push72=, $0, $pop73
	tee_local	$push71=, $7=, $pop72
	i32.load	$push70=, 0($pop71)
	tee_local	$push69=, $4=, $pop70
	i32.load8_u	$2=, 0($pop69)
	i32.const	$push68=, 1
	i32.add 	$push67=, $4, $pop68
	tee_local	$push66=, $4=, $pop67
	i32.store	0($7), $pop66
	i32.const	$push65=, 127
	i32.and 	$push24=, $2, $pop65
	i32.const	$push64=, 255
	i32.and 	$push63=, $6, $pop64
	tee_local	$push62=, $6=, $pop63
	i32.shl 	$push25=, $pop24, $pop62
	i64.extend_u/i32	$push26=, $pop25
	i64.or  	$5=, $pop26, $5
	i32.const	$push61=, 7
	i32.add 	$6=, $6, $pop61
	i32.const	$push60=, 7
	i32.shr_u	$push27=, $2, $pop60
	br_if   	0, $pop27
	end_loop
	i64.store32	12($1), $5
	i32.const	$push28=, 8
	i32.add 	$push83=, $0, $pop28
	tee_local	$push82=, $3=, $pop83
	i32.load	$push29=, 0($pop82)
	i32.ne  	$push30=, $pop29, $4
	i32.const	$push31=, .L.str.12
	call    	eosio_assert@FUNCTION, $pop30, $pop31
	i32.const	$push32=, 16
	i32.add 	$push33=, $1, $pop32
	i32.const	$push34=, 4
	i32.add 	$push81=, $0, $pop34
	tee_local	$push80=, $4=, $pop81
	i32.load	$push35=, 0($pop80)
	i32.const	$push79=, 1
	i32.call	$drop=, memcpy@FUNCTION, $pop33, $pop35, $pop79
	i32.load	$push36=, 0($4)
	i32.const	$push78=, 1
	i32.add 	$push77=, $pop36, $pop78
	tee_local	$push76=, $6=, $pop77
	i32.store	0($4), $pop76
	i32.const	$7=, 0
	i64.const	$5=, 0
.LBB19_3:
	loop    	
	i32.load	$push37=, 0($3)
	i32.lt_u	$push38=, $6, $pop37
	i32.const	$push95=, .L.str.13
	call    	eosio_assert@FUNCTION, $pop38, $pop95
	i32.load	$push94=, 0($4)
	tee_local	$push93=, $6=, $pop94
	i32.load8_u	$2=, 0($pop93)
	i32.const	$push92=, 1
	i32.add 	$push91=, $6, $pop92
	tee_local	$push90=, $6=, $pop91
	i32.store	0($4), $pop90
	i32.const	$push89=, 127
	i32.and 	$push39=, $2, $pop89
	i32.const	$push88=, 255
	i32.and 	$push87=, $7, $pop88
	tee_local	$push86=, $7=, $pop87
	i32.shl 	$push40=, $pop39, $pop86
	i64.extend_u/i32	$push41=, $pop40
	i64.or  	$5=, $pop41, $5
	i32.const	$push85=, 7
	i32.add 	$7=, $7, $pop85
	i32.const	$push84=, 7
	i32.shr_u	$push42=, $2, $pop84
	br_if   	0, $pop42
	end_loop
	i64.store32	20($1), $5
	copy_local	$push96=, $0
	.endfunc
.Lfunc_end19:
	.size	_ZN5eosiorsINS_10datastreamIPKcEEEERT_S6_RNS_18transaction_headerE, .Lfunc_end19-_ZN5eosiorsINS_10datastreamIPKcEEEERT_S6_RNS_18transaction_headerE

	.section	.text._ZNK5eosio11multi_indexILy12531646810004914176ENS_8multisig8proposalEJEE31load_object_by_primary_iteratorEl,"axG",@progbits,_ZNK5eosio11multi_indexILy12531646810004914176ENS_8multisig8proposalEJEE31load_object_by_primary_iteratorEl,comdat
	.hidden	_ZNK5eosio11multi_indexILy12531646810004914176ENS_8multisig8proposalEJEE31load_object_by_primary_iteratorEl
	.weak	_ZNK5eosio11multi_indexILy12531646810004914176ENS_8multisig8proposalEJEE31load_object_by_primary_iteratorEl
	.type	_ZNK5eosio11multi_indexILy12531646810004914176ENS_8multisig8proposalEJEE31load_object_by_primary_iteratorEl,@function
_ZNK5eosio11multi_indexILy12531646810004914176ENS_8multisig8proposalEJEE31load_object_by_primary_iteratorEl:
	.param  	i32, i32
	.result 	i32
	.local  	i32, i32, i32, i64, i32, i32, i32, i32
	i32.const	$push49=, 0
	i32.load	$push50=, __stack_pointer($pop49)
	i32.const	$push51=, 48
	i32.sub 	$push70=, $pop50, $pop51
	tee_local	$push69=, $9=, $pop70
	copy_local	$8=, $pop69
	i32.const	$push52=, 0
	i32.store	__stack_pointer($pop52), $9
	block   	
	i32.const	$push2=, 28
	i32.add 	$push3=, $0, $pop2
	i32.load	$push68=, 0($pop3)
	tee_local	$push67=, $7=, $pop68
	i32.load	$push66=, 24($0)
	tee_local	$push65=, $2=, $pop66
	i32.eq  	$push4=, $pop67, $pop65
	br_if   	0, $pop4
	i32.const	$push5=, 0
	i32.sub 	$3=, $pop5, $2
	i32.const	$push71=, -24
	i32.add 	$6=, $7, $pop71
.LBB20_2:
	loop    	
	i32.const	$push72=, 16
	i32.add 	$push6=, $6, $pop72
	i32.load	$push7=, 0($pop6)
	i32.eq  	$push8=, $pop7, $1
	br_if   	1, $pop8
	copy_local	$7=, $6
	i32.const	$push76=, -24
	i32.add 	$push75=, $6, $pop76
	tee_local	$push74=, $4=, $pop75
	copy_local	$6=, $pop74
	i32.add 	$push9=, $4, $3
	i32.const	$push73=, -24
	i32.ne  	$push10=, $pop9, $pop73
	br_if   	0, $pop10
.LBB20_4:
	end_loop
	end_block
	block   	
	block   	
	i32.eq  	$push11=, $7, $2
	br_if   	0, $pop11
	i32.const	$push12=, -24
	i32.add 	$push13=, $7, $pop12
	i32.load	$6=, 0($pop13)
	br      	1
.LBB20_6:
	end_block
	i32.const	$push14=, 0
	i32.const	$push79=, 0
	i32.call	$push78=, db_get_i64@FUNCTION, $1, $pop14, $pop79
	tee_local	$push77=, $6=, $pop78
	i32.const	$push15=, 31
	i32.shr_u	$push16=, $pop77, $pop15
	i32.const	$push17=, 1
	i32.xor 	$push18=, $pop16, $pop17
	i32.const	$push19=, .L.str.15
	call    	eosio_assert@FUNCTION, $pop18, $pop19
	block   	
	block   	
	i32.const	$push20=, 513
	i32.lt_u	$push21=, $6, $pop20
	br_if   	0, $pop21
	i32.call	$4=, malloc@FUNCTION, $6
	br      	1
.LBB20_8:
	end_block
	i32.const	$push48=, 0
	i32.const	$push22=, 15
	i32.add 	$push23=, $6, $pop22
	i32.const	$push24=, -16
	i32.and 	$push25=, $pop23, $pop24
	i32.sub 	$push81=, $9, $pop25
	tee_local	$push80=, $4=, $pop81
	copy_local	$push64=, $pop80
	i32.store	__stack_pointer($pop48), $pop64
.LBB20_9:
	end_block
	i32.call	$drop=, db_get_i64@FUNCTION, $1, $4, $6
	i32.store	36($8), $4
	i32.store	32($8), $4
	i32.add 	$push83=, $4, $6
	tee_local	$push82=, $7=, $pop83
	i32.store	40($8), $pop82
	block   	
	i32.const	$push26=, 512
	i32.le_u	$push27=, $6, $pop26
	br_if   	0, $pop27
	call    	free@FUNCTION, $4
	i32.const	$push28=, 40
	i32.add 	$push29=, $8, $pop28
	i32.load	$7=, 0($pop29)
	i32.load	$4=, 36($8)
.LBB20_11:
	end_block
	i32.const	$push30=, 32
	i32.call	$push98=, _Znwj@FUNCTION, $pop30
	tee_local	$push97=, $6=, $pop98
	i64.const	$push31=, 0
	i64.store	0($pop97), $pop31
	i64.const	$push96=, 0
	i64.store	8($6):p2align=2, $pop96
	i32.const	$push95=, 0
	i32.store	16($6), $pop95
	i32.store	20($6), $0
	i32.sub 	$push32=, $7, $4
	i32.const	$push33=, 7
	i32.gt_u	$push34=, $pop32, $pop33
	i32.const	$push35=, .L.str.12
	call    	eosio_assert@FUNCTION, $pop34, $pop35
	i32.const	$push36=, 8
	i32.call	$drop=, memcpy@FUNCTION, $6, $4, $pop36
	i32.const	$push94=, 8
	i32.add 	$push37=, $4, $pop94
	i32.store	36($8), $pop37
	i32.const	$push56=, 32
	i32.add 	$push57=, $8, $pop56
	i32.const	$push93=, 8
	i32.add 	$push38=, $6, $pop93
	i32.call	$drop=, _ZN5eosiorsINS_10datastreamIPKcEEEERT_S6_RNSt3__16vectorIcNS7_9allocatorIcEEEE@FUNCTION, $pop57, $pop38
	i32.store	24($6), $1
	i32.store	24($8), $6
	i64.load	$push92=, 0($6)
	tee_local	$push91=, $5=, $pop92
	i64.store	16($8), $pop91
	i32.load	$push90=, 24($6)
	tee_local	$push89=, $7=, $pop90
	i32.store	12($8), $pop89
	block   	
	block   	
	i32.const	$push41=, 28
	i32.add 	$push88=, $0, $pop41
	tee_local	$push87=, $1=, $pop88
	i32.load	$push86=, 0($pop87)
	tee_local	$push85=, $4=, $pop86
	i32.const	$push84=, 32
	i32.add 	$push39=, $0, $pop84
	i32.load	$push40=, 0($pop39)
	i32.ge_u	$push42=, $pop85, $pop40
	br_if   	0, $pop42
	i64.store	8($4), $5
	i32.store	16($4), $7
	i32.const	$push99=, 0
	i32.store	24($8), $pop99
	i32.store	0($4), $6
	i32.const	$push43=, 24
	i32.add 	$push44=, $4, $pop43
	i32.store	0($1), $pop44
	br      	1
.LBB20_13:
	end_block
	i32.const	$push1=, 24
	i32.add 	$push0=, $0, $pop1
	i32.const	$push58=, 24
	i32.add 	$push59=, $8, $pop58
	i32.const	$push60=, 16
	i32.add 	$push61=, $8, $pop60
	i32.const	$push62=, 12
	i32.add 	$push63=, $8, $pop62
	call    	_ZNSt3__16vectorIN5eosio11multi_indexILy12531646810004914176ENS1_8multisig8proposalEJEE8item_ptrENS_9allocatorIS6_EEE24__emplace_back_slow_pathIJNS_10unique_ptrINS5_4itemENS_14default_deleteISC_EEEERyRlEEEvDpOT_@FUNCTION, $pop0, $pop59, $pop61, $pop63
.LBB20_14:
	end_block
	i32.load	$4=, 24($8)
	i32.const	$push45=, 0
	i32.store	24($8), $pop45
	i32.eqz 	$push102=, $4
	br_if   	0, $pop102
	block   	
	i32.load	$push101=, 8($4)
	tee_local	$push100=, $7=, $pop101
	i32.eqz 	$push103=, $pop100
	br_if   	0, $pop103
	i32.const	$push46=, 12
	i32.add 	$push47=, $4, $pop46
	i32.store	0($pop47), $7
	call    	_ZdlPv@FUNCTION, $7
.LBB20_17:
	end_block
	call    	_ZdlPv@FUNCTION, $4
.LBB20_18:
	end_block
	i32.const	$push55=, 0
	i32.const	$push53=, 48
	i32.add 	$push54=, $8, $pop53
	i32.store	__stack_pointer($pop55), $pop54
	copy_local	$push104=, $6
	.endfunc
.Lfunc_end20:
	.size	_ZNK5eosio11multi_indexILy12531646810004914176ENS_8multisig8proposalEJEE31load_object_by_primary_iteratorEl, .Lfunc_end20-_ZNK5eosio11multi_indexILy12531646810004914176ENS_8multisig8proposalEJEE31load_object_by_primary_iteratorEl

	.text
	.type	_ZZN5eosio11multi_indexILy12531646810004914176ENS_8multisig8proposalEJEE7emplaceIZNS1_7proposeEvE3$_0EENS3_14const_iteratorEyOT_ENKUlRS7_E_clINS3_4itemEEEDaS9_,@function
_ZZN5eosio11multi_indexILy12531646810004914176ENS_8multisig8proposalEJEE7emplaceIZNS1_7proposeEvE3$_0EENS3_14const_iteratorEyOT_ENKUlRS7_E_clINS3_4itemEEEDaS9_:
	.param  	i32, i32
	.local  	i32, i32, i32, i32, i32, i32, i32, i64, i32
	i32.const	$push73=, 0
	i32.const	$push70=, 0
	i32.load	$push71=, __stack_pointer($pop70)
	i32.const	$push72=, 16
	i32.sub 	$push92=, $pop71, $pop72
	tee_local	$push91=, $5=, $pop92
	i32.store	__stack_pointer($pop73), $pop91
	i32.load	$2=, 0($0)
	i32.load	$push90=, 4($0)
	tee_local	$push89=, $6=, $pop90
	i32.load	$push1=, 0($pop89)
	i64.load	$push2=, 0($pop1)
	i64.store	0($1), $pop2
	i32.load	$push3=, 4($6)
	i32.load	$7=, 0($pop3)
	i32.const	$8=, 0
	copy_local	$push88=, $5
	tee_local	$push87=, $10=, $pop88
	i32.const	$push86=, 0
	i32.store	0($pop87), $pop86
	i32.const	$push85=, 0
	i32.store	4($10), $pop85
	i32.load	$3=, 8($6)
	i32.const	$push84=, 0
	i32.store	8($10), $pop84
	i32.const	$4=, 0
	block   	
	block   	
	i32.load	$push4=, 12($6)
	i32.load	$push5=, 0($pop4)
	i32.load	$push83=, 0($3)
	tee_local	$push82=, $3=, $pop83
	i32.sub 	$push81=, $pop5, $pop82
	tee_local	$push80=, $6=, $pop81
	i32.eqz 	$push131=, $pop80
	br_if   	0, $pop131
	i32.const	$push6=, -1
	i32.le_s	$push7=, $6, $pop6
	br_if   	1, $pop7
	i32.const	$push8=, 8
	i32.add 	$push9=, $10, $pop8
	i32.call	$push96=, _Znwj@FUNCTION, $6
	tee_local	$push95=, $4=, $pop96
	i32.add 	$push94=, $pop95, $6
	tee_local	$push93=, $8=, $pop94
	i32.store	0($pop9), $pop93
	i32.store	0($10), $4
	i32.add 	$push0=, $7, $3
	i32.call	$drop=, memcpy@FUNCTION, $4, $pop0, $6
	i32.store	4($10), $8
.LBB21_3:
	end_block
	block   	
	block   	
	i32.load	$push98=, 8($1)
	tee_local	$push97=, $6=, $pop98
	i32.eqz 	$push132=, $pop97
	br_if   	0, $pop132
	i32.const	$push10=, 12
	i32.add 	$push11=, $1, $pop10
	i32.store	0($pop11), $6
	call    	_ZdlPv@FUNCTION, $6
	i32.const	$push12=, 16
	i32.add 	$push100=, $1, $pop12
	tee_local	$push99=, $6=, $pop100
	i32.const	$push13=, 0
	i32.store	0($pop99), $pop13
	i32.const	$push14=, 8
	i32.add 	$push15=, $1, $pop14
	i64.const	$push16=, 0
	i64.store	0($pop15):p2align=2, $pop16
	br      	1
.LBB21_5:
	end_block
	i32.const	$push17=, 16
	i32.add 	$6=, $1, $pop17
.LBB21_6:
	end_block
	i32.store	0($6), $8
	i32.const	$push18=, 12
	i32.add 	$push19=, $1, $pop18
	i32.store	0($pop19), $8
	i32.const	$push20=, 8
	i32.add 	$push21=, $1, $pop20
	i32.store	0($pop21), $4
	i32.const	$push101=, 8
	i32.add 	$push22=, $8, $pop101
	i32.sub 	$6=, $pop22, $4
	i32.sub 	$push23=, $8, $4
	i64.extend_u/i32	$9=, $pop23
.LBB21_7:
	loop    	
	i32.const	$push106=, 1
	i32.add 	$6=, $6, $pop106
	i64.const	$push105=, 7
	i64.shr_u	$push104=, $9, $pop105
	tee_local	$push103=, $9=, $pop104
	i64.const	$push102=, 0
	i64.ne  	$push24=, $pop103, $pop102
	br_if   	0, $pop24
	end_loop
	block   	
	block   	
	i32.const	$push25=, 513
	i32.lt_u	$push26=, $6, $pop25
	br_if   	0, $pop26
	i32.call	$7=, malloc@FUNCTION, $6
	br      	1
.LBB21_10:
	end_block
	i32.const	$push69=, 0
	i32.const	$push27=, 15
	i32.add 	$push28=, $6, $pop27
	i32.const	$push29=, -16
	i32.and 	$push30=, $pop28, $pop29
	i32.sub 	$push108=, $5, $pop30
	tee_local	$push107=, $7=, $pop108
	copy_local	$push79=, $pop107
	i32.store	__stack_pointer($pop69), $pop79
.LBB21_11:
	end_block
	i32.const	$push112=, 7
	i32.gt_s	$push31=, $6, $pop112
	i32.const	$push111=, .L.str.11
	call    	eosio_assert@FUNCTION, $pop31, $pop111
	i32.const	$push32=, 8
	i32.call	$drop=, memcpy@FUNCTION, $7, $1, $pop32
	i32.const	$push35=, 12
	i32.add 	$push36=, $1, $pop35
	i32.load	$push37=, 0($pop36)
	i32.const	$push110=, 8
	i32.add 	$push33=, $1, $pop110
	i32.load	$push34=, 0($pop33)
	i32.sub 	$push38=, $pop37, $pop34
	i64.extend_u/i32	$9=, $pop38
	i32.const	$push109=, 8
	i32.add 	$8=, $7, $pop109
	i32.add 	$3=, $7, $6
.LBB21_12:
	loop    	
	i32.wrap/i64	$4=, $9
	i64.const	$push124=, 7
	i64.shr_u	$push123=, $9, $pop124
	tee_local	$push122=, $9=, $pop123
	i64.const	$push121=, 0
	i64.ne  	$push120=, $pop122, $pop121
	tee_local	$push119=, $5=, $pop120
	i32.const	$push118=, 7
	i32.shl 	$push40=, $pop119, $pop118
	i32.const	$push117=, 127
	i32.and 	$push39=, $4, $pop117
	i32.or  	$push41=, $pop40, $pop39
	i32.store8	15($10), $pop41
	i32.sub 	$push42=, $3, $8
	i32.const	$push116=, 0
	i32.gt_s	$push43=, $pop42, $pop116
	i32.const	$push115=, .L.str.11
	call    	eosio_assert@FUNCTION, $pop43, $pop115
	i32.const	$push77=, 15
	i32.add 	$push78=, $10, $pop77
	i32.const	$push114=, 1
	i32.call	$drop=, memcpy@FUNCTION, $8, $pop78, $pop114
	i32.const	$push113=, 1
	i32.add 	$8=, $8, $pop113
	br_if   	0, $5
	end_loop
	i32.sub 	$push49=, $3, $8
	i32.const	$push46=, 12
	i32.add 	$push47=, $1, $pop46
	i32.load	$push48=, 0($pop47)
	i32.const	$push44=, 8
	i32.add 	$push45=, $1, $pop44
	i32.load	$push130=, 0($pop45)
	tee_local	$push129=, $4=, $pop130
	i32.sub 	$push128=, $pop48, $pop129
	tee_local	$push127=, $5=, $pop128
	i32.ge_s	$push50=, $pop49, $pop127
	i32.const	$push51=, .L.str.11
	call    	eosio_assert@FUNCTION, $pop50, $pop51
	i32.call	$drop=, memcpy@FUNCTION, $8, $4, $5
	i64.load	$push52=, 8($2)
	i64.const	$push55=, -5915097263704637440
	i32.load	$push53=, 8($0)
	i64.load	$push54=, 0($pop53)
	i64.load	$push126=, 0($1)
	tee_local	$push125=, $9=, $pop126
	i32.call	$push56=, db_store_i64@FUNCTION, $pop52, $pop55, $pop54, $pop125, $7, $6
	i32.store	24($1), $pop56
	block   	
	i32.const	$push57=, 513
	i32.lt_u	$push58=, $6, $pop57
	br_if   	0, $pop58
	call    	free@FUNCTION, $7
.LBB21_15:
	end_block
	block   	
	i64.load	$push59=, 16($2)
	i64.lt_u	$push60=, $9, $pop59
	br_if   	0, $pop60
	i32.const	$push67=, 16
	i32.add 	$push68=, $2, $pop67
	i64.const	$push65=, -2
	i64.const	$push63=, 1
	i64.add 	$push64=, $9, $pop63
	i64.const	$push61=, -3
	i64.gt_u	$push62=, $9, $pop61
	i64.select	$push66=, $pop65, $pop64, $pop62
	i64.store	0($pop68), $pop66
.LBB21_17:
	end_block
	i32.const	$push76=, 0
	i32.const	$push74=, 16
	i32.add 	$push75=, $10, $pop74
	i32.store	__stack_pointer($pop76), $pop75
	return
.LBB21_18:
	end_block
	call    	_ZNKSt3__120__vector_base_commonILb1EE20__throw_length_errorEv@FUNCTION, $10
	unreachable
	.endfunc
.Lfunc_end21:
	.size	_ZZN5eosio11multi_indexILy12531646810004914176ENS_8multisig8proposalEJEE7emplaceIZNS1_7proposeEvE3$_0EENS3_14const_iteratorEyOT_ENKUlRS7_E_clINS3_4itemEEEDaS9_, .Lfunc_end21-_ZZN5eosio11multi_indexILy12531646810004914176ENS_8multisig8proposalEJEE7emplaceIZNS1_7proposeEvE3$_0EENS3_14const_iteratorEyOT_ENKUlRS7_E_clINS3_4itemEEEDaS9_

	.section	.text._ZNSt3__16vectorIN5eosio11multi_indexILy12531646810004914176ENS1_8multisig8proposalEJEE8item_ptrENS_9allocatorIS6_EEE24__emplace_back_slow_pathIJNS_10unique_ptrINS5_4itemENS_14default_deleteISC_EEEERyRlEEEvDpOT_,"axG",@progbits,_ZNSt3__16vectorIN5eosio11multi_indexILy12531646810004914176ENS1_8multisig8proposalEJEE8item_ptrENS_9allocatorIS6_EEE24__emplace_back_slow_pathIJNS_10unique_ptrINS5_4itemENS_14default_deleteISC_EEEERyRlEEEvDpOT_,comdat
	.hidden	_ZNSt3__16vectorIN5eosio11multi_indexILy12531646810004914176ENS1_8multisig8proposalEJEE8item_ptrENS_9allocatorIS6_EEE24__emplace_back_slow_pathIJNS_10unique_ptrINS5_4itemENS_14default_deleteISC_EEEERyRlEEEvDpOT_
	.weak	_ZNSt3__16vectorIN5eosio11multi_indexILy12531646810004914176ENS1_8multisig8proposalEJEE8item_ptrENS_9allocatorIS6_EEE24__emplace_back_slow_pathIJNS_10unique_ptrINS5_4itemENS_14default_deleteISC_EEEERyRlEEEvDpOT_
	.type	_ZNSt3__16vectorIN5eosio11multi_indexILy12531646810004914176ENS1_8multisig8proposalEJEE8item_ptrENS_9allocatorIS6_EEE24__emplace_back_slow_pathIJNS_10unique_ptrINS5_4itemENS_14default_deleteISC_EEEERyRlEEEvDpOT_,@function
_ZNSt3__16vectorIN5eosio11multi_indexILy12531646810004914176ENS1_8multisig8proposalEJEE8item_ptrENS_9allocatorIS6_EEE24__emplace_back_slow_pathIJNS_10unique_ptrINS5_4itemENS_14default_deleteISC_EEEERyRlEEEvDpOT_:
	.param  	i32, i32, i32, i32
	.local  	i32, i32, i32, i32
	block   	
	block   	
	i32.load	$push0=, 4($0)
	i32.load	$push47=, 0($0)
	tee_local	$push46=, $6=, $pop47
	i32.sub 	$push1=, $pop0, $pop46
	i32.const	$push45=, 24
	i32.div_s	$push44=, $pop1, $pop45
	tee_local	$push43=, $4=, $pop44
	i32.const	$push2=, 1
	i32.add 	$push42=, $pop43, $pop2
	tee_local	$push41=, $5=, $pop42
	i32.const	$push3=, 178956971
	i32.ge_u	$push4=, $pop41, $pop3
	br_if   	0, $pop4
	i32.const	$7=, 178956970
	block   	
	block   	
	i32.load	$push5=, 8($0)
	i32.sub 	$push6=, $pop5, $6
	i32.const	$push50=, 24
	i32.div_s	$push49=, $pop6, $pop50
	tee_local	$push48=, $6=, $pop49
	i32.const	$push7=, 89478484
	i32.gt_u	$push8=, $pop48, $pop7
	br_if   	0, $pop8
	i32.const	$push9=, 1
	i32.shl 	$push54=, $6, $pop9
	tee_local	$push53=, $7=, $pop54
	i32.lt_u	$push10=, $7, $5
	i32.select	$push52=, $5, $pop53, $pop10
	tee_local	$push51=, $7=, $pop52
	i32.eqz 	$push83=, $pop51
	br_if   	1, $pop83
.LBB22_3:
	end_block
	i32.const	$push11=, 24
	i32.mul 	$push12=, $7, $pop11
	i32.call	$6=, _Znwj@FUNCTION, $pop12
	br      	2
.LBB22_4:
	end_block
	i32.const	$7=, 0
	i32.const	$6=, 0
	br      	1
.LBB22_5:
	end_block
	call    	_ZNKSt3__120__vector_base_commonILb1EE20__throw_length_errorEv@FUNCTION, $0
	unreachable
.LBB22_6:
	end_block
	i32.load	$5=, 0($1)
	i32.const	$push63=, 0
	i32.store	0($1), $pop63
	i32.const	$push13=, 24
	i32.mul 	$push14=, $4, $pop13
	i32.add 	$push62=, $6, $pop14
	tee_local	$push61=, $1=, $pop62
	i32.store	0($pop61), $5
	i64.load	$push15=, 0($2)
	i64.store	8($1), $pop15
	i32.load	$push16=, 0($3)
	i32.store	16($1), $pop16
	i32.const	$push60=, 24
	i32.mul 	$push17=, $7, $pop60
	i32.add 	$4=, $6, $pop17
	i32.const	$push59=, 24
	i32.add 	$5=, $1, $pop59
	block   	
	block   	
	i32.const	$push18=, 4
	i32.add 	$push19=, $0, $pop18
	i32.load	$push58=, 0($pop19)
	tee_local	$push57=, $6=, $pop58
	i32.load	$push56=, 0($0)
	tee_local	$push55=, $7=, $pop56
	i32.eq  	$push20=, $pop57, $pop55
	br_if   	0, $pop20
.LBB22_8:
	loop    	
	i32.const	$push75=, -24
	i32.add 	$push74=, $6, $pop75
	tee_local	$push73=, $2=, $pop74
	i32.load	$3=, 0($pop73)
	i32.const	$push72=, 0
	i32.store	0($2), $pop72
	i32.const	$push71=, -24
	i32.add 	$push21=, $1, $pop71
	i32.store	0($pop21), $3
	i32.const	$push70=, -8
	i32.add 	$push22=, $1, $pop70
	i32.const	$push69=, -8
	i32.add 	$push23=, $6, $pop69
	i32.load	$push24=, 0($pop23)
	i32.store	0($pop22), $pop24
	i32.const	$push68=, -12
	i32.add 	$push25=, $1, $pop68
	i32.const	$push67=, -12
	i32.add 	$push26=, $6, $pop67
	i32.load	$push27=, 0($pop26)
	i32.store	0($pop25), $pop27
	i32.const	$push66=, -16
	i32.add 	$push28=, $1, $pop66
	i32.const	$push65=, -16
	i32.add 	$push29=, $6, $pop65
	i32.load	$push30=, 0($pop29)
	i32.store	0($pop28), $pop30
	i32.const	$push64=, -24
	i32.add 	$1=, $1, $pop64
	copy_local	$6=, $2
	i32.ne  	$push31=, $7, $2
	br_if   	0, $pop31
	end_loop
	i32.const	$push32=, 4
	i32.add 	$push33=, $0, $pop32
	i32.load	$7=, 0($pop33)
	i32.load	$2=, 0($0)
	br      	1
.LBB22_10:
	end_block
	copy_local	$2=, $7
.LBB22_11:
	end_block
	i32.store	0($0), $1
	i32.const	$push34=, 4
	i32.add 	$push35=, $0, $pop34
	i32.store	0($pop35), $5
	i32.const	$push36=, 8
	i32.add 	$push37=, $0, $pop36
	i32.store	0($pop37), $4
	block   	
	i32.eq  	$push38=, $7, $2
	br_if   	0, $pop38
.LBB22_13:
	loop    	
	i32.const	$push79=, -24
	i32.add 	$push78=, $7, $pop79
	tee_local	$push77=, $7=, $pop78
	i32.load	$1=, 0($pop77)
	i32.const	$push76=, 0
	i32.store	0($7), $pop76
	block   	
	i32.eqz 	$push84=, $1
	br_if   	0, $pop84
	block   	
	i32.load	$push81=, 8($1)
	tee_local	$push80=, $6=, $pop81
	i32.eqz 	$push85=, $pop80
	br_if   	0, $pop85
	i32.const	$push82=, 12
	i32.add 	$push39=, $1, $pop82
	i32.store	0($pop39), $6
	call    	_ZdlPv@FUNCTION, $6
.LBB22_16:
	end_block
	call    	_ZdlPv@FUNCTION, $1
.LBB22_17:
	end_block
	i32.ne  	$push40=, $2, $7
	br_if   	0, $pop40
.LBB22_18:
	end_loop
	end_block
	block   	
	i32.eqz 	$push86=, $2
	br_if   	0, $pop86
	call    	_ZdlPv@FUNCTION, $2
.LBB22_20:
	end_block
	.endfunc
.Lfunc_end22:
	.size	_ZNSt3__16vectorIN5eosio11multi_indexILy12531646810004914176ENS1_8multisig8proposalEJEE8item_ptrENS_9allocatorIS6_EEE24__emplace_back_slow_pathIJNS_10unique_ptrINS5_4itemENS_14default_deleteISC_EEEERyRlEEEvDpOT_, .Lfunc_end22-_ZNSt3__16vectorIN5eosio11multi_indexILy12531646810004914176ENS1_8multisig8proposalEJEE8item_ptrENS_9allocatorIS6_EEE24__emplace_back_slow_pathIJNS_10unique_ptrINS5_4itemENS_14default_deleteISC_EEEERyRlEEEvDpOT_

	.text
	.type	_ZZN5eosio11multi_indexILy3849304914312298496ENS_8multisig14approvals_infoEJEE7emplaceIZNS1_7proposeEvE3$_1EENS3_14const_iteratorEyOT_ENKUlRS7_E_clINS3_4itemEEEDaS9_,@function
_ZZN5eosio11multi_indexILy3849304914312298496ENS_8multisig14approvals_infoEJEE7emplaceIZNS1_7proposeEvE3$_1EENS3_14const_iteratorEyOT_ENKUlRS7_E_clINS3_4itemEEEDaS9_:
	.param  	i32, i32
	.local  	i32, i32, i32, i32, i32, i64, i32, i32, i32, i32
	i32.const	$push58=, 0
	i32.load	$push59=, __stack_pointer($pop58)
	i32.const	$push60=, 16
	i32.sub 	$push71=, $pop59, $pop60
	tee_local	$push70=, $11=, $pop71
	copy_local	$10=, $pop70
	i32.const	$push61=, 0
	i32.store	__stack_pointer($pop61), $11
	i32.load	$2=, 0($0)
	i32.load	$push69=, 4($0)
	tee_local	$push68=, $8=, $pop69
	i32.load	$push0=, 0($pop68)
	i64.load	$push1=, 0($pop0)
	i64.store	0($1), $pop1
	i32.const	$push2=, 8
	i32.add 	$3=, $1, $pop2
	i32.load	$8=, 4($8)
	block   	
	block   	
	i32.load	$push67=, 8($1)
	tee_local	$push66=, $5=, $pop67
	i32.eqz 	$push104=, $pop66
	br_if   	0, $pop104
	i32.const	$push3=, 12
	i32.add 	$push75=, $1, $pop3
	tee_local	$push74=, $9=, $pop75
	i32.store	0($pop74), $5
	call    	_ZdlPv@FUNCTION, $5
	i32.const	$push4=, 16
	i32.add 	$push73=, $1, $pop4
	tee_local	$push72=, $5=, $pop73
	i32.const	$push5=, 0
	i32.store	0($pop72), $pop5
	i64.const	$push6=, 0
	i64.store	0($3):p2align=2, $pop6
	br      	1
.LBB23_2:
	end_block
	i32.const	$push7=, 16
	i32.add 	$5=, $1, $pop7
	i32.const	$push8=, 12
	i32.add 	$9=, $1, $pop8
.LBB23_3:
	end_block
	i32.load	$push9=, 0($8)
	i32.store	0($3), $pop9
	i32.load	$push10=, 4($8)
	i32.store	0($9), $pop10
	i32.load	$push11=, 8($8)
	i32.store	0($5), $pop11
	i64.const	$push82=, 0
	i64.store	0($8):p2align=2, $pop82
	i32.const	$push12=, 0
	i32.store	8($8), $pop12
	i32.load	$push81=, 0($9)
	tee_local	$push80=, $9=, $pop81
	i32.load	$push79=, 0($3)
	tee_local	$push78=, $4=, $pop79
	i32.sub 	$push77=, $pop80, $pop78
	tee_local	$push76=, $6=, $pop77
	i32.const	$push13=, 4
	i32.shr_s	$push14=, $pop76, $pop13
	i64.extend_u/i32	$7=, $pop14
	i32.const	$8=, 8
.LBB23_4:
	loop    	
	i32.const	$push87=, 1
	i32.add 	$8=, $8, $pop87
	i64.const	$push86=, 7
	i64.shr_u	$push85=, $7, $pop86
	tee_local	$push84=, $7=, $pop85
	i64.const	$push83=, 0
	i64.ne  	$push15=, $pop84, $pop83
	br_if   	0, $pop15
	end_loop
	i32.const	$push16=, 20
	i32.add 	$5=, $1, $pop16
	block   	
	i32.eq  	$push17=, $4, $9
	br_if   	0, $pop17
	i32.const	$push18=, -16
	i32.and 	$push19=, $6, $pop18
	i32.add 	$8=, $pop19, $8
.LBB23_7:
	end_block
	i32.const	$push20=, 24
	i32.add 	$push21=, $1, $pop20
	i32.load	$push93=, 0($pop21)
	tee_local	$push92=, $9=, $pop93
	i32.load	$push91=, 0($5)
	tee_local	$push90=, $4=, $pop91
	i32.sub 	$push89=, $pop92, $pop90
	tee_local	$push88=, $6=, $pop89
	i32.const	$push22=, 4
	i32.shr_s	$push23=, $pop88, $pop22
	i64.extend_u/i32	$7=, $pop23
.LBB23_8:
	loop    	
	i32.const	$push98=, 1
	i32.add 	$8=, $8, $pop98
	i64.const	$push97=, 7
	i64.shr_u	$push96=, $7, $pop97
	tee_local	$push95=, $7=, $pop96
	i64.const	$push94=, 0
	i64.ne  	$push24=, $pop95, $pop94
	br_if   	0, $pop24
	end_loop
	block   	
	i32.eq  	$push25=, $4, $9
	br_if   	0, $pop25
	i32.const	$push26=, -16
	i32.and 	$push27=, $6, $pop26
	i32.add 	$8=, $pop27, $8
.LBB23_11:
	end_block
	block   	
	block   	
	i32.const	$push28=, 513
	i32.lt_u	$push29=, $8, $pop28
	br_if   	0, $pop29
	i32.call	$9=, malloc@FUNCTION, $8
	br      	1
.LBB23_13:
	end_block
	i32.const	$push57=, 0
	i32.const	$push30=, 15
	i32.add 	$push31=, $8, $pop30
	i32.const	$push32=, -16
	i32.and 	$push33=, $pop31, $pop32
	i32.sub 	$push100=, $11, $pop33
	tee_local	$push99=, $9=, $pop100
	copy_local	$push65=, $pop99
	i32.store	__stack_pointer($pop57), $pop65
.LBB23_14:
	end_block
	i32.store	0($10), $9
	i32.add 	$push34=, $9, $8
	i32.store	8($10), $pop34
	i32.const	$push35=, 7
	i32.gt_s	$push36=, $8, $pop35
	i32.const	$push37=, .L.str.11
	call    	eosio_assert@FUNCTION, $pop36, $pop37
	i32.const	$push38=, 8
	i32.call	$drop=, memcpy@FUNCTION, $9, $1, $pop38
	i32.const	$push103=, 8
	i32.add 	$push39=, $9, $pop103
	i32.store	4($10), $pop39
	i32.call	$drop=, _ZN5eosiolsINS_10datastreamIPcEENS_16permission_levelEEERT_S6_RKNSt3__16vectorIT0_NS7_9allocatorIS9_EEEE@FUNCTION, $10, $3
	i32.call	$drop=, _ZN5eosiolsINS_10datastreamIPcEENS_16permission_levelEEERT_S6_RKNSt3__16vectorIT0_NS7_9allocatorIS9_EEEE@FUNCTION, $10, $5
	i64.load	$push40=, 8($2)
	i64.const	$push43=, 3849304914312298496
	i32.load	$push41=, 8($0)
	i64.load	$push42=, 0($pop41)
	i64.load	$push102=, 0($1)
	tee_local	$push101=, $7=, $pop102
	i32.call	$push44=, db_store_i64@FUNCTION, $pop40, $pop43, $pop42, $pop101, $9, $8
	i32.store	36($1), $pop44
	block   	
	i32.const	$push45=, 513
	i32.lt_u	$push46=, $8, $pop45
	br_if   	0, $pop46
	call    	free@FUNCTION, $9
.LBB23_16:
	end_block
	block   	
	i64.load	$push47=, 16($2)
	i64.lt_u	$push48=, $7, $pop47
	br_if   	0, $pop48
	i32.const	$push55=, 16
	i32.add 	$push56=, $2, $pop55
	i64.const	$push53=, -2
	i64.const	$push51=, 1
	i64.add 	$push52=, $7, $pop51
	i64.const	$push49=, -3
	i64.gt_u	$push50=, $7, $pop49
	i64.select	$push54=, $pop53, $pop52, $pop50
	i64.store	0($pop56), $pop54
.LBB23_18:
	end_block
	i32.const	$push64=, 0
	i32.const	$push62=, 16
	i32.add 	$push63=, $10, $pop62
	i32.store	__stack_pointer($pop64), $pop63
	.endfunc
.Lfunc_end23:
	.size	_ZZN5eosio11multi_indexILy3849304914312298496ENS_8multisig14approvals_infoEJEE7emplaceIZNS1_7proposeEvE3$_1EENS3_14const_iteratorEyOT_ENKUlRS7_E_clINS3_4itemEEEDaS9_, .Lfunc_end23-_ZZN5eosio11multi_indexILy3849304914312298496ENS_8multisig14approvals_infoEJEE7emplaceIZNS1_7proposeEvE3$_1EENS3_14const_iteratorEyOT_ENKUlRS7_E_clINS3_4itemEEEDaS9_

	.section	.text._ZNSt3__16vectorIN5eosio11multi_indexILy3849304914312298496ENS1_8multisig14approvals_infoEJEE8item_ptrENS_9allocatorIS6_EEE24__emplace_back_slow_pathIJNS_10unique_ptrINS5_4itemENS_14default_deleteISC_EEEERyRlEEEvDpOT_,"axG",@progbits,_ZNSt3__16vectorIN5eosio11multi_indexILy3849304914312298496ENS1_8multisig14approvals_infoEJEE8item_ptrENS_9allocatorIS6_EEE24__emplace_back_slow_pathIJNS_10unique_ptrINS5_4itemENS_14default_deleteISC_EEEERyRlEEEvDpOT_,comdat
	.hidden	_ZNSt3__16vectorIN5eosio11multi_indexILy3849304914312298496ENS1_8multisig14approvals_infoEJEE8item_ptrENS_9allocatorIS6_EEE24__emplace_back_slow_pathIJNS_10unique_ptrINS5_4itemENS_14default_deleteISC_EEEERyRlEEEvDpOT_
	.weak	_ZNSt3__16vectorIN5eosio11multi_indexILy3849304914312298496ENS1_8multisig14approvals_infoEJEE8item_ptrENS_9allocatorIS6_EEE24__emplace_back_slow_pathIJNS_10unique_ptrINS5_4itemENS_14default_deleteISC_EEEERyRlEEEvDpOT_
	.type	_ZNSt3__16vectorIN5eosio11multi_indexILy3849304914312298496ENS1_8multisig14approvals_infoEJEE8item_ptrENS_9allocatorIS6_EEE24__emplace_back_slow_pathIJNS_10unique_ptrINS5_4itemENS_14default_deleteISC_EEEERyRlEEEvDpOT_,@function
_ZNSt3__16vectorIN5eosio11multi_indexILy3849304914312298496ENS1_8multisig14approvals_infoEJEE8item_ptrENS_9allocatorIS6_EEE24__emplace_back_slow_pathIJNS_10unique_ptrINS5_4itemENS_14default_deleteISC_EEEERyRlEEEvDpOT_:
	.param  	i32, i32, i32, i32
	.local  	i32, i32, i32, i32
	block   	
	block   	
	i32.load	$push0=, 4($0)
	i32.load	$push48=, 0($0)
	tee_local	$push47=, $6=, $pop48
	i32.sub 	$push1=, $pop0, $pop47
	i32.const	$push46=, 24
	i32.div_s	$push45=, $pop1, $pop46
	tee_local	$push44=, $4=, $pop45
	i32.const	$push2=, 1
	i32.add 	$push43=, $pop44, $pop2
	tee_local	$push42=, $5=, $pop43
	i32.const	$push3=, 178956971
	i32.ge_u	$push4=, $pop42, $pop3
	br_if   	0, $pop4
	i32.const	$7=, 178956970
	block   	
	block   	
	i32.load	$push5=, 8($0)
	i32.sub 	$push6=, $pop5, $6
	i32.const	$push51=, 24
	i32.div_s	$push50=, $pop6, $pop51
	tee_local	$push49=, $6=, $pop50
	i32.const	$push7=, 89478484
	i32.gt_u	$push8=, $pop49, $pop7
	br_if   	0, $pop8
	i32.const	$push9=, 1
	i32.shl 	$push55=, $6, $pop9
	tee_local	$push54=, $7=, $pop55
	i32.lt_u	$push10=, $7, $5
	i32.select	$push53=, $5, $pop54, $pop10
	tee_local	$push52=, $7=, $pop53
	i32.eqz 	$push87=, $pop52
	br_if   	1, $pop87
.LBB24_3:
	end_block
	i32.const	$push11=, 24
	i32.mul 	$push12=, $7, $pop11
	i32.call	$6=, _Znwj@FUNCTION, $pop12
	br      	2
.LBB24_4:
	end_block
	i32.const	$7=, 0
	i32.const	$6=, 0
	br      	1
.LBB24_5:
	end_block
	call    	_ZNKSt3__120__vector_base_commonILb1EE20__throw_length_errorEv@FUNCTION, $0
	unreachable
.LBB24_6:
	end_block
	i32.load	$5=, 0($1)
	i32.const	$push64=, 0
	i32.store	0($1), $pop64
	i32.const	$push13=, 24
	i32.mul 	$push14=, $4, $pop13
	i32.add 	$push63=, $6, $pop14
	tee_local	$push62=, $1=, $pop63
	i32.store	0($pop62), $5
	i64.load	$push15=, 0($2)
	i64.store	8($1), $pop15
	i32.load	$push16=, 0($3)
	i32.store	16($1), $pop16
	i32.const	$push61=, 24
	i32.mul 	$push17=, $7, $pop61
	i32.add 	$4=, $6, $pop17
	i32.const	$push60=, 24
	i32.add 	$5=, $1, $pop60
	block   	
	block   	
	i32.const	$push18=, 4
	i32.add 	$push19=, $0, $pop18
	i32.load	$push59=, 0($pop19)
	tee_local	$push58=, $6=, $pop59
	i32.load	$push57=, 0($0)
	tee_local	$push56=, $7=, $pop57
	i32.eq  	$push20=, $pop58, $pop56
	br_if   	0, $pop20
.LBB24_8:
	loop    	
	i32.const	$push76=, -24
	i32.add 	$push75=, $6, $pop76
	tee_local	$push74=, $2=, $pop75
	i32.load	$3=, 0($pop74)
	i32.const	$push73=, 0
	i32.store	0($2), $pop73
	i32.const	$push72=, -24
	i32.add 	$push21=, $1, $pop72
	i32.store	0($pop21), $3
	i32.const	$push71=, -8
	i32.add 	$push22=, $1, $pop71
	i32.const	$push70=, -8
	i32.add 	$push23=, $6, $pop70
	i32.load	$push24=, 0($pop23)
	i32.store	0($pop22), $pop24
	i32.const	$push69=, -12
	i32.add 	$push25=, $1, $pop69
	i32.const	$push68=, -12
	i32.add 	$push26=, $6, $pop68
	i32.load	$push27=, 0($pop26)
	i32.store	0($pop25), $pop27
	i32.const	$push67=, -16
	i32.add 	$push28=, $1, $pop67
	i32.const	$push66=, -16
	i32.add 	$push29=, $6, $pop66
	i32.load	$push30=, 0($pop29)
	i32.store	0($pop28), $pop30
	i32.const	$push65=, -24
	i32.add 	$1=, $1, $pop65
	copy_local	$6=, $2
	i32.ne  	$push31=, $7, $2
	br_if   	0, $pop31
	end_loop
	i32.const	$push32=, 4
	i32.add 	$push33=, $0, $pop32
	i32.load	$7=, 0($pop33)
	i32.load	$2=, 0($0)
	br      	1
.LBB24_10:
	end_block
	copy_local	$2=, $7
.LBB24_11:
	end_block
	i32.store	0($0), $1
	i32.const	$push34=, 4
	i32.add 	$push35=, $0, $pop34
	i32.store	0($pop35), $5
	i32.const	$push36=, 8
	i32.add 	$push37=, $0, $pop36
	i32.store	0($pop37), $4
	block   	
	i32.eq  	$push38=, $7, $2
	br_if   	0, $pop38
.LBB24_13:
	loop    	
	i32.const	$push80=, -24
	i32.add 	$push79=, $7, $pop80
	tee_local	$push78=, $7=, $pop79
	i32.load	$1=, 0($pop78)
	i32.const	$push77=, 0
	i32.store	0($7), $pop77
	block   	
	i32.eqz 	$push88=, $1
	br_if   	0, $pop88
	block   	
	i32.load	$push82=, 20($1)
	tee_local	$push81=, $6=, $pop82
	i32.eqz 	$push89=, $pop81
	br_if   	0, $pop89
	i32.const	$push83=, 24
	i32.add 	$push39=, $1, $pop83
	i32.store	0($pop39), $6
	call    	_ZdlPv@FUNCTION, $6
.LBB24_16:
	end_block
	block   	
	i32.load	$push85=, 8($1)
	tee_local	$push84=, $6=, $pop85
	i32.eqz 	$push90=, $pop84
	br_if   	0, $pop90
	i32.const	$push86=, 12
	i32.add 	$push40=, $1, $pop86
	i32.store	0($pop40), $6
	call    	_ZdlPv@FUNCTION, $6
.LBB24_18:
	end_block
	call    	_ZdlPv@FUNCTION, $1
.LBB24_19:
	end_block
	i32.ne  	$push41=, $2, $7
	br_if   	0, $pop41
.LBB24_20:
	end_loop
	end_block
	block   	
	i32.eqz 	$push91=, $2
	br_if   	0, $pop91
	call    	_ZdlPv@FUNCTION, $2
.LBB24_22:
	end_block
	.endfunc
.Lfunc_end24:
	.size	_ZNSt3__16vectorIN5eosio11multi_indexILy3849304914312298496ENS1_8multisig14approvals_infoEJEE8item_ptrENS_9allocatorIS6_EEE24__emplace_back_slow_pathIJNS_10unique_ptrINS5_4itemENS_14default_deleteISC_EEEERyRlEEEvDpOT_, .Lfunc_end24-_ZNSt3__16vectorIN5eosio11multi_indexILy3849304914312298496ENS1_8multisig14approvals_infoEJEE8item_ptrENS_9allocatorIS6_EEE24__emplace_back_slow_pathIJNS_10unique_ptrINS5_4itemENS_14default_deleteISC_EEEERyRlEEEvDpOT_

	.section	.text._ZN5eosiorsINS_10datastreamIPKcEEEERT_S6_RNSt3__16vectorIcNS7_9allocatorIcEEEE,"axG",@progbits,_ZN5eosiorsINS_10datastreamIPKcEEEERT_S6_RNSt3__16vectorIcNS7_9allocatorIcEEEE,comdat
	.hidden	_ZN5eosiorsINS_10datastreamIPKcEEEERT_S6_RNSt3__16vectorIcNS7_9allocatorIcEEEE
	.weak	_ZN5eosiorsINS_10datastreamIPKcEEEERT_S6_RNSt3__16vectorIcNS7_9allocatorIcEEEE
	.type	_ZN5eosiorsINS_10datastreamIPKcEEEERT_S6_RNSt3__16vectorIcNS7_9allocatorIcEEEE,@function
_ZN5eosiorsINS_10datastreamIPKcEEEERT_S6_RNSt3__16vectorIcNS7_9allocatorIcEEEE:
	.param  	i32, i32
	.result 	i32
	.local  	i32, i32, i32, i32, i64, i32
	i32.load	$5=, 4($0)
	i32.const	$7=, 0
	i64.const	$6=, 0
	i32.const	$push0=, 8
	i32.add 	$2=, $0, $pop0
	i32.const	$push3=, 4
	i32.add 	$3=, $0, $pop3
.LBB25_1:
	loop    	
	i32.load	$push1=, 0($2)
	i32.lt_u	$push2=, $5, $pop1
	i32.const	$push37=, .L.str.13
	call    	eosio_assert@FUNCTION, $pop2, $pop37
	i32.load	$push36=, 0($3)
	tee_local	$push35=, $5=, $pop36
	i32.load8_u	$4=, 0($pop35)
	i32.const	$push34=, 1
	i32.add 	$push33=, $5, $pop34
	tee_local	$push32=, $5=, $pop33
	i32.store	0($3), $pop32
	i32.const	$push31=, 127
	i32.and 	$push4=, $4, $pop31
	i32.const	$push30=, 255
	i32.and 	$push29=, $7, $pop30
	tee_local	$push28=, $7=, $pop29
	i32.shl 	$push5=, $pop4, $pop28
	i64.extend_u/i32	$push6=, $pop5
	i64.or  	$6=, $pop6, $6
	i32.const	$push27=, 7
	i32.add 	$7=, $7, $pop27
	i32.const	$push26=, 7
	i32.shr_u	$push7=, $4, $pop26
	br_if   	0, $pop7
	end_loop
	block   	
	block   	
	i32.wrap/i64	$push45=, $6
	tee_local	$push44=, $3=, $pop45
	i32.load	$push43=, 4($1)
	tee_local	$push42=, $7=, $pop43
	i32.load	$push41=, 0($1)
	tee_local	$push40=, $4=, $pop41
	i32.sub 	$push39=, $pop42, $pop40
	tee_local	$push38=, $2=, $pop39
	i32.le_u	$push8=, $pop44, $pop38
	br_if   	0, $pop8
	i32.sub 	$push12=, $3, $2
	call    	_ZNSt3__16vectorIcNS_9allocatorIcEEE8__appendEj@FUNCTION, $1, $pop12
	i32.const	$push13=, 4
	i32.add 	$push14=, $0, $pop13
	i32.load	$5=, 0($pop14)
	i32.const	$push46=, 4
	i32.add 	$push15=, $1, $pop46
	i32.load	$7=, 0($pop15)
	i32.load	$4=, 0($1)
	br      	1
.LBB25_4:
	end_block
	i32.ge_u	$push9=, $3, $2
	br_if   	0, $pop9
	i32.const	$push10=, 4
	i32.add 	$push11=, $1, $pop10
	i32.add 	$push48=, $4, $3
	tee_local	$push47=, $7=, $pop48
	i32.store	0($pop11), $pop47
.LBB25_6:
	end_block
	i32.const	$push16=, 8
	i32.add 	$push17=, $0, $pop16
	i32.load	$push18=, 0($pop17)
	i32.sub 	$push19=, $pop18, $5
	i32.sub 	$push52=, $7, $4
	tee_local	$push51=, $5=, $pop52
	i32.ge_u	$push20=, $pop19, $pop51
	i32.const	$push21=, .L.str.12
	call    	eosio_assert@FUNCTION, $pop20, $pop21
	i32.const	$push22=, 4
	i32.add 	$push50=, $0, $pop22
	tee_local	$push49=, $7=, $pop50
	i32.load	$push23=, 0($pop49)
	i32.call	$drop=, memcpy@FUNCTION, $4, $pop23, $5
	i32.load	$push24=, 0($7)
	i32.add 	$push25=, $pop24, $5
	i32.store	0($7), $pop25
	copy_local	$push53=, $0
	.endfunc
.Lfunc_end25:
	.size	_ZN5eosiorsINS_10datastreamIPKcEEEERT_S6_RNSt3__16vectorIcNS7_9allocatorIcEEEE, .Lfunc_end25-_ZN5eosiorsINS_10datastreamIPKcEEEERT_S6_RNSt3__16vectorIcNS7_9allocatorIcEEEE

	.section	.text._ZNSt3__16vectorIN5eosio16permission_levelENS_9allocatorIS2_EEE8__appendEj,"axG",@progbits,_ZNSt3__16vectorIN5eosio16permission_levelENS_9allocatorIS2_EEE8__appendEj,comdat
	.hidden	_ZNSt3__16vectorIN5eosio16permission_levelENS_9allocatorIS2_EEE8__appendEj
	.weak	_ZNSt3__16vectorIN5eosio16permission_levelENS_9allocatorIS2_EEE8__appendEj
	.type	_ZNSt3__16vectorIN5eosio16permission_levelENS_9allocatorIS2_EEE8__appendEj,@function
_ZNSt3__16vectorIN5eosio16permission_levelENS_9allocatorIS2_EEE8__appendEj:
	.param  	i32, i32
	.local  	i32, i32, i32, i32, i32, i32
	block   	
	block   	
	block   	
	block   	
	block   	
	i32.load	$push30=, 8($0)
	tee_local	$push29=, $2=, $pop30
	i32.load	$push28=, 4($0)
	tee_local	$push27=, $7=, $pop28
	i32.sub 	$push0=, $pop29, $pop27
	i32.const	$push26=, 4
	i32.shr_s	$push1=, $pop0, $pop26
	i32.ge_u	$push2=, $pop1, $1
	br_if   	0, $pop2
	i32.load	$push37=, 0($0)
	tee_local	$push36=, $6=, $pop37
	i32.sub 	$push6=, $7, $pop36
	i32.const	$push35=, 4
	i32.shr_s	$push34=, $pop6, $pop35
	tee_local	$push33=, $3=, $pop34
	i32.add 	$push32=, $pop33, $1
	tee_local	$push31=, $4=, $pop32
	i32.const	$push7=, 268435456
	i32.ge_u	$push8=, $pop31, $pop7
	br_if   	2, $pop8
	i32.const	$5=, 268435455
	block   	
	i32.sub 	$push40=, $2, $6
	tee_local	$push39=, $2=, $pop40
	i32.const	$push38=, 4
	i32.shr_s	$push9=, $pop39, $pop38
	i32.const	$push10=, 134217726
	i32.gt_u	$push11=, $pop9, $pop10
	br_if   	0, $pop11
	i32.const	$push12=, 3
	i32.shr_s	$push44=, $2, $pop12
	tee_local	$push43=, $5=, $pop44
	i32.lt_u	$push13=, $5, $4
	i32.select	$push42=, $4, $pop43, $pop13
	tee_local	$push41=, $5=, $pop42
	i32.eqz 	$push57=, $pop41
	br_if   	2, $pop57
	i32.const	$push14=, 268435456
	i32.ge_u	$push15=, $5, $pop14
	br_if   	4, $pop15
.LBB26_5:
	end_block
	i32.const	$push46=, 4
	i32.shl 	$push16=, $5, $pop46
	i32.call	$2=, _Znwj@FUNCTION, $pop16
	i32.const	$push45=, 4
	i32.add 	$push17=, $0, $pop45
	i32.load	$7=, 0($pop17)
	i32.load	$6=, 0($0)
	br      	4
.LBB26_6:
	end_block
	i32.const	$push56=, 4
	i32.add 	$push3=, $0, $pop56
	i32.const	$push55=, 4
	i32.shl 	$push4=, $1, $pop55
	i32.add 	$push5=, $7, $pop4
	i32.store	0($pop3), $pop5
	return
.LBB26_7:
	end_block
	i32.const	$5=, 0
	i32.const	$2=, 0
	br      	2
.LBB26_8:
	end_block
	call    	_ZNKSt3__120__vector_base_commonILb1EE20__throw_length_errorEv@FUNCTION, $0
	unreachable
.LBB26_9:
	end_block
	call    	abort@FUNCTION
	unreachable
.LBB26_10:
	end_block
	i32.const	$push53=, 4
	i32.shl 	$push18=, $3, $pop53
	i32.add 	$push52=, $2, $pop18
	tee_local	$push51=, $3=, $pop52
	i32.sub 	$push50=, $7, $6
	tee_local	$push49=, $7=, $pop50
	i32.sub 	$4=, $pop51, $pop49
	i32.const	$push48=, 4
	i32.shl 	$push19=, $1, $pop48
	i32.add 	$1=, $3, $pop19
	i32.const	$push47=, 4
	i32.shl 	$push20=, $5, $pop47
	i32.add 	$5=, $2, $pop20
	block   	
	i32.const	$push21=, 1
	i32.lt_s	$push22=, $7, $pop21
	br_if   	0, $pop22
	i32.call	$drop=, memcpy@FUNCTION, $4, $6, $7
	i32.load	$6=, 0($0)
.LBB26_12:
	end_block
	i32.store	0($0), $4
	i32.const	$push54=, 4
	i32.add 	$push23=, $0, $pop54
	i32.store	0($pop23), $1
	i32.const	$push24=, 8
	i32.add 	$push25=, $0, $pop24
	i32.store	0($pop25), $5
	block   	
	i32.eqz 	$push58=, $6
	br_if   	0, $pop58
	call    	_ZdlPv@FUNCTION, $6
.LBB26_14:
	end_block
	.endfunc
.Lfunc_end26:
	.size	_ZNSt3__16vectorIN5eosio16permission_levelENS_9allocatorIS2_EEE8__appendEj, .Lfunc_end26-_ZNSt3__16vectorIN5eosio16permission_levelENS_9allocatorIS2_EEE8__appendEj

	.text
	.hidden	_ZN5eosio8multisig7approveEyNS_4nameENS_16permission_levelE
	.globl	_ZN5eosio8multisig7approveEyNS_4nameENS_16permission_levelE
	.type	_ZN5eosio8multisig7approveEyNS_4nameENS_16permission_levelE,@function
_ZN5eosio8multisig7approveEyNS_4nameENS_16permission_levelE:
	.param  	i32, i64, i64, i32
	.local  	i64, i64, i32, i32, i32, i32
	i32.const	$push28=, 0
	i32.const	$push25=, 0
	i32.load	$push26=, __stack_pointer($pop25)
	i32.const	$push27=, 64
	i32.sub 	$push51=, $pop26, $pop27
	tee_local	$push50=, $9=, $pop51
	i32.store	__stack_pointer($pop28), $pop50
	i64.load	$push49=, 0($3)
	tee_local	$push48=, $4=, $pop49
	i64.load	$push47=, 8($3)
	tee_local	$push46=, $5=, $pop47
	call    	require_auth2@FUNCTION, $pop48, $pop46
	i32.const	$push0=, 56
	i32.add 	$push1=, $9, $pop0
	i32.const	$push2=, 0
	i32.store	0($pop1), $pop2
	i64.store	32($9), $1
	i64.const	$push3=, -1
	i64.store	40($9), $pop3
	i64.const	$push4=, 0
	i64.store	48($9), $pop4
	i64.load	$push5=, 0($0)
	i64.store	24($9), $pop5
	block   	
	i32.const	$push32=, 24
	i32.add 	$push33=, $9, $pop32
	i32.const	$push6=, .L.str.3
	i32.call	$push45=, _ZNK5eosio11multi_indexILy3849304914312298496ENS_8multisig14approvals_infoEJEE3getEyPKc@FUNCTION, $pop33, $2, $pop6
	tee_local	$push44=, $6=, $pop45
	i32.load	$push43=, 8($pop44)
	tee_local	$push42=, $0=, $pop43
	i32.const	$push7=, 12
	i32.add 	$push8=, $6, $pop7
	i32.load	$push41=, 0($pop8)
	tee_local	$push40=, $8=, $pop41
	i32.eq  	$push9=, $pop42, $pop40
	br_if   	0, $pop9
.LBB27_2:
	loop    	
	block   	
	i64.load	$push10=, 0($0)
	i64.ne  	$push11=, $pop10, $4
	br_if   	0, $pop11
	i32.const	$push52=, 8
	i32.add 	$push12=, $0, $pop52
	i64.load	$push13=, 0($pop12)
	i64.eq  	$push14=, $pop13, $5
	br_if   	2, $pop14
.LBB27_4:
	end_block
	i32.const	$push55=, 16
	i32.add 	$push54=, $0, $pop55
	tee_local	$push53=, $0=, $pop54
	i32.ne  	$push15=, $8, $pop53
	br_if   	0, $pop15
	end_loop
	copy_local	$0=, $8
.LBB27_6:
	end_block
	i32.store	16($9), $0
	i32.ne  	$push16=, $0, $8
	i32.const	$push17=, .L.str.4
	call    	eosio_assert@FUNCTION, $pop16, $pop17
	i32.store	8($9), $3
	i32.const	$push34=, 16
	i32.add 	$push35=, $9, $pop34
	i32.store	12($9), $pop35
	i32.const	$push36=, 24
	i32.add 	$push37=, $9, $pop36
	i32.const	$push38=, 8
	i32.add 	$push39=, $9, $pop38
	call    	_ZN5eosio11multi_indexILy3849304914312298496ENS_8multisig14approvals_infoEJEE6modifyIZNS1_7approveEyNS_4nameENS_16permission_levelEE3$_2EEvRKS2_yOT_@FUNCTION, $pop37, $6, $1, $pop39
	block   	
	i32.load	$push57=, 48($9)
	tee_local	$push56=, $6=, $pop57
	i32.eqz 	$push72=, $pop56
	br_if   	0, $pop72
	block   	
	block   	
	i32.const	$push18=, 52
	i32.add 	$push61=, $9, $pop18
	tee_local	$push60=, $7=, $pop61
	i32.load	$push59=, 0($pop60)
	tee_local	$push58=, $8=, $pop59
	i32.eq  	$push19=, $pop58, $6
	br_if   	0, $pop19
.LBB27_9:
	loop    	
	i32.const	$push65=, -24
	i32.add 	$push64=, $8, $pop65
	tee_local	$push63=, $8=, $pop64
	i32.load	$0=, 0($pop63)
	i32.const	$push62=, 0
	i32.store	0($8), $pop62
	block   	
	i32.eqz 	$push73=, $0
	br_if   	0, $pop73
	block   	
	i32.load	$push67=, 20($0)
	tee_local	$push66=, $3=, $pop67
	i32.eqz 	$push74=, $pop66
	br_if   	0, $pop74
	i32.const	$push68=, 24
	i32.add 	$push20=, $0, $pop68
	i32.store	0($pop20), $3
	call    	_ZdlPv@FUNCTION, $3
.LBB27_12:
	end_block
	block   	
	i32.load	$push70=, 8($0)
	tee_local	$push69=, $3=, $pop70
	i32.eqz 	$push75=, $pop69
	br_if   	0, $pop75
	i32.const	$push71=, 12
	i32.add 	$push21=, $0, $pop71
	i32.store	0($pop21), $3
	call    	_ZdlPv@FUNCTION, $3
.LBB27_14:
	end_block
	call    	_ZdlPv@FUNCTION, $0
.LBB27_15:
	end_block
	i32.ne  	$push22=, $6, $8
	br_if   	0, $pop22
	end_loop
	i32.const	$push23=, 48
	i32.add 	$push24=, $9, $pop23
	i32.load	$0=, 0($pop24)
	br      	1
.LBB27_17:
	end_block
	copy_local	$0=, $6
.LBB27_18:
	end_block
	i32.store	0($7), $6
	call    	_ZdlPv@FUNCTION, $0
.LBB27_19:
	end_block
	i32.const	$push31=, 0
	i32.const	$push29=, 64
	i32.add 	$push30=, $9, $pop29
	i32.store	__stack_pointer($pop31), $pop30
	.endfunc
.Lfunc_end27:
	.size	_ZN5eosio8multisig7approveEyNS_4nameENS_16permission_levelE, .Lfunc_end27-_ZN5eosio8multisig7approveEyNS_4nameENS_16permission_levelE

	.section	.text._ZNK5eosio11multi_indexILy3849304914312298496ENS_8multisig14approvals_infoEJEE3getEyPKc,"axG",@progbits,_ZNK5eosio11multi_indexILy3849304914312298496ENS_8multisig14approvals_infoEJEE3getEyPKc,comdat
	.hidden	_ZNK5eosio11multi_indexILy3849304914312298496ENS_8multisig14approvals_infoEJEE3getEyPKc
	.weak	_ZNK5eosio11multi_indexILy3849304914312298496ENS_8multisig14approvals_infoEJEE3getEyPKc
	.type	_ZNK5eosio11multi_indexILy3849304914312298496ENS_8multisig14approvals_infoEJEE3getEyPKc,@function
_ZNK5eosio11multi_indexILy3849304914312298496ENS_8multisig14approvals_infoEJEE3getEyPKc:
	.param  	i32, i64, i32
	.result 	i32
	.local  	i32, i32, i32, i32, i32
	block   	
	i32.const	$push0=, 28
	i32.add 	$push1=, $0, $pop0
	i32.load	$push27=, 0($pop1)
	tee_local	$push26=, $7=, $pop27
	i32.load	$push25=, 24($0)
	tee_local	$push24=, $3=, $pop25
	i32.eq  	$push2=, $pop26, $pop24
	br_if   	0, $pop2
	i32.const	$push28=, -24
	i32.add 	$6=, $7, $pop28
	i32.const	$push3=, 0
	i32.sub 	$4=, $pop3, $3
.LBB28_2:
	loop    	
	i32.load	$push4=, 0($6)
	i64.load	$push5=, 0($pop4)
	i64.eq  	$push6=, $pop5, $1
	br_if   	1, $pop6
	copy_local	$7=, $6
	i32.const	$push32=, -24
	i32.add 	$push31=, $6, $pop32
	tee_local	$push30=, $5=, $pop31
	copy_local	$6=, $pop30
	i32.add 	$push7=, $5, $4
	i32.const	$push29=, -24
	i32.ne  	$push8=, $pop7, $pop29
	br_if   	0, $pop8
.LBB28_4:
	end_loop
	end_block
	block   	
	block   	
	i32.eq  	$push9=, $7, $3
	br_if   	0, $pop9
	i32.const	$push10=, -24
	i32.add 	$push11=, $7, $pop10
	i32.load	$push34=, 0($pop11)
	tee_local	$push33=, $6=, $pop34
	i32.load	$push12=, 32($pop33)
	i32.eq  	$push13=, $pop12, $0
	i32.const	$push14=, .L.str.14
	call    	eosio_assert@FUNCTION, $pop13, $pop14
	br      	1
.LBB28_6:
	end_block
	i32.const	$6=, 0
	i64.load	$push16=, 0($0)
	i64.load	$push15=, 8($0)
	i64.const	$push17=, 3849304914312298496
	i32.call	$push37=, db_find_i64@FUNCTION, $pop16, $pop15, $pop17, $1
	tee_local	$push36=, $5=, $pop37
	i32.const	$push35=, 0
	i32.lt_s	$push18=, $pop36, $pop35
	br_if   	0, $pop18
	i32.call	$push39=, _ZNK5eosio11multi_indexILy3849304914312298496ENS_8multisig14approvals_infoEJEE31load_object_by_primary_iteratorEl@FUNCTION, $0, $5
	tee_local	$push38=, $6=, $pop39
	i32.load	$push19=, 32($pop38)
	i32.eq  	$push20=, $pop19, $0
	i32.const	$push21=, .L.str.14
	call    	eosio_assert@FUNCTION, $pop20, $pop21
.LBB28_8:
	end_block
	i32.const	$push22=, 0
	i32.ne  	$push23=, $6, $pop22
	call    	eosio_assert@FUNCTION, $pop23, $2
	copy_local	$push40=, $6
	.endfunc
.Lfunc_end28:
	.size	_ZNK5eosio11multi_indexILy3849304914312298496ENS_8multisig14approvals_infoEJEE3getEyPKc, .Lfunc_end28-_ZNK5eosio11multi_indexILy3849304914312298496ENS_8multisig14approvals_infoEJEE3getEyPKc

	.text
	.type	_ZN5eosio11multi_indexILy3849304914312298496ENS_8multisig14approvals_infoEJEE6modifyIZNS1_7approveEyNS_4nameENS_16permission_levelEE3$_2EEvRKS2_yOT_,@function
_ZN5eosio11multi_indexILy3849304914312298496ENS_8multisig14approvals_infoEJEE6modifyIZNS1_7approveEyNS_4nameENS_16permission_levelEE3$_2EEvRKS2_yOT_:
	.param  	i32, i32, i64, i32
	.local  	i64, i32, i32, i32, i32, i64, i32, i32, i32
	i32.const	$push71=, 0
	i32.load	$push72=, __stack_pointer($pop71)
	i32.const	$push73=, 16
	i32.sub 	$push84=, $pop72, $pop73
	tee_local	$push83=, $12=, $pop84
	copy_local	$11=, $pop83
	i32.const	$push74=, 0
	i32.store	__stack_pointer($pop74), $12
	i32.load	$push0=, 32($1)
	i32.eq  	$push1=, $pop0, $0
	i32.const	$push2=, .L.str.17
	call    	eosio_assert@FUNCTION, $pop1, $pop2
	i64.load	$push3=, 0($0)
	i64.call	$push4=, current_receiver@FUNCTION
	i64.eq  	$push5=, $pop3, $pop4
	i32.const	$push6=, .L.str.18
	call    	eosio_assert@FUNCTION, $pop5, $pop6
	i32.load	$10=, 0($3)
	i64.load	$4=, 0($1)
	block   	
	block   	
	i32.const	$push10=, 24
	i32.add 	$push82=, $1, $pop10
	tee_local	$push81=, $7=, $pop82
	i32.load	$push80=, 0($pop81)
	tee_local	$push79=, $5=, $pop80
	i32.const	$push7=, 28
	i32.add 	$push8=, $1, $pop7
	i32.load	$push9=, 0($pop8)
	i32.eq  	$push11=, $pop79, $pop9
	br_if   	0, $pop11
	i64.load	$push12=, 0($10)
	i64.store	0($5), $pop12
	i32.const	$push13=, 8
	i32.add 	$push14=, $5, $pop13
	i32.const	$push85=, 8
	i32.add 	$push15=, $10, $pop85
	i64.load	$push16=, 0($pop15)
	i64.store	0($pop14), $pop16
	i32.load	$push17=, 0($7)
	i32.const	$push18=, 16
	i32.add 	$push19=, $pop17, $pop18
	i32.store	0($7), $pop19
	br      	1
.LBB29_2:
	end_block
	i32.const	$push20=, 20
	i32.add 	$push21=, $1, $pop20
	call    	_ZNSt3__16vectorIN5eosio16permission_levelENS_9allocatorIS2_EEE21__push_back_slow_pathIRKS2_EEvOT_@FUNCTION, $pop21, $10
.LBB29_3:
	end_block
	block   	
	i32.const	$push24=, 12
	i32.add 	$push96=, $1, $pop24
	tee_local	$push95=, $10=, $pop96
	i32.load	$push25=, 0($pop95)
	i32.load	$push22=, 4($3)
	i32.load	$push94=, 0($pop22)
	tee_local	$push93=, $3=, $pop94
	i32.const	$push23=, 16
	i32.add 	$push92=, $pop93, $pop23
	tee_local	$push91=, $5=, $pop92
	i32.sub 	$push90=, $pop25, $pop91
	tee_local	$push89=, $6=, $pop90
	i32.const	$push88=, 4
	i32.shr_s	$push87=, $pop89, $pop88
	tee_local	$push86=, $7=, $pop87
	i32.eqz 	$push125=, $pop86
	br_if   	0, $pop125
	i32.call	$drop=, memmove@FUNCTION, $3, $5, $6
.LBB29_5:
	end_block
	i32.const	$push105=, 4
	i32.shl 	$push26=, $7, $pop105
	i32.add 	$push27=, $3, $pop26
	i32.store	0($10), $pop27
	i64.load	$push28=, 0($1)
	i64.eq  	$push29=, $4, $pop28
	i32.const	$push30=, .L.str.19
	call    	eosio_assert@FUNCTION, $pop29, $pop30
	i32.const	$3=, 8
	i32.const	$push104=, 8
	i32.add 	$5=, $1, $pop104
	i32.load	$push103=, 0($10)
	tee_local	$push102=, $10=, $pop103
	i32.load	$push101=, 8($1)
	tee_local	$push100=, $6=, $pop101
	i32.sub 	$push99=, $pop102, $pop100
	tee_local	$push98=, $8=, $pop99
	i32.const	$push97=, 4
	i32.shr_s	$push31=, $pop98, $pop97
	i64.extend_u/i32	$9=, $pop31
.LBB29_6:
	loop    	
	i32.const	$push110=, 1
	i32.add 	$3=, $3, $pop110
	i64.const	$push109=, 7
	i64.shr_u	$push108=, $9, $pop109
	tee_local	$push107=, $9=, $pop108
	i64.const	$push106=, 0
	i64.ne  	$push32=, $pop107, $pop106
	br_if   	0, $pop32
	end_loop
	i32.const	$push33=, 20
	i32.add 	$7=, $1, $pop33
	block   	
	i32.eq  	$push34=, $6, $10
	br_if   	0, $pop34
	i32.const	$push35=, -16
	i32.and 	$push36=, $8, $pop35
	i32.add 	$3=, $pop36, $3
.LBB29_9:
	end_block
	i32.const	$push37=, 24
	i32.add 	$push38=, $1, $pop37
	i32.load	$push116=, 0($pop38)
	tee_local	$push115=, $10=, $pop116
	i32.load	$push114=, 0($7)
	tee_local	$push113=, $6=, $pop114
	i32.sub 	$push112=, $pop115, $pop113
	tee_local	$push111=, $8=, $pop112
	i32.const	$push39=, 4
	i32.shr_s	$push40=, $pop111, $pop39
	i64.extend_u/i32	$9=, $pop40
.LBB29_10:
	loop    	
	i32.const	$push121=, 1
	i32.add 	$3=, $3, $pop121
	i64.const	$push120=, 7
	i64.shr_u	$push119=, $9, $pop120
	tee_local	$push118=, $9=, $pop119
	i64.const	$push117=, 0
	i64.ne  	$push41=, $pop118, $pop117
	br_if   	0, $pop41
	end_loop
	block   	
	i32.eq  	$push42=, $6, $10
	br_if   	0, $pop42
	i32.const	$push43=, -16
	i32.and 	$push44=, $8, $pop43
	i32.add 	$3=, $pop44, $3
.LBB29_13:
	end_block
	block   	
	block   	
	i32.const	$push45=, 513
	i32.lt_u	$push46=, $3, $pop45
	br_if   	0, $pop46
	i32.call	$10=, malloc@FUNCTION, $3
	br      	1
.LBB29_15:
	end_block
	i32.const	$push70=, 0
	i32.const	$push47=, 15
	i32.add 	$push48=, $3, $pop47
	i32.const	$push49=, -16
	i32.and 	$push50=, $pop48, $pop49
	i32.sub 	$push123=, $12, $pop50
	tee_local	$push122=, $10=, $pop123
	copy_local	$push78=, $pop122
	i32.store	__stack_pointer($pop70), $pop78
.LBB29_16:
	end_block
	i32.store	0($11), $10
	i32.add 	$push51=, $10, $3
	i32.store	8($11), $pop51
	i32.const	$push52=, 7
	i32.gt_s	$push53=, $3, $pop52
	i32.const	$push54=, .L.str.11
	call    	eosio_assert@FUNCTION, $pop53, $pop54
	i32.const	$push55=, 8
	i32.call	$drop=, memcpy@FUNCTION, $10, $1, $pop55
	i32.const	$push124=, 8
	i32.add 	$push56=, $10, $pop124
	i32.store	4($11), $pop56
	i32.call	$drop=, _ZN5eosiolsINS_10datastreamIPcEENS_16permission_levelEEERT_S6_RKNSt3__16vectorIT0_NS7_9allocatorIS9_EEEE@FUNCTION, $11, $5
	i32.call	$drop=, _ZN5eosiolsINS_10datastreamIPcEENS_16permission_levelEEERT_S6_RKNSt3__16vectorIT0_NS7_9allocatorIS9_EEEE@FUNCTION, $11, $7
	i32.load	$push57=, 36($1)
	call    	db_update_i64@FUNCTION, $pop57, $2, $10, $3
	block   	
	i32.const	$push58=, 513
	i32.lt_u	$push59=, $3, $pop58
	br_if   	0, $pop59
	call    	free@FUNCTION, $10
.LBB29_18:
	end_block
	block   	
	i64.load	$push60=, 16($0)
	i64.lt_u	$push61=, $4, $pop60
	br_if   	0, $pop61
	i32.const	$push68=, 16
	i32.add 	$push69=, $0, $pop68
	i64.const	$push66=, -2
	i64.const	$push64=, 1
	i64.add 	$push65=, $4, $pop64
	i64.const	$push62=, -3
	i64.gt_u	$push63=, $4, $pop62
	i64.select	$push67=, $pop66, $pop65, $pop63
	i64.store	0($pop69), $pop67
.LBB29_20:
	end_block
	i32.const	$push77=, 0
	i32.const	$push75=, 16
	i32.add 	$push76=, $11, $pop75
	i32.store	__stack_pointer($pop77), $pop76
	.endfunc
.Lfunc_end29:
	.size	_ZN5eosio11multi_indexILy3849304914312298496ENS_8multisig14approvals_infoEJEE6modifyIZNS1_7approveEyNS_4nameENS_16permission_levelEE3$_2EEvRKS2_yOT_, .Lfunc_end29-_ZN5eosio11multi_indexILy3849304914312298496ENS_8multisig14approvals_infoEJEE6modifyIZNS1_7approveEyNS_4nameENS_16permission_levelEE3$_2EEvRKS2_yOT_

	.section	.text._ZNSt3__16vectorIN5eosio16permission_levelENS_9allocatorIS2_EEE21__push_back_slow_pathIRKS2_EEvOT_,"axG",@progbits,_ZNSt3__16vectorIN5eosio16permission_levelENS_9allocatorIS2_EEE21__push_back_slow_pathIRKS2_EEvOT_,comdat
	.hidden	_ZNSt3__16vectorIN5eosio16permission_levelENS_9allocatorIS2_EEE21__push_back_slow_pathIRKS2_EEvOT_
	.weak	_ZNSt3__16vectorIN5eosio16permission_levelENS_9allocatorIS2_EEE21__push_back_slow_pathIRKS2_EEvOT_
	.type	_ZNSt3__16vectorIN5eosio16permission_levelENS_9allocatorIS2_EEE21__push_back_slow_pathIRKS2_EEvOT_,@function
_ZNSt3__16vectorIN5eosio16permission_levelENS_9allocatorIS2_EEE21__push_back_slow_pathIRKS2_EEvOT_:
	.param  	i32, i32
	.local  	i32, i32, i32, i32, i32, i32
	block   	
	block   	
	block   	
	i32.load	$push34=, 4($0)
	tee_local	$push33=, $6=, $pop34
	i32.load	$push32=, 0($0)
	tee_local	$push31=, $5=, $pop32
	i32.sub 	$push0=, $pop33, $pop31
	i32.const	$push30=, 4
	i32.shr_s	$push29=, $pop0, $pop30
	tee_local	$push28=, $2=, $pop29
	i32.const	$push1=, 1
	i32.add 	$push27=, $pop28, $pop1
	tee_local	$push26=, $3=, $pop27
	i32.const	$push2=, 268435456
	i32.ge_u	$push3=, $pop26, $pop2
	br_if   	0, $pop3
	i32.const	$4=, 268435455
	block   	
	block   	
	i32.load	$push4=, 8($0)
	i32.sub 	$push37=, $pop4, $5
	tee_local	$push36=, $7=, $pop37
	i32.const	$push35=, 4
	i32.shr_s	$push5=, $pop36, $pop35
	i32.const	$push6=, 134217726
	i32.gt_u	$push7=, $pop5, $pop6
	br_if   	0, $pop7
	i32.const	$push8=, 3
	i32.shr_s	$push41=, $7, $pop8
	tee_local	$push40=, $4=, $pop41
	i32.lt_u	$push9=, $4, $3
	i32.select	$push39=, $3, $pop40, $pop9
	tee_local	$push38=, $4=, $pop39
	i32.eqz 	$push53=, $pop38
	br_if   	1, $pop53
	i32.const	$push10=, 268435456
	i32.ge_u	$push11=, $4, $pop10
	br_if   	3, $pop11
.LBB30_4:
	end_block
	i32.const	$push12=, 4
	i32.shl 	$push13=, $4, $pop12
	i32.call	$7=, _Znwj@FUNCTION, $pop13
	i32.const	$push42=, 4
	i32.add 	$push14=, $0, $pop42
	i32.load	$6=, 0($pop14)
	i32.load	$5=, 0($0)
	br      	3
.LBB30_5:
	end_block
	i32.const	$4=, 0
	i32.const	$7=, 0
	br      	2
.LBB30_6:
	end_block
	call    	_ZNKSt3__120__vector_base_commonILb1EE20__throw_length_errorEv@FUNCTION, $0
	unreachable
.LBB30_7:
	end_block
	call    	abort@FUNCTION
	unreachable
.LBB30_8:
	end_block
	i32.const	$push50=, 4
	i32.shl 	$push15=, $2, $pop50
	i32.add 	$push49=, $7, $pop15
	tee_local	$push48=, $3=, $pop49
	i64.load	$push16=, 0($1)
	i64.store	0($pop48), $pop16
	i32.const	$push47=, 8
	i32.add 	$push17=, $3, $pop47
	i32.const	$push46=, 8
	i32.add 	$push18=, $1, $pop46
	i64.load	$push19=, 0($pop18)
	i64.store	0($pop17), $pop19
	i32.sub 	$push45=, $6, $5
	tee_local	$push44=, $1=, $pop45
	i32.sub 	$6=, $3, $pop44
	i32.const	$push43=, 4
	i32.shl 	$push20=, $4, $pop43
	i32.add 	$4=, $7, $pop20
	i32.const	$push21=, 16
	i32.add 	$3=, $3, $pop21
	block   	
	i32.const	$push22=, 1
	i32.lt_s	$push23=, $1, $pop22
	br_if   	0, $pop23
	i32.call	$drop=, memcpy@FUNCTION, $6, $5, $1
	i32.load	$5=, 0($0)
.LBB30_10:
	end_block
	i32.store	0($0), $6
	i32.const	$push52=, 4
	i32.add 	$push24=, $0, $pop52
	i32.store	0($pop24), $3
	i32.const	$push51=, 8
	i32.add 	$push25=, $0, $pop51
	i32.store	0($pop25), $4
	block   	
	i32.eqz 	$push54=, $5
	br_if   	0, $pop54
	call    	_ZdlPv@FUNCTION, $5
.LBB30_12:
	end_block
	.endfunc
.Lfunc_end30:
	.size	_ZNSt3__16vectorIN5eosio16permission_levelENS_9allocatorIS2_EEE21__push_back_slow_pathIRKS2_EEvOT_, .Lfunc_end30-_ZNSt3__16vectorIN5eosio16permission_levelENS_9allocatorIS2_EEE21__push_back_slow_pathIRKS2_EEvOT_

	.section	.text._ZNK5eosio11multi_indexILy3849304914312298496ENS_8multisig14approvals_infoEJEE31load_object_by_primary_iteratorEl,"axG",@progbits,_ZNK5eosio11multi_indexILy3849304914312298496ENS_8multisig14approvals_infoEJEE31load_object_by_primary_iteratorEl,comdat
	.hidden	_ZNK5eosio11multi_indexILy3849304914312298496ENS_8multisig14approvals_infoEJEE31load_object_by_primary_iteratorEl
	.weak	_ZNK5eosio11multi_indexILy3849304914312298496ENS_8multisig14approvals_infoEJEE31load_object_by_primary_iteratorEl
	.type	_ZNK5eosio11multi_indexILy3849304914312298496ENS_8multisig14approvals_infoEJEE31load_object_by_primary_iteratorEl,@function
_ZNK5eosio11multi_indexILy3849304914312298496ENS_8multisig14approvals_infoEJEE31load_object_by_primary_iteratorEl:
	.param  	i32, i32
	.result 	i32
	.local  	i32, i32, i32, i64, i32, i32, i32, i32
	i32.const	$push55=, 0
	i32.load	$push56=, __stack_pointer($pop55)
	i32.const	$push57=, 48
	i32.sub 	$push78=, $pop56, $pop57
	tee_local	$push77=, $9=, $pop78
	copy_local	$8=, $pop77
	i32.const	$push58=, 0
	i32.store	__stack_pointer($pop58), $9
	block   	
	i32.const	$push2=, 28
	i32.add 	$push3=, $0, $pop2
	i32.load	$push76=, 0($pop3)
	tee_local	$push75=, $7=, $pop76
	i32.load	$push74=, 24($0)
	tee_local	$push73=, $2=, $pop74
	i32.eq  	$push4=, $pop75, $pop73
	br_if   	0, $pop4
	i32.const	$push5=, 0
	i32.sub 	$3=, $pop5, $2
	i32.const	$push79=, -24
	i32.add 	$6=, $7, $pop79
.LBB31_2:
	loop    	
	i32.const	$push80=, 16
	i32.add 	$push6=, $6, $pop80
	i32.load	$push7=, 0($pop6)
	i32.eq  	$push8=, $pop7, $1
	br_if   	1, $pop8
	copy_local	$7=, $6
	i32.const	$push84=, -24
	i32.add 	$push83=, $6, $pop84
	tee_local	$push82=, $4=, $pop83
	copy_local	$6=, $pop82
	i32.add 	$push9=, $4, $3
	i32.const	$push81=, -24
	i32.ne  	$push10=, $pop9, $pop81
	br_if   	0, $pop10
.LBB31_4:
	end_loop
	end_block
	block   	
	block   	
	i32.eq  	$push11=, $7, $2
	br_if   	0, $pop11
	i32.const	$push12=, -24
	i32.add 	$push13=, $7, $pop12
	i32.load	$6=, 0($pop13)
	br      	1
.LBB31_6:
	end_block
	i32.const	$push14=, 0
	i32.const	$push87=, 0
	i32.call	$push86=, db_get_i64@FUNCTION, $1, $pop14, $pop87
	tee_local	$push85=, $6=, $pop86
	i32.const	$push15=, 31
	i32.shr_u	$push16=, $pop85, $pop15
	i32.const	$push17=, 1
	i32.xor 	$push18=, $pop16, $pop17
	i32.const	$push19=, .L.str.15
	call    	eosio_assert@FUNCTION, $pop18, $pop19
	block   	
	block   	
	i32.const	$push20=, 513
	i32.lt_u	$push21=, $6, $pop20
	br_if   	0, $pop21
	i32.call	$4=, malloc@FUNCTION, $6
	br      	1
.LBB31_8:
	end_block
	i32.const	$push54=, 0
	i32.const	$push22=, 15
	i32.add 	$push23=, $6, $pop22
	i32.const	$push24=, -16
	i32.and 	$push25=, $pop23, $pop24
	i32.sub 	$push89=, $9, $pop25
	tee_local	$push88=, $4=, $pop89
	copy_local	$push72=, $pop88
	i32.store	__stack_pointer($pop54), $pop72
.LBB31_9:
	end_block
	i32.call	$drop=, db_get_i64@FUNCTION, $1, $4, $6
	i32.store	36($8), $4
	i32.store	32($8), $4
	i32.add 	$push91=, $4, $6
	tee_local	$push90=, $7=, $pop91
	i32.store	40($8), $pop90
	block   	
	i32.const	$push26=, 512
	i32.le_u	$push27=, $6, $pop26
	br_if   	0, $pop27
	call    	free@FUNCTION, $4
	i32.const	$push28=, 40
	i32.add 	$push29=, $8, $pop28
	i32.load	$7=, 0($pop29)
	i32.load	$4=, 36($8)
.LBB31_11:
	end_block
	i32.const	$push30=, 48
	i32.call	$push106=, _Znwj@FUNCTION, $pop30
	tee_local	$push105=, $6=, $pop106
	i64.const	$push31=, 0
	i64.store	0($pop105), $pop31
	i64.const	$push104=, 0
	i64.store	8($6):p2align=2, $pop104
	i64.const	$push103=, 0
	i64.store	16($6):p2align=2, $pop103
	i64.const	$push102=, 0
	i64.store	24($6):p2align=2, $pop102
	i32.store	32($6), $0
	i32.sub 	$push32=, $7, $4
	i32.const	$push33=, 7
	i32.gt_u	$push34=, $pop32, $pop33
	i32.const	$push35=, .L.str.12
	call    	eosio_assert@FUNCTION, $pop34, $pop35
	i32.const	$push36=, 8
	i32.call	$drop=, memcpy@FUNCTION, $6, $4, $pop36
	i32.const	$push101=, 8
	i32.add 	$push37=, $4, $pop101
	i32.store	36($8), $pop37
	i32.const	$push62=, 32
	i32.add 	$push63=, $8, $pop62
	i32.const	$push100=, 8
	i32.add 	$push38=, $6, $pop100
	i32.call	$drop=, _ZN5eosiorsINS_10datastreamIPKcEENS_16permission_levelEEERT_S7_RNSt3__16vectorIT0_NS8_9allocatorISA_EEEE@FUNCTION, $pop63, $pop38
	i32.const	$push64=, 32
	i32.add 	$push65=, $8, $pop64
	i32.const	$push39=, 20
	i32.add 	$push40=, $6, $pop39
	i32.call	$drop=, _ZN5eosiorsINS_10datastreamIPKcEENS_16permission_levelEEERT_S7_RNSt3__16vectorIT0_NS8_9allocatorISA_EEEE@FUNCTION, $pop65, $pop40
	i32.store	36($6), $1
	i32.store	24($8), $6
	i64.load	$push99=, 0($6)
	tee_local	$push98=, $5=, $pop99
	i64.store	16($8), $pop98
	i32.load	$push97=, 36($6)
	tee_local	$push96=, $7=, $pop97
	i32.store	12($8), $pop96
	block   	
	block   	
	i32.const	$push44=, 28
	i32.add 	$push95=, $0, $pop44
	tee_local	$push94=, $1=, $pop95
	i32.load	$push93=, 0($pop94)
	tee_local	$push92=, $4=, $pop93
	i32.const	$push41=, 32
	i32.add 	$push42=, $0, $pop41
	i32.load	$push43=, 0($pop42)
	i32.ge_u	$push45=, $pop92, $pop43
	br_if   	0, $pop45
	i64.store	8($4), $5
	i32.store	16($4), $7
	i32.const	$push46=, 0
	i32.store	24($8), $pop46
	i32.store	0($4), $6
	i32.const	$push47=, 24
	i32.add 	$push48=, $4, $pop47
	i32.store	0($1), $pop48
	br      	1
.LBB31_13:
	end_block
	i32.const	$push1=, 24
	i32.add 	$push0=, $0, $pop1
	i32.const	$push66=, 24
	i32.add 	$push67=, $8, $pop66
	i32.const	$push68=, 16
	i32.add 	$push69=, $8, $pop68
	i32.const	$push70=, 12
	i32.add 	$push71=, $8, $pop70
	call    	_ZNSt3__16vectorIN5eosio11multi_indexILy3849304914312298496ENS1_8multisig14approvals_infoEJEE8item_ptrENS_9allocatorIS6_EEE24__emplace_back_slow_pathIJNS_10unique_ptrINS5_4itemENS_14default_deleteISC_EEEERyRlEEEvDpOT_@FUNCTION, $pop0, $pop67, $pop69, $pop71
.LBB31_14:
	end_block
	i32.load	$4=, 24($8)
	i32.const	$push49=, 0
	i32.store	24($8), $pop49
	i32.eqz 	$push111=, $4
	br_if   	0, $pop111
	block   	
	i32.load	$push108=, 20($4)
	tee_local	$push107=, $7=, $pop108
	i32.eqz 	$push112=, $pop107
	br_if   	0, $pop112
	i32.const	$push50=, 24
	i32.add 	$push51=, $4, $pop50
	i32.store	0($pop51), $7
	call    	_ZdlPv@FUNCTION, $7
.LBB31_17:
	end_block
	block   	
	i32.load	$push110=, 8($4)
	tee_local	$push109=, $7=, $pop110
	i32.eqz 	$push113=, $pop109
	br_if   	0, $pop113
	i32.const	$push52=, 12
	i32.add 	$push53=, $4, $pop52
	i32.store	0($pop53), $7
	call    	_ZdlPv@FUNCTION, $7
.LBB31_19:
	end_block
	call    	_ZdlPv@FUNCTION, $4
.LBB31_20:
	end_block
	i32.const	$push61=, 0
	i32.const	$push59=, 48
	i32.add 	$push60=, $8, $pop59
	i32.store	__stack_pointer($pop61), $pop60
	copy_local	$push114=, $6
	.endfunc
.Lfunc_end31:
	.size	_ZNK5eosio11multi_indexILy3849304914312298496ENS_8multisig14approvals_infoEJEE31load_object_by_primary_iteratorEl, .Lfunc_end31-_ZNK5eosio11multi_indexILy3849304914312298496ENS_8multisig14approvals_infoEJEE31load_object_by_primary_iteratorEl

	.text
	.hidden	_ZN5eosio8multisig9unapproveEyNS_4nameENS_16permission_levelE
	.globl	_ZN5eosio8multisig9unapproveEyNS_4nameENS_16permission_levelE
	.type	_ZN5eosio8multisig9unapproveEyNS_4nameENS_16permission_levelE,@function
_ZN5eosio8multisig9unapproveEyNS_4nameENS_16permission_levelE:
	.param  	i32, i64, i64, i32
	.local  	i64, i64, i32, i32, i32, i32
	i32.const	$push28=, 0
	i32.const	$push25=, 0
	i32.load	$push26=, __stack_pointer($pop25)
	i32.const	$push27=, 64
	i32.sub 	$push51=, $pop26, $pop27
	tee_local	$push50=, $9=, $pop51
	i32.store	__stack_pointer($pop28), $pop50
	i64.load	$push49=, 0($3)
	tee_local	$push48=, $4=, $pop49
	i64.load	$push47=, 8($3)
	tee_local	$push46=, $5=, $pop47
	call    	require_auth2@FUNCTION, $pop48, $pop46
	i32.const	$push0=, 56
	i32.add 	$push1=, $9, $pop0
	i32.const	$push2=, 0
	i32.store	0($pop1), $pop2
	i64.store	32($9), $1
	i64.const	$push3=, -1
	i64.store	40($9), $pop3
	i64.const	$push4=, 0
	i64.store	48($9), $pop4
	i64.load	$push5=, 0($0)
	i64.store	24($9), $pop5
	block   	
	i32.const	$push32=, 24
	i32.add 	$push33=, $9, $pop32
	i32.const	$push6=, .L.str.3
	i32.call	$push45=, _ZNK5eosio11multi_indexILy3849304914312298496ENS_8multisig14approvals_infoEJEE3getEyPKc@FUNCTION, $pop33, $2, $pop6
	tee_local	$push44=, $6=, $pop45
	i32.load	$push43=, 20($pop44)
	tee_local	$push42=, $0=, $pop43
	i32.const	$push7=, 24
	i32.add 	$push8=, $6, $pop7
	i32.load	$push41=, 0($pop8)
	tee_local	$push40=, $8=, $pop41
	i32.eq  	$push9=, $pop42, $pop40
	br_if   	0, $pop9
.LBB32_2:
	loop    	
	block   	
	i64.load	$push10=, 0($0)
	i64.ne  	$push11=, $pop10, $4
	br_if   	0, $pop11
	i32.const	$push52=, 8
	i32.add 	$push12=, $0, $pop52
	i64.load	$push13=, 0($pop12)
	i64.eq  	$push14=, $pop13, $5
	br_if   	2, $pop14
.LBB32_4:
	end_block
	i32.const	$push55=, 16
	i32.add 	$push54=, $0, $pop55
	tee_local	$push53=, $0=, $pop54
	i32.ne  	$push15=, $8, $pop53
	br_if   	0, $pop15
	end_loop
	copy_local	$0=, $8
.LBB32_6:
	end_block
	i32.store	16($9), $0
	i32.ne  	$push16=, $0, $8
	i32.const	$push17=, .L.str.5
	call    	eosio_assert@FUNCTION, $pop16, $pop17
	i32.store	8($9), $3
	i32.const	$push34=, 16
	i32.add 	$push35=, $9, $pop34
	i32.store	12($9), $pop35
	i32.const	$push36=, 24
	i32.add 	$push37=, $9, $pop36
	i32.const	$push38=, 8
	i32.add 	$push39=, $9, $pop38
	call    	_ZN5eosio11multi_indexILy3849304914312298496ENS_8multisig14approvals_infoEJEE6modifyIZNS1_9unapproveEyNS_4nameENS_16permission_levelEE3$_3EEvRKS2_yOT_@FUNCTION, $pop37, $6, $1, $pop39
	block   	
	i32.load	$push57=, 48($9)
	tee_local	$push56=, $6=, $pop57
	i32.eqz 	$push72=, $pop56
	br_if   	0, $pop72
	block   	
	block   	
	i32.const	$push18=, 52
	i32.add 	$push61=, $9, $pop18
	tee_local	$push60=, $7=, $pop61
	i32.load	$push59=, 0($pop60)
	tee_local	$push58=, $8=, $pop59
	i32.eq  	$push19=, $pop58, $6
	br_if   	0, $pop19
.LBB32_9:
	loop    	
	i32.const	$push65=, -24
	i32.add 	$push64=, $8, $pop65
	tee_local	$push63=, $8=, $pop64
	i32.load	$0=, 0($pop63)
	i32.const	$push62=, 0
	i32.store	0($8), $pop62
	block   	
	i32.eqz 	$push73=, $0
	br_if   	0, $pop73
	block   	
	i32.load	$push67=, 20($0)
	tee_local	$push66=, $3=, $pop67
	i32.eqz 	$push74=, $pop66
	br_if   	0, $pop74
	i32.const	$push68=, 24
	i32.add 	$push20=, $0, $pop68
	i32.store	0($pop20), $3
	call    	_ZdlPv@FUNCTION, $3
.LBB32_12:
	end_block
	block   	
	i32.load	$push70=, 8($0)
	tee_local	$push69=, $3=, $pop70
	i32.eqz 	$push75=, $pop69
	br_if   	0, $pop75
	i32.const	$push71=, 12
	i32.add 	$push21=, $0, $pop71
	i32.store	0($pop21), $3
	call    	_ZdlPv@FUNCTION, $3
.LBB32_14:
	end_block
	call    	_ZdlPv@FUNCTION, $0
.LBB32_15:
	end_block
	i32.ne  	$push22=, $6, $8
	br_if   	0, $pop22
	end_loop
	i32.const	$push23=, 48
	i32.add 	$push24=, $9, $pop23
	i32.load	$0=, 0($pop24)
	br      	1
.LBB32_17:
	end_block
	copy_local	$0=, $6
.LBB32_18:
	end_block
	i32.store	0($7), $6
	call    	_ZdlPv@FUNCTION, $0
.LBB32_19:
	end_block
	i32.const	$push31=, 0
	i32.const	$push29=, 64
	i32.add 	$push30=, $9, $pop29
	i32.store	__stack_pointer($pop31), $pop30
	.endfunc
.Lfunc_end32:
	.size	_ZN5eosio8multisig9unapproveEyNS_4nameENS_16permission_levelE, .Lfunc_end32-_ZN5eosio8multisig9unapproveEyNS_4nameENS_16permission_levelE

	.type	_ZN5eosio11multi_indexILy3849304914312298496ENS_8multisig14approvals_infoEJEE6modifyIZNS1_9unapproveEyNS_4nameENS_16permission_levelEE3$_3EEvRKS2_yOT_,@function
_ZN5eosio11multi_indexILy3849304914312298496ENS_8multisig14approvals_infoEJEE6modifyIZNS1_9unapproveEyNS_4nameENS_16permission_levelEE3$_3EEvRKS2_yOT_:
	.param  	i32, i32, i64, i32
	.local  	i64, i32, i32, i32, i32, i64, i32, i32, i32
	i32.const	$push71=, 0
	i32.load	$push72=, __stack_pointer($pop71)
	i32.const	$push73=, 16
	i32.sub 	$push85=, $pop72, $pop73
	tee_local	$push84=, $12=, $pop85
	copy_local	$11=, $pop84
	i32.const	$push74=, 0
	i32.store	__stack_pointer($pop74), $12
	i32.load	$push0=, 32($1)
	i32.eq  	$push1=, $pop0, $0
	i32.const	$push2=, .L.str.17
	call    	eosio_assert@FUNCTION, $pop1, $pop2
	i64.load	$push3=, 0($0)
	i64.call	$push4=, current_receiver@FUNCTION
	i64.eq  	$push5=, $pop3, $pop4
	i32.const	$push6=, .L.str.18
	call    	eosio_assert@FUNCTION, $pop5, $pop6
	i32.load	$10=, 0($3)
	i64.load	$4=, 0($1)
	block   	
	block   	
	i32.const	$push9=, 12
	i32.add 	$push83=, $1, $pop9
	tee_local	$push82=, $7=, $pop83
	i32.load	$push81=, 0($pop82)
	tee_local	$push80=, $5=, $pop81
	i32.const	$push79=, 16
	i32.add 	$push7=, $1, $pop79
	i32.load	$push8=, 0($pop7)
	i32.eq  	$push10=, $pop80, $pop8
	br_if   	0, $pop10
	i64.load	$push11=, 0($10)
	i64.store	0($5), $pop11
	i32.const	$push12=, 8
	i32.add 	$push13=, $5, $pop12
	i32.const	$push87=, 8
	i32.add 	$push14=, $10, $pop87
	i64.load	$push15=, 0($pop14)
	i64.store	0($pop13), $pop15
	i32.load	$push16=, 0($7)
	i32.const	$push86=, 16
	i32.add 	$push17=, $pop16, $pop86
	i32.store	0($7), $pop17
	br      	1
.LBB33_2:
	end_block
	i32.const	$push18=, 8
	i32.add 	$push19=, $1, $pop18
	call    	_ZNSt3__16vectorIN5eosio16permission_levelENS_9allocatorIS2_EEE21__push_back_slow_pathIRKS2_EEvOT_@FUNCTION, $pop19, $10
.LBB33_3:
	end_block
	block   	
	i32.const	$push22=, 24
	i32.add 	$push98=, $1, $pop22
	tee_local	$push97=, $10=, $pop98
	i32.load	$push23=, 0($pop97)
	i32.load	$push20=, 4($3)
	i32.load	$push96=, 0($pop20)
	tee_local	$push95=, $3=, $pop96
	i32.const	$push21=, 16
	i32.add 	$push94=, $pop95, $pop21
	tee_local	$push93=, $5=, $pop94
	i32.sub 	$push92=, $pop23, $pop93
	tee_local	$push91=, $6=, $pop92
	i32.const	$push90=, 4
	i32.shr_s	$push89=, $pop91, $pop90
	tee_local	$push88=, $7=, $pop89
	i32.eqz 	$push127=, $pop88
	br_if   	0, $pop127
	i32.call	$drop=, memmove@FUNCTION, $3, $5, $6
.LBB33_5:
	end_block
	i32.const	$push107=, 4
	i32.shl 	$push24=, $7, $pop107
	i32.add 	$push25=, $3, $pop24
	i32.store	0($10), $pop25
	i64.load	$push26=, 0($1)
	i64.eq  	$push27=, $4, $pop26
	i32.const	$push28=, .L.str.19
	call    	eosio_assert@FUNCTION, $pop27, $pop28
	i32.const	$3=, 8
	i32.const	$push106=, 8
	i32.add 	$5=, $1, $pop106
	i32.const	$push29=, 12
	i32.add 	$push30=, $1, $pop29
	i32.load	$push105=, 0($pop30)
	tee_local	$push104=, $10=, $pop105
	i32.load	$push103=, 8($1)
	tee_local	$push102=, $6=, $pop103
	i32.sub 	$push101=, $pop104, $pop102
	tee_local	$push100=, $8=, $pop101
	i32.const	$push99=, 4
	i32.shr_s	$push31=, $pop100, $pop99
	i64.extend_u/i32	$9=, $pop31
.LBB33_6:
	loop    	
	i32.const	$push112=, 1
	i32.add 	$3=, $3, $pop112
	i64.const	$push111=, 7
	i64.shr_u	$push110=, $9, $pop111
	tee_local	$push109=, $9=, $pop110
	i64.const	$push108=, 0
	i64.ne  	$push32=, $pop109, $pop108
	br_if   	0, $pop32
	end_loop
	i32.const	$push33=, 20
	i32.add 	$7=, $1, $pop33
	block   	
	i32.eq  	$push34=, $6, $10
	br_if   	0, $pop34
	i32.const	$push35=, -16
	i32.and 	$push36=, $8, $pop35
	i32.add 	$3=, $pop36, $3
.LBB33_9:
	end_block
	i32.const	$push37=, 24
	i32.add 	$push38=, $1, $pop37
	i32.load	$push118=, 0($pop38)
	tee_local	$push117=, $10=, $pop118
	i32.load	$push116=, 0($7)
	tee_local	$push115=, $6=, $pop116
	i32.sub 	$push114=, $pop117, $pop115
	tee_local	$push113=, $8=, $pop114
	i32.const	$push39=, 4
	i32.shr_s	$push40=, $pop113, $pop39
	i64.extend_u/i32	$9=, $pop40
.LBB33_10:
	loop    	
	i32.const	$push123=, 1
	i32.add 	$3=, $3, $pop123
	i64.const	$push122=, 7
	i64.shr_u	$push121=, $9, $pop122
	tee_local	$push120=, $9=, $pop121
	i64.const	$push119=, 0
	i64.ne  	$push41=, $pop120, $pop119
	br_if   	0, $pop41
	end_loop
	block   	
	i32.eq  	$push42=, $6, $10
	br_if   	0, $pop42
	i32.const	$push43=, -16
	i32.and 	$push44=, $8, $pop43
	i32.add 	$3=, $pop44, $3
.LBB33_13:
	end_block
	block   	
	block   	
	i32.const	$push45=, 513
	i32.lt_u	$push46=, $3, $pop45
	br_if   	0, $pop46
	i32.call	$10=, malloc@FUNCTION, $3
	br      	1
.LBB33_15:
	end_block
	i32.const	$push70=, 0
	i32.const	$push47=, 15
	i32.add 	$push48=, $3, $pop47
	i32.const	$push49=, -16
	i32.and 	$push50=, $pop48, $pop49
	i32.sub 	$push125=, $12, $pop50
	tee_local	$push124=, $10=, $pop125
	copy_local	$push78=, $pop124
	i32.store	__stack_pointer($pop70), $pop78
.LBB33_16:
	end_block
	i32.store	0($11), $10
	i32.add 	$push51=, $10, $3
	i32.store	8($11), $pop51
	i32.const	$push52=, 7
	i32.gt_s	$push53=, $3, $pop52
	i32.const	$push54=, .L.str.11
	call    	eosio_assert@FUNCTION, $pop53, $pop54
	i32.const	$push55=, 8
	i32.call	$drop=, memcpy@FUNCTION, $10, $1, $pop55
	i32.const	$push126=, 8
	i32.add 	$push56=, $10, $pop126
	i32.store	4($11), $pop56
	i32.call	$drop=, _ZN5eosiolsINS_10datastreamIPcEENS_16permission_levelEEERT_S6_RKNSt3__16vectorIT0_NS7_9allocatorIS9_EEEE@FUNCTION, $11, $5
	i32.call	$drop=, _ZN5eosiolsINS_10datastreamIPcEENS_16permission_levelEEERT_S6_RKNSt3__16vectorIT0_NS7_9allocatorIS9_EEEE@FUNCTION, $11, $7
	i32.load	$push57=, 36($1)
	call    	db_update_i64@FUNCTION, $pop57, $2, $10, $3
	block   	
	i32.const	$push58=, 513
	i32.lt_u	$push59=, $3, $pop58
	br_if   	0, $pop59
	call    	free@FUNCTION, $10
.LBB33_18:
	end_block
	block   	
	i64.load	$push60=, 16($0)
	i64.lt_u	$push61=, $4, $pop60
	br_if   	0, $pop61
	i32.const	$push68=, 16
	i32.add 	$push69=, $0, $pop68
	i64.const	$push66=, -2
	i64.const	$push64=, 1
	i64.add 	$push65=, $4, $pop64
	i64.const	$push62=, -3
	i64.gt_u	$push63=, $4, $pop62
	i64.select	$push67=, $pop66, $pop65, $pop63
	i64.store	0($pop69), $pop67
.LBB33_20:
	end_block
	i32.const	$push77=, 0
	i32.const	$push75=, 16
	i32.add 	$push76=, $11, $pop75
	i32.store	__stack_pointer($pop77), $pop76
	.endfunc
.Lfunc_end33:
	.size	_ZN5eosio11multi_indexILy3849304914312298496ENS_8multisig14approvals_infoEJEE6modifyIZNS1_9unapproveEyNS_4nameENS_16permission_levelEE3$_3EEvRKS2_yOT_, .Lfunc_end33-_ZN5eosio11multi_indexILy3849304914312298496ENS_8multisig14approvals_infoEJEE6modifyIZNS1_9unapproveEyNS_4nameENS_16permission_levelEE3$_3EEvRKS2_yOT_

	.hidden	_ZN5eosio8multisig6cancelEyNS_4nameEy
	.globl	_ZN5eosio8multisig6cancelEyNS_4nameEy
	.type	_ZN5eosio8multisig6cancelEyNS_4nameEy,@function
_ZN5eosio8multisig6cancelEyNS_4nameEy:
	.param  	i32, i64, i64, i64
	.local  	i32, i32, i32, i32, i32
	i32.const	$push33=, 0
	i32.const	$push30=, 0
	i32.load	$push31=, __stack_pointer($pop30)
	i32.const	$push32=, 96
	i32.sub 	$push51=, $pop31, $pop32
	tee_local	$push50=, $8=, $pop51
	i32.store	__stack_pointer($pop33), $pop50
	call    	require_auth@FUNCTION, $3
	i32.const	$push37=, 40
	i32.add 	$push38=, $8, $pop37
	i32.const	$push49=, 32
	i32.add 	$push0=, $pop38, $pop49
	i32.const	$push48=, 0
	i32.store	0($pop0), $pop48
	i64.store	48($8), $1
	i64.const	$push47=, -1
	i64.store	56($8), $pop47
	i64.const	$push46=, 0
	i64.store	64($8), $pop46
	i64.load	$push1=, 0($0)
	i64.store	40($8), $pop1
	i32.const	$push39=, 40
	i32.add 	$push40=, $8, $pop39
	i32.const	$push45=, .L.str.3
	i32.call	$7=, _ZNK5eosio11multi_indexILy12531646810004914176ENS_8multisig8proposalEJEE3getEyPKc@FUNCTION, $pop40, $2, $pop45
	block   	
	i64.eq  	$push2=, $3, $1
	br_if   	0, $pop2
	i32.const	$push3=, 12
	i32.add 	$push4=, $7, $pop3
	i32.load	$4=, 0($pop4)
	i32.load	$5=, 8($7)
	i64.call	$3=, current_time@FUNCTION
	i32.const	$push55=, 0
	i32.store	12($8), $pop55
	i32.const	$push54=, 0
	i32.store8	16($8), $pop54
	i32.const	$push53=, 0
	i32.store	20($8), $pop53
	i64.const	$push5=, 1000000
	i64.div_u	$push6=, $3, $pop5
	i32.wrap/i64	$push7=, $pop6
	i32.const	$push8=, 60
	i32.add 	$push9=, $pop7, $pop8
	i32.store	0($8), $pop9
	i32.store	84($8), $5
	i32.store	80($8), $5
	i32.store	88($8), $4
	i32.const	$push43=, 80
	i32.add 	$push44=, $8, $pop43
	i32.call	$drop=, _ZN5eosiorsINS_10datastreamIPKcEEEERT_S6_RNS_18transaction_headerE@FUNCTION, $pop44, $8
	i64.call	$3=, current_time@FUNCTION
	i32.load	$push12=, 0($8)
	i64.const	$push52=, 1000000
	i64.div_u	$push10=, $3, $pop52
	i32.wrap/i64	$push11=, $pop10
	i32.lt_u	$push13=, $pop12, $pop11
	i32.const	$push14=, .L.str.6
	call    	eosio_assert@FUNCTION, $pop13, $pop14
.LBB34_2:
	end_block
	i32.const	$push62=, 32
	i32.add 	$push15=, $8, $pop62
	i32.const	$push61=, 0
	i32.store	0($pop15), $pop61
	i64.store	8($8), $1
	i64.const	$push60=, -1
	i64.store	16($8), $pop60
	i64.const	$push59=, 0
	i64.store	24($8), $pop59
	i64.load	$push16=, 0($0)
	i64.store	0($8), $pop16
	i32.const	$push58=, .L.str.3
	i32.call	$0=, _ZNK5eosio11multi_indexILy3849304914312298496ENS_8multisig14approvals_infoEJEE3getEyPKc@FUNCTION, $8, $2, $pop58
	i32.const	$push41=, 40
	i32.add 	$push42=, $8, $pop41
	call    	_ZN5eosio11multi_indexILy12531646810004914176ENS_8multisig8proposalEJEE5eraseERKS2_@FUNCTION, $pop42, $7
	call    	_ZN5eosio11multi_indexILy3849304914312298496ENS_8multisig14approvals_infoEJEE5eraseERKS2_@FUNCTION, $8, $0
	block   	
	i32.load	$push57=, 24($8)
	tee_local	$push56=, $4=, $pop57
	i32.eqz 	$push90=, $pop56
	br_if   	0, $pop90
	block   	
	block   	
	i32.const	$push17=, 28
	i32.add 	$push66=, $8, $pop17
	tee_local	$push65=, $6=, $pop66
	i32.load	$push64=, 0($pop65)
	tee_local	$push63=, $7=, $pop64
	i32.eq  	$push18=, $pop63, $4
	br_if   	0, $pop18
.LBB34_5:
	loop    	
	i32.const	$push70=, -24
	i32.add 	$push69=, $7, $pop70
	tee_local	$push68=, $7=, $pop69
	i32.load	$0=, 0($pop68)
	i32.const	$push67=, 0
	i32.store	0($7), $pop67
	block   	
	i32.eqz 	$push91=, $0
	br_if   	0, $pop91
	block   	
	i32.load	$push72=, 20($0)
	tee_local	$push71=, $5=, $pop72
	i32.eqz 	$push92=, $pop71
	br_if   	0, $pop92
	i32.const	$push73=, 24
	i32.add 	$push19=, $0, $pop73
	i32.store	0($pop19), $5
	call    	_ZdlPv@FUNCTION, $5
.LBB34_8:
	end_block
	block   	
	i32.load	$push75=, 8($0)
	tee_local	$push74=, $5=, $pop75
	i32.eqz 	$push93=, $pop74
	br_if   	0, $pop93
	i32.const	$push76=, 12
	i32.add 	$push20=, $0, $pop76
	i32.store	0($pop20), $5
	call    	_ZdlPv@FUNCTION, $5
.LBB34_10:
	end_block
	call    	_ZdlPv@FUNCTION, $0
.LBB34_11:
	end_block
	i32.ne  	$push21=, $4, $7
	br_if   	0, $pop21
	end_loop
	i32.const	$push22=, 24
	i32.add 	$push23=, $8, $pop22
	i32.load	$0=, 0($pop23)
	br      	1
.LBB34_13:
	end_block
	copy_local	$0=, $4
.LBB34_14:
	end_block
	i32.store	0($6), $4
	call    	_ZdlPv@FUNCTION, $0
.LBB34_15:
	end_block
	block   	
	i32.load	$push78=, 64($8)
	tee_local	$push77=, $4=, $pop78
	i32.eqz 	$push94=, $pop77
	br_if   	0, $pop94
	block   	
	block   	
	i32.const	$push24=, 68
	i32.add 	$push82=, $8, $pop24
	tee_local	$push81=, $6=, $pop82
	i32.load	$push80=, 0($pop81)
	tee_local	$push79=, $0=, $pop80
	i32.eq  	$push25=, $pop79, $4
	br_if   	0, $pop25
.LBB34_18:
	loop    	
	i32.const	$push86=, -24
	i32.add 	$push85=, $0, $pop86
	tee_local	$push84=, $0=, $pop85
	i32.load	$7=, 0($pop84)
	i32.const	$push83=, 0
	i32.store	0($0), $pop83
	block   	
	i32.eqz 	$push95=, $7
	br_if   	0, $pop95
	block   	
	i32.load	$push88=, 8($7)
	tee_local	$push87=, $5=, $pop88
	i32.eqz 	$push96=, $pop87
	br_if   	0, $pop96
	i32.const	$push89=, 12
	i32.add 	$push26=, $7, $pop89
	i32.store	0($pop26), $5
	call    	_ZdlPv@FUNCTION, $5
.LBB34_21:
	end_block
	call    	_ZdlPv@FUNCTION, $7
.LBB34_22:
	end_block
	i32.ne  	$push27=, $4, $0
	br_if   	0, $pop27
	end_loop
	i32.const	$push28=, 64
	i32.add 	$push29=, $8, $pop28
	i32.load	$0=, 0($pop29)
	br      	1
.LBB34_24:
	end_block
	copy_local	$0=, $4
.LBB34_25:
	end_block
	i32.store	0($6), $4
	call    	_ZdlPv@FUNCTION, $0
.LBB34_26:
	end_block
	i32.const	$push36=, 0
	i32.const	$push34=, 96
	i32.add 	$push35=, $8, $pop34
	i32.store	__stack_pointer($pop36), $pop35
	.endfunc
.Lfunc_end34:
	.size	_ZN5eosio8multisig6cancelEyNS_4nameEy, .Lfunc_end34-_ZN5eosio8multisig6cancelEyNS_4nameEy

	.section	.text._ZNK5eosio11multi_indexILy12531646810004914176ENS_8multisig8proposalEJEE3getEyPKc,"axG",@progbits,_ZNK5eosio11multi_indexILy12531646810004914176ENS_8multisig8proposalEJEE3getEyPKc,comdat
	.hidden	_ZNK5eosio11multi_indexILy12531646810004914176ENS_8multisig8proposalEJEE3getEyPKc
	.weak	_ZNK5eosio11multi_indexILy12531646810004914176ENS_8multisig8proposalEJEE3getEyPKc
	.type	_ZNK5eosio11multi_indexILy12531646810004914176ENS_8multisig8proposalEJEE3getEyPKc,@function
_ZNK5eosio11multi_indexILy12531646810004914176ENS_8multisig8proposalEJEE3getEyPKc:
	.param  	i32, i64, i32
	.result 	i32
	.local  	i32, i32, i32, i32, i32
	block   	
	i32.const	$push0=, 28
	i32.add 	$push1=, $0, $pop0
	i32.load	$push27=, 0($pop1)
	tee_local	$push26=, $7=, $pop27
	i32.load	$push25=, 24($0)
	tee_local	$push24=, $3=, $pop25
	i32.eq  	$push2=, $pop26, $pop24
	br_if   	0, $pop2
	i32.const	$push28=, -24
	i32.add 	$6=, $7, $pop28
	i32.const	$push3=, 0
	i32.sub 	$4=, $pop3, $3
.LBB35_2:
	loop    	
	i32.load	$push4=, 0($6)
	i64.load	$push5=, 0($pop4)
	i64.eq  	$push6=, $pop5, $1
	br_if   	1, $pop6
	copy_local	$7=, $6
	i32.const	$push32=, -24
	i32.add 	$push31=, $6, $pop32
	tee_local	$push30=, $5=, $pop31
	copy_local	$6=, $pop30
	i32.add 	$push7=, $5, $4
	i32.const	$push29=, -24
	i32.ne  	$push8=, $pop7, $pop29
	br_if   	0, $pop8
.LBB35_4:
	end_loop
	end_block
	block   	
	block   	
	i32.eq  	$push9=, $7, $3
	br_if   	0, $pop9
	i32.const	$push10=, -24
	i32.add 	$push11=, $7, $pop10
	i32.load	$push34=, 0($pop11)
	tee_local	$push33=, $6=, $pop34
	i32.load	$push12=, 20($pop33)
	i32.eq  	$push13=, $pop12, $0
	i32.const	$push14=, .L.str.14
	call    	eosio_assert@FUNCTION, $pop13, $pop14
	br      	1
.LBB35_6:
	end_block
	i32.const	$6=, 0
	i64.load	$push16=, 0($0)
	i64.load	$push15=, 8($0)
	i64.const	$push17=, -5915097263704637440
	i32.call	$push37=, db_find_i64@FUNCTION, $pop16, $pop15, $pop17, $1
	tee_local	$push36=, $5=, $pop37
	i32.const	$push35=, 0
	i32.lt_s	$push18=, $pop36, $pop35
	br_if   	0, $pop18
	i32.call	$push39=, _ZNK5eosio11multi_indexILy12531646810004914176ENS_8multisig8proposalEJEE31load_object_by_primary_iteratorEl@FUNCTION, $0, $5
	tee_local	$push38=, $6=, $pop39
	i32.load	$push19=, 20($pop38)
	i32.eq  	$push20=, $pop19, $0
	i32.const	$push21=, .L.str.14
	call    	eosio_assert@FUNCTION, $pop20, $pop21
.LBB35_8:
	end_block
	i32.const	$push22=, 0
	i32.ne  	$push23=, $6, $pop22
	call    	eosio_assert@FUNCTION, $pop23, $2
	copy_local	$push40=, $6
	.endfunc
.Lfunc_end35:
	.size	_ZNK5eosio11multi_indexILy12531646810004914176ENS_8multisig8proposalEJEE3getEyPKc, .Lfunc_end35-_ZNK5eosio11multi_indexILy12531646810004914176ENS_8multisig8proposalEJEE3getEyPKc

	.section	.text._ZN5eosio11multi_indexILy12531646810004914176ENS_8multisig8proposalEJEE5eraseERKS2_,"axG",@progbits,_ZN5eosio11multi_indexILy12531646810004914176ENS_8multisig8proposalEJEE5eraseERKS2_,comdat
	.hidden	_ZN5eosio11multi_indexILy12531646810004914176ENS_8multisig8proposalEJEE5eraseERKS2_
	.weak	_ZN5eosio11multi_indexILy12531646810004914176ENS_8multisig8proposalEJEE5eraseERKS2_
	.type	_ZN5eosio11multi_indexILy12531646810004914176ENS_8multisig8proposalEJEE5eraseERKS2_,@function
_ZN5eosio11multi_indexILy12531646810004914176ENS_8multisig8proposalEJEE5eraseERKS2_:
	.param  	i32, i32
	.local  	i64, i32, i32, i32, i32, i32, i32
	i32.load	$push0=, 20($1)
	i32.eq  	$push1=, $pop0, $0
	i32.const	$push2=, .L.str.20
	call    	eosio_assert@FUNCTION, $pop1, $pop2
	i64.load	$push3=, 0($0)
	i64.call	$push4=, current_receiver@FUNCTION
	i64.eq  	$push5=, $pop3, $pop4
	i32.const	$push6=, .L.str.21
	call    	eosio_assert@FUNCTION, $pop5, $pop6
	block   	
	i32.const	$push7=, 28
	i32.add 	$push40=, $0, $pop7
	tee_local	$push39=, $5=, $pop40
	i32.load	$push38=, 0($pop39)
	tee_local	$push37=, $7=, $pop38
	i32.load	$push36=, 24($0)
	tee_local	$push35=, $3=, $pop36
	i32.eq  	$push8=, $pop37, $pop35
	br_if   	0, $pop8
	i64.load	$2=, 0($1)
	i32.const	$push9=, 0
	i32.sub 	$6=, $pop9, $3
	i32.const	$push41=, -24
	i32.add 	$8=, $7, $pop41
.LBB36_2:
	loop    	
	i32.load	$push10=, 0($8)
	i64.load	$push11=, 0($pop10)
	i64.eq  	$push12=, $pop11, $2
	br_if   	1, $pop12
	copy_local	$7=, $8
	i32.const	$push45=, -24
	i32.add 	$push44=, $8, $pop45
	tee_local	$push43=, $4=, $pop44
	copy_local	$8=, $pop43
	i32.add 	$push13=, $4, $6
	i32.const	$push42=, -24
	i32.ne  	$push14=, $pop13, $pop42
	br_if   	0, $pop14
.LBB36_4:
	end_loop
	end_block
	i32.ne  	$push15=, $7, $3
	i32.const	$push16=, .L.str.22
	call    	eosio_assert@FUNCTION, $pop15, $pop16
	i32.const	$push48=, -24
	i32.add 	$8=, $7, $pop48
	block   	
	block   	
	i32.load	$push47=, 0($5)
	tee_local	$push46=, $4=, $pop47
	i32.eq  	$push17=, $7, $pop46
	br_if   	0, $pop17
	i32.const	$push49=, 0
	i32.sub 	$3=, $pop49, $4
	copy_local	$7=, $8
.LBB36_6:
	loop    	
	i32.const	$push53=, 24
	i32.add 	$push52=, $7, $pop53
	tee_local	$push51=, $8=, $pop52
	i32.load	$6=, 0($pop51)
	i32.const	$push50=, 0
	i32.store	0($8), $pop50
	i32.load	$4=, 0($7)
	i32.store	0($7), $6
	block   	
	i32.eqz 	$push71=, $4
	br_if   	0, $pop71
	block   	
	i32.load	$push55=, 8($4)
	tee_local	$push54=, $6=, $pop55
	i32.eqz 	$push72=, $pop54
	br_if   	0, $pop72
	i32.const	$push56=, 12
	i32.add 	$push18=, $4, $pop56
	i32.store	0($pop18), $6
	call    	_ZdlPv@FUNCTION, $6
.LBB36_9:
	end_block
	call    	_ZdlPv@FUNCTION, $4
.LBB36_10:
	end_block
	i32.const	$push61=, 16
	i32.add 	$push19=, $7, $pop61
	i32.const	$push60=, 40
	i32.add 	$push20=, $7, $pop60
	i32.load	$push21=, 0($pop20)
	i32.store	0($pop19), $pop21
	i32.const	$push59=, 8
	i32.add 	$push22=, $7, $pop59
	i32.const	$push58=, 32
	i32.add 	$push23=, $7, $pop58
	i64.load	$push24=, 0($pop23)
	i64.store	0($pop22), $pop24
	copy_local	$7=, $8
	i32.add 	$push25=, $8, $3
	i32.const	$push57=, -24
	i32.ne  	$push26=, $pop25, $pop57
	br_if   	0, $pop26
	end_loop
	i32.const	$push27=, 28
	i32.add 	$push28=, $0, $pop27
	i32.load	$push63=, 0($pop28)
	tee_local	$push62=, $7=, $pop63
	i32.eq  	$push29=, $pop62, $8
	br_if   	1, $pop29
.LBB36_12:
	end_block
.LBB36_13:
	loop    	
	i32.const	$push67=, -24
	i32.add 	$push66=, $7, $pop67
	tee_local	$push65=, $7=, $pop66
	i32.load	$4=, 0($pop65)
	i32.const	$push64=, 0
	i32.store	0($7), $pop64
	block   	
	i32.eqz 	$push73=, $4
	br_if   	0, $pop73
	block   	
	i32.load	$push69=, 8($4)
	tee_local	$push68=, $6=, $pop69
	i32.eqz 	$push74=, $pop68
	br_if   	0, $pop74
	i32.const	$push70=, 12
	i32.add 	$push30=, $4, $pop70
	i32.store	0($pop30), $6
	call    	_ZdlPv@FUNCTION, $6
.LBB36_16:
	end_block
	call    	_ZdlPv@FUNCTION, $4
.LBB36_17:
	end_block
	i32.ne  	$push31=, $8, $7
	br_if   	0, $pop31
.LBB36_18:
	end_loop
	end_block
	i32.const	$push32=, 28
	i32.add 	$push33=, $0, $pop32
	i32.store	0($pop33), $8
	i32.load	$push34=, 24($1)
	call    	db_remove_i64@FUNCTION, $pop34
	.endfunc
.Lfunc_end36:
	.size	_ZN5eosio11multi_indexILy12531646810004914176ENS_8multisig8proposalEJEE5eraseERKS2_, .Lfunc_end36-_ZN5eosio11multi_indexILy12531646810004914176ENS_8multisig8proposalEJEE5eraseERKS2_

	.section	.text._ZN5eosio11multi_indexILy3849304914312298496ENS_8multisig14approvals_infoEJEE5eraseERKS2_,"axG",@progbits,_ZN5eosio11multi_indexILy3849304914312298496ENS_8multisig14approvals_infoEJEE5eraseERKS2_,comdat
	.hidden	_ZN5eosio11multi_indexILy3849304914312298496ENS_8multisig14approvals_infoEJEE5eraseERKS2_
	.weak	_ZN5eosio11multi_indexILy3849304914312298496ENS_8multisig14approvals_infoEJEE5eraseERKS2_
	.type	_ZN5eosio11multi_indexILy3849304914312298496ENS_8multisig14approvals_infoEJEE5eraseERKS2_,@function
_ZN5eosio11multi_indexILy3849304914312298496ENS_8multisig14approvals_infoEJEE5eraseERKS2_:
	.param  	i32, i32
	.local  	i64, i32, i32, i32, i32, i32, i32
	i32.load	$push0=, 32($1)
	i32.eq  	$push1=, $pop0, $0
	i32.const	$push2=, .L.str.20
	call    	eosio_assert@FUNCTION, $pop1, $pop2
	i64.load	$push3=, 0($0)
	i64.call	$push4=, current_receiver@FUNCTION
	i64.eq  	$push5=, $pop3, $pop4
	i32.const	$push6=, .L.str.21
	call    	eosio_assert@FUNCTION, $pop5, $pop6
	block   	
	i32.const	$push7=, 28
	i32.add 	$push42=, $0, $pop7
	tee_local	$push41=, $4=, $pop42
	i32.load	$push40=, 0($pop41)
	tee_local	$push39=, $7=, $pop40
	i32.load	$push38=, 24($0)
	tee_local	$push37=, $3=, $pop38
	i32.eq  	$push8=, $pop39, $pop37
	br_if   	0, $pop8
	i64.load	$2=, 0($1)
	i32.const	$push9=, 0
	i32.sub 	$5=, $pop9, $3
	i32.const	$push43=, -24
	i32.add 	$6=, $7, $pop43
.LBB37_2:
	loop    	
	i32.load	$push10=, 0($6)
	i64.load	$push11=, 0($pop10)
	i64.eq  	$push12=, $pop11, $2
	br_if   	1, $pop12
	copy_local	$7=, $6
	i32.const	$push47=, -24
	i32.add 	$push46=, $6, $pop47
	tee_local	$push45=, $8=, $pop46
	copy_local	$6=, $pop45
	i32.add 	$push13=, $8, $5
	i32.const	$push44=, -24
	i32.ne  	$push14=, $pop13, $pop44
	br_if   	0, $pop14
.LBB37_4:
	end_loop
	end_block
	i32.ne  	$push15=, $7, $3
	i32.const	$push16=, .L.str.22
	call    	eosio_assert@FUNCTION, $pop15, $pop16
	i32.const	$push50=, -24
	i32.add 	$8=, $7, $pop50
	block   	
	block   	
	i32.load	$push49=, 0($4)
	tee_local	$push48=, $6=, $pop49
	i32.eq  	$push17=, $7, $pop48
	br_if   	0, $pop17
	i32.const	$push51=, 0
	i32.sub 	$3=, $pop51, $6
	copy_local	$6=, $8
.LBB37_6:
	loop    	
	i32.const	$push55=, 24
	i32.add 	$push54=, $6, $pop55
	tee_local	$push53=, $8=, $pop54
	i32.load	$5=, 0($pop53)
	i32.const	$push52=, 0
	i32.store	0($8), $pop52
	i32.load	$7=, 0($6)
	i32.store	0($6), $5
	block   	
	i32.eqz 	$push79=, $7
	br_if   	0, $pop79
	block   	
	i32.load	$push57=, 20($7)
	tee_local	$push56=, $5=, $pop57
	i32.eqz 	$push80=, $pop56
	br_if   	0, $pop80
	i32.const	$push58=, 24
	i32.add 	$push18=, $7, $pop58
	i32.store	0($pop18), $5
	call    	_ZdlPv@FUNCTION, $5
.LBB37_9:
	end_block
	block   	
	i32.load	$push60=, 8($7)
	tee_local	$push59=, $5=, $pop60
	i32.eqz 	$push81=, $pop59
	br_if   	0, $pop81
	i32.const	$push61=, 12
	i32.add 	$push19=, $7, $pop61
	i32.store	0($pop19), $5
	call    	_ZdlPv@FUNCTION, $5
.LBB37_11:
	end_block
	call    	_ZdlPv@FUNCTION, $7
.LBB37_12:
	end_block
	i32.const	$push66=, 16
	i32.add 	$push20=, $6, $pop66
	i32.const	$push65=, 40
	i32.add 	$push21=, $6, $pop65
	i32.load	$push22=, 0($pop21)
	i32.store	0($pop20), $pop22
	i32.const	$push64=, 8
	i32.add 	$push23=, $6, $pop64
	i32.const	$push63=, 32
	i32.add 	$push24=, $6, $pop63
	i64.load	$push25=, 0($pop24)
	i64.store	0($pop23), $pop25
	copy_local	$6=, $8
	i32.add 	$push26=, $8, $3
	i32.const	$push62=, -24
	i32.ne  	$push27=, $pop26, $pop62
	br_if   	0, $pop27
	end_loop
	i32.const	$push28=, 28
	i32.add 	$push29=, $0, $pop28
	i32.load	$push68=, 0($pop29)
	tee_local	$push67=, $7=, $pop68
	i32.eq  	$push30=, $pop67, $8
	br_if   	1, $pop30
.LBB37_14:
	end_block
.LBB37_15:
	loop    	
	i32.const	$push72=, -24
	i32.add 	$push71=, $7, $pop72
	tee_local	$push70=, $7=, $pop71
	i32.load	$6=, 0($pop70)
	i32.const	$push69=, 0
	i32.store	0($7), $pop69
	block   	
	i32.eqz 	$push82=, $6
	br_if   	0, $pop82
	block   	
	i32.load	$push74=, 20($6)
	tee_local	$push73=, $5=, $pop74
	i32.eqz 	$push83=, $pop73
	br_if   	0, $pop83
	i32.const	$push75=, 24
	i32.add 	$push31=, $6, $pop75
	i32.store	0($pop31), $5
	call    	_ZdlPv@FUNCTION, $5
.LBB37_18:
	end_block
	block   	
	i32.load	$push77=, 8($6)
	tee_local	$push76=, $5=, $pop77
	i32.eqz 	$push84=, $pop76
	br_if   	0, $pop84
	i32.const	$push78=, 12
	i32.add 	$push32=, $6, $pop78
	i32.store	0($pop32), $5
	call    	_ZdlPv@FUNCTION, $5
.LBB37_20:
	end_block
	call    	_ZdlPv@FUNCTION, $6
.LBB37_21:
	end_block
	i32.ne  	$push33=, $8, $7
	br_if   	0, $pop33
.LBB37_22:
	end_loop
	end_block
	i32.const	$push34=, 28
	i32.add 	$push35=, $0, $pop34
	i32.store	0($pop35), $8
	i32.load	$push36=, 36($1)
	call    	db_remove_i64@FUNCTION, $pop36
	.endfunc
.Lfunc_end37:
	.size	_ZN5eosio11multi_indexILy3849304914312298496ENS_8multisig14approvals_infoEJEE5eraseERKS2_, .Lfunc_end37-_ZN5eosio11multi_indexILy3849304914312298496ENS_8multisig14approvals_infoEJEE5eraseERKS2_

	.text
	.hidden	_ZN5eosio8multisig4execEyNS_4nameEy
	.globl	_ZN5eosio8multisig4execEyNS_4nameEy
	.type	_ZN5eosio8multisig4execEyNS_4nameEy,@function
_ZN5eosio8multisig4execEyNS_4nameEy:
	.param  	i32, i64, i64, i64
	.local  	i32, i32, i32, i32, i32, i64, i32, i32
	i32.const	$push58=, 0
	i32.const	$push55=, 0
	i32.load	$push56=, __stack_pointer($pop55)
	i32.const	$push57=, 160
	i32.sub 	$push102=, $pop56, $pop57
	tee_local	$push101=, $11=, $pop102
	i32.store	__stack_pointer($pop58), $pop101
	call    	require_auth@FUNCTION, $3
	i32.const	$8=, 0
	i32.const	$push62=, 120
	i32.add 	$push63=, $11, $pop62
	i32.const	$push0=, 32
	i32.add 	$push1=, $pop63, $pop0
	i32.const	$push100=, 0
	i32.store	0($pop1), $pop100
	i64.store	128($11), $1
	i64.const	$push2=, -1
	i64.store	136($11), $pop2
	i64.const	$push99=, 0
	i64.store	144($11), $pop99
	i64.load	$push3=, 0($0)
	i64.store	120($11), $pop3
	i32.const	$push64=, 120
	i32.add 	$push65=, $11, $pop64
	i32.const	$push4=, .L.str.3
	i32.call	$10=, _ZNK5eosio11multi_indexILy12531646810004914176ENS_8multisig8proposalEJEE3getEyPKc@FUNCTION, $pop65, $2, $pop4
	i32.const	$push66=, 80
	i32.add 	$push67=, $11, $pop66
	i32.const	$push98=, 32
	i32.add 	$push5=, $pop67, $pop98
	i32.const	$push97=, 0
	i32.store	0($pop5), $pop97
	i64.store	88($11), $1
	i64.const	$push96=, -1
	i64.store	96($11), $pop96
	i64.const	$push95=, 0
	i64.store	104($11), $pop95
	i64.load	$push6=, 0($0)
	i64.store	80($11), $pop6
	i32.const	$push68=, 80
	i32.add 	$push69=, $11, $pop68
	i32.const	$push94=, .L.str.3
	i32.call	$0=, _ZNK5eosio11multi_indexILy3849304914312298496ENS_8multisig14approvals_infoEJEE3getEyPKc@FUNCTION, $pop69, $2, $pop94
	i64.call	$9=, current_time@FUNCTION
	i32.const	$push93=, 0
	i32.store	68($11), $pop93
	i32.const	$push92=, 0
	i32.store8	72($11), $pop92
	i32.const	$push91=, 0
	i32.store	76($11), $pop91
	i64.const	$push7=, 1000000
	i64.div_u	$push8=, $9, $pop7
	i32.wrap/i64	$push9=, $pop8
	i32.const	$push10=, 60
	i32.add 	$push11=, $pop9, $pop10
	i32.store	56($11), $pop11
	i32.load	$push90=, 8($10)
	tee_local	$push89=, $6=, $pop90
	i32.store	40($11), $pop89
	i32.store	44($11), $6
	i32.const	$push12=, 12
	i32.add 	$push13=, $10, $pop12
	i32.load	$push14=, 0($pop13)
	i32.store	48($11), $pop14
	i32.const	$push70=, 40
	i32.add 	$push71=, $11, $pop70
	i32.const	$push72=, 56
	i32.add 	$push73=, $11, $pop72
	i32.call	$drop=, _ZN5eosiorsINS_10datastreamIPKcEEEERT_S6_RNS_18transaction_headerE@FUNCTION, $pop71, $pop73
	i64.call	$9=, current_time@FUNCTION
	i32.load	$push17=, 56($11)
	i64.const	$push88=, 1000000
	i64.div_u	$push15=, $9, $pop88
	i32.wrap/i64	$push16=, $pop15
	i32.ge_u	$push18=, $pop17, $pop16
	i32.const	$push19=, .L.str
	call    	eosio_assert@FUNCTION, $pop18, $pop19
	i32.const	$push87=, 0
	i32.store	32($11), $pop87
	i64.const	$push86=, 0
	i64.store	24($11), $pop86
	i32.const	$push20=, 24
	i32.add 	$push21=, $0, $pop20
	i32.load	$push85=, 0($pop21)
	tee_local	$push84=, $6=, $pop85
	i32.load	$push83=, 20($0)
	tee_local	$push82=, $5=, $pop83
	i32.sub 	$push81=, $pop84, $pop82
	tee_local	$push80=, $7=, $pop81
	i32.const	$push22=, 4
	i32.shr_s	$push23=, $pop80, $pop22
	i64.extend_u/i32	$9=, $pop23
	i32.const	$push24=, 20
	i32.add 	$4=, $0, $pop24
.LBB38_1:
	loop    	
	i32.const	$push107=, -1
	i32.add 	$8=, $8, $pop107
	i64.const	$push106=, 7
	i64.shr_u	$push105=, $9, $pop106
	tee_local	$push104=, $9=, $pop105
	i64.const	$push103=, 0
	i64.ne  	$push25=, $pop104, $pop103
	br_if   	0, $pop25
	end_loop
	block   	
	block   	
	block   	
	block   	
	i32.eq  	$push27=, $5, $6
	br_if   	0, $pop27
	i32.const	$push28=, -16
	i32.and 	$push109=, $7, $pop28
	tee_local	$push108=, $6=, $pop109
	i32.ne  	$push29=, $pop108, $8
	br_if   	1, $pop29
	i32.const	$6=, 0
	i32.const	$8=, 0
	br      	3
.LBB38_5:
	end_block
	i32.const	$push26=, 0
	i32.sub 	$8=, $pop26, $8
	br      	1
.LBB38_6:
	end_block
	i32.sub 	$8=, $6, $8
.LBB38_7:
	end_block
	i32.const	$push74=, 24
	i32.add 	$push75=, $11, $pop74
	call    	_ZNSt3__16vectorIcNS_9allocatorIcEEE8__appendEj@FUNCTION, $pop75, $8
	i32.load	$6=, 28($11)
	i32.load	$8=, 24($11)
.LBB38_8:
	end_block
	i32.store	4($11), $8
	i32.store	0($11), $8
	i32.store	8($11), $6
	i32.call	$drop=, _ZN5eosiolsINS_10datastreamIPcEENS_16permission_levelEEERT_S6_RKNSt3__16vectorIT0_NS7_9allocatorIS9_EEEE@FUNCTION, $11, $4
	i32.const	$push30=, 8
	i32.add 	$push124=, $10, $pop30
	tee_local	$push123=, $8=, $pop124
	i32.load	$push122=, 0($pop123)
	tee_local	$push121=, $6=, $pop122
	i32.const	$push31=, 12
	i32.add 	$push120=, $10, $pop31
	tee_local	$push119=, $5=, $pop120
	i32.load	$push32=, 0($pop119)
	i32.sub 	$push33=, $pop32, $6
	i32.const	$push36=, 0
	i32.const	$push118=, 0
	i32.load	$push117=, 24($11)
	tee_local	$push116=, $6=, $pop117
	i32.load	$push34=, 28($11)
	i32.sub 	$push35=, $pop34, $6
	i32.call	$push37=, check_transaction_authorization@FUNCTION, $pop121, $pop33, $pop36, $pop118, $pop116, $pop35
	i32.const	$push115=, 0
	i32.gt_s	$push38=, $pop37, $pop115
	i32.const	$push39=, .L.str.2
	call    	eosio_assert@FUNCTION, $pop38, $pop39
	i64.store	8($11), $1
	i64.store	0($11), $2
	i32.load	$push114=, 0($8)
	tee_local	$push113=, $8=, $pop114
	i32.load	$push40=, 0($5)
	i32.sub 	$push41=, $pop40, $8
	i32.const	$push112=, 0
	call    	send_deferred@FUNCTION, $11, $3, $pop113, $pop41, $pop112
	i32.const	$push76=, 120
	i32.add 	$push77=, $11, $pop76
	call    	_ZN5eosio11multi_indexILy12531646810004914176ENS_8multisig8proposalEJEE5eraseERKS2_@FUNCTION, $pop77, $10
	i32.const	$push78=, 80
	i32.add 	$push79=, $11, $pop78
	call    	_ZN5eosio11multi_indexILy3849304914312298496ENS_8multisig14approvals_infoEJEE5eraseERKS2_@FUNCTION, $pop79, $0
	block   	
	i32.load	$push111=, 24($11)
	tee_local	$push110=, $8=, $pop111
	i32.eqz 	$push154=, $pop110
	br_if   	0, $pop154
	i32.store	28($11), $8
	call    	_ZdlPv@FUNCTION, $8
.LBB38_10:
	end_block
	block   	
	i32.load	$push126=, 104($11)
	tee_local	$push125=, $6=, $pop126
	i32.eqz 	$push155=, $pop125
	br_if   	0, $pop155
	block   	
	block   	
	i32.const	$push42=, 108
	i32.add 	$push130=, $11, $pop42
	tee_local	$push129=, $5=, $pop130
	i32.load	$push128=, 0($pop129)
	tee_local	$push127=, $10=, $pop128
	i32.eq  	$push43=, $pop127, $6
	br_if   	0, $pop43
.LBB38_13:
	loop    	
	i32.const	$push134=, -24
	i32.add 	$push133=, $10, $pop134
	tee_local	$push132=, $10=, $pop133
	i32.load	$8=, 0($pop132)
	i32.const	$push131=, 0
	i32.store	0($10), $pop131
	block   	
	i32.eqz 	$push156=, $8
	br_if   	0, $pop156
	block   	
	i32.load	$push136=, 20($8)
	tee_local	$push135=, $0=, $pop136
	i32.eqz 	$push157=, $pop135
	br_if   	0, $pop157
	i32.const	$push137=, 24
	i32.add 	$push44=, $8, $pop137
	i32.store	0($pop44), $0
	call    	_ZdlPv@FUNCTION, $0
.LBB38_16:
	end_block
	block   	
	i32.load	$push139=, 8($8)
	tee_local	$push138=, $0=, $pop139
	i32.eqz 	$push158=, $pop138
	br_if   	0, $pop158
	i32.const	$push140=, 12
	i32.add 	$push45=, $8, $pop140
	i32.store	0($pop45), $0
	call    	_ZdlPv@FUNCTION, $0
.LBB38_18:
	end_block
	call    	_ZdlPv@FUNCTION, $8
.LBB38_19:
	end_block
	i32.ne  	$push46=, $6, $10
	br_if   	0, $pop46
	end_loop
	i32.const	$push47=, 104
	i32.add 	$push48=, $11, $pop47
	i32.load	$8=, 0($pop48)
	br      	1
.LBB38_21:
	end_block
	copy_local	$8=, $6
.LBB38_22:
	end_block
	i32.store	0($5), $6
	call    	_ZdlPv@FUNCTION, $8
.LBB38_23:
	end_block
	block   	
	i32.load	$push142=, 144($11)
	tee_local	$push141=, $6=, $pop142
	i32.eqz 	$push159=, $pop141
	br_if   	0, $pop159
	block   	
	block   	
	i32.const	$push49=, 148
	i32.add 	$push146=, $11, $pop49
	tee_local	$push145=, $5=, $pop146
	i32.load	$push144=, 0($pop145)
	tee_local	$push143=, $8=, $pop144
	i32.eq  	$push50=, $pop143, $6
	br_if   	0, $pop50
.LBB38_26:
	loop    	
	i32.const	$push150=, -24
	i32.add 	$push149=, $8, $pop150
	tee_local	$push148=, $8=, $pop149
	i32.load	$10=, 0($pop148)
	i32.const	$push147=, 0
	i32.store	0($8), $pop147
	block   	
	i32.eqz 	$push160=, $10
	br_if   	0, $pop160
	block   	
	i32.load	$push152=, 8($10)
	tee_local	$push151=, $0=, $pop152
	i32.eqz 	$push161=, $pop151
	br_if   	0, $pop161
	i32.const	$push153=, 12
	i32.add 	$push51=, $10, $pop153
	i32.store	0($pop51), $0
	call    	_ZdlPv@FUNCTION, $0
.LBB38_29:
	end_block
	call    	_ZdlPv@FUNCTION, $10
.LBB38_30:
	end_block
	i32.ne  	$push52=, $6, $8
	br_if   	0, $pop52
	end_loop
	i32.const	$push53=, 144
	i32.add 	$push54=, $11, $pop53
	i32.load	$8=, 0($pop54)
	br      	1
.LBB38_32:
	end_block
	copy_local	$8=, $6
.LBB38_33:
	end_block
	i32.store	0($5), $6
	call    	_ZdlPv@FUNCTION, $8
.LBB38_34:
	end_block
	i32.const	$push61=, 0
	i32.const	$push59=, 160
	i32.add 	$push60=, $11, $pop59
	i32.store	__stack_pointer($pop61), $pop60
	.endfunc
.Lfunc_end38:
	.size	_ZN5eosio8multisig4execEyNS_4nameEy, .Lfunc_end38-_ZN5eosio8multisig4execEyNS_4nameEy

	.hidden	apply
	.globl	apply
	.type	apply,@function
apply:
	.param  	i64, i64, i64
	.local  	i32, i32, i64, i64, i64, i64, i32
	i32.const	$push77=, 0
	i32.const	$push74=, 0
	i32.load	$push75=, __stack_pointer($pop74)
	i32.const	$push76=, 96
	i32.sub 	$push102=, $pop75, $pop76
	tee_local	$push101=, $9=, $pop102
	i32.store	__stack_pointer($pop77), $pop101
	i64.const	$6=, 0
	i64.const	$5=, 59
	i32.const	$4=, .L.str.7
	i64.const	$7=, 0
.LBB39_1:
	loop    	
	block   	
	block   	
	block   	
	block   	
	block   	
	i64.const	$push103=, 6
	i64.gt_u	$push0=, $6, $pop103
	br_if   	0, $pop0
	i32.load8_s	$push108=, 0($4)
	tee_local	$push107=, $3=, $pop108
	i32.const	$push106=, -97
	i32.add 	$push2=, $pop107, $pop106
	i32.const	$push105=, 255
	i32.and 	$push3=, $pop2, $pop105
	i32.const	$push104=, 25
	i32.gt_u	$push4=, $pop3, $pop104
	br_if   	1, $pop4
	i32.const	$push109=, 165
	i32.add 	$3=, $3, $pop109
	br      	2
.LBB39_4:
	end_block
	i64.const	$8=, 0
	i64.const	$push110=, 11
	i64.le_u	$push1=, $6, $pop110
	br_if   	2, $pop1
	br      	3
.LBB39_5:
	end_block
	i32.const	$push115=, 208
	i32.add 	$push5=, $3, $pop115
	i32.const	$push114=, 0
	i32.const	$push113=, -49
	i32.add 	$push6=, $3, $pop113
	i32.const	$push112=, 255
	i32.and 	$push7=, $pop6, $pop112
	i32.const	$push111=, 5
	i32.lt_u	$push8=, $pop7, $pop111
	i32.select	$3=, $pop5, $pop114, $pop8
.LBB39_6:
	end_block
	i64.extend_u/i32	$push9=, $3
	i64.const	$push117=, 56
	i64.shl 	$push10=, $pop9, $pop117
	i64.const	$push116=, 56
	i64.shr_s	$8=, $pop10, $pop116
.LBB39_7:
	end_block
	i64.const	$push119=, 31
	i64.and 	$push12=, $8, $pop119
	i64.const	$push118=, 4294967295
	i64.and 	$push11=, $5, $pop118
	i64.shl 	$8=, $pop12, $pop11
.LBB39_8:
	end_block
	i32.const	$push125=, 1
	i32.add 	$4=, $4, $pop125
	i64.const	$push124=, 1
	i64.add 	$6=, $6, $pop124
	i64.or  	$7=, $8, $7
	i64.const	$push123=, -5
	i64.add 	$push122=, $5, $pop123
	tee_local	$push121=, $5=, $pop122
	i64.const	$push120=, -6
	i64.ne  	$push13=, $pop121, $pop120
	br_if   	0, $pop13
	end_loop
	block   	
	i64.ne  	$push14=, $7, $2
	br_if   	0, $pop14
	i64.const	$6=, 0
	i64.const	$5=, 59
	i32.const	$4=, .L.str.8
	i64.const	$7=, 0
.LBB39_11:
	loop    	
	block   	
	block   	
	block   	
	block   	
	block   	
	i64.const	$push126=, 4
	i64.gt_u	$push15=, $6, $pop126
	br_if   	0, $pop15
	i32.load8_s	$push131=, 0($4)
	tee_local	$push130=, $3=, $pop131
	i32.const	$push129=, -97
	i32.add 	$push17=, $pop130, $pop129
	i32.const	$push128=, 255
	i32.and 	$push18=, $pop17, $pop128
	i32.const	$push127=, 25
	i32.gt_u	$push19=, $pop18, $pop127
	br_if   	1, $pop19
	i32.const	$push132=, 165
	i32.add 	$3=, $3, $pop132
	br      	2
.LBB39_14:
	end_block
	i64.const	$8=, 0
	i64.const	$push133=, 11
	i64.le_u	$push16=, $6, $pop133
	br_if   	2, $pop16
	br      	3
.LBB39_15:
	end_block
	i32.const	$push138=, 208
	i32.add 	$push20=, $3, $pop138
	i32.const	$push137=, 0
	i32.const	$push136=, -49
	i32.add 	$push21=, $3, $pop136
	i32.const	$push135=, 255
	i32.and 	$push22=, $pop21, $pop135
	i32.const	$push134=, 5
	i32.lt_u	$push23=, $pop22, $pop134
	i32.select	$3=, $pop20, $pop137, $pop23
.LBB39_16:
	end_block
	i64.extend_u/i32	$push24=, $3
	i64.const	$push140=, 56
	i64.shl 	$push25=, $pop24, $pop140
	i64.const	$push139=, 56
	i64.shr_s	$8=, $pop25, $pop139
.LBB39_17:
	end_block
	i64.const	$push142=, 31
	i64.and 	$push27=, $8, $pop142
	i64.const	$push141=, 4294967295
	i64.and 	$push26=, $5, $pop141
	i64.shl 	$8=, $pop27, $pop26
.LBB39_18:
	end_block
	i32.const	$push148=, 1
	i32.add 	$4=, $4, $pop148
	i64.const	$push147=, 1
	i64.add 	$6=, $6, $pop147
	i64.or  	$7=, $8, $7
	i64.const	$push146=, -5
	i64.add 	$push145=, $5, $pop146
	tee_local	$push144=, $5=, $pop145
	i64.const	$push143=, -6
	i64.ne  	$push28=, $pop144, $pop143
	br_if   	0, $pop28
	end_loop
	i64.eq  	$push29=, $7, $1
	i32.const	$push30=, .L.str.9
	call    	eosio_assert@FUNCTION, $pop29, $pop30
.LBB39_20:
	end_block
	block   	
	block   	
	i64.eq  	$push31=, $1, $0
	br_if   	0, $pop31
	i64.const	$6=, 0
	i64.const	$5=, 59
	i32.const	$4=, .L.str.7
	i64.const	$7=, 0
.LBB39_22:
	loop    	
	block   	
	block   	
	block   	
	block   	
	block   	
	i64.const	$push149=, 6
	i64.gt_u	$push32=, $6, $pop149
	br_if   	0, $pop32
	i32.load8_s	$push154=, 0($4)
	tee_local	$push153=, $3=, $pop154
	i32.const	$push152=, -97
	i32.add 	$push34=, $pop153, $pop152
	i32.const	$push151=, 255
	i32.and 	$push35=, $pop34, $pop151
	i32.const	$push150=, 25
	i32.gt_u	$push36=, $pop35, $pop150
	br_if   	1, $pop36
	i32.const	$push155=, 165
	i32.add 	$3=, $3, $pop155
	br      	2
.LBB39_25:
	end_block
	i64.const	$8=, 0
	i64.const	$push156=, 11
	i64.le_u	$push33=, $6, $pop156
	br_if   	2, $pop33
	br      	3
.LBB39_26:
	end_block
	i32.const	$push161=, 208
	i32.add 	$push37=, $3, $pop161
	i32.const	$push160=, 0
	i32.const	$push159=, -49
	i32.add 	$push38=, $3, $pop159
	i32.const	$push158=, 255
	i32.and 	$push39=, $pop38, $pop158
	i32.const	$push157=, 5
	i32.lt_u	$push40=, $pop39, $pop157
	i32.select	$3=, $pop37, $pop160, $pop40
.LBB39_27:
	end_block
	i64.extend_u/i32	$push41=, $3
	i64.const	$push163=, 56
	i64.shl 	$push42=, $pop41, $pop163
	i64.const	$push162=, 56
	i64.shr_s	$8=, $pop42, $pop162
.LBB39_28:
	end_block
	i64.const	$push165=, 31
	i64.and 	$push44=, $8, $pop165
	i64.const	$push164=, 4294967295
	i64.and 	$push43=, $5, $pop164
	i64.shl 	$8=, $pop44, $pop43
.LBB39_29:
	end_block
	i32.const	$push171=, 1
	i32.add 	$4=, $4, $pop171
	i64.const	$push170=, 1
	i64.add 	$6=, $6, $pop170
	i64.or  	$7=, $8, $7
	i64.const	$push169=, -5
	i64.add 	$push168=, $5, $pop169
	tee_local	$push167=, $5=, $pop168
	i64.const	$push166=, -6
	i64.ne  	$push45=, $pop167, $pop166
	br_if   	0, $pop45
	end_loop
	i64.ne  	$push46=, $7, $2
	br_if   	1, $pop46
.LBB39_31:
	end_block
	i64.store	88($9), $0
	block   	
	block   	
	block   	
	block   	
	i64.const	$push47=, 3849304916161986559
	i64.le_s	$push48=, $2, $pop47
	br_if   	0, $pop48
	i64.const	$push49=, 3849304916161986560
	i64.eq  	$push50=, $2, $pop49
	br_if   	1, $pop50
	i64.const	$push51=, 4730614985703555072
	i64.eq  	$push52=, $2, $pop51
	br_if   	2, $pop52
	i64.const	$push53=, 6292795316831780864
	i64.ne  	$push54=, $2, $pop53
	br_if   	4, $pop54
	i32.const	$push59=, 0
	i32.store	52($9), $pop59
	i32.const	$push60=, _ZN5eosio8multisig4execEyNS_4nameEy@FUNCTION
	i32.store	48($9), $pop60
	i64.load	$push61=, 48($9)
	i64.store	40($9):p2align=2, $pop61
	i32.const	$push97=, 88
	i32.add 	$push98=, $9, $pop97
	i32.const	$push99=, 40
	i32.add 	$push100=, $9, $pop99
	i32.call	$drop=, _ZN5eosio14execute_actionINS_8multisigES1_JyNS_4nameEyEEEbPT_MT0_FvDpT1_E@FUNCTION, $pop98, $pop100
	br      	4
.LBB39_36:
	end_block
	i64.const	$push55=, -5915097261842366464
	i64.eq  	$push56=, $2, $pop55
	br_if   	2, $pop56
	i64.const	$push57=, -3112731855308193792
	i64.ne  	$push58=, $2, $pop57
	br_if   	3, $pop58
	i32.const	$push65=, 0
	i32.store	68($9), $pop65
	i32.const	$push66=, _ZN5eosio8multisig9unapproveEyNS_4nameENS_16permission_levelE@FUNCTION
	i32.store	64($9), $pop66
	i64.load	$push67=, 64($9)
	i64.store	24($9):p2align=2, $pop67
	i32.const	$push85=, 88
	i32.add 	$push86=, $9, $pop85
	i32.const	$push87=, 24
	i32.add 	$push88=, $9, $pop87
	i32.call	$drop=, _ZN5eosio14execute_actionINS_8multisigES1_JyNS_4nameENS_16permission_levelEEEEbPT_MT0_FvDpT1_E@FUNCTION, $pop86, $pop88
	br      	3
.LBB39_39:
	end_block
	i32.const	$push68=, 0
	i32.store	76($9), $pop68
	i32.const	$push69=, _ZN5eosio8multisig7approveEyNS_4nameENS_16permission_levelE@FUNCTION
	i32.store	72($9), $pop69
	i64.load	$push70=, 72($9)
	i64.store	16($9):p2align=2, $pop70
	i32.const	$push89=, 88
	i32.add 	$push90=, $9, $pop89
	i32.const	$push91=, 16
	i32.add 	$push92=, $9, $pop91
	i32.call	$drop=, _ZN5eosio14execute_actionINS_8multisigES1_JyNS_4nameENS_16permission_levelEEEEbPT_MT0_FvDpT1_E@FUNCTION, $pop90, $pop92
	br      	2
.LBB39_40:
	end_block
	i32.const	$push62=, 0
	i32.store	60($9), $pop62
	i32.const	$push63=, _ZN5eosio8multisig6cancelEyNS_4nameEy@FUNCTION
	i32.store	56($9), $pop63
	i64.load	$push64=, 56($9)
	i64.store	32($9):p2align=2, $pop64
	i32.const	$push93=, 88
	i32.add 	$push94=, $9, $pop93
	i32.const	$push95=, 32
	i32.add 	$push96=, $9, $pop95
	i32.call	$drop=, _ZN5eosio14execute_actionINS_8multisigES1_JyNS_4nameEyEEEbPT_MT0_FvDpT1_E@FUNCTION, $pop94, $pop96
	br      	1
.LBB39_41:
	end_block
	i32.const	$push71=, 0
	i32.store	84($9), $pop71
	i32.const	$push72=, _ZN5eosio8multisig7proposeEv@FUNCTION
	i32.store	80($9), $pop72
	i64.load	$push73=, 80($9)
	i64.store	8($9):p2align=2, $pop73
	i32.const	$push81=, 88
	i32.add 	$push82=, $9, $pop81
	i32.const	$push83=, 8
	i32.add 	$push84=, $9, $pop83
	i32.call	$drop=, _ZN5eosio14execute_actionINS_8multisigES1_JEEEbPT_MT0_FvDpT1_E@FUNCTION, $pop82, $pop84
.LBB39_42:
	end_block
	i32.const	$push80=, 0
	i32.const	$push78=, 96
	i32.add 	$push79=, $9, $pop78
	i32.store	__stack_pointer($pop80), $pop79
	.endfunc
.Lfunc_end39:
	.size	apply, .Lfunc_end39-apply

	.section	.text._ZN5eosio14execute_actionINS_8multisigES1_JEEEbPT_MT0_FvDpT1_E,"axG",@progbits,_ZN5eosio14execute_actionINS_8multisigES1_JEEEbPT_MT0_FvDpT1_E,comdat
	.hidden	_ZN5eosio14execute_actionINS_8multisigES1_JEEEbPT_MT0_FvDpT1_E
	.weak	_ZN5eosio14execute_actionINS_8multisigES1_JEEEbPT_MT0_FvDpT1_E
	.type	_ZN5eosio14execute_actionINS_8multisigES1_JEEEbPT_MT0_FvDpT1_E,@function
_ZN5eosio14execute_actionINS_8multisigES1_JEEEbPT_MT0_FvDpT1_E:
	.param  	i32, i32
	.result 	i32
	.local  	i32, i32, i32, i32
	i32.const	$push13=, 0
	i32.load	$push19=, __stack_pointer($pop13)
	tee_local	$push18=, $5=, $pop19
	copy_local	$4=, $pop18
	i32.load	$2=, 4($1)
	i32.load	$1=, 0($1)
	block   	
	i32.call	$push17=, action_data_size@FUNCTION
	tee_local	$push16=, $3=, $pop17
	i32.eqz 	$push25=, $pop16
	br_if   	0, $pop25
	block   	
	i32.const	$push0=, 512
	i32.le_u	$push1=, $3, $pop0
	br_if   	0, $pop1
	i32.call	$push21=, malloc@FUNCTION, $3
	tee_local	$push20=, $5=, $pop21
	i32.call	$drop=, read_action_data@FUNCTION, $pop20, $3
	call    	free@FUNCTION, $5
	br      	1
.LBB40_3:
	end_block
	i32.const	$push12=, 0
	i32.const	$push2=, 15
	i32.add 	$push3=, $3, $pop2
	i32.const	$push4=, -16
	i32.and 	$push5=, $pop3, $pop4
	i32.sub 	$push23=, $5, $pop5
	tee_local	$push22=, $5=, $pop23
	copy_local	$push15=, $pop22
	i32.store	__stack_pointer($pop12), $pop15
	i32.call	$drop=, read_action_data@FUNCTION, $5, $3
.LBB40_4:
	end_block
	i32.const	$push6=, 1
	i32.shr_s	$push7=, $2, $pop6
	i32.add 	$3=, $0, $pop7
	block   	
	i32.const	$push24=, 1
	i32.and 	$push8=, $2, $pop24
	i32.eqz 	$push26=, $pop8
	br_if   	0, $pop26
	i32.load	$push9=, 0($3)
	i32.add 	$push10=, $pop9, $1
	i32.load	$1=, 0($pop10)
.LBB40_6:
	end_block
	call_indirect	$3, $1
	i32.const	$push14=, 0
	i32.store	__stack_pointer($pop14), $4
	i32.const	$push11=, 1
	.endfunc
.Lfunc_end40:
	.size	_ZN5eosio14execute_actionINS_8multisigES1_JEEEbPT_MT0_FvDpT1_E, .Lfunc_end40-_ZN5eosio14execute_actionINS_8multisigES1_JEEEbPT_MT0_FvDpT1_E

	.section	.text._ZN5eosio14execute_actionINS_8multisigES1_JyNS_4nameENS_16permission_levelEEEEbPT_MT0_FvDpT1_E,"axG",@progbits,_ZN5eosio14execute_actionINS_8multisigES1_JyNS_4nameENS_16permission_levelEEEEbPT_MT0_FvDpT1_E,comdat
	.hidden	_ZN5eosio14execute_actionINS_8multisigES1_JyNS_4nameENS_16permission_levelEEEEbPT_MT0_FvDpT1_E
	.weak	_ZN5eosio14execute_actionINS_8multisigES1_JyNS_4nameENS_16permission_levelEEEEbPT_MT0_FvDpT1_E
	.type	_ZN5eosio14execute_actionINS_8multisigES1_JyNS_4nameENS_16permission_levelEEEEbPT_MT0_FvDpT1_E,@function
_ZN5eosio14execute_actionINS_8multisigES1_JyNS_4nameENS_16permission_levelEEEEbPT_MT0_FvDpT1_E:
	.param  	i32, i32
	.result 	i32
	.local  	i32, i32, i64, i64, i64, i32, i32, i32
	i32.const	$push38=, 0
	i32.load	$push39=, __stack_pointer($pop38)
	i32.const	$push40=, 96
	i32.sub 	$push67=, $pop39, $pop40
	tee_local	$push66=, $9=, $pop67
	copy_local	$8=, $pop66
	i32.const	$push41=, 0
	i32.store	__stack_pointer($pop41), $9
	i32.load	$2=, 4($1)
	i32.load	$7=, 0($1)
	block   	
	block   	
	block   	
	block   	
	i32.call	$push65=, action_data_size@FUNCTION
	tee_local	$push64=, $3=, $pop65
	i32.eqz 	$push82=, $pop64
	br_if   	0, $pop82
	i32.const	$push0=, 513
	i32.lt_u	$push1=, $3, $pop0
	br_if   	1, $pop1
	i32.call	$1=, malloc@FUNCTION, $3
	br      	2
.LBB41_3:
	end_block
	i32.const	$1=, 0
	br      	2
.LBB41_4:
	end_block
	i32.const	$push37=, 0
	i32.const	$push2=, 15
	i32.add 	$push3=, $3, $pop2
	i32.const	$push4=, -16
	i32.and 	$push5=, $pop3, $pop4
	i32.sub 	$push69=, $9, $pop5
	tee_local	$push68=, $1=, $pop69
	copy_local	$push63=, $pop68
	i32.store	__stack_pointer($pop37), $pop63
.LBB41_5:
	end_block
	i32.call	$drop=, read_action_data@FUNCTION, $1, $3
.LBB41_6:
	end_block
	i64.const	$push6=, 0
	i64.store	24($8), $pop6
	i64.const	$push70=, 0
	i64.store	16($8), $pop70
	i32.store	84($8), $1
	i32.store	80($8), $1
	i32.add 	$push7=, $1, $3
	i32.store	88($8), $pop7
	i32.const	$push45=, 80
	i32.add 	$push46=, $8, $pop45
	i32.store	48($8), $pop46
	i32.const	$push47=, 16
	i32.add 	$push48=, $8, $pop47
	i32.store	64($8), $pop48
	i32.const	$push49=, 64
	i32.add 	$push50=, $8, $pop49
	i32.const	$push51=, 48
	i32.add 	$push52=, $8, $pop51
	call    	_ZN5boost6fusion6detail17for_each_unrolledILi3EE4callINS0_18std_tuple_iteratorINSt3__15tupleIJyN5eosio4nameENS8_16permission_levelEEEELi0EEEZNS8_rsINS8_10datastreamIPKcEEJyS9_SA_EEERT_SJ_RNS7_IJDpT0_EEEEUlSJ_E_EEvRKSI_RKT0_@FUNCTION, $pop50, $pop52
	block   	
	i32.const	$push8=, 513
	i32.lt_u	$push9=, $3, $pop8
	br_if   	0, $pop9
	call    	free@FUNCTION, $1
.LBB41_8:
	end_block
	i32.const	$push53=, 16
	i32.add 	$push54=, $8, $pop53
	i32.const	$push10=, 8
	i32.add 	$push11=, $pop54, $pop10
	i64.load	$5=, 0($pop11)
	i32.const	$push12=, 60
	i32.add 	$push13=, $8, $pop12
	i32.const	$push14=, 44
	i32.add 	$push15=, $8, $pop14
	i32.load	$push16=, 0($pop15)
	i32.store	0($pop13), $pop16
	i32.const	$push55=, 48
	i32.add 	$push56=, $8, $pop55
	i32.const	$push75=, 8
	i32.add 	$push74=, $pop56, $pop75
	tee_local	$push73=, $1=, $pop74
	i32.const	$push17=, 40
	i32.add 	$push18=, $8, $pop17
	i32.load	$push19=, 0($pop18)
	i32.store	0($pop73), $pop19
	i64.load	$4=, 16($8)
	i32.load	$push20=, 32($8)
	i32.store	48($8), $pop20
	i32.const	$push21=, 36
	i32.add 	$push22=, $8, $pop21
	i32.load	$push23=, 0($pop22)
	i32.store	52($8), $pop23
	i32.const	$push57=, 64
	i32.add 	$push58=, $8, $pop57
	i32.const	$push72=, 8
	i32.add 	$push24=, $pop58, $pop72
	i64.load	$push25=, 0($1)
	i64.store	0($pop24), $pop25
	i64.load	$push26=, 48($8)
	i64.store	64($8), $pop26
	i32.const	$push27=, 1
	i32.shr_s	$push28=, $2, $pop27
	i32.add 	$1=, $0, $pop28
	block   	
	i32.const	$push71=, 1
	i32.and 	$push29=, $2, $pop71
	i32.eqz 	$push83=, $pop29
	br_if   	0, $pop83
	i32.load	$push30=, 0($1)
	i32.add 	$push31=, $pop30, $7
	i32.load	$7=, 0($pop31)
.LBB41_10:
	end_block
	i32.const	$push59=, 80
	i32.add 	$push60=, $8, $pop59
	i32.const	$push32=, 8
	i32.add 	$push33=, $pop60, $pop32
	i32.const	$push61=, 64
	i32.add 	$push62=, $8, $pop61
	i32.const	$push81=, 8
	i32.add 	$push34=, $pop62, $pop81
	i64.load	$push80=, 0($pop34)
	tee_local	$push79=, $6=, $pop80
	i64.store	0($pop33), $pop79
	i32.const	$push78=, 8
	i32.add 	$push35=, $8, $pop78
	i64.store	0($pop35), $6
	i64.load	$push77=, 64($8)
	tee_local	$push76=, $6=, $pop77
	i64.store	80($8), $pop76
	i64.store	0($8), $6
	call_indirect	$1, $4, $5, $8, $7
	i32.const	$push44=, 0
	i32.const	$push42=, 96
	i32.add 	$push43=, $8, $pop42
	i32.store	__stack_pointer($pop44), $pop43
	i32.const	$push36=, 1
	.endfunc
.Lfunc_end41:
	.size	_ZN5eosio14execute_actionINS_8multisigES1_JyNS_4nameENS_16permission_levelEEEEbPT_MT0_FvDpT1_E, .Lfunc_end41-_ZN5eosio14execute_actionINS_8multisigES1_JyNS_4nameENS_16permission_levelEEEEbPT_MT0_FvDpT1_E

	.section	.text._ZN5eosio14execute_actionINS_8multisigES1_JyNS_4nameEyEEEbPT_MT0_FvDpT1_E,"axG",@progbits,_ZN5eosio14execute_actionINS_8multisigES1_JyNS_4nameEyEEEbPT_MT0_FvDpT1_E,comdat
	.hidden	_ZN5eosio14execute_actionINS_8multisigES1_JyNS_4nameEyEEEbPT_MT0_FvDpT1_E
	.weak	_ZN5eosio14execute_actionINS_8multisigES1_JyNS_4nameEyEEEbPT_MT0_FvDpT1_E
	.type	_ZN5eosio14execute_actionINS_8multisigES1_JyNS_4nameEyEEEbPT_MT0_FvDpT1_E,@function
_ZN5eosio14execute_actionINS_8multisigES1_JyNS_4nameEyEEEbPT_MT0_FvDpT1_E:
	.param  	i32, i32
	.result 	i32
	.local  	i32, i64, i64, i64, i32, i32, i32, i32, i32
	i32.const	$push26=, 0
	i32.load	$push27=, __stack_pointer($pop26)
	i32.const	$push28=, 32
	i32.sub 	$push43=, $pop27, $pop28
	tee_local	$push42=, $8=, $pop43
	copy_local	$10=, $pop42
	i32.const	$push29=, 0
	i32.store	__stack_pointer($pop29), $8
	i32.load	$2=, 4($1)
	i32.load	$9=, 0($1)
	block   	
	block   	
	block   	
	block   	
	i32.call	$push41=, action_data_size@FUNCTION
	tee_local	$push40=, $1=, $pop41
	i32.eqz 	$push64=, $pop40
	br_if   	0, $pop64
	i32.const	$push0=, 513
	i32.lt_u	$push1=, $1, $pop0
	br_if   	1, $pop1
	i32.call	$8=, malloc@FUNCTION, $1
	br      	2
.LBB42_3:
	end_block
	i32.const	$8=, 0
	br      	2
.LBB42_4:
	end_block
	i32.const	$push25=, 0
	i32.const	$push2=, 15
	i32.add 	$push3=, $1, $pop2
	i32.const	$push4=, -16
	i32.and 	$push5=, $pop3, $pop4
	i32.sub 	$push45=, $8, $pop5
	tee_local	$push44=, $8=, $pop45
	copy_local	$push39=, $pop44
	i32.store	__stack_pointer($pop25), $pop39
.LBB42_5:
	end_block
	i32.call	$drop=, read_action_data@FUNCTION, $8, $1
.LBB42_6:
	end_block
	i64.const	$push6=, 0
	i64.store	16($10), $pop6
	i64.const	$push62=, 0
	i64.store	8($10), $pop62
	i64.const	$push61=, 0
	i64.store	24($10), $pop61
	i32.const	$push7=, 7
	i32.gt_u	$push8=, $1, $pop7
	i32.const	$push9=, .L.str.12
	call    	eosio_assert@FUNCTION, $pop8, $pop9
	i32.const	$push33=, 8
	i32.add 	$push34=, $10, $pop33
	i32.const	$push10=, 8
	i32.call	$drop=, memcpy@FUNCTION, $pop34, $8, $pop10
	i32.const	$push11=, -8
	i32.and 	$push60=, $1, $pop11
	tee_local	$push59=, $6=, $pop60
	i32.const	$push58=, 8
	i32.ne  	$push12=, $pop59, $pop58
	i32.const	$push57=, .L.str.12
	call    	eosio_assert@FUNCTION, $pop12, $pop57
	i32.const	$push35=, 8
	i32.add 	$push36=, $10, $pop35
	i32.const	$push56=, 8
	i32.add 	$push55=, $pop36, $pop56
	tee_local	$push54=, $7=, $pop55
	i32.const	$push53=, 8
	i32.add 	$push13=, $8, $pop53
	i32.const	$push52=, 8
	i32.call	$drop=, memcpy@FUNCTION, $pop54, $pop13, $pop52
	i32.const	$push14=, 16
	i32.ne  	$push15=, $6, $pop14
	i32.const	$push51=, .L.str.12
	call    	eosio_assert@FUNCTION, $pop15, $pop51
	i32.const	$push37=, 8
	i32.add 	$push38=, $10, $pop37
	i32.const	$push50=, 16
	i32.add 	$push49=, $pop38, $pop50
	tee_local	$push48=, $6=, $pop49
	i32.const	$push47=, 16
	i32.add 	$push16=, $8, $pop47
	i32.const	$push46=, 8
	i32.call	$drop=, memcpy@FUNCTION, $pop48, $pop16, $pop46
	block   	
	i32.const	$push17=, 513
	i32.lt_u	$push18=, $1, $pop17
	br_if   	0, $pop18
	call    	free@FUNCTION, $8
.LBB42_8:
	end_block
	i32.const	$push19=, 1
	i32.shr_s	$push20=, $2, $pop19
	i32.add 	$1=, $0, $pop20
	i64.load	$5=, 0($6)
	i64.load	$4=, 0($7)
	i64.load	$3=, 8($10)
	block   	
	i32.const	$push63=, 1
	i32.and 	$push21=, $2, $pop63
	i32.eqz 	$push65=, $pop21
	br_if   	0, $pop65
	i32.load	$push22=, 0($1)
	i32.add 	$push23=, $pop22, $9
	i32.load	$9=, 0($pop23)
.LBB42_10:
	end_block
	call_indirect	$1, $3, $4, $5, $9
	i32.const	$push32=, 0
	i32.const	$push30=, 32
	i32.add 	$push31=, $10, $pop30
	i32.store	__stack_pointer($pop32), $pop31
	i32.const	$push24=, 1
	.endfunc
.Lfunc_end42:
	.size	_ZN5eosio14execute_actionINS_8multisigES1_JyNS_4nameEyEEEbPT_MT0_FvDpT1_E, .Lfunc_end42-_ZN5eosio14execute_actionINS_8multisigES1_JyNS_4nameEyEEEbPT_MT0_FvDpT1_E

	.section	.text._ZN5boost6fusion6detail17for_each_unrolledILi3EE4callINS0_18std_tuple_iteratorINSt3__15tupleIJyN5eosio4nameENS8_16permission_levelEEEELi0EEEZNS8_rsINS8_10datastreamIPKcEEJyS9_SA_EEERT_SJ_RNS7_IJDpT0_EEEEUlSJ_E_EEvRKSI_RKT0_,"axG",@progbits,_ZN5boost6fusion6detail17for_each_unrolledILi3EE4callINS0_18std_tuple_iteratorINSt3__15tupleIJyN5eosio4nameENS8_16permission_levelEEEELi0EEEZNS8_rsINS8_10datastreamIPKcEEJyS9_SA_EEERT_SJ_RNS7_IJDpT0_EEEEUlSJ_E_EEvRKSI_RKT0_,comdat
	.hidden	_ZN5boost6fusion6detail17for_each_unrolledILi3EE4callINS0_18std_tuple_iteratorINSt3__15tupleIJyN5eosio4nameENS8_16permission_levelEEEELi0EEEZNS8_rsINS8_10datastreamIPKcEEJyS9_SA_EEERT_SJ_RNS7_IJDpT0_EEEEUlSJ_E_EEvRKSI_RKT0_
	.weak	_ZN5boost6fusion6detail17for_each_unrolledILi3EE4callINS0_18std_tuple_iteratorINSt3__15tupleIJyN5eosio4nameENS8_16permission_levelEEEELi0EEEZNS8_rsINS8_10datastreamIPKcEEJyS9_SA_EEERT_SJ_RNS7_IJDpT0_EEEEUlSJ_E_EEvRKSI_RKT0_
	.type	_ZN5boost6fusion6detail17for_each_unrolledILi3EE4callINS0_18std_tuple_iteratorINSt3__15tupleIJyN5eosio4nameENS8_16permission_levelEEEELi0EEEZNS8_rsINS8_10datastreamIPKcEEJyS9_SA_EEERT_SJ_RNS7_IJDpT0_EEEEUlSJ_E_EEvRKSI_RKT0_,@function
_ZN5boost6fusion6detail17for_each_unrolledILi3EE4callINS0_18std_tuple_iteratorINSt3__15tupleIJyN5eosio4nameENS8_16permission_levelEEEELi0EEEZNS8_rsINS8_10datastreamIPKcEEJyS9_SA_EEERT_SJ_RNS7_IJDpT0_EEEEUlSJ_E_EEvRKSI_RKT0_:
	.param  	i32, i32
	.local  	i32, i32
	i32.load	$2=, 0($0)
	i32.load	$push55=, 0($1)
	tee_local	$push54=, $3=, $pop55
	i32.load	$push1=, 8($pop54)
	i32.load	$push0=, 4($3)
	i32.sub 	$push2=, $pop1, $pop0
	i32.const	$push3=, 7
	i32.gt_u	$push4=, $pop2, $pop3
	i32.const	$push5=, .L.str.12
	call    	eosio_assert@FUNCTION, $pop4, $pop5
	i32.load	$push6=, 4($3)
	i32.const	$push7=, 8
	i32.call	$drop=, memcpy@FUNCTION, $2, $pop6, $pop7
	i32.load	$push8=, 4($3)
	i32.const	$push53=, 8
	i32.add 	$push9=, $pop8, $pop53
	i32.store	4($3), $pop9
	i32.load	$0=, 0($0)
	i32.load	$push52=, 0($1)
	tee_local	$push51=, $3=, $pop52
	i32.load	$push11=, 8($pop51)
	i32.load	$push10=, 4($3)
	i32.sub 	$push12=, $pop11, $pop10
	i32.const	$push50=, 7
	i32.gt_u	$push13=, $pop12, $pop50
	i32.const	$push49=, .L.str.12
	call    	eosio_assert@FUNCTION, $pop13, $pop49
	i32.const	$push48=, 8
	i32.add 	$push14=, $0, $pop48
	i32.load	$push15=, 4($3)
	i32.const	$push47=, 8
	i32.call	$drop=, memcpy@FUNCTION, $pop14, $pop15, $pop47
	i32.load	$push16=, 4($3)
	i32.const	$push46=, 8
	i32.add 	$push17=, $pop16, $pop46
	i32.store	4($3), $pop17
	i32.load	$push45=, 0($1)
	tee_local	$push44=, $3=, $pop45
	i32.load	$push19=, 8($pop44)
	i32.load	$push18=, 4($3)
	i32.sub 	$push20=, $pop19, $pop18
	i32.const	$push43=, 7
	i32.gt_u	$push21=, $pop20, $pop43
	i32.const	$push42=, .L.str.12
	call    	eosio_assert@FUNCTION, $pop21, $pop42
	i32.const	$push22=, 16
	i32.add 	$push23=, $0, $pop22
	i32.load	$push24=, 4($3)
	i32.const	$push41=, 8
	i32.call	$drop=, memcpy@FUNCTION, $pop23, $pop24, $pop41
	i32.load	$push25=, 4($3)
	i32.const	$push40=, 8
	i32.add 	$push39=, $pop25, $pop40
	tee_local	$push38=, $1=, $pop39
	i32.store	4($3), $pop38
	i32.load	$push26=, 8($3)
	i32.sub 	$push27=, $pop26, $1
	i32.const	$push37=, 7
	i32.gt_u	$push28=, $pop27, $pop37
	i32.const	$push36=, .L.str.12
	call    	eosio_assert@FUNCTION, $pop28, $pop36
	i32.const	$push29=, 24
	i32.add 	$push30=, $0, $pop29
	i32.load	$push31=, 4($3)
	i32.const	$push35=, 8
	i32.call	$drop=, memcpy@FUNCTION, $pop30, $pop31, $pop35
	i32.load	$push32=, 4($3)
	i32.const	$push34=, 8
	i32.add 	$push33=, $pop32, $pop34
	i32.store	4($3), $pop33
	.endfunc
.Lfunc_end43:
	.size	_ZN5boost6fusion6detail17for_each_unrolledILi3EE4callINS0_18std_tuple_iteratorINSt3__15tupleIJyN5eosio4nameENS8_16permission_levelEEEELi0EEEZNS8_rsINS8_10datastreamIPKcEEJyS9_SA_EEERT_SJ_RNS7_IJDpT0_EEEEUlSJ_E_EEvRKSI_RKT0_, .Lfunc_end43-_ZN5boost6fusion6detail17for_each_unrolledILi3EE4callINS0_18std_tuple_iteratorINSt3__15tupleIJyN5eosio4nameENS8_16permission_levelEEEELi0EEEZNS8_rsINS8_10datastreamIPKcEEJyS9_SA_EEERT_SJ_RNS7_IJDpT0_EEEEUlSJ_E_EEvRKSI_RKT0_

	.text
	.weak	_Znwj
	.type	_Znwj,@function
_Znwj:
	.param  	i32
	.result 	i32
	.local  	i32, i32
	block   	
	i32.const	$push0=, 1
	i32.select	$push4=, $0, $pop0, $0
	tee_local	$push3=, $1=, $pop4
	i32.call	$push2=, malloc@FUNCTION, $pop3
	tee_local	$push1=, $0=, $pop2
	br_if   	0, $pop1
.LBB44_1:
	loop    	
	i32.const	$0=, 0
	i32.const	$push9=, 0
	i32.load	$push8=, _ZStL13__new_handler($pop9)
	tee_local	$push7=, $2=, $pop8
	i32.eqz 	$push10=, $pop7
	br_if   	1, $pop10
	call_indirect	$2
	i32.call	$push6=, malloc@FUNCTION, $1
	tee_local	$push5=, $0=, $pop6
	i32.eqz 	$push11=, $pop5
	br_if   	0, $pop11
.LBB44_3:
	end_loop
	end_block
	copy_local	$push12=, $0
	.endfunc
.Lfunc_end44:
	.size	_Znwj, .Lfunc_end44-_Znwj

	.weak	_ZdlPv
	.type	_ZdlPv,@function
_ZdlPv:
	.param  	i32
	block   	
	i32.eqz 	$push0=, $0
	br_if   	0, $pop0
	call    	free@FUNCTION, $0
.LBB45_2:
	end_block
	.endfunc
.Lfunc_end45:
	.size	_ZdlPv, .Lfunc_end45-_ZdlPv

	.section	.text._ZNKSt3__120__vector_base_commonILb1EE20__throw_length_errorEv,"axG",@progbits,_ZNKSt3__120__vector_base_commonILb1EE20__throw_length_errorEv,comdat
	.hidden	_ZNKSt3__120__vector_base_commonILb1EE20__throw_length_errorEv
	.weak	_ZNKSt3__120__vector_base_commonILb1EE20__throw_length_errorEv
	.type	_ZNKSt3__120__vector_base_commonILb1EE20__throw_length_errorEv,@function
_ZNKSt3__120__vector_base_commonILb1EE20__throw_length_errorEv:
	.param  	i32
	call    	abort@FUNCTION
	unreachable
	.endfunc
.Lfunc_end46:
	.size	_ZNKSt3__120__vector_base_commonILb1EE20__throw_length_errorEv, .Lfunc_end46-_ZNKSt3__120__vector_base_commonILb1EE20__throw_length_errorEv

	.text
	.hidden	memcmp
	.globl	memcmp
	.type	memcmp,@function
memcmp:
	.param  	i32, i32, i32
	.result 	i32
	.local  	i32, i32, i32
	i32.const	$5=, 0
	block   	
	i32.eqz 	$push10=, $2
	br_if   	0, $pop10
.LBB47_2:
	block   	
	loop    	
	i32.load8_u	$push4=, 0($0)
	tee_local	$push3=, $3=, $pop4
	i32.load8_u	$push2=, 0($1)
	tee_local	$push1=, $4=, $pop2
	i32.ne  	$push0=, $pop3, $pop1
	br_if   	1, $pop0
	i32.const	$push9=, 1
	i32.add 	$1=, $1, $pop9
	i32.const	$push8=, 1
	i32.add 	$0=, $0, $pop8
	i32.const	$push7=, -1
	i32.add 	$push6=, $2, $pop7
	tee_local	$push5=, $2=, $pop6
	br_if   	0, $pop5
	br      	2
.LBB47_4:
	end_loop
	end_block
	i32.sub 	$5=, $3, $4
.LBB47_5:
	end_block
	copy_local	$push11=, $5
	.endfunc
.Lfunc_end47:
	.size	memcmp, .Lfunc_end47-memcmp

	.hidden	malloc
	.globl	malloc
	.type	malloc,@function
malloc:
	.param  	i32
	.result 	i32
	i32.const	$push0=, _ZN5eosio11memory_heapE
	i32.call	$push1=, _ZN5eosio14memory_manager6mallocEm@FUNCTION, $pop0, $0
	.endfunc
.Lfunc_end48:
	.size	malloc, .Lfunc_end48-malloc

	.section	.text._ZN5eosio14memory_manager6mallocEm,"axG",@progbits,_ZN5eosio14memory_manager6mallocEm,comdat
	.hidden	_ZN5eosio14memory_manager6mallocEm
	.weak	_ZN5eosio14memory_manager6mallocEm
	.type	_ZN5eosio14memory_manager6mallocEm,@function
_ZN5eosio14memory_manager6mallocEm:
	.param  	i32, i32
	.result 	i32
	.local  	i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32
	block   	
	i32.eqz 	$push128=, $1
	br_if   	0, $pop128
	block   	
	i32.load	$push63=, 8384($0)
	tee_local	$push62=, $13=, $pop63
	br_if   	0, $pop62
	i32.const	$13=, 16
	i32.const	$push0=, 8384
	i32.add 	$push1=, $0, $pop0
	i32.const	$push64=, 16
	i32.store	0($pop1), $pop64
.LBB49_3:
	end_block
	i32.const	$push2=, 8
	i32.add 	$push3=, $1, $pop2
	i32.const	$push69=, 4
	i32.add 	$push4=, $1, $pop69
	i32.const	$push5=, 7
	i32.and 	$push68=, $pop4, $pop5
	tee_local	$push67=, $2=, $pop68
	i32.sub 	$push6=, $pop3, $pop67
	i32.select	$2=, $pop6, $1, $2
	block   	
	block   	
	block   	
	i32.load	$push66=, 8388($0)
	tee_local	$push65=, $10=, $pop66
	i32.ge_u	$push7=, $pop65, $13
	br_if   	0, $pop7
	i32.const	$push8=, 12
	i32.mul 	$push9=, $10, $pop8
	i32.add 	$push10=, $0, $pop9
	i32.const	$push11=, 8192
	i32.add 	$1=, $pop10, $pop11
	block   	
	br_if   	0, $10
	i32.const	$push12=, 8196
	i32.add 	$push71=, $0, $pop12
	tee_local	$push70=, $13=, $pop71
	i32.load	$push13=, 0($pop70)
	br_if   	0, $pop13
	i32.const	$push14=, 8192
	i32.store	0($1), $pop14
	i32.store	0($13), $0
.LBB49_7:
	end_block
	i32.const	$push72=, 4
	i32.add 	$10=, $2, $pop72
.LBB49_8:
	loop    	
	block   	
	i32.load	$push74=, 8($1)
	tee_local	$push73=, $13=, $pop74
	i32.add 	$push15=, $pop73, $10
	i32.load	$push16=, 0($1)
	i32.gt_u	$push17=, $pop15, $pop16
	br_if   	0, $pop17
	i32.load	$push18=, 4($1)
	i32.add 	$push84=, $pop18, $13
	tee_local	$push83=, $13=, $pop84
	i32.load	$push19=, 0($13)
	i32.const	$push82=, -2147483648
	i32.and 	$push20=, $pop19, $pop82
	i32.or  	$push21=, $pop20, $2
	i32.store	0($pop83), $pop21
	i32.const	$push81=, 8
	i32.add 	$push80=, $1, $pop81
	tee_local	$push79=, $1=, $pop80
	i32.load	$push22=, 0($1)
	i32.add 	$push23=, $pop22, $10
	i32.store	0($pop79), $pop23
	i32.load	$push24=, 0($13)
	i32.const	$push78=, -2147483648
	i32.or  	$push25=, $pop24, $pop78
	i32.store	0($13), $pop25
	i32.const	$push77=, 4
	i32.add 	$push76=, $13, $pop77
	tee_local	$push75=, $1=, $pop76
	br_if   	3, $pop75
.LBB49_10:
	end_block
	i32.call	$push86=, _ZN5eosio14memory_manager16next_active_heapEv@FUNCTION, $0
	tee_local	$push85=, $1=, $pop86
	br_if   	0, $pop85
.LBB49_11:
	end_loop
	end_block
	i32.const	$push26=, 2147483644
	i32.sub 	$4=, $pop26, $2
	i32.const	$push55=, 8392
	i32.add 	$11=, $0, $pop55
	i32.const	$push57=, 8384
	i32.add 	$12=, $0, $pop57
	i32.load	$push88=, 8392($0)
	tee_local	$push87=, $3=, $pop88
	copy_local	$13=, $pop87
.LBB49_12:
	loop    	
	i32.const	$push100=, 12
	i32.mul 	$push27=, $13, $pop100
	i32.add 	$push99=, $0, $pop27
	tee_local	$push98=, $1=, $pop99
	i32.const	$push97=, 8200
	i32.add 	$push29=, $pop98, $pop97
	i32.load	$push30=, 0($pop29)
	i32.const	$push96=, 8192
	i32.add 	$push95=, $1, $pop96
	tee_local	$push94=, $5=, $pop95
	i32.load	$push28=, 0($pop94)
	i32.eq  	$push31=, $pop30, $pop28
	i32.const	$push93=, .L.str.1.11
	call    	eosio_assert@FUNCTION, $pop31, $pop93
	i32.const	$push92=, 8196
	i32.add 	$push32=, $1, $pop92
	i32.load	$push91=, 0($pop32)
	tee_local	$push90=, $6=, $pop91
	i32.const	$push89=, 4
	i32.add 	$13=, $pop90, $pop89
.LBB49_13:
	loop    	
	i32.load	$push33=, 0($5)
	i32.add 	$7=, $6, $pop33
	i32.const	$push107=, -4
	i32.add 	$push106=, $13, $pop107
	tee_local	$push105=, $8=, $pop106
	i32.load	$push104=, 0($pop105)
	tee_local	$push103=, $9=, $pop104
	i32.const	$push102=, 2147483647
	i32.and 	$1=, $pop103, $pop102
	block   	
	i32.const	$push101=, 0
	i32.lt_s	$push34=, $9, $pop101
	br_if   	0, $pop34
	block   	
	i32.ge_u	$push35=, $1, $2
	br_if   	0, $pop35
.LBB49_15:
	loop    	
	i32.add 	$push109=, $13, $1
	tee_local	$push108=, $10=, $pop109
	i32.ge_u	$push36=, $pop108, $7
	br_if   	1, $pop36
	i32.load	$push112=, 0($10)
	tee_local	$push111=, $10=, $pop112
	i32.const	$push110=, 0
	i32.lt_s	$push37=, $pop111, $pop110
	br_if   	1, $pop37
	i32.const	$push116=, 2147483647
	i32.and 	$push38=, $10, $pop116
	i32.add 	$push39=, $1, $pop38
	i32.const	$push115=, 4
	i32.add 	$push114=, $pop39, $pop115
	tee_local	$push113=, $1=, $pop114
	i32.lt_u	$push40=, $pop113, $2
	br_if   	0, $pop40
.LBB49_18:
	end_loop
	end_block
	i32.lt_u	$push41=, $1, $2
	i32.select	$push42=, $1, $2, $pop41
	i32.const	$push117=, -2147483648
	i32.and 	$push43=, $9, $pop117
	i32.or  	$push44=, $pop42, $pop43
	i32.store	0($8), $pop44
	block   	
	i32.le_u	$push45=, $1, $2
	br_if   	0, $pop45
	i32.add 	$push46=, $13, $2
	i32.add 	$push47=, $4, $1
	i32.const	$push118=, 2147483647
	i32.and 	$push48=, $pop47, $pop118
	i32.store	0($pop46), $pop48
.LBB49_20:
	end_block
	i32.ge_u	$push49=, $1, $2
	br_if   	4, $pop49
.LBB49_21:
	end_block
	i32.add 	$push53=, $13, $1
	i32.const	$push121=, 4
	i32.add 	$push120=, $pop53, $pop121
	tee_local	$push119=, $13=, $pop120
	i32.lt_u	$push54=, $pop119, $7
	br_if   	0, $pop54
	end_loop
	i32.const	$1=, 0
	i32.const	$push127=, 0
	i32.load	$push56=, 0($11)
	i32.const	$push126=, 1
	i32.add 	$push125=, $pop56, $pop126
	tee_local	$push124=, $13=, $pop125
	i32.load	$push58=, 0($12)
	i32.eq  	$push59=, $13, $pop58
	i32.select	$push123=, $pop127, $pop124, $pop59
	tee_local	$push122=, $13=, $pop123
	i32.store	0($11), $pop122
	i32.ne  	$push60=, $13, $3
	br_if   	0, $pop60
.LBB49_23:
	end_loop
	end_block
	return  	$1
.LBB49_24:
	end_block
	i32.load	$push50=, 0($8)
	i32.const	$push51=, -2147483648
	i32.or  	$push52=, $pop50, $pop51
	i32.store	0($8), $pop52
	return  	$13
.LBB49_25:
	end_block
	i32.const	$push61=, 0
	.endfunc
.Lfunc_end49:
	.size	_ZN5eosio14memory_manager6mallocEm, .Lfunc_end49-_ZN5eosio14memory_manager6mallocEm

	.section	.text._ZN5eosio14memory_manager16next_active_heapEv,"axG",@progbits,_ZN5eosio14memory_manager16next_active_heapEv,comdat
	.hidden	_ZN5eosio14memory_manager16next_active_heapEv
	.weak	_ZN5eosio14memory_manager16next_active_heapEv
	.type	_ZN5eosio14memory_manager16next_active_heapEv,@function
_ZN5eosio14memory_manager16next_active_heapEv:
	.param  	i32
	.result 	i32
	.local  	i32, i32, i32, i32, i32, i32, i32, i32
	i32.load	$1=, 8388($0)
	block   	
	block   	
	i32.const	$push94=, 0
	i32.load8_u	$push2=, _ZZ4sbrkjE11initialized($pop94)
	i32.eqz 	$push157=, $pop2
	br_if   	0, $pop157
	i32.const	$push95=, 0
	i32.load	$7=, _ZZ4sbrkjE10sbrk_bytes($pop95)
	br      	1
.LBB50_2:
	end_block
	current_memory	$7=
	i32.const	$push99=, 0
	i32.const	$push3=, 1
	i32.store8	_ZZ4sbrkjE11initialized($pop99), $pop3
	i32.const	$push98=, 0
	i32.const	$push4=, 16
	i32.shl 	$push97=, $7, $pop4
	tee_local	$push96=, $7=, $pop97
	i32.store	_ZZ4sbrkjE10sbrk_bytes($pop98), $pop96
.LBB50_3:
	end_block
	copy_local	$3=, $7
	block   	
	block   	
	block   	
	block   	
	i32.const	$push5=, 65535
	i32.add 	$push6=, $7, $pop5
	i32.const	$push7=, 16
	i32.shr_u	$push103=, $pop6, $pop7
	tee_local	$push102=, $2=, $pop103
	current_memory	$push101=
	tee_local	$push100=, $8=, $pop101
	i32.le_u	$push8=, $pop102, $pop100
	br_if   	0, $pop8
	i32.sub 	$push9=, $2, $8
	grow_memory	$pop9
	i32.const	$8=, 0
	current_memory	$push10=
	i32.ne  	$push11=, $2, $pop10
	br_if   	1, $pop11
	i32.const	$push12=, 0
	i32.load	$3=, _ZZ4sbrkjE10sbrk_bytes($pop12)
.LBB50_6:
	end_block
	i32.const	$8=, 0
	i32.const	$push105=, 0
	i32.store	_ZZ4sbrkjE10sbrk_bytes($pop105), $3
	i32.const	$push104=, 0
	i32.lt_s	$push13=, $7, $pop104
	br_if   	0, $pop13
	i32.const	$push0=, 12
	i32.mul 	$push1=, $1, $pop0
	i32.add 	$2=, $0, $pop1
	i32.const	$push20=, 65536
	i32.const	$push19=, 131072
	i32.const	$push16=, 65535
	i32.and 	$push110=, $7, $pop16
	tee_local	$push109=, $8=, $pop110
	i32.const	$push17=, 64513
	i32.lt_u	$push108=, $pop109, $pop17
	tee_local	$push107=, $6=, $pop108
	i32.select	$push21=, $pop20, $pop19, $pop107
	i32.add 	$push22=, $7, $pop21
	i32.const	$push14=, 131071
	i32.and 	$push15=, $7, $pop14
	i32.select	$push18=, $8, $pop15, $6
	i32.sub 	$push23=, $pop22, $pop18
	i32.sub 	$7=, $pop23, $7
	block   	
	i32.const	$push106=, 0
	i32.load8_u	$push24=, _ZZ4sbrkjE11initialized($pop106)
	br_if   	0, $pop24
	current_memory	$3=
	i32.const	$push114=, 0
	i32.const	$push25=, 1
	i32.store8	_ZZ4sbrkjE11initialized($pop114), $pop25
	i32.const	$push113=, 0
	i32.const	$push26=, 16
	i32.shl 	$push112=, $3, $pop26
	tee_local	$push111=, $3=, $pop112
	i32.store	_ZZ4sbrkjE10sbrk_bytes($pop113), $pop111
.LBB50_9:
	end_block
	i32.const	$push116=, 8192
	i32.add 	$2=, $2, $pop116
	i32.const	$push115=, 0
	i32.lt_s	$push27=, $7, $pop115
	br_if   	1, $pop27
	copy_local	$6=, $3
	block   	
	i32.const	$push28=, 7
	i32.add 	$push29=, $7, $pop28
	i32.const	$push30=, -8
	i32.and 	$push122=, $pop29, $pop30
	tee_local	$push121=, $5=, $pop122
	i32.add 	$push31=, $pop121, $3
	i32.const	$push32=, 65535
	i32.add 	$push33=, $pop31, $pop32
	i32.const	$push34=, 16
	i32.shr_u	$push120=, $pop33, $pop34
	tee_local	$push119=, $8=, $pop120
	current_memory	$push118=
	tee_local	$push117=, $4=, $pop118
	i32.le_u	$push35=, $pop119, $pop117
	br_if   	0, $pop35
	i32.sub 	$push36=, $8, $4
	grow_memory	$pop36
	current_memory	$push37=
	i32.ne  	$push38=, $8, $pop37
	br_if   	2, $pop38
	i32.const	$push39=, 0
	i32.load	$6=, _ZZ4sbrkjE10sbrk_bytes($pop39)
.LBB50_13:
	end_block
	i32.const	$push41=, 0
	i32.add 	$push40=, $6, $5
	i32.store	_ZZ4sbrkjE10sbrk_bytes($pop41), $pop40
	i32.const	$push42=, -1
	i32.eq  	$push43=, $3, $pop42
	br_if   	1, $pop43
	i32.const	$push44=, 12
	i32.mul 	$push45=, $1, $pop44
	i32.add 	$push128=, $0, $pop45
	tee_local	$push127=, $1=, $pop128
	i32.const	$push46=, 8196
	i32.add 	$push47=, $pop127, $pop46
	i32.load	$push126=, 0($pop47)
	tee_local	$push125=, $6=, $pop126
	i32.load	$push124=, 0($2)
	tee_local	$push123=, $8=, $pop124
	i32.add 	$push48=, $pop125, $pop123
	i32.eq  	$push49=, $pop48, $3
	br_if   	2, $pop49
	block   	
	i32.const	$push50=, 8200
	i32.add 	$push132=, $1, $pop50
	tee_local	$push131=, $5=, $pop132
	i32.load	$push130=, 0($pop131)
	tee_local	$push129=, $1=, $pop130
	i32.eq  	$push51=, $8, $pop129
	br_if   	0, $pop51
	i32.add 	$push134=, $6, $1
	tee_local	$push133=, $6=, $pop134
	i32.load	$push55=, 0($6)
	i32.const	$push56=, -2147483648
	i32.and 	$push57=, $pop55, $pop56
	i32.const	$push52=, -4
	i32.sub 	$push53=, $pop52, $1
	i32.add 	$push54=, $pop53, $8
	i32.or  	$push58=, $pop57, $pop54
	i32.store	0($pop133), $pop58
	i32.load	$push59=, 0($2)
	i32.store	0($5), $pop59
	i32.load	$push60=, 0($6)
	i32.const	$push61=, 2147483647
	i32.and 	$push62=, $pop60, $pop61
	i32.store	0($6), $pop62
.LBB50_17:
	end_block
	i32.const	$push63=, 8388
	i32.add 	$push142=, $0, $pop63
	tee_local	$push141=, $2=, $pop142
	i32.load	$push64=, 0($2)
	i32.const	$push65=, 1
	i32.add 	$push140=, $pop64, $pop65
	tee_local	$push139=, $2=, $pop140
	i32.store	0($pop141), $pop139
	i32.const	$push66=, 12
	i32.mul 	$push67=, $2, $pop66
	i32.add 	$push138=, $0, $pop67
	tee_local	$push137=, $0=, $pop138
	i32.const	$push68=, 8196
	i32.add 	$push69=, $pop137, $pop68
	i32.store	0($pop69), $3
	i32.const	$push70=, 8192
	i32.add 	$push136=, $0, $pop70
	tee_local	$push135=, $8=, $pop136
	i32.store	0($pop135), $7
.LBB50_18:
	end_block
	return  	$8
.LBB50_19:
	end_block
	block   	
	i32.load	$push150=, 0($2)
	tee_local	$push149=, $8=, $pop150
	i32.const	$push72=, 12
	i32.mul 	$push73=, $1, $pop72
	i32.add 	$push148=, $0, $pop73
	tee_local	$push147=, $3=, $pop148
	i32.const	$push74=, 8200
	i32.add 	$push146=, $pop147, $pop74
	tee_local	$push145=, $1=, $pop146
	i32.load	$push144=, 0($pop145)
	tee_local	$push143=, $7=, $pop144
	i32.eq  	$push75=, $pop149, $pop143
	br_if   	0, $pop75
	i32.const	$push79=, 8196
	i32.add 	$push80=, $3, $pop79
	i32.load	$push81=, 0($pop80)
	i32.add 	$push152=, $pop81, $7
	tee_local	$push151=, $3=, $pop152
	i32.load	$push82=, 0($3)
	i32.const	$push83=, -2147483648
	i32.and 	$push84=, $pop82, $pop83
	i32.const	$push76=, -4
	i32.sub 	$push77=, $pop76, $7
	i32.add 	$push78=, $pop77, $8
	i32.or  	$push85=, $pop84, $pop78
	i32.store	0($pop151), $pop85
	i32.load	$push86=, 0($2)
	i32.store	0($1), $pop86
	i32.load	$push87=, 0($3)
	i32.const	$push88=, 2147483647
	i32.and 	$push89=, $pop87, $pop88
	i32.store	0($3), $pop89
.LBB50_21:
	end_block
	i32.const	$push90=, 8388
	i32.add 	$push156=, $0, $pop90
	tee_local	$push155=, $7=, $pop156
	i32.load	$push91=, 0($pop155)
	i32.const	$push92=, 1
	i32.add 	$push154=, $pop91, $pop92
	tee_local	$push153=, $3=, $pop154
	i32.store	8384($0), $pop153
	i32.store	0($7), $3
	i32.const	$push93=, 0
	return  	$pop93
.LBB50_22:
	end_block
	i32.add 	$push71=, $8, $7
	i32.store	0($2), $pop71
	copy_local	$push158=, $2
	.endfunc
.Lfunc_end50:
	.size	_ZN5eosio14memory_manager16next_active_heapEv, .Lfunc_end50-_ZN5eosio14memory_manager16next_active_heapEv

	.text
	.hidden	free
	.globl	free
	.type	free,@function
free:
	.param  	i32
	.local  	i32, i32, i32
	block   	
	block   	
	i32.eqz 	$push28=, $0
	br_if   	0, $pop28
	i32.const	$push0=, 0
	i32.load	$push16=, _ZN5eosio11memory_heapE+8384($pop0)
	tee_local	$push15=, $2=, $pop16
	i32.const	$push1=, 1
	i32.lt_s	$push2=, $pop15, $pop1
	br_if   	0, $pop2
	i32.const	$3=, _ZN5eosio11memory_heapE+8192
	i32.const	$push18=, 12
	i32.mul 	$push3=, $2, $pop18
	i32.const	$push17=, _ZN5eosio11memory_heapE+8192
	i32.add 	$1=, $pop3, $pop17
.LBB51_3:
	loop    	
	i32.const	$push21=, 4
	i32.add 	$push4=, $3, $pop21
	i32.load	$push20=, 0($pop4)
	tee_local	$push19=, $2=, $pop20
	i32.eqz 	$push29=, $pop19
	br_if   	1, $pop29
	block   	
	i32.const	$push22=, 4
	i32.add 	$push5=, $2, $pop22
	i32.gt_u	$push6=, $pop5, $0
	br_if   	0, $pop6
	i32.load	$push7=, 0($3)
	i32.add 	$push8=, $2, $pop7
	i32.gt_u	$push9=, $pop8, $0
	br_if   	3, $pop9
.LBB51_6:
	end_block
	i32.const	$push25=, 12
	i32.add 	$push24=, $3, $pop25
	tee_local	$push23=, $3=, $pop24
	i32.lt_u	$push14=, $pop23, $1
	br_if   	0, $pop14
.LBB51_7:
	end_loop
	end_block
	return
.LBB51_8:
	end_block
	i32.const	$push10=, -4
	i32.add 	$push27=, $0, $pop10
	tee_local	$push26=, $3=, $pop27
	i32.load	$push11=, 0($3)
	i32.const	$push12=, 2147483647
	i32.and 	$push13=, $pop11, $pop12
	i32.store	0($pop26), $pop13
	.endfunc
.Lfunc_end51:
	.size	free, .Lfunc_end51-free

	.type	.L.str.11,@object
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.11:
	.asciz	"write"
	.size	.L.str.11, 6

	.type	.L.str.12,@object
.L.str.12:
	.asciz	"read"
	.size	.L.str.12, 5

	.type	.L.str,@object
.L.str:
	.asciz	"transaction expired"
	.size	.L.str, 20

	.type	.L.str.14,@object
.L.str.14:
	.asciz	"object passed to iterator_to is not in multi_index"
	.size	.L.str.14, 51

	.type	.L.str.1,@object
.L.str.1:
	.asciz	"proposal with the same name exists"
	.size	.L.str.1, 35

	.type	.L.str.2,@object
.L.str.2:
	.asciz	"transaction authorization failed"
	.size	.L.str.2, 33

	.type	.L.str.16,@object
.L.str.16:
	.asciz	"cannot create objects in table of another contract"
	.size	.L.str.16, 51

	.type	.L.str.15,@object
.L.str.15:
	.asciz	"error reading iterator"
	.size	.L.str.15, 23

	.type	.L.str.13,@object
.L.str.13:
	.asciz	"get"
	.size	.L.str.13, 4

	.type	.L.str.3,@object
.L.str.3:
	.asciz	"proposal not found"
	.size	.L.str.3, 19

	.type	.L.str.4,@object
.L.str.4:
	.asciz	"approval is not on the list of requested approvals"
	.size	.L.str.4, 51

	.type	.L.str.17,@object
.L.str.17:
	.asciz	"object passed to modify is not in multi_index"
	.size	.L.str.17, 46

	.type	.L.str.18,@object
.L.str.18:
	.asciz	"cannot modify objects in table of another contract"
	.size	.L.str.18, 51

	.type	.L.str.19,@object
.L.str.19:
	.asciz	"updater cannot change primary key when modifying an object"
	.size	.L.str.19, 59

	.type	.L.str.5,@object
.L.str.5:
	.asciz	"no approval previously granted"
	.size	.L.str.5, 31

	.type	.L.str.6,@object
.L.str.6:
	.asciz	"cannot cancel until expiration"
	.size	.L.str.6, 31

	.type	.L.str.20,@object
.L.str.20:
	.asciz	"object passed to erase is not in multi_index"
	.size	.L.str.20, 45

	.type	.L.str.21,@object
.L.str.21:
	.asciz	"cannot erase objects in table of another contract"
	.size	.L.str.21, 50

	.type	.L.str.22,@object
.L.str.22:
	.asciz	"attempt to remove object that was not in multi_index"
	.size	.L.str.22, 53

	.type	.L.str.7,@object
.L.str.7:
	.asciz	"onerror"
	.size	.L.str.7, 8

	.type	.L.str.8,@object
.L.str.8:
	.asciz	"eosio"
	.size	.L.str.8, 6

	.type	.L.str.9,@object
.L.str.9:
	.asciz	"onerror action's are only valid from the \"eosio\" system account"
	.size	.L.str.9, 64

	.type	_ZStL13__new_handler,@object
	.lcomm	_ZStL13__new_handler,4,2
	.hidden	_ZN5eosio11memory_heapE
	.type	_ZN5eosio11memory_heapE,@object
	.bss
	.globl	_ZN5eosio11memory_heapE
	.p2align	2
_ZN5eosio11memory_heapE:
	.skip	8396
	.size	_ZN5eosio11memory_heapE, 8396

	.type	.L.str.1.11,@object
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.1.11:
	.asciz	"malloc_from_freed was designed to only be called after _heap was completely allocated"
	.size	.L.str.1.11, 86

	.type	_ZZ4sbrkjE11initialized,@object
	.lcomm	_ZZ4sbrkjE11initialized,1
	.type	_ZZ4sbrkjE10sbrk_bytes,@object
	.lcomm	_ZZ4sbrkjE10sbrk_bytes,4,2

	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.functype	current_time, i64
	.functype	require_auth2, void, i64, i64
	.functype	check_transaction_authorization, i32, i32, i32, i32, i32, i32, i32
	.functype	eosio_assert, void, i32, i32
	.functype	memcpy, i32, i32, i32, i32
	.functype	check_permission_authorization, i32, i64, i64, i32, i32, i32, i32, i64
	.functype	action_data_size, i32
	.functype	read_action_data, i32, i32, i32
	.functype	require_auth, void, i64
	.functype	db_find_i64, i32, i64, i64, i64, i64
	.functype	current_receiver, i64
	.functype	db_store_i64, i32, i64, i64, i64, i64, i32, i32
	.functype	db_get_i64, i32, i32, i32, i32
	.functype	abort, void
	.functype	memmove, i32, i32, i32, i32
	.functype	db_update_i64, void, i32, i64, i32, i32
	.functype	db_remove_i64, void, i32
	.functype	send_deferred, void, i32, i64, i32, i32, i32
