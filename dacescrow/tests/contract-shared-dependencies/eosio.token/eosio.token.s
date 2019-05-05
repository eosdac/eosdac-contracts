	.text
	.file	"eosio.token.bc"
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

	.hidden	_ZN5eosio5token6createEyNS_5assetE
	.globl	_ZN5eosio5token6createEyNS_5assetE
	.type	_ZN5eosio5token6createEyNS_5assetE,@function
_ZN5eosio5token6createEyNS_5assetE:
	.param  	i32, i64, i32
	.local  	i64, i64, i64, i32, i64, i32, i32
	i32.const	$push92=, 0
	i32.const	$push89=, 0
	i32.load	$push90=, __stack_pointer($pop89)
	i32.const	$push91=, 128
	i32.sub 	$push136=, $pop90, $pop91
	tee_local	$push135=, $9=, $pop136
	i32.store	__stack_pointer($pop92), $pop135
	i64.load	$push0=, 0($0)
	call    	require_auth@FUNCTION, $pop0
	i32.const	$8=, 0
	i64.load	$push134=, 8($2)
	tee_local	$push133=, $3=, $pop134
	i64.const	$push132=, 8
	i64.shr_u	$push131=, $pop133, $pop132
	tee_local	$push130=, $4=, $pop131
	copy_local	$7=, $pop130
.LBB5_1:
	block   	
	block   	
	loop    	
	i32.wrap/i64	$push1=, $7
	i32.const	$push139=, 24
	i32.shl 	$push2=, $pop1, $pop139
	i32.const	$push138=, -1073741825
	i32.add 	$push3=, $pop2, $pop138
	i32.const	$push137=, 452984830
	i32.gt_u	$push4=, $pop3, $pop137
	br_if   	1, $pop4
	block   	
	i64.const	$push144=, 8
	i64.shr_u	$push143=, $7, $pop144
	tee_local	$push142=, $7=, $pop143
	i64.const	$push141=, 255
	i64.and 	$push5=, $pop142, $pop141
	i64.const	$push140=, 0
	i64.ne  	$push6=, $pop5, $pop140
	br_if   	0, $pop6
.LBB5_3:
	loop    	
	i64.const	$push149=, 8
	i64.shr_u	$push148=, $7, $pop149
	tee_local	$push147=, $7=, $pop148
	i64.const	$push146=, 255
	i64.and 	$push7=, $pop147, $pop146
	i64.const	$push145=, 0
	i64.ne  	$push8=, $pop7, $pop145
	br_if   	3, $pop8
	i32.const	$push153=, 1
	i32.add 	$push152=, $8, $pop153
	tee_local	$push151=, $8=, $pop152
	i32.const	$push150=, 7
	i32.lt_s	$push9=, $pop151, $pop150
	br_if   	0, $pop9
.LBB5_5:
	end_loop
	end_block
	i32.const	$6=, 1
	i32.const	$push157=, 1
	i32.add 	$push156=, $8, $pop157
	tee_local	$push155=, $8=, $pop156
	i32.const	$push154=, 7
	i32.lt_s	$push10=, $pop155, $pop154
	br_if   	0, $pop10
	br      	2
.LBB5_6:
	end_loop
	end_block
	i32.const	$6=, 0
.LBB5_7:
	end_block
	i32.const	$push11=, .L.str
	call    	eosio_assert@FUNCTION, $6, $pop11
	i32.const	$6=, 0
	block   	
	i64.load	$push159=, 0($2)
	tee_local	$push158=, $5=, $pop159
	i64.const	$push12=, 4611686018427387903
	i64.add 	$push13=, $pop158, $pop12
	i64.const	$push14=, 9223372036854775806
	i64.gt_u	$push15=, $pop13, $pop14
	br_if   	0, $pop15
	i32.const	$8=, 0
	copy_local	$7=, $4
.LBB5_9:
	block   	
	loop    	
	i32.wrap/i64	$push16=, $7
	i32.const	$push162=, 24
	i32.shl 	$push17=, $pop16, $pop162
	i32.const	$push161=, -1073741825
	i32.add 	$push18=, $pop17, $pop161
	i32.const	$push160=, 452984830
	i32.gt_u	$push19=, $pop18, $pop160
	br_if   	1, $pop19
	block   	
	i64.const	$push167=, 8
	i64.shr_u	$push166=, $7, $pop167
	tee_local	$push165=, $7=, $pop166
	i64.const	$push164=, 255
	i64.and 	$push20=, $pop165, $pop164
	i64.const	$push163=, 0
	i64.ne  	$push21=, $pop20, $pop163
	br_if   	0, $pop21
.LBB5_11:
	loop    	
	i64.const	$push172=, 8
	i64.shr_u	$push171=, $7, $pop172
	tee_local	$push170=, $7=, $pop171
	i64.const	$push169=, 255
	i64.and 	$push22=, $pop170, $pop169
	i64.const	$push168=, 0
	i64.ne  	$push23=, $pop22, $pop168
	br_if   	3, $pop23
	i32.const	$push176=, 1
	i32.add 	$push175=, $8, $pop176
	tee_local	$push174=, $8=, $pop175
	i32.const	$push173=, 7
	i32.lt_s	$push24=, $pop174, $pop173
	br_if   	0, $pop24
.LBB5_13:
	end_loop
	end_block
	i32.const	$6=, 1
	i32.const	$push180=, 1
	i32.add 	$push179=, $8, $pop180
	tee_local	$push178=, $8=, $pop179
	i32.const	$push177=, 7
	i32.lt_s	$push25=, $pop178, $pop177
	br_if   	0, $pop25
	br      	2
.LBB5_14:
	end_loop
	end_block
	i32.const	$6=, 0
.LBB5_15:
	end_block
	i32.const	$push26=, .L.str.1
	call    	eosio_assert@FUNCTION, $6, $pop26
	i64.const	$push27=, 0
	i64.gt_s	$push28=, $5, $pop27
	i32.const	$push29=, .L.str.2
	call    	eosio_assert@FUNCTION, $pop28, $pop29
	i32.const	$push96=, 8
	i32.add 	$push97=, $9, $pop96
	i32.const	$push189=, 32
	i32.add 	$push30=, $pop97, $pop189
	i32.const	$push188=, 0
	i32.store	0($pop30), $pop188
	i64.const	$push31=, -1
	i64.store	24($9), $pop31
	i64.const	$push187=, 0
	i64.store	32($9), $pop187
	i64.load	$push186=, 0($0)
	tee_local	$push185=, $7=, $pop186
	i64.store	8($9), $pop185
	i64.store	16($9), $4
	block   	
	block   	
	i64.const	$push184=, -4157508551318700032
	i32.call	$push183=, db_find_i64@FUNCTION, $7, $4, $pop184, $4
	tee_local	$push182=, $8=, $pop183
	i32.const	$push181=, 0
	i32.lt_s	$push32=, $pop182, $pop181
	br_if   	0, $pop32
	i32.const	$push126=, 8
	i32.add 	$push127=, $9, $pop126
	i32.call	$push33=, _ZNK5eosio11multi_indexILy14289235522390851584ENS_5token14currency_statsEJEE31load_object_by_primary_iteratorEl@FUNCTION, $pop127, $8
	i32.load	$push34=, 40($pop33)
	i32.const	$push128=, 8
	i32.add 	$push129=, $9, $pop128
	i32.eq  	$push35=, $pop34, $pop129
	i32.const	$push36=, .L.str.20
	call    	eosio_assert@FUNCTION, $pop35, $pop36
	i32.const	$8=, 0
	br      	1
.LBB5_17:
	end_block
	i32.const	$8=, 1
.LBB5_18:
	end_block
	i32.const	$push37=, .L.str.3
	call    	eosio_assert@FUNCTION, $8, $pop37
	i64.load	$4=, 0($0)
	i64.load	$push38=, 8($9)
	i64.call	$push39=, current_receiver@FUNCTION
	i64.eq  	$push40=, $pop38, $pop39
	i32.const	$push41=, .L.str.26
	call    	eosio_assert@FUNCTION, $pop40, $pop41
	i32.const	$push42=, 56
	i32.call	$push205=, _Znwj@FUNCTION, $pop42
	tee_local	$push204=, $8=, $pop205
	i32.call	$drop=, _ZN5eosio5token14currency_statsC2Ev@FUNCTION, $pop204
	i32.const	$push98=, 8
	i32.add 	$push99=, $9, $pop98
	i32.store	40($8), $pop99
	i64.store	8($8), $3
	i32.const	$push203=, 28
	i32.add 	$push43=, $8, $pop203
	i32.const	$push44=, 12
	i32.add 	$push45=, $2, $pop44
	i32.load	$push46=, 0($pop45)
	i32.store	0($pop43), $pop46
	i32.const	$push47=, 24
	i32.add 	$push48=, $8, $pop47
	i32.const	$push202=, 8
	i32.add 	$push49=, $2, $pop202
	i32.load	$push50=, 0($pop49)
	i32.store	0($pop48), $pop50
	i32.const	$push51=, 20
	i32.add 	$push52=, $8, $pop51
	i32.const	$push53=, 4
	i32.add 	$push54=, $2, $pop53
	i32.load	$push55=, 0($pop54)
	i32.store	0($pop52), $pop55
	i32.load	$push56=, 0($2)
	i32.store	16($8), $pop56
	i64.store	32($8), $1
	i32.const	$push100=, 48
	i32.add 	$push101=, $9, $pop100
	i32.const	$push57=, 40
	i32.add 	$push58=, $pop101, $pop57
	i32.store	96($9), $pop58
	i32.const	$push102=, 48
	i32.add 	$push103=, $9, $pop102
	i32.store	92($9), $pop103
	i32.const	$push104=, 48
	i32.add 	$push105=, $9, $pop104
	i32.store	88($9), $pop105
	i32.const	$push106=, 88
	i32.add 	$push107=, $9, $pop106
	i32.store	104($9), $pop107
	i32.const	$push59=, 16
	i32.add 	$push60=, $8, $pop59
	i32.store	116($9), $pop60
	i32.store	112($9), $8
	i32.const	$push201=, 32
	i32.add 	$push61=, $8, $pop201
	i32.store	120($9), $pop61
	i32.const	$push108=, 112
	i32.add 	$push109=, $9, $pop108
	i32.const	$push110=, 104
	i32.add 	$push111=, $9, $pop110
	call    	_ZN5boost3pfr6detail19for_each_field_implINS1_14sequence_tuple5tupleIJRKN5eosio5assetES8_RKyEEEZNS5_lsINS5_10datastreamIPcEENS5_5token14currency_statsELPv0EEERT_SK_RKT0_EUlRKSJ_E_JLj0ELj1ELj2EEEEvSK_OSL_NSt3__116integer_sequenceIjJXspT1_EEEENSS_17integral_constantIbLb0EEE@FUNCTION, $pop109, $pop111
	i32.const	$push112=, 8
	i32.add 	$push113=, $9, $pop112
	i32.const	$push200=, 8
	i32.add 	$push63=, $pop113, $pop200
	i64.load	$push64=, 0($pop63)
	i64.const	$push199=, -4157508551318700032
	i64.load	$push62=, 8($8)
	i64.const	$push198=, 8
	i64.shr_u	$push197=, $pop62, $pop198
	tee_local	$push196=, $7=, $pop197
	i32.const	$push114=, 48
	i32.add 	$push115=, $9, $pop114
	i32.const	$push195=, 40
	i32.call	$push194=, db_store_i64@FUNCTION, $pop64, $pop199, $4, $pop196, $pop115, $pop195
	tee_local	$push193=, $6=, $pop194
	i32.store	44($8), $pop193
	block   	
	i32.const	$push116=, 8
	i32.add 	$push117=, $9, $pop116
	i32.const	$push192=, 16
	i32.add 	$push191=, $pop117, $pop192
	tee_local	$push190=, $2=, $pop191
	i64.load	$push65=, 0($pop190)
	i64.lt_u	$push66=, $7, $pop65
	br_if   	0, $pop66
	i64.const	$push67=, 1
	i64.add 	$push68=, $7, $pop67
	i64.store	0($2), $pop68
.LBB5_20:
	end_block
	i32.store	112($9), $8
	i32.const	$push212=, 8
	i32.add 	$push69=, $8, $pop212
	i64.load	$push70=, 0($pop69)
	i64.const	$push211=, 8
	i64.shr_u	$push210=, $pop70, $pop211
	tee_local	$push209=, $7=, $pop210
	i64.store	48($9), $pop209
	i32.store	88($9), $6
	block   	
	block   	
	i32.const	$push118=, 8
	i32.add 	$push119=, $9, $pop118
	i32.const	$push208=, 28
	i32.add 	$push74=, $pop119, $pop208
	i32.load	$push207=, 0($pop74)
	tee_local	$push206=, $2=, $pop207
	i32.const	$push71=, 40
	i32.add 	$push72=, $9, $pop71
	i32.load	$push73=, 0($pop72)
	i32.ge_u	$push75=, $pop206, $pop73
	br_if   	0, $pop75
	i64.store	8($2), $7
	i32.store	16($2), $6
	i32.const	$push78=, 0
	i32.store	112($9), $pop78
	i32.store	0($2), $8
	i32.const	$push81=, 36
	i32.add 	$push82=, $9, $pop81
	i32.const	$push79=, 24
	i32.add 	$push80=, $2, $pop79
	i32.store	0($pop82), $pop80
	br      	1
.LBB5_22:
	end_block
	i32.const	$push76=, 32
	i32.add 	$push77=, $9, $pop76
	i32.const	$push120=, 112
	i32.add 	$push121=, $9, $pop120
	i32.const	$push122=, 48
	i32.add 	$push123=, $9, $pop122
	i32.const	$push124=, 88
	i32.add 	$push125=, $9, $pop124
	call    	_ZNSt3__16vectorIN5eosio11multi_indexILy14289235522390851584ENS1_5token14currency_statsEJEE8item_ptrENS_9allocatorIS6_EEE24__emplace_back_slow_pathIJNS_10unique_ptrINS5_4itemENS_14default_deleteISC_EEEERyRlEEEvDpOT_@FUNCTION, $pop77, $pop121, $pop123, $pop125
.LBB5_23:
	end_block
	i32.load	$8=, 112($9)
	i32.const	$push83=, 0
	i32.store	112($9), $pop83
	block   	
	i32.eqz 	$push223=, $8
	br_if   	0, $pop223
	call    	_ZdlPv@FUNCTION, $8
.LBB5_25:
	end_block
	block   	
	i32.load	$push214=, 32($9)
	tee_local	$push213=, $6=, $pop214
	i32.eqz 	$push224=, $pop213
	br_if   	0, $pop224
	block   	
	block   	
	i32.const	$push84=, 36
	i32.add 	$push218=, $9, $pop84
	tee_local	$push217=, $0=, $pop218
	i32.load	$push216=, 0($pop217)
	tee_local	$push215=, $8=, $pop216
	i32.eq  	$push85=, $pop215, $6
	br_if   	0, $pop85
.LBB5_28:
	loop    	
	i32.const	$push222=, -24
	i32.add 	$push221=, $8, $pop222
	tee_local	$push220=, $8=, $pop221
	i32.load	$2=, 0($pop220)
	i32.const	$push219=, 0
	i32.store	0($8), $pop219
	block   	
	i32.eqz 	$push225=, $2
	br_if   	0, $pop225
	call    	_ZdlPv@FUNCTION, $2
.LBB5_30:
	end_block
	i32.ne  	$push86=, $6, $8
	br_if   	0, $pop86
	end_loop
	i32.const	$push87=, 32
	i32.add 	$push88=, $9, $pop87
	i32.load	$8=, 0($pop88)
	br      	1
.LBB5_32:
	end_block
	copy_local	$8=, $6
.LBB5_33:
	end_block
	i32.store	0($0), $6
	call    	_ZdlPv@FUNCTION, $8
.LBB5_34:
	end_block
	i32.const	$push95=, 0
	i32.const	$push93=, 128
	i32.add 	$push94=, $9, $pop93
	i32.store	__stack_pointer($pop95), $pop94
	.endfunc
.Lfunc_end5:
	.size	_ZN5eosio5token6createEyNS_5assetE, .Lfunc_end5-_ZN5eosio5token6createEyNS_5assetE

	.section	.text._ZNK5eosio11multi_indexILy14289235522390851584ENS_5token14currency_statsEJEE31load_object_by_primary_iteratorEl,"axG",@progbits,_ZNK5eosio11multi_indexILy14289235522390851584ENS_5token14currency_statsEJEE31load_object_by_primary_iteratorEl,comdat
	.hidden	_ZNK5eosio11multi_indexILy14289235522390851584ENS_5token14currency_statsEJEE31load_object_by_primary_iteratorEl
	.weak	_ZNK5eosio11multi_indexILy14289235522390851584ENS_5token14currency_statsEJEE31load_object_by_primary_iteratorEl
	.type	_ZNK5eosio11multi_indexILy14289235522390851584ENS_5token14currency_statsEJEE31load_object_by_primary_iteratorEl,@function
_ZNK5eosio11multi_indexILy14289235522390851584ENS_5token14currency_statsEJEE31load_object_by_primary_iteratorEl:
	.param  	i32, i32
	.result 	i32
	.local  	i32, i32, i32, i64, i32, i32, i32, i32
	i32.const	$push45=, 0
	i32.load	$push46=, __stack_pointer($pop45)
	i32.const	$push47=, 48
	i32.sub 	$push70=, $pop46, $pop47
	tee_local	$push69=, $9=, $pop70
	copy_local	$8=, $pop69
	i32.const	$push48=, 0
	i32.store	__stack_pointer($pop48), $9
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
.LBB6_2:
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
.LBB6_4:
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
.LBB6_6:
	end_block
	i32.const	$push14=, 0
	i32.const	$push79=, 0
	i32.call	$push78=, db_get_i64@FUNCTION, $1, $pop14, $pop79
	tee_local	$push77=, $6=, $pop78
	i32.const	$push15=, 31
	i32.shr_u	$push16=, $pop77, $pop15
	i32.const	$push17=, 1
	i32.xor 	$push18=, $pop16, $pop17
	i32.const	$push19=, .L.str.21
	call    	eosio_assert@FUNCTION, $pop18, $pop19
	block   	
	block   	
	i32.const	$push20=, 513
	i32.lt_u	$push21=, $6, $pop20
	br_if   	0, $pop21
	i32.call	$4=, malloc@FUNCTION, $6
	br      	1
.LBB6_8:
	end_block
	i32.const	$push44=, 0
	i32.const	$push22=, 15
	i32.add 	$push23=, $6, $pop22
	i32.const	$push24=, -16
	i32.and 	$push25=, $pop23, $pop24
	i32.sub 	$push81=, $9, $pop25
	tee_local	$push80=, $4=, $pop81
	copy_local	$push64=, $pop80
	i32.store	__stack_pointer($pop44), $pop64
.LBB6_9:
	end_block
	i32.call	$drop=, db_get_i64@FUNCTION, $1, $4, $6
	i32.store	12($8), $4
	i32.store	8($8), $4
	i32.add 	$push26=, $4, $6
	i32.store	16($8), $pop26
	block   	
	i32.const	$push27=, 513
	i32.lt_u	$push28=, $6, $pop27
	br_if   	0, $pop28
	call    	free@FUNCTION, $4
.LBB6_11:
	end_block
	i32.const	$push29=, 56
	i32.call	$push92=, _Znwj@FUNCTION, $pop29
	tee_local	$push91=, $6=, $pop92
	i32.call	$drop=, _ZN5eosio5token14currency_statsC2Ev@FUNCTION, $pop91
	i32.store	40($6), $0
	i32.const	$push52=, 8
	i32.add 	$push53=, $8, $pop52
	i32.store	24($8), $pop53
	i32.const	$push30=, 16
	i32.add 	$push31=, $6, $pop30
	i32.store	36($8), $pop31
	i32.store	32($8), $6
	i32.const	$push32=, 32
	i32.add 	$push33=, $6, $pop32
	i32.store	40($8), $pop33
	i32.const	$push54=, 32
	i32.add 	$push55=, $8, $pop54
	i32.const	$push56=, 24
	i32.add 	$push57=, $8, $pop56
	call    	_ZN5boost3pfr6detail19for_each_field_implINS1_14sequence_tuple5tupleIJRN5eosio5assetES7_RyEEEZNS5_rsINS5_10datastreamIPKcEENS5_5token14currency_statsELPv0EEERT_SJ_RT0_EUlSJ_E_JLj0ELj1ELj2EEEEvSJ_OSK_NSt3__116integer_sequenceIjJXspT1_EEEENSO_17integral_constantIbLb0EEE@FUNCTION, $pop55, $pop57
	i32.store	44($6), $1
	i32.store	24($8), $6
	i64.load	$push34=, 8($6)
	i64.const	$push35=, 8
	i64.shr_u	$push90=, $pop34, $pop35
	tee_local	$push89=, $5=, $pop90
	i64.store	32($8), $pop89
	i32.load	$push88=, 44($6)
	tee_local	$push87=, $7=, $pop88
	i32.store	4($8), $pop87
	block   	
	block   	
	i32.const	$push38=, 28
	i32.add 	$push86=, $0, $pop38
	tee_local	$push85=, $1=, $pop86
	i32.load	$push84=, 0($pop85)
	tee_local	$push83=, $4=, $pop84
	i32.const	$push82=, 32
	i32.add 	$push36=, $0, $pop82
	i32.load	$push37=, 0($pop36)
	i32.ge_u	$push39=, $pop83, $pop37
	br_if   	0, $pop39
	i64.store	8($4), $5
	i32.store	16($4), $7
	i32.const	$push40=, 0
	i32.store	24($8), $pop40
	i32.store	0($4), $6
	i32.const	$push41=, 24
	i32.add 	$push42=, $4, $pop41
	i32.store	0($1), $pop42
	br      	1
.LBB6_13:
	end_block
	i32.const	$push1=, 24
	i32.add 	$push0=, $0, $pop1
	i32.const	$push58=, 24
	i32.add 	$push59=, $8, $pop58
	i32.const	$push60=, 32
	i32.add 	$push61=, $8, $pop60
	i32.const	$push62=, 4
	i32.add 	$push63=, $8, $pop62
	call    	_ZNSt3__16vectorIN5eosio11multi_indexILy14289235522390851584ENS1_5token14currency_statsEJEE8item_ptrENS_9allocatorIS6_EEE24__emplace_back_slow_pathIJNS_10unique_ptrINS5_4itemENS_14default_deleteISC_EEEERyRlEEEvDpOT_@FUNCTION, $pop0, $pop59, $pop61, $pop63
.LBB6_14:
	end_block
	i32.load	$4=, 24($8)
	i32.const	$push43=, 0
	i32.store	24($8), $pop43
	i32.eqz 	$push93=, $4
	br_if   	0, $pop93
	call    	_ZdlPv@FUNCTION, $4
.LBB6_16:
	end_block
	i32.const	$push51=, 0
	i32.const	$push49=, 48
	i32.add 	$push50=, $8, $pop49
	i32.store	__stack_pointer($pop51), $pop50
	copy_local	$push94=, $6
	.endfunc
.Lfunc_end6:
	.size	_ZNK5eosio11multi_indexILy14289235522390851584ENS_5token14currency_statsEJEE31load_object_by_primary_iteratorEl, .Lfunc_end6-_ZNK5eosio11multi_indexILy14289235522390851584ENS_5token14currency_statsEJEE31load_object_by_primary_iteratorEl

	.section	.text._ZN5eosio5token14currency_statsC2Ev,"axG",@progbits,_ZN5eosio5token14currency_statsC2Ev,comdat
	.hidden	_ZN5eosio5token14currency_statsC2Ev
	.weak	_ZN5eosio5token14currency_statsC2Ev
	.type	_ZN5eosio5token14currency_statsC2Ev,@function
_ZN5eosio5token14currency_statsC2Ev:
	.param  	i32
	.result 	i32
	.local  	i64, i32, i32
	i64.const	$push0=, 1397703940
	i64.store	8($0), $pop0
	i64.const	$push30=, 0
	i64.store	0($0), $pop30
	i32.const	$push29=, 1
	i32.const	$push1=, .L.str.23
	call    	eosio_assert@FUNCTION, $pop29, $pop1
	i64.load	$push2=, 8($0)
	i64.const	$push28=, 8
	i64.shr_u	$1=, $pop2, $pop28
	i32.const	$2=, 0
.LBB7_1:
	block   	
	block   	
	loop    	
	i32.wrap/i64	$push3=, $1
	i32.const	$push33=, 24
	i32.shl 	$push4=, $pop3, $pop33
	i32.const	$push32=, -1073741825
	i32.add 	$push5=, $pop4, $pop32
	i32.const	$push31=, 452984830
	i32.gt_u	$push6=, $pop5, $pop31
	br_if   	1, $pop6
	block   	
	i64.const	$push38=, 8
	i64.shr_u	$push37=, $1, $pop38
	tee_local	$push36=, $1=, $pop37
	i64.const	$push35=, 255
	i64.and 	$push7=, $pop36, $pop35
	i64.const	$push34=, 0
	i64.ne  	$push8=, $pop7, $pop34
	br_if   	0, $pop8
.LBB7_3:
	loop    	
	i64.const	$push43=, 8
	i64.shr_u	$push42=, $1, $pop43
	tee_local	$push41=, $1=, $pop42
	i64.const	$push40=, 255
	i64.and 	$push9=, $pop41, $pop40
	i64.const	$push39=, 0
	i64.ne  	$push10=, $pop9, $pop39
	br_if   	3, $pop10
	i32.const	$push47=, 1
	i32.add 	$push46=, $2, $pop47
	tee_local	$push45=, $2=, $pop46
	i32.const	$push44=, 7
	i32.lt_s	$push11=, $pop45, $pop44
	br_if   	0, $pop11
.LBB7_5:
	end_loop
	end_block
	i32.const	$3=, 1
	i32.const	$push51=, 1
	i32.add 	$push50=, $2, $pop51
	tee_local	$push49=, $2=, $pop50
	i32.const	$push48=, 7
	i32.lt_s	$push12=, $pop49, $pop48
	br_if   	0, $pop12
	br      	2
.LBB7_6:
	end_loop
	end_block
	i32.const	$3=, 0
.LBB7_7:
	end_block
	i32.const	$push13=, .L.str
	call    	eosio_assert@FUNCTION, $3, $pop13
	i32.const	$push57=, 24
	i32.add 	$push56=, $0, $pop57
	tee_local	$push55=, $2=, $pop56
	i64.const	$push14=, 1397703940
	i64.store	0($pop55), $pop14
	i64.const	$push54=, 0
	i64.store	16($0), $pop54
	i32.const	$push53=, 1
	i32.const	$push15=, .L.str.23
	call    	eosio_assert@FUNCTION, $pop53, $pop15
	i64.load	$push16=, 0($2)
	i64.const	$push52=, 8
	i64.shr_u	$1=, $pop16, $pop52
	i32.const	$2=, 0
.LBB7_8:
	block   	
	block   	
	loop    	
	i32.wrap/i64	$push17=, $1
	i32.const	$push60=, 24
	i32.shl 	$push18=, $pop17, $pop60
	i32.const	$push59=, -1073741825
	i32.add 	$push19=, $pop18, $pop59
	i32.const	$push58=, 452984830
	i32.gt_u	$push20=, $pop19, $pop58
	br_if   	1, $pop20
	block   	
	i64.const	$push65=, 8
	i64.shr_u	$push64=, $1, $pop65
	tee_local	$push63=, $1=, $pop64
	i64.const	$push62=, 255
	i64.and 	$push21=, $pop63, $pop62
	i64.const	$push61=, 0
	i64.ne  	$push22=, $pop21, $pop61
	br_if   	0, $pop22
.LBB7_10:
	loop    	
	i64.const	$push70=, 8
	i64.shr_u	$push69=, $1, $pop70
	tee_local	$push68=, $1=, $pop69
	i64.const	$push67=, 255
	i64.and 	$push23=, $pop68, $pop67
	i64.const	$push66=, 0
	i64.ne  	$push24=, $pop23, $pop66
	br_if   	3, $pop24
	i32.const	$push74=, 1
	i32.add 	$push73=, $2, $pop74
	tee_local	$push72=, $2=, $pop73
	i32.const	$push71=, 7
	i32.lt_s	$push25=, $pop72, $pop71
	br_if   	0, $pop25
.LBB7_12:
	end_loop
	end_block
	i32.const	$3=, 1
	i32.const	$push78=, 1
	i32.add 	$push77=, $2, $pop78
	tee_local	$push76=, $2=, $pop77
	i32.const	$push75=, 7
	i32.lt_s	$push26=, $pop76, $pop75
	br_if   	0, $pop26
	br      	2
.LBB7_13:
	end_loop
	end_block
	i32.const	$3=, 0
.LBB7_14:
	end_block
	i32.const	$push27=, .L.str
	call    	eosio_assert@FUNCTION, $3, $pop27
	copy_local	$push79=, $0
	.endfunc
.Lfunc_end7:
	.size	_ZN5eosio5token14currency_statsC2Ev, .Lfunc_end7-_ZN5eosio5token14currency_statsC2Ev

	.section	.text._ZN5boost3pfr6detail19for_each_field_implINS1_14sequence_tuple5tupleIJRKN5eosio5assetES8_RKyEEEZNS5_lsINS5_10datastreamIPcEENS5_5token14currency_statsELPv0EEERT_SK_RKT0_EUlRKSJ_E_JLj0ELj1ELj2EEEEvSK_OSL_NSt3__116integer_sequenceIjJXspT1_EEEENSS_17integral_constantIbLb0EEE,"axG",@progbits,_ZN5boost3pfr6detail19for_each_field_implINS1_14sequence_tuple5tupleIJRKN5eosio5assetES8_RKyEEEZNS5_lsINS5_10datastreamIPcEENS5_5token14currency_statsELPv0EEERT_SK_RKT0_EUlRKSJ_E_JLj0ELj1ELj2EEEEvSK_OSL_NSt3__116integer_sequenceIjJXspT1_EEEENSS_17integral_constantIbLb0EEE,comdat
	.hidden	_ZN5boost3pfr6detail19for_each_field_implINS1_14sequence_tuple5tupleIJRKN5eosio5assetES8_RKyEEEZNS5_lsINS5_10datastreamIPcEENS5_5token14currency_statsELPv0EEERT_SK_RKT0_EUlRKSJ_E_JLj0ELj1ELj2EEEEvSK_OSL_NSt3__116integer_sequenceIjJXspT1_EEEENSS_17integral_constantIbLb0EEE
	.weak	_ZN5boost3pfr6detail19for_each_field_implINS1_14sequence_tuple5tupleIJRKN5eosio5assetES8_RKyEEEZNS5_lsINS5_10datastreamIPcEENS5_5token14currency_statsELPv0EEERT_SK_RKT0_EUlRKSJ_E_JLj0ELj1ELj2EEEEvSK_OSL_NSt3__116integer_sequenceIjJXspT1_EEEENSS_17integral_constantIbLb0EEE
	.type	_ZN5boost3pfr6detail19for_each_field_implINS1_14sequence_tuple5tupleIJRKN5eosio5assetES8_RKyEEEZNS5_lsINS5_10datastreamIPcEENS5_5token14currency_statsELPv0EEERT_SK_RKT0_EUlRKSJ_E_JLj0ELj1ELj2EEEEvSK_OSL_NSt3__116integer_sequenceIjJXspT1_EEEENSS_17integral_constantIbLb0EEE,@function
_ZN5boost3pfr6detail19for_each_field_implINS1_14sequence_tuple5tupleIJRKN5eosio5assetES8_RKyEEEZNS5_lsINS5_10datastreamIPcEENS5_5token14currency_statsELPv0EEERT_SK_RKT0_EUlRKSJ_E_JLj0ELj1ELj2EEEEvSK_OSL_NSt3__116integer_sequenceIjJXspT1_EEEENSS_17integral_constantIbLb0EEE:
	.param  	i32, i32
	.local  	i32, i32, i32
	i32.load	$3=, 0($0)
	i32.load	$push64=, 0($1)
	tee_local	$push63=, $2=, $pop64
	i32.load	$push1=, 8($pop63)
	i32.load	$push0=, 4($2)
	i32.sub 	$push2=, $pop1, $pop0
	i32.const	$push3=, 7
	i32.gt_s	$push4=, $pop2, $pop3
	i32.const	$push5=, .L.str.27
	call    	eosio_assert@FUNCTION, $pop4, $pop5
	i32.load	$push6=, 4($2)
	i32.const	$push7=, 8
	i32.call	$drop=, memcpy@FUNCTION, $pop6, $3, $pop7
	i32.load	$push8=, 4($2)
	i32.const	$push62=, 8
	i32.add 	$push61=, $pop8, $pop62
	tee_local	$push60=, $4=, $pop61
	i32.store	4($2), $pop60
	i32.load	$push9=, 8($2)
	i32.sub 	$push10=, $pop9, $4
	i32.const	$push59=, 7
	i32.gt_s	$push11=, $pop10, $pop59
	i32.const	$push58=, .L.str.27
	call    	eosio_assert@FUNCTION, $pop11, $pop58
	i32.load	$push13=, 4($2)
	i32.const	$push57=, 8
	i32.add 	$push12=, $3, $pop57
	i32.const	$push56=, 8
	i32.call	$drop=, memcpy@FUNCTION, $pop13, $pop12, $pop56
	i32.load	$push14=, 4($2)
	i32.const	$push55=, 8
	i32.add 	$push15=, $pop14, $pop55
	i32.store	4($2), $pop15
	i32.load	$3=, 4($0)
	i32.load	$push54=, 0($1)
	tee_local	$push53=, $2=, $pop54
	i32.load	$push17=, 8($pop53)
	i32.load	$push16=, 4($2)
	i32.sub 	$push18=, $pop17, $pop16
	i32.const	$push52=, 7
	i32.gt_s	$push19=, $pop18, $pop52
	i32.const	$push51=, .L.str.27
	call    	eosio_assert@FUNCTION, $pop19, $pop51
	i32.load	$push20=, 4($2)
	i32.const	$push50=, 8
	i32.call	$drop=, memcpy@FUNCTION, $pop20, $3, $pop50
	i32.load	$push21=, 4($2)
	i32.const	$push49=, 8
	i32.add 	$push48=, $pop21, $pop49
	tee_local	$push47=, $4=, $pop48
	i32.store	4($2), $pop47
	i32.load	$push22=, 8($2)
	i32.sub 	$push23=, $pop22, $4
	i32.const	$push46=, 7
	i32.gt_s	$push24=, $pop23, $pop46
	i32.const	$push45=, .L.str.27
	call    	eosio_assert@FUNCTION, $pop24, $pop45
	i32.load	$push26=, 4($2)
	i32.const	$push44=, 8
	i32.add 	$push25=, $3, $pop44
	i32.const	$push43=, 8
	i32.call	$drop=, memcpy@FUNCTION, $pop26, $pop25, $pop43
	i32.load	$push27=, 4($2)
	i32.const	$push42=, 8
	i32.add 	$push28=, $pop27, $pop42
	i32.store	4($2), $pop28
	i32.load	$0=, 8($0)
	i32.load	$push41=, 0($1)
	tee_local	$push40=, $2=, $pop41
	i32.load	$push30=, 8($pop40)
	i32.load	$push29=, 4($2)
	i32.sub 	$push31=, $pop30, $pop29
	i32.const	$push39=, 7
	i32.gt_s	$push32=, $pop31, $pop39
	i32.const	$push38=, .L.str.27
	call    	eosio_assert@FUNCTION, $pop32, $pop38
	i32.load	$push33=, 4($2)
	i32.const	$push37=, 8
	i32.call	$drop=, memcpy@FUNCTION, $pop33, $0, $pop37
	i32.load	$push34=, 4($2)
	i32.const	$push36=, 8
	i32.add 	$push35=, $pop34, $pop36
	i32.store	4($2), $pop35
	.endfunc
.Lfunc_end8:
	.size	_ZN5boost3pfr6detail19for_each_field_implINS1_14sequence_tuple5tupleIJRKN5eosio5assetES8_RKyEEEZNS5_lsINS5_10datastreamIPcEENS5_5token14currency_statsELPv0EEERT_SK_RKT0_EUlRKSJ_E_JLj0ELj1ELj2EEEEvSK_OSL_NSt3__116integer_sequenceIjJXspT1_EEEENSS_17integral_constantIbLb0EEE, .Lfunc_end8-_ZN5boost3pfr6detail19for_each_field_implINS1_14sequence_tuple5tupleIJRKN5eosio5assetES8_RKyEEEZNS5_lsINS5_10datastreamIPcEENS5_5token14currency_statsELPv0EEERT_SK_RKT0_EUlRKSJ_E_JLj0ELj1ELj2EEEEvSK_OSL_NSt3__116integer_sequenceIjJXspT1_EEEENSS_17integral_constantIbLb0EEE

	.section	.text._ZNSt3__16vectorIN5eosio11multi_indexILy14289235522390851584ENS1_5token14currency_statsEJEE8item_ptrENS_9allocatorIS6_EEE24__emplace_back_slow_pathIJNS_10unique_ptrINS5_4itemENS_14default_deleteISC_EEEERyRlEEEvDpOT_,"axG",@progbits,_ZNSt3__16vectorIN5eosio11multi_indexILy14289235522390851584ENS1_5token14currency_statsEJEE8item_ptrENS_9allocatorIS6_EEE24__emplace_back_slow_pathIJNS_10unique_ptrINS5_4itemENS_14default_deleteISC_EEEERyRlEEEvDpOT_,comdat
	.hidden	_ZNSt3__16vectorIN5eosio11multi_indexILy14289235522390851584ENS1_5token14currency_statsEJEE8item_ptrENS_9allocatorIS6_EEE24__emplace_back_slow_pathIJNS_10unique_ptrINS5_4itemENS_14default_deleteISC_EEEERyRlEEEvDpOT_
	.weak	_ZNSt3__16vectorIN5eosio11multi_indexILy14289235522390851584ENS1_5token14currency_statsEJEE8item_ptrENS_9allocatorIS6_EEE24__emplace_back_slow_pathIJNS_10unique_ptrINS5_4itemENS_14default_deleteISC_EEEERyRlEEEvDpOT_
	.type	_ZNSt3__16vectorIN5eosio11multi_indexILy14289235522390851584ENS1_5token14currency_statsEJEE8item_ptrENS_9allocatorIS6_EEE24__emplace_back_slow_pathIJNS_10unique_ptrINS5_4itemENS_14default_deleteISC_EEEERyRlEEEvDpOT_,@function
_ZNSt3__16vectorIN5eosio11multi_indexILy14289235522390851584ENS1_5token14currency_statsEJEE8item_ptrENS_9allocatorIS6_EEE24__emplace_back_slow_pathIJNS_10unique_ptrINS5_4itemENS_14default_deleteISC_EEEERyRlEEEvDpOT_:
	.param  	i32, i32, i32, i32
	.local  	i32, i32, i32, i32
	block   	
	block   	
	i32.load	$push0=, 4($0)
	i32.load	$push46=, 0($0)
	tee_local	$push45=, $6=, $pop46
	i32.sub 	$push1=, $pop0, $pop45
	i32.const	$push44=, 24
	i32.div_s	$push43=, $pop1, $pop44
	tee_local	$push42=, $4=, $pop43
	i32.const	$push2=, 1
	i32.add 	$push41=, $pop42, $pop2
	tee_local	$push40=, $5=, $pop41
	i32.const	$push3=, 178956971
	i32.ge_u	$push4=, $pop40, $pop3
	br_if   	0, $pop4
	i32.const	$7=, 178956970
	block   	
	block   	
	i32.load	$push5=, 8($0)
	i32.sub 	$push6=, $pop5, $6
	i32.const	$push49=, 24
	i32.div_s	$push48=, $pop6, $pop49
	tee_local	$push47=, $6=, $pop48
	i32.const	$push7=, 89478484
	i32.gt_u	$push8=, $pop47, $pop7
	br_if   	0, $pop8
	i32.const	$push9=, 1
	i32.shl 	$push53=, $6, $pop9
	tee_local	$push52=, $7=, $pop53
	i32.lt_u	$push10=, $7, $5
	i32.select	$push51=, $5, $pop52, $pop10
	tee_local	$push50=, $7=, $pop51
	i32.eqz 	$push79=, $pop50
	br_if   	1, $pop79
.LBB9_3:
	end_block
	i32.const	$push11=, 24
	i32.mul 	$push12=, $7, $pop11
	i32.call	$6=, _Znwj@FUNCTION, $pop12
	br      	2
.LBB9_4:
	end_block
	i32.const	$7=, 0
	i32.const	$6=, 0
	br      	1
.LBB9_5:
	end_block
	call    	_ZNKSt3__120__vector_base_commonILb1EE20__throw_length_errorEv@FUNCTION, $0
	unreachable
.LBB9_6:
	end_block
	i32.load	$5=, 0($1)
	i32.const	$push62=, 0
	i32.store	0($1), $pop62
	i32.const	$push13=, 24
	i32.mul 	$push14=, $4, $pop13
	i32.add 	$push61=, $6, $pop14
	tee_local	$push60=, $1=, $pop61
	i32.store	0($pop60), $5
	i64.load	$push15=, 0($2)
	i64.store	8($1), $pop15
	i32.load	$push16=, 0($3)
	i32.store	16($1), $pop16
	i32.const	$push59=, 24
	i32.mul 	$push17=, $7, $pop59
	i32.add 	$4=, $6, $pop17
	i32.const	$push58=, 24
	i32.add 	$5=, $1, $pop58
	block   	
	block   	
	i32.const	$push18=, 4
	i32.add 	$push19=, $0, $pop18
	i32.load	$push57=, 0($pop19)
	tee_local	$push56=, $6=, $pop57
	i32.load	$push55=, 0($0)
	tee_local	$push54=, $7=, $pop55
	i32.eq  	$push20=, $pop56, $pop54
	br_if   	0, $pop20
.LBB9_8:
	loop    	
	i32.const	$push74=, -24
	i32.add 	$push73=, $6, $pop74
	tee_local	$push72=, $2=, $pop73
	i32.load	$3=, 0($pop72)
	i32.const	$push71=, 0
	i32.store	0($2), $pop71
	i32.const	$push70=, -24
	i32.add 	$push21=, $1, $pop70
	i32.store	0($pop21), $3
	i32.const	$push69=, -8
	i32.add 	$push22=, $1, $pop69
	i32.const	$push68=, -8
	i32.add 	$push23=, $6, $pop68
	i32.load	$push24=, 0($pop23)
	i32.store	0($pop22), $pop24
	i32.const	$push67=, -12
	i32.add 	$push25=, $1, $pop67
	i32.const	$push66=, -12
	i32.add 	$push26=, $6, $pop66
	i32.load	$push27=, 0($pop26)
	i32.store	0($pop25), $pop27
	i32.const	$push65=, -16
	i32.add 	$push28=, $1, $pop65
	i32.const	$push64=, -16
	i32.add 	$push29=, $6, $pop64
	i32.load	$push30=, 0($pop29)
	i32.store	0($pop28), $pop30
	i32.const	$push63=, -24
	i32.add 	$1=, $1, $pop63
	copy_local	$6=, $2
	i32.ne  	$push31=, $7, $2
	br_if   	0, $pop31
	end_loop
	i32.const	$push32=, 4
	i32.add 	$push33=, $0, $pop32
	i32.load	$7=, 0($pop33)
	i32.load	$6=, 0($0)
	br      	1
.LBB9_10:
	end_block
	copy_local	$6=, $7
.LBB9_11:
	end_block
	i32.store	0($0), $1
	i32.const	$push34=, 4
	i32.add 	$push35=, $0, $pop34
	i32.store	0($pop35), $5
	i32.const	$push36=, 8
	i32.add 	$push37=, $0, $pop36
	i32.store	0($pop37), $4
	block   	
	i32.eq  	$push38=, $7, $6
	br_if   	0, $pop38
.LBB9_13:
	loop    	
	i32.const	$push78=, -24
	i32.add 	$push77=, $7, $pop78
	tee_local	$push76=, $7=, $pop77
	i32.load	$1=, 0($pop76)
	i32.const	$push75=, 0
	i32.store	0($7), $pop75
	block   	
	i32.eqz 	$push80=, $1
	br_if   	0, $pop80
	call    	_ZdlPv@FUNCTION, $1
.LBB9_15:
	end_block
	i32.ne  	$push39=, $6, $7
	br_if   	0, $pop39
.LBB9_16:
	end_loop
	end_block
	block   	
	i32.eqz 	$push81=, $6
	br_if   	0, $pop81
	call    	_ZdlPv@FUNCTION, $6
.LBB9_18:
	end_block
	.endfunc
.Lfunc_end9:
	.size	_ZNSt3__16vectorIN5eosio11multi_indexILy14289235522390851584ENS1_5token14currency_statsEJEE8item_ptrENS_9allocatorIS6_EEE24__emplace_back_slow_pathIJNS_10unique_ptrINS5_4itemENS_14default_deleteISC_EEEERyRlEEEvDpOT_, .Lfunc_end9-_ZNSt3__16vectorIN5eosio11multi_indexILy14289235522390851584ENS1_5token14currency_statsEJEE8item_ptrENS_9allocatorIS6_EEE24__emplace_back_slow_pathIJNS_10unique_ptrINS5_4itemENS_14default_deleteISC_EEEERyRlEEEvDpOT_

	.section	.text._ZN5boost3pfr6detail19for_each_field_implINS1_14sequence_tuple5tupleIJRN5eosio5assetES7_RyEEEZNS5_rsINS5_10datastreamIPKcEENS5_5token14currency_statsELPv0EEERT_SJ_RT0_EUlSJ_E_JLj0ELj1ELj2EEEEvSJ_OSK_NSt3__116integer_sequenceIjJXspT1_EEEENSO_17integral_constantIbLb0EEE,"axG",@progbits,_ZN5boost3pfr6detail19for_each_field_implINS1_14sequence_tuple5tupleIJRN5eosio5assetES7_RyEEEZNS5_rsINS5_10datastreamIPKcEENS5_5token14currency_statsELPv0EEERT_SJ_RT0_EUlSJ_E_JLj0ELj1ELj2EEEEvSJ_OSK_NSt3__116integer_sequenceIjJXspT1_EEEENSO_17integral_constantIbLb0EEE,comdat
	.hidden	_ZN5boost3pfr6detail19for_each_field_implINS1_14sequence_tuple5tupleIJRN5eosio5assetES7_RyEEEZNS5_rsINS5_10datastreamIPKcEENS5_5token14currency_statsELPv0EEERT_SJ_RT0_EUlSJ_E_JLj0ELj1ELj2EEEEvSJ_OSK_NSt3__116integer_sequenceIjJXspT1_EEEENSO_17integral_constantIbLb0EEE
	.weak	_ZN5boost3pfr6detail19for_each_field_implINS1_14sequence_tuple5tupleIJRN5eosio5assetES7_RyEEEZNS5_rsINS5_10datastreamIPKcEENS5_5token14currency_statsELPv0EEERT_SJ_RT0_EUlSJ_E_JLj0ELj1ELj2EEEEvSJ_OSK_NSt3__116integer_sequenceIjJXspT1_EEEENSO_17integral_constantIbLb0EEE
	.type	_ZN5boost3pfr6detail19for_each_field_implINS1_14sequence_tuple5tupleIJRN5eosio5assetES7_RyEEEZNS5_rsINS5_10datastreamIPKcEENS5_5token14currency_statsELPv0EEERT_SJ_RT0_EUlSJ_E_JLj0ELj1ELj2EEEEvSJ_OSK_NSt3__116integer_sequenceIjJXspT1_EEEENSO_17integral_constantIbLb0EEE,@function
_ZN5boost3pfr6detail19for_each_field_implINS1_14sequence_tuple5tupleIJRN5eosio5assetES7_RyEEEZNS5_rsINS5_10datastreamIPKcEENS5_5token14currency_statsELPv0EEERT_SJ_RT0_EUlSJ_E_JLj0ELj1ELj2EEEEvSJ_OSK_NSt3__116integer_sequenceIjJXspT1_EEEENSO_17integral_constantIbLb0EEE:
	.param  	i32, i32
	.local  	i32, i32, i32
	i32.load	$3=, 0($0)
	i32.load	$push64=, 0($1)
	tee_local	$push63=, $2=, $pop64
	i32.load	$push1=, 8($pop63)
	i32.load	$push0=, 4($2)
	i32.sub 	$push2=, $pop1, $pop0
	i32.const	$push3=, 7
	i32.gt_u	$push4=, $pop2, $pop3
	i32.const	$push5=, .L.str.24
	call    	eosio_assert@FUNCTION, $pop4, $pop5
	i32.load	$push6=, 4($2)
	i32.const	$push7=, 8
	i32.call	$drop=, memcpy@FUNCTION, $3, $pop6, $pop7
	i32.load	$push8=, 4($2)
	i32.const	$push62=, 8
	i32.add 	$push61=, $pop8, $pop62
	tee_local	$push60=, $4=, $pop61
	i32.store	4($2), $pop60
	i32.load	$push9=, 8($2)
	i32.sub 	$push10=, $pop9, $4
	i32.const	$push59=, 7
	i32.gt_u	$push11=, $pop10, $pop59
	i32.const	$push58=, .L.str.24
	call    	eosio_assert@FUNCTION, $pop11, $pop58
	i32.const	$push57=, 8
	i32.add 	$push12=, $3, $pop57
	i32.load	$push13=, 4($2)
	i32.const	$push56=, 8
	i32.call	$drop=, memcpy@FUNCTION, $pop12, $pop13, $pop56
	i32.load	$push14=, 4($2)
	i32.const	$push55=, 8
	i32.add 	$push15=, $pop14, $pop55
	i32.store	4($2), $pop15
	i32.load	$3=, 4($0)
	i32.load	$push54=, 0($1)
	tee_local	$push53=, $2=, $pop54
	i32.load	$push17=, 8($pop53)
	i32.load	$push16=, 4($2)
	i32.sub 	$push18=, $pop17, $pop16
	i32.const	$push52=, 7
	i32.gt_u	$push19=, $pop18, $pop52
	i32.const	$push51=, .L.str.24
	call    	eosio_assert@FUNCTION, $pop19, $pop51
	i32.load	$push20=, 4($2)
	i32.const	$push50=, 8
	i32.call	$drop=, memcpy@FUNCTION, $3, $pop20, $pop50
	i32.load	$push21=, 4($2)
	i32.const	$push49=, 8
	i32.add 	$push48=, $pop21, $pop49
	tee_local	$push47=, $4=, $pop48
	i32.store	4($2), $pop47
	i32.load	$push22=, 8($2)
	i32.sub 	$push23=, $pop22, $4
	i32.const	$push46=, 7
	i32.gt_u	$push24=, $pop23, $pop46
	i32.const	$push45=, .L.str.24
	call    	eosio_assert@FUNCTION, $pop24, $pop45
	i32.const	$push44=, 8
	i32.add 	$push25=, $3, $pop44
	i32.load	$push26=, 4($2)
	i32.const	$push43=, 8
	i32.call	$drop=, memcpy@FUNCTION, $pop25, $pop26, $pop43
	i32.load	$push27=, 4($2)
	i32.const	$push42=, 8
	i32.add 	$push28=, $pop27, $pop42
	i32.store	4($2), $pop28
	i32.load	$0=, 8($0)
	i32.load	$push41=, 0($1)
	tee_local	$push40=, $2=, $pop41
	i32.load	$push30=, 8($pop40)
	i32.load	$push29=, 4($2)
	i32.sub 	$push31=, $pop30, $pop29
	i32.const	$push39=, 7
	i32.gt_u	$push32=, $pop31, $pop39
	i32.const	$push38=, .L.str.24
	call    	eosio_assert@FUNCTION, $pop32, $pop38
	i32.load	$push33=, 4($2)
	i32.const	$push37=, 8
	i32.call	$drop=, memcpy@FUNCTION, $0, $pop33, $pop37
	i32.load	$push34=, 4($2)
	i32.const	$push36=, 8
	i32.add 	$push35=, $pop34, $pop36
	i32.store	4($2), $pop35
	.endfunc
.Lfunc_end10:
	.size	_ZN5boost3pfr6detail19for_each_field_implINS1_14sequence_tuple5tupleIJRN5eosio5assetES7_RyEEEZNS5_rsINS5_10datastreamIPKcEENS5_5token14currency_statsELPv0EEERT_SJ_RT0_EUlSJ_E_JLj0ELj1ELj2EEEEvSJ_OSK_NSt3__116integer_sequenceIjJXspT1_EEEENSO_17integral_constantIbLb0EEE, .Lfunc_end10-_ZN5boost3pfr6detail19for_each_field_implINS1_14sequence_tuple5tupleIJRN5eosio5assetES7_RyEEEZNS5_rsINS5_10datastreamIPKcEENS5_5token14currency_statsELPv0EEERT_SJ_RT0_EUlSJ_E_JLj0ELj1ELj2EEEEvSJ_OSK_NSt3__116integer_sequenceIjJXspT1_EEEENSO_17integral_constantIbLb0EEE

	.text
	.hidden	_ZN5eosio5token5issueEyNS_5assetENSt3__112basic_stringIcNS2_11char_traitsIcEENS2_9allocatorIcEEEE
	.globl	_ZN5eosio5token5issueEyNS_5assetENSt3__112basic_stringIcNS2_11char_traitsIcEENS2_9allocatorIcEEEE
	.type	_ZN5eosio5token5issueEyNS_5assetENSt3__112basic_stringIcNS2_11char_traitsIcEENS2_9allocatorIcEEEE,@function
_ZN5eosio5token5issueEyNS_5assetENSt3__112basic_stringIcNS2_11char_traitsIcEENS2_9allocatorIcEEEE:
	.param  	i32, i64, i32, i32
	.local  	i32, i64, i64, i32, i64, i32, i32, i64, i64, i64, i32
	i32.const	$push164=, 0
	i32.const	$push161=, 0
	i32.load	$push162=, __stack_pointer($pop161)
	i32.const	$push163=, 224
	i32.sub 	$push220=, $pop162, $pop163
	tee_local	$push219=, $14=, $pop220
	i32.store	__stack_pointer($pop164), $pop219
	i32.const	$9=, 0
	i64.load	$push218=, 8($2)
	tee_local	$push217=, $11=, $pop218
	i64.const	$push216=, 8
	i64.shr_u	$push215=, $pop217, $pop216
	tee_local	$push214=, $13=, $pop215
	copy_local	$8=, $pop214
.LBB11_1:
	block   	
	block   	
	loop    	
	i32.wrap/i64	$push0=, $8
	i32.const	$push223=, 24
	i32.shl 	$push1=, $pop0, $pop223
	i32.const	$push222=, -1073741825
	i32.add 	$push2=, $pop1, $pop222
	i32.const	$push221=, 452984830
	i32.gt_u	$push3=, $pop2, $pop221
	br_if   	1, $pop3
	block   	
	i64.const	$push228=, 8
	i64.shr_u	$push227=, $8, $pop228
	tee_local	$push226=, $8=, $pop227
	i64.const	$push225=, 255
	i64.and 	$push4=, $pop226, $pop225
	i64.const	$push224=, 0
	i64.ne  	$push5=, $pop4, $pop224
	br_if   	0, $pop5
.LBB11_3:
	loop    	
	i64.const	$push233=, 8
	i64.shr_u	$push232=, $8, $pop233
	tee_local	$push231=, $8=, $pop232
	i64.const	$push230=, 255
	i64.and 	$push6=, $pop231, $pop230
	i64.const	$push229=, 0
	i64.ne  	$push7=, $pop6, $pop229
	br_if   	3, $pop7
	i32.const	$push237=, 1
	i32.add 	$push236=, $9, $pop237
	tee_local	$push235=, $9=, $pop236
	i32.const	$push234=, 7
	i32.lt_s	$push8=, $pop235, $pop234
	br_if   	0, $pop8
.LBB11_5:
	end_loop
	end_block
	i32.const	$7=, 1
	i32.const	$push241=, 1
	i32.add 	$push240=, $9, $pop241
	tee_local	$push239=, $9=, $pop240
	i32.const	$push238=, 7
	i32.lt_s	$push9=, $pop239, $pop238
	br_if   	0, $pop9
	br      	2
.LBB11_6:
	end_loop
	end_block
	i32.const	$7=, 0
.LBB11_7:
	end_block
	i32.const	$push10=, .L.str
	call    	eosio_assert@FUNCTION, $7, $pop10
	block   	
	block   	
	i32.load8_u	$push244=, 0($3)
	tee_local	$push243=, $9=, $pop244
	i32.const	$push242=, 1
	i32.and 	$push11=, $pop243, $pop242
	br_if   	0, $pop11
	i32.const	$push245=, 1
	i32.shr_u	$9=, $9, $pop245
	br      	1
.LBB11_9:
	end_block
	i32.load	$9=, 4($3)
.LBB11_10:
	end_block
	i32.const	$push12=, 257
	i32.lt_u	$push13=, $9, $pop12
	i32.const	$push14=, .L.str.4
	call    	eosio_assert@FUNCTION, $pop13, $pop14
	i32.const	$10=, 0
	i32.const	$push168=, 88
	i32.add 	$push169=, $14, $pop168
	i32.const	$push252=, 32
	i32.add 	$push15=, $pop169, $pop252
	i32.const	$push251=, 0
	i32.store	0($pop15), $pop251
	i64.const	$push16=, -1
	i64.store	104($14), $pop16
	i64.const	$push17=, 0
	i64.store	112($14), $pop17
	i64.load	$push250=, 0($0)
	tee_local	$push249=, $8=, $pop250
	i64.store	88($14), $pop249
	i64.store	96($14), $13
	i32.const	$7=, 0
	block   	
	i64.const	$push18=, -4157508551318700032
	i32.call	$push248=, db_find_i64@FUNCTION, $8, $13, $pop18, $13
	tee_local	$push247=, $9=, $pop248
	i32.const	$push246=, 0
	i32.lt_s	$push19=, $pop247, $pop246
	br_if   	0, $pop19
	i32.const	$push210=, 88
	i32.add 	$push211=, $14, $pop210
	i32.call	$push254=, _ZNK5eosio11multi_indexILy14289235522390851584ENS_5token14currency_statsEJEE31load_object_by_primary_iteratorEl@FUNCTION, $pop211, $9
	tee_local	$push253=, $7=, $pop254
	i32.load	$push20=, 40($pop253)
	i32.const	$push212=, 88
	i32.add 	$push213=, $14, $pop212
	i32.eq  	$push21=, $pop20, $pop213
	i32.const	$push22=, .L.str.20
	call    	eosio_assert@FUNCTION, $pop21, $pop22
.LBB11_12:
	end_block
	i32.const	$push258=, 0
	i32.ne  	$push23=, $7, $pop258
	i32.const	$push24=, .L.str.5
	call    	eosio_assert@FUNCTION, $pop23, $pop24
	i64.load	$push25=, 32($7)
	call    	require_auth@FUNCTION, $pop25
	i32.const	$push257=, 32
	i32.add 	$4=, $7, $pop257
	block   	
	i64.load	$push256=, 0($2)
	tee_local	$push255=, $8=, $pop256
	i64.const	$push26=, 4611686018427387903
	i64.add 	$push27=, $pop255, $pop26
	i64.const	$push28=, 9223372036854775806
	i64.gt_u	$push29=, $pop27, $pop28
	br_if   	0, $pop29
	i32.const	$9=, 0
.LBB11_14:
	block   	
	loop    	
	i32.wrap/i64	$push30=, $13
	i32.const	$push261=, 24
	i32.shl 	$push31=, $pop30, $pop261
	i32.const	$push260=, -1073741825
	i32.add 	$push32=, $pop31, $pop260
	i32.const	$push259=, 452984830
	i32.gt_u	$push33=, $pop32, $pop259
	br_if   	1, $pop33
	block   	
	i64.const	$push266=, 8
	i64.shr_u	$push265=, $13, $pop266
	tee_local	$push264=, $13=, $pop265
	i64.const	$push263=, 255
	i64.and 	$push34=, $pop264, $pop263
	i64.const	$push262=, 0
	i64.ne  	$push35=, $pop34, $pop262
	br_if   	0, $pop35
.LBB11_16:
	loop    	
	i64.const	$push271=, 8
	i64.shr_u	$push270=, $13, $pop271
	tee_local	$push269=, $13=, $pop270
	i64.const	$push268=, 255
	i64.and 	$push36=, $pop269, $pop268
	i64.const	$push267=, 0
	i64.ne  	$push37=, $pop36, $pop267
	br_if   	3, $pop37
	i32.const	$push275=, 1
	i32.add 	$push274=, $9, $pop275
	tee_local	$push273=, $9=, $pop274
	i32.const	$push272=, 7
	i32.lt_s	$push38=, $pop273, $pop272
	br_if   	0, $pop38
.LBB11_18:
	end_loop
	end_block
	i32.const	$10=, 1
	i32.const	$push279=, 1
	i32.add 	$push278=, $9, $pop279
	tee_local	$push277=, $9=, $pop278
	i32.const	$push276=, 7
	i32.lt_s	$push39=, $pop277, $pop276
	br_if   	0, $pop39
	br      	2
.LBB11_19:
	end_loop
	end_block
	i32.const	$10=, 0
.LBB11_20:
	end_block
	i32.const	$push40=, .L.str.6
	call    	eosio_assert@FUNCTION, $10, $pop40
	i64.const	$push41=, 0
	i64.gt_s	$push42=, $8, $pop41
	i32.const	$push43=, .L.str.7
	call    	eosio_assert@FUNCTION, $pop42, $pop43
	i64.load	$push44=, 8($7)
	i64.eq  	$push45=, $11, $pop44
	i32.const	$push46=, .L.str.8
	call    	eosio_assert@FUNCTION, $pop45, $pop46
	i64.load	$push48=, 16($7)
	i64.load	$push47=, 0($7)
	i64.sub 	$push49=, $pop48, $pop47
	i64.le_s	$push50=, $8, $pop49
	i32.const	$push51=, .L.str.9
	call    	eosio_assert@FUNCTION, $pop50, $pop51
	i32.load	$push52=, 40($7)
	i32.const	$push170=, 88
	i32.add 	$push171=, $14, $pop170
	i32.eq  	$push53=, $pop52, $pop171
	i32.const	$push54=, .L.str.28
	call    	eosio_assert@FUNCTION, $pop53, $pop54
	i64.load	$push55=, 88($14)
	i64.call	$push56=, current_receiver@FUNCTION
	i64.eq  	$push57=, $pop55, $pop56
	i32.const	$push58=, .L.str.29
	call    	eosio_assert@FUNCTION, $pop57, $pop58
	i64.load	$push291=, 8($7)
	tee_local	$push290=, $13=, $pop291
	i64.eq  	$push59=, $11, $pop290
	i32.const	$push60=, .L.str.31
	call    	eosio_assert@FUNCTION, $pop59, $pop60
	i64.load	$push61=, 0($7)
	i64.add 	$push289=, $pop61, $8
	tee_local	$push288=, $8=, $pop289
	i64.store	0($7), $pop288
	i64.const	$push62=, -4611686018427387904
	i64.gt_s	$push63=, $8, $pop62
	i32.const	$push64=, .L.str.32
	call    	eosio_assert@FUNCTION, $pop63, $pop64
	i64.load	$push65=, 0($7)
	i64.const	$push66=, 4611686018427387904
	i64.lt_s	$push67=, $pop65, $pop66
	i32.const	$push68=, .L.str.33
	call    	eosio_assert@FUNCTION, $pop67, $pop68
	i64.const	$push69=, 8
	i64.shr_u	$push287=, $13, $pop69
	tee_local	$push286=, $8=, $pop287
	i64.load	$push70=, 8($7)
	i64.const	$push285=, 8
	i64.shr_u	$push71=, $pop70, $pop285
	i64.eq  	$push72=, $pop286, $pop71
	i32.const	$push73=, .L.str.30
	call    	eosio_assert@FUNCTION, $pop72, $pop73
	i32.const	$push172=, 128
	i32.add 	$push173=, $14, $pop172
	i32.const	$push74=, 40
	i32.add 	$push75=, $pop173, $pop74
	i32.store	192($14), $pop75
	i32.const	$push174=, 128
	i32.add 	$push175=, $14, $pop174
	i32.store	188($14), $pop175
	i32.const	$push176=, 128
	i32.add 	$push177=, $14, $pop176
	i32.store	184($14), $pop177
	i32.const	$push178=, 184
	i32.add 	$push179=, $14, $pop178
	i32.store	200($14), $pop179
	i32.const	$push76=, 16
	i32.add 	$push77=, $7, $pop76
	i32.store	212($14), $pop77
	i32.store	208($14), $7
	i32.store	216($14), $4
	i32.const	$push180=, 208
	i32.add 	$push181=, $14, $pop180
	i32.const	$push182=, 200
	i32.add 	$push183=, $14, $pop182
	call    	_ZN5boost3pfr6detail19for_each_field_implINS1_14sequence_tuple5tupleIJRKN5eosio5assetES8_RKyEEEZNS5_lsINS5_10datastreamIPcEENS5_5token14currency_statsELPv0EEERT_SK_RKT0_EUlRKSJ_E_JLj0ELj1ELj2EEEEvSK_OSL_NSt3__116integer_sequenceIjJXspT1_EEEENSS_17integral_constantIbLb0EEE@FUNCTION, $pop181, $pop183
	i32.load	$push78=, 44($7)
	i64.const	$push284=, 0
	i32.const	$push184=, 128
	i32.add 	$push185=, $14, $pop184
	i32.const	$push283=, 40
	call    	db_update_i64@FUNCTION, $pop78, $pop284, $pop185, $pop283
	block   	
	i32.const	$push186=, 88
	i32.add 	$push187=, $14, $pop186
	i32.const	$push282=, 16
	i32.add 	$push281=, $pop187, $pop282
	tee_local	$push280=, $9=, $pop281
	i64.load	$push79=, 0($pop280)
	i64.lt_u	$push80=, $8, $pop79
	br_if   	0, $pop80
	i64.const	$push81=, 1
	i64.add 	$push82=, $8, $pop81
	i64.store	0($9), $pop82
.LBB11_22:
	end_block
	i32.const	$push188=, 72
	i32.add 	$push189=, $14, $pop188
	i32.const	$push83=, 12
	i32.add 	$push301=, $pop189, $pop83
	tee_local	$push300=, $9=, $pop301
	i32.const	$push299=, 12
	i32.add 	$push84=, $2, $pop299
	i32.load	$push85=, 0($pop84)
	i32.store	0($pop300), $pop85
	i32.const	$push190=, 72
	i32.add 	$push191=, $14, $pop190
	i32.const	$push86=, 8
	i32.add 	$push298=, $pop191, $pop86
	tee_local	$push297=, $7=, $pop298
	i32.const	$push296=, 8
	i32.add 	$push87=, $2, $pop296
	i32.load	$push88=, 0($pop87)
	i32.store	0($pop297), $pop88
	i32.const	$push89=, 4
	i32.add 	$push90=, $2, $pop89
	i32.load	$push91=, 0($pop90)
	i32.store	76($14), $pop91
	i32.load	$push92=, 0($2)
	i32.store	72($14), $pop92
	i64.load	$8=, 0($4)
	i32.const	$push192=, 8
	i32.add 	$push193=, $14, $pop192
	i32.const	$push295=, 12
	i32.add 	$push93=, $pop193, $pop295
	i32.load	$push94=, 0($9)
	i32.store	0($pop93), $pop94
	i32.const	$push194=, 8
	i32.add 	$push195=, $14, $pop194
	i32.const	$push294=, 8
	i32.add 	$push95=, $pop195, $pop294
	i32.load	$push96=, 0($7)
	i32.store	0($pop95), $pop96
	i32.load	$push97=, 76($14)
	i32.store	12($14), $pop97
	i32.load	$push98=, 72($14)
	i32.store	8($14), $pop98
	i32.const	$push196=, 8
	i32.add 	$push197=, $14, $pop196
	call    	_ZN5eosio5token11add_balanceEyNS_5assetEy@FUNCTION, $0, $8, $pop197, $8
	block   	
	i64.load	$push293=, 0($4)
	tee_local	$push292=, $5=, $pop293
	i64.eq  	$push99=, $pop292, $1
	br_if   	0, $pop99
	i64.load	$6=, 0($0)
	i64.const	$8=, 0
	i64.const	$11=, 59
	i32.const	$9=, .L.str.10
	i64.const	$12=, 0
.LBB11_24:
	loop    	
	block   	
	block   	
	block   	
	block   	
	block   	
	i64.const	$push302=, 5
	i64.gt_u	$push100=, $8, $pop302
	br_if   	0, $pop100
	i32.load8_s	$push307=, 0($9)
	tee_local	$push306=, $7=, $pop307
	i32.const	$push305=, -97
	i32.add 	$push102=, $pop306, $pop305
	i32.const	$push304=, 255
	i32.and 	$push103=, $pop102, $pop304
	i32.const	$push303=, 25
	i32.gt_u	$push104=, $pop103, $pop303
	br_if   	1, $pop104
	i32.const	$push308=, 165
	i32.add 	$7=, $7, $pop308
	br      	2
.LBB11_27:
	end_block
	i64.const	$13=, 0
	i64.const	$push309=, 11
	i64.le_u	$push101=, $8, $pop309
	br_if   	2, $pop101
	br      	3
.LBB11_28:
	end_block
	i32.const	$push314=, 208
	i32.add 	$push105=, $7, $pop314
	i32.const	$push313=, 0
	i32.const	$push312=, -49
	i32.add 	$push106=, $7, $pop312
	i32.const	$push311=, 255
	i32.and 	$push107=, $pop106, $pop311
	i32.const	$push310=, 5
	i32.lt_u	$push108=, $pop107, $pop310
	i32.select	$7=, $pop105, $pop313, $pop108
.LBB11_29:
	end_block
	i64.extend_u/i32	$push109=, $7
	i64.const	$push316=, 56
	i64.shl 	$push110=, $pop109, $pop316
	i64.const	$push315=, 56
	i64.shr_s	$13=, $pop110, $pop315
.LBB11_30:
	end_block
	i64.const	$push318=, 31
	i64.and 	$push112=, $13, $pop318
	i64.const	$push317=, 4294967295
	i64.and 	$push111=, $11, $pop317
	i64.shl 	$13=, $pop112, $pop111
.LBB11_31:
	end_block
	i32.const	$push324=, 1
	i32.add 	$9=, $9, $pop324
	i64.const	$push323=, 1
	i64.add 	$8=, $8, $pop323
	i64.or  	$12=, $13, $12
	i64.const	$push322=, -5
	i64.add 	$push321=, $11, $pop322
	tee_local	$push320=, $11=, $pop321
	i64.const	$push319=, -6
	i64.ne  	$push113=, $pop320, $pop319
	br_if   	0, $pop113
	end_loop
	i32.const	$push117=, 52
	i32.add 	$push118=, $14, $pop117
	i32.const	$push114=, 12
	i32.add 	$push115=, $2, $pop114
	i32.load	$push116=, 0($pop115)
	i32.store	0($pop118), $pop116
	i32.const	$push198=, 24
	i32.add 	$push199=, $14, $pop198
	i32.const	$push122=, 24
	i32.add 	$push339=, $pop199, $pop122
	tee_local	$push338=, $7=, $pop339
	i32.const	$push119=, 8
	i32.add 	$push120=, $2, $pop119
	i32.load	$push121=, 0($pop120)
	i32.store	0($pop338), $pop121
	i32.const	$push126=, 44
	i32.add 	$push127=, $14, $pop126
	i32.const	$push123=, 4
	i32.add 	$push124=, $2, $pop123
	i32.load	$push125=, 0($pop124)
	i32.store	0($pop127), $pop125
	i64.store	32($14), $1
	i64.store	24($14), $5
	i32.load	$push128=, 0($2)
	i32.store	40($14), $pop128
	i32.const	$push129=, 56
	i32.add 	$push130=, $14, $pop129
	i32.call	$drop=, _ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC1ERKS5_@FUNCTION, $pop130, $3
	i32.const	$push131=, 16
	i32.call	$push337=, _Znwj@FUNCTION, $pop131
	tee_local	$push336=, $9=, $pop337
	i64.store	0($pop336), $5
	i64.store	8($9), $12
	i32.store	208($14), $9
	i32.const	$push335=, 16
	i32.add 	$push334=, $9, $pop335
	tee_local	$push333=, $9=, $pop334
	i32.store	216($14), $pop333
	i32.store	212($14), $9
	i64.load	$push132=, 24($14)
	i64.store	128($14), $pop132
	i64.load	$push133=, 32($14)
	i64.store	136($14), $pop133
	i32.const	$push200=, 128
	i32.add 	$push201=, $14, $pop200
	i32.const	$push332=, 24
	i32.add 	$push134=, $pop201, $pop332
	i64.load	$push135=, 0($7)
	i64.store	0($pop134), $pop135
	i64.load	$push136=, 40($14)
	i64.store	144($14), $pop136
	i32.const	$push202=, 128
	i32.add 	$push203=, $14, $pop202
	i32.const	$push137=, 40
	i32.add 	$push331=, $pop203, $pop137
	tee_local	$push330=, $7=, $pop331
	i32.const	$push204=, 24
	i32.add 	$push205=, $14, $pop204
	i32.const	$push329=, 40
	i32.add 	$push328=, $pop205, $pop329
	tee_local	$push327=, $9=, $pop328
	i32.load	$push138=, 0($pop327)
	i32.store	0($pop330), $pop138
	i64.load	$push139=, 56($14)
	i64.store	160($14), $pop139
	i32.const	$push140=, 0
	i32.store	56($14), $pop140
	i32.const	$push141=, 60
	i32.add 	$push142=, $14, $pop141
	i32.const	$push326=, 0
	i32.store	0($pop142), $pop326
	i32.const	$push325=, 0
	i32.store	0($9), $pop325
	i64.const	$push143=, -3617168760277827584
	i32.const	$push206=, 208
	i32.add 	$push207=, $14, $pop206
	i32.const	$push208=, 128
	i32.add 	$push209=, $14, $pop208
	call    	_ZN5eosio15dispatch_inlineIJyyNS_5assetENSt3__112basic_stringIcNS2_11char_traitsIcEENS2_9allocatorIcEEEEEEEvyyNS2_6vectorINS_16permission_levelENS6_ISA_EEEENS2_5tupleIJDpT_EEE@FUNCTION, $6, $pop143, $pop207, $pop209
	block   	
	i32.load8_u	$push145=, 160($14)
	i32.const	$push144=, 1
	i32.and 	$push146=, $pop145, $pop144
	i32.eqz 	$push352=, $pop146
	br_if   	0, $pop352
	i32.load	$push147=, 0($7)
	call    	_ZdlPv@FUNCTION, $pop147
.LBB11_34:
	end_block
	block   	
	i32.load	$push341=, 208($14)
	tee_local	$push340=, $9=, $pop341
	i32.eqz 	$push353=, $pop340
	br_if   	0, $pop353
	i32.store	212($14), $9
	call    	_ZdlPv@FUNCTION, $9
.LBB11_36:
	end_block
	i32.const	$push148=, 56
	i32.add 	$push149=, $14, $pop148
	i32.load8_u	$push150=, 0($pop149)
	i32.const	$push151=, 1
	i32.and 	$push152=, $pop150, $pop151
	i32.eqz 	$push354=, $pop152
	br_if   	0, $pop354
	i32.const	$push153=, 64
	i32.add 	$push154=, $14, $pop153
	i32.load	$push155=, 0($pop154)
	call    	_ZdlPv@FUNCTION, $pop155
.LBB11_38:
	end_block
	block   	
	i32.load	$push343=, 112($14)
	tee_local	$push342=, $2=, $pop343
	i32.eqz 	$push355=, $pop342
	br_if   	0, $pop355
	block   	
	block   	
	i32.const	$push156=, 116
	i32.add 	$push347=, $14, $pop156
	tee_local	$push346=, $10=, $pop347
	i32.load	$push345=, 0($pop346)
	tee_local	$push344=, $9=, $pop345
	i32.eq  	$push157=, $pop344, $2
	br_if   	0, $pop157
.LBB11_41:
	loop    	
	i32.const	$push351=, -24
	i32.add 	$push350=, $9, $pop351
	tee_local	$push349=, $9=, $pop350
	i32.load	$7=, 0($pop349)
	i32.const	$push348=, 0
	i32.store	0($9), $pop348
	block   	
	i32.eqz 	$push356=, $7
	br_if   	0, $pop356
	call    	_ZdlPv@FUNCTION, $7
.LBB11_43:
	end_block
	i32.ne  	$push158=, $2, $9
	br_if   	0, $pop158
	end_loop
	i32.const	$push159=, 112
	i32.add 	$push160=, $14, $pop159
	i32.load	$9=, 0($pop160)
	br      	1
.LBB11_45:
	end_block
	copy_local	$9=, $2
.LBB11_46:
	end_block
	i32.store	0($10), $2
	call    	_ZdlPv@FUNCTION, $9
.LBB11_47:
	end_block
	i32.const	$push167=, 0
	i32.const	$push165=, 224
	i32.add 	$push166=, $14, $pop165
	i32.store	__stack_pointer($pop167), $pop166
	.endfunc
.Lfunc_end11:
	.size	_ZN5eosio5token5issueEyNS_5assetENSt3__112basic_stringIcNS2_11char_traitsIcEENS2_9allocatorIcEEEE, .Lfunc_end11-_ZN5eosio5token5issueEyNS_5assetENSt3__112basic_stringIcNS2_11char_traitsIcEENS2_9allocatorIcEEEE

	.hidden	_ZN5eosio5token11add_balanceEyNS_5assetEy
	.globl	_ZN5eosio5token11add_balanceEyNS_5assetEy
	.type	_ZN5eosio5token11add_balanceEyNS_5assetEy,@function
_ZN5eosio5token11add_balanceEyNS_5assetEy:
	.param  	i32, i64, i32, i64
	.local  	i64, i32, i64, i32, i32, i32
	i32.const	$push96=, 0
	i32.const	$push93=, 0
	i32.load	$push94=, __stack_pointer($pop93)
	i32.const	$push95=, 80
	i32.sub 	$push146=, $pop94, $pop95
	tee_local	$push145=, $9=, $pop146
	i32.store	__stack_pointer($pop96), $pop145
	i32.const	$8=, 0
	i32.const	$push100=, 8
	i32.add 	$push101=, $9, $pop100
	i32.const	$push144=, 32
	i32.add 	$push0=, $pop101, $pop144
	i32.const	$push143=, 0
	i32.store	0($pop0), $pop143
	i64.const	$push1=, -1
	i64.store	24($9), $pop1
	i64.const	$push142=, 0
	i64.store	32($9), $pop142
	i64.load	$push141=, 0($0)
	tee_local	$push140=, $6=, $pop141
	i64.store	8($9), $pop140
	i64.store	16($9), $1
	block   	
	block   	
	block   	
	block   	
	i64.const	$push3=, 3607749779137757184
	i64.load	$push139=, 8($2)
	tee_local	$push138=, $4=, $pop139
	i64.const	$push137=, 8
	i64.shr_u	$push2=, $pop138, $pop137
	i32.call	$push136=, db_find_i64@FUNCTION, $6, $1, $pop3, $pop2
	tee_local	$push135=, $0=, $pop136
	i32.const	$push134=, 0
	i32.lt_s	$push4=, $pop135, $pop134
	br_if   	0, $pop4
	i32.const	$push120=, 8
	i32.add 	$push121=, $9, $pop120
	i32.call	$push166=, _ZNK5eosio11multi_indexILy3607749779137757184ENS_5token7accountEJEE31load_object_by_primary_iteratorEl@FUNCTION, $pop121, $0
	tee_local	$push165=, $8=, $pop166
	i32.load	$push5=, 16($pop165)
	i32.const	$push122=, 8
	i32.add 	$push123=, $9, $pop122
	i32.eq  	$push6=, $pop5, $pop123
	i32.const	$push7=, .L.str.20
	call    	eosio_assert@FUNCTION, $pop6, $pop7
	i32.const	$push9=, 1
	i32.const	$push8=, .L.str.40
	call    	eosio_assert@FUNCTION, $pop9, $pop8
	i32.load	$push10=, 16($8)
	i32.const	$push124=, 8
	i32.add 	$push125=, $9, $pop124
	i32.eq  	$push11=, $pop10, $pop125
	i32.const	$push12=, .L.str.28
	call    	eosio_assert@FUNCTION, $pop11, $pop12
	i64.load	$push13=, 8($9)
	i64.call	$push14=, current_receiver@FUNCTION
	i64.eq  	$push15=, $pop13, $pop14
	i32.const	$push16=, .L.str.29
	call    	eosio_assert@FUNCTION, $pop15, $pop16
	i64.load	$push164=, 8($8)
	tee_local	$push163=, $1=, $pop164
	i64.eq  	$push17=, $4, $pop163
	i32.const	$push18=, .L.str.31
	call    	eosio_assert@FUNCTION, $pop17, $pop18
	i64.load	$push20=, 0($8)
	i64.load	$push19=, 0($2)
	i64.add 	$push162=, $pop20, $pop19
	tee_local	$push161=, $6=, $pop162
	i64.store	0($8), $pop161
	i64.const	$push21=, -4611686018427387904
	i64.gt_s	$push22=, $6, $pop21
	i32.const	$push23=, .L.str.32
	call    	eosio_assert@FUNCTION, $pop22, $pop23
	i64.load	$push24=, 0($8)
	i64.const	$push25=, 4611686018427387904
	i64.lt_s	$push26=, $pop24, $pop25
	i32.const	$push27=, .L.str.33
	call    	eosio_assert@FUNCTION, $pop26, $pop27
	i64.const	$push160=, 8
	i64.shr_u	$push159=, $1, $pop160
	tee_local	$push158=, $1=, $pop159
	i64.load	$push28=, 8($8)
	i64.const	$push157=, 8
	i64.shr_u	$push29=, $pop28, $pop157
	i64.eq  	$push30=, $pop158, $pop29
	i32.const	$push31=, .L.str.30
	call    	eosio_assert@FUNCTION, $pop30, $pop31
	i32.const	$push156=, 1
	i32.const	$push32=, .L.str.27
	call    	eosio_assert@FUNCTION, $pop156, $pop32
	i32.const	$push126=, 64
	i32.add 	$push127=, $9, $pop126
	i32.const	$push33=, 8
	i32.call	$drop=, memcpy@FUNCTION, $pop127, $8, $pop33
	i32.const	$push155=, 1
	i32.const	$push154=, .L.str.27
	call    	eosio_assert@FUNCTION, $pop155, $pop154
	i32.const	$push128=, 64
	i32.add 	$push129=, $9, $pop128
	i32.const	$push153=, 8
	i32.or  	$push35=, $pop129, $pop153
	i32.const	$push152=, 8
	i32.add 	$push34=, $8, $pop152
	i32.const	$push151=, 8
	i32.call	$drop=, memcpy@FUNCTION, $pop35, $pop34, $pop151
	i32.load	$push36=, 20($8)
	i64.const	$push150=, 0
	i32.const	$push130=, 64
	i32.add 	$push131=, $9, $pop130
	i32.const	$push37=, 16
	call    	db_update_i64@FUNCTION, $pop36, $pop150, $pop131, $pop37
	i32.const	$push132=, 8
	i32.add 	$push133=, $9, $pop132
	i32.const	$push149=, 16
	i32.add 	$push148=, $pop133, $pop149
	tee_local	$push147=, $8=, $pop148
	i64.load	$push38=, 0($pop147)
	i64.lt_u	$push39=, $1, $pop38
	br_if   	1, $pop39
	i64.const	$push40=, 1
	i64.add 	$push41=, $1, $pop40
	i64.store	0($8), $pop41
	i32.load	$push168=, 32($9)
	tee_local	$push167=, $2=, $pop168
	br_if   	2, $pop167
	br      	3
.LBB12_3:
	end_block
	i64.load	$push42=, 8($9)
	i64.call	$push43=, current_receiver@FUNCTION
	i64.eq  	$push44=, $pop42, $pop43
	i32.const	$push45=, .L.str.26
	call    	eosio_assert@FUNCTION, $pop44, $pop45
	i32.const	$push173=, 32
	i32.call	$push172=, _Znwj@FUNCTION, $pop173
	tee_local	$push171=, $0=, $pop172
	i64.const	$push46=, 1397703940
	i64.store	8($pop171), $pop46
	i64.const	$push170=, 0
	i64.store	0($0), $pop170
	i32.const	$push169=, 1
	i32.const	$push47=, .L.str.23
	call    	eosio_assert@FUNCTION, $pop169, $pop47
	i32.const	$push48=, 8
	i32.add 	$5=, $0, $pop48
	i64.const	$1=, 5459781
.LBB12_4:
	block   	
	loop    	
	i32.const	$7=, 0
	i32.wrap/i64	$push49=, $1
	i32.const	$push176=, 24
	i32.shl 	$push50=, $pop49, $pop176
	i32.const	$push175=, -1073741825
	i32.add 	$push51=, $pop50, $pop175
	i32.const	$push174=, 452984830
	i32.gt_u	$push52=, $pop51, $pop174
	br_if   	1, $pop52
	block   	
	i64.const	$push181=, 8
	i64.shr_u	$push180=, $1, $pop181
	tee_local	$push179=, $1=, $pop180
	i64.const	$push178=, 255
	i64.and 	$push53=, $pop179, $pop178
	i64.const	$push177=, 0
	i64.ne  	$push54=, $pop53, $pop177
	br_if   	0, $pop54
.LBB12_6:
	loop    	
	i64.const	$push186=, 8
	i64.shr_u	$push185=, $1, $pop186
	tee_local	$push184=, $1=, $pop185
	i64.const	$push183=, 255
	i64.and 	$push55=, $pop184, $pop183
	i64.const	$push182=, 0
	i64.ne  	$push56=, $pop55, $pop182
	br_if   	3, $pop56
	i32.const	$push190=, 1
	i32.add 	$push189=, $8, $pop190
	tee_local	$push188=, $8=, $pop189
	i32.const	$push187=, 7
	i32.lt_s	$push57=, $pop188, $pop187
	br_if   	0, $pop57
.LBB12_8:
	end_loop
	end_block
	i32.const	$7=, 1
	i32.const	$push194=, 1
	i32.add 	$push193=, $8, $pop194
	tee_local	$push192=, $8=, $pop193
	i32.const	$push191=, 7
	i32.lt_s	$push58=, $pop192, $pop191
	br_if   	0, $pop58
.LBB12_9:
	end_loop
	end_block
	i32.const	$push59=, .L.str
	call    	eosio_assert@FUNCTION, $7, $pop59
	i32.const	$push102=, 8
	i32.add 	$push103=, $9, $pop102
	i32.store	16($0), $pop103
	i32.const	$push60=, 8
	i32.add 	$push211=, $0, $pop60
	tee_local	$push210=, $8=, $pop211
	i32.const	$push209=, 8
	i32.add 	$push61=, $2, $pop209
	i64.load	$push62=, 0($pop61)
	i64.store	0($pop210), $pop62
	i64.load	$push63=, 0($2)
	i64.store	0($0), $pop63
	i32.const	$push65=, 1
	i32.const	$push64=, .L.str.27
	call    	eosio_assert@FUNCTION, $pop65, $pop64
	i32.const	$push104=, 64
	i32.add 	$push105=, $9, $pop104
	i32.const	$push208=, 8
	i32.call	$drop=, memcpy@FUNCTION, $pop105, $0, $pop208
	i32.const	$push207=, 1
	i32.const	$push206=, .L.str.27
	call    	eosio_assert@FUNCTION, $pop207, $pop206
	i32.const	$push106=, 64
	i32.add 	$push107=, $9, $pop106
	i32.const	$push205=, 8
	i32.or  	$push66=, $pop107, $pop205
	i32.const	$push204=, 8
	i32.call	$drop=, memcpy@FUNCTION, $pop66, $5, $pop204
	i32.const	$push108=, 8
	i32.add 	$push109=, $9, $pop108
	i32.const	$push203=, 8
	i32.add 	$push68=, $pop109, $pop203
	i64.load	$push69=, 0($pop68)
	i64.const	$push71=, 3607749779137757184
	i64.load	$push67=, 0($8)
	i64.const	$push202=, 8
	i64.shr_u	$push201=, $pop67, $pop202
	tee_local	$push200=, $1=, $pop201
	i32.const	$push110=, 64
	i32.add 	$push111=, $9, $pop110
	i32.const	$push70=, 16
	i32.call	$push199=, db_store_i64@FUNCTION, $pop69, $pop71, $3, $pop200, $pop111, $pop70
	tee_local	$push198=, $2=, $pop199
	i32.store	20($0), $pop198
	block   	
	i32.const	$push112=, 8
	i32.add 	$push113=, $9, $pop112
	i32.const	$push197=, 16
	i32.add 	$push196=, $pop113, $pop197
	tee_local	$push195=, $7=, $pop196
	i64.load	$push72=, 0($pop195)
	i64.lt_u	$push73=, $1, $pop72
	br_if   	0, $pop73
	i64.const	$push74=, 1
	i64.add 	$push75=, $1, $pop74
	i64.store	0($7), $pop75
.LBB12_11:
	end_block
	i32.store	56($9), $0
	i64.load	$push76=, 0($8)
	i64.const	$push218=, 8
	i64.shr_u	$push217=, $pop76, $pop218
	tee_local	$push216=, $1=, $pop217
	i64.store	64($9), $pop216
	i32.store	52($9), $2
	block   	
	block   	
	i32.const	$push80=, 36
	i32.add 	$push215=, $9, $pop80
	tee_local	$push214=, $7=, $pop215
	i32.load	$push213=, 0($pop214)
	tee_local	$push212=, $8=, $pop213
	i32.const	$push77=, 40
	i32.add 	$push78=, $9, $pop77
	i32.load	$push79=, 0($pop78)
	i32.ge_u	$push81=, $pop212, $pop79
	br_if   	0, $pop81
	i64.store	8($8), $1
	i32.store	16($8), $2
	i32.const	$push84=, 0
	i32.store	56($9), $pop84
	i32.store	0($8), $0
	i32.const	$push85=, 24
	i32.add 	$push86=, $8, $pop85
	i32.store	0($7), $pop86
	br      	1
.LBB12_13:
	end_block
	i32.const	$push82=, 32
	i32.add 	$push83=, $9, $pop82
	i32.const	$push114=, 56
	i32.add 	$push115=, $9, $pop114
	i32.const	$push116=, 64
	i32.add 	$push117=, $9, $pop116
	i32.const	$push118=, 52
	i32.add 	$push119=, $9, $pop118
	call    	_ZNSt3__16vectorIN5eosio11multi_indexILy3607749779137757184ENS1_5token7accountEJEE8item_ptrENS_9allocatorIS6_EEE24__emplace_back_slow_pathIJNS_10unique_ptrINS5_4itemENS_14default_deleteISC_EEEERyRlEEEvDpOT_@FUNCTION, $pop83, $pop115, $pop117, $pop119
.LBB12_14:
	end_block
	i32.load	$8=, 56($9)
	i32.const	$push87=, 0
	i32.store	56($9), $pop87
	i32.eqz 	$push229=, $8
	br_if   	0, $pop229
	call    	_ZdlPv@FUNCTION, $8
.LBB12_16:
	end_block
	i32.load	$push220=, 32($9)
	tee_local	$push219=, $2=, $pop220
	i32.eqz 	$push230=, $pop219
	br_if   	1, $pop230
.LBB12_17:
	end_block
	block   	
	block   	
	i32.const	$push88=, 36
	i32.add 	$push224=, $9, $pop88
	tee_local	$push223=, $7=, $pop224
	i32.load	$push222=, 0($pop223)
	tee_local	$push221=, $8=, $pop222
	i32.eq  	$push89=, $pop221, $2
	br_if   	0, $pop89
.LBB12_19:
	loop    	
	i32.const	$push228=, -24
	i32.add 	$push227=, $8, $pop228
	tee_local	$push226=, $8=, $pop227
	i32.load	$0=, 0($pop226)
	i32.const	$push225=, 0
	i32.store	0($8), $pop225
	block   	
	i32.eqz 	$push231=, $0
	br_if   	0, $pop231
	call    	_ZdlPv@FUNCTION, $0
.LBB12_21:
	end_block
	i32.ne  	$push90=, $2, $8
	br_if   	0, $pop90
	end_loop
	i32.const	$push91=, 32
	i32.add 	$push92=, $9, $pop91
	i32.load	$8=, 0($pop92)
	br      	1
.LBB12_23:
	end_block
	copy_local	$8=, $2
.LBB12_24:
	end_block
	i32.store	0($7), $2
	call    	_ZdlPv@FUNCTION, $8
.LBB12_25:
	end_block
	i32.const	$push99=, 0
	i32.const	$push97=, 80
	i32.add 	$push98=, $9, $pop97
	i32.store	__stack_pointer($pop99), $pop98
	.endfunc
.Lfunc_end12:
	.size	_ZN5eosio5token11add_balanceEyNS_5assetEy, .Lfunc_end12-_ZN5eosio5token11add_balanceEyNS_5assetEy

	.section	.text._ZN5eosio15dispatch_inlineIJyyNS_5assetENSt3__112basic_stringIcNS2_11char_traitsIcEENS2_9allocatorIcEEEEEEEvyyNS2_6vectorINS_16permission_levelENS6_ISA_EEEENS2_5tupleIJDpT_EEE,"axG",@progbits,_ZN5eosio15dispatch_inlineIJyyNS_5assetENSt3__112basic_stringIcNS2_11char_traitsIcEENS2_9allocatorIcEEEEEEEvyyNS2_6vectorINS_16permission_levelENS6_ISA_EEEENS2_5tupleIJDpT_EEE,comdat
	.hidden	_ZN5eosio15dispatch_inlineIJyyNS_5assetENSt3__112basic_stringIcNS2_11char_traitsIcEENS2_9allocatorIcEEEEEEEvyyNS2_6vectorINS_16permission_levelENS6_ISA_EEEENS2_5tupleIJDpT_EEE
	.weak	_ZN5eosio15dispatch_inlineIJyyNS_5assetENSt3__112basic_stringIcNS2_11char_traitsIcEENS2_9allocatorIcEEEEEEEvyyNS2_6vectorINS_16permission_levelENS6_ISA_EEEENS2_5tupleIJDpT_EEE
	.type	_ZN5eosio15dispatch_inlineIJyyNS_5assetENSt3__112basic_stringIcNS2_11char_traitsIcEENS2_9allocatorIcEEEEEEEvyyNS2_6vectorINS_16permission_levelENS6_ISA_EEEENS2_5tupleIJDpT_EEE,@function
_ZN5eosio15dispatch_inlineIJyyNS_5assetENSt3__112basic_stringIcNS2_11char_traitsIcEENS2_9allocatorIcEEEEEEEvyyNS2_6vectorINS_16permission_levelENS6_ISA_EEEENS2_5tupleIJDpT_EEE:
	.param  	i64, i64, i32, i32
	.local  	i32, i32, i32, i32, i32, i32
	i32.const	$push42=, 0
	i32.const	$push39=, 0
	i32.load	$push40=, __stack_pointer($pop39)
	i32.const	$push41=, 96
	i32.sub 	$push69=, $pop40, $pop41
	tee_local	$push68=, $9=, $pop69
	i32.store	__stack_pointer($pop42), $pop68
	i32.const	$push67=, 0
	i32.store	16($9), $pop67
	i64.const	$push66=, 0
	i64.store	8($9), $pop66
	i32.const	$6=, 0
	i32.const	$7=, 0
	i32.const	$8=, 0
	block   	
	block   	
	i32.load	$push1=, 4($2)
	i32.load	$push0=, 0($2)
	i32.sub 	$push65=, $pop1, $pop0
	tee_local	$push64=, $4=, $pop65
	i32.const	$push2=, 4
	i32.shr_s	$push63=, $pop64, $pop2
	tee_local	$push62=, $5=, $pop63
	i32.eqz 	$push109=, $pop62
	br_if   	0, $pop109
	i32.const	$push3=, 268435456
	i32.ge_u	$push4=, $5, $pop3
	br_if   	1, $pop4
	i32.const	$push7=, 16
	i32.add 	$push8=, $9, $pop7
	i32.call	$push78=, _Znwj@FUNCTION, $4
	tee_local	$push77=, $8=, $pop78
	i32.const	$push5=, 4
	i32.shl 	$push6=, $5, $pop5
	i32.add 	$push76=, $pop77, $pop6
	tee_local	$push75=, $6=, $pop76
	i32.store	0($pop8), $pop75
	i32.store	8($9), $8
	i32.store	12($9), $8
	block   	
	i32.const	$push74=, 4
	i32.add 	$push9=, $2, $pop74
	i32.load	$push10=, 0($pop9)
	i32.load	$push73=, 0($2)
	tee_local	$push72=, $7=, $pop73
	i32.sub 	$push71=, $pop10, $pop72
	tee_local	$push70=, $2=, $pop71
	i32.const	$push11=, 1
	i32.lt_s	$push12=, $pop70, $pop11
	br_if   	0, $pop12
	i32.call	$drop=, memcpy@FUNCTION, $8, $7, $2
	i32.add 	$push80=, $8, $2
	tee_local	$push79=, $7=, $pop80
	i32.store	12($9), $pop79
	br      	1
.LBB13_4:
	end_block
	copy_local	$7=, $8
.LBB13_5:
	end_block
	i32.const	$push13=, 44
	i32.add 	$push14=, $9, $pop13
	i32.store	0($pop14), $7
	i64.store	32($9), $1
	i32.const	$push15=, 16
	i32.add 	$push16=, $9, $pop15
	i32.const	$push93=, 0
	i32.store	0($pop16), $pop93
	i32.const	$push17=, 48
	i32.add 	$push18=, $9, $pop17
	i32.store	0($pop18), $6
	i64.store	24($9), $0
	i32.store	40($9), $8
	i64.const	$push92=, 0
	i64.store	8($9), $pop92
	i32.const	$push91=, 0
	i32.store	52($9), $pop91
	i32.const	$push46=, 24
	i32.add 	$push47=, $9, $pop46
	i32.const	$push19=, 32
	i32.add 	$push20=, $pop47, $pop19
	i32.const	$push90=, 0
	i32.store	0($pop20), $pop90
	i32.const	$push48=, 24
	i32.add 	$push49=, $9, $pop48
	i32.const	$push21=, 36
	i32.add 	$push22=, $pop49, $pop21
	i32.const	$push89=, 0
	i32.store	0($pop22), $pop89
	i32.const	$push88=, 36
	i32.add 	$push25=, $3, $pop88
	i32.load	$push26=, 0($pop25)
	i32.load8_u	$push87=, 32($3)
	tee_local	$push86=, $8=, $pop87
	i32.const	$push85=, 1
	i32.shr_u	$push24=, $pop86, $pop85
	i32.const	$push84=, 1
	i32.and 	$push23=, $8, $pop84
	i32.select	$push83=, $pop26, $pop24, $pop23
	tee_local	$push82=, $2=, $pop83
	i32.const	$push81=, 32
	i32.add 	$8=, $pop82, $pop81
	i64.extend_u/i32	$0=, $2
	i32.const	$push27=, 52
	i32.add 	$2=, $9, $pop27
.LBB13_6:
	loop    	
	i32.const	$push98=, 1
	i32.add 	$8=, $8, $pop98
	i64.const	$push97=, 7
	i64.shr_u	$push96=, $0, $pop97
	tee_local	$push95=, $0=, $pop96
	i64.const	$push94=, 0
	i64.ne  	$push28=, $pop95, $pop94
	br_if   	0, $pop28
	end_loop
	block   	
	block   	
	i32.eqz 	$push110=, $8
	br_if   	0, $pop110
	call    	_ZNSt3__16vectorIcNS_9allocatorIcEEE8__appendEj@FUNCTION, $2, $8
	i32.const	$push29=, 56
	i32.add 	$push30=, $9, $pop29
	i32.load	$2=, 0($pop30)
	i32.const	$push31=, 52
	i32.add 	$push32=, $9, $pop31
	i32.load	$8=, 0($pop32)
	br      	1
.LBB13_9:
	end_block
	i32.const	$2=, 0
	i32.const	$8=, 0
.LBB13_10:
	end_block
	i32.store	84($9), $8
	i32.store	80($9), $8
	i32.store	88($9), $2
	i32.const	$push50=, 80
	i32.add 	$push51=, $9, $pop50
	i32.store	64($9), $pop51
	i32.store	72($9), $3
	i32.const	$push52=, 72
	i32.add 	$push53=, $9, $pop52
	i32.const	$push54=, 64
	i32.add 	$push55=, $9, $pop54
	call    	_ZN5boost6fusion6detail17for_each_unrolledILi4EE4callINS0_18std_tuple_iteratorIKNSt3__15tupleIJyyN5eosio5assetENS6_12basic_stringIcNS6_11char_traitsIcEENS6_9allocatorIcEEEEEEELi0EEEZNS8_lsINS8_10datastreamIPcEEJyyS9_SF_EEERT_SO_RKNS7_IJDpT0_EEEEUlRKSN_E_EEvSV_RKT0_@FUNCTION, $pop53, $pop55
	i32.const	$push56=, 80
	i32.add 	$push57=, $9, $pop56
	i32.const	$push58=, 24
	i32.add 	$push59=, $9, $pop58
	call    	_ZN5eosio4packINS_6actionEEENSt3__16vectorIcNS2_9allocatorIcEEEERKT_@FUNCTION, $pop57, $pop59
	i32.load	$push102=, 80($9)
	tee_local	$push101=, $8=, $pop102
	i32.load	$push33=, 84($9)
	i32.sub 	$push34=, $pop33, $8
	call    	send_inline@FUNCTION, $pop101, $pop34
	block   	
	i32.load	$push100=, 80($9)
	tee_local	$push99=, $8=, $pop100
	i32.eqz 	$push111=, $pop99
	br_if   	0, $pop111
	i32.store	84($9), $8
	call    	_ZdlPv@FUNCTION, $8
.LBB13_12:
	end_block
	block   	
	i32.load	$push104=, 52($9)
	tee_local	$push103=, $8=, $pop104
	i32.eqz 	$push112=, $pop103
	br_if   	0, $pop112
	i32.const	$push35=, 56
	i32.add 	$push36=, $9, $pop35
	i32.store	0($pop36), $8
	call    	_ZdlPv@FUNCTION, $8
.LBB13_14:
	end_block
	block   	
	i32.load	$push106=, 40($9)
	tee_local	$push105=, $8=, $pop106
	i32.eqz 	$push113=, $pop105
	br_if   	0, $pop113
	i32.const	$push37=, 44
	i32.add 	$push38=, $9, $pop37
	i32.store	0($pop38), $8
	call    	_ZdlPv@FUNCTION, $8
.LBB13_16:
	end_block
	block   	
	i32.load	$push108=, 8($9)
	tee_local	$push107=, $8=, $pop108
	i32.eqz 	$push114=, $pop107
	br_if   	0, $pop114
	i32.store	12($9), $8
	call    	_ZdlPv@FUNCTION, $8
.LBB13_18:
	end_block
	i32.const	$push45=, 0
	i32.const	$push43=, 96
	i32.add 	$push44=, $9, $pop43
	i32.store	__stack_pointer($pop45), $pop44
	return
.LBB13_19:
	end_block
	i32.const	$push60=, 8
	i32.add 	$push61=, $9, $pop60
	call    	_ZNKSt3__120__vector_base_commonILb1EE20__throw_length_errorEv@FUNCTION, $pop61
	unreachable
	.endfunc
.Lfunc_end13:
	.size	_ZN5eosio15dispatch_inlineIJyyNS_5assetENSt3__112basic_stringIcNS2_11char_traitsIcEENS2_9allocatorIcEEEEEEEvyyNS2_6vectorINS_16permission_levelENS6_ISA_EEEENS2_5tupleIJDpT_EEE, .Lfunc_end13-_ZN5eosio15dispatch_inlineIJyyNS_5assetENSt3__112basic_stringIcNS2_11char_traitsIcEENS2_9allocatorIcEEEEEEEvyyNS2_6vectorINS_16permission_levelENS6_ISA_EEEENS2_5tupleIJDpT_EEE

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
.LBB14_4:
	end_block
	i32.call	$2=, _Znwj@FUNCTION, $6
	br      	3
.LBB14_5:
	end_block
	i32.const	$push2=, 4
	i32.add 	$0=, $0, $pop2
.LBB14_6:
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
.LBB14_7:
	end_loop
	end_block
	i32.const	$6=, 0
	i32.const	$2=, 0
	br      	1
.LBB14_8:
	end_block
	call    	_ZNKSt3__120__vector_base_commonILb1EE20__throw_length_errorEv@FUNCTION, $0
	unreachable
.LBB14_9:
	end_block
	i32.add 	$4=, $2, $6
	i32.add 	$push33=, $2, $3
	tee_local	$push32=, $5=, $pop33
	copy_local	$6=, $pop32
.LBB14_10:
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
.LBB14_13:
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
.LBB14_15:
	end_block
	.endfunc
.Lfunc_end14:
	.size	_ZNSt3__16vectorIcNS_9allocatorIcEEE8__appendEj, .Lfunc_end14-_ZNSt3__16vectorIcNS_9allocatorIcEEE8__appendEj

	.section	.text._ZN5boost6fusion6detail17for_each_unrolledILi4EE4callINS0_18std_tuple_iteratorIKNSt3__15tupleIJyyN5eosio5assetENS6_12basic_stringIcNS6_11char_traitsIcEENS6_9allocatorIcEEEEEEELi0EEEZNS8_lsINS8_10datastreamIPcEEJyyS9_SF_EEERT_SO_RKNS7_IJDpT0_EEEEUlRKSN_E_EEvSV_RKT0_,"axG",@progbits,_ZN5boost6fusion6detail17for_each_unrolledILi4EE4callINS0_18std_tuple_iteratorIKNSt3__15tupleIJyyN5eosio5assetENS6_12basic_stringIcNS6_11char_traitsIcEENS6_9allocatorIcEEEEEEELi0EEEZNS8_lsINS8_10datastreamIPcEEJyyS9_SF_EEERT_SO_RKNS7_IJDpT0_EEEEUlRKSN_E_EEvSV_RKT0_,comdat
	.hidden	_ZN5boost6fusion6detail17for_each_unrolledILi4EE4callINS0_18std_tuple_iteratorIKNSt3__15tupleIJyyN5eosio5assetENS6_12basic_stringIcNS6_11char_traitsIcEENS6_9allocatorIcEEEEEEELi0EEEZNS8_lsINS8_10datastreamIPcEEJyyS9_SF_EEERT_SO_RKNS7_IJDpT0_EEEEUlRKSN_E_EEvSV_RKT0_
	.weak	_ZN5boost6fusion6detail17for_each_unrolledILi4EE4callINS0_18std_tuple_iteratorIKNSt3__15tupleIJyyN5eosio5assetENS6_12basic_stringIcNS6_11char_traitsIcEENS6_9allocatorIcEEEEEEELi0EEEZNS8_lsINS8_10datastreamIPcEEJyyS9_SF_EEERT_SO_RKNS7_IJDpT0_EEEEUlRKSN_E_EEvSV_RKT0_
	.type	_ZN5boost6fusion6detail17for_each_unrolledILi4EE4callINS0_18std_tuple_iteratorIKNSt3__15tupleIJyyN5eosio5assetENS6_12basic_stringIcNS6_11char_traitsIcEENS6_9allocatorIcEEEEEEELi0EEEZNS8_lsINS8_10datastreamIPcEEJyyS9_SF_EEERT_SO_RKNS7_IJDpT0_EEEEUlRKSN_E_EEvSV_RKT0_,@function
_ZN5boost6fusion6detail17for_each_unrolledILi4EE4callINS0_18std_tuple_iteratorIKNSt3__15tupleIJyyN5eosio5assetENS6_12basic_stringIcNS6_11char_traitsIcEENS6_9allocatorIcEEEEEEELi0EEEZNS8_lsINS8_10datastreamIPcEEJyyS9_SF_EEERT_SO_RKNS7_IJDpT0_EEEEUlRKSN_E_EEvSV_RKT0_:
	.param  	i32, i32
	.local  	i32, i32
	i32.load	$2=, 0($0)
	i32.load	$push58=, 0($1)
	tee_local	$push57=, $3=, $pop58
	i32.load	$push1=, 8($pop57)
	i32.load	$push0=, 4($3)
	i32.sub 	$push2=, $pop1, $pop0
	i32.const	$push3=, 7
	i32.gt_s	$push4=, $pop2, $pop3
	i32.const	$push5=, .L.str.27
	call    	eosio_assert@FUNCTION, $pop4, $pop5
	i32.load	$push6=, 4($3)
	i32.const	$push7=, 8
	i32.call	$drop=, memcpy@FUNCTION, $pop6, $2, $pop7
	i32.load	$push8=, 4($3)
	i32.const	$push56=, 8
	i32.add 	$push9=, $pop8, $pop56
	i32.store	4($3), $pop9
	i32.load	$0=, 0($0)
	i32.load	$push55=, 0($1)
	tee_local	$push54=, $3=, $pop55
	i32.load	$push11=, 8($pop54)
	i32.load	$push10=, 4($3)
	i32.sub 	$push12=, $pop11, $pop10
	i32.const	$push53=, 7
	i32.gt_s	$push13=, $pop12, $pop53
	i32.const	$push52=, .L.str.27
	call    	eosio_assert@FUNCTION, $pop13, $pop52
	i32.load	$push15=, 4($3)
	i32.const	$push51=, 8
	i32.add 	$push14=, $0, $pop51
	i32.const	$push50=, 8
	i32.call	$drop=, memcpy@FUNCTION, $pop15, $pop14, $pop50
	i32.load	$push16=, 4($3)
	i32.const	$push49=, 8
	i32.add 	$push17=, $pop16, $pop49
	i32.store	4($3), $pop17
	i32.load	$push48=, 0($1)
	tee_local	$push47=, $3=, $pop48
	i32.load	$push19=, 8($pop47)
	i32.load	$push18=, 4($3)
	i32.sub 	$push20=, $pop19, $pop18
	i32.const	$push46=, 7
	i32.gt_s	$push21=, $pop20, $pop46
	i32.const	$push45=, .L.str.27
	call    	eosio_assert@FUNCTION, $pop21, $pop45
	i32.load	$push24=, 4($3)
	i32.const	$push22=, 16
	i32.add 	$push23=, $0, $pop22
	i32.const	$push44=, 8
	i32.call	$drop=, memcpy@FUNCTION, $pop24, $pop23, $pop44
	i32.load	$push25=, 4($3)
	i32.const	$push43=, 8
	i32.add 	$push42=, $pop25, $pop43
	tee_local	$push41=, $2=, $pop42
	i32.store	4($3), $pop41
	i32.load	$push26=, 8($3)
	i32.sub 	$push27=, $pop26, $2
	i32.const	$push40=, 7
	i32.gt_s	$push28=, $pop27, $pop40
	i32.const	$push39=, .L.str.27
	call    	eosio_assert@FUNCTION, $pop28, $pop39
	i32.load	$push31=, 4($3)
	i32.const	$push29=, 24
	i32.add 	$push30=, $0, $pop29
	i32.const	$push38=, 8
	i32.call	$drop=, memcpy@FUNCTION, $pop31, $pop30, $pop38
	i32.load	$push32=, 4($3)
	i32.const	$push37=, 8
	i32.add 	$push33=, $pop32, $pop37
	i32.store	4($3), $pop33
	i32.load	$push36=, 0($1)
	i32.const	$push34=, 32
	i32.add 	$push35=, $0, $pop34
	i32.call	$drop=, _ZN5eosiolsINS_10datastreamIPcEEEERT_S5_RKNSt3__112basic_stringIcNS6_11char_traitsIcEENS6_9allocatorIcEEEE@FUNCTION, $pop36, $pop35
	.endfunc
.Lfunc_end15:
	.size	_ZN5boost6fusion6detail17for_each_unrolledILi4EE4callINS0_18std_tuple_iteratorIKNSt3__15tupleIJyyN5eosio5assetENS6_12basic_stringIcNS6_11char_traitsIcEENS6_9allocatorIcEEEEEEELi0EEEZNS8_lsINS8_10datastreamIPcEEJyyS9_SF_EEERT_SO_RKNS7_IJDpT0_EEEEUlRKSN_E_EEvSV_RKT0_, .Lfunc_end15-_ZN5boost6fusion6detail17for_each_unrolledILi4EE4callINS0_18std_tuple_iteratorIKNSt3__15tupleIJyyN5eosio5assetENS6_12basic_stringIcNS6_11char_traitsIcEENS6_9allocatorIcEEEEEEELi0EEEZNS8_lsINS8_10datastreamIPcEEJyyS9_SF_EEERT_SO_RKNS7_IJDpT0_EEEEUlRKSN_E_EEvSV_RKT0_

	.section	.text._ZN5eosio4packINS_6actionEEENSt3__16vectorIcNS2_9allocatorIcEEEERKT_,"axG",@progbits,_ZN5eosio4packINS_6actionEEENSt3__16vectorIcNS2_9allocatorIcEEEERKT_,comdat
	.hidden	_ZN5eosio4packINS_6actionEEENSt3__16vectorIcNS2_9allocatorIcEEEERKT_
	.weak	_ZN5eosio4packINS_6actionEEENSt3__16vectorIcNS2_9allocatorIcEEEERKT_
	.type	_ZN5eosio4packINS_6actionEEENSt3__16vectorIcNS2_9allocatorIcEEEERKT_,@function
_ZN5eosio4packINS_6actionEEENSt3__16vectorIcNS2_9allocatorIcEEEERKT_:
	.param  	i32, i32
	.local  	i32, i32, i32, i32, i64, i32, i32
	i32.const	$push32=, 0
	i32.const	$push29=, 0
	i32.load	$push30=, __stack_pointer($pop29)
	i32.const	$push31=, 16
	i32.sub 	$push45=, $pop30, $pop31
	tee_local	$push44=, $8=, $pop45
	i32.store	__stack_pointer($pop32), $pop44
	i32.const	$push1=, 0
	i32.store	8($0), $pop1
	i64.const	$push43=, 0
	i64.store	0($0):p2align=2, $pop43
	i32.const	$5=, 16
	i32.const	$push42=, 16
	i32.add 	$2=, $1, $pop42
	i32.const	$push2=, 20
	i32.add 	$push3=, $1, $pop2
	i32.load	$push41=, 0($pop3)
	tee_local	$push40=, $7=, $pop41
	i32.load	$push39=, 16($1)
	tee_local	$push38=, $3=, $pop39
	i32.sub 	$push37=, $pop40, $pop38
	tee_local	$push36=, $4=, $pop37
	i32.const	$push4=, 4
	i32.shr_s	$push5=, $pop36, $pop4
	i64.extend_u/i32	$6=, $pop5
.LBB16_1:
	loop    	
	i32.const	$push50=, 1
	i32.add 	$5=, $5, $pop50
	i64.const	$push49=, 7
	i64.shr_u	$push48=, $6, $pop49
	tee_local	$push47=, $6=, $pop48
	i64.const	$push46=, 0
	i64.ne  	$push6=, $pop47, $pop46
	br_if   	0, $pop6
	end_loop
	block   	
	i32.eq  	$push7=, $3, $7
	br_if   	0, $pop7
	i32.const	$push8=, -16
	i32.and 	$push9=, $4, $pop8
	i32.add 	$5=, $pop9, $5
.LBB16_4:
	end_block
	i32.load	$push54=, 28($1)
	tee_local	$push53=, $7=, $pop54
	i32.sub 	$push10=, $pop53, $5
	i32.const	$push11=, 32
	i32.add 	$push12=, $1, $pop11
	i32.load	$push52=, 0($pop12)
	tee_local	$push51=, $3=, $pop52
	i32.sub 	$5=, $pop10, $pop51
	i32.const	$push13=, 28
	i32.add 	$4=, $1, $pop13
	i32.sub 	$push14=, $3, $7
	i64.extend_u/i32	$6=, $pop14
.LBB16_5:
	loop    	
	i32.const	$push59=, -1
	i32.add 	$5=, $5, $pop59
	i64.const	$push58=, 7
	i64.shr_u	$push57=, $6, $pop58
	tee_local	$push56=, $6=, $pop57
	i64.const	$push55=, 0
	i64.ne  	$push15=, $pop56, $pop55
	br_if   	0, $pop15
	end_loop
	i32.const	$7=, 0
	block   	
	block   	
	i32.eqz 	$push68=, $5
	br_if   	0, $pop68
	i32.const	$push60=, 0
	i32.sub 	$push0=, $pop60, $5
	call    	_ZNSt3__16vectorIcNS_9allocatorIcEEE8__appendEj@FUNCTION, $0, $pop0
	i32.const	$push16=, 4
	i32.add 	$push17=, $0, $pop16
	i32.load	$7=, 0($pop17)
	i32.load	$5=, 0($0)
	br      	1
.LBB16_8:
	end_block
	i32.const	$5=, 0
.LBB16_9:
	end_block
	i32.store	0($8), $5
	i32.store	8($8), $7
	i32.sub 	$push18=, $7, $5
	i32.const	$push19=, 7
	i32.gt_s	$push20=, $pop18, $pop19
	i32.const	$push21=, .L.str.27
	call    	eosio_assert@FUNCTION, $pop20, $pop21
	i32.const	$push22=, 8
	i32.call	$drop=, memcpy@FUNCTION, $5, $1, $pop22
	i32.const	$push67=, 8
	i32.add 	$push66=, $5, $pop67
	tee_local	$push65=, $0=, $pop66
	i32.sub 	$push23=, $7, $pop65
	i32.const	$push64=, 7
	i32.gt_s	$push24=, $pop23, $pop64
	i32.const	$push63=, .L.str.27
	call    	eosio_assert@FUNCTION, $pop24, $pop63
	i32.const	$push62=, 8
	i32.add 	$push25=, $1, $pop62
	i32.const	$push61=, 8
	i32.call	$drop=, memcpy@FUNCTION, $0, $pop25, $pop61
	i32.const	$push26=, 16
	i32.add 	$push27=, $5, $pop26
	i32.store	4($8), $pop27
	i32.call	$push28=, _ZN5eosiolsINS_10datastreamIPcEENS_16permission_levelEEERT_S6_RKNSt3__16vectorIT0_NS7_9allocatorIS9_EEEE@FUNCTION, $8, $2
	i32.call	$drop=, _ZN5eosiolsINS_10datastreamIPcEEEERT_S5_RKNSt3__16vectorIcNS6_9allocatorIcEEEE@FUNCTION, $pop28, $4
	i32.const	$push35=, 0
	i32.const	$push33=, 16
	i32.add 	$push34=, $8, $pop33
	i32.store	__stack_pointer($pop35), $pop34
	.endfunc
.Lfunc_end16:
	.size	_ZN5eosio4packINS_6actionEEENSt3__16vectorIcNS2_9allocatorIcEEEERKT_, .Lfunc_end16-_ZN5eosio4packINS_6actionEEENSt3__16vectorIcNS2_9allocatorIcEEEERKT_

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
.LBB17_1:
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
	i32.const	$push46=, .L.str.27
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
.LBB17_4:
	loop    	
	i32.const	$push80=, 8
	i32.add 	$push79=, $0, $pop80
	tee_local	$push78=, $2=, $pop79
	i32.load	$push15=, 0($pop78)
	i32.sub 	$push16=, $pop15, $5
	i32.const	$push77=, 7
	i32.gt_s	$push17=, $pop16, $pop77
	i32.const	$push76=, .L.str.27
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
	i32.const	$push70=, .L.str.27
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
.LBB17_5:
	end_loop
	end_block
	i32.const	$push33=, 0
	i32.const	$push31=, 16
	i32.add 	$push32=, $7, $pop31
	i32.store	__stack_pointer($pop33), $pop32
	copy_local	$push81=, $0
	.endfunc
.Lfunc_end17:
	.size	_ZN5eosiolsINS_10datastreamIPcEENS_16permission_levelEEERT_S6_RKNSt3__16vectorIT0_NS7_9allocatorIS9_EEEE, .Lfunc_end17-_ZN5eosiolsINS_10datastreamIPcEENS_16permission_levelEEERT_S6_RKNSt3__16vectorIT0_NS7_9allocatorIS9_EEEE

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
.LBB18_1:
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
	i32.const	$push40=, .L.str.27
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
	i32.const	$push21=, .L.str.27
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
.Lfunc_end18:
	.size	_ZN5eosiolsINS_10datastreamIPcEEEERT_S5_RKNSt3__16vectorIcNS6_9allocatorIcEEEE, .Lfunc_end18-_ZN5eosiolsINS_10datastreamIPcEEEERT_S5_RKNSt3__16vectorIcNS6_9allocatorIcEEEE

	.section	.text._ZN5eosiolsINS_10datastreamIPcEEEERT_S5_RKNSt3__112basic_stringIcNS6_11char_traitsIcEENS6_9allocatorIcEEEE,"axG",@progbits,_ZN5eosiolsINS_10datastreamIPcEEEERT_S5_RKNSt3__112basic_stringIcNS6_11char_traitsIcEENS6_9allocatorIcEEEE,comdat
	.hidden	_ZN5eosiolsINS_10datastreamIPcEEEERT_S5_RKNSt3__112basic_stringIcNS6_11char_traitsIcEENS6_9allocatorIcEEEE
	.weak	_ZN5eosiolsINS_10datastreamIPcEEEERT_S5_RKNSt3__112basic_stringIcNS6_11char_traitsIcEENS6_9allocatorIcEEEE
	.type	_ZN5eosiolsINS_10datastreamIPcEEEERT_S5_RKNSt3__112basic_stringIcNS6_11char_traitsIcEENS6_9allocatorIcEEEE,@function
_ZN5eosiolsINS_10datastreamIPcEEEERT_S5_RKNSt3__112basic_stringIcNS6_11char_traitsIcEENS6_9allocatorIcEEEE:
	.param  	i32, i32
	.result 	i32
	.local  	i32, i32, i32, i32, i32, i64, i32
	i32.const	$push31=, 0
	i32.const	$push28=, 0
	i32.load	$push29=, __stack_pointer($pop28)
	i32.const	$push30=, 16
	i32.sub 	$push42=, $pop29, $pop30
	tee_local	$push41=, $8=, $pop42
	i32.store	__stack_pointer($pop31), $pop41
	i32.load	$push2=, 4($1)
	i32.load8_u	$push40=, 0($1)
	tee_local	$push39=, $5=, $pop40
	i32.const	$push38=, 1
	i32.shr_u	$push1=, $pop39, $pop38
	i32.const	$push37=, 1
	i32.and 	$push0=, $5, $pop37
	i32.select	$push3=, $pop2, $pop1, $pop0
	i64.extend_u/i32	$7=, $pop3
	i32.load	$6=, 4($0)
	i32.const	$push7=, 8
	i32.add 	$4=, $0, $pop7
	i32.const	$push11=, 4
	i32.add 	$5=, $0, $pop11
.LBB19_1:
	loop    	
	i32.wrap/i64	$2=, $7
	i64.const	$push56=, 7
	i64.shr_u	$push55=, $7, $pop56
	tee_local	$push54=, $7=, $pop55
	i64.const	$push53=, 0
	i64.ne  	$push52=, $pop54, $pop53
	tee_local	$push51=, $3=, $pop52
	i32.const	$push50=, 7
	i32.shl 	$push5=, $pop51, $pop50
	i32.const	$push49=, 127
	i32.and 	$push4=, $2, $pop49
	i32.or  	$push6=, $pop5, $pop4
	i32.store8	15($8), $pop6
	i32.load	$push8=, 0($4)
	i32.sub 	$push9=, $pop8, $6
	i32.const	$push48=, 0
	i32.gt_s	$push10=, $pop9, $pop48
	i32.const	$push47=, .L.str.27
	call    	eosio_assert@FUNCTION, $pop10, $pop47
	i32.load	$push12=, 0($5)
	i32.const	$push35=, 15
	i32.add 	$push36=, $8, $pop35
	i32.const	$push46=, 1
	i32.call	$drop=, memcpy@FUNCTION, $pop12, $pop36, $pop46
	i32.load	$push13=, 0($5)
	i32.const	$push45=, 1
	i32.add 	$push44=, $pop13, $pop45
	tee_local	$push43=, $6=, $pop44
	i32.store	0($5), $pop43
	br_if   	0, $3
	end_loop
	block   	
	i32.const	$push65=, 4
	i32.add 	$push15=, $1, $pop65
	i32.load	$push16=, 0($pop15)
	i32.load8_u	$push64=, 0($1)
	tee_local	$push63=, $5=, $pop64
	i32.const	$push62=, 1
	i32.shr_u	$push14=, $pop63, $pop62
	i32.const	$push61=, 1
	i32.and 	$push60=, $5, $pop61
	tee_local	$push59=, $2=, $pop60
	i32.select	$push58=, $pop16, $pop14, $pop59
	tee_local	$push57=, $5=, $pop58
	i32.eqz 	$push70=, $pop57
	br_if   	0, $pop70
	i32.load	$3=, 8($1)
	i32.const	$push17=, 8
	i32.add 	$push18=, $0, $pop17
	i32.load	$push19=, 0($pop18)
	i32.sub 	$push20=, $pop19, $6
	i32.ge_s	$push21=, $pop20, $5
	i32.const	$push22=, .L.str.27
	call    	eosio_assert@FUNCTION, $pop21, $pop22
	i32.const	$push69=, 4
	i32.add 	$push68=, $0, $pop69
	tee_local	$push67=, $6=, $pop68
	i32.load	$push25=, 0($pop67)
	i32.const	$push66=, 1
	i32.add 	$push23=, $1, $pop66
	i32.select	$push24=, $3, $pop23, $2
	i32.call	$drop=, memcpy@FUNCTION, $pop25, $pop24, $5
	i32.load	$push26=, 0($6)
	i32.add 	$push27=, $pop26, $5
	i32.store	0($6), $pop27
.LBB19_4:
	end_block
	i32.const	$push34=, 0
	i32.const	$push32=, 16
	i32.add 	$push33=, $8, $pop32
	i32.store	__stack_pointer($pop34), $pop33
	copy_local	$push71=, $0
	.endfunc
.Lfunc_end19:
	.size	_ZN5eosiolsINS_10datastreamIPcEEEERT_S5_RKNSt3__112basic_stringIcNS6_11char_traitsIcEENS6_9allocatorIcEEEE, .Lfunc_end19-_ZN5eosiolsINS_10datastreamIPcEEEERT_S5_RKNSt3__112basic_stringIcNS6_11char_traitsIcEENS6_9allocatorIcEEEE

	.section	.text._ZNK5eosio11multi_indexILy3607749779137757184ENS_5token7accountEJEE31load_object_by_primary_iteratorEl,"axG",@progbits,_ZNK5eosio11multi_indexILy3607749779137757184ENS_5token7accountEJEE31load_object_by_primary_iteratorEl,comdat
	.hidden	_ZNK5eosio11multi_indexILy3607749779137757184ENS_5token7accountEJEE31load_object_by_primary_iteratorEl
	.weak	_ZNK5eosio11multi_indexILy3607749779137757184ENS_5token7accountEJEE31load_object_by_primary_iteratorEl
	.type	_ZNK5eosio11multi_indexILy3607749779137757184ENS_5token7accountEJEE31load_object_by_primary_iteratorEl,@function
_ZNK5eosio11multi_indexILy3607749779137757184ENS_5token7accountEJEE31load_object_by_primary_iteratorEl:
	.param  	i32, i32
	.result 	i32
	.local  	i32, i32, i32, i32, i32, i32, i64, i32, i32
	i32.const	$push60=, 0
	i32.load	$push61=, __stack_pointer($pop60)
	i32.const	$push62=, 32
	i32.sub 	$push79=, $pop61, $pop62
	tee_local	$push78=, $10=, $pop79
	copy_local	$9=, $pop78
	i32.const	$push63=, 0
	i32.store	__stack_pointer($pop63), $10
	block   	
	i32.const	$push0=, 28
	i32.add 	$push1=, $0, $pop0
	i32.load	$push77=, 0($pop1)
	tee_local	$push76=, $7=, $pop77
	i32.load	$push75=, 24($0)
	tee_local	$push74=, $3=, $pop75
	i32.eq  	$push2=, $pop76, $pop74
	br_if   	0, $pop2
	i32.const	$push3=, 0
	i32.sub 	$4=, $pop3, $3
	i32.const	$push80=, -24
	i32.add 	$6=, $7, $pop80
.LBB20_2:
	loop    	
	i32.const	$push81=, 16
	i32.add 	$push4=, $6, $pop81
	i32.load	$push5=, 0($pop4)
	i32.eq  	$push6=, $pop5, $1
	br_if   	1, $pop6
	copy_local	$7=, $6
	i32.const	$push85=, -24
	i32.add 	$push84=, $6, $pop85
	tee_local	$push83=, $5=, $pop84
	copy_local	$6=, $pop83
	i32.add 	$push7=, $5, $4
	i32.const	$push82=, -24
	i32.ne  	$push8=, $pop7, $pop82
	br_if   	0, $pop8
.LBB20_4:
	end_loop
	end_block
	block   	
	block   	
	i32.eq  	$push9=, $7, $3
	br_if   	0, $pop9
	i32.const	$push10=, -24
	i32.add 	$push11=, $7, $pop10
	i32.load	$5=, 0($pop11)
	br      	1
.LBB20_6:
	end_block
	i32.const	$push12=, 0
	i32.const	$push88=, 0
	i32.call	$push87=, db_get_i64@FUNCTION, $1, $pop12, $pop88
	tee_local	$push86=, $7=, $pop87
	i32.const	$push13=, 31
	i32.shr_u	$push14=, $pop86, $pop13
	i32.const	$push15=, 1
	i32.xor 	$push16=, $pop14, $pop15
	i32.const	$push17=, .L.str.21
	call    	eosio_assert@FUNCTION, $pop16, $pop17
	block   	
	block   	
	i32.const	$push18=, 512
	i32.le_u	$push19=, $7, $pop18
	br_if   	0, $pop19
	i32.call	$push90=, malloc@FUNCTION, $7
	tee_local	$push89=, $3=, $pop90
	i32.call	$drop=, db_get_i64@FUNCTION, $1, $pop89, $7
	call    	free@FUNCTION, $3
	br      	1
.LBB20_8:
	end_block
	i32.const	$push59=, 0
	i32.const	$push20=, 15
	i32.add 	$push21=, $7, $pop20
	i32.const	$push22=, -16
	i32.and 	$push23=, $pop21, $pop22
	i32.sub 	$push92=, $10, $pop23
	tee_local	$push91=, $3=, $pop92
	copy_local	$push73=, $pop91
	i32.store	__stack_pointer($pop59), $pop73
	i32.call	$drop=, db_get_i64@FUNCTION, $1, $3, $7
.LBB20_9:
	end_block
	i32.const	$push97=, 24
	i32.add 	$2=, $0, $pop97
	i32.const	$push24=, 32
	i32.call	$push96=, _Znwj@FUNCTION, $pop24
	tee_local	$push95=, $5=, $pop96
	i64.const	$push25=, 1397703940
	i64.store	8($pop95), $pop25
	i64.const	$push94=, 0
	i64.store	0($5), $pop94
	i32.const	$push93=, 1
	i32.const	$push26=, .L.str.23
	call    	eosio_assert@FUNCTION, $pop93, $pop26
	i32.const	$push27=, 8
	i32.add 	$10=, $5, $pop27
	i64.const	$8=, 5459781
	i32.const	$6=, 0
.LBB20_10:
	block   	
	block   	
	loop    	
	i32.wrap/i64	$push28=, $8
	i32.const	$push100=, 24
	i32.shl 	$push29=, $pop28, $pop100
	i32.const	$push99=, -1073741825
	i32.add 	$push30=, $pop29, $pop99
	i32.const	$push98=, 452984830
	i32.gt_u	$push31=, $pop30, $pop98
	br_if   	1, $pop31
	block   	
	i64.const	$push105=, 8
	i64.shr_u	$push104=, $8, $pop105
	tee_local	$push103=, $8=, $pop104
	i64.const	$push102=, 255
	i64.and 	$push32=, $pop103, $pop102
	i64.const	$push101=, 0
	i64.ne  	$push33=, $pop32, $pop101
	br_if   	0, $pop33
.LBB20_12:
	loop    	
	i64.const	$push110=, 8
	i64.shr_u	$push109=, $8, $pop110
	tee_local	$push108=, $8=, $pop109
	i64.const	$push107=, 255
	i64.and 	$push34=, $pop108, $pop107
	i64.const	$push106=, 0
	i64.ne  	$push35=, $pop34, $pop106
	br_if   	3, $pop35
	i32.const	$push114=, 1
	i32.add 	$push113=, $6, $pop114
	tee_local	$push112=, $6=, $pop113
	i32.const	$push111=, 7
	i32.lt_s	$push36=, $pop112, $pop111
	br_if   	0, $pop36
.LBB20_14:
	end_loop
	end_block
	i32.const	$4=, 1
	i32.const	$push118=, 1
	i32.add 	$push117=, $6, $pop118
	tee_local	$push116=, $6=, $pop117
	i32.const	$push115=, 7
	i32.lt_s	$push37=, $pop116, $pop115
	br_if   	0, $pop37
	br      	2
.LBB20_15:
	end_loop
	end_block
	i32.const	$4=, 0
.LBB20_16:
	end_block
	i32.const	$push38=, .L.str
	call    	eosio_assert@FUNCTION, $4, $pop38
	i32.store	16($5), $0
	i32.const	$push39=, 7
	i32.gt_u	$push40=, $7, $pop39
	i32.const	$push41=, .L.str.24
	call    	eosio_assert@FUNCTION, $pop40, $pop41
	i32.const	$push42=, 8
	i32.call	$drop=, memcpy@FUNCTION, $5, $3, $pop42
	i32.const	$push43=, -8
	i32.and 	$push44=, $7, $pop43
	i32.const	$push131=, 8
	i32.ne  	$push45=, $pop44, $pop131
	i32.const	$push130=, .L.str.24
	call    	eosio_assert@FUNCTION, $pop45, $pop130
	i32.const	$push129=, 8
	i32.add 	$push46=, $3, $pop129
	i32.const	$push128=, 8
	i32.call	$drop=, memcpy@FUNCTION, $10, $pop46, $pop128
	i32.store	20($5), $1
	i32.store	24($9), $5
	i32.const	$push127=, 8
	i32.add 	$push47=, $5, $pop127
	i64.load	$push48=, 0($pop47)
	i64.const	$push49=, 8
	i64.shr_u	$push126=, $pop48, $pop49
	tee_local	$push125=, $8=, $pop126
	i64.store	16($9), $pop125
	i32.load	$push124=, 20($5)
	tee_local	$push123=, $7=, $pop124
	i32.store	12($9), $pop123
	block   	
	block   	
	i32.const	$push53=, 28
	i32.add 	$push122=, $0, $pop53
	tee_local	$push121=, $1=, $pop122
	i32.load	$push120=, 0($pop121)
	tee_local	$push119=, $6=, $pop120
	i32.const	$push50=, 32
	i32.add 	$push51=, $0, $pop50
	i32.load	$push52=, 0($pop51)
	i32.ge_u	$push54=, $pop119, $pop52
	br_if   	0, $pop54
	i64.store	8($6), $8
	i32.store	16($6), $7
	i32.const	$push55=, 0
	i32.store	24($9), $pop55
	i32.store	0($6), $5
	i32.const	$push56=, 24
	i32.add 	$push57=, $6, $pop56
	i32.store	0($1), $pop57
	br      	1
.LBB20_18:
	end_block
	i32.const	$push67=, 24
	i32.add 	$push68=, $9, $pop67
	i32.const	$push69=, 16
	i32.add 	$push70=, $9, $pop69
	i32.const	$push71=, 12
	i32.add 	$push72=, $9, $pop71
	call    	_ZNSt3__16vectorIN5eosio11multi_indexILy3607749779137757184ENS1_5token7accountEJEE8item_ptrENS_9allocatorIS6_EEE24__emplace_back_slow_pathIJNS_10unique_ptrINS5_4itemENS_14default_deleteISC_EEEERyRlEEEvDpOT_@FUNCTION, $2, $pop68, $pop70, $pop72
.LBB20_19:
	end_block
	i32.load	$6=, 24($9)
	i32.const	$push58=, 0
	i32.store	24($9), $pop58
	i32.eqz 	$push132=, $6
	br_if   	0, $pop132
	call    	_ZdlPv@FUNCTION, $6
.LBB20_21:
	end_block
	i32.const	$push66=, 0
	i32.const	$push64=, 32
	i32.add 	$push65=, $9, $pop64
	i32.store	__stack_pointer($pop66), $pop65
	copy_local	$push133=, $5
	.endfunc
.Lfunc_end20:
	.size	_ZNK5eosio11multi_indexILy3607749779137757184ENS_5token7accountEJEE31load_object_by_primary_iteratorEl, .Lfunc_end20-_ZNK5eosio11multi_indexILy3607749779137757184ENS_5token7accountEJEE31load_object_by_primary_iteratorEl

	.section	.text._ZNSt3__16vectorIN5eosio11multi_indexILy3607749779137757184ENS1_5token7accountEJEE8item_ptrENS_9allocatorIS6_EEE24__emplace_back_slow_pathIJNS_10unique_ptrINS5_4itemENS_14default_deleteISC_EEEERyRlEEEvDpOT_,"axG",@progbits,_ZNSt3__16vectorIN5eosio11multi_indexILy3607749779137757184ENS1_5token7accountEJEE8item_ptrENS_9allocatorIS6_EEE24__emplace_back_slow_pathIJNS_10unique_ptrINS5_4itemENS_14default_deleteISC_EEEERyRlEEEvDpOT_,comdat
	.hidden	_ZNSt3__16vectorIN5eosio11multi_indexILy3607749779137757184ENS1_5token7accountEJEE8item_ptrENS_9allocatorIS6_EEE24__emplace_back_slow_pathIJNS_10unique_ptrINS5_4itemENS_14default_deleteISC_EEEERyRlEEEvDpOT_
	.weak	_ZNSt3__16vectorIN5eosio11multi_indexILy3607749779137757184ENS1_5token7accountEJEE8item_ptrENS_9allocatorIS6_EEE24__emplace_back_slow_pathIJNS_10unique_ptrINS5_4itemENS_14default_deleteISC_EEEERyRlEEEvDpOT_
	.type	_ZNSt3__16vectorIN5eosio11multi_indexILy3607749779137757184ENS1_5token7accountEJEE8item_ptrENS_9allocatorIS6_EEE24__emplace_back_slow_pathIJNS_10unique_ptrINS5_4itemENS_14default_deleteISC_EEEERyRlEEEvDpOT_,@function
_ZNSt3__16vectorIN5eosio11multi_indexILy3607749779137757184ENS1_5token7accountEJEE8item_ptrENS_9allocatorIS6_EEE24__emplace_back_slow_pathIJNS_10unique_ptrINS5_4itemENS_14default_deleteISC_EEEERyRlEEEvDpOT_:
	.param  	i32, i32, i32, i32
	.local  	i32, i32, i32, i32
	block   	
	block   	
	i32.load	$push0=, 4($0)
	i32.load	$push46=, 0($0)
	tee_local	$push45=, $6=, $pop46
	i32.sub 	$push1=, $pop0, $pop45
	i32.const	$push44=, 24
	i32.div_s	$push43=, $pop1, $pop44
	tee_local	$push42=, $4=, $pop43
	i32.const	$push2=, 1
	i32.add 	$push41=, $pop42, $pop2
	tee_local	$push40=, $5=, $pop41
	i32.const	$push3=, 178956971
	i32.ge_u	$push4=, $pop40, $pop3
	br_if   	0, $pop4
	i32.const	$7=, 178956970
	block   	
	block   	
	i32.load	$push5=, 8($0)
	i32.sub 	$push6=, $pop5, $6
	i32.const	$push49=, 24
	i32.div_s	$push48=, $pop6, $pop49
	tee_local	$push47=, $6=, $pop48
	i32.const	$push7=, 89478484
	i32.gt_u	$push8=, $pop47, $pop7
	br_if   	0, $pop8
	i32.const	$push9=, 1
	i32.shl 	$push53=, $6, $pop9
	tee_local	$push52=, $7=, $pop53
	i32.lt_u	$push10=, $7, $5
	i32.select	$push51=, $5, $pop52, $pop10
	tee_local	$push50=, $7=, $pop51
	i32.eqz 	$push79=, $pop50
	br_if   	1, $pop79
.LBB21_3:
	end_block
	i32.const	$push11=, 24
	i32.mul 	$push12=, $7, $pop11
	i32.call	$6=, _Znwj@FUNCTION, $pop12
	br      	2
.LBB21_4:
	end_block
	i32.const	$7=, 0
	i32.const	$6=, 0
	br      	1
.LBB21_5:
	end_block
	call    	_ZNKSt3__120__vector_base_commonILb1EE20__throw_length_errorEv@FUNCTION, $0
	unreachable
.LBB21_6:
	end_block
	i32.load	$5=, 0($1)
	i32.const	$push62=, 0
	i32.store	0($1), $pop62
	i32.const	$push13=, 24
	i32.mul 	$push14=, $4, $pop13
	i32.add 	$push61=, $6, $pop14
	tee_local	$push60=, $1=, $pop61
	i32.store	0($pop60), $5
	i64.load	$push15=, 0($2)
	i64.store	8($1), $pop15
	i32.load	$push16=, 0($3)
	i32.store	16($1), $pop16
	i32.const	$push59=, 24
	i32.mul 	$push17=, $7, $pop59
	i32.add 	$4=, $6, $pop17
	i32.const	$push58=, 24
	i32.add 	$5=, $1, $pop58
	block   	
	block   	
	i32.const	$push18=, 4
	i32.add 	$push19=, $0, $pop18
	i32.load	$push57=, 0($pop19)
	tee_local	$push56=, $6=, $pop57
	i32.load	$push55=, 0($0)
	tee_local	$push54=, $7=, $pop55
	i32.eq  	$push20=, $pop56, $pop54
	br_if   	0, $pop20
.LBB21_8:
	loop    	
	i32.const	$push74=, -24
	i32.add 	$push73=, $6, $pop74
	tee_local	$push72=, $2=, $pop73
	i32.load	$3=, 0($pop72)
	i32.const	$push71=, 0
	i32.store	0($2), $pop71
	i32.const	$push70=, -24
	i32.add 	$push21=, $1, $pop70
	i32.store	0($pop21), $3
	i32.const	$push69=, -8
	i32.add 	$push22=, $1, $pop69
	i32.const	$push68=, -8
	i32.add 	$push23=, $6, $pop68
	i32.load	$push24=, 0($pop23)
	i32.store	0($pop22), $pop24
	i32.const	$push67=, -12
	i32.add 	$push25=, $1, $pop67
	i32.const	$push66=, -12
	i32.add 	$push26=, $6, $pop66
	i32.load	$push27=, 0($pop26)
	i32.store	0($pop25), $pop27
	i32.const	$push65=, -16
	i32.add 	$push28=, $1, $pop65
	i32.const	$push64=, -16
	i32.add 	$push29=, $6, $pop64
	i32.load	$push30=, 0($pop29)
	i32.store	0($pop28), $pop30
	i32.const	$push63=, -24
	i32.add 	$1=, $1, $pop63
	copy_local	$6=, $2
	i32.ne  	$push31=, $7, $2
	br_if   	0, $pop31
	end_loop
	i32.const	$push32=, 4
	i32.add 	$push33=, $0, $pop32
	i32.load	$7=, 0($pop33)
	i32.load	$6=, 0($0)
	br      	1
.LBB21_10:
	end_block
	copy_local	$6=, $7
.LBB21_11:
	end_block
	i32.store	0($0), $1
	i32.const	$push34=, 4
	i32.add 	$push35=, $0, $pop34
	i32.store	0($pop35), $5
	i32.const	$push36=, 8
	i32.add 	$push37=, $0, $pop36
	i32.store	0($pop37), $4
	block   	
	i32.eq  	$push38=, $7, $6
	br_if   	0, $pop38
.LBB21_13:
	loop    	
	i32.const	$push78=, -24
	i32.add 	$push77=, $7, $pop78
	tee_local	$push76=, $7=, $pop77
	i32.load	$1=, 0($pop76)
	i32.const	$push75=, 0
	i32.store	0($7), $pop75
	block   	
	i32.eqz 	$push80=, $1
	br_if   	0, $pop80
	call    	_ZdlPv@FUNCTION, $1
.LBB21_15:
	end_block
	i32.ne  	$push39=, $6, $7
	br_if   	0, $pop39
.LBB21_16:
	end_loop
	end_block
	block   	
	i32.eqz 	$push81=, $6
	br_if   	0, $pop81
	call    	_ZdlPv@FUNCTION, $6
.LBB21_18:
	end_block
	.endfunc
.Lfunc_end21:
	.size	_ZNSt3__16vectorIN5eosio11multi_indexILy3607749779137757184ENS1_5token7accountEJEE8item_ptrENS_9allocatorIS6_EEE24__emplace_back_slow_pathIJNS_10unique_ptrINS5_4itemENS_14default_deleteISC_EEEERyRlEEEvDpOT_, .Lfunc_end21-_ZNSt3__16vectorIN5eosio11multi_indexILy3607749779137757184ENS1_5token7accountEJEE8item_ptrENS_9allocatorIS6_EEE24__emplace_back_slow_pathIJNS_10unique_ptrINS5_4itemENS_14default_deleteISC_EEEERyRlEEEvDpOT_

	.text
	.hidden	_ZN5eosio5token8transferEyyNS_5assetENSt3__112basic_stringIcNS2_11char_traitsIcEENS2_9allocatorIcEEEE
	.globl	_ZN5eosio5token8transferEyyNS_5assetENSt3__112basic_stringIcNS2_11char_traitsIcEENS2_9allocatorIcEEEE
	.type	_ZN5eosio5token8transferEyyNS_5assetENSt3__112basic_stringIcNS2_11char_traitsIcEENS2_9allocatorIcEEEE,@function
_ZN5eosio5token8transferEyyNS_5assetENSt3__112basic_stringIcNS2_11char_traitsIcEENS2_9allocatorIcEEEE:
	.param  	i32, i64, i64, i32, i32
	.local  	i64, i32, i64, i32, i64, i32, i32
	i32.const	$push59=, 0
	i32.const	$push56=, 0
	i32.load	$push57=, __stack_pointer($pop56)
	i32.const	$push58=, 112
	i32.sub 	$push93=, $pop57, $pop58
	tee_local	$push92=, $11=, $pop93
	i32.store	__stack_pointer($pop59), $pop92
	i64.ne  	$push0=, $1, $2
	i32.const	$push1=, .L.str.11
	call    	eosio_assert@FUNCTION, $pop0, $pop1
	call    	require_auth@FUNCTION, $1
	i32.call	$push2=, is_account@FUNCTION, $2
	i32.const	$push3=, .L.str.12
	call    	eosio_assert@FUNCTION, $pop2, $pop3
	i64.load	$5=, 8($3)
	i32.const	$8=, 0
	i32.const	$push4=, 104
	i32.add 	$push5=, $11, $pop4
	i32.const	$push91=, 0
	i32.store	0($pop5), $pop91
	i64.const	$push90=, 8
	i64.shr_u	$push89=, $5, $pop90
	tee_local	$push88=, $9=, $pop89
	i64.store	80($11), $pop88
	i64.const	$push6=, -1
	i64.store	88($11), $pop6
	i64.const	$push87=, 0
	i64.store	96($11), $pop87
	i64.load	$push7=, 0($0)
	i64.store	72($11), $pop7
	i32.const	$push63=, 72
	i32.add 	$push64=, $11, $pop63
	i32.const	$push8=, .L.str.13
	i32.call	$6=, _ZNK5eosio11multi_indexILy14289235522390851584ENS_5token14currency_statsEJEE3getEyPKc@FUNCTION, $pop64, $9, $pop8
	call    	require_recipient@FUNCTION, $1
	call    	require_recipient@FUNCTION, $2
	block   	
	i64.load	$push86=, 0($3)
	tee_local	$push85=, $7=, $pop86
	i64.const	$push9=, 4611686018427387903
	i64.add 	$push10=, $pop85, $pop9
	i64.const	$push11=, 9223372036854775806
	i64.gt_u	$push12=, $pop10, $pop11
	br_if   	0, $pop12
	i32.const	$10=, 0
.LBB22_2:
	block   	
	loop    	
	i32.wrap/i64	$push13=, $9
	i32.const	$push96=, 24
	i32.shl 	$push14=, $pop13, $pop96
	i32.const	$push95=, -1073741825
	i32.add 	$push15=, $pop14, $pop95
	i32.const	$push94=, 452984830
	i32.gt_u	$push16=, $pop15, $pop94
	br_if   	1, $pop16
	block   	
	i64.const	$push101=, 8
	i64.shr_u	$push100=, $9, $pop101
	tee_local	$push99=, $9=, $pop100
	i64.const	$push98=, 255
	i64.and 	$push17=, $pop99, $pop98
	i64.const	$push97=, 0
	i64.ne  	$push18=, $pop17, $pop97
	br_if   	0, $pop18
.LBB22_4:
	loop    	
	i64.const	$push106=, 8
	i64.shr_u	$push105=, $9, $pop106
	tee_local	$push104=, $9=, $pop105
	i64.const	$push103=, 255
	i64.and 	$push19=, $pop104, $pop103
	i64.const	$push102=, 0
	i64.ne  	$push20=, $pop19, $pop102
	br_if   	3, $pop20
	i32.const	$push110=, 1
	i32.add 	$push109=, $10, $pop110
	tee_local	$push108=, $10=, $pop109
	i32.const	$push107=, 7
	i32.lt_s	$push21=, $pop108, $pop107
	br_if   	0, $pop21
.LBB22_6:
	end_loop
	end_block
	i32.const	$8=, 1
	i32.const	$push114=, 1
	i32.add 	$push113=, $10, $pop114
	tee_local	$push112=, $10=, $pop113
	i32.const	$push111=, 7
	i32.lt_s	$push22=, $pop112, $pop111
	br_if   	0, $pop22
	br      	2
.LBB22_7:
	end_loop
	end_block
	i32.const	$8=, 0
.LBB22_8:
	end_block
	i32.const	$push23=, .L.str.6
	call    	eosio_assert@FUNCTION, $8, $pop23
	i64.const	$push118=, 0
	i64.gt_s	$push24=, $7, $pop118
	i32.const	$push25=, .L.str.14
	call    	eosio_assert@FUNCTION, $pop24, $pop25
	i64.load	$push26=, 8($6)
	i64.eq  	$push27=, $5, $pop26
	i32.const	$push28=, .L.str.8
	call    	eosio_assert@FUNCTION, $pop27, $pop28
	block   	
	block   	
	i32.load8_u	$push117=, 0($4)
	tee_local	$push116=, $10=, $pop117
	i32.const	$push115=, 1
	i32.and 	$push29=, $pop116, $pop115
	br_if   	0, $pop29
	i32.const	$push119=, 1
	i32.shr_u	$10=, $10, $pop119
	br      	1
.LBB22_10:
	end_block
	i32.load	$10=, 4($4)
.LBB22_11:
	end_block
	i32.const	$push30=, 257
	i32.lt_u	$push31=, $10, $pop30
	i32.const	$push32=, .L.str.4
	call    	eosio_assert@FUNCTION, $pop31, $pop32
	i32.const	$push65=, 56
	i32.add 	$push66=, $11, $pop65
	i32.const	$push33=, 8
	i32.add 	$push134=, $pop66, $pop33
	tee_local	$push133=, $10=, $pop134
	i32.const	$push132=, 8
	i32.add 	$push131=, $3, $pop132
	tee_local	$push130=, $8=, $pop131
	i64.load	$push34=, 0($pop130)
	i64.store	0($pop133), $pop34
	i64.load	$9=, 0($3)
	i32.const	$push67=, 24
	i32.add 	$push68=, $11, $pop67
	i32.const	$push35=, 12
	i32.add 	$push36=, $pop68, $pop35
	i32.const	$push69=, 56
	i32.add 	$push70=, $11, $pop69
	i32.const	$push129=, 12
	i32.add 	$push37=, $pop70, $pop129
	i32.load	$push38=, 0($pop37)
	i32.store	0($pop36), $pop38
	i32.const	$push71=, 24
	i32.add 	$push72=, $11, $pop71
	i32.const	$push128=, 8
	i32.add 	$push39=, $pop72, $pop128
	i32.load	$push40=, 0($10)
	i32.store	0($pop39), $pop40
	i64.store	56($11), $9
	i32.load	$push41=, 60($11)
	i32.store	28($11), $pop41
	i32.load	$push42=, 56($11)
	i32.store	24($11), $pop42
	i32.const	$push73=, 24
	i32.add 	$push74=, $11, $pop73
	call    	_ZN5eosio5token11sub_balanceEyNS_5assetE@FUNCTION, $0, $1, $pop74
	i32.const	$push75=, 40
	i32.add 	$push76=, $11, $pop75
	i32.const	$push127=, 8
	i32.add 	$push126=, $pop76, $pop127
	tee_local	$push125=, $10=, $pop126
	i64.load	$push43=, 0($8)
	i64.store	0($pop125), $pop43
	i64.load	$9=, 0($3)
	i32.const	$push77=, 8
	i32.add 	$push78=, $11, $pop77
	i32.const	$push124=, 12
	i32.add 	$push44=, $pop78, $pop124
	i32.const	$push79=, 40
	i32.add 	$push80=, $11, $pop79
	i32.const	$push123=, 12
	i32.add 	$push45=, $pop80, $pop123
	i32.load	$push46=, 0($pop45)
	i32.store	0($pop44), $pop46
	i32.const	$push81=, 8
	i32.add 	$push82=, $11, $pop81
	i32.const	$push122=, 8
	i32.add 	$push47=, $pop82, $pop122
	i32.load	$push48=, 0($10)
	i32.store	0($pop47), $pop48
	i64.store	40($11), $9
	i32.load	$push49=, 44($11)
	i32.store	12($11), $pop49
	i32.load	$push50=, 40($11)
	i32.store	8($11), $pop50
	i32.const	$push83=, 8
	i32.add 	$push84=, $11, $pop83
	call    	_ZN5eosio5token11add_balanceEyNS_5assetEy@FUNCTION, $0, $2, $pop84, $1
	block   	
	i32.load	$push121=, 96($11)
	tee_local	$push120=, $8=, $pop121
	i32.eqz 	$push143=, $pop120
	br_if   	0, $pop143
	block   	
	block   	
	i32.const	$push51=, 100
	i32.add 	$push138=, $11, $pop51
	tee_local	$push137=, $0=, $pop138
	i32.load	$push136=, 0($pop137)
	tee_local	$push135=, $10=, $pop136
	i32.eq  	$push52=, $pop135, $8
	br_if   	0, $pop52
.LBB22_14:
	loop    	
	i32.const	$push142=, -24
	i32.add 	$push141=, $10, $pop142
	tee_local	$push140=, $10=, $pop141
	i32.load	$3=, 0($pop140)
	i32.const	$push139=, 0
	i32.store	0($10), $pop139
	block   	
	i32.eqz 	$push144=, $3
	br_if   	0, $pop144
	call    	_ZdlPv@FUNCTION, $3
.LBB22_16:
	end_block
	i32.ne  	$push53=, $8, $10
	br_if   	0, $pop53
	end_loop
	i32.const	$push54=, 96
	i32.add 	$push55=, $11, $pop54
	i32.load	$10=, 0($pop55)
	br      	1
.LBB22_18:
	end_block
	copy_local	$10=, $8
.LBB22_19:
	end_block
	i32.store	0($0), $8
	call    	_ZdlPv@FUNCTION, $10
.LBB22_20:
	end_block
	i32.const	$push62=, 0
	i32.const	$push60=, 112
	i32.add 	$push61=, $11, $pop60
	i32.store	__stack_pointer($pop62), $pop61
	.endfunc
.Lfunc_end22:
	.size	_ZN5eosio5token8transferEyyNS_5assetENSt3__112basic_stringIcNS2_11char_traitsIcEENS2_9allocatorIcEEEE, .Lfunc_end22-_ZN5eosio5token8transferEyyNS_5assetENSt3__112basic_stringIcNS2_11char_traitsIcEENS2_9allocatorIcEEEE

	.section	.text._ZNK5eosio11multi_indexILy14289235522390851584ENS_5token14currency_statsEJEE3getEyPKc,"axG",@progbits,_ZNK5eosio11multi_indexILy14289235522390851584ENS_5token14currency_statsEJEE3getEyPKc,comdat
	.hidden	_ZNK5eosio11multi_indexILy14289235522390851584ENS_5token14currency_statsEJEE3getEyPKc
	.weak	_ZNK5eosio11multi_indexILy14289235522390851584ENS_5token14currency_statsEJEE3getEyPKc
	.type	_ZNK5eosio11multi_indexILy14289235522390851584ENS_5token14currency_statsEJEE3getEyPKc,@function
_ZNK5eosio11multi_indexILy14289235522390851584ENS_5token14currency_statsEJEE3getEyPKc:
	.param  	i32, i64, i32
	.result 	i32
	.local  	i32, i32, i32, i32, i32
	block   	
	i32.const	$push0=, 28
	i32.add 	$push1=, $0, $pop0
	i32.load	$push28=, 0($pop1)
	tee_local	$push27=, $7=, $pop28
	i32.load	$push26=, 24($0)
	tee_local	$push25=, $3=, $pop26
	i32.eq  	$push2=, $pop27, $pop25
	br_if   	0, $pop2
	i32.const	$push29=, -24
	i32.add 	$6=, $7, $pop29
	i32.const	$push3=, 0
	i32.sub 	$4=, $pop3, $3
.LBB23_2:
	loop    	
	i32.load	$push4=, 0($6)
	i64.load	$push5=, 8($pop4)
	i64.const	$push30=, 8
	i64.shr_u	$push6=, $pop5, $pop30
	i64.eq  	$push7=, $pop6, $1
	br_if   	1, $pop7
	copy_local	$7=, $6
	i32.const	$push34=, -24
	i32.add 	$push33=, $6, $pop34
	tee_local	$push32=, $5=, $pop33
	copy_local	$6=, $pop32
	i32.add 	$push8=, $5, $4
	i32.const	$push31=, -24
	i32.ne  	$push9=, $pop8, $pop31
	br_if   	0, $pop9
.LBB23_4:
	end_loop
	end_block
	block   	
	block   	
	i32.eq  	$push10=, $7, $3
	br_if   	0, $pop10
	i32.const	$push11=, -24
	i32.add 	$push12=, $7, $pop11
	i32.load	$push36=, 0($pop12)
	tee_local	$push35=, $6=, $pop36
	i32.load	$push13=, 40($pop35)
	i32.eq  	$push14=, $pop13, $0
	i32.const	$push15=, .L.str.20
	call    	eosio_assert@FUNCTION, $pop14, $pop15
	br      	1
.LBB23_6:
	end_block
	i32.const	$6=, 0
	i64.load	$push17=, 0($0)
	i64.load	$push16=, 8($0)
	i64.const	$push18=, -4157508551318700032
	i32.call	$push39=, db_find_i64@FUNCTION, $pop17, $pop16, $pop18, $1
	tee_local	$push38=, $5=, $pop39
	i32.const	$push37=, 0
	i32.lt_s	$push19=, $pop38, $pop37
	br_if   	0, $pop19
	i32.call	$push41=, _ZNK5eosio11multi_indexILy14289235522390851584ENS_5token14currency_statsEJEE31load_object_by_primary_iteratorEl@FUNCTION, $0, $5
	tee_local	$push40=, $6=, $pop41
	i32.load	$push20=, 40($pop40)
	i32.eq  	$push21=, $pop20, $0
	i32.const	$push22=, .L.str.20
	call    	eosio_assert@FUNCTION, $pop21, $pop22
.LBB23_8:
	end_block
	i32.const	$push23=, 0
	i32.ne  	$push24=, $6, $pop23
	call    	eosio_assert@FUNCTION, $pop24, $2
	copy_local	$push42=, $6
	.endfunc
.Lfunc_end23:
	.size	_ZNK5eosio11multi_indexILy14289235522390851584ENS_5token14currency_statsEJEE3getEyPKc, .Lfunc_end23-_ZNK5eosio11multi_indexILy14289235522390851584ENS_5token14currency_statsEJEE3getEyPKc

	.text
	.hidden	_ZN5eosio5token11sub_balanceEyNS_5assetE
	.globl	_ZN5eosio5token11sub_balanceEyNS_5assetE
	.type	_ZN5eosio5token11sub_balanceEyNS_5assetE,@function
_ZN5eosio5token11sub_balanceEyNS_5assetE:
	.param  	i32, i64, i32
	.local  	i64, i64, i32, i64, i32, i32
	i32.const	$push53=, 0
	i32.const	$push50=, 0
	i32.load	$push51=, __stack_pointer($pop50)
	i32.const	$push52=, 64
	i32.sub 	$push79=, $pop51, $pop52
	tee_local	$push78=, $8=, $pop79
	i32.store	__stack_pointer($pop53), $pop78
	i32.const	$push0=, 40
	i32.add 	$push1=, $8, $pop0
	i32.const	$push2=, 0
	i32.store	0($pop1), $pop2
	i64.store	16($8), $1
	i64.const	$push3=, -1
	i64.store	24($8), $pop3
	i64.const	$push4=, 0
	i64.store	32($8), $pop4
	i64.load	$push5=, 0($0)
	i64.store	8($8), $pop5
	i32.const	$push57=, 8
	i32.add 	$push58=, $8, $pop57
	i64.load	$push77=, 8($2)
	tee_local	$push76=, $3=, $pop77
	i64.const	$push75=, 8
	i64.shr_u	$push6=, $pop76, $pop75
	i32.const	$push7=, .L.str.15
	i32.call	$push74=, _ZNK5eosio11multi_indexILy3607749779137757184ENS_5token7accountEJEE3getEyPKc@FUNCTION, $pop58, $pop6, $pop7
	tee_local	$push73=, $0=, $pop74
	i64.load	$push8=, 0($pop73)
	i64.load	$push72=, 0($2)
	tee_local	$push71=, $4=, $pop72
	i64.ge_s	$push9=, $pop8, $pop71
	i32.const	$push10=, .L.str.16
	call    	eosio_assert@FUNCTION, $pop9, $pop10
	block   	
	block   	
	block   	
	i64.load	$push11=, 0($0)
	i64.ne  	$push12=, $4, $pop11
	br_if   	0, $pop12
	i32.const	$push59=, 8
	i32.add 	$push60=, $8, $pop59
	call    	_ZN5eosio11multi_indexILy3607749779137757184ENS_5token7accountEJEE5eraseERKS2_@FUNCTION, $pop60, $0
	i32.load	$push81=, 32($8)
	tee_local	$push80=, $5=, $pop81
	br_if   	1, $pop80
	br      	2
.LBB24_2:
	end_block
	i32.load	$push13=, 16($0)
	i32.const	$push61=, 8
	i32.add 	$push62=, $8, $pop61
	i32.eq  	$push14=, $pop13, $pop62
	i32.const	$push15=, .L.str.28
	call    	eosio_assert@FUNCTION, $pop14, $pop15
	i64.load	$push16=, 8($8)
	i64.call	$push17=, current_receiver@FUNCTION
	i64.eq  	$push18=, $pop16, $pop17
	i32.const	$push19=, .L.str.29
	call    	eosio_assert@FUNCTION, $pop18, $pop19
	i64.load	$push97=, 8($0)
	tee_local	$push96=, $6=, $pop97
	i64.eq  	$push20=, $3, $pop96
	i32.const	$push21=, .L.str.37
	call    	eosio_assert@FUNCTION, $pop20, $pop21
	i64.load	$push22=, 0($0)
	i64.sub 	$push95=, $pop22, $4
	tee_local	$push94=, $4=, $pop95
	i64.store	0($0), $pop94
	i64.const	$push23=, -4611686018427387904
	i64.gt_s	$push24=, $4, $pop23
	i32.const	$push25=, .L.str.38
	call    	eosio_assert@FUNCTION, $pop24, $pop25
	i64.load	$push26=, 0($0)
	i64.const	$push27=, 4611686018427387904
	i64.lt_s	$push28=, $pop26, $pop27
	i32.const	$push29=, .L.str.39
	call    	eosio_assert@FUNCTION, $pop28, $pop29
	i64.const	$push93=, 8
	i64.shr_u	$push92=, $6, $pop93
	tee_local	$push91=, $4=, $pop92
	i64.load	$push30=, 8($0)
	i64.const	$push90=, 8
	i64.shr_u	$push31=, $pop30, $pop90
	i64.eq  	$push32=, $pop91, $pop31
	i32.const	$push33=, .L.str.30
	call    	eosio_assert@FUNCTION, $pop32, $pop33
	i32.const	$push35=, 1
	i32.const	$push34=, .L.str.27
	call    	eosio_assert@FUNCTION, $pop35, $pop34
	i32.const	$push63=, 48
	i32.add 	$push64=, $8, $pop63
	i32.const	$push36=, 8
	i32.call	$drop=, memcpy@FUNCTION, $pop64, $0, $pop36
	i32.const	$push89=, 1
	i32.const	$push88=, .L.str.27
	call    	eosio_assert@FUNCTION, $pop89, $pop88
	i32.const	$push65=, 48
	i32.add 	$push66=, $8, $pop65
	i32.const	$push87=, 8
	i32.or  	$push38=, $pop66, $pop87
	i32.const	$push86=, 8
	i32.add 	$push37=, $0, $pop86
	i32.const	$push85=, 8
	i32.call	$drop=, memcpy@FUNCTION, $pop38, $pop37, $pop85
	i32.load	$push39=, 20($0)
	i32.const	$push67=, 48
	i32.add 	$push68=, $8, $pop67
	i32.const	$push40=, 16
	call    	db_update_i64@FUNCTION, $pop39, $1, $pop68, $pop40
	block   	
	i32.const	$push69=, 8
	i32.add 	$push70=, $8, $pop69
	i32.const	$push84=, 16
	i32.add 	$push83=, $pop70, $pop84
	tee_local	$push82=, $0=, $pop83
	i64.load	$push41=, 0($pop82)
	i64.lt_u	$push42=, $4, $pop41
	br_if   	0, $pop42
	i64.const	$push43=, 1
	i64.add 	$push44=, $4, $pop43
	i64.store	0($0), $pop44
.LBB24_4:
	end_block
	i32.load	$push99=, 32($8)
	tee_local	$push98=, $5=, $pop99
	i32.eqz 	$push108=, $pop98
	br_if   	1, $pop108
.LBB24_5:
	end_block
	block   	
	block   	
	i32.const	$push45=, 36
	i32.add 	$push103=, $8, $pop45
	tee_local	$push102=, $7=, $pop103
	i32.load	$push101=, 0($pop102)
	tee_local	$push100=, $0=, $pop101
	i32.eq  	$push46=, $pop100, $5
	br_if   	0, $pop46
.LBB24_7:
	loop    	
	i32.const	$push107=, -24
	i32.add 	$push106=, $0, $pop107
	tee_local	$push105=, $0=, $pop106
	i32.load	$2=, 0($pop105)
	i32.const	$push104=, 0
	i32.store	0($0), $pop104
	block   	
	i32.eqz 	$push109=, $2
	br_if   	0, $pop109
	call    	_ZdlPv@FUNCTION, $2
.LBB24_9:
	end_block
	i32.ne  	$push47=, $5, $0
	br_if   	0, $pop47
	end_loop
	i32.const	$push48=, 32
	i32.add 	$push49=, $8, $pop48
	i32.load	$0=, 0($pop49)
	br      	1
.LBB24_11:
	end_block
	copy_local	$0=, $5
.LBB24_12:
	end_block
	i32.store	0($7), $5
	call    	_ZdlPv@FUNCTION, $0
.LBB24_13:
	end_block
	i32.const	$push56=, 0
	i32.const	$push54=, 64
	i32.add 	$push55=, $8, $pop54
	i32.store	__stack_pointer($pop56), $pop55
	.endfunc
.Lfunc_end24:
	.size	_ZN5eosio5token11sub_balanceEyNS_5assetE, .Lfunc_end24-_ZN5eosio5token11sub_balanceEyNS_5assetE

	.section	.text._ZNK5eosio11multi_indexILy3607749779137757184ENS_5token7accountEJEE3getEyPKc,"axG",@progbits,_ZNK5eosio11multi_indexILy3607749779137757184ENS_5token7accountEJEE3getEyPKc,comdat
	.hidden	_ZNK5eosio11multi_indexILy3607749779137757184ENS_5token7accountEJEE3getEyPKc
	.weak	_ZNK5eosio11multi_indexILy3607749779137757184ENS_5token7accountEJEE3getEyPKc
	.type	_ZNK5eosio11multi_indexILy3607749779137757184ENS_5token7accountEJEE3getEyPKc,@function
_ZNK5eosio11multi_indexILy3607749779137757184ENS_5token7accountEJEE3getEyPKc:
	.param  	i32, i64, i32
	.result 	i32
	.local  	i32, i32, i32, i32, i32
	block   	
	i32.const	$push0=, 28
	i32.add 	$push1=, $0, $pop0
	i32.load	$push28=, 0($pop1)
	tee_local	$push27=, $7=, $pop28
	i32.load	$push26=, 24($0)
	tee_local	$push25=, $3=, $pop26
	i32.eq  	$push2=, $pop27, $pop25
	br_if   	0, $pop2
	i32.const	$push29=, -24
	i32.add 	$6=, $7, $pop29
	i32.const	$push3=, 0
	i32.sub 	$4=, $pop3, $3
.LBB25_2:
	loop    	
	i32.load	$push4=, 0($6)
	i64.load	$push5=, 8($pop4)
	i64.const	$push30=, 8
	i64.shr_u	$push6=, $pop5, $pop30
	i64.eq  	$push7=, $pop6, $1
	br_if   	1, $pop7
	copy_local	$7=, $6
	i32.const	$push34=, -24
	i32.add 	$push33=, $6, $pop34
	tee_local	$push32=, $5=, $pop33
	copy_local	$6=, $pop32
	i32.add 	$push8=, $5, $4
	i32.const	$push31=, -24
	i32.ne  	$push9=, $pop8, $pop31
	br_if   	0, $pop9
.LBB25_4:
	end_loop
	end_block
	block   	
	block   	
	i32.eq  	$push10=, $7, $3
	br_if   	0, $pop10
	i32.const	$push11=, -24
	i32.add 	$push12=, $7, $pop11
	i32.load	$push36=, 0($pop12)
	tee_local	$push35=, $6=, $pop36
	i32.load	$push13=, 16($pop35)
	i32.eq  	$push14=, $pop13, $0
	i32.const	$push15=, .L.str.20
	call    	eosio_assert@FUNCTION, $pop14, $pop15
	br      	1
.LBB25_6:
	end_block
	i32.const	$6=, 0
	i64.load	$push17=, 0($0)
	i64.load	$push16=, 8($0)
	i64.const	$push18=, 3607749779137757184
	i32.call	$push39=, db_find_i64@FUNCTION, $pop17, $pop16, $pop18, $1
	tee_local	$push38=, $5=, $pop39
	i32.const	$push37=, 0
	i32.lt_s	$push19=, $pop38, $pop37
	br_if   	0, $pop19
	i32.call	$push41=, _ZNK5eosio11multi_indexILy3607749779137757184ENS_5token7accountEJEE31load_object_by_primary_iteratorEl@FUNCTION, $0, $5
	tee_local	$push40=, $6=, $pop41
	i32.load	$push20=, 16($pop40)
	i32.eq  	$push21=, $pop20, $0
	i32.const	$push22=, .L.str.20
	call    	eosio_assert@FUNCTION, $pop21, $pop22
.LBB25_8:
	end_block
	i32.const	$push23=, 0
	i32.ne  	$push24=, $6, $pop23
	call    	eosio_assert@FUNCTION, $pop24, $2
	copy_local	$push42=, $6
	.endfunc
.Lfunc_end25:
	.size	_ZNK5eosio11multi_indexILy3607749779137757184ENS_5token7accountEJEE3getEyPKc, .Lfunc_end25-_ZNK5eosio11multi_indexILy3607749779137757184ENS_5token7accountEJEE3getEyPKc

	.section	.text._ZN5eosio11multi_indexILy3607749779137757184ENS_5token7accountEJEE5eraseERKS2_,"axG",@progbits,_ZN5eosio11multi_indexILy3607749779137757184ENS_5token7accountEJEE5eraseERKS2_,comdat
	.hidden	_ZN5eosio11multi_indexILy3607749779137757184ENS_5token7accountEJEE5eraseERKS2_
	.weak	_ZN5eosio11multi_indexILy3607749779137757184ENS_5token7accountEJEE5eraseERKS2_
	.type	_ZN5eosio11multi_indexILy3607749779137757184ENS_5token7accountEJEE5eraseERKS2_,@function
_ZN5eosio11multi_indexILy3607749779137757184ENS_5token7accountEJEE5eraseERKS2_:
	.param  	i32, i32
	.local  	i64, i32, i32, i32, i32, i32, i32
	i32.load	$push0=, 16($1)
	i32.eq  	$push1=, $pop0, $0
	i32.const	$push2=, .L.str.34
	call    	eosio_assert@FUNCTION, $pop1, $pop2
	i64.load	$push3=, 0($0)
	i64.call	$push4=, current_receiver@FUNCTION
	i64.eq  	$push5=, $pop3, $pop4
	i32.const	$push6=, .L.str.35
	call    	eosio_assert@FUNCTION, $pop5, $pop6
	block   	
	i32.const	$push7=, 28
	i32.add 	$push39=, $0, $pop7
	tee_local	$push38=, $5=, $pop39
	i32.load	$push37=, 0($pop38)
	tee_local	$push36=, $7=, $pop37
	i32.load	$push35=, 24($0)
	tee_local	$push34=, $3=, $pop35
	i32.eq  	$push8=, $pop36, $pop34
	br_if   	0, $pop8
	i64.load	$2=, 8($1)
	i32.const	$push9=, 0
	i32.sub 	$6=, $pop9, $3
	i32.const	$push40=, -24
	i32.add 	$8=, $7, $pop40
.LBB26_2:
	loop    	
	i32.load	$push10=, 0($8)
	i64.load	$push11=, 8($pop10)
	i64.xor 	$push12=, $pop11, $2
	i64.const	$push41=, 256
	i64.lt_u	$push13=, $pop12, $pop41
	br_if   	1, $pop13
	copy_local	$7=, $8
	i32.const	$push45=, -24
	i32.add 	$push44=, $8, $pop45
	tee_local	$push43=, $4=, $pop44
	copy_local	$8=, $pop43
	i32.add 	$push14=, $4, $6
	i32.const	$push42=, -24
	i32.ne  	$push15=, $pop14, $pop42
	br_if   	0, $pop15
.LBB26_4:
	end_loop
	end_block
	i32.ne  	$push16=, $7, $3
	i32.const	$push17=, .L.str.36
	call    	eosio_assert@FUNCTION, $pop16, $pop17
	i32.const	$push48=, -24
	i32.add 	$8=, $7, $pop48
	block   	
	block   	
	i32.load	$push47=, 0($5)
	tee_local	$push46=, $4=, $pop47
	i32.eq  	$push18=, $7, $pop46
	br_if   	0, $pop18
	i32.const	$push49=, 0
	i32.sub 	$3=, $pop49, $4
	copy_local	$7=, $8
.LBB26_6:
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
	i32.eqz 	$push65=, $4
	br_if   	0, $pop65
	call    	_ZdlPv@FUNCTION, $4
.LBB26_8:
	end_block
	i32.const	$push58=, 16
	i32.add 	$push19=, $7, $pop58
	i32.const	$push57=, 40
	i32.add 	$push20=, $7, $pop57
	i32.load	$push21=, 0($pop20)
	i32.store	0($pop19), $pop21
	i32.const	$push56=, 8
	i32.add 	$push22=, $7, $pop56
	i32.const	$push55=, 32
	i32.add 	$push23=, $7, $pop55
	i64.load	$push24=, 0($pop23)
	i64.store	0($pop22), $pop24
	copy_local	$7=, $8
	i32.add 	$push25=, $8, $3
	i32.const	$push54=, -24
	i32.ne  	$push26=, $pop25, $pop54
	br_if   	0, $pop26
	end_loop
	i32.const	$push27=, 28
	i32.add 	$push28=, $0, $pop27
	i32.load	$push60=, 0($pop28)
	tee_local	$push59=, $7=, $pop60
	i32.eq  	$push29=, $pop59, $8
	br_if   	1, $pop29
.LBB26_10:
	end_block
.LBB26_11:
	loop    	
	i32.const	$push64=, -24
	i32.add 	$push63=, $7, $pop64
	tee_local	$push62=, $7=, $pop63
	i32.load	$4=, 0($pop62)
	i32.const	$push61=, 0
	i32.store	0($7), $pop61
	block   	
	i32.eqz 	$push66=, $4
	br_if   	0, $pop66
	call    	_ZdlPv@FUNCTION, $4
.LBB26_13:
	end_block
	i32.ne  	$push30=, $8, $7
	br_if   	0, $pop30
.LBB26_14:
	end_loop
	end_block
	i32.const	$push31=, 28
	i32.add 	$push32=, $0, $pop31
	i32.store	0($pop32), $8
	i32.load	$push33=, 20($1)
	call    	db_remove_i64@FUNCTION, $pop33
	.endfunc
.Lfunc_end26:
	.size	_ZN5eosio11multi_indexILy3607749779137757184ENS_5token7accountEJEE5eraseERKS2_, .Lfunc_end26-_ZN5eosio11multi_indexILy3607749779137757184ENS_5token7accountEJEE5eraseERKS2_

	.text
	.hidden	apply
	.globl	apply
	.type	apply,@function
apply:
	.param  	i64, i64, i64
	.local  	i32, i32, i64, i64, i64, i64, i32
	i32.const	$push65=, 0
	i32.const	$push62=, 0
	i32.load	$push63=, __stack_pointer($pop62)
	i32.const	$push64=, 64
	i32.sub 	$push82=, $pop63, $pop64
	tee_local	$push81=, $9=, $pop82
	i32.store	__stack_pointer($pop65), $pop81
	i64.const	$6=, 0
	i64.const	$5=, 59
	i32.const	$4=, .L.str.17
	i64.const	$7=, 0
.LBB27_1:
	loop    	
	block   	
	block   	
	block   	
	block   	
	block   	
	i64.const	$push83=, 6
	i64.gt_u	$push0=, $6, $pop83
	br_if   	0, $pop0
	i32.load8_s	$push88=, 0($4)
	tee_local	$push87=, $3=, $pop88
	i32.const	$push86=, -97
	i32.add 	$push2=, $pop87, $pop86
	i32.const	$push85=, 255
	i32.and 	$push3=, $pop2, $pop85
	i32.const	$push84=, 25
	i32.gt_u	$push4=, $pop3, $pop84
	br_if   	1, $pop4
	i32.const	$push89=, 165
	i32.add 	$3=, $3, $pop89
	br      	2
.LBB27_4:
	end_block
	i64.const	$8=, 0
	i64.const	$push90=, 11
	i64.le_u	$push1=, $6, $pop90
	br_if   	2, $pop1
	br      	3
.LBB27_5:
	end_block
	i32.const	$push95=, 208
	i32.add 	$push5=, $3, $pop95
	i32.const	$push94=, 0
	i32.const	$push93=, -49
	i32.add 	$push6=, $3, $pop93
	i32.const	$push92=, 255
	i32.and 	$push7=, $pop6, $pop92
	i32.const	$push91=, 5
	i32.lt_u	$push8=, $pop7, $pop91
	i32.select	$3=, $pop5, $pop94, $pop8
.LBB27_6:
	end_block
	i64.extend_u/i32	$push9=, $3
	i64.const	$push97=, 56
	i64.shl 	$push10=, $pop9, $pop97
	i64.const	$push96=, 56
	i64.shr_s	$8=, $pop10, $pop96
.LBB27_7:
	end_block
	i64.const	$push99=, 31
	i64.and 	$push12=, $8, $pop99
	i64.const	$push98=, 4294967295
	i64.and 	$push11=, $5, $pop98
	i64.shl 	$8=, $pop12, $pop11
.LBB27_8:
	end_block
	i32.const	$push105=, 1
	i32.add 	$4=, $4, $pop105
	i64.const	$push104=, 1
	i64.add 	$6=, $6, $pop104
	i64.or  	$7=, $8, $7
	i64.const	$push103=, -5
	i64.add 	$push102=, $5, $pop103
	tee_local	$push101=, $5=, $pop102
	i64.const	$push100=, -6
	i64.ne  	$push13=, $pop101, $pop100
	br_if   	0, $pop13
	end_loop
	block   	
	i64.ne  	$push14=, $7, $2
	br_if   	0, $pop14
	i64.const	$6=, 0
	i64.const	$5=, 59
	i32.const	$4=, .L.str.18
	i64.const	$7=, 0
.LBB27_11:
	loop    	
	block   	
	block   	
	block   	
	block   	
	block   	
	i64.const	$push106=, 4
	i64.gt_u	$push15=, $6, $pop106
	br_if   	0, $pop15
	i32.load8_s	$push111=, 0($4)
	tee_local	$push110=, $3=, $pop111
	i32.const	$push109=, -97
	i32.add 	$push17=, $pop110, $pop109
	i32.const	$push108=, 255
	i32.and 	$push18=, $pop17, $pop108
	i32.const	$push107=, 25
	i32.gt_u	$push19=, $pop18, $pop107
	br_if   	1, $pop19
	i32.const	$push112=, 165
	i32.add 	$3=, $3, $pop112
	br      	2
.LBB27_14:
	end_block
	i64.const	$8=, 0
	i64.const	$push113=, 11
	i64.le_u	$push16=, $6, $pop113
	br_if   	2, $pop16
	br      	3
.LBB27_15:
	end_block
	i32.const	$push118=, 208
	i32.add 	$push20=, $3, $pop118
	i32.const	$push117=, 0
	i32.const	$push116=, -49
	i32.add 	$push21=, $3, $pop116
	i32.const	$push115=, 255
	i32.and 	$push22=, $pop21, $pop115
	i32.const	$push114=, 5
	i32.lt_u	$push23=, $pop22, $pop114
	i32.select	$3=, $pop20, $pop117, $pop23
.LBB27_16:
	end_block
	i64.extend_u/i32	$push24=, $3
	i64.const	$push120=, 56
	i64.shl 	$push25=, $pop24, $pop120
	i64.const	$push119=, 56
	i64.shr_s	$8=, $pop25, $pop119
.LBB27_17:
	end_block
	i64.const	$push122=, 31
	i64.and 	$push27=, $8, $pop122
	i64.const	$push121=, 4294967295
	i64.and 	$push26=, $5, $pop121
	i64.shl 	$8=, $pop27, $pop26
.LBB27_18:
	end_block
	i32.const	$push128=, 1
	i32.add 	$4=, $4, $pop128
	i64.const	$push127=, 1
	i64.add 	$6=, $6, $pop127
	i64.or  	$7=, $8, $7
	i64.const	$push126=, -5
	i64.add 	$push125=, $5, $pop126
	tee_local	$push124=, $5=, $pop125
	i64.const	$push123=, -6
	i64.ne  	$push28=, $pop124, $pop123
	br_if   	0, $pop28
	end_loop
	i64.eq  	$push29=, $7, $1
	i32.const	$push30=, .L.str.19
	call    	eosio_assert@FUNCTION, $pop29, $pop30
.LBB27_20:
	end_block
	block   	
	block   	
	i64.eq  	$push31=, $1, $0
	br_if   	0, $pop31
	i64.const	$6=, 0
	i64.const	$5=, 59
	i32.const	$4=, .L.str.17
	i64.const	$7=, 0
.LBB27_22:
	loop    	
	block   	
	block   	
	block   	
	block   	
	block   	
	i64.const	$push129=, 6
	i64.gt_u	$push32=, $6, $pop129
	br_if   	0, $pop32
	i32.load8_s	$push134=, 0($4)
	tee_local	$push133=, $3=, $pop134
	i32.const	$push132=, -97
	i32.add 	$push34=, $pop133, $pop132
	i32.const	$push131=, 255
	i32.and 	$push35=, $pop34, $pop131
	i32.const	$push130=, 25
	i32.gt_u	$push36=, $pop35, $pop130
	br_if   	1, $pop36
	i32.const	$push135=, 165
	i32.add 	$3=, $3, $pop135
	br      	2
.LBB27_25:
	end_block
	i64.const	$8=, 0
	i64.const	$push136=, 11
	i64.le_u	$push33=, $6, $pop136
	br_if   	2, $pop33
	br      	3
.LBB27_26:
	end_block
	i32.const	$push141=, 208
	i32.add 	$push37=, $3, $pop141
	i32.const	$push140=, 0
	i32.const	$push139=, -49
	i32.add 	$push38=, $3, $pop139
	i32.const	$push138=, 255
	i32.and 	$push39=, $pop38, $pop138
	i32.const	$push137=, 5
	i32.lt_u	$push40=, $pop39, $pop137
	i32.select	$3=, $pop37, $pop140, $pop40
.LBB27_27:
	end_block
	i64.extend_u/i32	$push41=, $3
	i64.const	$push143=, 56
	i64.shl 	$push42=, $pop41, $pop143
	i64.const	$push142=, 56
	i64.shr_s	$8=, $pop42, $pop142
.LBB27_28:
	end_block
	i64.const	$push145=, 31
	i64.and 	$push44=, $8, $pop145
	i64.const	$push144=, 4294967295
	i64.and 	$push43=, $5, $pop144
	i64.shl 	$8=, $pop44, $pop43
.LBB27_29:
	end_block
	i32.const	$push151=, 1
	i32.add 	$4=, $4, $pop151
	i64.const	$push150=, 1
	i64.add 	$6=, $6, $pop150
	i64.or  	$7=, $8, $7
	i64.const	$push149=, -5
	i64.add 	$push148=, $5, $pop149
	tee_local	$push147=, $5=, $pop148
	i64.const	$push146=, -6
	i64.ne  	$push45=, $pop147, $pop146
	br_if   	0, $pop45
	end_loop
	i64.ne  	$push46=, $7, $2
	br_if   	1, $pop46
.LBB27_31:
	end_block
	i64.store	56($9), $0
	block   	
	block   	
	i64.const	$push47=, -3617168760277827584
	i64.eq  	$push48=, $2, $pop47
	br_if   	0, $pop48
	i64.const	$push49=, 8516769789752901632
	i64.eq  	$push50=, $2, $pop49
	br_if   	1, $pop50
	i64.const	$push51=, 5031766152489992192
	i64.ne  	$push52=, $2, $pop51
	br_if   	2, $pop52
	i32.const	$push59=, 0
	i32.store	52($9), $pop59
	i32.const	$push60=, _ZN5eosio5token6createEyNS_5assetE@FUNCTION
	i32.store	48($9), $pop60
	i64.load	$push61=, 48($9)
	i64.store	8($9):p2align=2, $pop61
	i32.const	$push77=, 56
	i32.add 	$push78=, $9, $pop77
	i32.const	$push79=, 8
	i32.add 	$push80=, $9, $pop79
	i32.call	$drop=, _ZN5eosio14execute_actionINS_5tokenES1_JyNS_5assetEEEEbPT_MT0_FvDpT1_E@FUNCTION, $pop78, $pop80
	br      	2
.LBB27_35:
	end_block
	i32.const	$push53=, 0
	i32.store	36($9), $pop53
	i32.const	$push54=, _ZN5eosio5token8transferEyyNS_5assetENSt3__112basic_stringIcNS2_11char_traitsIcEENS2_9allocatorIcEEEE@FUNCTION
	i32.store	32($9), $pop54
	i64.load	$push55=, 32($9)
	i64.store	24($9):p2align=2, $pop55
	i32.const	$push69=, 56
	i32.add 	$push70=, $9, $pop69
	i32.const	$push71=, 24
	i32.add 	$push72=, $9, $pop71
	i32.call	$drop=, _ZN5eosio14execute_actionINS_5tokenES1_JyyNS_5assetENSt3__112basic_stringIcNS3_11char_traitsIcEENS3_9allocatorIcEEEEEEEbPT_MT0_FvDpT1_E@FUNCTION, $pop70, $pop72
	br      	1
.LBB27_36:
	end_block
	i32.const	$push56=, 0
	i32.store	44($9), $pop56
	i32.const	$push57=, _ZN5eosio5token5issueEyNS_5assetENSt3__112basic_stringIcNS2_11char_traitsIcEENS2_9allocatorIcEEEE@FUNCTION
	i32.store	40($9), $pop57
	i64.load	$push58=, 40($9)
	i64.store	16($9):p2align=2, $pop58
	i32.const	$push73=, 56
	i32.add 	$push74=, $9, $pop73
	i32.const	$push75=, 16
	i32.add 	$push76=, $9, $pop75
	i32.call	$drop=, _ZN5eosio14execute_actionINS_5tokenES1_JyNS_5assetENSt3__112basic_stringIcNS3_11char_traitsIcEENS3_9allocatorIcEEEEEEEbPT_MT0_FvDpT1_E@FUNCTION, $pop74, $pop76
.LBB27_37:
	end_block
	i32.const	$push68=, 0
	i32.const	$push66=, 64
	i32.add 	$push67=, $9, $pop66
	i32.store	__stack_pointer($pop68), $pop67
	.endfunc
.Lfunc_end27:
	.size	apply, .Lfunc_end27-apply

	.section	.text._ZN5eosio14execute_actionINS_5tokenES1_JyNS_5assetEEEEbPT_MT0_FvDpT1_E,"axG",@progbits,_ZN5eosio14execute_actionINS_5tokenES1_JyNS_5assetEEEEbPT_MT0_FvDpT1_E,comdat
	.hidden	_ZN5eosio14execute_actionINS_5tokenES1_JyNS_5assetEEEEbPT_MT0_FvDpT1_E
	.weak	_ZN5eosio14execute_actionINS_5tokenES1_JyNS_5assetEEEEbPT_MT0_FvDpT1_E
	.type	_ZN5eosio14execute_actionINS_5tokenES1_JyNS_5assetEEEEbPT_MT0_FvDpT1_E,@function
_ZN5eosio14execute_actionINS_5tokenES1_JyNS_5assetEEEEbPT_MT0_FvDpT1_E:
	.param  	i32, i32
	.result 	i32
	.local  	i32, i32, i64, i32, i64, i32, i32, i32
	i32.const	$push50=, 0
	i32.load	$push51=, __stack_pointer($pop50)
	i32.const	$push52=, 96
	i32.sub 	$push79=, $pop51, $pop52
	tee_local	$push78=, $7=, $pop79
	copy_local	$9=, $pop78
	i32.const	$push53=, 0
	i32.store	__stack_pointer($pop53), $7
	i32.load	$2=, 4($1)
	i32.load	$8=, 0($1)
	i32.const	$1=, 0
	i32.const	$5=, 0
	block   	
	i32.call	$push77=, action_data_size@FUNCTION
	tee_local	$push76=, $3=, $pop77
	i32.eqz 	$push132=, $pop76
	br_if   	0, $pop132
	block   	
	block   	
	i32.const	$push0=, 513
	i32.lt_u	$push1=, $3, $pop0
	br_if   	0, $pop1
	i32.call	$5=, malloc@FUNCTION, $3
	br      	1
.LBB28_3:
	end_block
	i32.const	$push49=, 0
	i32.const	$push2=, 15
	i32.add 	$push3=, $3, $pop2
	i32.const	$push4=, -16
	i32.and 	$push5=, $pop3, $pop4
	i32.sub 	$push81=, $7, $pop5
	tee_local	$push80=, $5=, $pop81
	copy_local	$push75=, $pop80
	i32.store	__stack_pointer($pop49), $pop75
.LBB28_4:
	end_block
	i32.call	$drop=, read_action_data@FUNCTION, $5, $3
.LBB28_5:
	end_block
	i32.const	$push6=, 40
	i32.add 	$push7=, $9, $pop6
	i64.const	$push8=, 1397703940
	i64.store	0($pop7), $pop8
	i64.const	$push84=, 0
	i64.store	32($9), $pop84
	i64.const	$push83=, 0
	i64.store	24($9), $pop83
	i32.const	$push82=, 1
	i32.const	$push9=, .L.str.23
	call    	eosio_assert@FUNCTION, $pop82, $pop9
	i64.const	$6=, 5459781
.LBB28_6:
	block   	
	loop    	
	i32.const	$7=, 0
	i32.wrap/i64	$push10=, $6
	i32.const	$push87=, 24
	i32.shl 	$push11=, $pop10, $pop87
	i32.const	$push86=, -1073741825
	i32.add 	$push12=, $pop11, $pop86
	i32.const	$push85=, 452984830
	i32.gt_u	$push13=, $pop12, $pop85
	br_if   	1, $pop13
	block   	
	i64.const	$push92=, 8
	i64.shr_u	$push91=, $6, $pop92
	tee_local	$push90=, $6=, $pop91
	i64.const	$push89=, 255
	i64.and 	$push14=, $pop90, $pop89
	i64.const	$push88=, 0
	i64.ne  	$push15=, $pop14, $pop88
	br_if   	0, $pop15
.LBB28_8:
	loop    	
	i64.const	$push97=, 8
	i64.shr_u	$push96=, $6, $pop97
	tee_local	$push95=, $6=, $pop96
	i64.const	$push94=, 255
	i64.and 	$push16=, $pop95, $pop94
	i64.const	$push93=, 0
	i64.ne  	$push17=, $pop16, $pop93
	br_if   	3, $pop17
	i32.const	$push101=, 1
	i32.add 	$push100=, $1, $pop101
	tee_local	$push99=, $1=, $pop100
	i32.const	$push98=, 7
	i32.lt_s	$push18=, $pop99, $pop98
	br_if   	0, $pop18
.LBB28_10:
	end_loop
	end_block
	i32.const	$7=, 1
	i32.const	$push105=, 1
	i32.add 	$push104=, $1, $pop105
	tee_local	$push103=, $1=, $pop104
	i32.const	$push102=, 7
	i32.lt_s	$push19=, $pop103, $pop102
	br_if   	0, $pop19
.LBB28_11:
	end_loop
	end_block
	i32.const	$push20=, .L.str
	call    	eosio_assert@FUNCTION, $7, $pop20
	i32.const	$push21=, 7
	i32.gt_u	$push22=, $3, $pop21
	i32.const	$push23=, .L.str.24
	call    	eosio_assert@FUNCTION, $pop22, $pop23
	i32.const	$push57=, 24
	i32.add 	$push58=, $9, $pop57
	i32.const	$push119=, 8
	i32.call	$drop=, memcpy@FUNCTION, $pop58, $5, $pop119
	i32.const	$push24=, -8
	i32.and 	$push118=, $3, $pop24
	tee_local	$push117=, $7=, $pop118
	i32.const	$push116=, 8
	i32.ne  	$push25=, $pop117, $pop116
	i32.const	$push115=, .L.str.24
	call    	eosio_assert@FUNCTION, $pop25, $pop115
	i32.const	$push59=, 24
	i32.add 	$push60=, $9, $pop59
	i32.const	$push114=, 8
	i32.add 	$push113=, $pop60, $pop114
	tee_local	$push112=, $1=, $pop113
	i32.const	$push111=, 8
	i32.add 	$push26=, $5, $pop111
	i32.const	$push110=, 8
	i32.call	$drop=, memcpy@FUNCTION, $pop112, $pop26, $pop110
	i32.const	$push27=, 16
	i32.ne  	$push28=, $7, $pop27
	i32.const	$push109=, .L.str.24
	call    	eosio_assert@FUNCTION, $pop28, $pop109
	i32.const	$push61=, 24
	i32.add 	$push62=, $9, $pop61
	i32.const	$push108=, 16
	i32.add 	$push30=, $pop62, $pop108
	i32.const	$push107=, 16
	i32.add 	$push29=, $5, $pop107
	i32.const	$push106=, 8
	i32.call	$drop=, memcpy@FUNCTION, $pop30, $pop29, $pop106
	block   	
	i32.const	$push31=, 513
	i32.lt_u	$push32=, $3, $pop31
	br_if   	0, $pop32
	call    	free@FUNCTION, $5
.LBB28_13:
	end_block
	i32.const	$push63=, 48
	i32.add 	$push64=, $9, $pop63
	i32.const	$push125=, 8
	i32.add 	$push124=, $pop64, $pop125
	tee_local	$push123=, $7=, $pop124
	i32.const	$push122=, 8
	i32.add 	$push33=, $1, $pop122
	i64.load	$push34=, 0($pop33)
	i64.store	0($pop123), $pop34
	i64.load	$6=, 24($9)
	i64.load	$push35=, 0($1)
	i64.store	48($9), $pop35
	i32.const	$push65=, 64
	i32.add 	$push66=, $9, $pop65
	i32.const	$push121=, 8
	i32.add 	$push36=, $pop66, $pop121
	i64.load	$push37=, 0($7)
	i64.store	0($pop36), $pop37
	i64.load	$push38=, 48($9)
	i64.store	64($9), $pop38
	i32.const	$push39=, 1
	i32.shr_s	$push40=, $2, $pop39
	i32.add 	$1=, $0, $pop40
	block   	
	i32.const	$push120=, 1
	i32.and 	$push41=, $2, $pop120
	i32.eqz 	$push133=, $pop41
	br_if   	0, $pop133
	i32.load	$push42=, 0($1)
	i32.add 	$push43=, $pop42, $8
	i32.load	$8=, 0($pop43)
.LBB28_15:
	end_block
	i32.const	$push67=, 80
	i32.add 	$push68=, $9, $pop67
	i32.const	$push44=, 8
	i32.add 	$push45=, $pop68, $pop44
	i32.const	$push69=, 64
	i32.add 	$push70=, $9, $pop69
	i32.const	$push131=, 8
	i32.add 	$push46=, $pop70, $pop131
	i64.load	$push130=, 0($pop46)
	tee_local	$push129=, $4=, $pop130
	i64.store	0($pop45), $pop129
	i32.const	$push71=, 8
	i32.add 	$push72=, $9, $pop71
	i32.const	$push128=, 8
	i32.add 	$push47=, $pop72, $pop128
	i64.store	0($pop47), $4
	i64.load	$push127=, 64($9)
	tee_local	$push126=, $4=, $pop127
	i64.store	80($9), $pop126
	i64.store	8($9), $4
	i32.const	$push73=, 8
	i32.add 	$push74=, $9, $pop73
	call_indirect	$1, $6, $pop74, $8
	i32.const	$push56=, 0
	i32.const	$push54=, 96
	i32.add 	$push55=, $9, $pop54
	i32.store	__stack_pointer($pop56), $pop55
	i32.const	$push48=, 1
	.endfunc
.Lfunc_end28:
	.size	_ZN5eosio14execute_actionINS_5tokenES1_JyNS_5assetEEEEbPT_MT0_FvDpT1_E, .Lfunc_end28-_ZN5eosio14execute_actionINS_5tokenES1_JyNS_5assetEEEEbPT_MT0_FvDpT1_E

	.section	.text._ZN5eosio14execute_actionINS_5tokenES1_JyNS_5assetENSt3__112basic_stringIcNS3_11char_traitsIcEENS3_9allocatorIcEEEEEEEbPT_MT0_FvDpT1_E,"axG",@progbits,_ZN5eosio14execute_actionINS_5tokenES1_JyNS_5assetENSt3__112basic_stringIcNS3_11char_traitsIcEENS3_9allocatorIcEEEEEEEbPT_MT0_FvDpT1_E,comdat
	.hidden	_ZN5eosio14execute_actionINS_5tokenES1_JyNS_5assetENSt3__112basic_stringIcNS3_11char_traitsIcEENS3_9allocatorIcEEEEEEEbPT_MT0_FvDpT1_E
	.weak	_ZN5eosio14execute_actionINS_5tokenES1_JyNS_5assetENSt3__112basic_stringIcNS3_11char_traitsIcEENS3_9allocatorIcEEEEEEEbPT_MT0_FvDpT1_E
	.type	_ZN5eosio14execute_actionINS_5tokenES1_JyNS_5assetENSt3__112basic_stringIcNS3_11char_traitsIcEENS3_9allocatorIcEEEEEEEbPT_MT0_FvDpT1_E,@function
_ZN5eosio14execute_actionINS_5tokenES1_JyNS_5assetENSt3__112basic_stringIcNS3_11char_traitsIcEENS3_9allocatorIcEEEEEEEbPT_MT0_FvDpT1_E:
	.param  	i32, i32
	.result 	i32
	.local  	i32, i64, i32, i32
	i32.const	$push51=, 0
	i32.const	$push48=, 0
	i32.load	$push49=, __stack_pointer($pop48)
	i32.const	$push50=, 80
	i32.sub 	$push79=, $pop49, $pop50
	tee_local	$push78=, $4=, $pop79
	i32.store	__stack_pointer($pop51), $pop78
	copy_local	$push77=, $4
	tee_local	$push76=, $5=, $pop77
	i32.store	60($pop76), $0
	i32.load	$push0=, 0($1)
	i32.store	48($5), $pop0
	i32.load	$push1=, 4($1)
	i32.store	52($5), $pop1
	i32.const	$1=, 0
	i32.const	$0=, 0
	block   	
	i32.call	$push75=, action_data_size@FUNCTION
	tee_local	$push74=, $2=, $pop75
	i32.eqz 	$push125=, $pop74
	br_if   	0, $pop125
	block   	
	block   	
	i32.const	$push2=, 513
	i32.lt_u	$push3=, $2, $pop2
	br_if   	0, $pop3
	i32.call	$0=, malloc@FUNCTION, $2
	br      	1
.LBB29_3:
	end_block
	i32.const	$push47=, 0
	i32.const	$push4=, 15
	i32.add 	$push5=, $2, $pop4
	i32.const	$push6=, -16
	i32.and 	$push7=, $pop5, $pop6
	i32.sub 	$push81=, $4, $pop7
	tee_local	$push80=, $0=, $pop81
	copy_local	$push73=, $pop80
	i32.store	__stack_pointer($pop47), $pop73
.LBB29_4:
	end_block
	i32.call	$drop=, read_action_data@FUNCTION, $0, $2
.LBB29_5:
	end_block
	i32.const	$push8=, 24
	i32.add 	$push9=, $5, $pop8
	i64.const	$push10=, 1397703940
	i64.store	0($pop9), $pop10
	i64.const	$push84=, 0
	i64.store	16($5), $pop84
	i64.const	$push83=, 0
	i64.store	8($5), $pop83
	i32.const	$push82=, 1
	i32.const	$push11=, .L.str.23
	call    	eosio_assert@FUNCTION, $pop82, $pop11
	i64.const	$3=, 5459781
.LBB29_6:
	block   	
	block   	
	loop    	
	i32.wrap/i64	$push12=, $3
	i32.const	$push87=, 24
	i32.shl 	$push13=, $pop12, $pop87
	i32.const	$push86=, -1073741825
	i32.add 	$push14=, $pop13, $pop86
	i32.const	$push85=, 452984830
	i32.gt_u	$push15=, $pop14, $pop85
	br_if   	1, $pop15
	block   	
	i64.const	$push92=, 8
	i64.shr_u	$push91=, $3, $pop92
	tee_local	$push90=, $3=, $pop91
	i64.const	$push89=, 255
	i64.and 	$push16=, $pop90, $pop89
	i64.const	$push88=, 0
	i64.ne  	$push17=, $pop16, $pop88
	br_if   	0, $pop17
.LBB29_8:
	loop    	
	i64.const	$push97=, 8
	i64.shr_u	$push96=, $3, $pop97
	tee_local	$push95=, $3=, $pop96
	i64.const	$push94=, 255
	i64.and 	$push18=, $pop95, $pop94
	i64.const	$push93=, 0
	i64.ne  	$push19=, $pop18, $pop93
	br_if   	3, $pop19
	i32.const	$push101=, 1
	i32.add 	$push100=, $1, $pop101
	tee_local	$push99=, $1=, $pop100
	i32.const	$push98=, 7
	i32.lt_s	$push20=, $pop99, $pop98
	br_if   	0, $pop20
.LBB29_10:
	end_loop
	end_block
	i32.const	$4=, 1
	i32.const	$push105=, 1
	i32.add 	$push104=, $1, $pop105
	tee_local	$push103=, $1=, $pop104
	i32.const	$push102=, 7
	i32.lt_s	$push21=, $pop103, $pop102
	br_if   	0, $pop21
	br      	2
.LBB29_11:
	end_loop
	end_block
	i32.const	$4=, 0
.LBB29_12:
	end_block
	i32.const	$push22=, .L.str
	call    	eosio_assert@FUNCTION, $4, $pop22
	i32.const	$push23=, 40
	i32.add 	$push24=, $5, $pop23
	i32.const	$push122=, 0
	i32.store	0($pop24), $pop122
	i64.const	$push25=, 0
	i64.store	32($5), $pop25
	i32.store	64($5), $0
	i32.add 	$push121=, $0, $2
	tee_local	$push120=, $1=, $pop121
	i32.store	72($5), $pop120
	i32.const	$push26=, 7
	i32.gt_u	$push27=, $2, $pop26
	i32.const	$push28=, .L.str.24
	call    	eosio_assert@FUNCTION, $pop27, $pop28
	i32.const	$push55=, 8
	i32.add 	$push56=, $5, $pop55
	i32.const	$push29=, 8
	i32.call	$drop=, memcpy@FUNCTION, $pop56, $0, $pop29
	i32.const	$push119=, 8
	i32.add 	$push118=, $0, $pop119
	tee_local	$push117=, $4=, $pop118
	i32.sub 	$push30=, $1, $pop117
	i32.const	$push116=, 7
	i32.gt_u	$push31=, $pop30, $pop116
	i32.const	$push115=, .L.str.24
	call    	eosio_assert@FUNCTION, $pop31, $pop115
	i32.const	$push57=, 8
	i32.add 	$push58=, $5, $pop57
	i32.const	$push114=, 8
	i32.add 	$push32=, $pop58, $pop114
	i32.const	$push113=, 8
	i32.call	$drop=, memcpy@FUNCTION, $pop32, $4, $pop113
	i32.const	$push33=, 16
	i32.add 	$push112=, $0, $pop33
	tee_local	$push111=, $4=, $pop112
	i32.sub 	$push34=, $1, $pop111
	i32.const	$push110=, 7
	i32.gt_u	$push35=, $pop34, $pop110
	i32.const	$push109=, .L.str.24
	call    	eosio_assert@FUNCTION, $pop35, $pop109
	i32.const	$push59=, 8
	i32.add 	$push60=, $5, $pop59
	i32.const	$push108=, 16
	i32.add 	$push36=, $pop60, $pop108
	i32.const	$push107=, 8
	i32.call	$drop=, memcpy@FUNCTION, $pop36, $4, $pop107
	i32.const	$push37=, 24
	i32.add 	$push38=, $0, $pop37
	i32.store	68($5), $pop38
	i32.const	$push63=, 64
	i32.add 	$push64=, $5, $pop63
	i32.const	$push61=, 8
	i32.add 	$push62=, $5, $pop61
	i32.const	$push106=, 24
	i32.add 	$push39=, $pop62, $pop106
	i32.call	$drop=, _ZN5eosiorsINS_10datastreamIPKcEEEERT_S6_RNSt3__112basic_stringIcNS7_11char_traitsIcEENS7_9allocatorIcEEEE@FUNCTION, $pop64, $pop39
	block   	
	i32.const	$push40=, 513
	i32.lt_u	$push41=, $2, $pop40
	br_if   	0, $pop41
	call    	free@FUNCTION, $0
.LBB29_14:
	end_block
	i32.const	$push65=, 48
	i32.add 	$push66=, $5, $pop65
	i32.store	68($5), $pop66
	i32.const	$push67=, 60
	i32.add 	$push68=, $5, $pop67
	i32.store	64($5), $pop68
	i32.const	$push69=, 64
	i32.add 	$push70=, $5, $pop69
	i32.const	$push71=, 8
	i32.add 	$push72=, $5, $pop71
	call    	_ZN5boost4mp116detail16tuple_apply_implIRZN5eosio14execute_actionINS3_5tokenES5_JyNS3_5assetENSt3__112basic_stringIcNS7_11char_traitsIcEENS7_9allocatorIcEEEEEEEbPT_MT0_FvDpT1_EEUlDpT_E_RNS7_5tupleIJyS6_SD_EEEJLj0ELj1ELj2EEEEDTclclsr3stdE7forwardISE_Efp_Espclsr3stdE3getIXT1_EEclsr3stdE7forwardISG_Efp0_EEEEOSE_OSG_NS0_16integer_sequenceIjJXspT1_EEEE@FUNCTION, $pop70, $pop72
	block   	
	i32.load8_u	$push42=, 32($5)
	i32.const	$push123=, 1
	i32.and 	$push43=, $pop42, $pop123
	i32.eqz 	$push126=, $pop43
	br_if   	0, $pop126
	i32.const	$push44=, 40
	i32.add 	$push45=, $5, $pop44
	i32.load	$push46=, 0($pop45)
	call    	_ZdlPv@FUNCTION, $pop46
.LBB29_16:
	end_block
	i32.const	$push54=, 0
	i32.const	$push52=, 80
	i32.add 	$push53=, $5, $pop52
	i32.store	__stack_pointer($pop54), $pop53
	i32.const	$push124=, 1
	.endfunc
.Lfunc_end29:
	.size	_ZN5eosio14execute_actionINS_5tokenES1_JyNS_5assetENSt3__112basic_stringIcNS3_11char_traitsIcEENS3_9allocatorIcEEEEEEEbPT_MT0_FvDpT1_E, .Lfunc_end29-_ZN5eosio14execute_actionINS_5tokenES1_JyNS_5assetENSt3__112basic_stringIcNS3_11char_traitsIcEENS3_9allocatorIcEEEEEEEbPT_MT0_FvDpT1_E

	.section	.text._ZN5eosio14execute_actionINS_5tokenES1_JyyNS_5assetENSt3__112basic_stringIcNS3_11char_traitsIcEENS3_9allocatorIcEEEEEEEbPT_MT0_FvDpT1_E,"axG",@progbits,_ZN5eosio14execute_actionINS_5tokenES1_JyyNS_5assetENSt3__112basic_stringIcNS3_11char_traitsIcEENS3_9allocatorIcEEEEEEEbPT_MT0_FvDpT1_E,comdat
	.hidden	_ZN5eosio14execute_actionINS_5tokenES1_JyyNS_5assetENSt3__112basic_stringIcNS3_11char_traitsIcEENS3_9allocatorIcEEEEEEEbPT_MT0_FvDpT1_E
	.weak	_ZN5eosio14execute_actionINS_5tokenES1_JyyNS_5assetENSt3__112basic_stringIcNS3_11char_traitsIcEENS3_9allocatorIcEEEEEEEbPT_MT0_FvDpT1_E
	.type	_ZN5eosio14execute_actionINS_5tokenES1_JyyNS_5assetENSt3__112basic_stringIcNS3_11char_traitsIcEENS3_9allocatorIcEEEEEEEbPT_MT0_FvDpT1_E,@function
_ZN5eosio14execute_actionINS_5tokenES1_JyyNS_5assetENSt3__112basic_stringIcNS3_11char_traitsIcEENS3_9allocatorIcEEEEEEEbPT_MT0_FvDpT1_E:
	.param  	i32, i32
	.result 	i32
	.local  	i32, i64, i32, i32
	i32.const	$push37=, 0
	i32.const	$push34=, 0
	i32.load	$push35=, __stack_pointer($pop34)
	i32.const	$push36=, 96
	i32.sub 	$push59=, $pop35, $pop36
	tee_local	$push58=, $4=, $pop59
	i32.store	__stack_pointer($pop37), $pop58
	copy_local	$push57=, $4
	tee_local	$push56=, $5=, $pop57
	i32.store	60($pop56), $0
	i32.load	$push0=, 0($1)
	i32.store	48($5), $pop0
	i32.load	$push1=, 4($1)
	i32.store	52($5), $pop1
	i32.const	$1=, 0
	i32.const	$0=, 0
	block   	
	i32.call	$push55=, action_data_size@FUNCTION
	tee_local	$push54=, $2=, $pop55
	i32.eqz 	$push91=, $pop54
	br_if   	0, $pop91
	block   	
	block   	
	i32.const	$push2=, 513
	i32.lt_u	$push3=, $2, $pop2
	br_if   	0, $pop3
	i32.call	$0=, malloc@FUNCTION, $2
	br      	1
.LBB30_3:
	end_block
	i32.const	$push33=, 0
	i32.const	$push4=, 15
	i32.add 	$push5=, $2, $pop4
	i32.const	$push6=, -16
	i32.and 	$push7=, $pop5, $pop6
	i32.sub 	$push61=, $4, $pop7
	tee_local	$push60=, $0=, $pop61
	copy_local	$push53=, $pop60
	i32.store	__stack_pointer($pop33), $pop53
.LBB30_4:
	end_block
	i32.call	$drop=, read_action_data@FUNCTION, $0, $2
.LBB30_5:
	end_block
	i32.const	$push66=, 24
	i32.add 	$push8=, $5, $pop66
	i64.const	$push9=, 1397703940
	i64.store	0($pop8), $pop9
	i64.const	$push65=, 0
	i64.store	8($5), $pop65
	i64.const	$push64=, 0
	i64.store	0($5), $pop64
	i64.const	$push63=, 0
	i64.store	16($5), $pop63
	i32.const	$push62=, 1
	i32.const	$push10=, .L.str.23
	call    	eosio_assert@FUNCTION, $pop62, $pop10
	i64.const	$3=, 5459781
.LBB30_6:
	block   	
	block   	
	loop    	
	i32.wrap/i64	$push11=, $3
	i32.const	$push69=, 24
	i32.shl 	$push12=, $pop11, $pop69
	i32.const	$push68=, -1073741825
	i32.add 	$push13=, $pop12, $pop68
	i32.const	$push67=, 452984830
	i32.gt_u	$push14=, $pop13, $pop67
	br_if   	1, $pop14
	block   	
	i64.const	$push74=, 8
	i64.shr_u	$push73=, $3, $pop74
	tee_local	$push72=, $3=, $pop73
	i64.const	$push71=, 255
	i64.and 	$push15=, $pop72, $pop71
	i64.const	$push70=, 0
	i64.ne  	$push16=, $pop15, $pop70
	br_if   	0, $pop16
.LBB30_8:
	loop    	
	i64.const	$push79=, 8
	i64.shr_u	$push78=, $3, $pop79
	tee_local	$push77=, $3=, $pop78
	i64.const	$push76=, 255
	i64.and 	$push17=, $pop77, $pop76
	i64.const	$push75=, 0
	i64.ne  	$push18=, $pop17, $pop75
	br_if   	3, $pop18
	i32.const	$push83=, 1
	i32.add 	$push82=, $1, $pop83
	tee_local	$push81=, $1=, $pop82
	i32.const	$push80=, 7
	i32.lt_s	$push19=, $pop81, $pop80
	br_if   	0, $pop19
.LBB30_10:
	end_loop
	end_block
	i32.const	$4=, 1
	i32.const	$push87=, 1
	i32.add 	$push86=, $1, $pop87
	tee_local	$push85=, $1=, $pop86
	i32.const	$push84=, 7
	i32.lt_s	$push20=, $pop85, $pop84
	br_if   	0, $pop20
	br      	2
.LBB30_11:
	end_loop
	end_block
	i32.const	$4=, 0
.LBB30_12:
	end_block
	i32.const	$push21=, .L.str
	call    	eosio_assert@FUNCTION, $4, $pop21
	i32.const	$push22=, 40
	i32.add 	$push23=, $5, $pop22
	i32.const	$push88=, 0
	i32.store	0($pop23), $pop88
	i64.const	$push24=, 0
	i64.store	32($5), $pop24
	i32.store	68($5), $0
	i32.store	64($5), $0
	i32.add 	$push25=, $0, $2
	i32.store	72($5), $pop25
	i32.const	$push41=, 64
	i32.add 	$push42=, $5, $pop41
	i32.store	80($5), $pop42
	i32.store	88($5), $5
	i32.const	$push43=, 88
	i32.add 	$push44=, $5, $pop43
	i32.const	$push45=, 80
	i32.add 	$push46=, $5, $pop45
	call    	_ZN5boost6fusion6detail17for_each_unrolledILi4EE4callINS0_18std_tuple_iteratorINSt3__15tupleIJyyN5eosio5assetENS6_12basic_stringIcNS6_11char_traitsIcEENS6_9allocatorIcEEEEEEELi0EEEZNS8_rsINS8_10datastreamIPKcEEJyyS9_SF_EEERT_SO_RNS7_IJDpT0_EEEEUlSO_E_EEvRKSN_RKT0_@FUNCTION, $pop44, $pop46
	block   	
	i32.const	$push26=, 513
	i32.lt_u	$push27=, $2, $pop26
	br_if   	0, $pop27
	call    	free@FUNCTION, $0
.LBB30_14:
	end_block
	i32.const	$push47=, 48
	i32.add 	$push48=, $5, $pop47
	i32.store	68($5), $pop48
	i32.const	$push49=, 60
	i32.add 	$push50=, $5, $pop49
	i32.store	64($5), $pop50
	i32.const	$push51=, 64
	i32.add 	$push52=, $5, $pop51
	call    	_ZN5boost4mp116detail16tuple_apply_implIRZN5eosio14execute_actionINS3_5tokenES5_JyyNS3_5assetENSt3__112basic_stringIcNS7_11char_traitsIcEENS7_9allocatorIcEEEEEEEbPT_MT0_FvDpT1_EEUlDpT_E_RNS7_5tupleIJyyS6_SD_EEEJLj0ELj1ELj2ELj3EEEEDTclclsr3stdE7forwardISE_Efp_Espclsr3stdE3getIXT1_EEclsr3stdE7forwardISG_Efp0_EEEEOSE_OSG_NS0_16integer_sequenceIjJXspT1_EEEE@FUNCTION, $pop52, $5
	block   	
	i32.load8_u	$push28=, 32($5)
	i32.const	$push89=, 1
	i32.and 	$push29=, $pop28, $pop89
	i32.eqz 	$push92=, $pop29
	br_if   	0, $pop92
	i32.const	$push30=, 40
	i32.add 	$push31=, $5, $pop30
	i32.load	$push32=, 0($pop31)
	call    	_ZdlPv@FUNCTION, $pop32
.LBB30_16:
	end_block
	i32.const	$push40=, 0
	i32.const	$push38=, 96
	i32.add 	$push39=, $5, $pop38
	i32.store	__stack_pointer($pop40), $pop39
	i32.const	$push90=, 1
	.endfunc
.Lfunc_end30:
	.size	_ZN5eosio14execute_actionINS_5tokenES1_JyyNS_5assetENSt3__112basic_stringIcNS3_11char_traitsIcEENS3_9allocatorIcEEEEEEEbPT_MT0_FvDpT1_E, .Lfunc_end30-_ZN5eosio14execute_actionINS_5tokenES1_JyyNS_5assetENSt3__112basic_stringIcNS3_11char_traitsIcEENS3_9allocatorIcEEEEEEEbPT_MT0_FvDpT1_E

	.section	.text._ZN5boost6fusion6detail17for_each_unrolledILi4EE4callINS0_18std_tuple_iteratorINSt3__15tupleIJyyN5eosio5assetENS6_12basic_stringIcNS6_11char_traitsIcEENS6_9allocatorIcEEEEEEELi0EEEZNS8_rsINS8_10datastreamIPKcEEJyyS9_SF_EEERT_SO_RNS7_IJDpT0_EEEEUlSO_E_EEvRKSN_RKT0_,"axG",@progbits,_ZN5boost6fusion6detail17for_each_unrolledILi4EE4callINS0_18std_tuple_iteratorINSt3__15tupleIJyyN5eosio5assetENS6_12basic_stringIcNS6_11char_traitsIcEENS6_9allocatorIcEEEEEEELi0EEEZNS8_rsINS8_10datastreamIPKcEEJyyS9_SF_EEERT_SO_RNS7_IJDpT0_EEEEUlSO_E_EEvRKSN_RKT0_,comdat
	.hidden	_ZN5boost6fusion6detail17for_each_unrolledILi4EE4callINS0_18std_tuple_iteratorINSt3__15tupleIJyyN5eosio5assetENS6_12basic_stringIcNS6_11char_traitsIcEENS6_9allocatorIcEEEEEEELi0EEEZNS8_rsINS8_10datastreamIPKcEEJyyS9_SF_EEERT_SO_RNS7_IJDpT0_EEEEUlSO_E_EEvRKSN_RKT0_
	.weak	_ZN5boost6fusion6detail17for_each_unrolledILi4EE4callINS0_18std_tuple_iteratorINSt3__15tupleIJyyN5eosio5assetENS6_12basic_stringIcNS6_11char_traitsIcEENS6_9allocatorIcEEEEEEELi0EEEZNS8_rsINS8_10datastreamIPKcEEJyyS9_SF_EEERT_SO_RNS7_IJDpT0_EEEEUlSO_E_EEvRKSN_RKT0_
	.type	_ZN5boost6fusion6detail17for_each_unrolledILi4EE4callINS0_18std_tuple_iteratorINSt3__15tupleIJyyN5eosio5assetENS6_12basic_stringIcNS6_11char_traitsIcEENS6_9allocatorIcEEEEEEELi0EEEZNS8_rsINS8_10datastreamIPKcEEJyyS9_SF_EEERT_SO_RNS7_IJDpT0_EEEEUlSO_E_EEvRKSN_RKT0_,@function
_ZN5boost6fusion6detail17for_each_unrolledILi4EE4callINS0_18std_tuple_iteratorINSt3__15tupleIJyyN5eosio5assetENS6_12basic_stringIcNS6_11char_traitsIcEENS6_9allocatorIcEEEEEEELi0EEEZNS8_rsINS8_10datastreamIPKcEEJyyS9_SF_EEERT_SO_RNS7_IJDpT0_EEEEUlSO_E_EEvRKSN_RKT0_:
	.param  	i32, i32
	.local  	i32, i32
	i32.load	$2=, 0($0)
	i32.load	$push58=, 0($1)
	tee_local	$push57=, $3=, $pop58
	i32.load	$push1=, 8($pop57)
	i32.load	$push0=, 4($3)
	i32.sub 	$push2=, $pop1, $pop0
	i32.const	$push3=, 7
	i32.gt_u	$push4=, $pop2, $pop3
	i32.const	$push5=, .L.str.24
	call    	eosio_assert@FUNCTION, $pop4, $pop5
	i32.load	$push6=, 4($3)
	i32.const	$push7=, 8
	i32.call	$drop=, memcpy@FUNCTION, $2, $pop6, $pop7
	i32.load	$push8=, 4($3)
	i32.const	$push56=, 8
	i32.add 	$push9=, $pop8, $pop56
	i32.store	4($3), $pop9
	i32.load	$0=, 0($0)
	i32.load	$push55=, 0($1)
	tee_local	$push54=, $3=, $pop55
	i32.load	$push11=, 8($pop54)
	i32.load	$push10=, 4($3)
	i32.sub 	$push12=, $pop11, $pop10
	i32.const	$push53=, 7
	i32.gt_u	$push13=, $pop12, $pop53
	i32.const	$push52=, .L.str.24
	call    	eosio_assert@FUNCTION, $pop13, $pop52
	i32.const	$push51=, 8
	i32.add 	$push14=, $0, $pop51
	i32.load	$push15=, 4($3)
	i32.const	$push50=, 8
	i32.call	$drop=, memcpy@FUNCTION, $pop14, $pop15, $pop50
	i32.load	$push16=, 4($3)
	i32.const	$push49=, 8
	i32.add 	$push17=, $pop16, $pop49
	i32.store	4($3), $pop17
	i32.load	$push48=, 0($1)
	tee_local	$push47=, $3=, $pop48
	i32.load	$push19=, 8($pop47)
	i32.load	$push18=, 4($3)
	i32.sub 	$push20=, $pop19, $pop18
	i32.const	$push46=, 7
	i32.gt_u	$push21=, $pop20, $pop46
	i32.const	$push45=, .L.str.24
	call    	eosio_assert@FUNCTION, $pop21, $pop45
	i32.const	$push22=, 16
	i32.add 	$push23=, $0, $pop22
	i32.load	$push24=, 4($3)
	i32.const	$push44=, 8
	i32.call	$drop=, memcpy@FUNCTION, $pop23, $pop24, $pop44
	i32.load	$push25=, 4($3)
	i32.const	$push43=, 8
	i32.add 	$push42=, $pop25, $pop43
	tee_local	$push41=, $2=, $pop42
	i32.store	4($3), $pop41
	i32.load	$push26=, 8($3)
	i32.sub 	$push27=, $pop26, $2
	i32.const	$push40=, 7
	i32.gt_u	$push28=, $pop27, $pop40
	i32.const	$push39=, .L.str.24
	call    	eosio_assert@FUNCTION, $pop28, $pop39
	i32.const	$push29=, 24
	i32.add 	$push30=, $0, $pop29
	i32.load	$push31=, 4($3)
	i32.const	$push38=, 8
	i32.call	$drop=, memcpy@FUNCTION, $pop30, $pop31, $pop38
	i32.load	$push32=, 4($3)
	i32.const	$push37=, 8
	i32.add 	$push33=, $pop32, $pop37
	i32.store	4($3), $pop33
	i32.load	$push36=, 0($1)
	i32.const	$push34=, 32
	i32.add 	$push35=, $0, $pop34
	i32.call	$drop=, _ZN5eosiorsINS_10datastreamIPKcEEEERT_S6_RNSt3__112basic_stringIcNS7_11char_traitsIcEENS7_9allocatorIcEEEE@FUNCTION, $pop36, $pop35
	.endfunc
.Lfunc_end31:
	.size	_ZN5boost6fusion6detail17for_each_unrolledILi4EE4callINS0_18std_tuple_iteratorINSt3__15tupleIJyyN5eosio5assetENS6_12basic_stringIcNS6_11char_traitsIcEENS6_9allocatorIcEEEEEEELi0EEEZNS8_rsINS8_10datastreamIPKcEEJyyS9_SF_EEERT_SO_RNS7_IJDpT0_EEEEUlSO_E_EEvRKSN_RKT0_, .Lfunc_end31-_ZN5boost6fusion6detail17for_each_unrolledILi4EE4callINS0_18std_tuple_iteratorINSt3__15tupleIJyyN5eosio5assetENS6_12basic_stringIcNS6_11char_traitsIcEENS6_9allocatorIcEEEEEEELi0EEEZNS8_rsINS8_10datastreamIPKcEEJyyS9_SF_EEERT_SO_RNS7_IJDpT0_EEEEUlSO_E_EEvRKSN_RKT0_

	.section	.text._ZN5boost4mp116detail16tuple_apply_implIRZN5eosio14execute_actionINS3_5tokenES5_JyyNS3_5assetENSt3__112basic_stringIcNS7_11char_traitsIcEENS7_9allocatorIcEEEEEEEbPT_MT0_FvDpT1_EEUlDpT_E_RNS7_5tupleIJyyS6_SD_EEEJLj0ELj1ELj2ELj3EEEEDTclclsr3stdE7forwardISE_Efp_Espclsr3stdE3getIXT1_EEclsr3stdE7forwardISG_Efp0_EEEEOSE_OSG_NS0_16integer_sequenceIjJXspT1_EEEE,"axG",@progbits,_ZN5boost4mp116detail16tuple_apply_implIRZN5eosio14execute_actionINS3_5tokenES5_JyyNS3_5assetENSt3__112basic_stringIcNS7_11char_traitsIcEENS7_9allocatorIcEEEEEEEbPT_MT0_FvDpT1_EEUlDpT_E_RNS7_5tupleIJyyS6_SD_EEEJLj0ELj1ELj2ELj3EEEEDTclclsr3stdE7forwardISE_Efp_Espclsr3stdE3getIXT1_EEclsr3stdE7forwardISG_Efp0_EEEEOSE_OSG_NS0_16integer_sequenceIjJXspT1_EEEE,comdat
	.hidden	_ZN5boost4mp116detail16tuple_apply_implIRZN5eosio14execute_actionINS3_5tokenES5_JyyNS3_5assetENSt3__112basic_stringIcNS7_11char_traitsIcEENS7_9allocatorIcEEEEEEEbPT_MT0_FvDpT1_EEUlDpT_E_RNS7_5tupleIJyyS6_SD_EEEJLj0ELj1ELj2ELj3EEEEDTclclsr3stdE7forwardISE_Efp_Espclsr3stdE3getIXT1_EEclsr3stdE7forwardISG_Efp0_EEEEOSE_OSG_NS0_16integer_sequenceIjJXspT1_EEEE
	.weak	_ZN5boost4mp116detail16tuple_apply_implIRZN5eosio14execute_actionINS3_5tokenES5_JyyNS3_5assetENSt3__112basic_stringIcNS7_11char_traitsIcEENS7_9allocatorIcEEEEEEEbPT_MT0_FvDpT1_EEUlDpT_E_RNS7_5tupleIJyyS6_SD_EEEJLj0ELj1ELj2ELj3EEEEDTclclsr3stdE7forwardISE_Efp_Espclsr3stdE3getIXT1_EEclsr3stdE7forwardISG_Efp0_EEEEOSE_OSG_NS0_16integer_sequenceIjJXspT1_EEEE
	.type	_ZN5boost4mp116detail16tuple_apply_implIRZN5eosio14execute_actionINS3_5tokenES5_JyyNS3_5assetENSt3__112basic_stringIcNS7_11char_traitsIcEENS7_9allocatorIcEEEEEEEbPT_MT0_FvDpT1_EEUlDpT_E_RNS7_5tupleIJyyS6_SD_EEEJLj0ELj1ELj2ELj3EEEEDTclclsr3stdE7forwardISE_Efp_Espclsr3stdE3getIXT1_EEclsr3stdE7forwardISG_Efp0_EEEEOSE_OSG_NS0_16integer_sequenceIjJXspT1_EEEE,@function
_ZN5boost4mp116detail16tuple_apply_implIRZN5eosio14execute_actionINS3_5tokenES5_JyyNS3_5assetENSt3__112basic_stringIcNS7_11char_traitsIcEENS7_9allocatorIcEEEEEEEbPT_MT0_FvDpT1_EEUlDpT_E_RNS7_5tupleIJyyS6_SD_EEEJLj0ELj1ELj2ELj3EEEEDTclclsr3stdE7forwardISE_Efp_Espclsr3stdE3getIXT1_EEclsr3stdE7forwardISG_Efp0_EEEEOSE_OSG_NS0_16integer_sequenceIjJXspT1_EEEE:
	.param  	i32, i32
	.local  	i64, i64, i32, i32
	i32.const	$push41=, 0
	i32.const	$push38=, 0
	i32.load	$push39=, __stack_pointer($pop38)
	i32.const	$push40=, 96
	i32.sub 	$push70=, $pop39, $pop40
	tee_local	$push69=, $5=, $pop70
	i32.store	__stack_pointer($pop41), $pop69
	i32.const	$push3=, 44
	i32.add 	$push4=, $5, $pop3
	i32.const	$push0=, 28
	i32.add 	$push1=, $1, $pop0
	i32.load	$push2=, 0($pop1)
	i32.store	0($pop4), $pop2
	i32.const	$push45=, 32
	i32.add 	$push46=, $5, $pop45
	i32.const	$push8=, 8
	i32.add 	$push68=, $pop46, $pop8
	tee_local	$push67=, $4=, $pop68
	i32.const	$push5=, 24
	i32.add 	$push6=, $1, $pop5
	i32.load	$push7=, 0($pop6)
	i32.store	0($pop67), $pop7
	i32.load	$push9=, 16($1)
	i32.store	32($5), $pop9
	i32.const	$push10=, 20
	i32.add 	$push11=, $1, $pop10
	i32.load	$push12=, 0($pop11)
	i32.store	36($5), $pop12
	i64.load	$3=, 8($1)
	i64.load	$2=, 0($1)
	i32.const	$push47=, 16
	i32.add 	$push48=, $5, $pop47
	i32.const	$push13=, 32
	i32.add 	$push14=, $1, $pop13
	i32.call	$drop=, _ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC1ERKS5_@FUNCTION, $pop48, $pop14
	i32.const	$push49=, 48
	i32.add 	$push50=, $5, $pop49
	i32.const	$push66=, 8
	i32.add 	$push15=, $pop50, $pop66
	i64.load	$push16=, 0($4)
	i64.store	0($pop15), $pop16
	i64.load	$push17=, 32($5)
	i64.store	48($5), $pop17
	i32.load	$push20=, 0($0)
	i32.load	$push21=, 0($pop20)
	i32.load	$push65=, 4($0)
	tee_local	$push64=, $1=, $pop65
	i32.load	$push63=, 4($pop64)
	tee_local	$push62=, $4=, $pop63
	i32.const	$push18=, 1
	i32.shr_s	$push19=, $pop62, $pop18
	i32.add 	$0=, $pop21, $pop19
	i32.load	$1=, 0($1)
	block   	
	i32.const	$push61=, 1
	i32.and 	$push22=, $4, $pop61
	i32.eqz 	$push77=, $pop22
	br_if   	0, $pop77
	i32.load	$push23=, 0($0)
	i32.add 	$push24=, $pop23, $1
	i32.load	$1=, 0($pop24)
.LBB32_2:
	end_block
	i32.const	$push51=, 80
	i32.add 	$push52=, $5, $pop51
	i32.const	$push25=, 8
	i32.add 	$push75=, $pop52, $pop25
	tee_local	$push74=, $4=, $pop75
	i32.const	$push53=, 48
	i32.add 	$push54=, $5, $pop53
	i32.const	$push73=, 8
	i32.add 	$push26=, $pop54, $pop73
	i64.load	$push27=, 0($pop26)
	i64.store	0($pop74), $pop27
	i64.load	$push28=, 48($5)
	i64.store	80($5), $pop28
	i32.const	$push55=, 64
	i32.add 	$push56=, $5, $pop55
	i32.const	$push57=, 16
	i32.add 	$push58=, $5, $pop57
	i32.call	$drop=, _ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC1ERKS5_@FUNCTION, $pop56, $pop58
	i32.const	$push72=, 8
	i32.add 	$push29=, $5, $pop72
	i64.load	$push30=, 0($4)
	i64.store	0($pop29), $pop30
	i64.load	$push31=, 80($5)
	i64.store	0($5), $pop31
	i32.const	$push59=, 64
	i32.add 	$push60=, $5, $pop59
	call_indirect	$0, $2, $3, $5, $pop60, $1
	block   	
	i32.load8_u	$push32=, 64($5)
	i32.const	$push71=, 1
	i32.and 	$push33=, $pop32, $pop71
	i32.eqz 	$push78=, $pop33
	br_if   	0, $pop78
	i32.load	$push34=, 72($5)
	call    	_ZdlPv@FUNCTION, $pop34
.LBB32_4:
	end_block
	block   	
	i32.load8_u	$push35=, 16($5)
	i32.const	$push76=, 1
	i32.and 	$push36=, $pop35, $pop76
	i32.eqz 	$push79=, $pop36
	br_if   	0, $pop79
	i32.load	$push37=, 24($5)
	call    	_ZdlPv@FUNCTION, $pop37
.LBB32_6:
	end_block
	i32.const	$push44=, 0
	i32.const	$push42=, 96
	i32.add 	$push43=, $5, $pop42
	i32.store	__stack_pointer($pop44), $pop43
	.endfunc
.Lfunc_end32:
	.size	_ZN5boost4mp116detail16tuple_apply_implIRZN5eosio14execute_actionINS3_5tokenES5_JyyNS3_5assetENSt3__112basic_stringIcNS7_11char_traitsIcEENS7_9allocatorIcEEEEEEEbPT_MT0_FvDpT1_EEUlDpT_E_RNS7_5tupleIJyyS6_SD_EEEJLj0ELj1ELj2ELj3EEEEDTclclsr3stdE7forwardISE_Efp_Espclsr3stdE3getIXT1_EEclsr3stdE7forwardISG_Efp0_EEEEOSE_OSG_NS0_16integer_sequenceIjJXspT1_EEEE, .Lfunc_end32-_ZN5boost4mp116detail16tuple_apply_implIRZN5eosio14execute_actionINS3_5tokenES5_JyyNS3_5assetENSt3__112basic_stringIcNS7_11char_traitsIcEENS7_9allocatorIcEEEEEEEbPT_MT0_FvDpT1_EEUlDpT_E_RNS7_5tupleIJyyS6_SD_EEEJLj0ELj1ELj2ELj3EEEEDTclclsr3stdE7forwardISE_Efp_Espclsr3stdE3getIXT1_EEclsr3stdE7forwardISG_Efp0_EEEEOSE_OSG_NS0_16integer_sequenceIjJXspT1_EEEE

	.section	.text._ZN5eosiorsINS_10datastreamIPKcEEEERT_S6_RNSt3__112basic_stringIcNS7_11char_traitsIcEENS7_9allocatorIcEEEE,"axG",@progbits,_ZN5eosiorsINS_10datastreamIPKcEEEERT_S6_RNSt3__112basic_stringIcNS7_11char_traitsIcEENS7_9allocatorIcEEEE,comdat
	.hidden	_ZN5eosiorsINS_10datastreamIPKcEEEERT_S6_RNSt3__112basic_stringIcNS7_11char_traitsIcEENS7_9allocatorIcEEEE
	.weak	_ZN5eosiorsINS_10datastreamIPKcEEEERT_S6_RNSt3__112basic_stringIcNS7_11char_traitsIcEENS7_9allocatorIcEEEE
	.type	_ZN5eosiorsINS_10datastreamIPKcEEEERT_S6_RNSt3__112basic_stringIcNS7_11char_traitsIcEENS7_9allocatorIcEEEE,@function
_ZN5eosiorsINS_10datastreamIPKcEEEERT_S6_RNSt3__112basic_stringIcNS7_11char_traitsIcEENS7_9allocatorIcEEEE:
	.param  	i32, i32
	.result 	i32
	.local  	i32, i32, i32, i32, i32, i32
	i32.const	$push38=, 0
	i32.const	$push35=, 0
	i32.load	$push36=, __stack_pointer($pop35)
	i32.const	$push37=, 32
	i32.sub 	$push51=, $pop36, $pop37
	tee_local	$push50=, $7=, $pop51
	i32.store	__stack_pointer($pop38), $pop50
	i32.const	$push49=, 0
	i32.store	24($7), $pop49
	i64.const	$push48=, 0
	i64.store	16($7), $pop48
	i32.const	$push42=, 16
	i32.add 	$push43=, $7, $pop42
	i32.call	$drop=, _ZN5eosiorsINS_10datastreamIPKcEEEERT_S6_RNSt3__16vectorIcNS7_9allocatorIcEEEE@FUNCTION, $0, $pop43
	block   	
	block   	
	block   	
	block   	
	block   	
	block   	
	block   	
	block   	
	block   	
	i32.load	$push47=, 20($7)
	tee_local	$push46=, $5=, $pop47
	i32.load	$push45=, 16($7)
	tee_local	$push44=, $4=, $pop45
	i32.ne  	$push0=, $pop46, $pop44
	br_if   	0, $pop0
	i32.load8_u	$push25=, 0($1)
	i32.const	$push26=, 1
	i32.and 	$push27=, $pop25, $pop26
	br_if   	1, $pop27
	i32.const	$push31=, 0
	i32.store16	0($1), $pop31
	i32.const	$push32=, 8
	i32.add 	$4=, $1, $pop32
	br      	2
.LBB33_3:
	end_block
	i32.const	$push1=, 8
	i32.add 	$push2=, $7, $pop1
	i32.const	$push55=, 0
	i32.store	0($pop2), $pop55
	i64.const	$push54=, 0
	i64.store	0($7), $pop54
	i32.sub 	$push53=, $5, $4
	tee_local	$push52=, $2=, $pop53
	i32.const	$push3=, -16
	i32.ge_u	$push4=, $pop52, $pop3
	br_if   	7, $pop4
	i32.const	$push5=, 11
	i32.ge_u	$push6=, $2, $pop5
	br_if   	2, $pop6
	i32.const	$push12=, 1
	i32.shl 	$push13=, $2, $pop12
	i32.store8	0($7), $pop13
	i32.const	$push56=, 1
	i32.or  	$6=, $7, $pop56
	br_if   	3, $2
	br      	4
.LBB33_6:
	end_block
	i32.load	$push28=, 8($1)
	i32.const	$push29=, 0
	i32.store8	0($pop28), $pop29
	i32.const	$push57=, 0
	i32.store	4($1), $pop57
	i32.const	$push30=, 8
	i32.add 	$4=, $1, $pop30
.LBB33_7:
	end_block
	i32.const	$push33=, 0
	call    	_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE7reserveEj@FUNCTION, $1, $pop33
	i32.const	$push60=, 0
	i32.store	0($4), $pop60
	i64.const	$push34=, 0
	i64.store	0($1):p2align=2, $pop34
	i32.load	$push59=, 16($7)
	tee_local	$push58=, $4=, $pop59
	br_if   	3, $pop58
	br      	4
.LBB33_8:
	end_block
	i32.const	$push7=, 16
	i32.add 	$push8=, $2, $pop7
	i32.const	$push9=, -16
	i32.and 	$push62=, $pop8, $pop9
	tee_local	$push61=, $5=, $pop62
	i32.call	$6=, _Znwj@FUNCTION, $pop61
	i32.const	$push10=, 1
	i32.or  	$push11=, $5, $pop10
	i32.store	0($7), $pop11
	i32.store	8($7), $6
	i32.store	4($7), $2
.LBB33_9:
	end_block
	copy_local	$3=, $2
	copy_local	$5=, $6
.LBB33_10:
	loop    	
	i32.load8_u	$push14=, 0($4)
	i32.store8	0($5), $pop14
	i32.const	$push67=, 1
	i32.add 	$5=, $5, $pop67
	i32.const	$push66=, 1
	i32.add 	$4=, $4, $pop66
	i32.const	$push65=, -1
	i32.add 	$push64=, $3, $pop65
	tee_local	$push63=, $3=, $pop64
	br_if   	0, $pop63
	end_loop
	i32.add 	$6=, $6, $2
.LBB33_12:
	end_block
	i32.const	$push68=, 0
	i32.store8	0($6), $pop68
	block   	
	block   	
	i32.load8_u	$push15=, 0($1)
	i32.const	$push16=, 1
	i32.and 	$push17=, $pop15, $pop16
	br_if   	0, $pop17
	i32.const	$push69=, 0
	i32.store16	0($1), $pop69
	br      	1
.LBB33_14:
	end_block
	i32.load	$push18=, 8($1)
	i32.const	$push71=, 0
	i32.store8	0($pop18), $pop71
	i32.const	$push70=, 0
	i32.store	4($1), $pop70
.LBB33_15:
	end_block
	i32.const	$push19=, 0
	call    	_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE7reserveEj@FUNCTION, $1, $pop19
	i32.const	$push20=, 8
	i32.add 	$push21=, $1, $pop20
	i32.const	$push74=, 8
	i32.add 	$push22=, $7, $pop74
	i32.load	$push23=, 0($pop22)
	i32.store	0($pop21), $pop23
	i64.load	$push24=, 0($7)
	i64.store	0($1):p2align=2, $pop24
	i32.load	$push73=, 16($7)
	tee_local	$push72=, $4=, $pop73
	i32.eqz 	$push75=, $pop72
	br_if   	1, $pop75
.LBB33_16:
	end_block
	i32.store	20($7), $4
	call    	_ZdlPv@FUNCTION, $4
.LBB33_17:
	end_block
	i32.const	$push41=, 0
	i32.const	$push39=, 32
	i32.add 	$push40=, $7, $pop39
	i32.store	__stack_pointer($pop41), $pop40
	return  	$0
.LBB33_18:
	end_block
	call    	_ZNKSt3__121__basic_string_commonILb1EE20__throw_length_errorEv@FUNCTION, $7
	unreachable
	.endfunc
.Lfunc_end33:
	.size	_ZN5eosiorsINS_10datastreamIPKcEEEERT_S6_RNSt3__112basic_stringIcNS7_11char_traitsIcEENS7_9allocatorIcEEEE, .Lfunc_end33-_ZN5eosiorsINS_10datastreamIPKcEEEERT_S6_RNSt3__112basic_stringIcNS7_11char_traitsIcEENS7_9allocatorIcEEEE

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
.LBB34_1:
	loop    	
	i32.load	$push1=, 0($2)
	i32.lt_u	$push2=, $5, $pop1
	i32.const	$push37=, .L.str.41
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
.LBB34_4:
	end_block
	i32.ge_u	$push9=, $3, $2
	br_if   	0, $pop9
	i32.const	$push10=, 4
	i32.add 	$push11=, $1, $pop10
	i32.add 	$push48=, $4, $3
	tee_local	$push47=, $7=, $pop48
	i32.store	0($pop11), $pop47
.LBB34_6:
	end_block
	i32.const	$push16=, 8
	i32.add 	$push17=, $0, $pop16
	i32.load	$push18=, 0($pop17)
	i32.sub 	$push19=, $pop18, $5
	i32.sub 	$push52=, $7, $4
	tee_local	$push51=, $5=, $pop52
	i32.ge_u	$push20=, $pop19, $pop51
	i32.const	$push21=, .L.str.24
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
.Lfunc_end34:
	.size	_ZN5eosiorsINS_10datastreamIPKcEEEERT_S6_RNSt3__16vectorIcNS7_9allocatorIcEEEE, .Lfunc_end34-_ZN5eosiorsINS_10datastreamIPKcEEEERT_S6_RNSt3__16vectorIcNS7_9allocatorIcEEEE

	.section	.text._ZN5boost4mp116detail16tuple_apply_implIRZN5eosio14execute_actionINS3_5tokenES5_JyNS3_5assetENSt3__112basic_stringIcNS7_11char_traitsIcEENS7_9allocatorIcEEEEEEEbPT_MT0_FvDpT1_EEUlDpT_E_RNS7_5tupleIJyS6_SD_EEEJLj0ELj1ELj2EEEEDTclclsr3stdE7forwardISE_Efp_Espclsr3stdE3getIXT1_EEclsr3stdE7forwardISG_Efp0_EEEEOSE_OSG_NS0_16integer_sequenceIjJXspT1_EEEE,"axG",@progbits,_ZN5boost4mp116detail16tuple_apply_implIRZN5eosio14execute_actionINS3_5tokenES5_JyNS3_5assetENSt3__112basic_stringIcNS7_11char_traitsIcEENS7_9allocatorIcEEEEEEEbPT_MT0_FvDpT1_EEUlDpT_E_RNS7_5tupleIJyS6_SD_EEEJLj0ELj1ELj2EEEEDTclclsr3stdE7forwardISE_Efp_Espclsr3stdE3getIXT1_EEclsr3stdE7forwardISG_Efp0_EEEEOSE_OSG_NS0_16integer_sequenceIjJXspT1_EEEE,comdat
	.hidden	_ZN5boost4mp116detail16tuple_apply_implIRZN5eosio14execute_actionINS3_5tokenES5_JyNS3_5assetENSt3__112basic_stringIcNS7_11char_traitsIcEENS7_9allocatorIcEEEEEEEbPT_MT0_FvDpT1_EEUlDpT_E_RNS7_5tupleIJyS6_SD_EEEJLj0ELj1ELj2EEEEDTclclsr3stdE7forwardISE_Efp_Espclsr3stdE3getIXT1_EEclsr3stdE7forwardISG_Efp0_EEEEOSE_OSG_NS0_16integer_sequenceIjJXspT1_EEEE
	.weak	_ZN5boost4mp116detail16tuple_apply_implIRZN5eosio14execute_actionINS3_5tokenES5_JyNS3_5assetENSt3__112basic_stringIcNS7_11char_traitsIcEENS7_9allocatorIcEEEEEEEbPT_MT0_FvDpT1_EEUlDpT_E_RNS7_5tupleIJyS6_SD_EEEJLj0ELj1ELj2EEEEDTclclsr3stdE7forwardISE_Efp_Espclsr3stdE3getIXT1_EEclsr3stdE7forwardISG_Efp0_EEEEOSE_OSG_NS0_16integer_sequenceIjJXspT1_EEEE
	.type	_ZN5boost4mp116detail16tuple_apply_implIRZN5eosio14execute_actionINS3_5tokenES5_JyNS3_5assetENSt3__112basic_stringIcNS7_11char_traitsIcEENS7_9allocatorIcEEEEEEEbPT_MT0_FvDpT1_EEUlDpT_E_RNS7_5tupleIJyS6_SD_EEEJLj0ELj1ELj2EEEEDTclclsr3stdE7forwardISE_Efp_Espclsr3stdE3getIXT1_EEclsr3stdE7forwardISG_Efp0_EEEEOSE_OSG_NS0_16integer_sequenceIjJXspT1_EEEE,@function
_ZN5boost4mp116detail16tuple_apply_implIRZN5eosio14execute_actionINS3_5tokenES5_JyNS3_5assetENSt3__112basic_stringIcNS7_11char_traitsIcEENS7_9allocatorIcEEEEEEEbPT_MT0_FvDpT1_EEUlDpT_E_RNS7_5tupleIJyS6_SD_EEEJLj0ELj1ELj2EEEEDTclclsr3stdE7forwardISE_Efp_Espclsr3stdE3getIXT1_EEclsr3stdE7forwardISG_Efp0_EEEEOSE_OSG_NS0_16integer_sequenceIjJXspT1_EEEE:
	.param  	i32, i32
	.local  	i64, i32, i32
	i32.const	$push40=, 0
	i32.const	$push37=, 0
	i32.load	$push38=, __stack_pointer($pop37)
	i32.const	$push39=, 96
	i32.sub 	$push72=, $pop38, $pop39
	tee_local	$push71=, $4=, $pop72
	i32.store	__stack_pointer($pop40), $pop71
	i32.const	$push44=, 32
	i32.add 	$push45=, $4, $pop44
	i32.const	$push3=, 12
	i32.add 	$push4=, $pop45, $pop3
	i32.const	$push0=, 20
	i32.add 	$push1=, $1, $pop0
	i32.load	$push2=, 0($pop1)
	i32.store	0($pop4), $pop2
	i32.const	$push46=, 32
	i32.add 	$push47=, $4, $pop46
	i32.const	$push8=, 8
	i32.add 	$push70=, $pop47, $pop8
	tee_local	$push69=, $3=, $pop70
	i32.const	$push5=, 16
	i32.add 	$push6=, $1, $pop5
	i32.load	$push7=, 0($pop6)
	i32.store	0($pop69), $pop7
	i32.load	$push9=, 8($1)
	i32.store	32($4), $pop9
	i32.const	$push68=, 12
	i32.add 	$push10=, $1, $pop68
	i32.load	$push11=, 0($pop10)
	i32.store	36($4), $pop11
	i64.load	$2=, 0($1)
	i32.const	$push48=, 16
	i32.add 	$push49=, $4, $pop48
	i32.const	$push12=, 24
	i32.add 	$push13=, $1, $pop12
	i32.call	$drop=, _ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC1ERKS5_@FUNCTION, $pop49, $pop13
	i32.const	$push50=, 48
	i32.add 	$push51=, $4, $pop50
	i32.const	$push67=, 8
	i32.add 	$push14=, $pop51, $pop67
	i64.load	$push15=, 0($3)
	i64.store	0($pop14), $pop15
	i64.load	$push16=, 32($4)
	i64.store	48($4), $pop16
	i32.load	$push19=, 0($0)
	i32.load	$push20=, 0($pop19)
	i32.load	$push66=, 4($0)
	tee_local	$push65=, $1=, $pop66
	i32.load	$push64=, 4($pop65)
	tee_local	$push63=, $3=, $pop64
	i32.const	$push17=, 1
	i32.shr_s	$push18=, $pop63, $pop17
	i32.add 	$0=, $pop20, $pop18
	i32.load	$1=, 0($1)
	block   	
	i32.const	$push62=, 1
	i32.and 	$push21=, $3, $pop62
	i32.eqz 	$push79=, $pop21
	br_if   	0, $pop79
	i32.load	$push22=, 0($0)
	i32.add 	$push23=, $pop22, $1
	i32.load	$1=, 0($pop23)
.LBB35_2:
	end_block
	i32.const	$push52=, 80
	i32.add 	$push53=, $4, $pop52
	i32.const	$push24=, 8
	i32.add 	$push77=, $pop53, $pop24
	tee_local	$push76=, $3=, $pop77
	i32.const	$push54=, 48
	i32.add 	$push55=, $4, $pop54
	i32.const	$push75=, 8
	i32.add 	$push25=, $pop55, $pop75
	i64.load	$push26=, 0($pop25)
	i64.store	0($pop76), $pop26
	i64.load	$push27=, 48($4)
	i64.store	80($4), $pop27
	i32.const	$push56=, 64
	i32.add 	$push57=, $4, $pop56
	i32.const	$push58=, 16
	i32.add 	$push59=, $4, $pop58
	i32.call	$drop=, _ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC1ERKS5_@FUNCTION, $pop57, $pop59
	i32.const	$push74=, 8
	i32.add 	$push28=, $4, $pop74
	i64.load	$push29=, 0($3)
	i64.store	0($pop28), $pop29
	i64.load	$push30=, 80($4)
	i64.store	0($4), $pop30
	i32.const	$push60=, 64
	i32.add 	$push61=, $4, $pop60
	call_indirect	$0, $2, $4, $pop61, $1
	block   	
	i32.load8_u	$push31=, 64($4)
	i32.const	$push73=, 1
	i32.and 	$push32=, $pop31, $pop73
	i32.eqz 	$push80=, $pop32
	br_if   	0, $pop80
	i32.load	$push33=, 72($4)
	call    	_ZdlPv@FUNCTION, $pop33
.LBB35_4:
	end_block
	block   	
	i32.load8_u	$push34=, 16($4)
	i32.const	$push78=, 1
	i32.and 	$push35=, $pop34, $pop78
	i32.eqz 	$push81=, $pop35
	br_if   	0, $pop81
	i32.load	$push36=, 24($4)
	call    	_ZdlPv@FUNCTION, $pop36
.LBB35_6:
	end_block
	i32.const	$push43=, 0
	i32.const	$push41=, 96
	i32.add 	$push42=, $4, $pop41
	i32.store	__stack_pointer($pop43), $pop42
	.endfunc
.Lfunc_end35:
	.size	_ZN5boost4mp116detail16tuple_apply_implIRZN5eosio14execute_actionINS3_5tokenES5_JyNS3_5assetENSt3__112basic_stringIcNS7_11char_traitsIcEENS7_9allocatorIcEEEEEEEbPT_MT0_FvDpT1_EEUlDpT_E_RNS7_5tupleIJyS6_SD_EEEJLj0ELj1ELj2EEEEDTclclsr3stdE7forwardISE_Efp_Espclsr3stdE3getIXT1_EEclsr3stdE7forwardISG_Efp0_EEEEOSE_OSG_NS0_16integer_sequenceIjJXspT1_EEEE, .Lfunc_end35-_ZN5boost4mp116detail16tuple_apply_implIRZN5eosio14execute_actionINS3_5tokenES5_JyNS3_5assetENSt3__112basic_stringIcNS7_11char_traitsIcEENS7_9allocatorIcEEEEEEEbPT_MT0_FvDpT1_EEUlDpT_E_RNS7_5tupleIJyS6_SD_EEEJLj0ELj1ELj2EEEEDTclclsr3stdE7forwardISE_Efp_Espclsr3stdE3getIXT1_EEclsr3stdE7forwardISG_Efp0_EEEEOSE_OSG_NS0_16integer_sequenceIjJXspT1_EEEE

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
.LBB36_1:
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
.LBB36_3:
	end_loop
	end_block
	copy_local	$push12=, $0
	.endfunc
.Lfunc_end36:
	.size	_Znwj, .Lfunc_end36-_Znwj

	.weak	_ZdlPv
	.type	_ZdlPv,@function
_ZdlPv:
	.param  	i32
	block   	
	i32.eqz 	$push0=, $0
	br_if   	0, $pop0
	call    	free@FUNCTION, $0
.LBB37_2:
	end_block
	.endfunc
.Lfunc_end37:
	.size	_ZdlPv, .Lfunc_end37-_ZdlPv

	.section	.text._ZNKSt3__121__basic_string_commonILb1EE20__throw_length_errorEv,"axG",@progbits,_ZNKSt3__121__basic_string_commonILb1EE20__throw_length_errorEv,comdat
	.hidden	_ZNKSt3__121__basic_string_commonILb1EE20__throw_length_errorEv
	.weak	_ZNKSt3__121__basic_string_commonILb1EE20__throw_length_errorEv
	.type	_ZNKSt3__121__basic_string_commonILb1EE20__throw_length_errorEv,@function
_ZNKSt3__121__basic_string_commonILb1EE20__throw_length_errorEv:
	.param  	i32
	call    	abort@FUNCTION
	unreachable
	.endfunc
.Lfunc_end38:
	.size	_ZNKSt3__121__basic_string_commonILb1EE20__throw_length_errorEv, .Lfunc_end38-_ZNKSt3__121__basic_string_commonILb1EE20__throw_length_errorEv

	.section	.text._ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE7reserveEj,"axG",@progbits,_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE7reserveEj,comdat
	.hidden	_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE7reserveEj
	.weak	_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE7reserveEj
	.type	_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE7reserveEj,@function
_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE7reserveEj:
	.param  	i32, i32
	.local  	i32, i32, i32, i32, i32, i32
	block   	
	i32.const	$push0=, -16
	i32.ge_u	$push1=, $1, $pop0
	br_if   	0, $pop1
	i32.const	$2=, 10
	block   	
	i32.load8_u	$push35=, 0($0)
	tee_local	$push34=, $5=, $pop35
	i32.const	$push33=, 1
	i32.and 	$push2=, $pop34, $pop33
	i32.eqz 	$push52=, $pop2
	br_if   	0, $pop52
	i32.load	$push37=, 0($0)
	tee_local	$push36=, $5=, $pop37
	i32.const	$push3=, -2
	i32.and 	$push4=, $pop36, $pop3
	i32.const	$push5=, -1
	i32.add 	$2=, $pop4, $pop5
.LBB39_3:
	end_block
	block   	
	block   	
	i32.const	$push38=, 1
	i32.and 	$push6=, $5, $pop38
	br_if   	0, $pop6
	i32.const	$push7=, 254
	i32.and 	$push8=, $5, $pop7
	i32.const	$push9=, 1
	i32.shr_u	$3=, $pop8, $pop9
	br      	1
.LBB39_5:
	end_block
	i32.load	$3=, 4($0)
.LBB39_6:
	end_block
	i32.const	$4=, 10
	block   	
	i32.gt_u	$push10=, $3, $1
	i32.select	$push40=, $3, $1, $pop10
	tee_local	$push39=, $1=, $pop40
	i32.const	$push11=, 11
	i32.lt_u	$push12=, $pop39, $pop11
	br_if   	0, $pop12
	i32.const	$push13=, 16
	i32.add 	$push14=, $1, $pop13
	i32.const	$push15=, -16
	i32.and 	$push16=, $pop14, $pop15
	i32.const	$push17=, -1
	i32.add 	$4=, $pop16, $pop17
.LBB39_8:
	end_block
	block   	
	i32.eq  	$push18=, $4, $2
	br_if   	0, $pop18
	block   	
	block   	
	i32.const	$push19=, 10
	i32.ne  	$push20=, $4, $pop19
	br_if   	0, $pop20
	i32.const	$6=, 1
	i32.const	$push41=, 1
	i32.add 	$1=, $0, $pop41
	i32.load	$2=, 8($0)
	i32.const	$7=, 0
	br      	1
.LBB39_11:
	end_block
	i32.const	$push42=, 1
	i32.add 	$push22=, $4, $pop42
	i32.call	$1=, _Znwj@FUNCTION, $pop22
	block   	
	i32.gt_u	$push21=, $4, $2
	br_if   	0, $pop21
	i32.eqz 	$push53=, $1
	br_if   	2, $pop53
.LBB39_13:
	end_block
	block   	
	i32.load8_u	$push45=, 0($0)
	tee_local	$push44=, $5=, $pop45
	i32.const	$push43=, 1
	i32.and 	$push23=, $pop44, $pop43
	br_if   	0, $pop23
	i32.const	$7=, 1
	i32.const	$push46=, 1
	i32.add 	$2=, $0, $pop46
	i32.const	$6=, 0
	br      	1
.LBB39_15:
	end_block
	i32.load	$2=, 8($0)
	i32.const	$6=, 1
	i32.const	$7=, 1
.LBB39_16:
	end_block
	block   	
	block   	
	i32.const	$push47=, 1
	i32.and 	$push24=, $5, $pop47
	br_if   	0, $pop24
	i32.const	$push25=, 254
	i32.and 	$push26=, $5, $pop25
	i32.const	$push48=, 1
	i32.shr_u	$5=, $pop26, $pop48
	br      	1
.LBB39_18:
	end_block
	i32.load	$5=, 4($0)
.LBB39_19:
	end_block
	block   	
	i32.const	$push27=, 1
	i32.add 	$push50=, $5, $pop27
	tee_local	$push49=, $5=, $pop50
	i32.eqz 	$push54=, $pop49
	br_if   	0, $pop54
	i32.call	$drop=, memcpy@FUNCTION, $1, $2, $5
.LBB39_21:
	end_block
	block   	
	i32.eqz 	$push55=, $6
	br_if   	0, $pop55
	call    	_ZdlPv@FUNCTION, $2
.LBB39_23:
	end_block
	block   	
	i32.eqz 	$push56=, $7
	br_if   	0, $pop56
	i32.store	4($0), $3
	i32.store	8($0), $1
	i32.const	$push30=, 1
	i32.add 	$push31=, $4, $pop30
	i32.const	$push51=, 1
	i32.or  	$push32=, $pop31, $pop51
	i32.store	0($0), $pop32
	return
.LBB39_25:
	end_block
	i32.const	$push28=, 1
	i32.shl 	$push29=, $3, $pop28
	i32.store8	0($0), $pop29
.LBB39_26:
	end_block
	return
.LBB39_27:
	end_block
	call    	abort@FUNCTION
	unreachable
	.endfunc
.Lfunc_end39:
	.size	_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE7reserveEj, .Lfunc_end39-_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE7reserveEj

	.section	.text._ZNKSt3__120__vector_base_commonILb1EE20__throw_length_errorEv,"axG",@progbits,_ZNKSt3__120__vector_base_commonILb1EE20__throw_length_errorEv,comdat
	.hidden	_ZNKSt3__120__vector_base_commonILb1EE20__throw_length_errorEv
	.weak	_ZNKSt3__120__vector_base_commonILb1EE20__throw_length_errorEv
	.type	_ZNKSt3__120__vector_base_commonILb1EE20__throw_length_errorEv,@function
_ZNKSt3__120__vector_base_commonILb1EE20__throw_length_errorEv:
	.param  	i32
	call    	abort@FUNCTION
	unreachable
	.endfunc
.Lfunc_end40:
	.size	_ZNKSt3__120__vector_base_commonILb1EE20__throw_length_errorEv, .Lfunc_end40-_ZNKSt3__120__vector_base_commonILb1EE20__throw_length_errorEv

	.section	.text._ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC2ERKS5_,"axG",@progbits,_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC5ERKS5_,comdat
	.hidden	_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC2ERKS5_
	.weak	_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC2ERKS5_
	.type	_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC2ERKS5_,@function
_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC2ERKS5_:
	.param  	i32, i32
	.result 	i32
	.local  	i32, i32, i32
	i64.const	$push0=, 0
	i64.store	0($0):p2align=2, $pop0
	i32.const	$push23=, 8
	i32.add 	$push22=, $0, $pop23
	tee_local	$push21=, $3=, $pop22
	i32.const	$push1=, 0
	i32.store	0($pop21), $pop1
	block   	
	i32.load8_u	$push2=, 0($1)
	i32.const	$push3=, 1
	i32.and 	$push4=, $pop2, $pop3
	br_if   	0, $pop4
	i64.load	$push18=, 0($1):p2align=2
	i64.store	0($0):p2align=2, $pop18
	i32.const	$push24=, 8
	i32.add 	$push19=, $1, $pop24
	i32.load	$push20=, 0($pop19)
	i32.store	0($3), $pop20
	return  	$0
.LBB41_2:
	end_block
	block   	
	i32.load	$push26=, 4($1)
	tee_local	$push25=, $3=, $pop26
	i32.const	$push5=, -16
	i32.ge_u	$push6=, $pop25, $pop5
	br_if   	0, $pop6
	i32.load	$2=, 8($1)
	block   	
	block   	
	block   	
	i32.const	$push7=, 11
	i32.ge_u	$push8=, $3, $pop7
	br_if   	0, $pop8
	i32.const	$push14=, 1
	i32.shl 	$push15=, $3, $pop14
	i32.store8	0($0), $pop15
	i32.const	$push27=, 1
	i32.add 	$1=, $0, $pop27
	br_if   	1, $3
	br      	2
.LBB41_5:
	end_block
	i32.const	$push9=, 16
	i32.add 	$push10=, $3, $pop9
	i32.const	$push11=, -16
	i32.and 	$push29=, $pop10, $pop11
	tee_local	$push28=, $4=, $pop29
	i32.call	$1=, _Znwj@FUNCTION, $pop28
	i32.const	$push12=, 1
	i32.or  	$push13=, $4, $pop12
	i32.store	0($0), $pop13
	i32.store	8($0), $1
	i32.store	4($0), $3
.LBB41_6:
	end_block
	i32.call	$drop=, memcpy@FUNCTION, $1, $2, $3
.LBB41_7:
	end_block
	i32.add 	$push16=, $1, $3
	i32.const	$push17=, 0
	i32.store8	0($pop16), $pop17
	return  	$0
.LBB41_8:
	end_block
	call    	abort@FUNCTION
	unreachable
	.endfunc
.Lfunc_end41:
	.size	_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC2ERKS5_, .Lfunc_end41-_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC2ERKS5_

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
.LBB42_2:
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
.LBB42_4:
	end_loop
	end_block
	i32.sub 	$5=, $3, $4
.LBB42_5:
	end_block
	copy_local	$push11=, $5
	.endfunc
.Lfunc_end42:
	.size	memcmp, .Lfunc_end42-memcmp

	.hidden	malloc
	.globl	malloc
	.type	malloc,@function
malloc:
	.param  	i32
	.result 	i32
	i32.const	$push0=, _ZN5eosio11memory_heapE
	i32.call	$push1=, _ZN5eosio14memory_manager6mallocEm@FUNCTION, $pop0, $0
	.endfunc
.Lfunc_end43:
	.size	malloc, .Lfunc_end43-malloc

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
.LBB44_3:
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
.LBB44_7:
	end_block
	i32.const	$push72=, 4
	i32.add 	$10=, $2, $pop72
.LBB44_8:
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
.LBB44_10:
	end_block
	i32.call	$push86=, _ZN5eosio14memory_manager16next_active_heapEv@FUNCTION, $0
	tee_local	$push85=, $1=, $pop86
	br_if   	0, $pop85
.LBB44_11:
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
.LBB44_12:
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
	i32.const	$push93=, .L.str.1.17
	call    	eosio_assert@FUNCTION, $pop31, $pop93
	i32.const	$push92=, 8196
	i32.add 	$push32=, $1, $pop92
	i32.load	$push91=, 0($pop32)
	tee_local	$push90=, $6=, $pop91
	i32.const	$push89=, 4
	i32.add 	$13=, $pop90, $pop89
.LBB44_13:
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
.LBB44_15:
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
.LBB44_18:
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
.LBB44_20:
	end_block
	i32.ge_u	$push49=, $1, $2
	br_if   	4, $pop49
.LBB44_21:
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
.LBB44_23:
	end_loop
	end_block
	return  	$1
.LBB44_24:
	end_block
	i32.load	$push50=, 0($8)
	i32.const	$push51=, -2147483648
	i32.or  	$push52=, $pop50, $pop51
	i32.store	0($8), $pop52
	return  	$13
.LBB44_25:
	end_block
	i32.const	$push61=, 0
	.endfunc
.Lfunc_end44:
	.size	_ZN5eosio14memory_manager6mallocEm, .Lfunc_end44-_ZN5eosio14memory_manager6mallocEm

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
.LBB45_2:
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
.LBB45_3:
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
.LBB45_6:
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
.LBB45_9:
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
.LBB45_13:
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
.LBB45_17:
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
.LBB45_18:
	end_block
	return  	$8
.LBB45_19:
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
.LBB45_21:
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
.LBB45_22:
	end_block
	i32.add 	$push71=, $8, $7
	i32.store	0($2), $pop71
	copy_local	$push158=, $2
	.endfunc
.Lfunc_end45:
	.size	_ZN5eosio14memory_manager16next_active_heapEv, .Lfunc_end45-_ZN5eosio14memory_manager16next_active_heapEv

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
.LBB46_3:
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
.LBB46_6:
	end_block
	i32.const	$push25=, 12
	i32.add 	$push24=, $3, $pop25
	tee_local	$push23=, $3=, $pop24
	i32.lt_u	$push14=, $pop23, $1
	br_if   	0, $pop14
.LBB46_7:
	end_loop
	end_block
	return
.LBB46_8:
	end_block
	i32.const	$push10=, -4
	i32.add 	$push27=, $0, $pop10
	tee_local	$push26=, $3=, $pop27
	i32.load	$push11=, 0($3)
	i32.const	$push12=, 2147483647
	i32.and 	$push13=, $pop11, $pop12
	i32.store	0($pop26), $pop13
	.endfunc
.Lfunc_end46:
	.size	free, .Lfunc_end46-free

	.type	.L.str,@object
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"invalid symbol name"
	.size	.L.str, 20

	.type	.L.str.1,@object
.L.str.1:
	.asciz	"invalid supply"
	.size	.L.str.1, 15

	.type	.L.str.2,@object
.L.str.2:
	.asciz	"max-supply must be positive"
	.size	.L.str.2, 28

	.type	.L.str.20,@object
.L.str.20:
	.asciz	"object passed to iterator_to is not in multi_index"
	.size	.L.str.20, 51

	.type	.L.str.3,@object
.L.str.3:
	.asciz	"token with symbol already exists"
	.size	.L.str.3, 33

	.type	.L.str.26,@object
.L.str.26:
	.asciz	"cannot create objects in table of another contract"
	.size	.L.str.26, 51

	.type	.L.str.27,@object
.L.str.27:
	.asciz	"write"
	.size	.L.str.27, 6

	.type	.L.str.23,@object
.L.str.23:
	.asciz	"magnitude of asset amount must be less than 2^62"
	.size	.L.str.23, 49

	.type	.L.str.21,@object
.L.str.21:
	.asciz	"error reading iterator"
	.size	.L.str.21, 23

	.type	.L.str.24,@object
.L.str.24:
	.asciz	"read"
	.size	.L.str.24, 5

	.type	.L.str.4,@object
.L.str.4:
	.asciz	"memo has more than 256 bytes"
	.size	.L.str.4, 29

	.type	.L.str.5,@object
.L.str.5:
	.asciz	"token with symbol does not exist, create token before issue"
	.size	.L.str.5, 60

	.type	.L.str.6,@object
.L.str.6:
	.asciz	"invalid quantity"
	.size	.L.str.6, 17

	.type	.L.str.7,@object
.L.str.7:
	.asciz	"must issue positive quantity"
	.size	.L.str.7, 29

	.type	.L.str.8,@object
.L.str.8:
	.asciz	"symbol precision mismatch"
	.size	.L.str.8, 26

	.type	.L.str.9,@object
.L.str.9:
	.asciz	"quantity exceeds available supply"
	.size	.L.str.9, 34

	.type	.L.str.28,@object
.L.str.28:
	.asciz	"object passed to modify is not in multi_index"
	.size	.L.str.28, 46

	.type	.L.str.29,@object
.L.str.29:
	.asciz	"cannot modify objects in table of another contract"
	.size	.L.str.29, 51

	.type	.L.str.31,@object
.L.str.31:
	.asciz	"attempt to add asset with different symbol"
	.size	.L.str.31, 43

	.type	.L.str.32,@object
.L.str.32:
	.asciz	"addition underflow"
	.size	.L.str.32, 19

	.type	.L.str.33,@object
.L.str.33:
	.asciz	"addition overflow"
	.size	.L.str.33, 18

	.type	.L.str.30,@object
.L.str.30:
	.asciz	"updater cannot change primary key when modifying an object"
	.size	.L.str.30, 59

	.type	.L.str.10,@object
.L.str.10:
	.asciz	"active"
	.size	.L.str.10, 7

	.type	.L.str.40,@object
.L.str.40:
	.asciz	"cannot pass end iterator to modify"
	.size	.L.str.40, 35

	.type	.L.str.11,@object
.L.str.11:
	.asciz	"cannot transfer to self"
	.size	.L.str.11, 24

	.type	.L.str.12,@object
.L.str.12:
	.asciz	"to account does not exist"
	.size	.L.str.12, 26

	.type	.L.str.13,@object
.L.str.13:
	.asciz	"unable to find key"
	.size	.L.str.13, 19

	.type	.L.str.14,@object
.L.str.14:
	.asciz	"must transfer positive quantity"
	.size	.L.str.14, 32

	.type	.L.str.15,@object
.L.str.15:
	.asciz	"no balance object found"
	.size	.L.str.15, 24

	.type	.L.str.16,@object
.L.str.16:
	.asciz	"overdrawn balance"
	.size	.L.str.16, 18

	.type	.L.str.37,@object
.L.str.37:
	.asciz	"attempt to subtract asset with different symbol"
	.size	.L.str.37, 48

	.type	.L.str.38,@object
.L.str.38:
	.asciz	"subtraction underflow"
	.size	.L.str.38, 22

	.type	.L.str.39,@object
.L.str.39:
	.asciz	"subtraction overflow"
	.size	.L.str.39, 21

	.type	.L.str.34,@object
.L.str.34:
	.asciz	"object passed to erase is not in multi_index"
	.size	.L.str.34, 45

	.type	.L.str.35,@object
.L.str.35:
	.asciz	"cannot erase objects in table of another contract"
	.size	.L.str.35, 50

	.type	.L.str.36,@object
.L.str.36:
	.asciz	"attempt to remove object that was not in multi_index"
	.size	.L.str.36, 53

	.type	.L.str.17,@object
.L.str.17:
	.asciz	"onerror"
	.size	.L.str.17, 8

	.type	.L.str.18,@object
.L.str.18:
	.asciz	"eosio"
	.size	.L.str.18, 6

	.type	.L.str.19,@object
.L.str.19:
	.asciz	"onerror action's are only valid from the \"eosio\" system account"
	.size	.L.str.19, 64

	.type	.L.str.41,@object
.L.str.41:
	.asciz	"get"
	.size	.L.str.41, 4

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

	.type	.L.str.1.17,@object
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.1.17:
	.asciz	"malloc_from_freed was designed to only be called after _heap was completely allocated"
	.size	.L.str.1.17, 86

	.type	_ZZ4sbrkjE11initialized,@object
	.lcomm	_ZZ4sbrkjE11initialized,1
	.type	_ZZ4sbrkjE10sbrk_bytes,@object
	.lcomm	_ZZ4sbrkjE10sbrk_bytes,4,2

	.weak	_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC1ERKS5_
	.type	_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC1ERKS5_,@function
	.hidden	_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC1ERKS5_
_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC1ERKS5_ = _ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC2ERKS5_@FUNCTION
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
	.ident	"clang version 4.0.1 (https://github.com/llvm-mirror/clang.git 3c8961bedc65c9a15cbe67a2ef385a0938f7cfef) (https://github.com/llvm-mirror/llvm.git c8fccc53ed66d505898f8850bcc690c977a7c9a7)"
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
	.functype	require_auth, void, i64
	.functype	eosio_assert, void, i32, i32
	.functype	db_find_i64, i32, i64, i64, i64, i64
	.functype	current_receiver, i64
	.functype	db_store_i64, i32, i64, i64, i64, i64, i32, i32
	.functype	memcpy, i32, i32, i32, i32
	.functype	db_get_i64, i32, i32, i32, i32
	.functype	db_update_i64, void, i32, i64, i32, i32
	.functype	send_inline, void, i32, i32
	.functype	is_account, i32, i64
	.functype	require_recipient, void, i64
	.functype	db_remove_i64, void, i32
	.functype	action_data_size, i32
	.functype	read_action_data, i32, i32, i32
	.functype	abort, void
