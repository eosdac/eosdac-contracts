(module
 (type $FUNCSIG$viiii (func (param i32 i32 i32 i32)))
 (type $FUNCSIG$vij (func (param i32 i64)))
 (type $FUNCSIG$viji (func (param i32 i64 i32)))
 (type $FUNCSIG$vijj (func (param i32 i64 i64)))
 (type $FUNCSIG$vii (func (param i32 i32)))
 (type $FUNCSIG$vijii (func (param i32 i64 i32 i32)))
 (type $FUNCSIG$v (func))
 (type $FUNCSIG$j (func (result i64)))
 (type $FUNCSIG$vjj (func (param i64 i64)))
 (type $FUNCSIG$vj (func (param i64)))
 (type $FUNCSIG$ijjjj (func (param i64 i64 i64 i64) (result i32)))
 (type $FUNCSIG$iii (func (param i32 i32) (result i32)))
 (type $FUNCSIG$vi (func (param i32)))
 (type $FUNCSIG$iiii (func (param i32 i32 i32) (result i32)))
 (type $FUNCSIG$i (func (result i32)))
 (type $FUNCSIG$ijjjij (func (param i64 i64 i64 i32 i64) (result i32)))
 (type $FUNCSIG$ijjj (func (param i64 i64 i64) (result i32)))
 (type $FUNCSIG$ijjjjii (func (param i64 i64 i64 i64 i32 i32) (result i32)))
 (type $FUNCSIG$ijjjii (func (param i64 i64 i64 i32 i32) (result i32)))
 (type $FUNCSIG$ijjjji (func (param i64 i64 i64 i64 i32) (result i32)))
 (import "env" "abort" (func $abort))
 (import "env" "action_data_size" (func $action_data_size (result i32)))
 (import "env" "current_receiver" (func $current_receiver (result i64)))
 (import "env" "current_time" (func $current_time (result i64)))
 (import "env" "db_end_i64" (func $db_end_i64 (param i64 i64 i64) (result i32)))
 (import "env" "db_find_i64" (func $db_find_i64 (param i64 i64 i64 i64) (result i32)))
 (import "env" "db_get_i64" (func $db_get_i64 (param i32 i32 i32) (result i32)))
 (import "env" "db_idx128_end" (func $db_idx128_end (param i64 i64 i64) (result i32)))
 (import "env" "db_idx128_find_primary" (func $db_idx128_find_primary (param i64 i64 i64 i32 i64) (result i32)))
 (import "env" "db_idx128_lowerbound" (func $db_idx128_lowerbound (param i64 i64 i64 i32 i32) (result i32)))
 (import "env" "db_idx128_previous" (func $db_idx128_previous (param i32 i32) (result i32)))
 (import "env" "db_idx128_remove" (func $db_idx128_remove (param i32)))
 (import "env" "db_idx128_store" (func $db_idx128_store (param i64 i64 i64 i64 i32) (result i32)))
 (import "env" "db_idx128_update" (func $db_idx128_update (param i32 i64 i32)))
 (import "env" "db_idx64_end" (func $db_idx64_end (param i64 i64 i64) (result i32)))
 (import "env" "db_idx64_find_primary" (func $db_idx64_find_primary (param i64 i64 i64 i32 i64) (result i32)))
 (import "env" "db_idx64_lowerbound" (func $db_idx64_lowerbound (param i64 i64 i64 i32 i32) (result i32)))
 (import "env" "db_idx64_previous" (func $db_idx64_previous (param i32 i32) (result i32)))
 (import "env" "db_idx64_remove" (func $db_idx64_remove (param i32)))
 (import "env" "db_idx64_store" (func $db_idx64_store (param i64 i64 i64 i64 i32) (result i32)))
 (import "env" "db_idx64_update" (func $db_idx64_update (param i32 i64 i32)))
 (import "env" "db_lowerbound_i64" (func $db_lowerbound_i64 (param i64 i64 i64 i64) (result i32)))
 (import "env" "db_next_i64" (func $db_next_i64 (param i32 i32) (result i32)))
 (import "env" "db_previous_i64" (func $db_previous_i64 (param i32 i32) (result i32)))
 (import "env" "db_remove_i64" (func $db_remove_i64 (param i32)))
 (import "env" "db_store_i64" (func $db_store_i64 (param i64 i64 i64 i64 i32 i32) (result i32)))
 (import "env" "db_update_i64" (func $db_update_i64 (param i32 i64 i32 i32)))
 (import "env" "eosio_assert" (func $eosio_assert (param i32 i32)))
 (import "env" "memcpy" (func $memcpy (param i32 i32 i32) (result i32)))
 (import "env" "memmove" (func $memmove (param i32 i32 i32) (result i32)))
 (import "env" "memset" (func $memset (param i32 i32 i32) (result i32)))
 (import "env" "read_action_data" (func $read_action_data (param i32 i32) (result i32)))
 (import "env" "require_auth" (func $require_auth (param i64)))
 (import "env" "require_auth2" (func $require_auth2 (param i64 i64)))
 (import "env" "send_inline" (func $send_inline (param i32 i32)))
 (table 10 10 anyfunc)
 (elem (i32.const 0) $__wasm_nullptr $_ZN12daccustodian9voteproxyEN5eosio4nameES1_ $_ZN12daccustodian10paypendingENSt3__112basic_stringIcNS0_11char_traitsIcEENS0_9allocatorIcEEEE $_ZN12daccustodian12updateconfigEN5eosio5assetEhm $_ZN12daccustodian9unregcandEN5eosio4nameE $_ZN12daccustodian12updatereqpayEN5eosio4nameENS0_5assetE $_ZN12daccustodian8votecustEN5eosio4nameENSt3__16vectorIS1_NS2_9allocatorIS1_EEEE $_ZN12daccustodian9newperiodENSt3__112basic_stringIcNS0_11char_traitsIcEENS0_9allocatorIcEEEE $_ZN12daccustodian9updatebioEN5eosio4nameENSt3__112basic_stringIcNS2_11char_traitsIcEENS2_9allocatorIcEEEE $_ZN12daccustodian12regcandidateEN5eosio4nameENSt3__112basic_stringIcNS2_11char_traitsIcEENS2_9allocatorIcEEEENS0_5assetE)
 (memory $0 1)
 (data (i32.const 4) "\c0h\00\00")
 (data (i32.const 16) "onerror\00")
 (data (i32.const 32) "eosio\00")
 (data (i32.const 48) "onerror action\'s are only valid from the \"eosio\" system account\00")
 (data (i32.const 112) "active\00")
 (data (i32.const 128) "eosio.token\00")
 (data (i32.const 144) "transfer\00")
 (data (i32.const 160) "eosdactoken\00")
 (data (i32.const 176) "cannot pass end iterator to erase\00")
 (data (i32.const 224) "cannot increment end iterator\00")
 (data (i32.const 256) "object passed to erase is not in multi_index\00")
 (data (i32.const 304) "cannot erase objects in table of another contract\00")
 (data (i32.const 368) "attempt to remove object that was not in multi_index\00")
 (data (i32.const 432) "write\00")
 (data (i32.const 448) "error reading iterator\00")
 (data (i32.const 480) "magnitude of asset amount must be less than 2^62\00")
 (data (i32.const 544) "invalid symbol name\00")
 (data (i32.const 576) "read\00")
 (data (i32.const 592) "get\00")
 (data (i32.const 608) "object passed to modify is not in multi_index\00")
 (data (i32.const 656) "cannot modify objects in table of another contract\00")
 (data (i32.const 720) "updater cannot change primary key when modifying an object\00")
 (data (i32.const 784) "cannot decrement end iterator when the index is empty\00")
 (data (i32.const 848) "cannot decrement iterator at beginning of index\00")
 (data (i32.const 896) "object passed to iterator_to is not in multi_index\00")
 (data (i32.const 960) "cannot pass end iterator to modify\00")
 (data (i32.const 1008) "cannot create objects in table of another contract\00")
 (data (i32.const 1072) "EOSDAC Custodian pay. Thank you.\00")
 (data (i32.const 1120) "attempt to add asset with different symbol\00")
 (data (i32.const 1168) "addition underflow\00")
 (data (i32.const 1200) "addition overflow\00")
 (data (i32.const 1232) "Account is not registered with members\00")
 (data (i32.const 1280) "Account has not agreed to any terms\00")
 (data (i32.const 1328) "Agreed terms isn\'t the latest.\00")
 (data (i32.const 1360) "Member cannot proxy vote for themselves: \00")
 (data (i32.const 1408) "Proxy voters cannot vote for another proxy: \00")
 (data (i32.const 1456) "\c0\05\00\00")
 (data (i32.const 1472) ".12345abcdefghijklmnopqrstuvwxyz\00")
 (data (i32.const 1520) "cannot decrement end iterator when the table is empty\00")
 (data (i32.const 1584) "cannot decrement iterator at beginning of table\00")
 (data (i32.const 1648) "Max number of allowed votes was exceeded.\00")
 (data (i32.const 1696) "Candidate is not already registered.\00")
 (data (i32.const 1744) "Returning locked up stake. Thank you.\00")
 (data (i32.const 1792) "Candidate is already registered.\00")
 (data (i32.const 1840) "Candidate lockup amount\00")
 (data (i32.const 1872) "The provided asset does not match the current lockup asset symbol.\00")
 (data (i32.const 10336) "malloc_from_freed was designed to only be called after _heap was completely allocated\00")
 (export "memory" (memory $0))
 (export "_ZeqRK11checksum256S1_" (func $_ZeqRK11checksum256S1_))
 (export "_ZeqRK11checksum160S1_" (func $_ZeqRK11checksum160S1_))
 (export "_ZneRK11checksum160S1_" (func $_ZneRK11checksum160S1_))
 (export "now" (func $now))
 (export "_ZN5eosio12require_authERKNS_16permission_levelE" (func $_ZN5eosio12require_authERKNS_16permission_levelE))
 (export "_Z11combine_idsRKhRKy" (func $_Z11combine_idsRKhRKy))
 (export "apply" (func $apply))
 (export "malloc" (func $malloc))
 (export "free" (func $free))
 (export "memcmp" (func $memcmp))
 (export "strlen" (func $strlen))
 (func $_ZeqRK11checksum256S1_ (param $0 i32) (param $1 i32) (result i32)
  (i32.eqz
   (call $memcmp
    (get_local $0)
    (get_local $1)
    (i32.const 32)
   )
  )
 )
 (func $_ZeqRK11checksum160S1_ (param $0 i32) (param $1 i32) (result i32)
  (i32.eqz
   (call $memcmp
    (get_local $0)
    (get_local $1)
    (i32.const 32)
   )
  )
 )
 (func $_ZneRK11checksum160S1_ (param $0 i32) (param $1 i32) (result i32)
  (i32.ne
   (call $memcmp
    (get_local $0)
    (get_local $1)
    (i32.const 32)
   )
   (i32.const 0)
  )
 )
 (func $now (result i32)
  (i32.wrap/i64
   (i64.div_u
    (call $current_time)
    (i64.const 1000000)
   )
  )
 )
 (func $_ZN5eosio12require_authERKNS_16permission_levelE (param $0 i32)
  (call $require_auth2
   (i64.load
    (get_local $0)
   )
   (i64.load offset=8
    (get_local $0)
   )
  )
 )
 (func $_Z11combine_idsRKhRKy (param $0 i32) (param $1 i32) (param $2 i32)
  (i64.store
   (i32.add
    (get_local $0)
    (i32.const 8)
   )
   (i64.const 0)
  )
  (i64.store
   (get_local $0)
   (i64.or
    (i64.shl
     (i64.load8_u
      (get_local $1)
     )
     (i64.const 8)
    )
    (i64.load
     (get_local $2)
    )
   )
  )
 )
 (func $apply (param $0 i64) (param $1 i64) (param $2 i64)
  (local $3 i32)
  (local $4 i32)
  (local $5 i64)
  (local $6 i64)
  (local $7 i64)
  (local $8 i64)
  (local $9 i32)
  (i32.store offset=4
   (i32.const 0)
   (tee_local $9
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 416)
    )
   )
  )
  (set_local $6
   (i64.const 0)
  )
  (set_local $5
   (i64.const 59)
  )
  (set_local $4
   (i32.const 16)
  )
  (set_local $7
   (i64.const 0)
  )
  (loop $label$0
   (block $label$1
    (block $label$2
     (block $label$3
      (block $label$4
       (block $label$5
        (br_if $label$5
         (i64.gt_u
          (get_local $6)
          (i64.const 6)
         )
        )
        (br_if $label$4
         (i32.gt_u
          (i32.and
           (i32.add
            (tee_local $3
             (i32.load8_s
              (get_local $4)
             )
            )
            (i32.const -97)
           )
           (i32.const 255)
          )
          (i32.const 25)
         )
        )
        (set_local $3
         (i32.add
          (get_local $3)
          (i32.const 165)
         )
        )
        (br $label$3)
       )
       (set_local $8
        (i64.const 0)
       )
       (br_if $label$2
        (i64.le_u
         (get_local $6)
         (i64.const 11)
        )
       )
       (br $label$1)
      )
      (set_local $3
       (select
        (i32.add
         (get_local $3)
         (i32.const 208)
        )
        (i32.const 0)
        (i32.lt_u
         (i32.and
          (i32.add
           (get_local $3)
           (i32.const -49)
          )
          (i32.const 255)
         )
         (i32.const 5)
        )
       )
      )
     )
     (set_local $8
      (i64.shr_s
       (i64.shl
        (i64.extend_u/i32
         (get_local $3)
        )
        (i64.const 56)
       )
       (i64.const 56)
      )
     )
    )
    (set_local $8
     (i64.shl
      (i64.and
       (get_local $8)
       (i64.const 31)
      )
      (i64.and
       (get_local $5)
       (i64.const 4294967295)
      )
     )
    )
   )
   (set_local $4
    (i32.add
     (get_local $4)
     (i32.const 1)
    )
   )
   (set_local $6
    (i64.add
     (get_local $6)
     (i64.const 1)
    )
   )
   (set_local $7
    (i64.or
     (get_local $8)
     (get_local $7)
    )
   )
   (br_if $label$0
    (i64.ne
     (tee_local $5
      (i64.add
       (get_local $5)
       (i64.const -5)
      )
     )
     (i64.const -6)
    )
   )
  )
  (block $label$6
   (br_if $label$6
    (i64.ne
     (get_local $7)
     (get_local $2)
    )
   )
   (set_local $6
    (i64.const 0)
   )
   (set_local $5
    (i64.const 59)
   )
   (set_local $4
    (i32.const 32)
   )
   (set_local $7
    (i64.const 0)
   )
   (loop $label$7
    (block $label$8
     (block $label$9
      (block $label$10
       (block $label$11
        (block $label$12
         (br_if $label$12
          (i64.gt_u
           (get_local $6)
           (i64.const 4)
          )
         )
         (br_if $label$11
          (i32.gt_u
           (i32.and
            (i32.add
             (tee_local $3
              (i32.load8_s
               (get_local $4)
              )
             )
             (i32.const -97)
            )
            (i32.const 255)
           )
           (i32.const 25)
          )
         )
         (set_local $3
          (i32.add
           (get_local $3)
           (i32.const 165)
          )
         )
         (br $label$10)
        )
        (set_local $8
         (i64.const 0)
        )
        (br_if $label$9
         (i64.le_u
          (get_local $6)
          (i64.const 11)
         )
        )
        (br $label$8)
       )
       (set_local $3
        (select
         (i32.add
          (get_local $3)
          (i32.const 208)
         )
         (i32.const 0)
         (i32.lt_u
          (i32.and
           (i32.add
            (get_local $3)
            (i32.const -49)
           )
           (i32.const 255)
          )
          (i32.const 5)
         )
        )
       )
      )
      (set_local $8
       (i64.shr_s
        (i64.shl
         (i64.extend_u/i32
          (get_local $3)
         )
         (i64.const 56)
        )
        (i64.const 56)
       )
      )
     )
     (set_local $8
      (i64.shl
       (i64.and
        (get_local $8)
        (i64.const 31)
       )
       (i64.and
        (get_local $5)
        (i64.const 4294967295)
       )
      )
     )
    )
    (set_local $4
     (i32.add
      (get_local $4)
      (i32.const 1)
     )
    )
    (set_local $6
     (i64.add
      (get_local $6)
      (i64.const 1)
     )
    )
    (set_local $7
     (i64.or
      (get_local $8)
      (get_local $7)
     )
    )
    (br_if $label$7
     (i64.ne
      (tee_local $5
       (i64.add
        (get_local $5)
        (i64.const -5)
       )
      )
      (i64.const -6)
     )
    )
   )
   (call $eosio_assert
    (i64.eq
     (get_local $7)
     (get_local $1)
    )
    (i32.const 48)
   )
  )
  (block $label$13
   (block $label$14
    (br_if $label$14
     (i64.eq
      (get_local $1)
      (get_local $0)
     )
    )
    (set_local $6
     (i64.const 0)
    )
    (set_local $5
     (i64.const 59)
    )
    (set_local $4
     (i32.const 16)
    )
    (set_local $7
     (i64.const 0)
    )
    (loop $label$15
     (block $label$16
      (block $label$17
       (block $label$18
        (block $label$19
         (block $label$20
          (br_if $label$20
           (i64.gt_u
            (get_local $6)
            (i64.const 6)
           )
          )
          (br_if $label$19
           (i32.gt_u
            (i32.and
             (i32.add
              (tee_local $3
               (i32.load8_s
                (get_local $4)
               )
              )
              (i32.const -97)
             )
             (i32.const 255)
            )
            (i32.const 25)
           )
          )
          (set_local $3
           (i32.add
            (get_local $3)
            (i32.const 165)
           )
          )
          (br $label$18)
         )
         (set_local $8
          (i64.const 0)
         )
         (br_if $label$17
          (i64.le_u
           (get_local $6)
           (i64.const 11)
          )
         )
         (br $label$16)
        )
        (set_local $3
         (select
          (i32.add
           (get_local $3)
           (i32.const 208)
          )
          (i32.const 0)
          (i32.lt_u
           (i32.and
            (i32.add
             (get_local $3)
             (i32.const -49)
            )
            (i32.const 255)
           )
           (i32.const 5)
          )
         )
        )
       )
       (set_local $8
        (i64.shr_s
         (i64.shl
          (i64.extend_u/i32
           (get_local $3)
          )
          (i64.const 56)
         )
         (i64.const 56)
        )
       )
      )
      (set_local $8
       (i64.shl
        (i64.and
         (get_local $8)
         (i64.const 31)
        )
        (i64.and
         (get_local $5)
         (i64.const 4294967295)
        )
       )
      )
     )
     (set_local $4
      (i32.add
       (get_local $4)
       (i32.const 1)
      )
     )
     (set_local $6
      (i64.add
       (get_local $6)
       (i64.const 1)
      )
     )
     (set_local $7
      (i64.or
       (get_local $8)
       (get_local $7)
      )
     )
     (br_if $label$15
      (i64.ne
       (tee_local $5
        (i64.add
         (get_local $5)
         (i64.const -5)
        )
       )
       (i64.const -6)
      )
     )
    )
    (br_if $label$13
     (i64.ne
      (get_local $7)
      (get_local $2)
     )
    )
   )
   (set_local $4
    (call $_ZN12daccustodianC2Ey
     (i32.add
      (get_local $9)
      (i32.const 152)
     )
     (get_local $0)
    )
   )
   (block $label$21
    (block $label$22
     (block $label$23
      (block $label$24
       (block $label$25
        (block $label$26
         (block $label$27
          (block $label$28
           (block $label$29
            (br_if $label$29
             (i64.le_s
              (get_local $2)
              (i64.const -3075276122726858753)
             )
            )
            (br_if $label$28
             (i64.le_s
              (get_local $2)
              (i64.const -3075276114202636833)
             )
            )
            (br_if $label$26
             (i64.eq
              (get_local $2)
              (i64.const -3075276114202636832)
             )
            )
            (br_if $label$25
             (i64.eq
              (get_local $2)
              (i64.const -2507761262604058624)
             )
            )
            (br_if $label$21
             (i64.ne
              (get_local $2)
              (i64.const -2507754169382731776)
             )
            )
            (i32.store offset=100
             (get_local $9)
             (i32.const 0)
            )
            (i32.store offset=96
             (get_local $9)
             (i32.const 1)
            )
            (i64.store offset=56 align=4
             (get_local $9)
             (i64.load offset=96
              (get_local $9)
             )
            )
            (drop
             (call $_ZN5eosio14execute_actionI12daccustodianS1_JNS_4nameES2_EEEbPT_MT0_FvDpT1_E
              (get_local $4)
              (i32.add
               (get_local $9)
               (i32.const 56)
              )
             )
            )
            (br $label$21)
           )
           (br_if $label$27
            (i64.gt_s
             (get_local $2)
             (i64.const -5001103018682633569)
            )
           )
           (br_if $label$24
            (i64.eq
             (get_local $2)
             (i64.const -7297707859695370240)
            )
           )
           (br_if $label$21
            (i64.ne
             (get_local $2)
             (i64.const -6215718120718663680)
            )
           )
           (i32.store offset=84
            (get_local $9)
            (i32.const 0)
           )
           (i32.store offset=80
            (get_local $9)
            (i32.const 2)
           )
           (i64.store offset=72 align=4
            (get_local $9)
            (i64.load offset=80
             (get_local $9)
            )
           )
           (drop
            (call $_ZN5eosio14execute_actionI12daccustodianS1_JNSt3__112basic_stringIcNS2_11char_traitsIcEENS2_9allocatorIcEEEEEEEbPT_MT0_FvDpT1_E
             (get_local $4)
             (i32.add
              (get_local $9)
              (i32.const 72)
             )
            )
           )
           (br $label$21)
          )
          (br_if $label$23
           (i64.eq
            (get_local $2)
            (i64.const -3075276122726858752)
           )
          )
          (br_if $label$21
           (i64.ne
            (get_local $2)
            (i64.const -3075276122089661248)
           )
          )
          (i32.store offset=148
           (get_local $9)
           (i32.const 0)
          )
          (i32.store offset=144
           (get_local $9)
           (i32.const 3)
          )
          (i64.store offset=8 align=4
           (get_local $9)
           (i64.load offset=144
            (get_local $9)
           )
          )
          (drop
           (call $_ZN5eosio14execute_actionI12daccustodianS1_JNS_5assetEhmEEEbPT_MT0_FvDpT1_E
            (get_local $4)
            (i32.add
             (get_local $9)
             (i32.const 8)
            )
           )
          )
          (br $label$21)
         )
         (br_if $label$22
          (i64.eq
           (get_local $2)
           (i64.const -5001103018682633568)
          )
         )
         (br_if $label$21
          (i64.ne
           (get_local $2)
           (i64.const -3103360433297817600)
          )
         )
         (i32.store offset=132
          (get_local $9)
          (i32.const 0)
         )
         (i32.store offset=128
          (get_local $9)
          (i32.const 4)
         )
         (i64.store offset=24 align=4
          (get_local $9)
          (i64.load offset=128
           (get_local $9)
          )
         )
         (drop
          (call $_ZN5eosio14execute_actionI12daccustodianS1_JNS_4nameEEEEbPT_MT0_FvDpT1_E
           (get_local $4)
           (i32.add
            (get_local $9)
            (i32.const 24)
           )
          )
         )
         (br $label$21)
        )
        (i32.store offset=116
         (get_local $9)
         (i32.const 0)
        )
        (i32.store offset=112
         (get_local $9)
         (i32.const 5)
        )
        (i64.store offset=40 align=4
         (get_local $9)
         (i64.load offset=112
          (get_local $9)
         )
        )
        (drop
         (call $_ZN5eosio14execute_actionI12daccustodianS1_JNS_4nameENS_5assetEEEEbPT_MT0_FvDpT1_E
          (get_local $4)
          (i32.add
           (get_local $9)
           (i32.const 40)
          )
         )
        )
        (br $label$21)
       )
       (i32.store offset=108
        (get_local $9)
        (i32.const 0)
       )
       (i32.store offset=104
        (get_local $9)
        (i32.const 6)
       )
       (i64.store offset=48 align=4
        (get_local $9)
        (i64.load offset=104
         (get_local $9)
        )
       )
       (drop
        (call $_ZN5eosio14execute_actionI12daccustodianS1_JNS_4nameENSt3__16vectorIS2_NS3_9allocatorIS2_EEEEEEEbPT_MT0_FvDpT1_E
         (get_local $4)
         (i32.add
          (get_local $9)
          (i32.const 48)
         )
        )
       )
       (br $label$21)
      )
      (i32.store offset=92
       (get_local $9)
       (i32.const 0)
      )
      (i32.store offset=88
       (get_local $9)
       (i32.const 7)
      )
      (i64.store offset=64 align=4
       (get_local $9)
       (i64.load offset=88
        (get_local $9)
       )
      )
      (drop
       (call $_ZN5eosio14execute_actionI12daccustodianS1_JNSt3__112basic_stringIcNS2_11char_traitsIcEENS2_9allocatorIcEEEEEEEbPT_MT0_FvDpT1_E
        (get_local $4)
        (i32.add
         (get_local $9)
         (i32.const 64)
        )
       )
      )
      (br $label$21)
     )
     (i32.store offset=124
      (get_local $9)
      (i32.const 0)
     )
     (i32.store offset=120
      (get_local $9)
      (i32.const 8)
     )
     (i64.store offset=32 align=4
      (get_local $9)
      (i64.load offset=120
       (get_local $9)
      )
     )
     (drop
      (call $_ZN5eosio14execute_actionI12daccustodianS1_JNS_4nameENSt3__112basic_stringIcNS3_11char_traitsIcEENS3_9allocatorIcEEEEEEEbPT_MT0_FvDpT1_E
       (get_local $4)
       (i32.add
        (get_local $9)
        (i32.const 32)
       )
      )
     )
     (br $label$21)
    )
    (i32.store offset=140
     (get_local $9)
     (i32.const 0)
    )
    (i32.store offset=136
     (get_local $9)
     (i32.const 9)
    )
    (i64.store offset=16 align=4
     (get_local $9)
     (i64.load offset=136
      (get_local $9)
     )
    )
    (drop
     (call $_ZN5eosio14execute_actionI12daccustodianS1_JNS_4nameENSt3__112basic_stringIcNS3_11char_traitsIcEENS3_9allocatorIcEEEENS_5assetEEEEbPT_MT0_FvDpT1_E
      (get_local $4)
      (i32.add
       (get_local $9)
       (i32.const 16)
      )
     )
    )
   )
   (drop
    (call $_ZN12daccustodianD2Ev
     (get_local $4)
    )
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $9)
    (i32.const 416)
   )
  )
 )
 (func $_ZN12daccustodianC2Ey (param $0 i32) (param $1 i64) (result i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i64)
  (local $5 i64)
  (local $6 i64)
  (local $7 i64)
  (i64.store offset=8
   (get_local $0)
   (get_local $1)
  )
  (i64.store
   (get_local $0)
   (get_local $1)
  )
  (i64.store
   (i32.add
    (get_local $0)
    (i32.const 16)
   )
   (get_local $1)
  )
  (i64.store
   (i32.add
    (get_local $0)
    (i32.const 24)
   )
   (i64.const -1)
  )
  (set_local $5
   (i64.const 0)
  )
  (i64.store align=4
   (i32.add
    (get_local $0)
    (i32.const 32)
   )
   (i64.const 0)
  )
  (i32.store
   (i32.add
    (get_local $0)
    (i32.const 40)
   )
   (i32.const 0)
  )
  (i64.store offset=48
   (get_local $0)
   (get_local $1)
  )
  (i64.store
   (i32.add
    (get_local $0)
    (i32.const 56)
   )
   (get_local $1)
  )
  (i64.store
   (i32.add
    (get_local $0)
    (i32.const 64)
   )
   (i64.const -1)
  )
  (i32.store
   (i32.add
    (get_local $0)
    (i32.const 72)
   )
   (i32.const 0)
  )
  (i32.store
   (i32.add
    (get_local $0)
    (i32.const 76)
   )
   (i32.const 0)
  )
  (i32.store
   (i32.add
    (get_local $0)
    (i32.const 80)
   )
   (i32.const 0)
  )
  (i32.store16 align=1
   (i32.add
    (get_local $0)
    (i32.const 84)
   )
   (i32.const 0)
  )
  (i64.store offset=88
   (get_local $0)
   (get_local $1)
  )
  (i64.store
   (i32.add
    (get_local $0)
    (i32.const 96)
   )
   (get_local $1)
  )
  (i64.store
   (i32.add
    (get_local $0)
    (i32.const 104)
   )
   (i64.const -1)
  )
  (i32.store
   (i32.add
    (get_local $0)
    (i32.const 112)
   )
   (i32.const 0)
  )
  (i32.store
   (i32.add
    (get_local $0)
    (i32.const 116)
   )
   (i32.const 0)
  )
  (i32.store
   (i32.add
    (get_local $0)
    (i32.const 120)
   )
   (i32.const 0)
  )
  (i32.store8
   (i32.add
    (get_local $0)
    (i32.const 124)
   )
   (i32.const 0)
  )
  (i64.store offset=128
   (get_local $0)
   (get_local $1)
  )
  (i64.store
   (i32.add
    (get_local $0)
    (i32.const 136)
   )
   (get_local $1)
  )
  (i64.store
   (i32.add
    (get_local $0)
    (i32.const 144)
   )
   (i64.const -1)
  )
  (i32.store
   (i32.add
    (get_local $0)
    (i32.const 152)
   )
   (i32.const 0)
  )
  (i32.store
   (i32.add
    (get_local $0)
    (i32.const 156)
   )
   (i32.const 0)
  )
  (i32.store
   (i32.add
    (get_local $0)
    (i32.const 160)
   )
   (i32.const 0)
  )
  (set_local $4
   (i64.const 59)
  )
  (set_local $3
   (i32.const 160)
  )
  (set_local $6
   (i64.const 0)
  )
  (loop $label$0
   (block $label$1
    (block $label$2
     (block $label$3
      (block $label$4
       (block $label$5
        (br_if $label$5
         (i64.gt_u
          (get_local $5)
          (i64.const 10)
         )
        )
        (br_if $label$4
         (i32.gt_u
          (i32.and
           (i32.add
            (tee_local $2
             (i32.load8_s
              (get_local $3)
             )
            )
            (i32.const -97)
           )
           (i32.const 255)
          )
          (i32.const 25)
         )
        )
        (set_local $2
         (i32.add
          (get_local $2)
          (i32.const 165)
         )
        )
        (br $label$3)
       )
       (set_local $1
        (i64.const 0)
       )
       (br_if $label$2
        (i64.eq
         (get_local $5)
         (i64.const 11)
        )
       )
       (br $label$1)
      )
      (set_local $2
       (select
        (i32.add
         (get_local $2)
         (i32.const 208)
        )
        (i32.const 0)
        (i32.lt_u
         (i32.and
          (i32.add
           (get_local $2)
           (i32.const -49)
          )
          (i32.const 255)
         )
         (i32.const 5)
        )
       )
      )
     )
     (set_local $1
      (i64.shr_s
       (i64.shl
        (i64.extend_u/i32
         (get_local $2)
        )
        (i64.const 56)
       )
       (i64.const 56)
      )
     )
    )
    (set_local $1
     (i64.shl
      (i64.and
       (get_local $1)
       (i64.const 31)
      )
      (i64.and
       (get_local $4)
       (i64.const 4294967295)
      )
     )
    )
   )
   (set_local $3
    (i32.add
     (get_local $3)
     (i32.const 1)
    )
   )
   (set_local $4
    (i64.add
     (get_local $4)
     (i64.const -5)
    )
   )
   (set_local $6
    (i64.or
     (get_local $1)
     (get_local $6)
    )
   )
   (br_if $label$0
    (i64.ne
     (tee_local $5
      (i64.add
       (get_local $5)
       (i64.const 1)
      )
     )
     (i64.const 13)
    )
   )
  )
  (set_local $5
   (i64.const 0)
  )
  (set_local $4
   (i64.const 59)
  )
  (set_local $3
   (i32.const 160)
  )
  (set_local $7
   (i64.const 0)
  )
  (loop $label$6
   (block $label$7
    (block $label$8
     (block $label$9
      (block $label$10
       (block $label$11
        (br_if $label$11
         (i64.gt_u
          (get_local $5)
          (i64.const 10)
         )
        )
        (br_if $label$10
         (i32.gt_u
          (i32.and
           (i32.add
            (tee_local $2
             (i32.load8_s
              (get_local $3)
             )
            )
            (i32.const -97)
           )
           (i32.const 255)
          )
          (i32.const 25)
         )
        )
        (set_local $2
         (i32.add
          (get_local $2)
          (i32.const 165)
         )
        )
        (br $label$9)
       )
       (set_local $1
        (i64.const 0)
       )
       (br_if $label$8
        (i64.eq
         (get_local $5)
         (i64.const 11)
        )
       )
       (br $label$7)
      )
      (set_local $2
       (select
        (i32.add
         (get_local $2)
         (i32.const 208)
        )
        (i32.const 0)
        (i32.lt_u
         (i32.and
          (i32.add
           (get_local $2)
           (i32.const -49)
          )
          (i32.const 255)
         )
         (i32.const 5)
        )
       )
      )
     )
     (set_local $1
      (i64.shr_s
       (i64.shl
        (i64.extend_u/i32
         (get_local $2)
        )
        (i64.const 56)
       )
       (i64.const 56)
      )
     )
    )
    (set_local $1
     (i64.shl
      (i64.and
       (get_local $1)
       (i64.const 31)
      )
      (i64.and
       (get_local $4)
       (i64.const 4294967295)
      )
     )
    )
   )
   (set_local $3
    (i32.add
     (get_local $3)
     (i32.const 1)
    )
   )
   (set_local $4
    (i64.add
     (get_local $4)
     (i64.const -5)
    )
   )
   (set_local $7
    (i64.or
     (get_local $1)
     (get_local $7)
    )
   )
   (br_if $label$6
    (i64.ne
     (tee_local $5
      (i64.add
       (get_local $5)
       (i64.const 1)
      )
     )
     (i64.const 13)
    )
   )
  )
  (i64.store offset=168
   (get_local $0)
   (get_local $6)
  )
  (i64.store
   (i32.add
    (get_local $0)
    (i32.const 176)
   )
   (get_local $7)
  )
  (i64.store
   (i32.add
    (get_local $0)
    (i32.const 184)
   )
   (i64.const -1)
  )
  (set_local $5
   (i64.const 0)
  )
  (i64.store align=4
   (i32.add
    (get_local $0)
    (i32.const 192)
   )
   (i64.const 0)
  )
  (i32.store
   (i32.add
    (get_local $0)
    (i32.const 200)
   )
   (i32.const 0)
  )
  (set_local $4
   (i64.const 59)
  )
  (set_local $3
   (i32.const 160)
  )
  (set_local $6
   (i64.const 0)
  )
  (loop $label$12
   (block $label$13
    (block $label$14
     (block $label$15
      (block $label$16
       (block $label$17
        (br_if $label$17
         (i64.gt_u
          (get_local $5)
          (i64.const 10)
         )
        )
        (br_if $label$16
         (i32.gt_u
          (i32.and
           (i32.add
            (tee_local $2
             (i32.load8_s
              (get_local $3)
             )
            )
            (i32.const -97)
           )
           (i32.const 255)
          )
          (i32.const 25)
         )
        )
        (set_local $2
         (i32.add
          (get_local $2)
          (i32.const 165)
         )
        )
        (br $label$15)
       )
       (set_local $1
        (i64.const 0)
       )
       (br_if $label$14
        (i64.eq
         (get_local $5)
         (i64.const 11)
        )
       )
       (br $label$13)
      )
      (set_local $2
       (select
        (i32.add
         (get_local $2)
         (i32.const 208)
        )
        (i32.const 0)
        (i32.lt_u
         (i32.and
          (i32.add
           (get_local $2)
           (i32.const -49)
          )
          (i32.const 255)
         )
         (i32.const 5)
        )
       )
      )
     )
     (set_local $1
      (i64.shr_s
       (i64.shl
        (i64.extend_u/i32
         (get_local $2)
        )
        (i64.const 56)
       )
       (i64.const 56)
      )
     )
    )
    (set_local $1
     (i64.shl
      (i64.and
       (get_local $1)
       (i64.const 31)
      )
      (i64.and
       (get_local $4)
       (i64.const 4294967295)
      )
     )
    )
   )
   (set_local $3
    (i32.add
     (get_local $3)
     (i32.const 1)
    )
   )
   (set_local $4
    (i64.add
     (get_local $4)
     (i64.const -5)
    )
   )
   (set_local $6
    (i64.or
     (get_local $1)
     (get_local $6)
    )
   )
   (br_if $label$12
    (i64.ne
     (tee_local $5
      (i64.add
       (get_local $5)
       (i64.const 1)
      )
     )
     (i64.const 13)
    )
   )
  )
  (set_local $5
   (i64.const 0)
  )
  (set_local $4
   (i64.const 59)
  )
  (set_local $3
   (i32.const 160)
  )
  (set_local $7
   (i64.const 0)
  )
  (loop $label$18
   (block $label$19
    (block $label$20
     (block $label$21
      (block $label$22
       (block $label$23
        (br_if $label$23
         (i64.gt_u
          (get_local $5)
          (i64.const 10)
         )
        )
        (br_if $label$22
         (i32.gt_u
          (i32.and
           (i32.add
            (tee_local $2
             (i32.load8_s
              (get_local $3)
             )
            )
            (i32.const -97)
           )
           (i32.const 255)
          )
          (i32.const 25)
         )
        )
        (set_local $2
         (i32.add
          (get_local $2)
          (i32.const 165)
         )
        )
        (br $label$21)
       )
       (set_local $1
        (i64.const 0)
       )
       (br_if $label$20
        (i64.eq
         (get_local $5)
         (i64.const 11)
        )
       )
       (br $label$19)
      )
      (set_local $2
       (select
        (i32.add
         (get_local $2)
         (i32.const 208)
        )
        (i32.const 0)
        (i32.lt_u
         (i32.and
          (i32.add
           (get_local $2)
           (i32.const -49)
          )
          (i32.const 255)
         )
         (i32.const 5)
        )
       )
      )
     )
     (set_local $1
      (i64.shr_s
       (i64.shl
        (i64.extend_u/i32
         (get_local $2)
        )
        (i64.const 56)
       )
       (i64.const 56)
      )
     )
    )
    (set_local $1
     (i64.shl
      (i64.and
       (get_local $1)
       (i64.const 31)
      )
      (i64.and
       (get_local $4)
       (i64.const 4294967295)
      )
     )
    )
   )
   (set_local $3
    (i32.add
     (get_local $3)
     (i32.const 1)
    )
   )
   (set_local $4
    (i64.add
     (get_local $4)
     (i64.const -5)
    )
   )
   (set_local $7
    (i64.or
     (get_local $1)
     (get_local $7)
    )
   )
   (br_if $label$18
    (i64.ne
     (tee_local $5
      (i64.add
       (get_local $5)
       (i64.const 1)
      )
     )
     (i64.const 13)
    )
   )
  )
  (i64.store offset=208
   (get_local $0)
   (get_local $6)
  )
  (i64.store offset=248
   (get_local $0)
   (i64.const 18930585150899460)
  )
  (i64.store
   (i32.add
    (get_local $0)
    (i32.const 216)
   )
   (get_local $7)
  )
  (i64.store
   (i32.add
    (get_local $0)
    (i32.const 224)
   )
   (i64.const -1)
  )
  (i64.store align=4
   (i32.add
    (get_local $0)
    (i32.const 232)
   )
   (i64.const 0)
  )
  (i32.store
   (i32.add
    (get_local $0)
    (i32.const 240)
   )
   (i32.const 0)
  )
  (i64.store offset=256
   (get_local $0)
   (i64.const 1397703940)
  )
  (get_local $0)
 )
 (func $_ZN12daccustodian12updateconfigEN5eosio5assetEhm (type $FUNCSIG$viiii) (param $0 i32) (param $1 i32) (param $2 i32) (param $3 i32)
  (local $4 i64)
  (local $5 i32)
  (i32.store offset=4
   (i32.const 0)
   (tee_local $5
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 32)
    )
   )
  )
  (call $require_auth
   (i64.load
    (get_local $0)
   )
  )
  (set_local $4
   (i64.load offset=8
    (get_local $1)
   )
  )
  (call $_ZN12daccustodian7configsEv
   (i32.add
    (get_local $5)
    (i32.const 8)
   )
   (get_local $0)
  )
  (call $eosio_assert
   (i64.eq
    (get_local $4)
    (i64.load offset=16
     (get_local $5)
    )
   )
   (i32.const 1872)
  )
  (i64.store
   (i32.add
    (i32.add
     (get_local $5)
     (i32.const 8)
    )
    (i32.const 8)
   )
   (i64.load offset=8
    (get_local $1)
   )
  )
  (i32.store8 offset=24
   (get_local $5)
   (get_local $2)
  )
  (i32.store8 offset=25
   (get_local $5)
   (i32.const 3)
  )
  (i64.store offset=8
   (get_local $5)
   (i64.load
    (get_local $1)
   )
  )
  (call $_ZN5eosio9singletonILy4982871454518345728E15contract_configE3setERKS1_y
   (i32.add
    (get_local $0)
    (i32.const 8)
   )
   (i32.add
    (get_local $5)
    (i32.const 8)
   )
   (i64.load
    (get_local $0)
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $5)
    (i32.const 32)
   )
  )
 )
 (func $_ZN5eosio14execute_actionI12daccustodianS1_JNS_5assetEhmEEEbPT_MT0_FvDpT1_E (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i64)
  (local $6 i32)
  (local $7 i32)
  (local $8 i32)
  (set_local $8
   (tee_local $6
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 96)
    )
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (get_local $6)
  )
  (set_local $2
   (i32.load offset=4
    (get_local $1)
   )
  )
  (set_local $7
   (i32.load
    (get_local $1)
   )
  )
  (set_local $1
   (i32.const 0)
  )
  (set_local $4
   (i32.const 0)
  )
  (block $label$0
   (br_if $label$0
    (i32.eqz
     (tee_local $3
      (call $action_data_size)
     )
    )
   )
   (block $label$1
    (block $label$2
     (br_if $label$2
      (i32.lt_u
       (get_local $3)
       (i32.const 513)
      )
     )
     (set_local $4
      (call $malloc
       (get_local $3)
      )
     )
     (br $label$1)
    )
    (i32.store offset=4
     (i32.const 0)
     (tee_local $4
      (i32.sub
       (get_local $6)
       (i32.and
        (i32.add
         (get_local $3)
         (i32.const 15)
        )
        (i32.const -16)
       )
      )
     )
    )
   )
   (drop
    (call $read_action_data
     (get_local $4)
     (get_local $3)
    )
   )
  )
  (i64.store offset=32
   (get_local $8)
   (i64.const 1398362884)
  )
  (i64.store offset=24
   (get_local $8)
   (i64.const 0)
  )
  (call $eosio_assert
   (i32.const 1)
   (i32.const 480)
  )
  (set_local $5
   (i64.const 5462355)
  )
  (block $label$3
   (block $label$4
    (loop $label$5
     (br_if $label$4
      (i32.gt_u
       (i32.add
        (i32.shl
         (i32.wrap/i64
          (get_local $5)
         )
         (i32.const 24)
        )
        (i32.const -1073741825)
       )
       (i32.const 452984830)
      )
     )
     (block $label$6
      (br_if $label$6
       (i64.ne
        (i64.and
         (tee_local $5
          (i64.shr_u
           (get_local $5)
           (i64.const 8)
          )
         )
         (i64.const 255)
        )
        (i64.const 0)
       )
      )
      (loop $label$7
       (br_if $label$4
        (i64.ne
         (i64.and
          (tee_local $5
           (i64.shr_u
            (get_local $5)
            (i64.const 8)
           )
          )
          (i64.const 255)
         )
         (i64.const 0)
        )
       )
       (br_if $label$7
        (i32.lt_s
         (tee_local $1
          (i32.add
           (get_local $1)
           (i32.const 1)
          )
         )
         (i32.const 7)
        )
       )
      )
     )
     (set_local $6
      (i32.const 1)
     )
     (br_if $label$5
      (i32.lt_s
       (tee_local $1
        (i32.add
         (get_local $1)
         (i32.const 1)
        )
       )
       (i32.const 7)
      )
     )
     (br $label$3)
    )
   )
   (set_local $6
    (i32.const 0)
   )
  )
  (call $eosio_assert
   (get_local $6)
   (i32.const 544)
  )
  (i32.store offset=44
   (get_local $8)
   (i32.const 0)
  )
  (i32.store8 offset=40
   (get_local $8)
   (i32.const 0)
  )
  (i32.store offset=84
   (get_local $8)
   (get_local $4)
  )
  (i32.store offset=80
   (get_local $8)
   (get_local $4)
  )
  (i32.store offset=88
   (get_local $8)
   (i32.add
    (get_local $4)
    (get_local $3)
   )
  )
  (i32.store offset=48
   (get_local $8)
   (i32.add
    (get_local $8)
    (i32.const 80)
   )
  )
  (i32.store offset=64
   (get_local $8)
   (i32.add
    (get_local $8)
    (i32.const 24)
   )
  )
  (call $_ZN5boost6fusion6detail17for_each_unrolledILi3EE4callINS0_18std_tuple_iteratorINSt3__15tupleIJN5eosio5assetEhmEEELi0EEEZNS8_rsINS8_10datastreamIPKcEEJS9_hmEEERT_SI_RNS7_IJDpT0_EEEEUlSI_E_EEvRKSH_RKT0_
   (i32.add
    (get_local $8)
    (i32.const 64)
   )
   (i32.add
    (get_local $8)
    (i32.const 48)
   )
  )
  (block $label$8
   (br_if $label$8
    (i32.lt_u
     (get_local $3)
     (i32.const 513)
    )
   )
   (call $free
    (get_local $4)
   )
  )
  (i64.store
   (tee_local $1
    (i32.add
     (i32.add
      (get_local $8)
      (i32.const 48)
     )
     (i32.const 8)
    )
   )
   (i64.load
    (i32.add
     (i32.add
      (get_local $8)
      (i32.const 24)
     )
     (i32.const 8)
    )
   )
  )
  (i64.store offset=48
   (get_local $8)
   (i64.load offset=24
    (get_local $8)
   )
  )
  (set_local $4
   (i32.load
    (i32.add
     (get_local $8)
     (i32.const 44)
    )
   )
  )
  (set_local $6
   (i32.load8_u
    (i32.add
     (get_local $8)
     (i32.const 40)
    )
   )
  )
  (i64.store
   (i32.add
    (i32.add
     (get_local $8)
     (i32.const 64)
    )
    (i32.const 8)
   )
   (i64.load
    (get_local $1)
   )
  )
  (i64.store offset=64
   (get_local $8)
   (i64.load offset=48
    (get_local $8)
   )
  )
  (set_local $1
   (i32.add
    (get_local $0)
    (i32.shr_s
     (get_local $2)
     (i32.const 1)
    )
   )
  )
  (block $label$9
   (br_if $label$9
    (i32.eqz
     (i32.and
      (get_local $2)
      (i32.const 1)
     )
    )
   )
   (set_local $7
    (i32.load
     (i32.add
      (i32.load
       (get_local $1)
      )
      (get_local $7)
     )
    )
   )
  )
  (i64.store
   (i32.add
    (i32.add
     (get_local $8)
     (i32.const 80)
    )
    (i32.const 8)
   )
   (tee_local $5
    (i64.load
     (i32.add
      (i32.add
       (get_local $8)
       (i32.const 64)
      )
      (i32.const 8)
     )
    )
   )
  )
  (i64.store
   (i32.add
    (i32.add
     (get_local $8)
     (i32.const 8)
    )
    (i32.const 8)
   )
   (get_local $5)
  )
  (i64.store offset=80
   (get_local $8)
   (tee_local $5
    (i64.load offset=64
     (get_local $8)
    )
   )
  )
  (i64.store offset=8
   (get_local $8)
   (get_local $5)
  )
  (call_indirect (type $FUNCSIG$viiii)
   (get_local $1)
   (i32.add
    (get_local $8)
    (i32.const 8)
   )
   (i32.and
    (get_local $6)
    (i32.const 255)
   )
   (get_local $4)
   (get_local $7)
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $8)
    (i32.const 96)
   )
  )
  (i32.const 1)
 )
 (func $_ZN12daccustodian12regcandidateEN5eosio4nameENSt3__112basic_stringIcNS2_11char_traitsIcEENS2_9allocatorIcEEEENS0_5assetE (type $FUNCSIG$vijii) (param $0 i32) (param $1 i64) (param $2 i32) (param $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i64)
  (local $7 i32)
  (local $8 i32)
  (local $9 i32)
  (local $10 i64)
  (local $11 i64)
  (local $12 i64)
  (local $13 i64)
  (local $14 i64)
  (local $15 i32)
  (i32.store offset=4
   (i32.const 0)
   (tee_local $15
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 176)
    )
   )
  )
  (i64.store offset=136
   (get_local $15)
   (get_local $1)
  )
  (call $require_auth
   (get_local $1)
  )
  (call $eosio_assert
   (i64.ne
    (i64.load offset=8
     (tee_local $9
      (call $_ZNK5eosio11multi_indexILy10566699676600369152E6memberJEE3getEyPKc
       (i32.add
        (get_local $0)
        (i32.const 168)
       )
       (get_local $1)
       (i32.const 1232)
      )
     )
    )
    (i64.const 0)
   )
   (i32.const 1280)
  )
  (i32.store offset=52
   (get_local $15)
   (i32.const 0)
  )
  (i32.store offset=48
   (get_local $15)
   (i32.add
    (get_local $0)
    (i32.const 208)
   )
  )
  (call $eosio_assert
   (i64.eq
    (i64.load offset=24
     (i32.load offset=4
      (call $_ZN5eosio11multi_indexILy10566699677317378048E9termsinfoJEE14const_iteratormmEv
       (i32.add
        (get_local $15)
        (i32.const 48)
       )
      )
     )
    )
    (i64.load offset=8
     (get_local $9)
    )
   )
   (i32.const 1328)
  )
  (block $label$0
   (br_if $label$0
    (i32.eq
     (tee_local $8
      (i32.load
       (i32.add
        (get_local $0)
        (i32.const 76)
       )
      )
     )
     (tee_local $4
      (i32.load
       (i32.add
        (get_local $0)
        (i32.const 72)
       )
      )
     )
    )
   )
   (set_local $9
    (i32.add
     (get_local $8)
     (i32.const -24)
    )
   )
   (set_local $5
    (i32.sub
     (i32.const 0)
     (get_local $4)
    )
   )
   (loop $label$1
    (br_if $label$0
     (i64.eq
      (i64.load
       (i32.load
        (get_local $9)
       )
      )
      (get_local $1)
     )
    )
    (set_local $8
     (get_local $9)
    )
    (set_local $9
     (tee_local $7
      (i32.add
       (get_local $9)
       (i32.const -24)
      )
     )
    )
    (br_if $label$1
     (i32.ne
      (i32.add
       (get_local $7)
       (get_local $5)
      )
      (i32.const -24)
     )
    )
   )
  )
  (set_local $5
   (i32.add
    (get_local $0)
    (i32.const 48)
   )
  )
  (block $label$2
   (block $label$3
    (br_if $label$3
     (i32.eq
      (get_local $8)
      (get_local $4)
     )
    )
    (call $eosio_assert
     (i32.eq
      (i32.load offset=88
       (tee_local $9
        (i32.load
         (i32.add
          (get_local $8)
          (i32.const -24)
         )
        )
       )
      )
      (get_local $5)
     )
     (i32.const 896)
    )
    (br $label$2)
   )
   (set_local $9
    (i32.const 0)
   )
   (br_if $label$2
    (i32.lt_s
     (tee_local $7
      (call $db_find_i64
       (i64.load
        (i32.add
         (get_local $0)
         (i32.const 48)
        )
       )
       (i64.load
        (i32.add
         (get_local $0)
         (i32.const 56)
        )
       )
       (i64.const 4730634643120193536)
       (get_local $1)
      )
     )
     (i32.const 0)
    )
   )
   (call $eosio_assert
    (i32.eq
     (i32.load offset=88
      (tee_local $9
       (call $_ZNK5eosio11multi_indexILy4730634643120193536E9candidateJNS_10indexed_byILy8518361509820596224EN5boost11multi_index13const_mem_funIS1_oXadL_ZNKS1_22get_by_is_cust_and_payEvEEEEEENS2_ILy4591222642450628608ENS5_IS1_yXadL_ZNKS1_15by_number_votesEvEEEEEEEE31load_object_by_primary_iteratorEl
        (get_local $5)
        (get_local $7)
       )
      )
     )
     (get_local $5)
    )
    (i32.const 896)
   )
  )
  (call $eosio_assert
   (i32.eqz
    (get_local $9)
   )
   (i32.const 1792)
  )
  (call $eosio_assert
   (i64.eq
    (i64.load offset=8
     (get_local $3)
    )
    (i64.load offset=256
     (get_local $0)
    )
   )
   (i32.const 1792)
  )
  (set_local $1
   (i64.const 0)
  )
  (set_local $10
   (i64.const 59)
  )
  (set_local $9
   (i32.const 112)
  )
  (set_local $6
   (i64.load offset=136
    (get_local $15)
   )
  )
  (set_local $11
   (i64.const 0)
  )
  (loop $label$4
   (block $label$5
    (block $label$6
     (block $label$7
      (block $label$8
       (block $label$9
        (br_if $label$9
         (i64.gt_u
          (get_local $1)
          (i64.const 5)
         )
        )
        (br_if $label$8
         (i32.gt_u
          (i32.and
           (i32.add
            (tee_local $7
             (i32.load8_s
              (get_local $9)
             )
            )
            (i32.const -97)
           )
           (i32.const 255)
          )
          (i32.const 25)
         )
        )
        (set_local $7
         (i32.add
          (get_local $7)
          (i32.const 165)
         )
        )
        (br $label$7)
       )
       (set_local $12
        (i64.const 0)
       )
       (br_if $label$6
        (i64.le_u
         (get_local $1)
         (i64.const 11)
        )
       )
       (br $label$5)
      )
      (set_local $7
       (select
        (i32.add
         (get_local $7)
         (i32.const 208)
        )
        (i32.const 0)
        (i32.lt_u
         (i32.and
          (i32.add
           (get_local $7)
           (i32.const -49)
          )
          (i32.const 255)
         )
         (i32.const 5)
        )
       )
      )
     )
     (set_local $12
      (i64.shr_s
       (i64.shl
        (i64.extend_u/i32
         (get_local $7)
        )
        (i64.const 56)
       )
       (i64.const 56)
      )
     )
    )
    (set_local $12
     (i64.shl
      (i64.and
       (get_local $12)
       (i64.const 31)
      )
      (i64.and
       (get_local $10)
       (i64.const 4294967295)
      )
     )
    )
   )
   (set_local $9
    (i32.add
     (get_local $9)
     (i32.const 1)
    )
   )
   (set_local $1
    (i64.add
     (get_local $1)
     (i64.const 1)
    )
   )
   (set_local $11
    (i64.or
     (get_local $12)
     (get_local $11)
    )
   )
   (br_if $label$4
    (i64.ne
     (tee_local $10
      (i64.add
       (get_local $10)
       (i64.const -5)
      )
     )
     (i64.const -6)
    )
   )
  )
  (set_local $1
   (i64.const 0)
  )
  (set_local $10
   (i64.const 59)
  )
  (set_local $9
   (i32.const 160)
  )
  (set_local $13
   (i64.const 0)
  )
  (loop $label$10
   (block $label$11
    (block $label$12
     (block $label$13
      (block $label$14
       (block $label$15
        (br_if $label$15
         (i64.gt_u
          (get_local $1)
          (i64.const 10)
         )
        )
        (br_if $label$14
         (i32.gt_u
          (i32.and
           (i32.add
            (tee_local $7
             (i32.load8_s
              (get_local $9)
             )
            )
            (i32.const -97)
           )
           (i32.const 255)
          )
          (i32.const 25)
         )
        )
        (set_local $7
         (i32.add
          (get_local $7)
          (i32.const 165)
         )
        )
        (br $label$13)
       )
       (set_local $12
        (i64.const 0)
       )
       (br_if $label$12
        (i64.eq
         (get_local $1)
         (i64.const 11)
        )
       )
       (br $label$11)
      )
      (set_local $7
       (select
        (i32.add
         (get_local $7)
         (i32.const 208)
        )
        (i32.const 0)
        (i32.lt_u
         (i32.and
          (i32.add
           (get_local $7)
           (i32.const -49)
          )
          (i32.const 255)
         )
         (i32.const 5)
        )
       )
      )
     )
     (set_local $12
      (i64.shr_s
       (i64.shl
        (i64.extend_u/i32
         (get_local $7)
        )
        (i64.const 56)
       )
       (i64.const 56)
      )
     )
    )
    (set_local $12
     (i64.shl
      (i64.and
       (get_local $12)
       (i64.const 31)
      )
      (i64.and
       (get_local $10)
       (i64.const 4294967295)
      )
     )
    )
   )
   (set_local $9
    (i32.add
     (get_local $9)
     (i32.const 1)
    )
   )
   (set_local $10
    (i64.add
     (get_local $10)
     (i64.const -5)
    )
   )
   (set_local $13
    (i64.or
     (get_local $12)
     (get_local $13)
    )
   )
   (br_if $label$10
    (i64.ne
     (tee_local $1
      (i64.add
       (get_local $1)
       (i64.const 1)
      )
     )
     (i64.const 13)
    )
   )
  )
  (set_local $1
   (i64.const 0)
  )
  (set_local $10
   (i64.const 59)
  )
  (set_local $9
   (i32.const 144)
  )
  (set_local $14
   (i64.const 0)
  )
  (loop $label$16
   (block $label$17
    (block $label$18
     (block $label$19
      (block $label$20
       (block $label$21
        (br_if $label$21
         (i64.gt_u
          (get_local $1)
          (i64.const 7)
         )
        )
        (br_if $label$20
         (i32.gt_u
          (i32.and
           (i32.add
            (tee_local $7
             (i32.load8_s
              (get_local $9)
             )
            )
            (i32.const -97)
           )
           (i32.const 255)
          )
          (i32.const 25)
         )
        )
        (set_local $7
         (i32.add
          (get_local $7)
          (i32.const 165)
         )
        )
        (br $label$19)
       )
       (set_local $12
        (i64.const 0)
       )
       (br_if $label$18
        (i64.le_u
         (get_local $1)
         (i64.const 11)
        )
       )
       (br $label$17)
      )
      (set_local $7
       (select
        (i32.add
         (get_local $7)
         (i32.const 208)
        )
        (i32.const 0)
        (i32.lt_u
         (i32.and
          (i32.add
           (get_local $7)
           (i32.const -49)
          )
          (i32.const 255)
         )
         (i32.const 5)
        )
       )
      )
     )
     (set_local $12
      (i64.shr_s
       (i64.shl
        (i64.extend_u/i32
         (get_local $7)
        )
        (i64.const 56)
       )
       (i64.const 56)
      )
     )
    )
    (set_local $12
     (i64.shl
      (i64.and
       (get_local $12)
       (i64.const 31)
      )
      (i64.and
       (get_local $10)
       (i64.const 4294967295)
      )
     )
    )
   )
   (set_local $9
    (i32.add
     (get_local $9)
     (i32.const 1)
    )
   )
   (set_local $1
    (i64.add
     (get_local $1)
     (i64.const 1)
    )
   )
   (set_local $14
    (i64.or
     (get_local $12)
     (get_local $14)
    )
   )
   (br_if $label$16
    (i64.ne
     (tee_local $10
      (i64.add
       (get_local $10)
       (i64.const -5)
      )
     )
     (i64.const -6)
    )
   )
  )
  (call $_ZN12daccustodian7configsEv
   (i32.add
    (get_local $15)
    (i32.const 24)
   )
   (get_local $0)
  )
  (i32.store
   (i32.add
    (get_local $15)
    (i32.const 16)
   )
   (i32.const 0)
  )
  (i64.store offset=8
   (get_local $15)
   (i64.const 0)
  )
  (block $label$22
   (br_if $label$22
    (i32.ge_u
     (tee_local $9
      (call $strlen
       (i32.const 1840)
      )
     )
     (i32.const -16)
    )
   )
   (block $label$23
    (block $label$24
     (block $label$25
      (br_if $label$25
       (i32.ge_u
        (get_local $9)
        (i32.const 11)
       )
      )
      (i32.store8 offset=8
       (get_local $15)
       (i32.shl
        (get_local $9)
        (i32.const 1)
       )
      )
      (set_local $7
       (i32.or
        (i32.add
         (get_local $15)
         (i32.const 8)
        )
        (i32.const 1)
       )
      )
      (br_if $label$24
       (get_local $9)
      )
      (br $label$23)
     )
     (set_local $7
      (call $_Znwj
       (tee_local $8
        (i32.and
         (i32.add
          (get_local $9)
          (i32.const 16)
         )
         (i32.const -16)
        )
       )
      )
     )
     (i32.store offset=8
      (get_local $15)
      (i32.or
       (get_local $8)
       (i32.const 1)
      )
     )
     (i32.store offset=16
      (get_local $15)
      (get_local $7)
     )
     (i32.store offset=12
      (get_local $15)
      (get_local $9)
     )
    )
    (drop
     (call $memcpy
      (get_local $7)
      (i32.const 1840)
      (get_local $9)
     )
    )
   )
   (i32.store8
    (i32.add
     (get_local $7)
     (get_local $9)
    )
    (i32.const 0)
   )
   (i32.store
    (i32.add
     (i32.add
      (get_local $15)
      (i32.const 48)
     )
     (i32.const 20)
    )
    (i32.load offset=28
     (get_local $15)
    )
   )
   (i64.store offset=56
    (get_local $15)
    (i64.load
     (get_local $0)
    )
   )
   (i32.store
    (i32.add
     (i32.add
      (get_local $15)
      (i32.const 48)
     )
     (i32.const 28)
    )
    (i32.load
     (i32.add
      (get_local $15)
      (i32.const 36)
     )
    )
   )
   (i32.store
    (i32.add
     (i32.add
      (get_local $15)
      (i32.const 48)
     )
     (i32.const 24)
    )
    (i32.load
     (i32.add
      (i32.add
       (get_local $15)
       (i32.const 24)
      )
      (i32.const 8)
     )
    )
   )
   (i64.store offset=48
    (get_local $15)
    (i64.load offset=136
     (get_local $15)
    )
   )
   (i32.store offset=64
    (get_local $15)
    (i32.load offset=24
     (get_local $15)
    )
   )
   (i32.store
    (i32.add
     (get_local $15)
     (i32.const 88)
    )
    (i32.load
     (tee_local $9
      (i32.add
       (i32.add
        (get_local $15)
        (i32.const 8)
       )
       (i32.const 8)
      )
     )
    )
   )
   (i64.store offset=80
    (get_local $15)
    (i64.load offset=8
     (get_local $15)
    )
   )
   (i32.store offset=8
    (get_local $15)
    (i32.const 0)
   )
   (i32.store offset=12
    (get_local $15)
    (i32.const 0)
   )
   (i32.store
    (get_local $9)
    (i32.const 0)
   )
   (i64.store offset=96
    (get_local $15)
    (get_local $13)
   )
   (i64.store offset=104
    (get_local $15)
    (get_local $14)
   )
   (i64.store
    (tee_local $9
     (call $_Znwj
      (i32.const 16)
     )
    )
    (get_local $6)
   )
   (i64.store offset=8
    (get_local $9)
    (get_local $11)
   )
   (i32.store
    (i32.add
     (i32.add
      (get_local $15)
      (i32.const 96)
     )
     (i32.const 32)
    )
    (i32.const 0)
   )
   (i32.store
    (i32.add
     (i32.add
      (get_local $15)
      (i32.const 96)
     )
     (i32.const 24)
    )
    (tee_local $7
     (i32.add
      (get_local $9)
      (i32.const 16)
     )
    )
   )
   (i32.store
    (i32.add
     (i32.add
      (get_local $15)
      (i32.const 96)
     )
     (i32.const 20)
    )
    (get_local $7)
   )
   (i32.store offset=112
    (get_local $15)
    (get_local $9)
   )
   (i32.store offset=124
    (get_local $15)
    (i32.const 0)
   )
   (i32.store
    (i32.add
     (i32.add
      (get_local $15)
      (i32.const 96)
     )
     (i32.const 36)
    )
    (i32.const 0)
   )
   (set_local $9
    (i32.add
     (tee_local $7
      (select
       (i32.load
        (i32.add
         (i32.add
          (get_local $15)
          (i32.const 48)
         )
         (i32.const 36)
        )
       )
       (i32.shr_u
        (tee_local $9
         (i32.load8_u offset=80
          (get_local $15)
         )
        )
        (i32.const 1)
       )
       (i32.and
        (get_local $9)
        (i32.const 1)
       )
      )
     )
     (i32.const 32)
    )
   )
   (set_local $1
    (i64.extend_u/i32
     (get_local $7)
    )
   )
   (set_local $7
    (i32.add
     (i32.add
      (get_local $15)
      (i32.const 96)
     )
     (i32.const 28)
    )
   )
   (loop $label$26
    (set_local $9
     (i32.add
      (get_local $9)
      (i32.const 1)
     )
    )
    (br_if $label$26
     (i64.ne
      (tee_local $1
       (i64.shr_u
        (get_local $1)
        (i64.const 7)
       )
      )
      (i64.const 0)
     )
    )
   )
   (block $label$27
    (block $label$28
     (br_if $label$28
      (i32.eqz
       (get_local $9)
      )
     )
     (call $_ZNSt3__16vectorIcNS_9allocatorIcEEE8__appendEj
      (get_local $7)
      (get_local $9)
     )
     (set_local $7
      (i32.load
       (i32.add
        (get_local $15)
        (i32.const 128)
       )
      )
     )
     (set_local $9
      (i32.load
       (i32.add
        (get_local $15)
        (i32.const 124)
       )
      )
     )
     (br $label$27)
    )
    (set_local $7
     (i32.const 0)
    )
    (set_local $9
     (i32.const 0)
    )
   )
   (i32.store offset=148
    (get_local $15)
    (get_local $9)
   )
   (i32.store offset=144
    (get_local $15)
    (get_local $9)
   )
   (i32.store offset=152
    (get_local $15)
    (get_local $7)
   )
   (i32.store offset=160
    (get_local $15)
    (i32.add
     (get_local $15)
     (i32.const 144)
    )
   )
   (i32.store offset=168
    (get_local $15)
    (i32.add
     (get_local $15)
     (i32.const 48)
    )
   )
   (call $_ZN5boost6fusion6detail17for_each_unrolledILi4EE4callINS0_18std_tuple_iteratorIKNSt3__15tupleIJN5eosio4nameEyNS8_5assetENS6_12basic_stringIcNS6_11char_traitsIcEENS6_9allocatorIcEEEEEEELi0EEEZNS8_lsINS8_10datastreamIPcEEJS9_ySA_SG_EEERT_SP_RKNS7_IJDpT0_EEEEUlRKSO_E_EEvSW_RKT0_
    (i32.add
     (get_local $15)
     (i32.const 168)
    )
    (i32.add
     (get_local $15)
     (i32.const 160)
    )
   )
   (call $_ZN5eosio4packINS_6actionEEENSt3__16vectorIcNS2_9allocatorIcEEEERKT_
    (i32.add
     (get_local $15)
     (i32.const 144)
    )
    (i32.add
     (get_local $15)
     (i32.const 96)
    )
   )
   (call $send_inline
    (tee_local $9
     (i32.load offset=144
      (get_local $15)
     )
    )
    (i32.sub
     (i32.load offset=148
      (get_local $15)
     )
     (get_local $9)
    )
   )
   (block $label$29
    (br_if $label$29
     (i32.eqz
      (tee_local $9
       (i32.load offset=144
        (get_local $15)
       )
      )
     )
    )
    (i32.store offset=148
     (get_local $15)
     (get_local $9)
    )
    (call $_ZdlPv
     (get_local $9)
    )
   )
   (block $label$30
    (br_if $label$30
     (i32.eqz
      (tee_local $9
       (i32.load offset=124
        (get_local $15)
       )
      )
     )
    )
    (i32.store
     (i32.add
      (get_local $15)
      (i32.const 128)
     )
     (get_local $9)
    )
    (call $_ZdlPv
     (get_local $9)
    )
   )
   (block $label$31
    (br_if $label$31
     (i32.eqz
      (tee_local $9
       (i32.load offset=112
        (get_local $15)
       )
      )
     )
    )
    (i32.store
     (i32.add
      (get_local $15)
      (i32.const 116)
     )
     (get_local $9)
    )
    (call $_ZdlPv
     (get_local $9)
    )
   )
   (block $label$32
    (br_if $label$32
     (i32.eqz
      (i32.and
       (i32.load8_u
        (i32.add
         (get_local $15)
         (i32.const 80)
        )
       )
       (i32.const 1)
      )
     )
    )
    (call $_ZdlPv
     (i32.load
      (i32.add
       (get_local $15)
       (i32.const 88)
      )
     )
    )
   )
   (block $label$33
    (br_if $label$33
     (i32.eqz
      (i32.and
       (i32.load8_u offset=8
        (get_local $15)
       )
       (i32.const 1)
      )
     )
    )
    (call $_ZdlPv
     (i32.load
      (i32.add
       (get_local $15)
       (i32.const 16)
      )
     )
    )
   )
   (set_local $1
    (i64.load
     (get_local $0)
    )
   )
   (i32.store offset=52
    (get_local $15)
    (get_local $2)
   )
   (i32.store offset=56
    (get_local $15)
    (get_local $3)
   )
   (i32.store offset=60
    (get_local $15)
    (get_local $0)
   )
   (i32.store offset=48
    (get_local $15)
    (i32.add
     (get_local $15)
     (i32.const 136)
    )
   )
   (call $_ZN5eosio11multi_indexILy4730634643120193536E9candidateJNS_10indexed_byILy8518361509820596224EN5boost11multi_index13const_mem_funIS1_oXadL_ZNKS1_22get_by_is_cust_and_payEvEEEEEENS2_ILy4591222642450628608ENS5_IS1_yXadL_ZNKS1_15by_number_votesEvEEEEEEEE7emplaceIZN12daccustodian12regcandidateENS_4nameENSt3__112basic_stringIcNSE_11char_traitsIcEENSE_9allocatorIcEEEENS_5assetEEUlRS1_E_EENSA_14const_iteratorEyOT_
    (i32.add
     (get_local $15)
     (i32.const 96)
    )
    (get_local $5)
    (get_local $1)
    (i32.add
     (get_local $15)
     (i32.const 48)
    )
   )
   (i32.store offset=4
    (i32.const 0)
    (i32.add
     (get_local $15)
     (i32.const 176)
    )
   )
   (return)
  )
  (call $_ZNKSt3__121__basic_string_commonILb1EE20__throw_length_errorEv
   (i32.add
    (get_local $15)
    (i32.const 8)
   )
  )
  (unreachable)
 )
 (func $_ZN5eosio14execute_actionI12daccustodianS1_JNS_4nameENSt3__112basic_stringIcNS3_11char_traitsIcEENS3_9allocatorIcEEEENS_5assetEEEEbPT_MT0_FvDpT1_E (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i64)
  (local $4 i32)
  (local $5 i32)
  (i32.store offset=4
   (i32.const 0)
   (tee_local $4
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 80)
    )
   )
  )
  (i32.store offset=60
   (tee_local $5
    (get_local $4)
   )
   (get_local $0)
  )
  (i32.store offset=48
   (get_local $5)
   (i32.load
    (get_local $1)
   )
  )
  (i32.store offset=52
   (get_local $5)
   (i32.load offset=4
    (get_local $1)
   )
  )
  (set_local $1
   (i32.const 0)
  )
  (set_local $0
   (i32.const 0)
  )
  (block $label$0
   (br_if $label$0
    (i32.eqz
     (tee_local $2
      (call $action_data_size)
     )
    )
   )
   (block $label$1
    (block $label$2
     (br_if $label$2
      (i32.lt_u
       (get_local $2)
       (i32.const 513)
      )
     )
     (set_local $0
      (call $malloc
       (get_local $2)
      )
     )
     (br $label$1)
    )
    (i32.store offset=4
     (i32.const 0)
     (tee_local $0
      (i32.sub
       (get_local $4)
       (i32.and
        (i32.add
         (get_local $2)
         (i32.const 15)
        )
        (i32.const -16)
       )
      )
     )
    )
   )
   (drop
    (call $read_action_data
     (get_local $0)
     (get_local $2)
    )
   )
  )
  (i32.store
   (i32.add
    (get_local $5)
    (i32.const 24)
   )
   (i32.const 0)
  )
  (i64.store
   (i32.add
    (get_local $5)
    (i32.const 40)
   )
   (i64.const 1398362884)
  )
  (i64.store offset=8
   (get_local $5)
   (i64.const 0)
  )
  (i64.store offset=16
   (get_local $5)
   (i64.const 0)
  )
  (i64.store offset=32
   (get_local $5)
   (i64.const 0)
  )
  (call $eosio_assert
   (i32.const 1)
   (i32.const 480)
  )
  (set_local $3
   (i64.const 5462355)
  )
  (block $label$3
   (loop $label$4
    (set_local $4
     (i32.const 0)
    )
    (br_if $label$3
     (i32.gt_u
      (i32.add
       (i32.shl
        (i32.wrap/i64
         (get_local $3)
        )
        (i32.const 24)
       )
       (i32.const -1073741825)
      )
      (i32.const 452984830)
     )
    )
    (block $label$5
     (br_if $label$5
      (i64.ne
       (i64.and
        (tee_local $3
         (i64.shr_u
          (get_local $3)
          (i64.const 8)
         )
        )
        (i64.const 255)
       )
       (i64.const 0)
      )
     )
     (loop $label$6
      (br_if $label$3
       (i64.ne
        (i64.and
         (tee_local $3
          (i64.shr_u
           (get_local $3)
           (i64.const 8)
          )
         )
         (i64.const 255)
        )
        (i64.const 0)
       )
      )
      (br_if $label$6
       (i32.lt_s
        (tee_local $1
         (i32.add
          (get_local $1)
          (i32.const 1)
         )
        )
        (i32.const 7)
       )
      )
     )
    )
    (set_local $4
     (i32.const 1)
    )
    (br_if $label$4
     (i32.lt_s
      (tee_local $1
       (i32.add
        (get_local $1)
        (i32.const 1)
       )
      )
      (i32.const 7)
     )
    )
   )
  )
  (call $eosio_assert
   (get_local $4)
   (i32.const 544)
  )
  (i32.store offset=72
   (get_local $5)
   (i32.add
    (get_local $0)
    (get_local $2)
   )
  )
  (i32.store offset=64
   (get_local $5)
   (get_local $0)
  )
  (call $eosio_assert
   (i32.gt_u
    (get_local $2)
    (i32.const 7)
   )
   (i32.const 576)
  )
  (drop
   (call $memcpy
    (i32.add
     (get_local $5)
     (i32.const 8)
    )
    (get_local $0)
    (i32.const 8)
   )
  )
  (i32.store offset=68
   (get_local $5)
   (i32.add
    (get_local $0)
    (i32.const 8)
   )
  )
  (drop
   (call $_ZN5eosiorsINS_10datastreamIPKcEEEERT_S6_RNSt3__112basic_stringIcNS7_11char_traitsIcEENS7_9allocatorIcEEEE
    (i32.add
     (get_local $5)
     (i32.const 64)
    )
    (i32.add
     (i32.add
      (get_local $5)
      (i32.const 8)
     )
     (i32.const 8)
    )
   )
  )
  (call $eosio_assert
   (i32.gt_u
    (i32.sub
     (i32.load offset=72
      (get_local $5)
     )
     (i32.load offset=68
      (get_local $5)
     )
    )
    (i32.const 7)
   )
   (i32.const 576)
  )
  (drop
   (call $memcpy
    (i32.add
     (get_local $5)
     (i32.const 32)
    )
    (i32.load offset=68
     (get_local $5)
    )
    (i32.const 8)
   )
  )
  (i32.store offset=68
   (get_local $5)
   (tee_local $1
    (i32.add
     (i32.load offset=68
      (get_local $5)
     )
     (i32.const 8)
    )
   )
  )
  (call $eosio_assert
   (i32.gt_u
    (i32.sub
     (i32.load offset=72
      (get_local $5)
     )
     (get_local $1)
    )
    (i32.const 7)
   )
   (i32.const 576)
  )
  (drop
   (call $memcpy
    (i32.add
     (get_local $5)
     (i32.const 40)
    )
    (i32.load offset=68
     (get_local $5)
    )
    (i32.const 8)
   )
  )
  (block $label$7
   (br_if $label$7
    (i32.lt_u
     (get_local $2)
     (i32.const 513)
    )
   )
   (call $free
    (get_local $0)
   )
  )
  (i32.store offset=68
   (get_local $5)
   (i32.add
    (get_local $5)
    (i32.const 48)
   )
  )
  (i32.store offset=64
   (get_local $5)
   (i32.add
    (get_local $5)
    (i32.const 60)
   )
  )
  (call $_ZN5boost4mp116detail16tuple_apply_implIRZN5eosio14execute_actionI12daccustodianS5_JNS3_4nameENSt3__112basic_stringIcNS7_11char_traitsIcEENS7_9allocatorIcEEEENS3_5assetEEEEbPT_MT0_FvDpT1_EEUlDpT_E_RNS7_5tupleIJS6_SD_SE_EEEJLj0ELj1ELj2EEEEDTclclsr3stdE7forwardISF_Efp_Espclsr3stdE3getIXT1_EEclsr3stdE7forwardISH_Efp0_EEEEOSF_OSH_NS0_16integer_sequenceIjJXspT1_EEEE
   (i32.add
    (get_local $5)
    (i32.const 64)
   )
   (i32.add
    (get_local $5)
    (i32.const 8)
   )
  )
  (block $label$8
   (br_if $label$8
    (i32.eqz
     (i32.and
      (i32.load8_u offset=16
       (get_local $5)
      )
      (i32.const 1)
     )
    )
   )
   (call $_ZdlPv
    (i32.load
     (i32.add
      (get_local $5)
      (i32.const 24)
     )
    )
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $5)
    (i32.const 80)
   )
  )
  (i32.const 1)
 )
 (func $_ZN12daccustodian9unregcandEN5eosio4nameE (type $FUNCSIG$vij) (param $0 i32) (param $1 i64)
  (local $2 i32)
  (local $3 i32)
  (i32.store offset=4
   (i32.const 0)
   (tee_local $3
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 32)
    )
   )
  )
  (i64.store offset=24
   (get_local $3)
   (get_local $1)
  )
  (call $require_auth
   (get_local $1)
  )
  (call $_ZN5eosio11multi_indexILy4730634643120193536E9candidateJNS_10indexed_byILy8518361509820596224EN5boost11multi_index13const_mem_funIS1_oXadL_ZNKS1_22get_by_is_cust_and_payEvEEEEEENS2_ILy4591222642450628608ENS5_IS1_yXadL_ZNKS1_15by_number_votesEvEEEEEEEE5eraseERKS1_
   (tee_local $2
    (i32.add
     (get_local $0)
     (i32.const 48)
    )
   )
   (tee_local $2
    (call $_ZNK5eosio11multi_indexILy4730634643120193536E9candidateJNS_10indexed_byILy8518361509820596224EN5boost11multi_index13const_mem_funIS1_oXadL_ZNKS1_22get_by_is_cust_and_payEvEEEEEENS2_ILy4591222642450628608ENS5_IS1_yXadL_ZNKS1_15by_number_votesEvEEEEEEEE3getEyPKc
     (get_local $2)
     (get_local $1)
     (i32.const 1696)
    )
   )
  )
  (set_local $1
   (i64.load
    (get_local $0)
   )
  )
  (i32.store offset=20
   (get_local $3)
   (get_local $2)
  )
  (i32.store offset=16
   (get_local $3)
   (i32.add
    (get_local $3)
    (i32.const 24)
   )
  )
  (call $_ZN5eosio11multi_indexILy12296682192053436416E3payJEE7emplaceIZN12daccustodian9unregcandENS_4nameEEUlRS1_E_EENS2_14const_iteratorEyOT_
   (i32.add
    (get_local $3)
    (i32.const 8)
   )
   (i32.add
    (get_local $0)
    (i32.const 128)
   )
   (get_local $1)
   (i32.add
    (get_local $3)
    (i32.const 16)
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $3)
    (i32.const 32)
   )
  )
 )
 (func $_ZN5eosio14execute_actionI12daccustodianS1_JNS_4nameEEEEbPT_MT0_FvDpT1_E (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i64)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (set_local $6
   (tee_local $4
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 16)
    )
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (get_local $4)
  )
  (set_local $2
   (i32.load offset=4
    (get_local $1)
   )
  )
  (set_local $5
   (i32.load
    (get_local $1)
   )
  )
  (block $label$0
   (block $label$1
    (block $label$2
     (block $label$3
      (br_if $label$3
       (i32.eqz
        (tee_local $1
         (call $action_data_size)
        )
       )
      )
      (br_if $label$2
       (i32.lt_u
        (get_local $1)
        (i32.const 513)
       )
      )
      (set_local $4
       (call $malloc
        (get_local $1)
       )
      )
      (br $label$1)
     )
     (set_local $4
      (i32.const 0)
     )
     (br $label$0)
    )
    (i32.store offset=4
     (i32.const 0)
     (tee_local $4
      (i32.sub
       (get_local $4)
       (i32.and
        (i32.add
         (get_local $1)
         (i32.const 15)
        )
        (i32.const -16)
       )
      )
     )
    )
   )
   (drop
    (call $read_action_data
     (get_local $4)
     (get_local $1)
    )
   )
  )
  (i64.store offset=8
   (get_local $6)
   (i64.const 0)
  )
  (call $eosio_assert
   (i32.gt_u
    (get_local $1)
    (i32.const 7)
   )
   (i32.const 576)
  )
  (drop
   (call $memcpy
    (i32.add
     (get_local $6)
     (i32.const 8)
    )
    (get_local $4)
    (i32.const 8)
   )
  )
  (set_local $3
   (i64.load offset=8
    (get_local $6)
   )
  )
  (block $label$4
   (br_if $label$4
    (i32.lt_u
     (get_local $1)
     (i32.const 513)
    )
   )
   (call $free
    (get_local $4)
   )
  )
  (set_local $1
   (i32.add
    (get_local $0)
    (i32.shr_s
     (get_local $2)
     (i32.const 1)
    )
   )
  )
  (block $label$5
   (br_if $label$5
    (i32.eqz
     (i32.and
      (get_local $2)
      (i32.const 1)
     )
    )
   )
   (set_local $5
    (i32.load
     (i32.add
      (i32.load
       (get_local $1)
      )
      (get_local $5)
     )
    )
   )
  )
  (call_indirect (type $FUNCSIG$vij)
   (get_local $1)
   (get_local $3)
   (get_local $5)
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $6)
    (i32.const 16)
   )
  )
  (i32.const 1)
 )
 (func $_ZN12daccustodian9updatebioEN5eosio4nameENSt3__112basic_stringIcNS2_11char_traitsIcEENS2_9allocatorIcEEEE (type $FUNCSIG$viji) (param $0 i32) (param $1 i64) (param $2 i32)
  (local $3 i32)
  (local $4 i32)
  (i32.store offset=4
   (i32.const 0)
   (tee_local $4
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 16)
    )
   )
  )
  (call $require_auth
   (get_local $1)
  )
  (call $eosio_assert
   (i64.ne
    (i64.load offset=8
     (tee_local $3
      (call $_ZNK5eosio11multi_indexILy10566699676600369152E6memberJEE3getEyPKc
       (i32.add
        (get_local $0)
        (i32.const 168)
       )
       (get_local $1)
       (i32.const 1232)
      )
     )
    )
    (i64.const 0)
   )
   (i32.const 1280)
  )
  (i32.store offset=12
   (get_local $4)
   (i32.const 0)
  )
  (i32.store offset=8
   (get_local $4)
   (i32.add
    (get_local $0)
    (i32.const 208)
   )
  )
  (call $eosio_assert
   (i64.eq
    (i64.load offset=24
     (i32.load offset=4
      (call $_ZN5eosio11multi_indexILy10566699677317378048E9termsinfoJEE14const_iteratormmEv
       (i32.add
        (get_local $4)
        (i32.const 8)
       )
      )
     )
    )
    (i64.load offset=8
     (get_local $3)
    )
   )
   (i32.const 1328)
  )
  (set_local $3
   (call $_ZNK5eosio11multi_indexILy4730634643120193536E9candidateJNS_10indexed_byILy8518361509820596224EN5boost11multi_index13const_mem_funIS1_oXadL_ZNKS1_22get_by_is_cust_and_payEvEEEEEENS2_ILy4591222642450628608ENS5_IS1_yXadL_ZNKS1_15by_number_votesEvEEEEEEEE3getEyPKc
    (tee_local $0
     (i32.add
      (get_local $0)
      (i32.const 48)
     )
    )
    (get_local $1)
    (i32.const 1696)
   )
  )
  (i32.store
   (get_local $4)
   (get_local $2)
  )
  (call $_ZN5eosio11multi_indexILy4730634643120193536E9candidateJNS_10indexed_byILy8518361509820596224EN5boost11multi_index13const_mem_funIS1_oXadL_ZNKS1_22get_by_is_cust_and_payEvEEEEEENS2_ILy4591222642450628608ENS5_IS1_yXadL_ZNKS1_15by_number_votesEvEEEEEEEE6modifyIZN12daccustodian9updatebioENS_4nameENSt3__112basic_stringIcNSE_11char_traitsIcEENSE_9allocatorIcEEEEEUlRS1_E_EEvRKS1_yOT_
   (get_local $0)
   (get_local $3)
   (i64.const 0)
   (get_local $4)
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $4)
    (i32.const 16)
   )
  )
 )
 (func $_ZN5eosio14execute_actionI12daccustodianS1_JNS_4nameENSt3__112basic_stringIcNS3_11char_traitsIcEENS3_9allocatorIcEEEEEEEbPT_MT0_FvDpT1_E (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  (i32.store offset=4
   (i32.const 0)
   (tee_local $3
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 64)
    )
   )
  )
  (i32.store offset=44
   (tee_local $2
    (get_local $3)
   )
   (get_local $0)
  )
  (i32.store offset=32
   (get_local $2)
   (i32.load
    (get_local $1)
   )
  )
  (i32.store offset=36
   (get_local $2)
   (i32.load offset=4
    (get_local $1)
   )
  )
  (set_local $1
   (i32.const 0)
  )
  (block $label$0
   (br_if $label$0
    (i32.eqz
     (tee_local $0
      (call $action_data_size)
     )
    )
   )
   (block $label$1
    (block $label$2
     (br_if $label$2
      (i32.lt_u
       (get_local $0)
       (i32.const 513)
      )
     )
     (set_local $1
      (call $malloc
       (get_local $0)
      )
     )
     (br $label$1)
    )
    (i32.store offset=4
     (i32.const 0)
     (tee_local $1
      (i32.sub
       (get_local $3)
       (i32.and
        (i32.add
         (get_local $0)
         (i32.const 15)
        )
        (i32.const -16)
       )
      )
     )
    )
   )
   (drop
    (call $read_action_data
     (get_local $1)
     (get_local $0)
    )
   )
  )
  (i32.store
   (i32.add
    (get_local $2)
    (i32.const 24)
   )
   (i32.const 0)
  )
  (i64.store offset=8
   (get_local $2)
   (i64.const 0)
  )
  (i64.store offset=16
   (get_local $2)
   (i64.const 0)
  )
  (i32.store offset=56
   (get_local $2)
   (i32.add
    (get_local $1)
    (get_local $0)
   )
  )
  (i32.store offset=48
   (get_local $2)
   (get_local $1)
  )
  (call $eosio_assert
   (i32.gt_u
    (get_local $0)
    (i32.const 7)
   )
   (i32.const 576)
  )
  (drop
   (call $memcpy
    (i32.add
     (get_local $2)
     (i32.const 8)
    )
    (get_local $1)
    (i32.const 8)
   )
  )
  (i32.store offset=52
   (get_local $2)
   (i32.add
    (get_local $1)
    (i32.const 8)
   )
  )
  (drop
   (call $_ZN5eosiorsINS_10datastreamIPKcEEEERT_S6_RNSt3__112basic_stringIcNS7_11char_traitsIcEENS7_9allocatorIcEEEE
    (i32.add
     (get_local $2)
     (i32.const 48)
    )
    (i32.add
     (i32.add
      (get_local $2)
      (i32.const 8)
     )
     (i32.const 8)
    )
   )
  )
  (block $label$3
   (br_if $label$3
    (i32.lt_u
     (get_local $0)
     (i32.const 513)
    )
   )
   (call $free
    (get_local $1)
   )
  )
  (i32.store offset=52
   (get_local $2)
   (i32.add
    (get_local $2)
    (i32.const 32)
   )
  )
  (i32.store offset=48
   (get_local $2)
   (i32.add
    (get_local $2)
    (i32.const 44)
   )
  )
  (call $_ZN5boost4mp116detail16tuple_apply_implIRZN5eosio14execute_actionI12daccustodianS5_JNS3_4nameENSt3__112basic_stringIcNS7_11char_traitsIcEENS7_9allocatorIcEEEEEEEbPT_MT0_FvDpT1_EEUlDpT_E_RNS7_5tupleIJS6_SD_EEEJLj0ELj1EEEEDTclclsr3stdE7forwardISE_Efp_Espclsr3stdE3getIXT1_EEclsr3stdE7forwardISG_Efp0_EEEEOSE_OSG_NS0_16integer_sequenceIjJXspT1_EEEE
   (i32.add
    (get_local $2)
    (i32.const 48)
   )
   (i32.add
    (get_local $2)
    (i32.const 8)
   )
  )
  (block $label$4
   (br_if $label$4
    (i32.eqz
     (i32.and
      (i32.load8_u offset=16
       (get_local $2)
      )
      (i32.const 1)
     )
    )
   )
   (call $_ZdlPv
    (i32.load
     (i32.add
      (get_local $2)
      (i32.const 24)
     )
    )
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $2)
    (i32.const 64)
   )
  )
  (i32.const 1)
 )
 (func $_ZN12daccustodian12updatereqpayEN5eosio4nameENS0_5assetE (type $FUNCSIG$viji) (param $0 i32) (param $1 i64) (param $2 i32)
  (local $3 i32)
  (local $4 i32)
  (i32.store offset=4
   (i32.const 0)
   (tee_local $4
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 16)
    )
   )
  )
  (call $require_auth
   (get_local $1)
  )
  (call $eosio_assert
   (i64.ne
    (i64.load offset=8
     (tee_local $3
      (call $_ZNK5eosio11multi_indexILy10566699676600369152E6memberJEE3getEyPKc
       (i32.add
        (get_local $0)
        (i32.const 168)
       )
       (get_local $1)
       (i32.const 1232)
      )
     )
    )
    (i64.const 0)
   )
   (i32.const 1280)
  )
  (i32.store offset=12
   (get_local $4)
   (i32.const 0)
  )
  (i32.store offset=8
   (get_local $4)
   (i32.add
    (get_local $0)
    (i32.const 208)
   )
  )
  (call $eosio_assert
   (i64.eq
    (i64.load offset=24
     (i32.load offset=4
      (call $_ZN5eosio11multi_indexILy10566699677317378048E9termsinfoJEE14const_iteratormmEv
       (i32.add
        (get_local $4)
        (i32.const 8)
       )
      )
     )
    )
    (i64.load offset=8
     (get_local $3)
    )
   )
   (i32.const 1328)
  )
  (set_local $3
   (call $_ZNK5eosio11multi_indexILy4730634643120193536E9candidateJNS_10indexed_byILy8518361509820596224EN5boost11multi_index13const_mem_funIS1_oXadL_ZNKS1_22get_by_is_cust_and_payEvEEEEEENS2_ILy4591222642450628608ENS5_IS1_yXadL_ZNKS1_15by_number_votesEvEEEEEEEE3getEyPKc
    (tee_local $0
     (i32.add
      (get_local $0)
      (i32.const 48)
     )
    )
    (get_local $1)
    (i32.const 1696)
   )
  )
  (i32.store
   (get_local $4)
   (get_local $2)
  )
  (call $_ZN5eosio11multi_indexILy4730634643120193536E9candidateJNS_10indexed_byILy8518361509820596224EN5boost11multi_index13const_mem_funIS1_oXadL_ZNKS1_22get_by_is_cust_and_payEvEEEEEENS2_ILy4591222642450628608ENS5_IS1_yXadL_ZNKS1_15by_number_votesEvEEEEEEEE6modifyIZN12daccustodian12updatereqpayENS_4nameENS_5assetEEUlRS1_E_EEvRKS1_yOT_
   (get_local $0)
   (get_local $3)
   (i64.const 0)
   (get_local $4)
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $4)
    (i32.const 16)
   )
  )
 )
 (func $_ZN5eosio14execute_actionI12daccustodianS1_JNS_4nameENS_5assetEEEEbPT_MT0_FvDpT1_E (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i64)
  (local $5 i32)
  (local $6 i64)
  (local $7 i32)
  (local $8 i32)
  (local $9 i32)
  (set_local $9
   (tee_local $7
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 96)
    )
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (get_local $7)
  )
  (set_local $2
   (i32.load offset=4
    (get_local $1)
   )
  )
  (set_local $8
   (i32.load
    (get_local $1)
   )
  )
  (set_local $1
   (i32.const 0)
  )
  (set_local $5
   (i32.const 0)
  )
  (block $label$0
   (br_if $label$0
    (i32.eqz
     (tee_local $3
      (call $action_data_size)
     )
    )
   )
   (block $label$1
    (block $label$2
     (br_if $label$2
      (i32.lt_u
       (get_local $3)
       (i32.const 513)
      )
     )
     (set_local $5
      (call $malloc
       (get_local $3)
      )
     )
     (br $label$1)
    )
    (i32.store offset=4
     (i32.const 0)
     (tee_local $5
      (i32.sub
       (get_local $7)
       (i32.and
        (i32.add
         (get_local $3)
         (i32.const 15)
        )
        (i32.const -16)
       )
      )
     )
    )
   )
   (drop
    (call $read_action_data
     (get_local $5)
     (get_local $3)
    )
   )
  )
  (i64.store
   (i32.add
    (get_local $9)
    (i32.const 40)
   )
   (i64.const 1398362884)
  )
  (i64.store offset=32
   (get_local $9)
   (i64.const 0)
  )
  (i64.store offset=24
   (get_local $9)
   (i64.const 0)
  )
  (call $eosio_assert
   (i32.const 1)
   (i32.const 480)
  )
  (set_local $6
   (i64.const 5462355)
  )
  (block $label$3
   (loop $label$4
    (set_local $7
     (i32.const 0)
    )
    (br_if $label$3
     (i32.gt_u
      (i32.add
       (i32.shl
        (i32.wrap/i64
         (get_local $6)
        )
        (i32.const 24)
       )
       (i32.const -1073741825)
      )
      (i32.const 452984830)
     )
    )
    (block $label$5
     (br_if $label$5
      (i64.ne
       (i64.and
        (tee_local $6
         (i64.shr_u
          (get_local $6)
          (i64.const 8)
         )
        )
        (i64.const 255)
       )
       (i64.const 0)
      )
     )
     (loop $label$6
      (br_if $label$3
       (i64.ne
        (i64.and
         (tee_local $6
          (i64.shr_u
           (get_local $6)
           (i64.const 8)
          )
         )
         (i64.const 255)
        )
        (i64.const 0)
       )
      )
      (br_if $label$6
       (i32.lt_s
        (tee_local $1
         (i32.add
          (get_local $1)
          (i32.const 1)
         )
        )
        (i32.const 7)
       )
      )
     )
    )
    (set_local $7
     (i32.const 1)
    )
    (br_if $label$4
     (i32.lt_s
      (tee_local $1
       (i32.add
        (get_local $1)
        (i32.const 1)
       )
      )
      (i32.const 7)
     )
    )
   )
  )
  (call $eosio_assert
   (get_local $7)
   (i32.const 544)
  )
  (call $eosio_assert
   (i32.gt_u
    (get_local $3)
    (i32.const 7)
   )
   (i32.const 576)
  )
  (drop
   (call $memcpy
    (i32.add
     (get_local $9)
     (i32.const 24)
    )
    (get_local $5)
    (i32.const 8)
   )
  )
  (call $eosio_assert
   (i32.ne
    (tee_local $7
     (i32.and
      (get_local $3)
      (i32.const -8)
     )
    )
    (i32.const 8)
   )
   (i32.const 576)
  )
  (drop
   (call $memcpy
    (tee_local $1
     (i32.add
      (i32.add
       (get_local $9)
       (i32.const 24)
      )
      (i32.const 8)
     )
    )
    (i32.add
     (get_local $5)
     (i32.const 8)
    )
    (i32.const 8)
   )
  )
  (call $eosio_assert
   (i32.ne
    (get_local $7)
    (i32.const 16)
   )
   (i32.const 576)
  )
  (drop
   (call $memcpy
    (i32.add
     (i32.add
      (get_local $9)
      (i32.const 24)
     )
     (i32.const 16)
    )
    (i32.add
     (get_local $5)
     (i32.const 16)
    )
    (i32.const 8)
   )
  )
  (block $label$7
   (br_if $label$7
    (i32.lt_u
     (get_local $3)
     (i32.const 513)
    )
   )
   (call $free
    (get_local $5)
   )
  )
  (i64.store
   (tee_local $7
    (i32.add
     (i32.add
      (get_local $9)
      (i32.const 48)
     )
     (i32.const 8)
    )
   )
   (i64.load
    (i32.add
     (get_local $1)
     (i32.const 8)
    )
   )
  )
  (set_local $6
   (i64.load offset=24
    (get_local $9)
   )
  )
  (i64.store offset=48
   (get_local $9)
   (i64.load
    (get_local $1)
   )
  )
  (i64.store
   (i32.add
    (i32.add
     (get_local $9)
     (i32.const 64)
    )
    (i32.const 8)
   )
   (i64.load
    (get_local $7)
   )
  )
  (i64.store offset=64
   (get_local $9)
   (i64.load offset=48
    (get_local $9)
   )
  )
  (set_local $1
   (i32.add
    (get_local $0)
    (i32.shr_s
     (get_local $2)
     (i32.const 1)
    )
   )
  )
  (block $label$8
   (br_if $label$8
    (i32.eqz
     (i32.and
      (get_local $2)
      (i32.const 1)
     )
    )
   )
   (set_local $8
    (i32.load
     (i32.add
      (i32.load
       (get_local $1)
      )
      (get_local $8)
     )
    )
   )
  )
  (i64.store
   (i32.add
    (i32.add
     (get_local $9)
     (i32.const 80)
    )
    (i32.const 8)
   )
   (tee_local $4
    (i64.load
     (i32.add
      (i32.add
       (get_local $9)
       (i32.const 64)
      )
      (i32.const 8)
     )
    )
   )
  )
  (i64.store
   (i32.add
    (i32.add
     (get_local $9)
     (i32.const 8)
    )
    (i32.const 8)
   )
   (get_local $4)
  )
  (i64.store offset=80
   (get_local $9)
   (tee_local $4
    (i64.load offset=64
     (get_local $9)
    )
   )
  )
  (i64.store offset=8
   (get_local $9)
   (get_local $4)
  )
  (call_indirect (type $FUNCSIG$viji)
   (get_local $1)
   (get_local $6)
   (i32.add
    (get_local $9)
    (i32.const 8)
   )
   (get_local $8)
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $9)
    (i32.const 96)
   )
  )
  (i32.const 1)
 )
 (func $_ZN12daccustodian8votecustEN5eosio4nameENSt3__16vectorIS1_NS2_9allocatorIS1_EEEE (type $FUNCSIG$viji) (param $0 i32) (param $1 i64) (param $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (local $8 i32)
  (i32.store offset=4
   (i32.const 0)
   (tee_local $8
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 48)
    )
   )
  )
  (i64.store offset=40
   (get_local $8)
   (get_local $1)
  )
  (call $require_auth
   (get_local $1)
  )
  (call $eosio_assert
   (i64.ne
    (i64.load offset=8
     (tee_local $6
      (call $_ZNK5eosio11multi_indexILy10566699676600369152E6memberJEE3getEyPKc
       (i32.add
        (get_local $0)
        (i32.const 168)
       )
       (get_local $1)
       (i32.const 1232)
      )
     )
    )
    (i64.const 0)
   )
   (i32.const 1280)
  )
  (i32.store offset=20
   (get_local $8)
   (i32.const 0)
  )
  (i32.store offset=16
   (get_local $8)
   (i32.add
    (get_local $0)
    (i32.const 208)
   )
  )
  (call $eosio_assert
   (i64.eq
    (i64.load offset=24
     (i32.load offset=4
      (call $_ZN5eosio11multi_indexILy10566699677317378048E9termsinfoJEE14const_iteratormmEv
       (i32.add
        (get_local $8)
        (i32.const 16)
       )
      )
     )
    )
    (i64.load offset=8
     (get_local $6)
    )
   )
   (i32.const 1328)
  )
  (set_local $6
   (i32.load
    (get_local $2)
   )
  )
  (set_local $5
   (i32.load offset=4
    (get_local $2)
   )
  )
  (call $_ZN12daccustodian7configsEv
   (i32.add
    (get_local $8)
    (i32.const 16)
   )
   (get_local $0)
  )
  (call $eosio_assert
   (i32.le_u
    (i32.shr_s
     (i32.sub
      (get_local $5)
      (get_local $6)
     )
     (i32.const 3)
    )
    (i32.load8_u offset=32
     (get_local $8)
    )
   )
   (i32.const 1648)
  )
  (block $label$0
   (br_if $label$0
    (i32.eq
     (tee_local $7
      (i32.load
       (i32.add
        (get_local $0)
        (i32.const 116)
       )
      )
     )
     (tee_local $3
      (i32.load
       (i32.add
        (get_local $0)
        (i32.const 112)
       )
      )
     )
    )
   )
   (set_local $6
    (i32.add
     (get_local $7)
     (i32.const -24)
    )
   )
   (set_local $4
    (i32.sub
     (i32.const 0)
     (get_local $3)
    )
   )
   (loop $label$1
    (br_if $label$0
     (i64.eq
      (i64.load
       (i32.load
        (get_local $6)
       )
      )
      (get_local $1)
     )
    )
    (set_local $7
     (get_local $6)
    )
    (set_local $6
     (tee_local $5
      (i32.add
       (get_local $6)
       (i32.const -24)
      )
     )
    )
    (br_if $label$1
     (i32.ne
      (i32.add
       (get_local $5)
       (get_local $4)
      )
      (i32.const -24)
     )
    )
   )
  )
  (set_local $6
   (i32.add
    (get_local $0)
    (i32.const 88)
   )
  )
  (block $label$2
   (block $label$3
    (block $label$4
     (block $label$5
      (block $label$6
       (br_if $label$6
        (i32.eq
         (get_local $7)
         (get_local $3)
        )
       )
       (call $eosio_assert
        (i32.eq
         (i32.load offset=36
          (tee_local $5
           (i32.load
            (i32.add
             (get_local $7)
             (i32.const -24)
            )
           )
          )
         )
         (get_local $6)
        )
        (i32.const 896)
       )
       (set_local $1
        (i64.load
         (get_local $0)
        )
       )
       (br_if $label$5
        (get_local $5)
       )
       (br $label$3)
      )
      (br_if $label$4
       (i32.le_s
        (tee_local $5
         (call $db_find_i64
          (i64.load
           (i32.add
            (get_local $0)
            (i32.const 88)
           )
          )
          (i64.load
           (i32.add
            (get_local $0)
            (i32.const 96)
           )
          )
          (i64.const -2507752926491967488)
          (get_local $1)
         )
        )
        (i32.const -1)
       )
      )
      (call $eosio_assert
       (i32.eq
        (i32.load offset=36
         (tee_local $5
          (call $_ZNK5eosio11multi_indexILy15938991147217584128E4voteJNS_10indexed_byILy4587895300147904512EN5boost11multi_index13const_mem_funIS1_yXadL_ZNKS1_8by_proxyEvEEEEEEEE31load_object_by_primary_iteratorEl
           (get_local $6)
           (get_local $5)
          )
         )
        )
        (get_local $6)
       )
       (i32.const 896)
      )
      (set_local $1
       (i64.load
        (get_local $0)
       )
      )
     )
     (i32.store offset=16
      (get_local $8)
      (get_local $2)
     )
     (call $eosio_assert
      (i32.const 1)
      (i32.const 960)
     )
     (call $_ZN5eosio11multi_indexILy15938991147217584128E4voteJNS_10indexed_byILy4587895300147904512EN5boost11multi_index13const_mem_funIS1_yXadL_ZNKS1_8by_proxyEvEEEEEEEE6modifyIZN12daccustodian8votecustENS_4nameENSt3__16vectorISB_NSC_9allocatorISB_EEEEEUlRS1_E_EEvRKS1_yOT_
      (get_local $6)
      (get_local $5)
      (get_local $1)
      (i32.add
       (get_local $8)
       (i32.const 16)
      )
     )
     (br $label$2)
    )
    (set_local $1
     (i64.load
      (get_local $0)
     )
    )
   )
   (i32.store offset=20
    (get_local $8)
    (get_local $2)
   )
   (i32.store offset=16
    (get_local $8)
    (i32.add
     (get_local $8)
     (i32.const 40)
    )
   )
   (call $_ZN5eosio11multi_indexILy15938991147217584128E4voteJNS_10indexed_byILy4587895300147904512EN5boost11multi_index13const_mem_funIS1_yXadL_ZNKS1_8by_proxyEvEEEEEEEE7emplaceIZN12daccustodian8votecustENS_4nameENSt3__16vectorISB_NSC_9allocatorISB_EEEEEUlRS1_E0_EENS8_14const_iteratorEyOT_
    (i32.add
     (get_local $8)
     (i32.const 8)
    )
    (get_local $6)
    (get_local $1)
    (i32.add
     (get_local $8)
     (i32.const 16)
    )
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $8)
    (i32.const 48)
   )
  )
 )
 (func $_ZN5eosio14execute_actionI12daccustodianS1_JNS_4nameENSt3__16vectorIS2_NS3_9allocatorIS2_EEEEEEEbPT_MT0_FvDpT1_E (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i64)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (set_local $6
   (tee_local $7
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 64)
    )
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (get_local $7)
  )
  (set_local $2
   (i32.load offset=4
    (get_local $1)
   )
  )
  (set_local $5
   (i32.load
    (get_local $1)
   )
  )
  (set_local $1
   (i32.const 0)
  )
  (block $label$0
   (br_if $label$0
    (i32.eqz
     (tee_local $3
      (call $action_data_size)
     )
    )
   )
   (block $label$1
    (block $label$2
     (br_if $label$2
      (i32.lt_u
       (get_local $3)
       (i32.const 513)
      )
     )
     (set_local $1
      (call $malloc
       (get_local $3)
      )
     )
     (br $label$1)
    )
    (i32.store offset=4
     (i32.const 0)
     (tee_local $1
      (i32.sub
       (get_local $7)
       (i32.and
        (i32.add
         (get_local $3)
         (i32.const 15)
        )
        (i32.const -16)
       )
      )
     )
    )
   )
   (drop
    (call $read_action_data
     (get_local $1)
     (get_local $3)
    )
   )
  )
  (i32.store
   (i32.add
    (get_local $6)
    (i32.const 24)
   )
   (i32.const 0)
  )
  (i64.store offset=8
   (get_local $6)
   (i64.const 0)
  )
  (i64.store offset=16
   (get_local $6)
   (i64.const 0)
  )
  (i32.store offset=56
   (get_local $6)
   (i32.add
    (get_local $1)
    (get_local $3)
   )
  )
  (i32.store offset=48
   (get_local $6)
   (get_local $1)
  )
  (call $eosio_assert
   (i32.gt_u
    (get_local $3)
    (i32.const 7)
   )
   (i32.const 576)
  )
  (drop
   (call $memcpy
    (i32.add
     (get_local $6)
     (i32.const 8)
    )
    (get_local $1)
    (i32.const 8)
   )
  )
  (i32.store offset=52
   (get_local $6)
   (i32.add
    (get_local $1)
    (i32.const 8)
   )
  )
  (drop
   (call $_ZN5eosiorsINS_10datastreamIPKcEENS_4nameEEERT_S7_RNSt3__16vectorIT0_NS8_9allocatorISA_EEEE
    (i32.add
     (get_local $6)
     (i32.const 48)
    )
    (tee_local $7
     (i32.add
      (i32.add
       (get_local $6)
       (i32.const 8)
      )
      (i32.const 8)
     )
    )
   )
  )
  (block $label$3
   (br_if $label$3
    (i32.lt_u
     (get_local $3)
     (i32.const 513)
    )
   )
   (call $free
    (get_local $1)
   )
  )
  (set_local $1
   (i32.const 0)
  )
  (i32.store offset=40
   (get_local $6)
   (i32.const 0)
  )
  (set_local $4
   (i64.load offset=8
    (get_local $6)
   )
  )
  (i64.store offset=32
   (get_local $6)
   (i64.const 0)
  )
  (block $label$4
   (block $label$5
    (block $label$6
     (br_if $label$6
      (i32.eqz
       (tee_local $3
        (i32.shr_s
         (tee_local $7
          (i32.sub
           (i32.load
            (i32.add
             (get_local $6)
             (i32.const 20)
            )
           )
           (i32.load
            (get_local $7)
           )
          )
         )
         (i32.const 3)
        )
       )
      )
     )
     (br_if $label$5
      (i32.ge_u
       (get_local $3)
       (i32.const 536870912)
      )
     )
     (i32.store
      (i32.add
       (i32.add
        (get_local $6)
        (i32.const 32)
       )
       (i32.const 8)
      )
      (i32.add
       (tee_local $1
        (call $_Znwj
         (get_local $7)
        )
       )
       (i32.shl
        (get_local $3)
        (i32.const 3)
       )
      )
     )
     (i32.store offset=32
      (get_local $6)
      (get_local $1)
     )
     (i32.store offset=36
      (get_local $6)
      (get_local $1)
     )
     (br_if $label$6
      (i32.lt_s
       (tee_local $3
        (i32.sub
         (i32.load
          (i32.add
           (get_local $6)
           (i32.const 20)
          )
         )
         (tee_local $7
          (i32.load
           (i32.add
            (i32.add
             (get_local $6)
             (i32.const 8)
            )
            (i32.const 8)
           )
          )
         )
        )
       )
       (i32.const 1)
      )
     )
     (drop
      (call $memcpy
       (get_local $1)
       (get_local $7)
       (get_local $3)
      )
     )
     (i32.store offset=36
      (get_local $6)
      (tee_local $1
       (i32.add
        (i32.load offset=36
         (get_local $6)
        )
        (get_local $3)
       )
      )
     )
    )
    (set_local $3
     (i32.add
      (get_local $0)
      (i32.shr_s
       (get_local $2)
       (i32.const 1)
      )
     )
    )
    (block $label$7
     (br_if $label$7
      (i32.eqz
       (i32.and
        (get_local $2)
        (i32.const 1)
       )
      )
     )
     (set_local $5
      (i32.load
       (i32.add
        (i32.load
         (get_local $3)
        )
        (get_local $5)
       )
      )
     )
    )
    (i64.store offset=48
     (get_local $6)
     (i64.const 0)
    )
    (i32.store offset=56
     (get_local $6)
     (i32.const 0)
    )
    (block $label$8
     (br_if $label$8
      (i32.eqz
       (tee_local $2
        (i32.shr_s
         (tee_local $1
          (i32.sub
           (get_local $1)
           (i32.load offset=32
            (get_local $6)
           )
          )
         )
         (i32.const 3)
        )
       )
      )
     )
     (br_if $label$4
      (i32.ge_u
       (get_local $2)
       (i32.const 536870912)
      )
     )
     (i32.store
      (i32.add
       (get_local $6)
       (i32.const 56)
      )
      (i32.add
       (tee_local $1
        (call $_Znwj
         (get_local $1)
        )
       )
       (i32.shl
        (get_local $2)
        (i32.const 3)
       )
      )
     )
     (i32.store offset=48
      (get_local $6)
      (get_local $1)
     )
     (i32.store offset=52
      (get_local $6)
      (get_local $1)
     )
     (br_if $label$8
      (i32.lt_s
       (tee_local $2
        (i32.sub
         (i32.load offset=36
          (get_local $6)
         )
         (tee_local $7
          (i32.load offset=32
           (get_local $6)
          )
         )
        )
       )
       (i32.const 1)
      )
     )
     (drop
      (call $memcpy
       (get_local $1)
       (get_local $7)
       (get_local $2)
      )
     )
     (i32.store offset=52
      (get_local $6)
      (i32.add
       (get_local $1)
       (get_local $2)
      )
     )
    )
    (call_indirect (type $FUNCSIG$viji)
     (get_local $3)
     (get_local $4)
     (i32.add
      (get_local $6)
      (i32.const 48)
     )
     (get_local $5)
    )
    (block $label$9
     (br_if $label$9
      (i32.eqz
       (tee_local $1
        (i32.load offset=48
         (get_local $6)
        )
       )
      )
     )
     (i32.store offset=52
      (get_local $6)
      (get_local $1)
     )
     (call $_ZdlPv
      (get_local $1)
     )
    )
    (block $label$10
     (br_if $label$10
      (i32.eqz
       (tee_local $1
        (i32.load offset=32
         (get_local $6)
        )
       )
      )
     )
     (i32.store offset=36
      (get_local $6)
      (get_local $1)
     )
     (call $_ZdlPv
      (get_local $1)
     )
    )
    (block $label$11
     (br_if $label$11
      (i32.eqz
       (tee_local $1
        (i32.load
         (i32.add
          (get_local $6)
          (i32.const 16)
         )
        )
       )
      )
     )
     (i32.store
      (i32.add
       (get_local $6)
       (i32.const 20)
      )
      (get_local $1)
     )
     (call $_ZdlPv
      (get_local $1)
     )
    )
    (i32.store offset=4
     (i32.const 0)
     (i32.add
      (get_local $6)
      (i32.const 64)
     )
    )
    (return
     (i32.const 1)
    )
   )
   (call $_ZNKSt3__120__vector_base_commonILb1EE20__throw_length_errorEv
    (i32.add
     (get_local $6)
     (i32.const 32)
    )
   )
   (unreachable)
  )
  (call $_ZNKSt3__120__vector_base_commonILb1EE20__throw_length_errorEv
   (i32.add
    (get_local $6)
    (i32.const 48)
   )
  )
  (unreachable)
 )
 (func $_ZN12daccustodian9voteproxyEN5eosio4nameES1_ (type $FUNCSIG$vijj) (param $0 i32) (param $1 i64) (param $2 i64)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (local $8 i32)
  (local $9 i32)
  (local $10 i32)
  (i32.store offset=4
   (i32.const 0)
   (tee_local $10
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 64)
    )
   )
  )
  (i64.store offset=56
   (get_local $10)
   (get_local $1)
  )
  (i64.store offset=48
   (get_local $10)
   (get_local $2)
  )
  (call $require_auth
   (get_local $1)
  )
  (call $eosio_assert
   (i64.ne
    (i64.load offset=8
     (tee_local $8
      (call $_ZNK5eosio11multi_indexILy10566699676600369152E6memberJEE3getEyPKc
       (i32.add
        (get_local $0)
        (i32.const 168)
       )
       (get_local $1)
       (i32.const 1232)
      )
     )
    )
    (i64.const 0)
   )
   (i32.const 1280)
  )
  (i32.store offset=36
   (get_local $10)
   (i32.const 0)
  )
  (i32.store offset=32
   (get_local $10)
   (i32.add
    (get_local $0)
    (i32.const 208)
   )
  )
  (call $eosio_assert
   (i64.eq
    (i64.load offset=24
     (i32.load offset=4
      (call $_ZN5eosio11multi_indexILy10566699677317378048E9termsinfoJEE14const_iteratormmEv
       (i32.add
        (get_local $10)
        (i32.const 32)
       )
      )
     )
    )
    (i64.load offset=8
     (get_local $8)
    )
   )
   (i32.const 1328)
  )
  (call $_ZNK5eosio4name9to_stringEv
   (i32.add
    (get_local $10)
    (i32.const 16)
   )
   (i32.add
    (get_local $10)
    (i32.const 56)
   )
  )
  (i32.store
   (i32.add
    (i32.add
     (get_local $10)
     (i32.const 32)
    )
    (i32.const 8)
   )
   (i32.load
    (tee_local $7
     (i32.add
      (tee_local $8
       (call $_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE6insertEjPKc
        (i32.add
         (get_local $10)
         (i32.const 16)
        )
        (i32.const 0)
        (i32.const 1360)
       )
      )
      (i32.const 8)
     )
    )
   )
  )
  (i64.store offset=32
   (get_local $10)
   (i64.load align=4
    (get_local $8)
   )
  )
  (i32.store
   (get_local $8)
   (i32.const 0)
  )
  (i32.store
   (i32.add
    (get_local $8)
    (i32.const 4)
   )
   (i32.const 0)
  )
  (i32.store
   (get_local $7)
   (i32.const 0)
  )
  (block $label$0
   (br_if $label$0
    (i32.eqz
     (i32.and
      (i32.load8_u offset=16
       (get_local $10)
      )
      (i32.const 1)
     )
    )
   )
   (call $_ZdlPv
    (i32.load offset=24
     (get_local $10)
    )
   )
   (set_local $2
    (i64.load offset=48
     (get_local $10)
    )
   )
  )
  (call $eosio_assert
   (i64.ne
    (i64.load offset=56
     (get_local $10)
    )
    (get_local $2)
   )
   (select
    (i32.load offset=40
     (get_local $10)
    )
    (tee_local $3
     (i32.or
      (i32.add
       (get_local $10)
       (i32.const 32)
      )
      (i32.const 1)
     )
    )
    (i32.and
     (i32.load8_u offset=32
      (get_local $10)
     )
     (i32.const 1)
    )
   )
  )
  (block $label$1
   (br_if $label$1
    (i32.eq
     (tee_local $9
      (i32.load
       (i32.add
        (get_local $0)
        (i32.const 116)
       )
      )
     )
     (tee_local $5
      (i32.load
       (i32.add
        (get_local $0)
        (i32.const 112)
       )
      )
     )
    )
   )
   (set_local $8
    (i32.add
     (get_local $9)
     (i32.const -24)
    )
   )
   (set_local $6
    (i32.sub
     (i32.const 0)
     (get_local $5)
    )
   )
   (loop $label$2
    (br_if $label$1
     (i64.eq
      (i64.load
       (i32.load
        (get_local $8)
       )
      )
      (get_local $2)
     )
    )
    (set_local $9
     (get_local $8)
    )
    (set_local $8
     (tee_local $7
      (i32.add
       (get_local $8)
       (i32.const -24)
      )
     )
    )
    (br_if $label$2
     (i32.ne
      (i32.add
       (get_local $7)
       (get_local $6)
      )
      (i32.const -24)
     )
    )
   )
  )
  (set_local $4
   (i32.add
    (get_local $0)
    (i32.const 88)
   )
  )
  (block $label$3
   (block $label$4
    (block $label$5
     (br_if $label$5
      (i32.eq
       (get_local $9)
       (get_local $5)
      )
     )
     (call $eosio_assert
      (i32.eq
       (i32.load offset=36
        (tee_local $6
         (i32.load
          (i32.add
           (get_local $9)
           (i32.const -24)
          )
         )
        )
       )
       (get_local $4)
      )
      (i32.const 896)
     )
     (br_if $label$4
      (get_local $6)
     )
     (br $label$3)
    )
    (br_if $label$3
     (i32.lt_s
      (tee_local $8
       (call $db_find_i64
        (i64.load
         (i32.add
          (get_local $0)
          (i32.const 88)
         )
        )
        (i64.load
         (i32.add
          (get_local $0)
          (i32.const 96)
         )
        )
        (i64.const -2507752926491967488)
        (get_local $2)
       )
      )
      (i32.const 0)
     )
    )
    (call $eosio_assert
     (i32.eq
      (i32.load offset=36
       (tee_local $6
        (call $_ZNK5eosio11multi_indexILy15938991147217584128E4voteJNS_10indexed_byILy4587895300147904512EN5boost11multi_index13const_mem_funIS1_yXadL_ZNKS1_8by_proxyEvEEEEEEEE31load_object_by_primary_iteratorEl
         (get_local $4)
         (get_local $8)
        )
       )
      )
      (get_local $4)
     )
     (i32.const 896)
    )
   )
   (call $_ZNK5eosio4name9to_stringEv
    (i32.add
     (get_local $10)
     (i32.const 16)
    )
    (i32.add
     (get_local $10)
     (i32.const 56)
    )
   )
   (set_local $7
    (i32.load
     (tee_local $8
      (call $_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE6insertEjPKc
       (i32.add
        (get_local $10)
        (i32.const 16)
       )
       (i32.const 0)
       (i32.const 1408)
      )
     )
    )
   )
   (i32.store
    (get_local $8)
    (i32.const 0)
   )
   (set_local $5
    (i32.load offset=4
     (get_local $8)
    )
   )
   (i32.store offset=4
    (get_local $8)
    (i32.const 0)
   )
   (set_local $9
    (i32.load offset=8
     (get_local $8)
    )
   )
   (i32.store offset=8
    (get_local $8)
    (i32.const 0)
   )
   (block $label$6
    (block $label$7
     (br_if $label$7
      (i32.and
       (i32.load8_u offset=32
        (get_local $10)
       )
       (i32.const 1)
      )
     )
     (i32.store16 offset=32
      (get_local $10)
      (i32.const 0)
     )
     (br $label$6)
    )
    (i32.store8
     (i32.load
      (i32.add
       (get_local $10)
       (i32.const 40)
      )
     )
     (i32.const 0)
    )
    (i32.store offset=36
     (get_local $10)
     (i32.const 0)
    )
   )
   (call $_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE7reserveEj
    (i32.add
     (get_local $10)
     (i32.const 32)
    )
    (i32.const 0)
   )
   (i32.store
    (tee_local $8
     (i32.add
      (get_local $10)
      (i32.const 40)
     )
    )
    (get_local $9)
   )
   (i32.store offset=32
    (get_local $10)
    (get_local $7)
   )
   (i32.store offset=36
    (get_local $10)
    (get_local $5)
   )
   (block $label$8
    (br_if $label$8
     (i32.eqz
      (i32.and
       (i32.load8_u offset=16
        (get_local $10)
       )
       (i32.const 1)
      )
     )
    )
    (call $_ZdlPv
     (i32.load offset=24
      (get_local $10)
     )
    )
    (set_local $9
     (i32.load
      (get_local $8)
     )
    )
    (set_local $7
     (i32.load8_u offset=32
      (get_local $10)
     )
    )
   )
   (call $eosio_assert
    (i64.eqz
     (i64.load offset=8
      (get_local $6)
     )
    )
    (select
     (get_local $9)
     (get_local $3)
     (i32.and
      (get_local $7)
      (i32.const 1)
     )
    )
   )
  )
  (set_local $2
   (i64.load offset=56
    (get_local $10)
   )
  )
  (block $label$9
   (br_if $label$9
    (i32.eq
     (tee_local $9
      (i32.load
       (i32.add
        (get_local $0)
        (i32.const 116)
       )
      )
     )
     (tee_local $5
      (i32.load
       (i32.add
        (get_local $0)
        (i32.const 112)
       )
      )
     )
    )
   )
   (set_local $8
    (i32.add
     (get_local $9)
     (i32.const -24)
    )
   )
   (set_local $6
    (i32.sub
     (i32.const 0)
     (get_local $5)
    )
   )
   (loop $label$10
    (br_if $label$9
     (i64.eq
      (i64.load
       (i32.load
        (get_local $8)
       )
      )
      (get_local $2)
     )
    )
    (set_local $9
     (get_local $8)
    )
    (set_local $8
     (tee_local $7
      (i32.add
       (get_local $8)
       (i32.const -24)
      )
     )
    )
    (br_if $label$10
     (i32.ne
      (i32.add
       (get_local $7)
       (get_local $6)
      )
      (i32.const -24)
     )
    )
   )
  )
  (block $label$11
   (block $label$12
    (block $label$13
     (block $label$14
      (block $label$15
       (br_if $label$15
        (i32.eq
         (get_local $9)
         (get_local $5)
        )
       )
       (call $eosio_assert
        (i32.eq
         (i32.load offset=36
          (tee_local $8
           (i32.load
            (i32.add
             (get_local $9)
             (i32.const -24)
            )
           )
          )
         )
         (get_local $4)
        )
        (i32.const 896)
       )
       (set_local $2
        (i64.load
         (get_local $0)
        )
       )
       (br_if $label$14
        (get_local $8)
       )
       (br $label$12)
      )
      (br_if $label$13
       (i32.le_s
        (tee_local $8
         (call $db_find_i64
          (i64.load
           (i32.add
            (get_local $0)
            (i32.const 88)
           )
          )
          (i64.load
           (i32.add
            (get_local $0)
            (i32.const 96)
           )
          )
          (i64.const -2507752926491967488)
          (get_local $2)
         )
        )
        (i32.const -1)
       )
      )
      (call $eosio_assert
       (i32.eq
        (i32.load offset=36
         (tee_local $8
          (call $_ZNK5eosio11multi_indexILy15938991147217584128E4voteJNS_10indexed_byILy4587895300147904512EN5boost11multi_index13const_mem_funIS1_yXadL_ZNKS1_8by_proxyEvEEEEEEEE31load_object_by_primary_iteratorEl
           (get_local $4)
           (get_local $8)
          )
         )
        )
        (get_local $4)
       )
       (i32.const 896)
      )
      (set_local $2
       (i64.load
        (get_local $0)
       )
      )
     )
     (i32.store offset=16
      (get_local $10)
      (i32.add
       (get_local $10)
       (i32.const 48)
      )
     )
     (call $eosio_assert
      (i32.const 1)
      (i32.const 960)
     )
     (call $_ZN5eosio11multi_indexILy15938991147217584128E4voteJNS_10indexed_byILy4587895300147904512EN5boost11multi_index13const_mem_funIS1_yXadL_ZNKS1_8by_proxyEvEEEEEEEE6modifyIZN12daccustodian9voteproxyENS_4nameESB_EUlRS1_E_EEvRKS1_yOT_
      (get_local $4)
      (get_local $8)
      (get_local $2)
      (i32.add
       (get_local $10)
       (i32.const 16)
      )
     )
     (br $label$11)
    )
    (set_local $2
     (i64.load
      (get_local $0)
     )
    )
   )
   (i32.store offset=20
    (get_local $10)
    (i32.add
     (get_local $10)
     (i32.const 48)
    )
   )
   (i32.store offset=16
    (get_local $10)
    (i32.add
     (get_local $10)
     (i32.const 56)
    )
   )
   (call $_ZN5eosio11multi_indexILy15938991147217584128E4voteJNS_10indexed_byILy4587895300147904512EN5boost11multi_index13const_mem_funIS1_yXadL_ZNKS1_8by_proxyEvEEEEEEEE7emplaceIZN12daccustodian9voteproxyENS_4nameESB_EUlRS1_E0_EENS8_14const_iteratorEyOT_
    (i32.add
     (get_local $10)
     (i32.const 8)
    )
    (get_local $4)
    (get_local $2)
    (i32.add
     (get_local $10)
     (i32.const 16)
    )
   )
  )
  (block $label$16
   (br_if $label$16
    (i32.eqz
     (i32.and
      (i32.load8_u offset=32
       (get_local $10)
      )
      (i32.const 1)
     )
    )
   )
   (call $_ZdlPv
    (i32.load
     (i32.add
      (get_local $10)
      (i32.const 40)
     )
    )
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $10)
    (i32.const 64)
   )
  )
 )
 (func $_ZN5eosio14execute_actionI12daccustodianS1_JNS_4nameES2_EEEbPT_MT0_FvDpT1_E (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i64)
  (local $4 i64)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (local $8 i32)
  (set_local $8
   (tee_local $6
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 16)
    )
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (get_local $6)
  )
  (set_local $2
   (i32.load offset=4
    (get_local $1)
   )
  )
  (set_local $7
   (i32.load
    (get_local $1)
   )
  )
  (block $label$0
   (block $label$1
    (block $label$2
     (block $label$3
      (br_if $label$3
       (i32.eqz
        (tee_local $1
         (call $action_data_size)
        )
       )
      )
      (br_if $label$2
       (i32.lt_u
        (get_local $1)
        (i32.const 513)
       )
      )
      (set_local $6
       (call $malloc
        (get_local $1)
       )
      )
      (br $label$1)
     )
     (set_local $6
      (i32.const 0)
     )
     (br $label$0)
    )
    (i32.store offset=4
     (i32.const 0)
     (tee_local $6
      (i32.sub
       (get_local $6)
       (i32.and
        (i32.add
         (get_local $1)
         (i32.const 15)
        )
        (i32.const -16)
       )
      )
     )
    )
   )
   (drop
    (call $read_action_data
     (get_local $6)
     (get_local $1)
    )
   )
  )
  (i64.store offset=8
   (get_local $8)
   (i64.const 0)
  )
  (i64.store
   (get_local $8)
   (i64.const 0)
  )
  (call $eosio_assert
   (i32.gt_u
    (get_local $1)
    (i32.const 7)
   )
   (i32.const 576)
  )
  (drop
   (call $memcpy
    (get_local $8)
    (get_local $6)
    (i32.const 8)
   )
  )
  (call $eosio_assert
   (i32.ne
    (i32.and
     (get_local $1)
     (i32.const -8)
    )
    (i32.const 8)
   )
   (i32.const 576)
  )
  (drop
   (call $memcpy
    (tee_local $5
     (i32.add
      (get_local $8)
      (i32.const 8)
     )
    )
    (i32.add
     (get_local $6)
     (i32.const 8)
    )
    (i32.const 8)
   )
  )
  (block $label$4
   (br_if $label$4
    (i32.lt_u
     (get_local $1)
     (i32.const 513)
    )
   )
   (call $free
    (get_local $6)
   )
  )
  (set_local $1
   (i32.add
    (get_local $0)
    (i32.shr_s
     (get_local $2)
     (i32.const 1)
    )
   )
  )
  (set_local $4
   (i64.load
    (get_local $5)
   )
  )
  (set_local $3
   (i64.load
    (get_local $8)
   )
  )
  (block $label$5
   (br_if $label$5
    (i32.eqz
     (i32.and
      (get_local $2)
      (i32.const 1)
     )
    )
   )
   (set_local $7
    (i32.load
     (i32.add
      (i32.load
       (get_local $1)
      )
      (get_local $7)
     )
    )
   )
  )
  (call_indirect (type $FUNCSIG$vijj)
   (get_local $1)
   (get_local $3)
   (get_local $4)
   (get_local $7)
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $8)
    (i32.const 16)
   )
  )
  (i32.const 1)
 )
 (func $_ZN12daccustodian9newperiodENSt3__112basic_stringIcNS0_11char_traitsIcEENS0_9allocatorIcEEEE (type $FUNCSIG$vii) (param $0 i32) (param $1 i32)
  (call $require_auth
   (i64.load
    (get_local $0)
   )
  )
  (call $_ZN12daccustodian13distributepayEv
   (get_local $0)
  )
  (call $_ZN12daccustodian13clearOldVotesEv
   (get_local $0)
  )
  (call $_ZN12daccustodian13tallyNewVotesEv
   (get_local $0)
  )
  (call $_ZN12daccustodian22configureForNextPeriodEv
   (get_local $0)
  )
 )
 (func $_ZN5eosio14execute_actionI12daccustodianS1_JNSt3__112basic_stringIcNS2_11char_traitsIcEENS2_9allocatorIcEEEEEEEbPT_MT0_FvDpT1_E (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (set_local $5
   (tee_local $6
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 48)
    )
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (get_local $6)
  )
  (set_local $2
   (i32.load offset=4
    (get_local $1)
   )
  )
  (set_local $4
   (i32.load
    (get_local $1)
   )
  )
  (set_local $1
   (i32.const 0)
  )
  (block $label$0
   (br_if $label$0
    (i32.eqz
     (tee_local $3
      (call $action_data_size)
     )
    )
   )
   (block $label$1
    (block $label$2
     (br_if $label$2
      (i32.lt_u
       (get_local $3)
       (i32.const 513)
      )
     )
     (set_local $1
      (call $malloc
       (get_local $3)
      )
     )
     (br $label$1)
    )
    (i32.store offset=4
     (i32.const 0)
     (tee_local $1
      (i32.sub
       (get_local $6)
       (i32.and
        (i32.add
         (get_local $3)
         (i32.const 15)
        )
        (i32.const -16)
       )
      )
     )
    )
   )
   (drop
    (call $read_action_data
     (get_local $1)
     (get_local $3)
    )
   )
  )
  (i32.store offset=8
   (get_local $5)
   (i32.const 0)
  )
  (i64.store
   (get_local $5)
   (i64.const 0)
  )
  (i32.store offset=36
   (get_local $5)
   (get_local $1)
  )
  (i32.store offset=32
   (get_local $5)
   (get_local $1)
  )
  (i32.store offset=40
   (get_local $5)
   (i32.add
    (get_local $1)
    (get_local $3)
   )
  )
  (drop
   (call $_ZN5eosiorsINS_10datastreamIPKcEEEERT_S6_RNSt3__112basic_stringIcNS7_11char_traitsIcEENS7_9allocatorIcEEEE
    (i32.add
     (get_local $5)
     (i32.const 32)
    )
    (get_local $5)
   )
  )
  (block $label$3
   (br_if $label$3
    (i32.lt_u
     (get_local $3)
     (i32.const 513)
    )
   )
   (call $free
    (get_local $1)
   )
  )
  (set_local $1
   (i32.add
    (get_local $0)
    (i32.shr_s
     (get_local $2)
     (i32.const 1)
    )
   )
  )
  (drop
   (call $_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC2ERKS5_
    (i32.add
     (get_local $5)
     (i32.const 16)
    )
    (get_local $5)
   )
  )
  (block $label$4
   (br_if $label$4
    (i32.eqz
     (i32.and
      (get_local $2)
      (i32.const 1)
     )
    )
   )
   (set_local $4
    (i32.load
     (i32.add
      (i32.load
       (get_local $1)
      )
      (get_local $4)
     )
    )
   )
  )
  (drop
   (call $_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC2ERKS5_
    (i32.add
     (get_local $5)
     (i32.const 32)
    )
    (i32.add
     (get_local $5)
     (i32.const 16)
    )
   )
  )
  (call_indirect (type $FUNCSIG$vii)
   (get_local $1)
   (i32.add
    (get_local $5)
    (i32.const 32)
   )
   (get_local $4)
  )
  (block $label$5
   (br_if $label$5
    (i32.eqz
     (i32.and
      (i32.load8_u offset=32
       (get_local $5)
      )
      (i32.const 1)
     )
    )
   )
   (call $_ZdlPv
    (i32.load offset=40
     (get_local $5)
    )
   )
  )
  (block $label$6
   (br_if $label$6
    (i32.eqz
     (i32.and
      (i32.load8_u offset=16
       (get_local $5)
      )
      (i32.const 1)
     )
    )
   )
   (call $_ZdlPv
    (i32.load offset=24
     (get_local $5)
    )
   )
  )
  (block $label$7
   (br_if $label$7
    (i32.eqz
     (i32.and
      (i32.load8_u
       (get_local $5)
      )
      (i32.const 1)
     )
    )
   )
   (call $_ZdlPv
    (i32.load
     (i32.add
      (get_local $5)
      (i32.const 8)
     )
    )
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $5)
    (i32.const 48)
   )
  )
  (i32.const 1)
 )
 (func $_ZN12daccustodian10paypendingENSt3__112basic_stringIcNS0_11char_traitsIcEENS0_9allocatorIcEEEE (type $FUNCSIG$vii) (param $0 i32) (param $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i64)
  (local $7 i32)
  (local $8 i32)
  (local $9 i32)
  (local $10 i32)
  (local $11 i32)
  (local $12 i32)
  (local $13 i32)
  (local $14 i32)
  (local $15 i32)
  (local $16 i64)
  (local $17 i64)
  (local $18 i64)
  (local $19 i64)
  (local $20 i64)
  (local $21 i64)
  (local $22 i32)
  (i32.store offset=4
   (i32.const 0)
   (tee_local $22
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 128)
    )
   )
  )
  (call $require_auth
   (i64.load
    (get_local $0)
   )
  )
  (block $label$0
   (br_if $label$0
    (i32.lt_s
     (tee_local $15
      (call $db_lowerbound_i64
       (i64.load offset=128
        (get_local $0)
       )
       (i64.load
        (i32.add
         (get_local $0)
         (i32.const 136)
        )
       )
       (i64.const -6150061881656115200)
       (i64.const 0)
      )
     )
     (i32.const 0)
    )
   )
   (set_local $14
    (call $_ZNK5eosio11multi_indexILy12296682192053436416E3payJEE31load_object_by_primary_iteratorEl
     (tee_local $2
      (i32.add
       (get_local $0)
       (i32.const 128)
      )
     )
     (get_local $15)
    )
   )
   (set_local $5
    (i32.add
     (get_local $22)
     (i32.const 84)
    )
   )
   (set_local $4
    (i32.add
     (i32.add
      (get_local $22)
      (i32.const 8)
     )
     (i32.const 32)
    )
   )
   (set_local $8
    (i32.add
     (get_local $0)
     (i32.const 256)
    )
   )
   (set_local $10
    (i32.add
     (tee_local $3
      (i32.add
       (i32.add
        (get_local $22)
        (i32.const 8)
       )
       (i32.const 16)
      )
     )
     (i32.const 4)
    )
   )
   (set_local $13
    (i32.add
     (get_local $22)
     (i32.const 48)
    )
   )
   (loop $label$1
    (block $label$2
     (block $label$3
      (block $label$4
       (block $label$5
        (block $label$6
         (block $label$7
          (br_if $label$7
           (i64.ne
            (i64.load
             (tee_local $9
              (i32.add
               (get_local $14)
               (i32.const 16)
              )
             )
            )
            (i64.load
             (get_local $8)
            )
           )
          )
          (set_local $6
           (i64.load
            (get_local $0)
           )
          )
          (set_local $17
           (i64.const 0)
          )
          (set_local $16
           (i64.const 59)
          )
          (set_local $15
           (i32.const 112)
          )
          (set_local $18
           (i64.const 0)
          )
          (loop $label$8
           (block $label$9
            (block $label$10
             (block $label$11
              (block $label$12
               (block $label$13
                (br_if $label$13
                 (i64.gt_u
                  (get_local $17)
                  (i64.const 5)
                 )
                )
                (br_if $label$12
                 (i32.gt_u
                  (i32.and
                   (i32.add
                    (tee_local $7
                     (i32.load8_s
                      (get_local $15)
                     )
                    )
                    (i32.const -97)
                   )
                   (i32.const 255)
                  )
                  (i32.const 25)
                 )
                )
                (set_local $7
                 (i32.add
                  (get_local $7)
                  (i32.const 165)
                 )
                )
                (br $label$11)
               )
               (set_local $19
                (i64.const 0)
               )
               (br_if $label$10
                (i64.le_u
                 (get_local $17)
                 (i64.const 11)
                )
               )
               (br $label$9)
              )
              (set_local $7
               (select
                (i32.add
                 (get_local $7)
                 (i32.const 208)
                )
                (i32.const 0)
                (i32.lt_u
                 (i32.and
                  (i32.add
                   (get_local $7)
                   (i32.const -49)
                  )
                  (i32.const 255)
                 )
                 (i32.const 5)
                )
               )
              )
             )
             (set_local $19
              (i64.shr_s
               (i64.shl
                (i64.extend_u/i32
                 (get_local $7)
                )
                (i64.const 56)
               )
               (i64.const 56)
              )
             )
            )
            (set_local $19
             (i64.shl
              (i64.and
               (get_local $19)
               (i64.const 31)
              )
              (i64.and
               (get_local $16)
               (i64.const 4294967295)
              )
             )
            )
           )
           (set_local $15
            (i32.add
             (get_local $15)
             (i32.const 1)
            )
           )
           (set_local $17
            (i64.add
             (get_local $17)
             (i64.const 1)
            )
           )
           (set_local $18
            (i64.or
             (get_local $19)
             (get_local $18)
            )
           )
           (br_if $label$8
            (i64.ne
             (tee_local $16
              (i64.add
               (get_local $16)
               (i64.const -5)
              )
             )
             (i64.const -6)
            )
           )
          )
          (set_local $17
           (i64.const 0)
          )
          (set_local $16
           (i64.const 59)
          )
          (set_local $15
           (i32.const 128)
          )
          (set_local $20
           (i64.const 0)
          )
          (loop $label$14
           (block $label$15
            (block $label$16
             (block $label$17
              (block $label$18
               (block $label$19
                (br_if $label$19
                 (i64.gt_u
                  (get_local $17)
                  (i64.const 10)
                 )
                )
                (br_if $label$18
                 (i32.gt_u
                  (i32.and
                   (i32.add
                    (tee_local $7
                     (i32.load8_s
                      (get_local $15)
                     )
                    )
                    (i32.const -97)
                   )
                   (i32.const 255)
                  )
                  (i32.const 25)
                 )
                )
                (set_local $7
                 (i32.add
                  (get_local $7)
                  (i32.const 165)
                 )
                )
                (br $label$17)
               )
               (set_local $19
                (i64.const 0)
               )
               (br_if $label$16
                (i64.eq
                 (get_local $17)
                 (i64.const 11)
                )
               )
               (br $label$15)
              )
              (set_local $7
               (select
                (i32.add
                 (get_local $7)
                 (i32.const 208)
                )
                (i32.const 0)
                (i32.lt_u
                 (i32.and
                  (i32.add
                   (get_local $7)
                   (i32.const -49)
                  )
                  (i32.const 255)
                 )
                 (i32.const 5)
                )
               )
              )
             )
             (set_local $19
              (i64.shr_s
               (i64.shl
                (i64.extend_u/i32
                 (get_local $7)
                )
                (i64.const 56)
               )
               (i64.const 56)
              )
             )
            )
            (set_local $19
             (i64.shl
              (i64.and
               (get_local $19)
               (i64.const 31)
              )
              (i64.and
               (get_local $16)
               (i64.const 4294967295)
              )
             )
            )
           )
           (set_local $15
            (i32.add
             (get_local $15)
             (i32.const 1)
            )
           )
           (set_local $16
            (i64.add
             (get_local $16)
             (i64.const -5)
            )
           )
           (set_local $20
            (i64.or
             (get_local $19)
             (get_local $20)
            )
           )
           (br_if $label$14
            (i64.ne
             (tee_local $17
              (i64.add
               (get_local $17)
               (i64.const 1)
              )
             )
             (i64.const 13)
            )
           )
          )
          (set_local $17
           (i64.const 0)
          )
          (set_local $16
           (i64.const 59)
          )
          (set_local $15
           (i32.const 144)
          )
          (set_local $21
           (i64.const 0)
          )
          (loop $label$20
           (block $label$21
            (block $label$22
             (block $label$23
              (block $label$24
               (block $label$25
                (br_if $label$25
                 (i64.gt_u
                  (get_local $17)
                  (i64.const 7)
                 )
                )
                (br_if $label$24
                 (i32.gt_u
                  (i32.and
                   (i32.add
                    (tee_local $7
                     (i32.load8_s
                      (get_local $15)
                     )
                    )
                    (i32.const -97)
                   )
                   (i32.const 255)
                  )
                  (i32.const 25)
                 )
                )
                (set_local $7
                 (i32.add
                  (get_local $7)
                  (i32.const 165)
                 )
                )
                (br $label$23)
               )
               (set_local $19
                (i64.const 0)
               )
               (br_if $label$22
                (i64.le_u
                 (get_local $17)
                 (i64.const 11)
                )
               )
               (br $label$21)
              )
              (set_local $7
               (select
                (i32.add
                 (get_local $7)
                 (i32.const 208)
                )
                (i32.const 0)
                (i32.lt_u
                 (i32.and
                  (i32.add
                   (get_local $7)
                   (i32.const -49)
                  )
                  (i32.const 255)
                 )
                 (i32.const 5)
                )
               )
              )
             )
             (set_local $19
              (i64.shr_s
               (i64.shl
                (i64.extend_u/i32
                 (get_local $7)
                )
                (i64.const 56)
               )
               (i64.const 56)
              )
             )
            )
            (set_local $19
             (i64.shl
              (i64.and
               (get_local $19)
               (i64.const 31)
              )
              (i64.and
               (get_local $16)
               (i64.const 4294967295)
              )
             )
            )
           )
           (set_local $15
            (i32.add
             (get_local $15)
             (i32.const 1)
            )
           )
           (set_local $17
            (i64.add
             (get_local $17)
             (i64.const 1)
            )
           )
           (set_local $21
            (i64.or
             (get_local $19)
             (get_local $21)
            )
           )
           (br_if $label$20
            (i64.ne
             (tee_local $16
              (i64.add
               (get_local $16)
               (i64.const -5)
              )
             )
             (i64.const -6)
            )
           )
          )
          (i64.store
           (i32.add
            (i32.add
             (get_local $22)
             (i32.const 8)
            )
            (i32.const 8)
           )
           (i64.load
            (get_local $14)
           )
          )
          (i32.store
           (i32.add
            (get_local $3)
            (i32.const 12)
           )
           (i32.load
            (i32.add
             (get_local $14)
             (i32.const 20)
            )
           )
          )
          (i32.store
           (i32.add
            (get_local $3)
            (i32.const 8)
           )
           (i32.load
            (get_local $9)
           )
          )
          (i32.store
           (get_local $10)
           (i32.load
            (i32.add
             (get_local $14)
             (i32.const 12)
            )
           )
          )
          (i32.store
           (get_local $3)
           (i32.load offset=8
            (get_local $14)
           )
          )
          (i64.store offset=8
           (get_local $22)
           (get_local $6)
          )
          (drop
           (call $_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC2ERKS5_
            (get_local $4)
            (i32.add
             (get_local $14)
             (i32.const 24)
            )
           )
          )
          (i64.store
           (i32.add
            (i32.add
             (get_local $22)
             (i32.const 56)
            )
            (i32.const 8)
           )
           (get_local $21)
          )
          (i64.store
           (tee_local $7
            (i32.add
             (i32.add
              (get_local $22)
              (i32.const 56)
             )
             (i32.const 16)
            )
           )
           (i64.const 0)
          )
          (i32.store
           (tee_local $11
            (i32.add
             (i32.add
              (get_local $22)
              (i32.const 56)
             )
             (i32.const 24)
            )
           )
           (i32.const 0)
          )
          (i64.store offset=56
           (get_local $22)
           (get_local $20)
          )
          (i32.store
           (get_local $7)
           (tee_local $15
            (call $_Znwj
             (i32.const 16)
            )
           )
          )
          (i64.store
           (get_local $15)
           (get_local $6)
          )
          (i64.store offset=8
           (get_local $15)
           (get_local $18)
          )
          (i32.store
           (get_local $5)
           (i32.const 0)
          )
          (i32.store
           (tee_local $9
            (i32.add
             (i32.add
              (get_local $22)
              (i32.const 56)
             )
             (i32.const 32)
            )
           )
           (i32.const 0)
          )
          (i32.store
           (get_local $11)
           (tee_local $15
            (i32.add
             (get_local $15)
             (i32.const 16)
            )
           )
          )
          (i32.store
           (tee_local $12
            (i32.add
             (i32.add
              (get_local $22)
              (i32.const 56)
             )
             (i32.const 20)
            )
           )
           (get_local $15)
          )
          (i32.store
           (i32.add
            (i32.add
             (get_local $22)
             (i32.const 56)
            )
            (i32.const 36)
           )
           (i32.const 0)
          )
          (set_local $15
           (i32.add
            (tee_local $11
             (select
              (i32.load
               (i32.add
                (i32.add
                 (get_local $22)
                 (i32.const 8)
                )
                (i32.const 36)
               )
              )
              (i32.shr_u
               (tee_local $15
                (i32.load8_u
                 (get_local $4)
                )
               )
               (i32.const 1)
              )
              (i32.and
               (get_local $15)
               (i32.const 1)
              )
             )
            )
            (i32.const 32)
           )
          )
          (set_local $17
           (i64.extend_u/i32
            (get_local $11)
           )
          )
          (loop $label$26
           (set_local $15
            (i32.add
             (get_local $15)
             (i32.const 1)
            )
           )
           (br_if $label$26
            (i64.ne
             (tee_local $17
              (i64.shr_u
               (get_local $17)
               (i64.const 7)
              )
             )
             (i64.const 0)
            )
           )
          )
          (br_if $label$6
           (i32.eqz
            (get_local $15)
           )
          )
          (call $_ZNSt3__16vectorIcNS_9allocatorIcEEE8__appendEj
           (get_local $5)
           (get_local $15)
          )
          (set_local $11
           (i32.load
            (get_local $9)
           )
          )
          (set_local $15
           (i32.load
            (get_local $5)
           )
          )
          (br $label$5)
         )
         (set_local $6
          (i64.load
           (get_local $0)
          )
         )
         (set_local $17
          (i64.const 0)
         )
         (set_local $16
          (i64.const 59)
         )
         (set_local $15
          (i32.const 112)
         )
         (set_local $18
          (i64.const 0)
         )
         (loop $label$27
          (block $label$28
           (block $label$29
            (block $label$30
             (block $label$31
              (block $label$32
               (br_if $label$32
                (i64.gt_u
                 (get_local $17)
                 (i64.const 5)
                )
               )
               (br_if $label$31
                (i32.gt_u
                 (i32.and
                  (i32.add
                   (tee_local $7
                    (i32.load8_s
                     (get_local $15)
                    )
                   )
                   (i32.const -97)
                  )
                  (i32.const 255)
                 )
                 (i32.const 25)
                )
               )
               (set_local $7
                (i32.add
                 (get_local $7)
                 (i32.const 165)
                )
               )
               (br $label$30)
              )
              (set_local $19
               (i64.const 0)
              )
              (br_if $label$29
               (i64.le_u
                (get_local $17)
                (i64.const 11)
               )
              )
              (br $label$28)
             )
             (set_local $7
              (select
               (i32.add
                (get_local $7)
                (i32.const 208)
               )
               (i32.const 0)
               (i32.lt_u
                (i32.and
                 (i32.add
                  (get_local $7)
                  (i32.const -49)
                 )
                 (i32.const 255)
                )
                (i32.const 5)
               )
              )
             )
            )
            (set_local $19
             (i64.shr_s
              (i64.shl
               (i64.extend_u/i32
                (get_local $7)
               )
               (i64.const 56)
              )
              (i64.const 56)
             )
            )
           )
           (set_local $19
            (i64.shl
             (i64.and
              (get_local $19)
              (i64.const 31)
             )
             (i64.and
              (get_local $16)
              (i64.const 4294967295)
             )
            )
           )
          )
          (set_local $15
           (i32.add
            (get_local $15)
            (i32.const 1)
           )
          )
          (set_local $17
           (i64.add
            (get_local $17)
            (i64.const 1)
           )
          )
          (set_local $18
           (i64.or
            (get_local $19)
            (get_local $18)
           )
          )
          (br_if $label$27
           (i64.ne
            (tee_local $16
             (i64.add
              (get_local $16)
              (i64.const -5)
             )
            )
            (i64.const -6)
           )
          )
         )
         (set_local $17
          (i64.const 0)
         )
         (set_local $16
          (i64.const 59)
         )
         (set_local $15
          (i32.const 160)
         )
         (set_local $20
          (i64.const 0)
         )
         (loop $label$33
          (block $label$34
           (block $label$35
            (block $label$36
             (block $label$37
              (block $label$38
               (br_if $label$38
                (i64.gt_u
                 (get_local $17)
                 (i64.const 10)
                )
               )
               (br_if $label$37
                (i32.gt_u
                 (i32.and
                  (i32.add
                   (tee_local $7
                    (i32.load8_s
                     (get_local $15)
                    )
                   )
                   (i32.const -97)
                  )
                  (i32.const 255)
                 )
                 (i32.const 25)
                )
               )
               (set_local $7
                (i32.add
                 (get_local $7)
                 (i32.const 165)
                )
               )
               (br $label$36)
              )
              (set_local $19
               (i64.const 0)
              )
              (br_if $label$35
               (i64.eq
                (get_local $17)
                (i64.const 11)
               )
              )
              (br $label$34)
             )
             (set_local $7
              (select
               (i32.add
                (get_local $7)
                (i32.const 208)
               )
               (i32.const 0)
               (i32.lt_u
                (i32.and
                 (i32.add
                  (get_local $7)
                  (i32.const -49)
                 )
                 (i32.const 255)
                )
                (i32.const 5)
               )
              )
             )
            )
            (set_local $19
             (i64.shr_s
              (i64.shl
               (i64.extend_u/i32
                (get_local $7)
               )
               (i64.const 56)
              )
              (i64.const 56)
             )
            )
           )
           (set_local $19
            (i64.shl
             (i64.and
              (get_local $19)
              (i64.const 31)
             )
             (i64.and
              (get_local $16)
              (i64.const 4294967295)
             )
            )
           )
          )
          (set_local $15
           (i32.add
            (get_local $15)
            (i32.const 1)
           )
          )
          (set_local $16
           (i64.add
            (get_local $16)
            (i64.const -5)
           )
          )
          (set_local $20
           (i64.or
            (get_local $19)
            (get_local $20)
           )
          )
          (br_if $label$33
           (i64.ne
            (tee_local $17
             (i64.add
              (get_local $17)
              (i64.const 1)
             )
            )
            (i64.const 13)
           )
          )
         )
         (set_local $17
          (i64.const 0)
         )
         (set_local $16
          (i64.const 59)
         )
         (set_local $15
          (i32.const 144)
         )
         (set_local $21
          (i64.const 0)
         )
         (loop $label$39
          (block $label$40
           (block $label$41
            (block $label$42
             (block $label$43
              (block $label$44
               (br_if $label$44
                (i64.gt_u
                 (get_local $17)
                 (i64.const 7)
                )
               )
               (br_if $label$43
                (i32.gt_u
                 (i32.and
                  (i32.add
                   (tee_local $7
                    (i32.load8_s
                     (get_local $15)
                    )
                   )
                   (i32.const -97)
                  )
                  (i32.const 255)
                 )
                 (i32.const 25)
                )
               )
               (set_local $7
                (i32.add
                 (get_local $7)
                 (i32.const 165)
                )
               )
               (br $label$42)
              )
              (set_local $19
               (i64.const 0)
              )
              (br_if $label$41
               (i64.le_u
                (get_local $17)
                (i64.const 11)
               )
              )
              (br $label$40)
             )
             (set_local $7
              (select
               (i32.add
                (get_local $7)
                (i32.const 208)
               )
               (i32.const 0)
               (i32.lt_u
                (i32.and
                 (i32.add
                  (get_local $7)
                  (i32.const -49)
                 )
                 (i32.const 255)
                )
                (i32.const 5)
               )
              )
             )
            )
            (set_local $19
             (i64.shr_s
              (i64.shl
               (i64.extend_u/i32
                (get_local $7)
               )
               (i64.const 56)
              )
              (i64.const 56)
             )
            )
           )
           (set_local $19
            (i64.shl
             (i64.and
              (get_local $19)
              (i64.const 31)
             )
             (i64.and
              (get_local $16)
              (i64.const 4294967295)
             )
            )
           )
          )
          (set_local $15
           (i32.add
            (get_local $15)
            (i32.const 1)
           )
          )
          (set_local $17
           (i64.add
            (get_local $17)
            (i64.const 1)
           )
          )
          (set_local $21
           (i64.or
            (get_local $19)
            (get_local $21)
           )
          )
          (br_if $label$39
           (i64.ne
            (tee_local $16
             (i64.add
              (get_local $16)
              (i64.const -5)
             )
            )
            (i64.const -6)
           )
          )
         )
         (i64.store
          (i32.add
           (i32.add
            (get_local $22)
            (i32.const 8)
           )
           (i32.const 8)
          )
          (i64.load
           (get_local $14)
          )
         )
         (i32.store
          (i32.add
           (get_local $3)
           (i32.const 12)
          )
          (i32.load
           (i32.add
            (get_local $14)
            (i32.const 20)
           )
          )
         )
         (i32.store
          (i32.add
           (get_local $3)
           (i32.const 8)
          )
          (i32.load
           (get_local $9)
          )
         )
         (i32.store
          (get_local $10)
          (i32.load
           (i32.add
            (get_local $14)
            (i32.const 12)
           )
          )
         )
         (i32.store
          (get_local $3)
          (i32.load offset=8
           (get_local $14)
          )
         )
         (i64.store offset=8
          (get_local $22)
          (get_local $6)
         )
         (drop
          (call $_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC2ERKS5_
           (get_local $4)
           (i32.add
            (get_local $14)
            (i32.const 24)
           )
          )
         )
         (i64.store
          (i32.add
           (i32.add
            (get_local $22)
            (i32.const 56)
           )
           (i32.const 8)
          )
          (get_local $21)
         )
         (i64.store
          (tee_local $7
           (i32.add
            (i32.add
             (get_local $22)
             (i32.const 56)
            )
            (i32.const 16)
           )
          )
          (i64.const 0)
         )
         (i32.store
          (tee_local $11
           (i32.add
            (i32.add
             (get_local $22)
             (i32.const 56)
            )
            (i32.const 24)
           )
          )
          (i32.const 0)
         )
         (i64.store offset=56
          (get_local $22)
          (get_local $20)
         )
         (i32.store
          (get_local $7)
          (tee_local $15
           (call $_Znwj
            (i32.const 16)
           )
          )
         )
         (i64.store
          (get_local $15)
          (get_local $6)
         )
         (i64.store offset=8
          (get_local $15)
          (get_local $18)
         )
         (i32.store
          (get_local $5)
          (i32.const 0)
         )
         (i32.store
          (tee_local $9
           (i32.add
            (i32.add
             (get_local $22)
             (i32.const 56)
            )
            (i32.const 32)
           )
          )
          (i32.const 0)
         )
         (i32.store
          (get_local $11)
          (tee_local $15
           (i32.add
            (get_local $15)
            (i32.const 16)
           )
          )
         )
         (i32.store
          (tee_local $12
           (i32.add
            (i32.add
             (get_local $22)
             (i32.const 56)
            )
            (i32.const 20)
           )
          )
          (get_local $15)
         )
         (i32.store
          (i32.add
           (i32.add
            (get_local $22)
            (i32.const 56)
           )
           (i32.const 36)
          )
          (i32.const 0)
         )
         (set_local $15
          (i32.add
           (tee_local $11
            (select
             (i32.load
              (i32.add
               (i32.add
                (get_local $22)
                (i32.const 8)
               )
               (i32.const 36)
              )
             )
             (i32.shr_u
              (tee_local $15
               (i32.load8_u
                (get_local $4)
               )
              )
              (i32.const 1)
             )
             (i32.and
              (get_local $15)
              (i32.const 1)
             )
            )
           )
           (i32.const 32)
          )
         )
         (set_local $17
          (i64.extend_u/i32
           (get_local $11)
          )
         )
         (loop $label$45
          (set_local $15
           (i32.add
            (get_local $15)
            (i32.const 1)
           )
          )
          (br_if $label$45
           (i64.ne
            (tee_local $17
             (i64.shr_u
              (get_local $17)
              (i64.const 7)
             )
            )
            (i64.const 0)
           )
          )
         )
         (br_if $label$4
          (i32.eqz
           (get_local $15)
          )
         )
         (call $_ZNSt3__16vectorIcNS_9allocatorIcEEE8__appendEj
          (get_local $5)
          (get_local $15)
         )
         (set_local $11
          (i32.load
           (get_local $9)
          )
         )
         (set_local $15
          (i32.load
           (get_local $5)
          )
         )
         (br $label$3)
        )
        (set_local $11
         (i32.const 0)
        )
        (set_local $15
         (i32.const 0)
        )
       )
       (i32.store
        (i32.add
         (i32.add
          (get_local $22)
          (i32.const 96)
         )
         (i32.const 8)
        )
        (get_local $11)
       )
       (i32.store offset=100
        (get_local $22)
        (get_local $15)
       )
       (i32.store offset=96
        (get_local $22)
        (get_local $15)
       )
       (i32.store offset=112
        (get_local $22)
        (i32.add
         (get_local $22)
         (i32.const 96)
        )
       )
       (i32.store offset=120
        (get_local $22)
        (i32.add
         (get_local $22)
         (i32.const 8)
        )
       )
       (call $_ZN5boost6fusion6detail17for_each_unrolledILi4EE4callINS0_18std_tuple_iteratorIKNSt3__15tupleIJyN5eosio4nameENS8_5assetENS6_12basic_stringIcNS6_11char_traitsIcEENS6_9allocatorIcEEEEEEELi0EEEZNS8_lsINS8_10datastreamIPcEEJyS9_SA_SG_EEERT_SP_RKNS7_IJDpT0_EEEEUlRKSO_E_EEvSW_RKT0_
        (i32.add
         (get_local $22)
         (i32.const 120)
        )
        (i32.add
         (get_local $22)
         (i32.const 112)
        )
       )
       (call $_ZN5eosio4packINS_6actionEEENSt3__16vectorIcNS2_9allocatorIcEEEERKT_
        (i32.add
         (get_local $22)
         (i32.const 96)
        )
        (i32.add
         (get_local $22)
         (i32.const 56)
        )
       )
       (call $send_inline
        (tee_local $15
         (i32.load offset=96
          (get_local $22)
         )
        )
        (i32.sub
         (i32.load offset=100
          (get_local $22)
         )
         (get_local $15)
        )
       )
       (block $label$46
        (br_if $label$46
         (i32.eqz
          (tee_local $15
           (i32.load offset=96
            (get_local $22)
           )
          )
         )
        )
        (i32.store offset=100
         (get_local $22)
         (get_local $15)
        )
        (call $_ZdlPv
         (get_local $15)
        )
       )
       (block $label$47
        (br_if $label$47
         (i32.eqz
          (tee_local $15
           (i32.load
            (get_local $5)
           )
          )
         )
        )
        (i32.store
         (get_local $9)
         (get_local $15)
        )
        (call $_ZdlPv
         (get_local $15)
        )
       )
       (block $label$48
        (br_if $label$48
         (i32.eqz
          (tee_local $15
           (i32.load
            (get_local $7)
           )
          )
         )
        )
        (i32.store
         (get_local $12)
         (get_local $15)
        )
        (call $_ZdlPv
         (get_local $15)
        )
       )
       (br_if $label$2
        (i32.eqz
         (i32.and
          (i32.load8_u
           (get_local $4)
          )
          (i32.const 1)
         )
        )
       )
       (call $_ZdlPv
        (i32.load
         (get_local $13)
        )
       )
       (br $label$2)
      )
      (set_local $11
       (i32.const 0)
      )
      (set_local $15
       (i32.const 0)
      )
     )
     (i32.store
      (i32.add
       (i32.add
        (get_local $22)
        (i32.const 96)
       )
       (i32.const 8)
      )
      (get_local $11)
     )
     (i32.store offset=100
      (get_local $22)
      (get_local $15)
     )
     (i32.store offset=96
      (get_local $22)
      (get_local $15)
     )
     (i32.store offset=112
      (get_local $22)
      (i32.add
       (get_local $22)
       (i32.const 96)
      )
     )
     (i32.store offset=120
      (get_local $22)
      (i32.add
       (get_local $22)
       (i32.const 8)
      )
     )
     (call $_ZN5boost6fusion6detail17for_each_unrolledILi4EE4callINS0_18std_tuple_iteratorIKNSt3__15tupleIJyN5eosio4nameENS8_5assetENS6_12basic_stringIcNS6_11char_traitsIcEENS6_9allocatorIcEEEEEEELi0EEEZNS8_lsINS8_10datastreamIPcEEJyS9_SA_SG_EEERT_SP_RKNS7_IJDpT0_EEEEUlRKSO_E_EEvSW_RKT0_
      (i32.add
       (get_local $22)
       (i32.const 120)
      )
      (i32.add
       (get_local $22)
       (i32.const 112)
      )
     )
     (call $_ZN5eosio4packINS_6actionEEENSt3__16vectorIcNS2_9allocatorIcEEEERKT_
      (i32.add
       (get_local $22)
       (i32.const 96)
      )
      (i32.add
       (get_local $22)
       (i32.const 56)
      )
     )
     (call $send_inline
      (tee_local $15
       (i32.load offset=96
        (get_local $22)
       )
      )
      (i32.sub
       (i32.load offset=100
        (get_local $22)
       )
       (get_local $15)
      )
     )
     (block $label$49
      (br_if $label$49
       (i32.eqz
        (tee_local $15
         (i32.load offset=96
          (get_local $22)
         )
        )
       )
      )
      (i32.store offset=100
       (get_local $22)
       (get_local $15)
      )
      (call $_ZdlPv
       (get_local $15)
      )
     )
     (block $label$50
      (br_if $label$50
       (i32.eqz
        (tee_local $15
         (i32.load
          (get_local $5)
         )
        )
       )
      )
      (i32.store
       (get_local $9)
       (get_local $15)
      )
      (call $_ZdlPv
       (get_local $15)
      )
     )
     (block $label$51
      (br_if $label$51
       (i32.eqz
        (tee_local $15
         (i32.load
          (get_local $7)
         )
        )
       )
      )
      (i32.store
       (get_local $12)
       (get_local $15)
      )
      (call $_ZdlPv
       (get_local $15)
      )
     )
     (br_if $label$2
      (i32.eqz
       (i32.and
        (i32.load8_u
         (get_local $4)
        )
        (i32.const 1)
       )
      )
     )
     (call $_ZdlPv
      (i32.load
       (get_local $13)
      )
     )
    )
    (set_local $15
     (i32.const 0)
    )
    (call $eosio_assert
     (tee_local $7
      (i32.ne
       (get_local $14)
       (i32.const 0)
      )
     )
     (i32.const 176)
    )
    (call $eosio_assert
     (get_local $7)
     (i32.const 224)
    )
    (block $label$52
     (br_if $label$52
      (i32.lt_s
       (tee_local $7
        (call $db_next_i64
         (i32.load offset=40
          (get_local $14)
         )
         (i32.add
          (get_local $22)
          (i32.const 8)
         )
        )
       )
       (i32.const 0)
      )
     )
     (set_local $15
      (call $_ZNK5eosio11multi_indexILy12296682192053436416E3payJEE31load_object_by_primary_iteratorEl
       (get_local $2)
       (get_local $7)
      )
     )
    )
    (call $_ZN5eosio11multi_indexILy12296682192053436416E3payJEE5eraseERKS1_
     (get_local $2)
     (get_local $14)
    )
    (set_local $14
     (get_local $15)
    )
    (br_if $label$1
     (get_local $15)
    )
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $22)
    (i32.const 128)
   )
  )
 )
 (func $_ZN12daccustodianD2Ev (param $0 i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (block $label$0
   (br_if $label$0
    (i32.eqz
     (tee_local $3
      (i32.load
       (i32.add
        (get_local $0)
        (i32.const 232)
       )
      )
     )
    )
   )
   (block $label$1
    (block $label$2
     (br_if $label$2
      (i32.eq
       (tee_local $5
        (i32.load
         (tee_local $2
          (i32.add
           (get_local $0)
           (i32.const 236)
          )
         )
        )
       )
       (get_local $3)
      )
     )
     (loop $label$3
      (set_local $1
       (i32.load
        (tee_local $5
         (i32.add
          (get_local $5)
          (i32.const -24)
         )
        )
       )
      )
      (i32.store
       (get_local $5)
       (i32.const 0)
      )
      (block $label$4
       (br_if $label$4
        (i32.eqz
         (get_local $1)
        )
       )
       (block $label$5
        (br_if $label$5
         (i32.eqz
          (i32.and
           (i32.load8_u offset=12
            (get_local $1)
           )
           (i32.const 1)
          )
         )
        )
        (call $_ZdlPv
         (i32.load
          (i32.add
           (get_local $1)
           (i32.const 20)
          )
         )
        )
       )
       (block $label$6
        (br_if $label$6
         (i32.eqz
          (i32.and
           (i32.load8_u
            (get_local $1)
           )
           (i32.const 1)
          )
         )
        )
        (call $_ZdlPv
         (i32.load offset=8
          (get_local $1)
         )
        )
       )
       (call $_ZdlPv
        (get_local $1)
       )
      )
      (br_if $label$3
       (i32.ne
        (get_local $3)
        (get_local $5)
       )
      )
     )
     (set_local $1
      (i32.load
       (i32.add
        (get_local $0)
        (i32.const 232)
       )
      )
     )
     (br $label$1)
    )
    (set_local $1
     (get_local $3)
    )
   )
   (i32.store
    (get_local $2)
    (get_local $3)
   )
   (call $_ZdlPv
    (get_local $1)
   )
  )
  (block $label$7
   (br_if $label$7
    (i32.eqz
     (tee_local $3
      (i32.load
       (i32.add
        (get_local $0)
        (i32.const 192)
       )
      )
     )
    )
   )
   (block $label$8
    (block $label$9
     (br_if $label$9
      (i32.eq
       (tee_local $1
        (i32.load
         (tee_local $2
          (i32.add
           (get_local $0)
           (i32.const 196)
          )
         )
        )
       )
       (get_local $3)
      )
     )
     (loop $label$10
      (set_local $5
       (i32.load
        (tee_local $1
         (i32.add
          (get_local $1)
          (i32.const -24)
         )
        )
       )
      )
      (i32.store
       (get_local $1)
       (i32.const 0)
      )
      (block $label$11
       (br_if $label$11
        (i32.eqz
         (get_local $5)
        )
       )
       (call $_ZdlPv
        (get_local $5)
       )
      )
      (br_if $label$10
       (i32.ne
        (get_local $3)
        (get_local $1)
       )
      )
     )
     (set_local $1
      (i32.load
       (i32.add
        (get_local $0)
        (i32.const 192)
       )
      )
     )
     (br $label$8)
    )
    (set_local $1
     (get_local $3)
    )
   )
   (i32.store
    (get_local $2)
    (get_local $3)
   )
   (call $_ZdlPv
    (get_local $1)
   )
  )
  (block $label$12
   (br_if $label$12
    (i32.eqz
     (tee_local $3
      (i32.load
       (i32.add
        (get_local $0)
        (i32.const 152)
       )
      )
     )
    )
   )
   (block $label$13
    (block $label$14
     (br_if $label$14
      (i32.eq
       (tee_local $1
        (i32.load
         (tee_local $2
          (i32.add
           (get_local $0)
           (i32.const 156)
          )
         )
        )
       )
       (get_local $3)
      )
     )
     (loop $label$15
      (set_local $5
       (i32.load
        (tee_local $1
         (i32.add
          (get_local $1)
          (i32.const -24)
         )
        )
       )
      )
      (i32.store
       (get_local $1)
       (i32.const 0)
      )
      (block $label$16
       (br_if $label$16
        (i32.eqz
         (get_local $5)
        )
       )
       (block $label$17
        (br_if $label$17
         (i32.eqz
          (i32.and
           (i32.load8_u offset=24
            (get_local $5)
           )
           (i32.const 1)
          )
         )
        )
        (call $_ZdlPv
         (i32.load
          (i32.add
           (get_local $5)
           (i32.const 32)
          )
         )
        )
       )
       (call $_ZdlPv
        (get_local $5)
       )
      )
      (br_if $label$15
       (i32.ne
        (get_local $3)
        (get_local $1)
       )
      )
     )
     (set_local $1
      (i32.load
       (i32.add
        (get_local $0)
        (i32.const 152)
       )
      )
     )
     (br $label$13)
    )
    (set_local $1
     (get_local $3)
    )
   )
   (i32.store
    (get_local $2)
    (get_local $3)
   )
   (call $_ZdlPv
    (get_local $1)
   )
  )
  (block $label$18
   (br_if $label$18
    (i32.eqz
     (tee_local $2
      (i32.load
       (i32.add
        (get_local $0)
        (i32.const 112)
       )
      )
     )
    )
   )
   (block $label$19
    (block $label$20
     (br_if $label$20
      (i32.eq
       (tee_local $1
        (i32.load
         (tee_local $4
          (i32.add
           (get_local $0)
           (i32.const 116)
          )
         )
        )
       )
       (get_local $2)
      )
     )
     (loop $label$21
      (set_local $5
       (i32.load
        (tee_local $1
         (i32.add
          (get_local $1)
          (i32.const -24)
         )
        )
       )
      )
      (i32.store
       (get_local $1)
       (i32.const 0)
      )
      (block $label$22
       (br_if $label$22
        (i32.eqz
         (get_local $5)
        )
       )
       (block $label$23
        (br_if $label$23
         (i32.eqz
          (tee_local $3
           (i32.load offset=24
            (get_local $5)
           )
          )
         )
        )
        (i32.store
         (i32.add
          (get_local $5)
          (i32.const 28)
         )
         (get_local $3)
        )
        (call $_ZdlPv
         (get_local $3)
        )
       )
       (call $_ZdlPv
        (get_local $5)
       )
      )
      (br_if $label$21
       (i32.ne
        (get_local $2)
        (get_local $1)
       )
      )
     )
     (set_local $1
      (i32.load
       (i32.add
        (get_local $0)
        (i32.const 112)
       )
      )
     )
     (br $label$19)
    )
    (set_local $1
     (get_local $2)
    )
   )
   (i32.store
    (get_local $4)
    (get_local $2)
   )
   (call $_ZdlPv
    (get_local $1)
   )
  )
  (block $label$24
   (br_if $label$24
    (i32.eqz
     (tee_local $3
      (i32.load
       (i32.add
        (get_local $0)
        (i32.const 72)
       )
      )
     )
    )
   )
   (block $label$25
    (block $label$26
     (br_if $label$26
      (i32.eq
       (tee_local $1
        (i32.load
         (tee_local $2
          (i32.add
           (get_local $0)
           (i32.const 76)
          )
         )
        )
       )
       (get_local $3)
      )
     )
     (loop $label$27
      (set_local $5
       (i32.load
        (tee_local $1
         (i32.add
          (get_local $1)
          (i32.const -24)
         )
        )
       )
      )
      (i32.store
       (get_local $1)
       (i32.const 0)
      )
      (block $label$28
       (br_if $label$28
        (i32.eqz
         (get_local $5)
        )
       )
       (block $label$29
        (br_if $label$29
         (i32.eqz
          (i32.and
           (i32.load8_u offset=8
            (get_local $5)
           )
           (i32.const 1)
          )
         )
        )
        (call $_ZdlPv
         (i32.load
          (i32.add
           (get_local $5)
           (i32.const 16)
          )
         )
        )
       )
       (call $_ZdlPv
        (get_local $5)
       )
      )
      (br_if $label$27
       (i32.ne
        (get_local $3)
        (get_local $1)
       )
      )
     )
     (set_local $1
      (i32.load
       (i32.add
        (get_local $0)
        (i32.const 72)
       )
      )
     )
     (br $label$25)
    )
    (set_local $1
     (get_local $3)
    )
   )
   (i32.store
    (get_local $2)
    (get_local $3)
   )
   (call $_ZdlPv
    (get_local $1)
   )
  )
  (block $label$30
   (br_if $label$30
    (i32.eqz
     (tee_local $3
      (i32.load
       (i32.add
        (get_local $0)
        (i32.const 32)
       )
      )
     )
    )
   )
   (block $label$31
    (block $label$32
     (br_if $label$32
      (i32.eq
       (tee_local $1
        (i32.load
         (tee_local $2
          (i32.add
           (get_local $0)
           (i32.const 36)
          )
         )
        )
       )
       (get_local $3)
      )
     )
     (loop $label$33
      (set_local $5
       (i32.load
        (tee_local $1
         (i32.add
          (get_local $1)
          (i32.const -24)
         )
        )
       )
      )
      (i32.store
       (get_local $1)
       (i32.const 0)
      )
      (block $label$34
       (br_if $label$34
        (i32.eqz
         (get_local $5)
        )
       )
       (call $_ZdlPv
        (get_local $5)
       )
      )
      (br_if $label$33
       (i32.ne
        (get_local $3)
        (get_local $1)
       )
      )
     )
     (set_local $1
      (i32.load
       (i32.add
        (get_local $0)
        (i32.const 32)
       )
      )
     )
     (br $label$31)
    )
    (set_local $1
     (get_local $3)
    )
   )
   (i32.store
    (get_local $2)
    (get_local $3)
   )
   (call $_ZdlPv
    (get_local $1)
   )
  )
  (get_local $0)
 )
 (func $_ZNK5eosio11multi_indexILy12296682192053436416E3payJEE31load_object_by_primary_iteratorEl (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i64)
  (local $6 i32)
  (local $7 i32)
  (local $8 i32)
  (local $9 i32)
  (i32.store offset=4
   (i32.const 0)
   (tee_local $9
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 48)
    )
   )
  )
  (i32.store offset=44
   (tee_local $8
    (get_local $9)
   )
   (get_local $1)
  )
  (block $label$0
   (br_if $label$0
    (i32.eq
     (tee_local $7
      (i32.load
       (i32.add
        (get_local $0)
        (i32.const 28)
       )
      )
     )
     (tee_local $2
      (i32.load offset=24
       (get_local $0)
      )
     )
    )
   )
   (set_local $3
    (i32.sub
     (i32.const 0)
     (get_local $2)
    )
   )
   (set_local $6
    (i32.add
     (get_local $7)
     (i32.const -24)
    )
   )
   (loop $label$1
    (br_if $label$0
     (i32.eq
      (i32.load
       (i32.add
        (get_local $6)
        (i32.const 16)
       )
      )
      (get_local $1)
     )
    )
    (set_local $7
     (get_local $6)
    )
    (set_local $6
     (tee_local $4
      (i32.add
       (get_local $6)
       (i32.const -24)
      )
     )
    )
    (br_if $label$1
     (i32.ne
      (i32.add
       (get_local $4)
       (get_local $3)
      )
      (i32.const -24)
     )
    )
   )
  )
  (block $label$2
   (block $label$3
    (br_if $label$3
     (i32.eq
      (get_local $7)
      (get_local $2)
     )
    )
    (set_local $6
     (i32.load
      (i32.add
       (get_local $7)
       (i32.const -24)
      )
     )
    )
    (br $label$2)
   )
   (call $eosio_assert
    (i32.xor
     (i32.shr_u
      (tee_local $6
       (call $db_get_i64
        (get_local $1)
        (i32.const 0)
        (i32.const 0)
       )
      )
      (i32.const 31)
     )
     (i32.const 1)
    )
    (i32.const 448)
   )
   (block $label$4
    (block $label$5
     (br_if $label$5
      (i32.lt_u
       (get_local $6)
       (i32.const 513)
      )
     )
     (set_local $4
      (call $malloc
       (get_local $6)
      )
     )
     (br $label$4)
    )
    (i32.store offset=4
     (i32.const 0)
     (tee_local $4
      (i32.sub
       (get_local $9)
       (i32.and
        (i32.add
         (get_local $6)
         (i32.const 15)
        )
        (i32.const -16)
       )
      )
     )
    )
   )
   (drop
    (call $db_get_i64
     (get_local $1)
     (get_local $4)
     (get_local $6)
    )
   )
   (i32.store offset=36
    (get_local $8)
    (get_local $4)
   )
   (i32.store offset=32
    (get_local $8)
    (get_local $4)
   )
   (i32.store offset=40
    (get_local $8)
    (i32.add
     (get_local $4)
     (get_local $6)
    )
   )
   (block $label$6
    (br_if $label$6
     (i32.lt_u
      (get_local $6)
      (i32.const 513)
     )
    )
    (call $free
     (get_local $4)
    )
   )
   (i32.store offset=12
    (get_local $8)
    (i32.add
     (get_local $8)
     (i32.const 32)
    )
   )
   (i32.store offset=16
    (get_local $8)
    (i32.add
     (get_local $8)
     (i32.const 44)
    )
   )
   (i32.store offset=8
    (get_local $8)
    (get_local $0)
   )
   (set_local $6
    (call $_ZN5eosio11multi_indexILy12296682192053436416E3payJEE4itemC2IZNKS2_31load_object_by_primary_iteratorElEUlRT_E_EEPKS2_OS5_
     (tee_local $4
      (call $_Znwj
       (i32.const 48)
      )
     )
     (get_local $0)
     (i32.add
      (get_local $8)
      (i32.const 8)
     )
    )
   )
   (i32.store offset=24
    (get_local $8)
    (get_local $4)
   )
   (i64.store offset=8
    (get_local $8)
    (tee_local $5
     (i64.load
      (get_local $4)
     )
    )
   )
   (i32.store offset=4
    (get_local $8)
    (tee_local $1
     (i32.load offset=40
      (get_local $4)
     )
    )
   )
   (block $label$7
    (block $label$8
     (br_if $label$8
      (i32.ge_u
       (tee_local $7
        (i32.load
         (tee_local $3
          (i32.add
           (get_local $0)
           (i32.const 28)
          )
         )
        )
       )
       (i32.load
        (i32.add
         (get_local $0)
         (i32.const 32)
        )
       )
      )
     )
     (i64.store offset=8
      (get_local $7)
      (get_local $5)
     )
     (i32.store offset=16
      (get_local $7)
      (get_local $1)
     )
     (i32.store offset=24
      (get_local $8)
      (i32.const 0)
     )
     (i32.store
      (get_local $7)
      (get_local $4)
     )
     (i32.store
      (get_local $3)
      (i32.add
       (get_local $7)
       (i32.const 24)
      )
     )
     (br $label$7)
    )
    (call $_ZNSt3__16vectorIN5eosio11multi_indexILy12296682192053436416E3payJEE8item_ptrENS_9allocatorIS5_EEE24__emplace_back_slow_pathIJNS_10unique_ptrINS4_4itemENS_14default_deleteISB_EEEERyRlEEEvDpOT_
     (i32.add
      (get_local $0)
      (i32.const 24)
     )
     (i32.add
      (get_local $8)
      (i32.const 24)
     )
     (i32.add
      (get_local $8)
      (i32.const 8)
     )
     (i32.add
      (get_local $8)
      (i32.const 4)
     )
    )
   )
   (set_local $4
    (i32.load offset=24
     (get_local $8)
    )
   )
   (i32.store offset=24
    (get_local $8)
    (i32.const 0)
   )
   (br_if $label$2
    (i32.eqz
     (get_local $4)
    )
   )
   (block $label$9
    (br_if $label$9
     (i32.eqz
      (i32.and
       (i32.load8_u offset=24
        (get_local $4)
       )
       (i32.const 1)
      )
     )
    )
    (call $_ZdlPv
     (i32.load
      (i32.add
       (get_local $4)
       (i32.const 32)
      )
     )
    )
   )
   (call $_ZdlPv
    (get_local $4)
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $8)
    (i32.const 48)
   )
  )
  (get_local $6)
 )
 (func $_ZNSt3__16vectorIcNS_9allocatorIcEEE8__appendEj (param $0 i32) (param $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (block $label$0
   (block $label$1
    (block $label$2
     (block $label$3
      (block $label$4
       (br_if $label$4
        (i32.ge_u
         (i32.sub
          (tee_local $2
           (i32.load offset=8
            (get_local $0)
           )
          )
          (tee_local $6
           (i32.load offset=4
            (get_local $0)
           )
          )
         )
         (get_local $1)
        )
       )
       (br_if $label$2
        (i32.le_s
         (tee_local $4
          (i32.add
           (tee_local $3
            (i32.sub
             (get_local $6)
             (tee_local $5
              (i32.load
               (get_local $0)
              )
             )
            )
           )
           (get_local $1)
          )
         )
         (i32.const -1)
        )
       )
       (set_local $6
        (i32.const 2147483647)
       )
       (block $label$5
        (br_if $label$5
         (i32.gt_u
          (tee_local $2
           (i32.sub
            (get_local $2)
            (get_local $5)
           )
          )
          (i32.const 1073741822)
         )
        )
        (br_if $label$3
         (i32.eqz
          (tee_local $6
           (select
            (get_local $4)
            (tee_local $6
             (i32.shl
              (get_local $2)
              (i32.const 1)
             )
            )
            (i32.lt_u
             (get_local $6)
             (get_local $4)
            )
           )
          )
         )
        )
       )
       (set_local $2
        (call $_Znwj
         (get_local $6)
        )
       )
       (br $label$1)
      )
      (set_local $0
       (i32.add
        (get_local $0)
        (i32.const 4)
       )
      )
      (loop $label$6
       (i32.store8
        (get_local $6)
        (i32.const 0)
       )
       (i32.store
        (get_local $0)
        (tee_local $6
         (i32.add
          (i32.load
           (get_local $0)
          )
          (i32.const 1)
         )
        )
       )
       (br_if $label$6
        (tee_local $1
         (i32.add
          (get_local $1)
          (i32.const -1)
         )
        )
       )
       (br $label$0)
      )
     )
     (set_local $6
      (i32.const 0)
     )
     (set_local $2
      (i32.const 0)
     )
     (br $label$1)
    )
    (call $_ZNKSt3__120__vector_base_commonILb1EE20__throw_length_errorEv
     (get_local $0)
    )
    (unreachable)
   )
   (set_local $4
    (i32.add
     (get_local $2)
     (get_local $6)
    )
   )
   (set_local $6
    (tee_local $5
     (i32.add
      (get_local $2)
      (get_local $3)
     )
    )
   )
   (loop $label$7
    (i32.store8
     (get_local $6)
     (i32.const 0)
    )
    (set_local $6
     (i32.add
      (get_local $6)
      (i32.const 1)
     )
    )
    (br_if $label$7
     (tee_local $1
      (i32.add
       (get_local $1)
       (i32.const -1)
      )
     )
    )
   )
   (set_local $5
    (i32.sub
     (get_local $5)
     (tee_local $2
      (i32.sub
       (i32.load
        (tee_local $3
         (i32.add
          (get_local $0)
          (i32.const 4)
         )
        )
       )
       (tee_local $1
        (i32.load
         (get_local $0)
        )
       )
      )
     )
    )
   )
   (block $label$8
    (br_if $label$8
     (i32.lt_s
      (get_local $2)
      (i32.const 1)
     )
    )
    (drop
     (call $memcpy
      (get_local $5)
      (get_local $1)
      (get_local $2)
     )
    )
    (set_local $1
     (i32.load
      (get_local $0)
     )
    )
   )
   (i32.store
    (get_local $0)
    (get_local $5)
   )
   (i32.store
    (get_local $3)
    (get_local $6)
   )
   (i32.store
    (i32.add
     (get_local $0)
     (i32.const 8)
    )
    (get_local $4)
   )
   (br_if $label$0
    (i32.eqz
     (get_local $1)
    )
   )
   (call $_ZdlPv
    (get_local $1)
   )
   (return)
  )
 )
 (func $_ZN5boost6fusion6detail17for_each_unrolledILi4EE4callINS0_18std_tuple_iteratorIKNSt3__15tupleIJyN5eosio4nameENS8_5assetENS6_12basic_stringIcNS6_11char_traitsIcEENS6_9allocatorIcEEEEEEELi0EEEZNS8_lsINS8_10datastreamIPcEEJyS9_SA_SG_EEERT_SP_RKNS7_IJDpT0_EEEEUlRKSO_E_EEvSW_RKT0_ (param $0 i32) (param $1 i32)
  (local $2 i32)
  (local $3 i32)
  (set_local $2
   (i32.load
    (get_local $0)
   )
  )
  (call $eosio_assert
   (i32.gt_s
    (i32.sub
     (i32.load offset=8
      (tee_local $3
       (i32.load
        (get_local $1)
       )
      )
     )
     (i32.load offset=4
      (get_local $3)
     )
    )
    (i32.const 7)
   )
   (i32.const 432)
  )
  (drop
   (call $memcpy
    (i32.load offset=4
     (get_local $3)
    )
    (get_local $2)
    (i32.const 8)
   )
  )
  (i32.store offset=4
   (get_local $3)
   (i32.add
    (i32.load offset=4
     (get_local $3)
    )
    (i32.const 8)
   )
  )
  (set_local $0
   (i32.load
    (get_local $0)
   )
  )
  (call $eosio_assert
   (i32.gt_s
    (i32.sub
     (i32.load offset=8
      (tee_local $3
       (i32.load
        (get_local $1)
       )
      )
     )
     (i32.load offset=4
      (get_local $3)
     )
    )
    (i32.const 7)
   )
   (i32.const 432)
  )
  (drop
   (call $memcpy
    (i32.load offset=4
     (get_local $3)
    )
    (i32.add
     (get_local $0)
     (i32.const 8)
    )
    (i32.const 8)
   )
  )
  (i32.store offset=4
   (get_local $3)
   (i32.add
    (i32.load offset=4
     (get_local $3)
    )
    (i32.const 8)
   )
  )
  (call $eosio_assert
   (i32.gt_s
    (i32.sub
     (i32.load offset=8
      (tee_local $3
       (i32.load
        (get_local $1)
       )
      )
     )
     (i32.load offset=4
      (get_local $3)
     )
    )
    (i32.const 7)
   )
   (i32.const 432)
  )
  (drop
   (call $memcpy
    (i32.load offset=4
     (get_local $3)
    )
    (i32.add
     (get_local $0)
     (i32.const 16)
    )
    (i32.const 8)
   )
  )
  (i32.store offset=4
   (get_local $3)
   (tee_local $2
    (i32.add
     (i32.load offset=4
      (get_local $3)
     )
     (i32.const 8)
    )
   )
  )
  (call $eosio_assert
   (i32.gt_s
    (i32.sub
     (i32.load offset=8
      (get_local $3)
     )
     (get_local $2)
    )
    (i32.const 7)
   )
   (i32.const 432)
  )
  (drop
   (call $memcpy
    (i32.load offset=4
     (get_local $3)
    )
    (i32.add
     (get_local $0)
     (i32.const 24)
    )
    (i32.const 8)
   )
  )
  (i32.store offset=4
   (get_local $3)
   (i32.add
    (i32.load offset=4
     (get_local $3)
    )
    (i32.const 8)
   )
  )
  (drop
   (call $_ZN5eosiolsINS_10datastreamIPcEEEERT_S5_RKNSt3__112basic_stringIcNS6_11char_traitsIcEENS6_9allocatorIcEEEE
    (i32.load
     (get_local $1)
    )
    (i32.add
     (get_local $0)
     (i32.const 32)
    )
   )
  )
 )
 (func $_ZN5eosio4packINS_6actionEEENSt3__16vectorIcNS2_9allocatorIcEEEERKT_ (param $0 i32) (param $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i64)
  (local $7 i32)
  (local $8 i32)
  (i32.store offset=4
   (i32.const 0)
   (tee_local $8
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 16)
    )
   )
  )
  (i32.store offset=8
   (get_local $0)
   (i32.const 0)
  )
  (i64.store align=4
   (get_local $0)
   (i64.const 0)
  )
  (set_local $5
   (i32.const 16)
  )
  (set_local $2
   (i32.add
    (get_local $1)
    (i32.const 16)
   )
  )
  (set_local $6
   (i64.extend_u/i32
    (i32.shr_s
     (tee_local $4
      (i32.sub
       (tee_local $7
        (i32.load
         (i32.add
          (get_local $1)
          (i32.const 20)
         )
        )
       )
       (tee_local $3
        (i32.load offset=16
         (get_local $1)
        )
       )
      )
     )
     (i32.const 4)
    )
   )
  )
  (loop $label$0
   (set_local $5
    (i32.add
     (get_local $5)
     (i32.const 1)
    )
   )
   (br_if $label$0
    (i64.ne
     (tee_local $6
      (i64.shr_u
       (get_local $6)
       (i64.const 7)
      )
     )
     (i64.const 0)
    )
   )
  )
  (block $label$1
   (br_if $label$1
    (i32.eq
     (get_local $3)
     (get_local $7)
    )
   )
   (set_local $5
    (i32.add
     (i32.and
      (get_local $4)
      (i32.const -16)
     )
     (get_local $5)
    )
   )
  )
  (set_local $5
   (i32.sub
    (i32.sub
     (tee_local $7
      (i32.load offset=28
       (get_local $1)
      )
     )
     (get_local $5)
    )
    (tee_local $3
     (i32.load
      (i32.add
       (get_local $1)
       (i32.const 32)
      )
     )
    )
   )
  )
  (set_local $4
   (i32.add
    (get_local $1)
    (i32.const 28)
   )
  )
  (set_local $6
   (i64.extend_u/i32
    (i32.sub
     (get_local $3)
     (get_local $7)
    )
   )
  )
  (loop $label$2
   (set_local $5
    (i32.add
     (get_local $5)
     (i32.const -1)
    )
   )
   (br_if $label$2
    (i64.ne
     (tee_local $6
      (i64.shr_u
       (get_local $6)
       (i64.const 7)
      )
     )
     (i64.const 0)
    )
   )
  )
  (set_local $7
   (i32.const 0)
  )
  (block $label$3
   (block $label$4
    (br_if $label$4
     (i32.eqz
      (get_local $5)
     )
    )
    (call $_ZNSt3__16vectorIcNS_9allocatorIcEEE8__appendEj
     (get_local $0)
     (i32.sub
      (i32.const 0)
      (get_local $5)
     )
    )
    (set_local $7
     (i32.load
      (i32.add
       (get_local $0)
       (i32.const 4)
      )
     )
    )
    (set_local $5
     (i32.load
      (get_local $0)
     )
    )
    (br $label$3)
   )
   (set_local $5
    (i32.const 0)
   )
  )
  (i32.store
   (get_local $8)
   (get_local $5)
  )
  (i32.store offset=8
   (get_local $8)
   (get_local $7)
  )
  (call $eosio_assert
   (i32.gt_s
    (i32.sub
     (get_local $7)
     (get_local $5)
    )
    (i32.const 7)
   )
   (i32.const 432)
  )
  (drop
   (call $memcpy
    (get_local $5)
    (get_local $1)
    (i32.const 8)
   )
  )
  (call $eosio_assert
   (i32.gt_s
    (i32.sub
     (get_local $7)
     (tee_local $0
      (i32.add
       (get_local $5)
       (i32.const 8)
      )
     )
    )
    (i32.const 7)
   )
   (i32.const 432)
  )
  (drop
   (call $memcpy
    (get_local $0)
    (i32.add
     (get_local $1)
     (i32.const 8)
    )
    (i32.const 8)
   )
  )
  (i32.store offset=4
   (get_local $8)
   (i32.add
    (get_local $5)
    (i32.const 16)
   )
  )
  (drop
   (call $_ZN5eosiolsINS_10datastreamIPcEEEERT_S5_RKNSt3__16vectorIcNS6_9allocatorIcEEEE
    (call $_ZN5eosiolsINS_10datastreamIPcEENS_16permission_levelEEERT_S6_RKNSt3__16vectorIT0_NS7_9allocatorIS9_EEEE
     (get_local $8)
     (get_local $2)
    )
    (get_local $4)
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $8)
    (i32.const 16)
   )
  )
 )
 (func $_ZN5eosio11multi_indexILy12296682192053436416E3payJEE5eraseERKS1_ (param $0 i32) (param $1 i32)
  (local $2 i64)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (local $8 i32)
  (call $eosio_assert
   (i32.eq
    (i32.load offset=36
     (get_local $1)
    )
    (get_local $0)
   )
   (i32.const 256)
  )
  (call $eosio_assert
   (i64.eq
    (i64.load
     (get_local $0)
    )
    (call $current_receiver)
   )
   (i32.const 304)
  )
  (block $label$0
   (br_if $label$0
    (i32.eq
     (tee_local $7
      (i32.load
       (tee_local $5
        (i32.add
         (get_local $0)
         (i32.const 28)
        )
       )
      )
     )
     (tee_local $3
      (i32.load offset=24
       (get_local $0)
      )
     )
    )
   )
   (set_local $2
    (i64.load
     (get_local $1)
    )
   )
   (set_local $6
    (i32.sub
     (i32.const 0)
     (get_local $3)
    )
   )
   (set_local $8
    (i32.add
     (get_local $7)
     (i32.const -24)
    )
   )
   (loop $label$1
    (br_if $label$0
     (i64.eq
      (i64.load
       (i32.load
        (get_local $8)
       )
      )
      (get_local $2)
     )
    )
    (set_local $7
     (get_local $8)
    )
    (set_local $8
     (tee_local $4
      (i32.add
       (get_local $8)
       (i32.const -24)
      )
     )
    )
    (br_if $label$1
     (i32.ne
      (i32.add
       (get_local $4)
       (get_local $6)
      )
      (i32.const -24)
     )
    )
   )
  )
  (call $eosio_assert
   (i32.ne
    (get_local $7)
    (get_local $3)
   )
   (i32.const 368)
  )
  (set_local $8
   (i32.add
    (get_local $7)
    (i32.const -24)
   )
  )
  (block $label$2
   (block $label$3
    (br_if $label$3
     (i32.eq
      (get_local $7)
      (tee_local $4
       (i32.load
        (get_local $5)
       )
      )
     )
    )
    (set_local $3
     (i32.sub
      (i32.const 0)
      (get_local $4)
     )
    )
    (set_local $7
     (get_local $8)
    )
    (loop $label$4
     (set_local $6
      (i32.load
       (tee_local $8
        (i32.add
         (get_local $7)
         (i32.const 24)
        )
       )
      )
     )
     (i32.store
      (get_local $8)
      (i32.const 0)
     )
     (set_local $4
      (i32.load
       (get_local $7)
      )
     )
     (i32.store
      (get_local $7)
      (get_local $6)
     )
     (block $label$5
      (br_if $label$5
       (i32.eqz
        (get_local $4)
       )
      )
      (block $label$6
       (br_if $label$6
        (i32.eqz
         (i32.and
          (i32.load8_u offset=24
           (get_local $4)
          )
          (i32.const 1)
         )
        )
       )
       (call $_ZdlPv
        (i32.load
         (i32.add
          (get_local $4)
          (i32.const 32)
         )
        )
       )
      )
      (call $_ZdlPv
       (get_local $4)
      )
     )
     (i32.store
      (i32.add
       (get_local $7)
       (i32.const 16)
      )
      (i32.load
       (i32.add
        (get_local $7)
        (i32.const 40)
       )
      )
     )
     (i64.store
      (i32.add
       (get_local $7)
       (i32.const 8)
      )
      (i64.load
       (i32.add
        (get_local $7)
        (i32.const 32)
       )
      )
     )
     (set_local $7
      (get_local $8)
     )
     (br_if $label$4
      (i32.ne
       (i32.add
        (get_local $8)
        (get_local $3)
       )
       (i32.const -24)
      )
     )
    )
    (br_if $label$2
     (i32.eq
      (tee_local $7
       (i32.load
        (i32.add
         (get_local $0)
         (i32.const 28)
        )
       )
      )
      (get_local $8)
     )
    )
   )
   (loop $label$7
    (set_local $4
     (i32.load
      (tee_local $7
       (i32.add
        (get_local $7)
        (i32.const -24)
       )
      )
     )
    )
    (i32.store
     (get_local $7)
     (i32.const 0)
    )
    (block $label$8
     (br_if $label$8
      (i32.eqz
       (get_local $4)
      )
     )
     (block $label$9
      (br_if $label$9
       (i32.eqz
        (i32.and
         (i32.load8_u offset=24
          (get_local $4)
         )
         (i32.const 1)
        )
       )
      )
      (call $_ZdlPv
       (i32.load
        (i32.add
         (get_local $4)
         (i32.const 32)
        )
       )
      )
     )
     (call $_ZdlPv
      (get_local $4)
     )
    )
    (br_if $label$7
     (i32.ne
      (get_local $8)
      (get_local $7)
     )
    )
   )
  )
  (i32.store
   (i32.add
    (get_local $0)
    (i32.const 28)
   )
   (get_local $8)
  )
  (call $db_remove_i64
   (i32.load offset=40
    (get_local $1)
   )
  )
 )
 (func $_ZN5eosiolsINS_10datastreamIPcEENS_16permission_levelEEERT_S6_RKNSt3__16vectorIT0_NS7_9allocatorIS9_EEEE (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i64)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (i32.store offset=4
   (i32.const 0)
   (tee_local $7
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 16)
    )
   )
  )
  (set_local $4
   (i64.extend_u/i32
    (i32.shr_s
     (i32.sub
      (i32.load offset=4
       (get_local $1)
      )
      (i32.load
       (get_local $1)
      )
     )
     (i32.const 4)
    )
   )
  )
  (set_local $5
   (i32.load offset=4
    (get_local $0)
   )
  )
  (set_local $2
   (i32.add
    (get_local $0)
    (i32.const 8)
   )
  )
  (loop $label$0
   (set_local $3
    (i32.wrap/i64
     (get_local $4)
    )
   )
   (i32.store8 offset=15
    (get_local $7)
    (i32.or
     (i32.shl
      (tee_local $6
       (i64.ne
        (tee_local $4
         (i64.shr_u
          (get_local $4)
          (i64.const 7)
         )
        )
        (i64.const 0)
       )
      )
      (i32.const 7)
     )
     (i32.and
      (get_local $3)
      (i32.const 127)
     )
    )
   )
   (call $eosio_assert
    (i32.gt_s
     (i32.sub
      (i32.load
       (get_local $2)
      )
      (get_local $5)
     )
     (i32.const 0)
    )
    (i32.const 432)
   )
   (drop
    (call $memcpy
     (i32.load
      (tee_local $3
       (i32.add
        (get_local $0)
        (i32.const 4)
       )
      )
     )
     (i32.add
      (get_local $7)
      (i32.const 15)
     )
     (i32.const 1)
    )
   )
   (i32.store
    (get_local $3)
    (tee_local $5
     (i32.add
      (i32.load
       (get_local $3)
      )
      (i32.const 1)
     )
    )
   )
   (br_if $label$0
    (get_local $6)
   )
  )
  (block $label$1
   (br_if $label$1
    (i32.eq
     (tee_local $6
      (i32.load
       (get_local $1)
      )
     )
     (tee_local $1
      (i32.load
       (i32.add
        (get_local $1)
        (i32.const 4)
       )
      )
     )
    )
   )
   (set_local $3
    (i32.add
     (get_local $0)
     (i32.const 4)
    )
   )
   (loop $label$2
    (call $eosio_assert
     (i32.gt_s
      (i32.sub
       (i32.load
        (tee_local $2
         (i32.add
          (get_local $0)
          (i32.const 8)
         )
        )
       )
       (get_local $5)
      )
      (i32.const 7)
     )
     (i32.const 432)
    )
    (drop
     (call $memcpy
      (i32.load
       (get_local $3)
      )
      (get_local $6)
      (i32.const 8)
     )
    )
    (i32.store
     (get_local $3)
     (tee_local $5
      (i32.add
       (i32.load
        (get_local $3)
       )
       (i32.const 8)
      )
     )
    )
    (call $eosio_assert
     (i32.gt_s
      (i32.sub
       (i32.load
        (get_local $2)
       )
       (get_local $5)
      )
      (i32.const 7)
     )
     (i32.const 432)
    )
    (drop
     (call $memcpy
      (i32.load
       (get_local $3)
      )
      (i32.add
       (get_local $6)
       (i32.const 8)
      )
      (i32.const 8)
     )
    )
    (i32.store
     (get_local $3)
     (tee_local $5
      (i32.add
       (i32.load
        (get_local $3)
       )
       (i32.const 8)
      )
     )
    )
    (br_if $label$2
     (i32.ne
      (tee_local $6
       (i32.add
        (get_local $6)
        (i32.const 16)
       )
      )
      (get_local $1)
     )
    )
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $7)
    (i32.const 16)
   )
  )
  (get_local $0)
 )
 (func $_ZN5eosiolsINS_10datastreamIPcEEEERT_S5_RKNSt3__16vectorIcNS6_9allocatorIcEEEE (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i64)
  (local $8 i32)
  (i32.store offset=4
   (i32.const 0)
   (tee_local $8
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 16)
    )
   )
  )
  (set_local $7
   (i64.extend_u/i32
    (i32.sub
     (i32.load offset=4
      (get_local $1)
     )
     (i32.load
      (get_local $1)
     )
    )
   )
  )
  (set_local $6
   (i32.load offset=4
    (get_local $0)
   )
  )
  (set_local $4
   (i32.add
    (get_local $0)
    (i32.const 8)
   )
  )
  (set_local $5
   (i32.add
    (get_local $0)
    (i32.const 4)
   )
  )
  (loop $label$0
   (set_local $2
    (i32.wrap/i64
     (get_local $7)
    )
   )
   (i32.store8 offset=15
    (get_local $8)
    (i32.or
     (i32.shl
      (tee_local $3
       (i64.ne
        (tee_local $7
         (i64.shr_u
          (get_local $7)
          (i64.const 7)
         )
        )
        (i64.const 0)
       )
      )
      (i32.const 7)
     )
     (i32.and
      (get_local $2)
      (i32.const 127)
     )
    )
   )
   (call $eosio_assert
    (i32.gt_s
     (i32.sub
      (i32.load
       (get_local $4)
      )
      (get_local $6)
     )
     (i32.const 0)
    )
    (i32.const 432)
   )
   (drop
    (call $memcpy
     (i32.load
      (get_local $5)
     )
     (i32.add
      (get_local $8)
      (i32.const 15)
     )
     (i32.const 1)
    )
   )
   (i32.store
    (get_local $5)
    (tee_local $6
     (i32.add
      (i32.load
       (get_local $5)
      )
      (i32.const 1)
     )
    )
   )
   (br_if $label$0
    (get_local $3)
   )
  )
  (call $eosio_assert
   (i32.ge_s
    (i32.sub
     (i32.load
      (i32.add
       (get_local $0)
       (i32.const 8)
      )
     )
     (get_local $6)
    )
    (tee_local $5
     (i32.sub
      (i32.load
       (i32.add
        (get_local $1)
        (i32.const 4)
       )
      )
      (tee_local $2
       (i32.load
        (get_local $1)
       )
      )
     )
    )
   )
   (i32.const 432)
  )
  (drop
   (call $memcpy
    (i32.load
     (tee_local $6
      (i32.add
       (get_local $0)
       (i32.const 4)
      )
     )
    )
    (get_local $2)
    (get_local $5)
   )
  )
  (i32.store
   (get_local $6)
   (i32.add
    (i32.load
     (get_local $6)
    )
    (get_local $5)
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $8)
    (i32.const 16)
   )
  )
  (get_local $0)
 )
 (func $_ZN5eosiolsINS_10datastreamIPcEEEERT_S5_RKNSt3__112basic_stringIcNS6_11char_traitsIcEENS6_9allocatorIcEEEE (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i64)
  (local $8 i32)
  (i32.store offset=4
   (i32.const 0)
   (tee_local $8
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 16)
    )
   )
  )
  (set_local $7
   (i64.extend_u/i32
    (select
     (i32.load offset=4
      (get_local $1)
     )
     (i32.shr_u
      (tee_local $5
       (i32.load8_u
        (get_local $1)
       )
      )
      (i32.const 1)
     )
     (i32.and
      (get_local $5)
      (i32.const 1)
     )
    )
   )
  )
  (set_local $6
   (i32.load offset=4
    (get_local $0)
   )
  )
  (set_local $4
   (i32.add
    (get_local $0)
    (i32.const 8)
   )
  )
  (set_local $5
   (i32.add
    (get_local $0)
    (i32.const 4)
   )
  )
  (loop $label$0
   (set_local $2
    (i32.wrap/i64
     (get_local $7)
    )
   )
   (i32.store8 offset=15
    (get_local $8)
    (i32.or
     (i32.shl
      (tee_local $3
       (i64.ne
        (tee_local $7
         (i64.shr_u
          (get_local $7)
          (i64.const 7)
         )
        )
        (i64.const 0)
       )
      )
      (i32.const 7)
     )
     (i32.and
      (get_local $2)
      (i32.const 127)
     )
    )
   )
   (call $eosio_assert
    (i32.gt_s
     (i32.sub
      (i32.load
       (get_local $4)
      )
      (get_local $6)
     )
     (i32.const 0)
    )
    (i32.const 432)
   )
   (drop
    (call $memcpy
     (i32.load
      (get_local $5)
     )
     (i32.add
      (get_local $8)
      (i32.const 15)
     )
     (i32.const 1)
    )
   )
   (i32.store
    (get_local $5)
    (tee_local $6
     (i32.add
      (i32.load
       (get_local $5)
      )
      (i32.const 1)
     )
    )
   )
   (br_if $label$0
    (get_local $3)
   )
  )
  (block $label$1
   (br_if $label$1
    (i32.eqz
     (tee_local $5
      (select
       (i32.load
        (i32.add
         (get_local $1)
         (i32.const 4)
        )
       )
       (i32.shr_u
        (tee_local $5
         (i32.load8_u
          (get_local $1)
         )
        )
        (i32.const 1)
       )
       (tee_local $2
        (i32.and
         (get_local $5)
         (i32.const 1)
        )
       )
      )
     )
    )
   )
   (set_local $3
    (i32.load offset=8
     (get_local $1)
    )
   )
   (call $eosio_assert
    (i32.ge_s
     (i32.sub
      (i32.load
       (i32.add
        (get_local $0)
        (i32.const 8)
       )
      )
      (get_local $6)
     )
     (get_local $5)
    )
    (i32.const 432)
   )
   (drop
    (call $memcpy
     (i32.load
      (tee_local $6
       (i32.add
        (get_local $0)
        (i32.const 4)
       )
      )
     )
     (select
      (get_local $3)
      (i32.add
       (get_local $1)
       (i32.const 1)
      )
      (get_local $2)
     )
     (get_local $5)
    )
   )
   (i32.store
    (get_local $6)
    (i32.add
     (i32.load
      (get_local $6)
     )
     (get_local $5)
    )
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $8)
    (i32.const 16)
   )
  )
  (get_local $0)
 )
 (func $_ZN5eosio11multi_indexILy12296682192053436416E3payJEE4itemC2IZNKS2_31load_object_by_primary_iteratorElEUlRT_E_EEPKS2_OS5_ (param $0 i32) (param $1 i32) (param $2 i32) (result i32)
  (local $3 i64)
  (local $4 i32)
  (local $5 i32)
  (i64.store offset=8
   (get_local $0)
   (i64.const 0)
  )
  (i64.store
   (get_local $0)
   (i64.const 0)
  )
  (i64.store
   (tee_local $4
    (i32.add
     (get_local $0)
     (i32.const 16)
    )
   )
   (i64.const 1398362884)
  )
  (call $eosio_assert
   (i32.const 1)
   (i32.const 480)
  )
  (set_local $3
   (i64.shr_u
    (i64.load
     (get_local $4)
    )
    (i64.const 8)
   )
  )
  (set_local $4
   (i32.const 0)
  )
  (block $label$0
   (block $label$1
    (loop $label$2
     (br_if $label$1
      (i32.gt_u
       (i32.add
        (i32.shl
         (i32.wrap/i64
          (get_local $3)
         )
         (i32.const 24)
        )
        (i32.const -1073741825)
       )
       (i32.const 452984830)
      )
     )
     (block $label$3
      (br_if $label$3
       (i64.ne
        (i64.and
         (tee_local $3
          (i64.shr_u
           (get_local $3)
           (i64.const 8)
          )
         )
         (i64.const 255)
        )
        (i64.const 0)
       )
      )
      (loop $label$4
       (br_if $label$1
        (i64.ne
         (i64.and
          (tee_local $3
           (i64.shr_u
            (get_local $3)
            (i64.const 8)
           )
          )
          (i64.const 255)
         )
         (i64.const 0)
        )
       )
       (br_if $label$4
        (i32.lt_s
         (tee_local $4
          (i32.add
           (get_local $4)
           (i32.const 1)
          )
         )
         (i32.const 7)
        )
       )
      )
     )
     (set_local $5
      (i32.const 1)
     )
     (br_if $label$2
      (i32.lt_s
       (tee_local $4
        (i32.add
         (get_local $4)
         (i32.const 1)
        )
       )
       (i32.const 7)
      )
     )
     (br $label$0)
    )
   )
   (set_local $5
    (i32.const 0)
   )
  )
  (call $eosio_assert
   (get_local $5)
   (i32.const 544)
  )
  (i32.store
   (i32.add
    (get_local $0)
    (i32.const 32)
   )
   (i32.const 0)
  )
  (i64.store offset=24 align=4
   (get_local $0)
   (i64.const 0)
  )
  (i32.store offset=36
   (get_local $0)
   (get_local $1)
  )
  (call $eosio_assert
   (i32.gt_u
    (i32.sub
     (i32.load offset=8
      (tee_local $4
       (i32.load offset=4
        (get_local $2)
       )
      )
     )
     (i32.load offset=4
      (get_local $4)
     )
    )
    (i32.const 7)
   )
   (i32.const 576)
  )
  (drop
   (call $memcpy
    (get_local $0)
    (i32.load offset=4
     (get_local $4)
    )
    (i32.const 8)
   )
  )
  (i32.store offset=4
   (get_local $4)
   (tee_local $5
    (i32.add
     (i32.load offset=4
      (get_local $4)
     )
     (i32.const 8)
    )
   )
  )
  (call $eosio_assert
   (i32.gt_u
    (i32.sub
     (i32.load offset=8
      (get_local $4)
     )
     (get_local $5)
    )
    (i32.const 7)
   )
   (i32.const 576)
  )
  (drop
   (call $memcpy
    (i32.add
     (get_local $0)
     (i32.const 8)
    )
    (i32.load offset=4
     (get_local $4)
    )
    (i32.const 8)
   )
  )
  (i32.store offset=4
   (get_local $4)
   (tee_local $5
    (i32.add
     (i32.load offset=4
      (get_local $4)
     )
     (i32.const 8)
    )
   )
  )
  (call $eosio_assert
   (i32.gt_u
    (i32.sub
     (i32.load offset=8
      (get_local $4)
     )
     (get_local $5)
    )
    (i32.const 7)
   )
   (i32.const 576)
  )
  (drop
   (call $memcpy
    (i32.add
     (get_local $0)
     (i32.const 16)
    )
    (i32.load offset=4
     (get_local $4)
    )
    (i32.const 8)
   )
  )
  (i32.store offset=4
   (get_local $4)
   (i32.add
    (i32.load offset=4
     (get_local $4)
    )
    (i32.const 8)
   )
  )
  (drop
   (call $_ZN5eosiorsINS_10datastreamIPKcEEEERT_S6_RNSt3__112basic_stringIcNS7_11char_traitsIcEENS7_9allocatorIcEEEE
    (get_local $4)
    (i32.add
     (get_local $0)
     (i32.const 24)
    )
   )
  )
  (i32.store offset=40
   (get_local $0)
   (i32.load
    (i32.load offset=8
     (get_local $2)
    )
   )
  )
  (get_local $0)
 )
 (func $_ZNSt3__16vectorIN5eosio11multi_indexILy12296682192053436416E3payJEE8item_ptrENS_9allocatorIS5_EEE24__emplace_back_slow_pathIJNS_10unique_ptrINS4_4itemENS_14default_deleteISB_EEEERyRlEEEvDpOT_ (param $0 i32) (param $1 i32) (param $2 i32) (param $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (block $label$0
   (block $label$1
    (br_if $label$1
     (i32.ge_u
      (tee_local $5
       (i32.add
        (tee_local $4
         (i32.div_s
          (i32.sub
           (i32.load offset=4
            (get_local $0)
           )
           (tee_local $6
            (i32.load
             (get_local $0)
            )
           )
          )
          (i32.const 24)
         )
        )
        (i32.const 1)
       )
      )
      (i32.const 178956971)
     )
    )
    (set_local $7
     (i32.const 178956970)
    )
    (block $label$2
     (block $label$3
      (br_if $label$3
       (i32.gt_u
        (tee_local $6
         (i32.div_s
          (i32.sub
           (i32.load offset=8
            (get_local $0)
           )
           (get_local $6)
          )
          (i32.const 24)
         )
        )
        (i32.const 89478484)
       )
      )
      (br_if $label$2
       (i32.eqz
        (tee_local $7
         (select
          (get_local $5)
          (tee_local $7
           (i32.shl
            (get_local $6)
            (i32.const 1)
           )
          )
          (i32.lt_u
           (get_local $7)
           (get_local $5)
          )
         )
        )
       )
      )
     )
     (set_local $6
      (call $_Znwj
       (i32.mul
        (get_local $7)
        (i32.const 24)
       )
      )
     )
     (br $label$0)
    )
    (set_local $7
     (i32.const 0)
    )
    (set_local $6
     (i32.const 0)
    )
    (br $label$0)
   )
   (call $_ZNKSt3__120__vector_base_commonILb1EE20__throw_length_errorEv
    (get_local $0)
   )
   (unreachable)
  )
  (set_local $5
   (i32.load
    (get_local $1)
   )
  )
  (i32.store
   (get_local $1)
   (i32.const 0)
  )
  (i32.store
   (tee_local $1
    (i32.add
     (get_local $6)
     (i32.mul
      (get_local $4)
      (i32.const 24)
     )
    )
   )
   (get_local $5)
  )
  (i64.store offset=8
   (get_local $1)
   (i64.load
    (get_local $2)
   )
  )
  (i32.store offset=16
   (get_local $1)
   (i32.load
    (get_local $3)
   )
  )
  (set_local $4
   (i32.add
    (get_local $6)
    (i32.mul
     (get_local $7)
     (i32.const 24)
    )
   )
  )
  (set_local $5
   (i32.add
    (get_local $1)
    (i32.const 24)
   )
  )
  (block $label$4
   (block $label$5
    (br_if $label$5
     (i32.eq
      (tee_local $6
       (i32.load
        (i32.add
         (get_local $0)
         (i32.const 4)
        )
       )
      )
      (tee_local $7
       (i32.load
        (get_local $0)
       )
      )
     )
    )
    (loop $label$6
     (set_local $3
      (i32.load
       (tee_local $2
        (i32.add
         (get_local $6)
         (i32.const -24)
        )
       )
      )
     )
     (i32.store
      (get_local $2)
      (i32.const 0)
     )
     (i32.store
      (i32.add
       (get_local $1)
       (i32.const -24)
      )
      (get_local $3)
     )
     (i32.store
      (i32.add
       (get_local $1)
       (i32.const -8)
      )
      (i32.load
       (i32.add
        (get_local $6)
        (i32.const -8)
       )
      )
     )
     (i32.store
      (i32.add
       (get_local $1)
       (i32.const -12)
      )
      (i32.load
       (i32.add
        (get_local $6)
        (i32.const -12)
       )
      )
     )
     (i32.store
      (i32.add
       (get_local $1)
       (i32.const -16)
      )
      (i32.load
       (i32.add
        (get_local $6)
        (i32.const -16)
       )
      )
     )
     (set_local $1
      (i32.add
       (get_local $1)
       (i32.const -24)
      )
     )
     (set_local $6
      (get_local $2)
     )
     (br_if $label$6
      (i32.ne
       (get_local $7)
       (get_local $2)
      )
     )
    )
    (set_local $7
     (i32.load
      (i32.add
       (get_local $0)
       (i32.const 4)
      )
     )
    )
    (set_local $6
     (i32.load
      (get_local $0)
     )
    )
    (br $label$4)
   )
   (set_local $6
    (get_local $7)
   )
  )
  (i32.store
   (get_local $0)
   (get_local $1)
  )
  (i32.store
   (i32.add
    (get_local $0)
    (i32.const 4)
   )
   (get_local $5)
  )
  (i32.store
   (i32.add
    (get_local $0)
    (i32.const 8)
   )
   (get_local $4)
  )
  (block $label$7
   (br_if $label$7
    (i32.eq
     (get_local $7)
     (get_local $6)
    )
   )
   (loop $label$8
    (set_local $1
     (i32.load
      (tee_local $7
       (i32.add
        (get_local $7)
        (i32.const -24)
       )
      )
     )
    )
    (i32.store
     (get_local $7)
     (i32.const 0)
    )
    (block $label$9
     (br_if $label$9
      (i32.eqz
       (get_local $1)
      )
     )
     (block $label$10
      (br_if $label$10
       (i32.eqz
        (i32.and
         (i32.load8_u offset=24
          (get_local $1)
         )
         (i32.const 1)
        )
       )
      )
      (call $_ZdlPv
       (i32.load
        (i32.add
         (get_local $1)
         (i32.const 32)
        )
       )
      )
     )
     (call $_ZdlPv
      (get_local $1)
     )
    )
    (br_if $label$8
     (i32.ne
      (get_local $6)
      (get_local $7)
     )
    )
   )
  )
  (block $label$11
   (br_if $label$11
    (i32.eqz
     (get_local $6)
    )
   )
   (call $_ZdlPv
    (get_local $6)
   )
  )
 )
 (func $_ZN5eosiorsINS_10datastreamIPKcEEEERT_S6_RNSt3__112basic_stringIcNS7_11char_traitsIcEENS7_9allocatorIcEEEE (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (i32.store offset=4
   (i32.const 0)
   (tee_local $7
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 32)
    )
   )
  )
  (i32.store offset=24
   (get_local $7)
   (i32.const 0)
  )
  (i64.store offset=16
   (get_local $7)
   (i64.const 0)
  )
  (drop
   (call $_ZN5eosiorsINS_10datastreamIPKcEEEERT_S6_RNSt3__16vectorIcNS7_9allocatorIcEEEE
    (get_local $0)
    (i32.add
     (get_local $7)
     (i32.const 16)
    )
   )
  )
  (block $label$0
   (block $label$1
    (block $label$2
     (block $label$3
      (block $label$4
       (block $label$5
        (block $label$6
         (block $label$7
          (block $label$8
           (br_if $label$8
            (i32.ne
             (tee_local $5
              (i32.load offset=20
               (get_local $7)
              )
             )
             (tee_local $4
              (i32.load offset=16
               (get_local $7)
              )
             )
            )
           )
           (br_if $label$7
            (i32.and
             (i32.load8_u
              (get_local $1)
             )
             (i32.const 1)
            )
           )
           (i32.store16
            (get_local $1)
            (i32.const 0)
           )
           (set_local $4
            (i32.add
             (get_local $1)
             (i32.const 8)
            )
           )
           (br $label$6)
          )
          (i32.store
           (i32.add
            (get_local $7)
            (i32.const 8)
           )
           (i32.const 0)
          )
          (i64.store
           (get_local $7)
           (i64.const 0)
          )
          (br_if $label$0
           (i32.ge_u
            (tee_local $2
             (i32.sub
              (get_local $5)
              (get_local $4)
             )
            )
            (i32.const -16)
           )
          )
          (br_if $label$5
           (i32.ge_u
            (get_local $2)
            (i32.const 11)
           )
          )
          (i32.store8
           (get_local $7)
           (i32.shl
            (get_local $2)
            (i32.const 1)
           )
          )
          (set_local $6
           (i32.or
            (get_local $7)
            (i32.const 1)
           )
          )
          (br_if $label$4
           (get_local $2)
          )
          (br $label$3)
         )
         (i32.store8
          (i32.load offset=8
           (get_local $1)
          )
          (i32.const 0)
         )
         (i32.store offset=4
          (get_local $1)
          (i32.const 0)
         )
         (set_local $4
          (i32.add
           (get_local $1)
           (i32.const 8)
          )
         )
        )
        (call $_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE7reserveEj
         (get_local $1)
         (i32.const 0)
        )
        (i32.store
         (get_local $4)
         (i32.const 0)
        )
        (i64.store align=4
         (get_local $1)
         (i64.const 0)
        )
        (br_if $label$2
         (tee_local $4
          (i32.load offset=16
           (get_local $7)
          )
         )
        )
        (br $label$1)
       )
       (set_local $6
        (call $_Znwj
         (tee_local $5
          (i32.and
           (i32.add
            (get_local $2)
            (i32.const 16)
           )
           (i32.const -16)
          )
         )
        )
       )
       (i32.store
        (get_local $7)
        (i32.or
         (get_local $5)
         (i32.const 1)
        )
       )
       (i32.store offset=8
        (get_local $7)
        (get_local $6)
       )
       (i32.store offset=4
        (get_local $7)
        (get_local $2)
       )
      )
      (set_local $3
       (get_local $2)
      )
      (set_local $5
       (get_local $6)
      )
      (loop $label$9
       (i32.store8
        (get_local $5)
        (i32.load8_u
         (get_local $4)
        )
       )
       (set_local $5
        (i32.add
         (get_local $5)
         (i32.const 1)
        )
       )
       (set_local $4
        (i32.add
         (get_local $4)
         (i32.const 1)
        )
       )
       (br_if $label$9
        (tee_local $3
         (i32.add
          (get_local $3)
          (i32.const -1)
         )
        )
       )
      )
      (set_local $6
       (i32.add
        (get_local $6)
        (get_local $2)
       )
      )
     )
     (i32.store8
      (get_local $6)
      (i32.const 0)
     )
     (block $label$10
      (block $label$11
       (br_if $label$11
        (i32.and
         (i32.load8_u
          (get_local $1)
         )
         (i32.const 1)
        )
       )
       (i32.store16
        (get_local $1)
        (i32.const 0)
       )
       (br $label$10)
      )
      (i32.store8
       (i32.load offset=8
        (get_local $1)
       )
       (i32.const 0)
      )
      (i32.store offset=4
       (get_local $1)
       (i32.const 0)
      )
     )
     (call $_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE7reserveEj
      (get_local $1)
      (i32.const 0)
     )
     (i32.store
      (i32.add
       (get_local $1)
       (i32.const 8)
      )
      (i32.load
       (i32.add
        (get_local $7)
        (i32.const 8)
       )
      )
     )
     (i64.store align=4
      (get_local $1)
      (i64.load
       (get_local $7)
      )
     )
     (br_if $label$1
      (i32.eqz
       (tee_local $4
        (i32.load offset=16
         (get_local $7)
        )
       )
      )
     )
    )
    (i32.store offset=20
     (get_local $7)
     (get_local $4)
    )
    (call $_ZdlPv
     (get_local $4)
    )
   )
   (i32.store offset=4
    (i32.const 0)
    (i32.add
     (get_local $7)
     (i32.const 32)
    )
   )
   (return
    (get_local $0)
   )
  )
  (call $_ZNKSt3__121__basic_string_commonILb1EE20__throw_length_errorEv
   (get_local $7)
  )
  (unreachable)
 )
 (func $_ZN5eosiorsINS_10datastreamIPKcEEEERT_S6_RNSt3__16vectorIcNS7_9allocatorIcEEEE (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i64)
  (local $7 i32)
  (set_local $5
   (i32.load offset=4
    (get_local $0)
   )
  )
  (set_local $7
   (i32.const 0)
  )
  (set_local $6
   (i64.const 0)
  )
  (set_local $2
   (i32.add
    (get_local $0)
    (i32.const 8)
   )
  )
  (set_local $3
   (i32.add
    (get_local $0)
    (i32.const 4)
   )
  )
  (loop $label$0
   (call $eosio_assert
    (i32.lt_u
     (get_local $5)
     (i32.load
      (get_local $2)
     )
    )
    (i32.const 592)
   )
   (set_local $4
    (i32.load8_u
     (tee_local $5
      (i32.load
       (get_local $3)
      )
     )
    )
   )
   (i32.store
    (get_local $3)
    (tee_local $5
     (i32.add
      (get_local $5)
      (i32.const 1)
     )
    )
   )
   (set_local $6
    (i64.or
     (i64.extend_u/i32
      (i32.shl
       (i32.and
        (get_local $4)
        (i32.const 127)
       )
       (tee_local $7
        (i32.and
         (get_local $7)
         (i32.const 255)
        )
       )
      )
     )
     (get_local $6)
    )
   )
   (set_local $7
    (i32.add
     (get_local $7)
     (i32.const 7)
    )
   )
   (br_if $label$0
    (i32.shr_u
     (get_local $4)
     (i32.const 7)
    )
   )
  )
  (block $label$1
   (block $label$2
    (br_if $label$2
     (i32.le_u
      (tee_local $3
       (i32.wrap/i64
        (get_local $6)
       )
      )
      (tee_local $2
       (i32.sub
        (tee_local $7
         (i32.load offset=4
          (get_local $1)
         )
        )
        (tee_local $4
         (i32.load
          (get_local $1)
         )
        )
       )
      )
     )
    )
    (call $_ZNSt3__16vectorIcNS_9allocatorIcEEE8__appendEj
     (get_local $1)
     (i32.sub
      (get_local $3)
      (get_local $2)
     )
    )
    (set_local $5
     (i32.load
      (i32.add
       (get_local $0)
       (i32.const 4)
      )
     )
    )
    (set_local $7
     (i32.load
      (i32.add
       (get_local $1)
       (i32.const 4)
      )
     )
    )
    (set_local $4
     (i32.load
      (get_local $1)
     )
    )
    (br $label$1)
   )
   (br_if $label$1
    (i32.ge_u
     (get_local $3)
     (get_local $2)
    )
   )
   (i32.store
    (i32.add
     (get_local $1)
     (i32.const 4)
    )
    (tee_local $7
     (i32.add
      (get_local $4)
      (get_local $3)
     )
    )
   )
  )
  (call $eosio_assert
   (i32.ge_u
    (i32.sub
     (i32.load
      (i32.add
       (get_local $0)
       (i32.const 8)
      )
     )
     (get_local $5)
    )
    (tee_local $5
     (i32.sub
      (get_local $7)
      (get_local $4)
     )
    )
   )
   (i32.const 576)
  )
  (drop
   (call $memcpy
    (get_local $4)
    (i32.load
     (tee_local $7
      (i32.add
       (get_local $0)
       (i32.const 4)
      )
     )
    )
    (get_local $5)
   )
  )
  (i32.store
   (get_local $7)
   (i32.add
    (i32.load
     (get_local $7)
    )
    (get_local $5)
   )
  )
  (get_local $0)
 )
 (func $_ZN12daccustodian13distributepayEv (param $0 i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i64)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i64)
  (local $8 i32)
  (local $9 i32)
  (local $10 i32)
  (local $11 i32)
  (local $12 i32)
  (local $13 i32)
  (local $14 i32)
  (local $15 i32)
  (i32.store offset=4
   (i32.const 0)
   (tee_local $15
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 96)
    )
   )
  )
  (i32.store offset=64
   (get_local $15)
   (i32.add
    (get_local $0)
    (i32.const 48)
   )
  )
  (set_local $6
   (i32.const 0)
  )
  (i32.store
   (i32.add
    (i32.add
     (get_local $15)
     (i32.const 40)
    )
    (i32.const 8)
   )
   (i32.const 0)
  )
  (i32.store
   (tee_local $14
    (i32.add
     (get_local $15)
     (i32.const 56)
    )
   )
   (i32.const 0)
  )
  (i32.store offset=44
   (get_local $15)
   (i32.add
    (get_local $15)
    (i32.const 64)
   )
  )
  (i32.store offset=52
   (get_local $15)
   (i32.add
    (get_local $15)
    (i32.const 64)
   )
  )
  (i32.store offset=32
   (get_local $15)
   (i32.const 0)
  )
  (i64.store offset=24
   (get_local $15)
   (i64.const 0)
  )
  (i64.store offset=88
   (get_local $15)
   (i64.const 0)
  )
  (i64.store offset=80
   (get_local $15)
   (i64.const 0)
  )
  (call $_ZNK5eosio11multi_indexILy4730634643120193536E9candidateJNS_10indexed_byILy8518361509820596224EN5boost11multi_index13const_mem_funIS1_oXadL_ZNKS1_22get_by_is_cust_and_payEvEEEEEENS2_ILy4591222642450628608ENS5_IS1_yXadL_ZNKS1_15by_number_votesEvEEEEEEEE5indexILy8518361509820596224ES6_Ly0ELb0EE11lower_boundERKo
   (i32.add
    (get_local $15)
    (i32.const 8)
   )
   (i32.add
    (get_local $15)
    (i32.const 64)
   )
   (i32.add
    (get_local $15)
    (i32.const 80)
   )
  )
  (set_local $1
   (i32.add
    (get_local $15)
    (i32.const 52)
   )
  )
  (block $label$0
   (block $label$1
    (br_if $label$1
     (i32.eqz
      (i32.load offset=12
       (get_local $15)
      )
     )
    )
    (set_local $5
     (i32.add
      (i32.add
       (get_local $15)
       (i32.const 24)
      )
      (i32.const 8)
     )
    )
    (loop $label$2
     (i64.store offset=80
      (get_local $15)
      (i64.load align=4
       (get_local $1)
      )
     )
     (block $label$3
      (br_if $label$3
       (i32.eqz
        (i32.load8_u offset=56
         (i32.load offset=4
          (call $_ZN5eosio11multi_indexILy4730634643120193536E9candidateJNS_10indexed_byILy8518361509820596224EN5boost11multi_index13const_mem_funIS1_oXadL_ZNKS1_22get_by_is_cust_and_payEvEEEEEENS2_ILy4591222642450628608ENS5_IS1_yXadL_ZNKS1_15by_number_votesEvEEEEEEEE5indexILy8518361509820596224ES6_Ly0ELb0EE14const_iteratormmEv
           (i32.add
            (get_local $15)
            (i32.const 80)
           )
          )
         )
        )
       )
      )
      (i64.store offset=80
       (get_local $15)
       (i64.load align=4
        (get_local $1)
       )
      )
      (set_local $6
       (i32.add
        (i32.load offset=4
         (call $_ZN5eosio11multi_indexILy4730634643120193536E9candidateJNS_10indexed_byILy8518361509820596224EN5boost11multi_index13const_mem_funIS1_oXadL_ZNKS1_22get_by_is_cust_and_payEvEEEEEENS2_ILy4591222642450628608ENS5_IS1_yXadL_ZNKS1_15by_number_votesEvEEEEEEEE5indexILy8518361509820596224ES6_Ly0ELb0EE14const_iteratormmEv
          (i32.add
           (get_local $15)
           (i32.const 80)
          )
         )
        )
        (i32.const 24)
       )
      )
      (block $label$4
       (br_if $label$4
        (i32.eq
         (tee_local $13
          (i32.load offset=28
           (get_local $15)
          )
         )
         (i32.load
          (get_local $5)
         )
        )
       )
       (i64.store
        (get_local $13)
        (i64.load
         (get_local $6)
        )
       )
       (i32.store offset=28
        (get_local $15)
        (i32.add
         (get_local $13)
         (i32.const 8)
        )
       )
       (br $label$3)
      )
      (call $_ZNSt3__16vectorIxNS_9allocatorIxEEE21__push_back_slow_pathIRKxEEvOT_
       (i32.add
        (get_local $15)
        (i32.const 24)
       )
       (get_local $6)
      )
     )
     (drop
      (call $_ZN5eosio11multi_indexILy4730634643120193536E9candidateJNS_10indexed_byILy8518361509820596224EN5boost11multi_index13const_mem_funIS1_oXadL_ZNKS1_22get_by_is_cust_and_payEvEEEEEENS2_ILy4591222642450628608ENS5_IS1_yXadL_ZNKS1_15by_number_votesEvEEEEEEEE5indexILy8518361509820596224ES6_Ly0ELb0EE14const_iteratormmEv
       (get_local $1)
      )
     )
     (i64.store offset=88
      (get_local $15)
      (i64.const 0)
     )
     (i64.store offset=80
      (get_local $15)
      (i64.const 0)
     )
     (call $_ZNK5eosio11multi_indexILy4730634643120193536E9candidateJNS_10indexed_byILy8518361509820596224EN5boost11multi_index13const_mem_funIS1_oXadL_ZNKS1_22get_by_is_cust_and_payEvEEEEEENS2_ILy4591222642450628608ENS5_IS1_yXadL_ZNKS1_15by_number_votesEvEEEEEEEE5indexILy8518361509820596224ES6_Ly0ELb0EE11lower_boundERKo
      (i32.add
       (get_local $15)
       (i32.const 8)
      )
      (i32.add
       (get_local $15)
       (i32.const 64)
      )
      (i32.add
       (get_local $15)
       (i32.const 80)
      )
     )
     (br_if $label$2
      (i32.ne
       (i32.load
        (get_local $14)
       )
       (i32.load offset=12
        (get_local $15)
       )
      )
     )
    )
    (set_local $6
     (i32.load offset=28
      (get_local $15)
     )
    )
    (set_local $13
     (i32.load offset=24
      (get_local $15)
     )
    )
    (br $label$0)
   )
   (set_local $13
    (i32.const 0)
   )
  )
  (call $_ZNSt3__113__nth_elementIRNS_6__lessIxxEENS_11__wrap_iterIPxEEEEvT0_S7_S7_T_
   (get_local $13)
   (i32.add
    (get_local $13)
    (tee_local $14
     (i32.and
      (i32.shr_s
       (i32.sub
        (get_local $6)
        (get_local $13)
       )
       (i32.const 1)
      )
      (i32.const -8)
     )
    )
   )
   (get_local $6)
   (i32.add
    (get_local $15)
    (i32.const 80)
   )
  )
  (i64.store offset=8
   (get_local $15)
   (tee_local $3
    (i64.load
     (i32.add
      (i32.load offset=24
       (get_local $15)
      )
      (get_local $14)
     )
    )
   )
  )
  (i64.store offset=16
   (get_local $15)
   (tee_local $7
    (i64.load offset=256
     (get_local $0)
    )
   )
  )
  (call $eosio_assert
   (i64.lt_u
    (i64.add
     (get_local $3)
     (i64.const 4611686018427387903)
    )
    (i64.const 9223372036854775807)
   )
   (i32.const 480)
  )
  (set_local $3
   (i64.shr_u
    (get_local $7)
    (i64.const 8)
   )
  )
  (set_local $13
   (i32.const 0)
  )
  (block $label$5
   (block $label$6
    (loop $label$7
     (br_if $label$6
      (i32.gt_u
       (i32.add
        (i32.shl
         (i32.wrap/i64
          (get_local $3)
         )
         (i32.const 24)
        )
        (i32.const -1073741825)
       )
       (i32.const 452984830)
      )
     )
     (block $label$8
      (br_if $label$8
       (i64.ne
        (i64.and
         (tee_local $3
          (i64.shr_u
           (get_local $3)
           (i64.const 8)
          )
         )
         (i64.const 255)
        )
        (i64.const 0)
       )
      )
      (loop $label$9
       (br_if $label$6
        (i64.ne
         (i64.and
          (tee_local $3
           (i64.shr_u
            (get_local $3)
            (i64.const 8)
           )
          )
          (i64.const 255)
         )
         (i64.const 0)
        )
       )
       (br_if $label$9
        (i32.lt_s
         (tee_local $13
          (i32.add
           (get_local $13)
           (i32.const 1)
          )
         )
         (i32.const 7)
        )
       )
      )
     )
     (set_local $6
      (i32.const 1)
     )
     (br_if $label$7
      (i32.lt_s
       (tee_local $13
        (i32.add
         (get_local $13)
         (i32.const 1)
        )
       )
       (i32.const 7)
      )
     )
     (br $label$5)
    )
   )
   (set_local $6
    (i32.const 0)
   )
  )
  (call $eosio_assert
   (get_local $6)
   (i32.const 544)
  )
  (i32.store
   (i32.add
    (get_local $15)
    (i32.const 48)
   )
   (i32.const 0)
  )
  (i32.store
   (tee_local $8
    (i32.add
     (get_local $15)
     (i32.const 56)
    )
   )
   (i32.const 0)
  )
  (i32.store
   (tee_local $9
    (i32.add
     (get_local $15)
     (i32.const 52)
    )
   )
   (i32.add
    (get_local $15)
    (i32.const 64)
   )
  )
  (i32.store offset=44
   (get_local $15)
   (i32.add
    (get_local $15)
    (i32.const 64)
   )
  )
  (i64.store offset=88
   (get_local $15)
   (i64.const 0)
  )
  (i64.store offset=80
   (get_local $15)
   (i64.const 0)
  )
  (call $_ZNK5eosio11multi_indexILy4730634643120193536E9candidateJNS_10indexed_byILy8518361509820596224EN5boost11multi_index13const_mem_funIS1_oXadL_ZNKS1_22get_by_is_cust_and_payEvEEEEEENS2_ILy4591222642450628608ENS5_IS1_yXadL_ZNKS1_15by_number_votesEvEEEEEEEE5indexILy8518361509820596224ES6_Ly0ELb0EE11lower_boundERKo
   (i32.add
    (get_local $15)
    (i32.const 72)
   )
   (i32.add
    (get_local $15)
    (i32.const 64)
   )
   (i32.add
    (get_local $15)
    (i32.const 80)
   )
  )
  (block $label$10
   (br_if $label$10
    (i32.eq
     (i32.load
      (get_local $8)
     )
     (i32.load offset=76
      (get_local $15)
     )
    )
   )
   (set_local $2
    (i32.add
     (get_local $0)
     (i32.const 128)
    )
   )
   (set_local $10
    (i32.add
     (get_local $0)
     (i32.const 152)
    )
   )
   (set_local $11
    (i32.add
     (get_local $0)
     (i32.const 156)
    )
   )
   (set_local $12
    (i32.add
     (get_local $0)
     (i32.const 136)
    )
   )
   (loop $label$11
    (i64.store offset=80
     (get_local $15)
     (i64.load align=4
      (get_local $9)
     )
    )
    (block $label$12
     (br_if $label$12
      (i32.eqz
       (i32.load8_u offset=56
        (i32.load offset=4
         (call $_ZN5eosio11multi_indexILy4730634643120193536E9candidateJNS_10indexed_byILy8518361509820596224EN5boost11multi_index13const_mem_funIS1_oXadL_ZNKS1_22get_by_is_cust_and_payEvEEEEEENS2_ILy4591222642450628608ENS5_IS1_yXadL_ZNKS1_15by_number_votesEvEEEEEEEE5indexILy8518361509820596224ES6_Ly0ELb0EE14const_iteratormmEv
          (i32.add
           (get_local $15)
           (i32.const 80)
          )
         )
        )
       )
      )
     )
     (i64.store offset=80
      (get_local $15)
      (i64.load align=4
       (get_local $9)
      )
     )
     (set_local $3
      (i64.load
       (i32.load offset=4
        (call $_ZN5eosio11multi_indexILy4730634643120193536E9candidateJNS_10indexed_byILy8518361509820596224EN5boost11multi_index13const_mem_funIS1_oXadL_ZNKS1_22get_by_is_cust_and_payEvEEEEEENS2_ILy4591222642450628608ENS5_IS1_yXadL_ZNKS1_15by_number_votesEvEEEEEEEE5indexILy8518361509820596224ES6_Ly0ELb0EE14const_iteratormmEv
         (i32.add
          (get_local $15)
          (i32.const 80)
         )
        )
       )
      )
     )
     (block $label$13
      (br_if $label$13
       (i32.eq
        (tee_local $14
         (i32.load
          (get_local $11)
         )
        )
        (tee_local $4
         (i32.load
          (get_local $10)
         )
        )
       )
      )
      (set_local $13
       (i32.add
        (get_local $14)
        (i32.const -24)
       )
      )
      (set_local $5
       (i32.sub
        (i32.const 0)
        (get_local $4)
       )
      )
      (loop $label$14
       (br_if $label$13
        (i64.eq
         (i64.load
          (i32.load
           (get_local $13)
          )
         )
         (get_local $3)
        )
       )
       (set_local $14
        (get_local $13)
       )
       (set_local $13
        (tee_local $6
         (i32.add
          (get_local $13)
          (i32.const -24)
         )
        )
       )
       (br_if $label$14
        (i32.ne
         (i32.add
          (get_local $6)
          (get_local $5)
         )
         (i32.const -24)
        )
       )
      )
     )
     (block $label$15
      (block $label$16
       (block $label$17
        (block $label$18
         (br_if $label$18
          (i32.eq
           (get_local $14)
           (get_local $4)
          )
         )
         (call $eosio_assert
          (i32.eq
           (i32.load offset=36
            (tee_local $13
             (i32.load
              (i32.add
               (get_local $14)
               (i32.const -24)
              )
             )
            )
           )
           (get_local $2)
          )
          (i32.const 896)
         )
         (set_local $3
          (i64.load
           (get_local $0)
          )
         )
         (br_if $label$17
          (get_local $13)
         )
         (br $label$15)
        )
        (br_if $label$16
         (i32.le_s
          (tee_local $13
           (call $db_find_i64
            (i64.load
             (get_local $2)
            )
            (i64.load
             (get_local $12)
            )
            (i64.const -6150061881656115200)
            (get_local $3)
           )
          )
          (i32.const -1)
         )
        )
        (call $eosio_assert
         (i32.eq
          (i32.load offset=36
           (tee_local $13
            (call $_ZNK5eosio11multi_indexILy12296682192053436416E3payJEE31load_object_by_primary_iteratorEl
             (get_local $2)
             (get_local $13)
            )
           )
          )
          (get_local $2)
         )
         (i32.const 896)
        )
        (set_local $3
         (i64.load
          (get_local $0)
         )
        )
       )
       (i32.store offset=80
        (get_local $15)
        (i32.add
         (get_local $15)
         (i32.const 8)
        )
       )
       (call $eosio_assert
        (i32.const 1)
        (i32.const 960)
       )
       (call $_ZN5eosio11multi_indexILy12296682192053436416E3payJEE6modifyIZN12daccustodian13distributepayEvEUlRS1_E_EEvRKS1_yOT_
        (get_local $2)
        (get_local $13)
        (get_local $3)
        (i32.add
         (get_local $15)
         (i32.const 80)
        )
       )
       (br $label$12)
      )
      (set_local $3
       (i64.load
        (get_local $0)
       )
      )
     )
     (i32.store offset=84
      (get_local $15)
      (i32.add
       (get_local $15)
       (i32.const 8)
      )
     )
     (i32.store offset=80
      (get_local $15)
      (i32.add
       (get_local $15)
       (i32.const 40)
      )
     )
     (call $_ZN5eosio11multi_indexILy12296682192053436416E3payJEE7emplaceIZN12daccustodian13distributepayEvEUlRS1_E0_EENS2_14const_iteratorEyOT_
      (i32.add
       (get_local $15)
       (i32.const 72)
      )
      (get_local $2)
      (get_local $3)
      (i32.add
       (get_local $15)
       (i32.const 80)
      )
     )
    )
    (drop
     (call $_ZN5eosio11multi_indexILy4730634643120193536E9candidateJNS_10indexed_byILy8518361509820596224EN5boost11multi_index13const_mem_funIS1_oXadL_ZNKS1_22get_by_is_cust_and_payEvEEEEEENS2_ILy4591222642450628608ENS5_IS1_yXadL_ZNKS1_15by_number_votesEvEEEEEEEE5indexILy8518361509820596224ES6_Ly0ELb0EE14const_iteratormmEv
      (get_local $1)
     )
    )
    (i64.store offset=88
     (get_local $15)
     (i64.const 0)
    )
    (i64.store offset=80
     (get_local $15)
     (i64.const 0)
    )
    (call $_ZNK5eosio11multi_indexILy4730634643120193536E9candidateJNS_10indexed_byILy8518361509820596224EN5boost11multi_index13const_mem_funIS1_oXadL_ZNKS1_22get_by_is_cust_and_payEvEEEEEENS2_ILy4591222642450628608ENS5_IS1_yXadL_ZNKS1_15by_number_votesEvEEEEEEEE5indexILy8518361509820596224ES6_Ly0ELb0EE11lower_boundERKo
     (i32.add
      (get_local $15)
      (i32.const 72)
     )
     (i32.add
      (get_local $15)
      (i32.const 64)
     )
     (i32.add
      (get_local $15)
      (i32.const 80)
     )
    )
    (br_if $label$11
     (i32.ne
      (i32.load
       (get_local $8)
      )
      (i32.load offset=76
       (get_local $15)
      )
     )
    )
   )
  )
  (block $label$19
   (br_if $label$19
    (i32.eqz
     (tee_local $13
      (i32.load offset=24
       (get_local $15)
      )
     )
    )
   )
   (i32.store offset=28
    (get_local $15)
    (get_local $13)
   )
   (call $_ZdlPv
    (get_local $13)
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $15)
    (i32.const 96)
   )
  )
 )
 (func $_ZN12daccustodian13clearOldVotesEv (param $0 i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  (i32.store offset=4
   (i32.const 0)
   (tee_local $3
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 16)
    )
   )
  )
  (block $label$0
   (br_if $label$0
    (i32.lt_s
     (tee_local $2
      (call $db_lowerbound_i64
       (i64.load offset=88
        (get_local $0)
       )
       (i64.load
        (i32.add
         (get_local $0)
         (i32.const 96)
        )
       )
       (i64.const -2507752926491967488)
       (i64.const 0)
      )
     )
     (i32.const 0)
    )
   )
   (call $_ZN5eosio11multi_indexILy15938991147217584128E4voteJNS_10indexed_byILy4587895300147904512EN5boost11multi_index13const_mem_funIS1_yXadL_ZNKS1_8by_proxyEvEEEEEEEE6modifyIZN12daccustodian13clearOldVotesEvEUlRS1_E_EEvRKS1_yOT_
    (tee_local $1
     (i32.add
      (get_local $0)
      (i32.const 88)
     )
    )
    (tee_local $2
     (call $_ZNK5eosio11multi_indexILy15938991147217584128E4voteJNS_10indexed_byILy4587895300147904512EN5boost11multi_index13const_mem_funIS1_yXadL_ZNKS1_8by_proxyEvEEEEEEEE31load_object_by_primary_iteratorEl
      (get_local $1)
      (get_local $2)
     )
    )
    (i64.load
     (get_local $0)
    )
    (get_local $3)
   )
   (call $eosio_assert
    (i32.const 1)
    (i32.const 224)
   )
   (br_if $label$0
    (i32.lt_s
     (tee_local $2
      (call $db_next_i64
       (i32.load offset=40
        (get_local $2)
       )
       (i32.add
        (get_local $3)
        (i32.const 8)
       )
      )
     )
     (i32.const 0)
    )
   )
   (loop $label$1
    (call $_ZN5eosio11multi_indexILy15938991147217584128E4voteJNS_10indexed_byILy4587895300147904512EN5boost11multi_index13const_mem_funIS1_yXadL_ZNKS1_8by_proxyEvEEEEEEEE6modifyIZN12daccustodian13clearOldVotesEvEUlRS1_E_EEvRKS1_yOT_
     (get_local $1)
     (tee_local $2
      (call $_ZNK5eosio11multi_indexILy15938991147217584128E4voteJNS_10indexed_byILy4587895300147904512EN5boost11multi_index13const_mem_funIS1_yXadL_ZNKS1_8by_proxyEvEEEEEEEE31load_object_by_primary_iteratorEl
       (get_local $1)
       (get_local $2)
      )
     )
     (i64.load
      (get_local $0)
     )
     (get_local $3)
    )
    (call $eosio_assert
     (i32.const 1)
     (i32.const 224)
    )
    (br_if $label$1
     (i32.gt_s
      (tee_local $2
       (call $db_next_i64
        (i32.load offset=40
         (get_local $2)
        )
        (i32.add
         (get_local $3)
         (i32.const 8)
        )
       )
      )
      (i32.const -1)
     )
    )
   )
  )
  (block $label$2
   (br_if $label$2
    (i32.lt_s
     (tee_local $2
      (call $db_lowerbound_i64
       (i64.load offset=48
        (get_local $0)
       )
       (i64.load
        (i32.add
         (get_local $0)
         (i32.const 56)
        )
       )
       (i64.const 4730634643120193536)
       (i64.const 0)
      )
     )
     (i32.const 0)
    )
   )
   (call $_ZN5eosio11multi_indexILy4730634643120193536E9candidateJNS_10indexed_byILy8518361509820596224EN5boost11multi_index13const_mem_funIS1_oXadL_ZNKS1_22get_by_is_cust_and_payEvEEEEEENS2_ILy4591222642450628608ENS5_IS1_yXadL_ZNKS1_15by_number_votesEvEEEEEEEE6modifyIZN12daccustodian13clearOldVotesEvEUlRS1_E_EEvRKS1_yOT_
    (tee_local $1
     (i32.add
      (get_local $0)
      (i32.const 48)
     )
    )
    (tee_local $2
     (call $_ZNK5eosio11multi_indexILy4730634643120193536E9candidateJNS_10indexed_byILy8518361509820596224EN5boost11multi_index13const_mem_funIS1_oXadL_ZNKS1_22get_by_is_cust_and_payEvEEEEEENS2_ILy4591222642450628608ENS5_IS1_yXadL_ZNKS1_15by_number_votesEvEEEEEEEE31load_object_by_primary_iteratorEl
      (get_local $1)
      (get_local $2)
     )
    )
    (i64.load
     (get_local $0)
    )
    (get_local $3)
   )
   (call $eosio_assert
    (i32.const 1)
    (i32.const 224)
   )
   (br_if $label$2
    (i32.lt_s
     (tee_local $2
      (call $db_next_i64
       (i32.load offset=92
        (get_local $2)
       )
       (i32.add
        (get_local $3)
        (i32.const 8)
       )
      )
     )
     (i32.const 0)
    )
   )
   (loop $label$3
    (call $_ZN5eosio11multi_indexILy4730634643120193536E9candidateJNS_10indexed_byILy8518361509820596224EN5boost11multi_index13const_mem_funIS1_oXadL_ZNKS1_22get_by_is_cust_and_payEvEEEEEENS2_ILy4591222642450628608ENS5_IS1_yXadL_ZNKS1_15by_number_votesEvEEEEEEEE6modifyIZN12daccustodian13clearOldVotesEvEUlRS1_E_EEvRKS1_yOT_
     (get_local $1)
     (tee_local $2
      (call $_ZNK5eosio11multi_indexILy4730634643120193536E9candidateJNS_10indexed_byILy8518361509820596224EN5boost11multi_index13const_mem_funIS1_oXadL_ZNKS1_22get_by_is_cust_and_payEvEEEEEENS2_ILy4591222642450628608ENS5_IS1_yXadL_ZNKS1_15by_number_votesEvEEEEEEEE31load_object_by_primary_iteratorEl
       (get_local $1)
       (get_local $2)
      )
     )
     (i64.load
      (get_local $0)
     )
     (get_local $3)
    )
    (call $eosio_assert
     (i32.const 1)
     (i32.const 224)
    )
    (br_if $label$3
     (i32.gt_s
      (tee_local $2
       (call $db_next_i64
        (i32.load offset=92
         (get_local $2)
        )
        (i32.add
         (get_local $3)
         (i32.const 8)
        )
       )
      )
      (i32.const -1)
     )
    )
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $3)
    (i32.const 16)
   )
  )
 )
 (func $_ZN12daccustodian13tallyNewVotesEv (param $0 i32)
  (local $1 i32)
  (local $2 i64)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (local $8 i32)
  (local $9 i32)
  (local $10 i32)
  (local $11 i32)
  (local $12 i32)
  (local $13 i32)
  (local $14 i32)
  (local $15 i32)
  (local $16 i32)
  (local $17 i32)
  (local $18 i32)
  (local $19 i32)
  (local $20 i32)
  (local $21 i64)
  (local $22 i64)
  (local $23 i64)
  (local $24 i64)
  (local $25 i32)
  (local $26 i32)
  (local $27 i32)
  (local $28 i32)
  (i32.store offset=4
   (i32.const 0)
   (tee_local $28
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 96)
    )
   )
  )
  (i32.store offset=80
   (get_local $28)
   (tee_local $1
    (i32.add
     (get_local $0)
     (i32.const 88)
    )
   )
  )
  (call $_ZN12daccustodian7configsEv
   (i32.add
    (get_local $28)
    (i32.const 16)
   )
   (get_local $0)
  )
  (set_local $22
   (i64.load offset=24
    (get_local $28)
   )
  )
  (i32.store
   (i32.add
    (i32.add
     (get_local $28)
     (i32.const 56)
    )
    (i32.const 8)
   )
   (i32.const 0)
  )
  (i32.store
   (tee_local $10
    (i32.add
     (i32.add
      (get_local $28)
      (i32.const 56)
     )
     (i32.const 16)
    )
   )
   (i32.const 0)
  )
  (i32.store offset=60
   (get_local $28)
   (i32.add
    (get_local $28)
    (i32.const 80)
   )
  )
  (i32.store offset=68
   (get_local $28)
   (i32.add
    (get_local $28)
    (i32.const 80)
   )
  )
  (i64.store offset=16
   (get_local $28)
   (i64.const 0)
  )
  (call $_ZNK5eosio11multi_indexILy15938991147217584128E4voteJNS_10indexed_byILy4587895300147904512EN5boost11multi_index13const_mem_funIS1_yXadL_ZNKS1_8by_proxyEvEEEEEEEE5indexILy4587895300147904512ES6_Ly0ELb0EE11lower_boundERKy
   (i32.add
    (get_local $28)
    (i32.const 88)
   )
   (i32.add
    (get_local $28)
    (i32.const 80)
   )
   (i32.add
    (get_local $28)
    (i32.const 16)
   )
  )
  (block $label$0
   (br_if $label$0
    (i32.eqz
     (tee_local $4
      (i32.load offset=92
       (get_local $28)
      )
     )
    )
   )
   (set_local $2
    (i64.shr_u
     (get_local $22)
     (i64.const 8)
    )
   )
   (set_local $3
    (i32.add
     (get_local $28)
     (i32.const 68)
    )
   )
   (set_local $5
    (i32.add
     (get_local $0)
     (i32.const 48)
    )
   )
   (set_local $11
    (i32.add
     (i32.add
      (get_local $28)
      (i32.const 16)
     )
     (i32.const 16)
    )
   )
   (set_local $12
    (i32.add
     (get_local $28)
     (i32.const 40)
    )
   )
   (set_local $13
    (i32.add
     (get_local $28)
     (i32.const 48)
    )
   )
   (set_local $14
    (i32.add
     (i32.add
      (get_local $28)
      (i32.const 16)
     )
     (i32.const 8)
    )
   )
   (set_local $18
    (i32.add
     (get_local $0)
     (i32.const 72)
    )
   )
   (set_local $19
    (i32.add
     (get_local $0)
     (i32.const 76)
    )
   )
   (set_local $20
    (i32.add
     (get_local $0)
     (i32.const 56)
    )
   )
   (set_local $15
    (i32.add
     (get_local $0)
     (i32.const 112)
    )
   )
   (set_local $16
    (i32.add
     (get_local $0)
     (i32.const 116)
    )
   )
   (set_local $17
    (i32.add
     (get_local $0)
     (i32.const 96)
    )
   )
   (loop $label$1
    (set_local $22
     (i64.const 0)
    )
    (set_local $21
     (i64.const 59)
    )
    (set_local $26
     (i32.const 160)
    )
    (set_local $23
     (i64.const 0)
    )
    (loop $label$2
     (block $label$3
      (block $label$4
       (block $label$5
        (block $label$6
         (block $label$7
          (br_if $label$7
           (i64.gt_u
            (get_local $22)
            (i64.const 10)
           )
          )
          (br_if $label$6
           (i32.gt_u
            (i32.and
             (i32.add
              (tee_local $9
               (i32.load8_s
                (get_local $26)
               )
              )
              (i32.const -97)
             )
             (i32.const 255)
            )
            (i32.const 25)
           )
          )
          (set_local $9
           (i32.add
            (get_local $9)
            (i32.const 165)
           )
          )
          (br $label$5)
         )
         (set_local $24
          (i64.const 0)
         )
         (br_if $label$4
          (i64.eq
           (get_local $22)
           (i64.const 11)
          )
         )
         (br $label$3)
        )
        (set_local $9
         (select
          (i32.add
           (get_local $9)
           (i32.const 208)
          )
          (i32.const 0)
          (i32.lt_u
           (i32.and
            (i32.add
             (get_local $9)
             (i32.const -49)
            )
            (i32.const 255)
           )
           (i32.const 5)
          )
         )
        )
       )
       (set_local $24
        (i64.shr_s
         (i64.shl
          (i64.extend_u/i32
           (get_local $9)
          )
          (i64.const 56)
         )
         (i64.const 56)
        )
       )
      )
      (set_local $24
       (i64.shl
        (i64.and
         (get_local $24)
         (i64.const 31)
        )
        (i64.and
         (get_local $21)
         (i64.const 4294967295)
        )
       )
      )
     )
     (set_local $26
      (i32.add
       (get_local $26)
       (i32.const 1)
      )
     )
     (set_local $21
      (i64.add
       (get_local $21)
       (i64.const -5)
      )
     )
     (set_local $23
      (i64.or
       (get_local $24)
       (get_local $23)
      )
     )
     (br_if $label$2
      (i64.ne
       (tee_local $22
        (i64.add
         (get_local $22)
         (i64.const 1)
        )
       )
       (i64.const 13)
      )
     )
    )
    (i64.store offset=16
     (get_local $28)
     (i64.load align=4
      (get_local $3)
     )
    )
    (set_local $26
     (i32.load offset=4
      (call $_ZN5eosio11multi_indexILy15938991147217584128E4voteJNS_10indexed_byILy4587895300147904512EN5boost11multi_index13const_mem_funIS1_yXadL_ZNKS1_8by_proxyEvEEEEEEEE5indexILy4587895300147904512ES6_Ly0ELb0EE14const_iteratormmEv
       (i32.add
        (get_local $28)
        (i32.const 16)
       )
      )
     )
    )
    (i64.store
     (get_local $11)
     (i64.const -1)
    )
    (i64.store
     (get_local $12)
     (i64.const 0)
    )
    (i32.store
     (get_local $13)
     (i32.const 0)
    )
    (i64.store
     (get_local $14)
     (tee_local $22
      (i64.load
       (get_local $26)
      )
     )
    )
    (i64.store offset=16
     (get_local $28)
     (get_local $23)
    )
    (block $label$8
     (br_if $label$8
      (i32.lt_s
       (tee_local $26
        (call $db_find_i64
         (get_local $23)
         (get_local $22)
         (i64.const 3607749779137757184)
         (get_local $2)
        )
       )
       (i32.const 0)
      )
     )
     (call $eosio_assert
      (i32.eq
       (i32.load offset=16
        (tee_local $26
         (call $_ZNK5eosio11multi_indexILy3607749779137757184E7accountJEE31load_object_by_primary_iteratorEl
          (i32.add
           (get_local $28)
           (i32.const 16)
          )
          (get_local $26)
         )
        )
       )
       (i32.add
        (get_local $28)
        (i32.const 16)
       )
      )
      (i32.const 896)
     )
     (i64.store offset=8
      (get_local $28)
      (i64.load
       (get_local $26)
      )
     )
     (i64.store offset=88
      (get_local $28)
      (i64.load align=4
       (get_local $3)
      )
     )
     (set_local $26
      (i32.load offset=4
       (call $_ZN5eosio11multi_indexILy15938991147217584128E4voteJNS_10indexed_byILy4587895300147904512EN5boost11multi_index13const_mem_funIS1_yXadL_ZNKS1_8by_proxyEvEEEEEEEE5indexILy4587895300147904512ES6_Ly0ELb0EE14const_iteratormmEv
        (i32.add
         (get_local $28)
         (i32.const 88)
        )
       )
      )
     )
     (set_local $22
      (i64.load
       (get_local $0)
      )
     )
     (i32.store offset=88
      (get_local $28)
      (i32.add
       (get_local $28)
       (i32.const 8)
      )
     )
     (call $_ZN5eosio11multi_indexILy15938991147217584128E4voteJNS_10indexed_byILy4587895300147904512EN5boost11multi_index13const_mem_funIS1_yXadL_ZNKS1_8by_proxyEvEEEEEEEE6modifyIZN12daccustodian13tallyNewVotesEvEUlRS1_E_EEvRKS1_yOT_
      (get_local $1)
      (get_local $26)
      (get_local $22)
      (i32.add
       (get_local $28)
       (i32.const 88)
      )
     )
     (i64.store offset=88
      (get_local $28)
      (i64.load align=4
       (get_local $3)
      )
     )
     (br_if $label$8
      (i64.eqz
       (i64.load offset=8
        (i32.load offset=4
         (call $_ZN5eosio11multi_indexILy15938991147217584128E4voteJNS_10indexed_byILy4587895300147904512EN5boost11multi_index13const_mem_funIS1_yXadL_ZNKS1_8by_proxyEvEEEEEEEE5indexILy4587895300147904512ES6_Ly0ELb0EE14const_iteratormmEv
          (i32.add
           (get_local $28)
           (i32.const 88)
          )
         )
        )
       )
      )
     )
     (i64.store offset=88
      (get_local $28)
      (i64.load align=4
       (get_local $3)
      )
     )
     (set_local $22
      (i64.load offset=8
       (i32.load offset=4
        (call $_ZN5eosio11multi_indexILy15938991147217584128E4voteJNS_10indexed_byILy4587895300147904512EN5boost11multi_index13const_mem_funIS1_yXadL_ZNKS1_8by_proxyEvEEEEEEEE5indexILy4587895300147904512ES6_Ly0ELb0EE14const_iteratormmEv
         (i32.add
          (get_local $28)
          (i32.const 88)
         )
        )
       )
      )
     )
     (block $label$9
      (br_if $label$9
       (i32.eq
        (tee_local $27
         (i32.load
          (get_local $16)
         )
        )
        (tee_local $25
         (i32.load
          (get_local $15)
         )
        )
       )
      )
      (set_local $26
       (i32.add
        (get_local $27)
        (i32.const -24)
       )
      )
      (set_local $8
       (i32.sub
        (i32.const 0)
        (get_local $25)
       )
      )
      (loop $label$10
       (br_if $label$9
        (i64.eq
         (i64.load
          (i32.load
           (get_local $26)
          )
         )
         (get_local $22)
        )
       )
       (set_local $27
        (get_local $26)
       )
       (set_local $26
        (tee_local $9
         (i32.add
          (get_local $26)
          (i32.const -24)
         )
        )
       )
       (br_if $label$10
        (i32.ne
         (i32.add
          (get_local $9)
          (get_local $8)
         )
         (i32.const -24)
        )
       )
      )
     )
     (block $label$11
      (block $label$12
       (br_if $label$12
        (i32.eq
         (get_local $27)
         (get_local $25)
        )
       )
       (call $eosio_assert
        (i32.eq
         (i32.load offset=36
          (tee_local $26
           (i32.load
            (i32.add
             (get_local $27)
             (i32.const -24)
            )
           )
          )
         )
         (get_local $1)
        )
        (i32.const 896)
       )
       (br_if $label$11
        (get_local $26)
       )
       (br $label$8)
      )
      (br_if $label$8
       (i32.lt_s
        (tee_local $26
         (call $db_find_i64
          (i64.load
           (get_local $1)
          )
          (i64.load
           (get_local $17)
          )
          (i64.const -2507752926491967488)
          (get_local $22)
         )
        )
        (i32.const 0)
       )
      )
      (call $eosio_assert
       (i32.eq
        (i32.load offset=36
         (tee_local $26
          (call $_ZNK5eosio11multi_indexILy15938991147217584128E4voteJNS_10indexed_byILy4587895300147904512EN5boost11multi_index13const_mem_funIS1_yXadL_ZNKS1_8by_proxyEvEEEEEEEE31load_object_by_primary_iteratorEl
           (get_local $1)
           (get_local $26)
          )
         )
        )
        (get_local $1)
       )
       (i32.const 896)
      )
     )
     (set_local $22
      (i64.load
       (get_local $0)
      )
     )
     (i32.store offset=88
      (get_local $28)
      (i32.add
       (get_local $28)
       (i32.const 8)
      )
     )
     (call $eosio_assert
      (i32.const 1)
      (i32.const 960)
     )
     (call $_ZN5eosio11multi_indexILy15938991147217584128E4voteJNS_10indexed_byILy4587895300147904512EN5boost11multi_index13const_mem_funIS1_yXadL_ZNKS1_8by_proxyEvEEEEEEEE6modifyIZN12daccustodian13tallyNewVotesEvEUlRS1_E0_EEvRKS1_yOT_
      (get_local $1)
      (get_local $26)
      (get_local $22)
      (i32.add
       (get_local $28)
       (i32.const 88)
      )
     )
    )
    (i64.store offset=88
     (get_local $28)
     (i64.load align=4
      (get_local $3)
     )
    )
    (block $label$13
     (br_if $label$13
      (i64.ne
       (i64.load offset=8
        (i32.load offset=4
         (call $_ZN5eosio11multi_indexILy15938991147217584128E4voteJNS_10indexed_byILy4587895300147904512EN5boost11multi_index13const_mem_funIS1_yXadL_ZNKS1_8by_proxyEvEEEEEEEE5indexILy4587895300147904512ES6_Ly0ELb0EE14const_iteratormmEv
          (i32.add
           (get_local $28)
           (i32.const 88)
          )
         )
        )
       )
       (i64.const 0)
      )
     )
     (i64.store offset=88
      (get_local $28)
      (i64.load align=4
       (get_local $3)
      )
     )
     (br_if $label$13
      (i32.eq
       (tee_local $25
        (i32.load offset=24
         (tee_local $26
          (i32.load offset=4
           (call $_ZN5eosio11multi_indexILy15938991147217584128E4voteJNS_10indexed_byILy4587895300147904512EN5boost11multi_index13const_mem_funIS1_yXadL_ZNKS1_8by_proxyEvEEEEEEEE5indexILy4587895300147904512ES6_Ly0ELb0EE14const_iteratormmEv
            (i32.add
             (get_local $28)
             (i32.const 88)
            )
           )
          )
         )
        )
       )
       (tee_local $6
        (i32.load
         (i32.add
          (get_local $26)
          (i32.const 28)
         )
        )
       )
      )
     )
     (loop $label$14
      (set_local $22
       (i64.load
        (get_local $25)
       )
      )
      (block $label$15
       (br_if $label$15
        (i32.eq
         (tee_local $27
          (i32.load
           (get_local $19)
          )
         )
         (tee_local $7
          (i32.load
           (get_local $18)
          )
         )
        )
       )
       (set_local $26
        (i32.add
         (get_local $27)
         (i32.const -24)
        )
       )
       (set_local $8
        (i32.sub
         (i32.const 0)
         (get_local $7)
        )
       )
       (loop $label$16
        (br_if $label$15
         (i64.eq
          (i64.load
           (i32.load
            (get_local $26)
           )
          )
          (get_local $22)
         )
        )
        (set_local $27
         (get_local $26)
        )
        (set_local $26
         (tee_local $9
          (i32.add
           (get_local $26)
           (i32.const -24)
          )
         )
        )
        (br_if $label$16
         (i32.ne
          (i32.add
           (get_local $9)
           (get_local $8)
          )
          (i32.const -24)
         )
        )
       )
      )
      (block $label$17
       (block $label$18
        (br_if $label$18
         (i32.eq
          (get_local $27)
          (get_local $7)
         )
        )
        (call $eosio_assert
         (i32.eq
          (i32.load offset=88
           (tee_local $26
            (i32.load
             (i32.add
              (get_local $27)
              (i32.const -24)
             )
            )
           )
          )
          (get_local $5)
         )
         (i32.const 896)
        )
        (br $label$17)
       )
       (set_local $26
        (i32.const 0)
       )
       (br_if $label$17
        (i32.lt_s
         (tee_local $9
          (call $db_find_i64
           (i64.load
            (get_local $5)
           )
           (i64.load
            (get_local $20)
           )
           (i64.const 4730634643120193536)
           (get_local $22)
          )
         )
         (i32.const 0)
        )
       )
       (call $eosio_assert
        (i32.eq
         (i32.load offset=88
          (tee_local $26
           (call $_ZNK5eosio11multi_indexILy4730634643120193536E9candidateJNS_10indexed_byILy8518361509820596224EN5boost11multi_index13const_mem_funIS1_oXadL_ZNKS1_22get_by_is_cust_and_payEvEEEEEENS2_ILy4591222642450628608ENS5_IS1_yXadL_ZNKS1_15by_number_votesEvEEEEEEEE31load_object_by_primary_iteratorEl
            (get_local $5)
            (get_local $9)
           )
          )
         )
         (get_local $5)
        )
        (i32.const 896)
       )
      )
      (set_local $22
       (i64.load
        (get_local $0)
       )
      )
      (i32.store offset=88
       (get_local $28)
       (i32.add
        (get_local $28)
        (i32.const 56)
       )
      )
      (call $eosio_assert
       (i32.ne
        (get_local $26)
        (i32.const 0)
       )
       (i32.const 960)
      )
      (call $_ZN5eosio11multi_indexILy4730634643120193536E9candidateJNS_10indexed_byILy8518361509820596224EN5boost11multi_index13const_mem_funIS1_oXadL_ZNKS1_22get_by_is_cust_and_payEvEEEEEENS2_ILy4591222642450628608ENS5_IS1_yXadL_ZNKS1_15by_number_votesEvEEEEEEEE6modifyIZN12daccustodian13tallyNewVotesEvEUlRT_E_EEvRKS1_yOSD_
       (get_local $5)
       (get_local $26)
       (get_local $22)
       (i32.add
        (get_local $28)
        (i32.const 88)
       )
      )
      (br_if $label$14
       (i32.ne
        (tee_local $25
         (i32.add
          (get_local $25)
          (i32.const 8)
         )
        )
        (get_local $6)
       )
      )
     )
    )
    (drop
     (call $_ZN5eosio11multi_indexILy15938991147217584128E4voteJNS_10indexed_byILy4587895300147904512EN5boost11multi_index13const_mem_funIS1_yXadL_ZNKS1_8by_proxyEvEEEEEEEE5indexILy4587895300147904512ES6_Ly0ELb0EE14const_iteratormmEv
      (get_local $3)
     )
    )
    (block $label$19
     (br_if $label$19
      (i32.eqz
       (tee_local $27
        (i32.load
         (get_local $12)
        )
       )
      )
     )
     (block $label$20
      (block $label$21
       (br_if $label$21
        (i32.eq
         (tee_local $26
          (i32.load
           (tee_local $8
            (i32.add
             (i32.add
              (get_local $28)
              (i32.const 16)
             )
             (i32.const 28)
            )
           )
          )
         )
         (get_local $27)
        )
       )
       (loop $label$22
        (set_local $9
         (i32.load
          (tee_local $26
           (i32.add
            (get_local $26)
            (i32.const -24)
           )
          )
         )
        )
        (i32.store
         (get_local $26)
         (i32.const 0)
        )
        (block $label$23
         (br_if $label$23
          (i32.eqz
           (get_local $9)
          )
         )
         (call $_ZdlPv
          (get_local $9)
         )
        )
        (br_if $label$22
         (i32.ne
          (get_local $27)
          (get_local $26)
         )
        )
       )
       (set_local $26
        (i32.load
         (get_local $12)
        )
       )
       (br $label$20)
      )
      (set_local $26
       (get_local $27)
      )
     )
     (i32.store
      (get_local $8)
      (get_local $27)
     )
     (call $_ZdlPv
      (get_local $26)
     )
    )
    (br_if $label$1
     (i32.ne
      (i32.load
       (get_local $10)
      )
      (get_local $4)
     )
    )
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $28)
    (i32.const 96)
   )
  )
 )
 (func $_ZN12daccustodian22configureForNextPeriodEv (param $0 i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i64)
  (local $7 i32)
  (local $8 i32)
  (i32.store offset=4
   (i32.const 0)
   (tee_local $8
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 80)
    )
   )
  )
  (i32.store offset=64
   (get_local $8)
   (tee_local $1
    (i32.add
     (get_local $0)
     (i32.const 48)
    )
   )
  )
  (i32.store
   (i32.add
    (i32.add
     (get_local $8)
     (i32.const 40)
    )
    (i32.const 8)
   )
   (i32.const 0)
  )
  (i32.store
   (tee_local $4
    (i32.add
     (get_local $8)
     (i32.const 56)
    )
   )
   (i32.const 0)
  )
  (i32.store offset=44
   (get_local $8)
   (i32.add
    (get_local $8)
    (i32.const 64)
   )
  )
  (i32.store offset=52
   (get_local $8)
   (i32.add
    (get_local $8)
    (i32.const 64)
   )
  )
  (i64.store offset=8
   (get_local $8)
   (i64.const 0)
  )
  (call $_ZNK5eosio11multi_indexILy4730634643120193536E9candidateJNS_10indexed_byILy8518361509820596224EN5boost11multi_index13const_mem_funIS1_oXadL_ZNKS1_22get_by_is_cust_and_payEvEEEEEENS2_ILy4591222642450628608ENS5_IS1_yXadL_ZNKS1_15by_number_votesEvEEEEEEEE5indexILy4591222642450628608ES8_Ly1ELb0EE11lower_boundERKy
   (i32.add
    (get_local $8)
    (i32.const 72)
   )
   (i32.add
    (get_local $8)
    (i32.const 64)
   )
   (i32.add
    (get_local $8)
    (i32.const 8)
   )
  )
  (set_local $3
   (i32.load offset=76
    (get_local $8)
   )
  )
  (i32.store offset=72
   (get_local $8)
   (i32.const 0)
  )
  (call $_ZN12daccustodian7configsEv
   (i32.add
    (get_local $8)
    (i32.const 8)
   )
   (get_local $0)
  )
  (i32.store offset=36
   (get_local $8)
   (i32.load8_u offset=25
    (get_local $8)
   )
  )
  (block $label$0
   (br_if $label$0
    (i32.eqz
     (get_local $3)
    )
   )
   (set_local $2
    (i32.add
     (get_local $8)
     (i32.const 52)
    )
   )
   (set_local $7
    (i32.add
     (i32.add
      (get_local $8)
      (i32.const 8)
     )
     (i32.const 8)
    )
   )
   (loop $label$1
    (i64.store offset=8
     (get_local $8)
     (i64.load align=4
      (get_local $2)
     )
    )
    (set_local $5
     (i32.load offset=4
      (call $_ZN5eosio11multi_indexILy4730634643120193536E9candidateJNS_10indexed_byILy8518361509820596224EN5boost11multi_index13const_mem_funIS1_oXadL_ZNKS1_22get_by_is_cust_and_payEvEEEEEENS2_ILy4591222642450628608ENS5_IS1_yXadL_ZNKS1_15by_number_votesEvEEEEEEEE5indexILy4591222642450628608ES8_Ly1ELb0EE14const_iteratormmEv
       (i32.add
        (get_local $8)
        (i32.const 8)
       )
      )
     )
    )
    (set_local $6
     (i64.load
      (get_local $0)
     )
    )
    (i32.store
     (get_local $7)
     (get_local $0)
    )
    (i32.store offset=12
     (get_local $8)
     (i32.add
      (get_local $8)
      (i32.const 36)
     )
    )
    (i32.store offset=8
     (get_local $8)
     (i32.add
      (get_local $8)
      (i32.const 72)
     )
    )
    (call $_ZN5eosio11multi_indexILy4730634643120193536E9candidateJNS_10indexed_byILy8518361509820596224EN5boost11multi_index13const_mem_funIS1_oXadL_ZNKS1_22get_by_is_cust_and_payEvEEEEEENS2_ILy4591222642450628608ENS5_IS1_yXadL_ZNKS1_15by_number_votesEvEEEEEEEE6modifyIZN12daccustodian22configureForNextPeriodEvEUlRS1_E_EEvRKS1_yOT_
     (get_local $1)
     (get_local $5)
     (get_local $6)
     (i32.add
      (get_local $8)
      (i32.const 8)
     )
    )
    (drop
     (call $_ZN5eosio11multi_indexILy4730634643120193536E9candidateJNS_10indexed_byILy8518361509820596224EN5boost11multi_index13const_mem_funIS1_oXadL_ZNKS1_22get_by_is_cust_and_payEvEEEEEENS2_ILy4591222642450628608ENS5_IS1_yXadL_ZNKS1_15by_number_votesEvEEEEEEEE5indexILy4591222642450628608ES8_Ly1ELb0EE14const_iteratormmEv
      (get_local $2)
     )
    )
    (i32.store offset=72
     (get_local $8)
     (i32.add
      (i32.load offset=72
       (get_local $8)
      )
      (i32.const 1)
     )
    )
    (br_if $label$1
     (i32.ne
      (i32.load
       (get_local $4)
      )
      (get_local $3)
     )
    )
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $8)
    (i32.const 80)
   )
  )
 )
 (func $_ZNK5eosio11multi_indexILy4730634643120193536E9candidateJNS_10indexed_byILy8518361509820596224EN5boost11multi_index13const_mem_funIS1_oXadL_ZNKS1_22get_by_is_cust_and_payEvEEEEEENS2_ILy4591222642450628608ENS5_IS1_yXadL_ZNKS1_15by_number_votesEvEEEEEEEE5indexILy4591222642450628608ES8_Ly1ELb0EE11lower_boundERKy (param $0 i32) (param $1 i32) (param $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i64)
  (local $6 i32)
  (local $7 i32)
  (local $8 i32)
  (local $9 i32)
  (local $10 i32)
  (i32.store offset=4
   (i32.const 0)
   (tee_local $10
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 16)
    )
   )
  )
  (i64.store offset=8
   (get_local $10)
   (i64.const 0)
  )
  (i64.store
   (get_local $10)
   (i64.load
    (get_local $2)
   )
  )
  (set_local $2
   (i32.const 0)
  )
  (block $label$0
   (br_if $label$0
    (i32.lt_s
     (tee_local $3
      (call $db_idx64_lowerbound
       (i64.load
        (tee_local $8
         (i32.load
          (get_local $1)
         )
        )
       )
       (i64.load offset=8
        (get_local $8)
       )
       (i64.const 4730634643120193537)
       (get_local $10)
       (i32.add
        (get_local $10)
        (i32.const 8)
       )
      )
     )
     (i32.const 0)
    )
   )
   (set_local $5
    (i64.load offset=8
     (get_local $10)
    )
   )
   (block $label$1
    (br_if $label$1
     (i32.eq
      (tee_local $9
       (i32.load
        (i32.add
         (tee_local $4
          (i32.load
           (get_local $1)
          )
         )
         (i32.const 28)
        )
       )
      )
      (tee_local $6
       (i32.load offset=24
        (get_local $4)
       )
      )
     )
    )
    (set_local $2
     (i32.add
      (get_local $9)
      (i32.const -24)
     )
    )
    (set_local $7
     (i32.sub
      (i32.const 0)
      (get_local $6)
     )
    )
    (loop $label$2
     (br_if $label$1
      (i64.eq
       (i64.load
        (i32.load
         (get_local $2)
        )
       )
       (get_local $5)
      )
     )
     (set_local $9
      (get_local $2)
     )
     (set_local $2
      (tee_local $8
       (i32.add
        (get_local $2)
        (i32.const -24)
       )
      )
     )
     (br_if $label$2
      (i32.ne
       (i32.add
        (get_local $8)
        (get_local $7)
       )
       (i32.const -24)
      )
     )
    )
   )
   (block $label$3
    (block $label$4
     (br_if $label$4
      (i32.eq
       (get_local $9)
       (get_local $6)
      )
     )
     (call $eosio_assert
      (i32.eq
       (i32.load offset=88
        (tee_local $2
         (i32.load
          (i32.add
           (get_local $9)
           (i32.const -24)
          )
         )
        )
       )
       (get_local $4)
      )
      (i32.const 896)
     )
     (br $label$3)
    )
    (call $eosio_assert
     (i32.eq
      (i32.load offset=88
       (tee_local $2
        (call $_ZNK5eosio11multi_indexILy4730634643120193536E9candidateJNS_10indexed_byILy8518361509820596224EN5boost11multi_index13const_mem_funIS1_oXadL_ZNKS1_22get_by_is_cust_and_payEvEEEEEENS2_ILy4591222642450628608ENS5_IS1_yXadL_ZNKS1_15by_number_votesEvEEEEEEEE31load_object_by_primary_iteratorEl
         (get_local $4)
         (call $db_find_i64
          (i64.load
           (get_local $4)
          )
          (i64.load offset=8
           (get_local $4)
          )
          (i64.const 4730634643120193536)
          (get_local $5)
         )
        )
       )
      )
      (get_local $4)
     )
     (i32.const 896)
    )
   )
   (i32.store
    (i32.add
     (get_local $2)
     (i32.const 100)
    )
    (get_local $3)
   )
  )
  (i32.store offset=4
   (get_local $0)
   (get_local $2)
  )
  (i32.store
   (get_local $0)
   (get_local $1)
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $10)
    (i32.const 16)
   )
  )
 )
 (func $_ZN12daccustodian7configsEv (param $0 i32) (param $1 i32)
  (local $2 i32)
  (local $3 i64)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (i32.store offset=4
   (i32.const 0)
   (tee_local $6
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 32)
    )
   )
  )
  (i64.store offset=8
   (get_local $6)
   (i64.const 100000)
  )
  (i64.store offset=24
   (get_local $6)
   (i64.const 0)
  )
  (i64.store offset=16
   (get_local $6)
   (i64.const 18930585150899460)
  )
  (call $eosio_assert
   (i32.const 1)
   (i32.const 480)
  )
  (set_local $2
   (i32.add
    (get_local $1)
    (i32.const 8)
   )
  )
  (set_local $3
   (i64.const 73947598245701)
  )
  (set_local $4
   (i32.const 0)
  )
  (block $label$0
   (block $label$1
    (loop $label$2
     (br_if $label$1
      (i32.gt_u
       (i32.add
        (i32.shl
         (i32.wrap/i64
          (get_local $3)
         )
         (i32.const 24)
        )
        (i32.const -1073741825)
       )
       (i32.const 452984830)
      )
     )
     (block $label$3
      (br_if $label$3
       (i64.ne
        (i64.and
         (tee_local $3
          (i64.shr_u
           (get_local $3)
           (i64.const 8)
          )
         )
         (i64.const 255)
        )
        (i64.const 0)
       )
      )
      (loop $label$4
       (br_if $label$1
        (i64.ne
         (i64.and
          (tee_local $3
           (i64.shr_u
            (get_local $3)
            (i64.const 8)
           )
          )
          (i64.const 255)
         )
         (i64.const 0)
        )
       )
       (br_if $label$4
        (i32.lt_s
         (tee_local $4
          (i32.add
           (get_local $4)
           (i32.const 1)
          )
         )
         (i32.const 7)
        )
       )
      )
     )
     (set_local $5
      (i32.const 1)
     )
     (br_if $label$2
      (i32.lt_s
       (tee_local $4
        (i32.add
         (get_local $4)
         (i32.const 1)
        )
       )
       (i32.const 7)
      )
     )
     (br $label$0)
    )
   )
   (set_local $5
    (i32.const 0)
   )
  )
  (call $eosio_assert
   (get_local $5)
   (i32.const 544)
  )
  (i32.store16 offset=24
   (get_local $6)
   (i32.const 773)
  )
  (block $label$5
   (block $label$6
    (br_if $label$6
     (i32.eq
      (tee_local $4
       (i32.load
        (i32.add
         (get_local $1)
         (i32.const 36)
        )
       )
      )
      (i32.load
       (i32.add
        (get_local $1)
        (i32.const 32)
       )
      )
     )
    )
    (call $eosio_assert
     (i32.eq
      (i32.load offset=24
       (tee_local $4
        (i32.load
         (i32.add
          (get_local $4)
          (i32.const -24)
         )
        )
       )
      )
      (get_local $2)
     )
     (i32.const 896)
    )
    (br_if $label$5
     (get_local $4)
    )
    (set_local $4
     (i32.add
      (get_local $6)
      (i32.const 8)
     )
    )
    (br $label$5)
   )
   (block $label$7
    (br_if $label$7
     (i32.lt_s
      (tee_local $4
       (call $db_find_i64
        (i64.load
         (i32.add
          (get_local $1)
          (i32.const 8)
         )
        )
        (i64.load
         (i32.add
          (get_local $1)
          (i32.const 16)
         )
        )
        (i64.const 4982871454518345728)
        (i64.const 4982871454518345728)
       )
      )
      (i32.const 0)
     )
    )
    (call $eosio_assert
     (i32.eq
      (i32.load offset=24
       (tee_local $4
        (call $_ZNK5eosio11multi_indexILy4982871454518345728ENS_9singletonILy4982871454518345728E15contract_configE3rowEJEE31load_object_by_primary_iteratorEl
         (get_local $2)
         (get_local $4)
        )
       )
      )
      (get_local $2)
     )
     (i32.const 896)
    )
    (br $label$5)
   )
   (set_local $4
    (i32.add
     (get_local $6)
     (i32.const 8)
    )
   )
  )
  (i64.store
   (get_local $0)
   (i64.load
    (get_local $4)
   )
  )
  (i64.store
   (i32.add
    (get_local $0)
    (i32.const 16)
   )
   (i64.load
    (i32.add
     (get_local $4)
     (i32.const 16)
    )
   )
  )
  (i64.store
   (i32.add
    (get_local $0)
    (i32.const 8)
   )
   (i64.load
    (i32.add
     (get_local $4)
     (i32.const 8)
    )
   )
  )
  (call $_ZN5eosio9singletonILy4982871454518345728E15contract_configE3setERKS1_y
   (get_local $2)
   (get_local $0)
   (i64.load
    (get_local $1)
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $6)
    (i32.const 32)
   )
  )
 )
 (func $_ZN5eosio11multi_indexILy4730634643120193536E9candidateJNS_10indexed_byILy8518361509820596224EN5boost11multi_index13const_mem_funIS1_oXadL_ZNKS1_22get_by_is_cust_and_payEvEEEEEENS2_ILy4591222642450628608ENS5_IS1_yXadL_ZNKS1_15by_number_votesEvEEEEEEEE5indexILy4591222642450628608ES8_Ly1ELb0EE14const_iteratormmEv (param $0 i32) (result i32)
  (local $1 i32)
  (local $2 i64)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (local $8 i32)
  (local $9 i32)
  (i32.store offset=4
   (i32.const 0)
   (tee_local $9
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 16)
    )
   )
  )
  (i64.store offset=8
   (get_local $9)
   (i64.const 0)
  )
  (block $label$0
   (block $label$1
    (br_if $label$1
     (i32.eqz
      (tee_local $7
       (i32.load offset=4
        (get_local $0)
       )
      )
     )
    )
    (block $label$2
     (br_if $label$2
      (i32.ne
       (tee_local $5
        (i32.load
         (i32.add
          (get_local $7)
          (i32.const 100)
         )
        )
       )
       (i32.const -1)
      )
     )
     (set_local $5
      (call $db_idx64_find_primary
       (i64.load
        (tee_local $5
         (i32.load
          (i32.load
           (get_local $0)
          )
         )
        )
       )
       (i64.load offset=8
        (get_local $5)
       )
       (i64.const 4730634643120193537)
       (get_local $9)
       (i64.load
        (get_local $7)
       )
      )
     )
     (i32.store
      (i32.add
       (i32.load
        (i32.add
         (get_local $0)
         (i32.const 4)
        )
       )
       (i32.const 100)
      )
      (get_local $5)
     )
    )
    (call $eosio_assert
     (i32.xor
      (i32.shr_u
       (tee_local $6
        (call $db_idx64_previous
         (get_local $5)
         (i32.add
          (get_local $9)
          (i32.const 8)
         )
        )
       )
       (i32.const 31)
      )
      (i32.const 1)
     )
     (i32.const 848)
    )
    (br $label$0)
   )
   (call $eosio_assert
    (i32.ne
     (tee_local $7
      (call $db_idx64_end
       (i64.load
        (tee_local $7
         (i32.load
          (i32.load
           (get_local $0)
          )
         )
        )
       )
       (i64.load offset=8
        (get_local $7)
       )
       (i64.const 4730634643120193537)
      )
     )
     (i32.const -1)
    )
    (i32.const 784)
   )
   (call $eosio_assert
    (i32.xor
     (i32.shr_u
      (tee_local $6
       (call $db_idx64_previous
        (get_local $7)
        (i32.add
         (get_local $9)
         (i32.const 8)
        )
       )
      )
      (i32.const 31)
     )
     (i32.const 1)
    )
    (i32.const 784)
   )
  )
  (set_local $2
   (i64.load offset=8
    (get_local $9)
   )
  )
  (block $label$3
   (br_if $label$3
    (i32.eq
     (tee_local $8
      (i32.load
       (i32.add
        (tee_local $1
         (i32.load
          (i32.load
           (get_local $0)
          )
         )
        )
        (i32.const 28)
       )
      )
     )
     (tee_local $3
      (i32.load offset=24
       (get_local $1)
      )
     )
    )
   )
   (set_local $7
    (i32.add
     (get_local $8)
     (i32.const -24)
    )
   )
   (set_local $4
    (i32.sub
     (i32.const 0)
     (get_local $3)
    )
   )
   (loop $label$4
    (br_if $label$3
     (i64.eq
      (i64.load
       (i32.load
        (get_local $7)
       )
      )
      (get_local $2)
     )
    )
    (set_local $8
     (get_local $7)
    )
    (set_local $7
     (tee_local $5
      (i32.add
       (get_local $7)
       (i32.const -24)
      )
     )
    )
    (br_if $label$4
     (i32.ne
      (i32.add
       (get_local $5)
       (get_local $4)
      )
      (i32.const -24)
     )
    )
   )
  )
  (block $label$5
   (block $label$6
    (br_if $label$6
     (i32.eq
      (get_local $8)
      (get_local $3)
     )
    )
    (call $eosio_assert
     (i32.eq
      (i32.load offset=88
       (tee_local $7
        (i32.load
         (i32.add
          (get_local $8)
          (i32.const -24)
         )
        )
       )
      )
      (get_local $1)
     )
     (i32.const 896)
    )
    (br $label$5)
   )
   (call $eosio_assert
    (i32.eq
     (i32.load offset=88
      (tee_local $7
       (call $_ZNK5eosio11multi_indexILy4730634643120193536E9candidateJNS_10indexed_byILy8518361509820596224EN5boost11multi_index13const_mem_funIS1_oXadL_ZNKS1_22get_by_is_cust_and_payEvEEEEEENS2_ILy4591222642450628608ENS5_IS1_yXadL_ZNKS1_15by_number_votesEvEEEEEEEE31load_object_by_primary_iteratorEl
        (get_local $1)
        (call $db_find_i64
         (i64.load
          (get_local $1)
         )
         (i64.load offset=8
          (get_local $1)
         )
         (i64.const 4730634643120193536)
         (get_local $2)
        )
       )
      )
     )
     (get_local $1)
    )
    (i32.const 896)
   )
  )
  (i32.store
   (i32.add
    (get_local $0)
    (i32.const 4)
   )
   (get_local $7)
  )
  (i32.store
   (i32.add
    (get_local $7)
    (i32.const 100)
   )
   (get_local $6)
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $9)
    (i32.const 16)
   )
  )
  (get_local $0)
 )
 (func $_ZN5eosio11multi_indexILy4730634643120193536E9candidateJNS_10indexed_byILy8518361509820596224EN5boost11multi_index13const_mem_funIS1_oXadL_ZNKS1_22get_by_is_cust_and_payEvEEEEEENS2_ILy4591222642450628608ENS5_IS1_yXadL_ZNKS1_15by_number_votesEvEEEEEEEE6modifyIZN12daccustodian22configureForNextPeriodEvEUlRS1_E_EEvRKS1_yOT_ (param $0 i32) (param $1 i32) (param $2 i64) (param $3 i32)
  (local $4 i32)
  (local $5 i64)
  (local $6 i64)
  (local $7 i32)
  (local $8 i64)
  (local $9 i32)
  (local $10 i32)
  (i32.store offset=4
   (i32.const 0)
   (tee_local $10
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 96)
    )
   )
  )
  (i64.store offset=80
   (tee_local $9
    (get_local $10)
   )
   (get_local $2)
  )
  (call $eosio_assert
   (i32.eq
    (i32.load offset=88
     (get_local $1)
    )
    (get_local $0)
   )
   (i32.const 608)
  )
  (call $eosio_assert
   (i64.eq
    (i64.load
     (get_local $0)
    )
    (call $current_receiver)
   )
   (i32.const 656)
  )
  (i64.store offset=56
   (get_local $9)
   (i64.const 0)
  )
  (i64.store offset=64
   (get_local $9)
   (i64.load offset=80
    (get_local $1)
   )
  )
  (i64.store offset=48
   (get_local $9)
   (i64.or
    (i64.shl
     (i64.load8_u offset=56
      (get_local $1)
     )
     (i64.const 8)
    )
    (i64.load offset=24
     (get_local $1)
    )
   )
  )
  (i64.store offset=40
   (get_local $9)
   (tee_local $8
    (i64.load
     (get_local $1)
    )
   )
  )
  (i32.store8 offset=56
   (get_local $1)
   (i32.lt_s
    (i32.load
     (i32.load
      (get_local $3)
     )
    )
    (i32.load
     (i32.load offset=4
      (get_local $3)
     )
    )
   )
  )
  (set_local $6
   (get_local $8)
  )
  (block $label$0
   (br_if $label$0
    (i64.lt_s
     (i64.load offset=40
      (get_local $1)
     )
     (i64.const 1)
    )
   )
   (set_local $3
    (i32.load offset=8
     (get_local $3)
    )
   )
   (i64.store offset=24
    (get_local $1)
    (i64.load
     (tee_local $7
      (i32.add
       (get_local $1)
       (i32.const 40)
      )
     )
    )
   )
   (i64.store
    (i32.add
     (get_local $1)
     (i32.const 32)
    )
    (i64.load
     (i32.add
      (get_local $7)
      (i32.const 8)
     )
    )
   )
   (set_local $5
    (i64.load offset=256
     (get_local $3)
    )
   )
   (call $eosio_assert
    (i32.const 1)
    (i32.const 480)
   )
   (set_local $6
    (i64.shr_u
     (get_local $5)
     (i64.const 8)
    )
   )
   (set_local $3
    (i32.const 0)
   )
   (block $label$1
    (block $label$2
     (loop $label$3
      (br_if $label$2
       (i32.gt_u
        (i32.add
         (i32.shl
          (i32.wrap/i64
           (get_local $6)
          )
          (i32.const 24)
         )
         (i32.const -1073741825)
        )
        (i32.const 452984830)
       )
      )
      (block $label$4
       (br_if $label$4
        (i64.ne
         (i64.and
          (tee_local $6
           (i64.shr_u
            (get_local $6)
            (i64.const 8)
           )
          )
          (i64.const 255)
         )
         (i64.const 0)
        )
       )
       (loop $label$5
        (br_if $label$2
         (i64.ne
          (i64.and
           (tee_local $6
            (i64.shr_u
             (get_local $6)
             (i64.const 8)
            )
           )
           (i64.const 255)
          )
          (i64.const 0)
         )
        )
        (br_if $label$5
         (i32.lt_s
          (tee_local $3
           (i32.add
            (get_local $3)
            (i32.const 1)
           )
          )
          (i32.const 7)
         )
        )
       )
      )
      (set_local $7
       (i32.const 1)
      )
      (br_if $label$3
       (i32.lt_s
        (tee_local $3
         (i32.add
          (get_local $3)
          (i32.const 1)
         )
        )
        (i32.const 7)
       )
      )
      (br $label$1)
     )
    )
    (set_local $7
     (i32.const 0)
    )
   )
   (call $eosio_assert
    (get_local $7)
    (i32.const 544)
   )
   (i64.store
    (i32.add
     (get_local $1)
     (i32.const 48)
    )
    (get_local $5)
   )
   (i64.store offset=40
    (get_local $1)
    (i64.const 0)
   )
   (set_local $6
    (i64.load
     (get_local $1)
    )
   )
  )
  (set_local $4
   (i32.add
    (get_local $0)
    (i32.const 36)
   )
  )
  (call $eosio_assert
   (i64.eq
    (get_local $8)
    (get_local $6)
   )
   (i32.const 720)
  )
  (set_local $3
   (i32.add
    (tee_local $7
     (select
      (i32.load
       (i32.add
        (get_local $1)
        (i32.const 12)
       )
      )
      (i32.shr_u
       (tee_local $3
        (i32.load8_u offset=8
         (get_local $1)
        )
       )
       (i32.const 1)
      )
      (i32.and
       (get_local $3)
       (i32.const 1)
      )
     )
    )
    (i32.const 65)
   )
  )
  (set_local $6
   (i64.extend_u/i32
    (get_local $7)
   )
  )
  (loop $label$6
   (set_local $3
    (i32.add
     (get_local $3)
     (i32.const 1)
    )
   )
   (br_if $label$6
    (i64.ne
     (tee_local $6
      (i64.shr_u
       (get_local $6)
       (i64.const 7)
      )
     )
     (i64.const 0)
    )
   )
  )
  (block $label$7
   (block $label$8
    (br_if $label$8
     (i32.lt_u
      (get_local $3)
      (i32.const 513)
     )
    )
    (set_local $7
     (call $malloc
      (get_local $3)
     )
    )
    (br $label$7)
   )
   (i32.store offset=4
    (i32.const 0)
    (tee_local $7
     (i32.sub
      (get_local $10)
      (i32.and
       (i32.add
        (get_local $3)
        (i32.const 15)
       )
       (i32.const -16)
      )
     )
    )
   )
  )
  (i32.store offset=28
   (get_local $9)
   (get_local $7)
  )
  (i32.store offset=24
   (get_local $9)
   (get_local $7)
  )
  (i32.store offset=32
   (get_local $9)
   (i32.add
    (get_local $7)
    (get_local $3)
   )
  )
  (drop
   (call $_ZlsIN5eosio10datastreamIPcEEERT_S5_RK9candidate
    (i32.add
     (get_local $9)
     (i32.const 24)
    )
    (get_local $1)
   )
  )
  (call $db_update_i64
   (i32.load offset=92
    (get_local $1)
   )
   (get_local $2)
   (get_local $7)
   (get_local $3)
  )
  (block $label$9
   (br_if $label$9
    (i32.lt_u
     (get_local $3)
     (i32.const 513)
    )
   )
   (call $free
    (get_local $7)
   )
   (set_local $8
    (i64.load offset=40
     (get_local $9)
    )
   )
  )
  (block $label$10
   (br_if $label$10
    (i64.lt_u
     (get_local $8)
     (i64.load offset=16
      (get_local $0)
     )
    )
   )
   (i64.store
    (i32.add
     (get_local $0)
     (i32.const 16)
    )
    (select
     (i64.const -2)
     (i64.add
      (get_local $8)
      (i64.const 1)
     )
     (i64.gt_u
      (get_local $8)
      (i64.const -3)
     )
    )
   )
  )
  (i32.store offset=4
   (get_local $9)
   (get_local $1)
  )
  (i32.store
   (get_local $9)
   (get_local $0)
  )
  (i32.store offset=12
   (get_local $9)
   (get_local $1)
  )
  (i32.store offset=8
   (get_local $9)
   (i32.add
    (get_local $9)
    (i32.const 48)
   )
  )
  (i32.store offset=16
   (get_local $9)
   (i32.add
    (get_local $9)
    (i32.const 40)
   )
  )
  (i32.store offset=20
   (get_local $9)
   (i32.add
    (get_local $9)
    (i32.const 80)
   )
  )
  (i32.store offset=88
   (get_local $9)
   (get_local $9)
  )
  (call $_ZNK5boost4hana6detail7on_eachIPZN5eosio11multi_indexILy4730634643120193536E9candidateJNS3_10indexed_byILy8518361509820596224ENS_11multi_index13const_mem_funIS5_oXadL_ZNKS5_22get_by_is_cust_and_payEvEEEEEENS6_ILy4591222642450628608ENS8_IS5_yXadL_ZNKS5_15by_number_votesEvEEEEEEEE6modifyIZN12daccustodian22configureForNextPeriodEvEUlRS5_E_EEvRKS5_yOT_EUlRSK_E_EclIJRNS0_5tupleIJNS0_9type_implINSD_5indexILy8518361509820596224ES9_Ly0ELb0EEEE1_ENSS_INST_ILy8518361509820596224ES9_Ly0ELb1EEEE1_EEEERNSR_IJNSS_INST_ILy4591222642450628608ESB_Ly1ELb0EEEE1_ENSS_INST_ILy4591222642450628608ESB_Ly1ELb1EEEE1_EEEEEEEvDpOT_
   (i32.add
    (get_local $9)
    (i32.const 88)
   )
   (get_local $4)
   (i32.add
    (get_local $4)
    (i32.const 1)
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $9)
    (i32.const 96)
   )
  )
 )
 (func $_ZlsIN5eosio10datastreamIPcEEERT_S5_RK9candidate (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (call $eosio_assert
   (i32.gt_s
    (i32.sub
     (i32.load offset=8
      (get_local $0)
     )
     (i32.load offset=4
      (get_local $0)
     )
    )
    (i32.const 7)
   )
   (i32.const 432)
  )
  (drop
   (call $memcpy
    (i32.load offset=4
     (get_local $0)
    )
    (get_local $1)
    (i32.const 8)
   )
  )
  (i32.store offset=4
   (get_local $0)
   (i32.add
    (i32.load offset=4
     (get_local $0)
    )
    (i32.const 8)
   )
  )
  (call $eosio_assert
   (i32.gt_s
    (i32.sub
     (i32.load offset=8
      (tee_local $0
       (call $_ZN5eosiolsINS_10datastreamIPcEEEERT_S5_RKNSt3__112basic_stringIcNS6_11char_traitsIcEENS6_9allocatorIcEEEE
        (get_local $0)
        (i32.add
         (get_local $1)
         (i32.const 8)
        )
       )
      )
     )
     (i32.load offset=4
      (get_local $0)
     )
    )
    (i32.const 7)
   )
   (i32.const 432)
  )
  (drop
   (call $memcpy
    (i32.load offset=4
     (get_local $0)
    )
    (i32.add
     (get_local $1)
     (i32.const 24)
    )
    (i32.const 8)
   )
  )
  (i32.store offset=4
   (get_local $0)
   (tee_local $2
    (i32.add
     (i32.load offset=4
      (get_local $0)
     )
     (i32.const 8)
    )
   )
  )
  (call $eosio_assert
   (i32.gt_s
    (i32.sub
     (i32.load offset=8
      (get_local $0)
     )
     (get_local $2)
    )
    (i32.const 7)
   )
   (i32.const 432)
  )
  (drop
   (call $memcpy
    (i32.load offset=4
     (get_local $0)
    )
    (i32.add
     (get_local $1)
     (i32.const 32)
    )
    (i32.const 8)
   )
  )
  (i32.store offset=4
   (get_local $0)
   (tee_local $2
    (i32.add
     (i32.load offset=4
      (get_local $0)
     )
     (i32.const 8)
    )
   )
  )
  (call $eosio_assert
   (i32.gt_s
    (i32.sub
     (i32.load offset=8
      (get_local $0)
     )
     (get_local $2)
    )
    (i32.const 7)
   )
   (i32.const 432)
  )
  (drop
   (call $memcpy
    (i32.load offset=4
     (get_local $0)
    )
    (i32.add
     (get_local $1)
     (i32.const 40)
    )
    (i32.const 8)
   )
  )
  (i32.store offset=4
   (get_local $0)
   (tee_local $2
    (i32.add
     (i32.load offset=4
      (get_local $0)
     )
     (i32.const 8)
    )
   )
  )
  (call $eosio_assert
   (i32.gt_s
    (i32.sub
     (i32.load offset=8
      (get_local $0)
     )
     (get_local $2)
    )
    (i32.const 7)
   )
   (i32.const 432)
  )
  (drop
   (call $memcpy
    (i32.load offset=4
     (get_local $0)
    )
    (i32.add
     (get_local $1)
     (i32.const 48)
    )
    (i32.const 8)
   )
  )
  (i32.store offset=4
   (get_local $0)
   (tee_local $2
    (i32.add
     (i32.load offset=4
      (get_local $0)
     )
     (i32.const 8)
    )
   )
  )
  (call $eosio_assert
   (i32.gt_s
    (i32.sub
     (i32.load offset=8
      (get_local $0)
     )
     (get_local $2)
    )
    (i32.const 0)
   )
   (i32.const 432)
  )
  (drop
   (call $memcpy
    (i32.load offset=4
     (get_local $0)
    )
    (i32.add
     (get_local $1)
     (i32.const 56)
    )
    (i32.const 1)
   )
  )
  (i32.store offset=4
   (get_local $0)
   (tee_local $2
    (i32.add
     (i32.load offset=4
      (get_local $0)
     )
     (i32.const 1)
    )
   )
  )
  (call $eosio_assert
   (i32.gt_s
    (i32.sub
     (i32.load offset=8
      (get_local $0)
     )
     (get_local $2)
    )
    (i32.const 7)
   )
   (i32.const 432)
  )
  (drop
   (call $memcpy
    (i32.load offset=4
     (get_local $0)
    )
    (i32.add
     (get_local $1)
     (i32.const 64)
    )
    (i32.const 8)
   )
  )
  (i32.store offset=4
   (get_local $0)
   (tee_local $2
    (i32.add
     (i32.load offset=4
      (get_local $0)
     )
     (i32.const 8)
    )
   )
  )
  (call $eosio_assert
   (i32.gt_s
    (i32.sub
     (i32.load offset=8
      (get_local $0)
     )
     (get_local $2)
    )
    (i32.const 7)
   )
   (i32.const 432)
  )
  (drop
   (call $memcpy
    (i32.load offset=4
     (get_local $0)
    )
    (i32.add
     (get_local $1)
     (i32.const 72)
    )
    (i32.const 8)
   )
  )
  (i32.store offset=4
   (get_local $0)
   (tee_local $2
    (i32.add
     (i32.load offset=4
      (get_local $0)
     )
     (i32.const 8)
    )
   )
  )
  (call $eosio_assert
   (i32.gt_s
    (i32.sub
     (i32.load offset=8
      (get_local $0)
     )
     (get_local $2)
    )
    (i32.const 7)
   )
   (i32.const 432)
  )
  (drop
   (call $memcpy
    (i32.load offset=4
     (get_local $0)
    )
    (i32.add
     (get_local $1)
     (i32.const 80)
    )
    (i32.const 8)
   )
  )
  (i32.store offset=4
   (get_local $0)
   (i32.add
    (i32.load offset=4
     (get_local $0)
    )
    (i32.const 8)
   )
  )
  (get_local $0)
 )
 (func $_ZNK5boost4hana6detail7on_eachIPZN5eosio11multi_indexILy4730634643120193536E9candidateJNS3_10indexed_byILy8518361509820596224ENS_11multi_index13const_mem_funIS5_oXadL_ZNKS5_22get_by_is_cust_and_payEvEEEEEENS6_ILy4591222642450628608ENS8_IS5_yXadL_ZNKS5_15by_number_votesEvEEEEEEEE6modifyIZN12daccustodian22configureForNextPeriodEvEUlRS5_E_EEvRKS5_yOT_EUlRSK_E_EclIJRNS0_5tupleIJNS0_9type_implINSD_5indexILy8518361509820596224ES9_Ly0ELb0EEEE1_ENSS_INST_ILy8518361509820596224ES9_Ly0ELb1EEEE1_EEEERNSR_IJNSS_INST_ILy4591222642450628608ESB_Ly1ELb0EEEE1_ENSS_INST_ILy4591222642450628608ESB_Ly1ELb1EEEE1_EEEEEEEvDpOT_ (param $0 i32) (param $1 i32) (param $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (i32.store offset=4
   (i32.const 0)
   (tee_local $6
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 32)
    )
   )
  )
  (set_local $4
   (i32.load
    (tee_local $3
     (i32.load
      (get_local $0)
     )
    )
   )
  )
  (set_local $5
   (i32.load offset=4
    (get_local $3)
   )
  )
  (i64.store offset=24
   (get_local $6)
   (i64.const 0)
  )
  (i64.store offset=16
   (get_local $6)
   (i64.or
    (i64.shl
     (i64.load8_u offset=56
      (get_local $5)
     )
     (i64.const 8)
    )
    (i64.load offset=24
     (get_local $5)
    )
   )
  )
  (block $label$0
   (br_if $label$0
    (i32.eqz
     (call $memcmp
      (i32.load offset=8
       (get_local $3)
      )
      (i32.add
       (get_local $6)
       (i32.const 16)
      )
      (i32.const 16)
     )
    )
   )
   (block $label$1
    (br_if $label$1
     (i32.gt_s
      (tee_local $5
       (i32.load offset=96
        (i32.load offset=12
         (get_local $3)
        )
       )
      )
      (i32.const -1)
     )
    )
    (set_local $5
     (call $db_idx128_find_primary
      (i64.load
       (get_local $4)
      )
      (i64.load offset=8
       (get_local $4)
      )
      (i64.const 4730634643120193536)
      (get_local $6)
      (i64.load
       (i32.load offset=16
        (get_local $3)
       )
      )
     )
    )
    (i32.store offset=96
     (i32.load
      (i32.add
       (get_local $3)
       (i32.const 12)
      )
     )
     (get_local $5)
    )
   )
   (call $db_idx128_update
    (get_local $5)
    (i64.load
     (i32.load offset=20
      (get_local $3)
     )
    )
    (i32.add
     (get_local $6)
     (i32.const 16)
    )
   )
  )
  (set_local $5
   (i32.load
    (tee_local $3
     (i32.load
      (get_local $0)
     )
    )
   )
  )
  (i64.store offset=16
   (get_local $6)
   (i64.load offset=80
    (i32.load offset=4
     (get_local $3)
    )
   )
  )
  (block $label$2
   (br_if $label$2
    (i32.eqz
     (call $memcmp
      (i32.add
       (i32.load offset=8
        (get_local $3)
       )
       (i32.const 16)
      )
      (i32.add
       (get_local $6)
       (i32.const 16)
      )
      (i32.const 8)
     )
    )
   )
   (block $label$3
    (br_if $label$3
     (i32.gt_s
      (tee_local $0
       (i32.load
        (i32.add
         (i32.load offset=12
          (get_local $3)
         )
         (i32.const 100)
        )
       )
      )
      (i32.const -1)
     )
    )
    (set_local $0
     (call $db_idx64_find_primary
      (i64.load
       (get_local $5)
      )
      (i64.load offset=8
       (get_local $5)
      )
      (i64.const 4730634643120193537)
      (get_local $6)
      (i64.load
       (i32.load offset=16
        (get_local $3)
       )
      )
     )
    )
    (i32.store
     (i32.add
      (i32.load
       (i32.add
        (get_local $3)
        (i32.const 12)
       )
      )
      (i32.const 100)
     )
     (get_local $0)
    )
   )
   (call $db_idx64_update
    (get_local $0)
    (i64.load
     (i32.load offset=20
      (get_local $3)
     )
    )
    (i32.add
     (get_local $6)
     (i32.const 16)
    )
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $6)
    (i32.const 32)
   )
  )
 )
 (func $_ZNK5eosio11multi_indexILy4730634643120193536E9candidateJNS_10indexed_byILy8518361509820596224EN5boost11multi_index13const_mem_funIS1_oXadL_ZNKS1_22get_by_is_cust_and_payEvEEEEEENS2_ILy4591222642450628608ENS5_IS1_yXadL_ZNKS1_15by_number_votesEvEEEEEEEE31load_object_by_primary_iteratorEl (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i64)
  (local $6 i32)
  (local $7 i32)
  (local $8 i32)
  (local $9 i32)
  (set_local $8
   (tee_local $9
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 48)
    )
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (get_local $9)
  )
  (block $label$0
   (br_if $label$0
    (i32.eq
     (tee_local $7
      (i32.load
       (i32.add
        (get_local $0)
        (i32.const 28)
       )
      )
     )
     (tee_local $2
      (i32.load offset=24
       (get_local $0)
      )
     )
    )
   )
   (set_local $3
    (i32.sub
     (i32.const 0)
     (get_local $2)
    )
   )
   (set_local $6
    (i32.add
     (get_local $7)
     (i32.const -24)
    )
   )
   (loop $label$1
    (br_if $label$0
     (i32.eq
      (i32.load
       (i32.add
        (get_local $6)
        (i32.const 16)
       )
      )
      (get_local $1)
     )
    )
    (set_local $7
     (get_local $6)
    )
    (set_local $6
     (tee_local $4
      (i32.add
       (get_local $6)
       (i32.const -24)
      )
     )
    )
    (br_if $label$1
     (i32.ne
      (i32.add
       (get_local $4)
       (get_local $3)
      )
      (i32.const -24)
     )
    )
   )
  )
  (block $label$2
   (block $label$3
    (br_if $label$3
     (i32.eq
      (get_local $7)
      (get_local $2)
     )
    )
    (set_local $6
     (i32.load
      (i32.add
       (get_local $7)
       (i32.const -24)
      )
     )
    )
    (br $label$2)
   )
   (call $eosio_assert
    (i32.xor
     (i32.shr_u
      (tee_local $6
       (call $db_get_i64
        (get_local $1)
        (i32.const 0)
        (i32.const 0)
       )
      )
      (i32.const 31)
     )
     (i32.const 1)
    )
    (i32.const 448)
   )
   (block $label$4
    (block $label$5
     (br_if $label$5
      (i32.lt_u
       (get_local $6)
       (i32.const 513)
      )
     )
     (set_local $4
      (call $malloc
       (get_local $6)
      )
     )
     (br $label$4)
    )
    (i32.store offset=4
     (i32.const 0)
     (tee_local $4
      (i32.sub
       (get_local $9)
       (i32.and
        (i32.add
         (get_local $6)
         (i32.const 15)
        )
        (i32.const -16)
       )
      )
     )
    )
   )
   (drop
    (call $db_get_i64
     (get_local $1)
     (get_local $4)
     (get_local $6)
    )
   )
   (i32.store offset=36
    (get_local $8)
    (get_local $4)
   )
   (i32.store offset=32
    (get_local $8)
    (get_local $4)
   )
   (i32.store offset=40
    (get_local $8)
    (i32.add
     (get_local $4)
     (get_local $6)
    )
   )
   (block $label$6
    (br_if $label$6
     (i32.lt_u
      (get_local $6)
      (i32.const 513)
     )
    )
    (call $free
     (get_local $4)
    )
   )
   (set_local $4
    (call $_ZN9candidateC2Ev
     (tee_local $6
      (call $_Znwj
       (i32.const 104)
      )
     )
    )
   )
   (i32.store offset=88
    (get_local $6)
    (get_local $0)
   )
   (drop
    (call $_ZrsIN5eosio10datastreamIPKcEEERT_S6_R9candidate
     (i32.add
      (get_local $8)
      (i32.const 32)
     )
     (get_local $4)
    )
   )
   (i32.store offset=96
    (get_local $6)
    (i32.const -1)
   )
   (i32.store offset=92
    (get_local $6)
    (get_local $1)
   )
   (i32.store offset=100
    (get_local $6)
    (i32.const -1)
   )
   (i32.store offset=24
    (get_local $8)
    (get_local $6)
   )
   (i64.store offset=16
    (get_local $8)
    (tee_local $5
     (i64.load
      (get_local $6)
     )
    )
   )
   (i32.store offset=12
    (get_local $8)
    (tee_local $7
     (i32.load offset=92
      (get_local $6)
     )
    )
   )
   (block $label$7
    (block $label$8
     (br_if $label$8
      (i32.ge_u
       (tee_local $4
        (i32.load
         (tee_local $1
          (i32.add
           (get_local $0)
           (i32.const 28)
          )
         )
        )
       )
       (i32.load
        (i32.add
         (get_local $0)
         (i32.const 32)
        )
       )
      )
     )
     (i64.store offset=8
      (get_local $4)
      (get_local $5)
     )
     (i32.store offset=16
      (get_local $4)
      (get_local $7)
     )
     (i32.store offset=24
      (get_local $8)
      (i32.const 0)
     )
     (i32.store
      (get_local $4)
      (get_local $6)
     )
     (i32.store
      (get_local $1)
      (i32.add
       (get_local $4)
       (i32.const 24)
      )
     )
     (br $label$7)
    )
    (call $_ZNSt3__16vectorIN5eosio11multi_indexILy4730634643120193536E9candidateJNS1_10indexed_byILy8518361509820596224EN5boost11multi_index13const_mem_funIS3_oXadL_ZNKS3_22get_by_is_cust_and_payEvEEEEEENS4_ILy4591222642450628608ENS7_IS3_yXadL_ZNKS3_15by_number_votesEvEEEEEEEE8item_ptrENS_9allocatorISD_EEE24__emplace_back_slow_pathIJNS_10unique_ptrINSC_4itemENS_14default_deleteISJ_EEEERNS1_4nameERlEEEvDpOT_
     (i32.add
      (get_local $0)
      (i32.const 24)
     )
     (i32.add
      (get_local $8)
      (i32.const 24)
     )
     (i32.add
      (get_local $8)
      (i32.const 16)
     )
     (i32.add
      (get_local $8)
      (i32.const 12)
     )
    )
   )
   (set_local $4
    (i32.load offset=24
     (get_local $8)
    )
   )
   (i32.store offset=24
    (get_local $8)
    (i32.const 0)
   )
   (br_if $label$2
    (i32.eqz
     (get_local $4)
    )
   )
   (block $label$9
    (br_if $label$9
     (i32.eqz
      (i32.and
       (i32.load8_u offset=8
        (get_local $4)
       )
       (i32.const 1)
      )
     )
    )
    (call $_ZdlPv
     (i32.load
      (i32.add
       (get_local $4)
       (i32.const 16)
      )
     )
    )
   )
   (call $_ZdlPv
    (get_local $4)
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $8)
    (i32.const 48)
   )
  )
  (get_local $6)
 )
 (func $_ZN9candidateC2Ev (param $0 i32) (result i32)
  (local $1 i64)
  (local $2 i32)
  (local $3 i32)
  (i64.store
   (get_local $0)
   (i64.const 0)
  )
  (i64.store offset=8 align=4
   (get_local $0)
   (i64.const 0)
  )
  (i64.store offset=24
   (get_local $0)
   (i64.const 0)
  )
  (set_local $2
   (i32.const 0)
  )
  (i32.store
   (i32.add
    (get_local $0)
    (i32.const 16)
   )
   (i32.const 0)
  )
  (i64.store
   (tee_local $3
    (i32.add
     (get_local $0)
     (i32.const 32)
    )
   )
   (i64.const 1398362884)
  )
  (call $eosio_assert
   (i32.const 1)
   (i32.const 480)
  )
  (set_local $1
   (i64.shr_u
    (i64.load
     (get_local $3)
    )
    (i64.const 8)
   )
  )
  (block $label$0
   (block $label$1
    (loop $label$2
     (br_if $label$1
      (i32.gt_u
       (i32.add
        (i32.shl
         (i32.wrap/i64
          (get_local $1)
         )
         (i32.const 24)
        )
        (i32.const -1073741825)
       )
       (i32.const 452984830)
      )
     )
     (block $label$3
      (br_if $label$3
       (i64.ne
        (i64.and
         (tee_local $1
          (i64.shr_u
           (get_local $1)
           (i64.const 8)
          )
         )
         (i64.const 255)
        )
        (i64.const 0)
       )
      )
      (loop $label$4
       (br_if $label$1
        (i64.ne
         (i64.and
          (tee_local $1
           (i64.shr_u
            (get_local $1)
            (i64.const 8)
           )
          )
          (i64.const 255)
         )
         (i64.const 0)
        )
       )
       (br_if $label$4
        (i32.lt_s
         (tee_local $2
          (i32.add
           (get_local $2)
           (i32.const 1)
          )
         )
         (i32.const 7)
        )
       )
      )
     )
     (set_local $3
      (i32.const 1)
     )
     (br_if $label$2
      (i32.lt_s
       (tee_local $2
        (i32.add
         (get_local $2)
         (i32.const 1)
        )
       )
       (i32.const 7)
      )
     )
     (br $label$0)
    )
   )
   (set_local $3
    (i32.const 0)
   )
  )
  (call $eosio_assert
   (get_local $3)
   (i32.const 544)
  )
  (i64.store
   (tee_local $2
    (i32.add
     (get_local $0)
     (i32.const 48)
    )
   )
   (i64.const 1398362884)
  )
  (i64.store offset=40
   (get_local $0)
   (i64.const 0)
  )
  (call $eosio_assert
   (i32.const 1)
   (i32.const 480)
  )
  (set_local $1
   (i64.shr_u
    (i64.load
     (get_local $2)
    )
    (i64.const 8)
   )
  )
  (set_local $2
   (i32.const 0)
  )
  (block $label$5
   (block $label$6
    (loop $label$7
     (br_if $label$6
      (i32.gt_u
       (i32.add
        (i32.shl
         (i32.wrap/i64
          (get_local $1)
         )
         (i32.const 24)
        )
        (i32.const -1073741825)
       )
       (i32.const 452984830)
      )
     )
     (block $label$8
      (br_if $label$8
       (i64.ne
        (i64.and
         (tee_local $1
          (i64.shr_u
           (get_local $1)
           (i64.const 8)
          )
         )
         (i64.const 255)
        )
        (i64.const 0)
       )
      )
      (loop $label$9
       (br_if $label$6
        (i64.ne
         (i64.and
          (tee_local $1
           (i64.shr_u
            (get_local $1)
            (i64.const 8)
           )
          )
          (i64.const 255)
         )
         (i64.const 0)
        )
       )
       (br_if $label$9
        (i32.lt_s
         (tee_local $2
          (i32.add
           (get_local $2)
           (i32.const 1)
          )
         )
         (i32.const 7)
        )
       )
      )
     )
     (set_local $3
      (i32.const 1)
     )
     (br_if $label$7
      (i32.lt_s
       (tee_local $2
        (i32.add
         (get_local $2)
         (i32.const 1)
        )
       )
       (i32.const 7)
      )
     )
     (br $label$5)
    )
   )
   (set_local $3
    (i32.const 0)
   )
  )
  (call $eosio_assert
   (get_local $3)
   (i32.const 544)
  )
  (i64.store
   (tee_local $2
    (i32.add
     (get_local $0)
     (i32.const 72)
    )
   )
   (i64.const 1398362884)
  )
  (i64.store offset=64
   (get_local $0)
   (i64.const 0)
  )
  (call $eosio_assert
   (i32.const 1)
   (i32.const 480)
  )
  (set_local $1
   (i64.shr_u
    (i64.load
     (get_local $2)
    )
    (i64.const 8)
   )
  )
  (set_local $2
   (i32.const 0)
  )
  (block $label$10
   (block $label$11
    (loop $label$12
     (br_if $label$11
      (i32.gt_u
       (i32.add
        (i32.shl
         (i32.wrap/i64
          (get_local $1)
         )
         (i32.const 24)
        )
        (i32.const -1073741825)
       )
       (i32.const 452984830)
      )
     )
     (block $label$13
      (br_if $label$13
       (i64.ne
        (i64.and
         (tee_local $1
          (i64.shr_u
           (get_local $1)
           (i64.const 8)
          )
         )
         (i64.const 255)
        )
        (i64.const 0)
       )
      )
      (loop $label$14
       (br_if $label$11
        (i64.ne
         (i64.and
          (tee_local $1
           (i64.shr_u
            (get_local $1)
            (i64.const 8)
           )
          )
          (i64.const 255)
         )
         (i64.const 0)
        )
       )
       (br_if $label$14
        (i32.lt_s
         (tee_local $2
          (i32.add
           (get_local $2)
           (i32.const 1)
          )
         )
         (i32.const 7)
        )
       )
      )
     )
     (set_local $3
      (i32.const 1)
     )
     (br_if $label$12
      (i32.lt_s
       (tee_local $2
        (i32.add
         (get_local $2)
         (i32.const 1)
        )
       )
       (i32.const 7)
      )
     )
     (br $label$10)
    )
   )
   (set_local $3
    (i32.const 0)
   )
  )
  (call $eosio_assert
   (get_local $3)
   (i32.const 544)
  )
  (get_local $0)
 )
 (func $_ZrsIN5eosio10datastreamIPKcEEERT_S6_R9candidate (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (call $eosio_assert
   (i32.gt_u
    (i32.sub
     (i32.load offset=8
      (get_local $0)
     )
     (i32.load offset=4
      (get_local $0)
     )
    )
    (i32.const 7)
   )
   (i32.const 576)
  )
  (drop
   (call $memcpy
    (get_local $1)
    (i32.load offset=4
     (get_local $0)
    )
    (i32.const 8)
   )
  )
  (i32.store offset=4
   (get_local $0)
   (i32.add
    (i32.load offset=4
     (get_local $0)
    )
    (i32.const 8)
   )
  )
  (call $eosio_assert
   (i32.gt_u
    (i32.sub
     (i32.load offset=8
      (tee_local $0
       (call $_ZN5eosiorsINS_10datastreamIPKcEEEERT_S6_RNSt3__112basic_stringIcNS7_11char_traitsIcEENS7_9allocatorIcEEEE
        (get_local $0)
        (i32.add
         (get_local $1)
         (i32.const 8)
        )
       )
      )
     )
     (i32.load offset=4
      (get_local $0)
     )
    )
    (i32.const 7)
   )
   (i32.const 576)
  )
  (drop
   (call $memcpy
    (i32.add
     (get_local $1)
     (i32.const 24)
    )
    (i32.load offset=4
     (get_local $0)
    )
    (i32.const 8)
   )
  )
  (i32.store offset=4
   (get_local $0)
   (tee_local $2
    (i32.add
     (i32.load offset=4
      (get_local $0)
     )
     (i32.const 8)
    )
   )
  )
  (call $eosio_assert
   (i32.gt_u
    (i32.sub
     (i32.load offset=8
      (get_local $0)
     )
     (get_local $2)
    )
    (i32.const 7)
   )
   (i32.const 576)
  )
  (drop
   (call $memcpy
    (i32.add
     (get_local $1)
     (i32.const 32)
    )
    (i32.load offset=4
     (get_local $0)
    )
    (i32.const 8)
   )
  )
  (i32.store offset=4
   (get_local $0)
   (tee_local $2
    (i32.add
     (i32.load offset=4
      (get_local $0)
     )
     (i32.const 8)
    )
   )
  )
  (call $eosio_assert
   (i32.gt_u
    (i32.sub
     (i32.load offset=8
      (get_local $0)
     )
     (get_local $2)
    )
    (i32.const 7)
   )
   (i32.const 576)
  )
  (drop
   (call $memcpy
    (i32.add
     (get_local $1)
     (i32.const 40)
    )
    (i32.load offset=4
     (get_local $0)
    )
    (i32.const 8)
   )
  )
  (i32.store offset=4
   (get_local $0)
   (tee_local $2
    (i32.add
     (i32.load offset=4
      (get_local $0)
     )
     (i32.const 8)
    )
   )
  )
  (call $eosio_assert
   (i32.gt_u
    (i32.sub
     (i32.load offset=8
      (get_local $0)
     )
     (get_local $2)
    )
    (i32.const 7)
   )
   (i32.const 576)
  )
  (drop
   (call $memcpy
    (i32.add
     (get_local $1)
     (i32.const 48)
    )
    (i32.load offset=4
     (get_local $0)
    )
    (i32.const 8)
   )
  )
  (i32.store offset=4
   (get_local $0)
   (tee_local $2
    (i32.add
     (i32.load offset=4
      (get_local $0)
     )
     (i32.const 8)
    )
   )
  )
  (call $eosio_assert
   (i32.ne
    (i32.load offset=8
     (get_local $0)
    )
    (get_local $2)
   )
   (i32.const 576)
  )
  (drop
   (call $memcpy
    (i32.add
     (get_local $1)
     (i32.const 56)
    )
    (i32.load offset=4
     (get_local $0)
    )
    (i32.const 1)
   )
  )
  (i32.store offset=4
   (get_local $0)
   (tee_local $2
    (i32.add
     (i32.load offset=4
      (get_local $0)
     )
     (i32.const 1)
    )
   )
  )
  (call $eosio_assert
   (i32.gt_u
    (i32.sub
     (i32.load offset=8
      (get_local $0)
     )
     (get_local $2)
    )
    (i32.const 7)
   )
   (i32.const 576)
  )
  (drop
   (call $memcpy
    (i32.add
     (get_local $1)
     (i32.const 64)
    )
    (i32.load offset=4
     (get_local $0)
    )
    (i32.const 8)
   )
  )
  (i32.store offset=4
   (get_local $0)
   (tee_local $2
    (i32.add
     (i32.load offset=4
      (get_local $0)
     )
     (i32.const 8)
    )
   )
  )
  (call $eosio_assert
   (i32.gt_u
    (i32.sub
     (i32.load offset=8
      (get_local $0)
     )
     (get_local $2)
    )
    (i32.const 7)
   )
   (i32.const 576)
  )
  (drop
   (call $memcpy
    (i32.add
     (get_local $1)
     (i32.const 72)
    )
    (i32.load offset=4
     (get_local $0)
    )
    (i32.const 8)
   )
  )
  (i32.store offset=4
   (get_local $0)
   (tee_local $2
    (i32.add
     (i32.load offset=4
      (get_local $0)
     )
     (i32.const 8)
    )
   )
  )
  (call $eosio_assert
   (i32.gt_u
    (i32.sub
     (i32.load offset=8
      (get_local $0)
     )
     (get_local $2)
    )
    (i32.const 7)
   )
   (i32.const 576)
  )
  (drop
   (call $memcpy
    (i32.add
     (get_local $1)
     (i32.const 80)
    )
    (i32.load offset=4
     (get_local $0)
    )
    (i32.const 8)
   )
  )
  (i32.store offset=4
   (get_local $0)
   (i32.add
    (i32.load offset=4
     (get_local $0)
    )
    (i32.const 8)
   )
  )
  (get_local $0)
 )
 (func $_ZNSt3__16vectorIN5eosio11multi_indexILy4730634643120193536E9candidateJNS1_10indexed_byILy8518361509820596224EN5boost11multi_index13const_mem_funIS3_oXadL_ZNKS3_22get_by_is_cust_and_payEvEEEEEENS4_ILy4591222642450628608ENS7_IS3_yXadL_ZNKS3_15by_number_votesEvEEEEEEEE8item_ptrENS_9allocatorISD_EEE24__emplace_back_slow_pathIJNS_10unique_ptrINSC_4itemENS_14default_deleteISJ_EEEERNS1_4nameERlEEEvDpOT_ (param $0 i32) (param $1 i32) (param $2 i32) (param $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (block $label$0
   (block $label$1
    (br_if $label$1
     (i32.ge_u
      (tee_local $5
       (i32.add
        (tee_local $4
         (i32.div_s
          (i32.sub
           (i32.load offset=4
            (get_local $0)
           )
           (tee_local $6
            (i32.load
             (get_local $0)
            )
           )
          )
          (i32.const 24)
         )
        )
        (i32.const 1)
       )
      )
      (i32.const 178956971)
     )
    )
    (set_local $7
     (i32.const 178956970)
    )
    (block $label$2
     (block $label$3
      (br_if $label$3
       (i32.gt_u
        (tee_local $6
         (i32.div_s
          (i32.sub
           (i32.load offset=8
            (get_local $0)
           )
           (get_local $6)
          )
          (i32.const 24)
         )
        )
        (i32.const 89478484)
       )
      )
      (br_if $label$2
       (i32.eqz
        (tee_local $7
         (select
          (get_local $5)
          (tee_local $7
           (i32.shl
            (get_local $6)
            (i32.const 1)
           )
          )
          (i32.lt_u
           (get_local $7)
           (get_local $5)
          )
         )
        )
       )
      )
     )
     (set_local $6
      (call $_Znwj
       (i32.mul
        (get_local $7)
        (i32.const 24)
       )
      )
     )
     (br $label$0)
    )
    (set_local $7
     (i32.const 0)
    )
    (set_local $6
     (i32.const 0)
    )
    (br $label$0)
   )
   (call $_ZNKSt3__120__vector_base_commonILb1EE20__throw_length_errorEv
    (get_local $0)
   )
   (unreachable)
  )
  (set_local $5
   (i32.load
    (get_local $1)
   )
  )
  (i32.store
   (get_local $1)
   (i32.const 0)
  )
  (i32.store
   (tee_local $1
    (i32.add
     (get_local $6)
     (i32.mul
      (get_local $4)
      (i32.const 24)
     )
    )
   )
   (get_local $5)
  )
  (i64.store offset=8
   (get_local $1)
   (i64.load
    (get_local $2)
   )
  )
  (i32.store offset=16
   (get_local $1)
   (i32.load
    (get_local $3)
   )
  )
  (set_local $4
   (i32.add
    (get_local $6)
    (i32.mul
     (get_local $7)
     (i32.const 24)
    )
   )
  )
  (set_local $5
   (i32.add
    (get_local $1)
    (i32.const 24)
   )
  )
  (block $label$4
   (block $label$5
    (br_if $label$5
     (i32.eq
      (tee_local $6
       (i32.load
        (i32.add
         (get_local $0)
         (i32.const 4)
        )
       )
      )
      (tee_local $7
       (i32.load
        (get_local $0)
       )
      )
     )
    )
    (loop $label$6
     (set_local $3
      (i32.load
       (tee_local $2
        (i32.add
         (get_local $6)
         (i32.const -24)
        )
       )
      )
     )
     (i32.store
      (get_local $2)
      (i32.const 0)
     )
     (i32.store
      (i32.add
       (get_local $1)
       (i32.const -24)
      )
      (get_local $3)
     )
     (i32.store
      (i32.add
       (get_local $1)
       (i32.const -8)
      )
      (i32.load
       (i32.add
        (get_local $6)
        (i32.const -8)
       )
      )
     )
     (i32.store
      (i32.add
       (get_local $1)
       (i32.const -12)
      )
      (i32.load
       (i32.add
        (get_local $6)
        (i32.const -12)
       )
      )
     )
     (i32.store
      (i32.add
       (get_local $1)
       (i32.const -16)
      )
      (i32.load
       (i32.add
        (get_local $6)
        (i32.const -16)
       )
      )
     )
     (set_local $1
      (i32.add
       (get_local $1)
       (i32.const -24)
      )
     )
     (set_local $6
      (get_local $2)
     )
     (br_if $label$6
      (i32.ne
       (get_local $7)
       (get_local $2)
      )
     )
    )
    (set_local $7
     (i32.load
      (i32.add
       (get_local $0)
       (i32.const 4)
      )
     )
    )
    (set_local $6
     (i32.load
      (get_local $0)
     )
    )
    (br $label$4)
   )
   (set_local $6
    (get_local $7)
   )
  )
  (i32.store
   (get_local $0)
   (get_local $1)
  )
  (i32.store
   (i32.add
    (get_local $0)
    (i32.const 4)
   )
   (get_local $5)
  )
  (i32.store
   (i32.add
    (get_local $0)
    (i32.const 8)
   )
   (get_local $4)
  )
  (block $label$7
   (br_if $label$7
    (i32.eq
     (get_local $7)
     (get_local $6)
    )
   )
   (loop $label$8
    (set_local $1
     (i32.load
      (tee_local $7
       (i32.add
        (get_local $7)
        (i32.const -24)
       )
      )
     )
    )
    (i32.store
     (get_local $7)
     (i32.const 0)
    )
    (block $label$9
     (br_if $label$9
      (i32.eqz
       (get_local $1)
      )
     )
     (block $label$10
      (br_if $label$10
       (i32.eqz
        (i32.and
         (i32.load8_u offset=8
          (get_local $1)
         )
         (i32.const 1)
        )
       )
      )
      (call $_ZdlPv
       (i32.load
        (i32.add
         (get_local $1)
         (i32.const 16)
        )
       )
      )
     )
     (call $_ZdlPv
      (get_local $1)
     )
    )
    (br_if $label$8
     (i32.ne
      (get_local $6)
      (get_local $7)
     )
    )
   )
  )
  (block $label$11
   (br_if $label$11
    (i32.eqz
     (get_local $6)
    )
   )
   (call $_ZdlPv
    (get_local $6)
   )
  )
 )
 (func $_ZNK5eosio11multi_indexILy4982871454518345728ENS_9singletonILy4982871454518345728E15contract_configE3rowEJEE31load_object_by_primary_iteratorEl (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i64)
  (local $8 i32)
  (local $9 i32)
  (set_local $8
   (tee_local $9
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 48)
    )
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (get_local $9)
  )
  (block $label$0
   (br_if $label$0
    (i32.eq
     (tee_local $6
      (i32.load
       (i32.add
        (get_local $0)
        (i32.const 28)
       )
      )
     )
     (tee_local $2
      (i32.load offset=24
       (get_local $0)
      )
     )
    )
   )
   (set_local $3
    (i32.sub
     (i32.const 0)
     (get_local $2)
    )
   )
   (set_local $5
    (i32.add
     (get_local $6)
     (i32.const -24)
    )
   )
   (loop $label$1
    (br_if $label$0
     (i32.eq
      (i32.load
       (i32.add
        (get_local $5)
        (i32.const 16)
       )
      )
      (get_local $1)
     )
    )
    (set_local $6
     (get_local $5)
    )
    (set_local $5
     (tee_local $4
      (i32.add
       (get_local $5)
       (i32.const -24)
      )
     )
    )
    (br_if $label$1
     (i32.ne
      (i32.add
       (get_local $4)
       (get_local $3)
      )
      (i32.const -24)
     )
    )
   )
  )
  (block $label$2
   (block $label$3
    (br_if $label$3
     (i32.eq
      (get_local $6)
      (get_local $2)
     )
    )
    (set_local $4
     (i32.load
      (i32.add
       (get_local $6)
       (i32.const -24)
      )
     )
    )
    (br $label$2)
   )
   (call $eosio_assert
    (i32.xor
     (i32.shr_u
      (tee_local $5
       (call $db_get_i64
        (get_local $1)
        (i32.const 0)
        (i32.const 0)
       )
      )
      (i32.const 31)
     )
     (i32.const 1)
    )
    (i32.const 448)
   )
   (block $label$4
    (block $label$5
     (br_if $label$5
      (i32.lt_u
       (get_local $5)
       (i32.const 513)
      )
     )
     (set_local $4
      (call $malloc
       (get_local $5)
      )
     )
     (br $label$4)
    )
    (i32.store offset=4
     (i32.const 0)
     (tee_local $4
      (i32.sub
       (get_local $9)
       (i32.and
        (i32.add
         (get_local $5)
         (i32.const 15)
        )
        (i32.const -16)
       )
      )
     )
    )
   )
   (drop
    (call $db_get_i64
     (get_local $1)
     (get_local $4)
     (get_local $5)
    )
   )
   (i32.store offset=36
    (get_local $8)
    (get_local $4)
   )
   (i32.store offset=32
    (get_local $8)
    (get_local $4)
   )
   (i32.store offset=40
    (get_local $8)
    (i32.add
     (get_local $4)
     (get_local $5)
    )
   )
   (block $label$6
    (br_if $label$6
     (i32.lt_u
      (get_local $5)
      (i32.const 513)
     )
    )
    (call $free
     (get_local $4)
    )
   )
   (set_local $3
    (i32.add
     (get_local $0)
     (i32.const 24)
    )
   )
   (i64.store offset=8
    (tee_local $4
     (call $_Znwj
      (i32.const 40)
     )
    )
    (i64.const 18930585150899460)
   )
   (i64.store
    (get_local $4)
    (i64.const 100000)
   )
   (call $eosio_assert
    (i32.const 1)
    (i32.const 480)
   )
   (set_local $7
    (i64.const 73947598245701)
   )
   (set_local $5
    (i32.const 0)
   )
   (block $label$7
    (block $label$8
     (loop $label$9
      (br_if $label$8
       (i32.gt_u
        (i32.add
         (i32.shl
          (i32.wrap/i64
           (get_local $7)
          )
          (i32.const 24)
         )
         (i32.const -1073741825)
        )
        (i32.const 452984830)
       )
      )
      (block $label$10
       (br_if $label$10
        (i64.ne
         (i64.and
          (tee_local $7
           (i64.shr_u
            (get_local $7)
            (i64.const 8)
           )
          )
          (i64.const 255)
         )
         (i64.const 0)
        )
       )
       (loop $label$11
        (br_if $label$8
         (i64.ne
          (i64.and
           (tee_local $7
            (i64.shr_u
             (get_local $7)
             (i64.const 8)
            )
           )
           (i64.const 255)
          )
          (i64.const 0)
         )
        )
        (br_if $label$11
         (i32.lt_s
          (tee_local $5
           (i32.add
            (get_local $5)
            (i32.const 1)
           )
          )
          (i32.const 7)
         )
        )
       )
      )
      (set_local $6
       (i32.const 1)
      )
      (br_if $label$9
       (i32.lt_s
        (tee_local $5
         (i32.add
          (get_local $5)
          (i32.const 1)
         )
        )
        (i32.const 7)
       )
      )
      (br $label$7)
     )
    )
    (set_local $6
     (i32.const 0)
    )
   )
   (call $eosio_assert
    (get_local $6)
    (i32.const 544)
   )
   (i32.store offset=24
    (get_local $4)
    (get_local $0)
   )
   (i32.store16 offset=16
    (get_local $4)
    (i32.const 773)
   )
   (drop
    (call $_ZrsIN5eosio10datastreamIPKcEEERT_S6_R15contract_config
     (i32.add
      (get_local $8)
      (i32.const 32)
     )
     (get_local $4)
    )
   )
   (i32.store offset=28
    (get_local $4)
    (get_local $1)
   )
   (i32.store offset=24
    (get_local $8)
    (get_local $4)
   )
   (i64.store offset=16
    (get_local $8)
    (i64.const 4982871454518345728)
   )
   (i32.store offset=12
    (get_local $8)
    (tee_local $6
     (i32.load offset=28
      (get_local $4)
     )
    )
   )
   (block $label$12
    (block $label$13
     (br_if $label$13
      (i32.ge_u
       (tee_local $5
        (i32.load
         (tee_local $1
          (i32.add
           (get_local $0)
           (i32.const 28)
          )
         )
        )
       )
       (i32.load
        (i32.add
         (get_local $0)
         (i32.const 32)
        )
       )
      )
     )
     (i64.store offset=8
      (get_local $5)
      (i64.const 4982871454518345728)
     )
     (i32.store offset=16
      (get_local $5)
      (get_local $6)
     )
     (i32.store offset=24
      (get_local $8)
      (i32.const 0)
     )
     (i32.store
      (get_local $5)
      (get_local $4)
     )
     (i32.store
      (get_local $1)
      (i32.add
       (get_local $5)
       (i32.const 24)
      )
     )
     (br $label$12)
    )
    (call $_ZNSt3__16vectorIN5eosio11multi_indexILy4982871454518345728ENS1_9singletonILy4982871454518345728E15contract_configE3rowEJEE8item_ptrENS_9allocatorIS8_EEE24__emplace_back_slow_pathIJNS_10unique_ptrINS7_4itemENS_14default_deleteISE_EEEERyRlEEEvDpOT_
     (get_local $3)
     (i32.add
      (get_local $8)
      (i32.const 24)
     )
     (i32.add
      (get_local $8)
      (i32.const 16)
     )
     (i32.add
      (get_local $8)
      (i32.const 12)
     )
    )
   )
   (set_local $5
    (i32.load offset=24
     (get_local $8)
    )
   )
   (i32.store offset=24
    (get_local $8)
    (i32.const 0)
   )
   (br_if $label$2
    (i32.eqz
     (get_local $5)
    )
   )
   (call $_ZdlPv
    (get_local $5)
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $8)
    (i32.const 48)
   )
  )
  (get_local $4)
 )
 (func $_ZN5eosio9singletonILy4982871454518345728E15contract_configE3setERKS1_y (param $0 i32) (param $1 i32) (param $2 i64)
  (local $3 i32)
  (local $4 i32)
  (i32.store offset=4
   (i32.const 0)
   (tee_local $4
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 16)
    )
   )
  )
  (block $label$0
   (block $label$1
    (block $label$2
     (block $label$3
      (br_if $label$3
       (i32.eq
        (tee_local $3
         (i32.load
          (i32.add
           (get_local $0)
           (i32.const 28)
          )
         )
        )
        (i32.load offset=24
         (get_local $0)
        )
       )
      )
      (call $eosio_assert
       (i32.eq
        (i32.load offset=24
         (tee_local $3
          (i32.load
           (i32.add
            (get_local $3)
            (i32.const -24)
           )
          )
         )
        )
        (get_local $0)
       )
       (i32.const 896)
      )
      (br_if $label$2
       (get_local $3)
      )
      (br $label$1)
     )
     (br_if $label$1
      (i32.lt_s
       (tee_local $3
        (call $db_find_i64
         (i64.load
          (get_local $0)
         )
         (i64.load offset=8
          (get_local $0)
         )
         (i64.const 4982871454518345728)
         (i64.const 4982871454518345728)
        )
       )
       (i32.const 0)
      )
     )
     (call $eosio_assert
      (i32.eq
       (i32.load offset=24
        (tee_local $3
         (call $_ZNK5eosio11multi_indexILy4982871454518345728ENS_9singletonILy4982871454518345728E15contract_configE3rowEJEE31load_object_by_primary_iteratorEl
          (get_local $0)
          (get_local $3)
         )
        )
       )
       (get_local $0)
      )
      (i32.const 896)
     )
    )
    (i32.store
     (get_local $4)
     (get_local $1)
    )
    (call $eosio_assert
     (i32.const 1)
     (i32.const 960)
    )
    (call $_ZN5eosio11multi_indexILy4982871454518345728ENS_9singletonILy4982871454518345728E15contract_configE3rowEJEE6modifyIZNS3_3setERKS2_yEUlRS4_E_EEvRKS4_yOT_
     (get_local $0)
     (get_local $3)
     (get_local $2)
     (get_local $4)
    )
    (br $label$0)
   )
   (i32.store offset=8
    (get_local $4)
    (get_local $1)
   )
   (call $_ZN5eosio11multi_indexILy4982871454518345728ENS_9singletonILy4982871454518345728E15contract_configE3rowEJEE7emplaceIZNS3_3setERKS2_yEUlRS4_E0_EENS5_14const_iteratorEyOT_
    (get_local $4)
    (get_local $0)
    (get_local $2)
    (i32.add
     (get_local $4)
     (i32.const 8)
    )
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $4)
    (i32.const 16)
   )
  )
 )
 (func $_ZN5eosio11multi_indexILy4982871454518345728ENS_9singletonILy4982871454518345728E15contract_configE3rowEJEE6modifyIZNS3_3setERKS2_yEUlRS4_E_EEvRKS4_yOT_ (param $0 i32) (param $1 i32) (param $2 i64) (param $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (i32.store offset=4
   (i32.const 0)
   (tee_local $6
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 32)
    )
   )
  )
  (call $eosio_assert
   (i32.eq
    (i32.load offset=24
     (get_local $1)
    )
    (get_local $0)
   )
   (i32.const 608)
  )
  (call $eosio_assert
   (i64.eq
    (i64.load
     (get_local $0)
    )
    (call $current_receiver)
   )
   (i32.const 656)
  )
  (i64.store
   (get_local $1)
   (i64.load
    (tee_local $3
     (i32.load
      (get_local $3)
     )
    )
   )
  )
  (i32.store16
   (tee_local $4
    (i32.add
     (get_local $1)
     (i32.const 16)
    )
   )
   (i32.load16_u
    (i32.add
     (get_local $3)
     (i32.const 16)
    )
   )
  )
  (i64.store
   (tee_local $5
    (i32.add
     (get_local $1)
     (i32.const 8)
    )
   )
   (i64.load
    (i32.add
     (get_local $3)
     (i32.const 8)
    )
   )
  )
  (call $eosio_assert
   (i32.const 1)
   (i32.const 720)
  )
  (call $eosio_assert
   (i32.const 1)
   (i32.const 432)
  )
  (drop
   (call $memcpy
    (get_local $6)
    (get_local $1)
    (i32.const 8)
   )
  )
  (call $eosio_assert
   (i32.const 1)
   (i32.const 432)
  )
  (drop
   (call $memcpy
    (i32.or
     (get_local $6)
     (i32.const 8)
    )
    (get_local $5)
    (i32.const 8)
   )
  )
  (call $eosio_assert
   (i32.const 1)
   (i32.const 432)
  )
  (drop
   (call $memcpy
    (i32.add
     (get_local $6)
     (i32.const 16)
    )
    (get_local $4)
    (i32.const 1)
   )
  )
  (call $eosio_assert
   (i32.const 1)
   (i32.const 432)
  )
  (drop
   (call $memcpy
    (i32.add
     (get_local $6)
     (i32.const 17)
    )
    (i32.add
     (get_local $1)
     (i32.const 17)
    )
    (i32.const 1)
   )
  )
  (call $db_update_i64
   (i32.load offset=28
    (get_local $1)
   )
   (get_local $2)
   (get_local $6)
   (i32.const 18)
  )
  (block $label$0
   (br_if $label$0
    (i64.gt_u
     (i64.load offset=16
      (get_local $0)
     )
     (i64.const 4982871454518345728)
    )
   )
   (i64.store
    (i32.add
     (get_local $0)
     (i32.const 16)
    )
    (i64.const 4982871454518345729)
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $6)
    (i32.const 32)
   )
  )
 )
 (func $_ZN5eosio11multi_indexILy4982871454518345728ENS_9singletonILy4982871454518345728E15contract_configE3rowEJEE7emplaceIZNS3_3setERKS2_yEUlRS4_E0_EENS5_14const_iteratorEyOT_ (param $0 i32) (param $1 i32) (param $2 i64) (param $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (i32.store offset=4
   (i32.const 0)
   (tee_local $7
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 48)
    )
   )
  )
  (i64.store offset=40
   (get_local $7)
   (get_local $2)
  )
  (call $eosio_assert
   (i64.eq
    (i64.load
     (get_local $1)
    )
    (call $current_receiver)
   )
   (i32.const 1008)
  )
  (i32.store offset=20
   (get_local $7)
   (get_local $3)
  )
  (i32.store offset=16
   (get_local $7)
   (get_local $1)
  )
  (i32.store offset=24
   (get_local $7)
   (i32.add
    (get_local $7)
    (i32.const 40)
   )
  )
  (i64.store offset=8
   (tee_local $4
    (call $_Znwj
     (i32.const 40)
    )
   )
   (i64.const 18930585150899460)
  )
  (i64.store
   (get_local $4)
   (i64.const 100000)
  )
  (call $eosio_assert
   (i32.const 1)
   (i32.const 480)
  )
  (set_local $2
   (i64.const 73947598245701)
  )
  (set_local $3
   (i32.const 0)
  )
  (block $label$0
   (block $label$1
    (loop $label$2
     (br_if $label$1
      (i32.gt_u
       (i32.add
        (i32.shl
         (i32.wrap/i64
          (get_local $2)
         )
         (i32.const 24)
        )
        (i32.const -1073741825)
       )
       (i32.const 452984830)
      )
     )
     (block $label$3
      (br_if $label$3
       (i64.ne
        (i64.and
         (tee_local $2
          (i64.shr_u
           (get_local $2)
           (i64.const 8)
          )
         )
         (i64.const 255)
        )
        (i64.const 0)
       )
      )
      (loop $label$4
       (br_if $label$1
        (i64.ne
         (i64.and
          (tee_local $2
           (i64.shr_u
            (get_local $2)
            (i64.const 8)
           )
          )
          (i64.const 255)
         )
         (i64.const 0)
        )
       )
       (br_if $label$4
        (i32.lt_s
         (tee_local $3
          (i32.add
           (get_local $3)
           (i32.const 1)
          )
         )
         (i32.const 7)
        )
       )
      )
     )
     (set_local $6
      (i32.const 1)
     )
     (br_if $label$2
      (i32.lt_s
       (tee_local $3
        (i32.add
         (get_local $3)
         (i32.const 1)
        )
       )
       (i32.const 7)
      )
     )
     (br $label$0)
    )
   )
   (set_local $6
    (i32.const 0)
   )
  )
  (call $eosio_assert
   (get_local $6)
   (i32.const 544)
  )
  (i32.store offset=24
   (get_local $4)
   (get_local $1)
  )
  (i32.store16 offset=16
   (get_local $4)
   (i32.const 773)
  )
  (call $_ZZN5eosio11multi_indexILy4982871454518345728ENS_9singletonILy4982871454518345728E15contract_configE3rowEJEE7emplaceIZNS3_3setERKS2_yEUlRS4_E0_EENS5_14const_iteratorEyOT_ENKUlRSC_E_clINS5_4itemEEEDaSE_
   (i32.add
    (get_local $7)
    (i32.const 16)
   )
   (get_local $4)
  )
  (i32.store offset=32
   (get_local $7)
   (get_local $4)
  )
  (i64.store offset=16
   (get_local $7)
   (i64.const 4982871454518345728)
  )
  (i32.store offset=12
   (get_local $7)
   (tee_local $6
    (i32.load offset=28
     (get_local $4)
    )
   )
  )
  (block $label$5
   (block $label$6
    (br_if $label$6
     (i32.ge_u
      (tee_local $3
       (i32.load
        (tee_local $5
         (i32.add
          (get_local $1)
          (i32.const 28)
         )
        )
       )
      )
      (i32.load
       (i32.add
        (get_local $1)
        (i32.const 32)
       )
      )
     )
    )
    (i64.store offset=8
     (get_local $3)
     (i64.const 4982871454518345728)
    )
    (i32.store offset=16
     (get_local $3)
     (get_local $6)
    )
    (i32.store offset=32
     (get_local $7)
     (i32.const 0)
    )
    (i32.store
     (get_local $3)
     (get_local $4)
    )
    (i32.store
     (get_local $5)
     (i32.add
      (get_local $3)
      (i32.const 24)
     )
    )
    (br $label$5)
   )
   (call $_ZNSt3__16vectorIN5eosio11multi_indexILy4982871454518345728ENS1_9singletonILy4982871454518345728E15contract_configE3rowEJEE8item_ptrENS_9allocatorIS8_EEE24__emplace_back_slow_pathIJNS_10unique_ptrINS7_4itemENS_14default_deleteISE_EEEERyRlEEEvDpOT_
    (i32.add
     (get_local $1)
     (i32.const 24)
    )
    (i32.add
     (get_local $7)
     (i32.const 32)
    )
    (i32.add
     (get_local $7)
     (i32.const 16)
    )
    (i32.add
     (get_local $7)
     (i32.const 12)
    )
   )
  )
  (i32.store offset=4
   (get_local $0)
   (get_local $4)
  )
  (i32.store
   (get_local $0)
   (get_local $1)
  )
  (set_local $3
   (i32.load offset=32
    (get_local $7)
   )
  )
  (i32.store offset=32
   (get_local $7)
   (i32.const 0)
  )
  (block $label$7
   (br_if $label$7
    (i32.eqz
     (get_local $3)
    )
   )
   (call $_ZdlPv
    (get_local $3)
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $7)
    (i32.const 48)
   )
  )
 )
 (func $_ZZN5eosio11multi_indexILy4982871454518345728ENS_9singletonILy4982871454518345728E15contract_configE3rowEJEE7emplaceIZNS3_3setERKS2_yEUlRS4_E0_EENS5_14const_iteratorEyOT_ENKUlRSC_E_clINS5_4itemEEEDaSE_ (param $0 i32) (param $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (i32.store offset=4
   (i32.const 0)
   (tee_local $6
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 32)
    )
   )
  )
  (set_local $2
   (i32.load
    (get_local $0)
   )
  )
  (i64.store
   (get_local $1)
   (i64.load
    (tee_local $3
     (i32.load
      (i32.load offset=4
       (get_local $0)
      )
     )
    )
   )
  )
  (i32.store16
   (tee_local $4
    (i32.add
     (get_local $1)
     (i32.const 16)
    )
   )
   (i32.load16_u
    (i32.add
     (get_local $3)
     (i32.const 16)
    )
   )
  )
  (i64.store
   (tee_local $5
    (i32.add
     (get_local $1)
     (i32.const 8)
    )
   )
   (i64.load
    (i32.add
     (get_local $3)
     (i32.const 8)
    )
   )
  )
  (call $eosio_assert
   (i32.const 1)
   (i32.const 432)
  )
  (drop
   (call $memcpy
    (get_local $6)
    (get_local $1)
    (i32.const 8)
   )
  )
  (call $eosio_assert
   (i32.const 1)
   (i32.const 432)
  )
  (drop
   (call $memcpy
    (i32.or
     (get_local $6)
     (i32.const 8)
    )
    (get_local $5)
    (i32.const 8)
   )
  )
  (call $eosio_assert
   (i32.const 1)
   (i32.const 432)
  )
  (drop
   (call $memcpy
    (i32.add
     (get_local $6)
     (i32.const 16)
    )
    (get_local $4)
    (i32.const 1)
   )
  )
  (call $eosio_assert
   (i32.const 1)
   (i32.const 432)
  )
  (drop
   (call $memcpy
    (i32.add
     (get_local $6)
     (i32.const 17)
    )
    (i32.add
     (get_local $1)
     (i32.const 17)
    )
    (i32.const 1)
   )
  )
  (i32.store offset=28
   (get_local $1)
   (call $db_store_i64
    (i64.load offset=8
     (get_local $2)
    )
    (i64.const 4982871454518345728)
    (i64.load
     (i32.load offset=8
      (get_local $0)
     )
    )
    (i64.const 4982871454518345728)
    (get_local $6)
    (i32.const 18)
   )
  )
  (block $label$0
   (br_if $label$0
    (i64.gt_u
     (i64.load offset=16
      (get_local $2)
     )
     (i64.const 4982871454518345728)
    )
   )
   (i64.store
    (i32.add
     (get_local $2)
     (i32.const 16)
    )
    (i64.const 4982871454518345729)
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $6)
    (i32.const 32)
   )
  )
 )
 (func $_ZNSt3__16vectorIN5eosio11multi_indexILy4982871454518345728ENS1_9singletonILy4982871454518345728E15contract_configE3rowEJEE8item_ptrENS_9allocatorIS8_EEE24__emplace_back_slow_pathIJNS_10unique_ptrINS7_4itemENS_14default_deleteISE_EEEERyRlEEEvDpOT_ (param $0 i32) (param $1 i32) (param $2 i32) (param $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (block $label$0
   (block $label$1
    (br_if $label$1
     (i32.ge_u
      (tee_local $5
       (i32.add
        (tee_local $4
         (i32.div_s
          (i32.sub
           (i32.load offset=4
            (get_local $0)
           )
           (tee_local $6
            (i32.load
             (get_local $0)
            )
           )
          )
          (i32.const 24)
         )
        )
        (i32.const 1)
       )
      )
      (i32.const 178956971)
     )
    )
    (set_local $7
     (i32.const 178956970)
    )
    (block $label$2
     (block $label$3
      (br_if $label$3
       (i32.gt_u
        (tee_local $6
         (i32.div_s
          (i32.sub
           (i32.load offset=8
            (get_local $0)
           )
           (get_local $6)
          )
          (i32.const 24)
         )
        )
        (i32.const 89478484)
       )
      )
      (br_if $label$2
       (i32.eqz
        (tee_local $7
         (select
          (get_local $5)
          (tee_local $7
           (i32.shl
            (get_local $6)
            (i32.const 1)
           )
          )
          (i32.lt_u
           (get_local $7)
           (get_local $5)
          )
         )
        )
       )
      )
     )
     (set_local $6
      (call $_Znwj
       (i32.mul
        (get_local $7)
        (i32.const 24)
       )
      )
     )
     (br $label$0)
    )
    (set_local $7
     (i32.const 0)
    )
    (set_local $6
     (i32.const 0)
    )
    (br $label$0)
   )
   (call $_ZNKSt3__120__vector_base_commonILb1EE20__throw_length_errorEv
    (get_local $0)
   )
   (unreachable)
  )
  (set_local $5
   (i32.load
    (get_local $1)
   )
  )
  (i32.store
   (get_local $1)
   (i32.const 0)
  )
  (i32.store
   (tee_local $1
    (i32.add
     (get_local $6)
     (i32.mul
      (get_local $4)
      (i32.const 24)
     )
    )
   )
   (get_local $5)
  )
  (i64.store offset=8
   (get_local $1)
   (i64.load
    (get_local $2)
   )
  )
  (i32.store offset=16
   (get_local $1)
   (i32.load
    (get_local $3)
   )
  )
  (set_local $4
   (i32.add
    (get_local $6)
    (i32.mul
     (get_local $7)
     (i32.const 24)
    )
   )
  )
  (set_local $5
   (i32.add
    (get_local $1)
    (i32.const 24)
   )
  )
  (block $label$4
   (block $label$5
    (br_if $label$5
     (i32.eq
      (tee_local $6
       (i32.load
        (i32.add
         (get_local $0)
         (i32.const 4)
        )
       )
      )
      (tee_local $7
       (i32.load
        (get_local $0)
       )
      )
     )
    )
    (loop $label$6
     (set_local $3
      (i32.load
       (tee_local $2
        (i32.add
         (get_local $6)
         (i32.const -24)
        )
       )
      )
     )
     (i32.store
      (get_local $2)
      (i32.const 0)
     )
     (i32.store
      (i32.add
       (get_local $1)
       (i32.const -24)
      )
      (get_local $3)
     )
     (i32.store
      (i32.add
       (get_local $1)
       (i32.const -8)
      )
      (i32.load
       (i32.add
        (get_local $6)
        (i32.const -8)
       )
      )
     )
     (i32.store
      (i32.add
       (get_local $1)
       (i32.const -12)
      )
      (i32.load
       (i32.add
        (get_local $6)
        (i32.const -12)
       )
      )
     )
     (i32.store
      (i32.add
       (get_local $1)
       (i32.const -16)
      )
      (i32.load
       (i32.add
        (get_local $6)
        (i32.const -16)
       )
      )
     )
     (set_local $1
      (i32.add
       (get_local $1)
       (i32.const -24)
      )
     )
     (set_local $6
      (get_local $2)
     )
     (br_if $label$6
      (i32.ne
       (get_local $7)
       (get_local $2)
      )
     )
    )
    (set_local $7
     (i32.load
      (i32.add
       (get_local $0)
       (i32.const 4)
      )
     )
    )
    (set_local $6
     (i32.load
      (get_local $0)
     )
    )
    (br $label$4)
   )
   (set_local $6
    (get_local $7)
   )
  )
  (i32.store
   (get_local $0)
   (get_local $1)
  )
  (i32.store
   (i32.add
    (get_local $0)
    (i32.const 4)
   )
   (get_local $5)
  )
  (i32.store
   (i32.add
    (get_local $0)
    (i32.const 8)
   )
   (get_local $4)
  )
  (block $label$7
   (br_if $label$7
    (i32.eq
     (get_local $7)
     (get_local $6)
    )
   )
   (loop $label$8
    (set_local $1
     (i32.load
      (tee_local $7
       (i32.add
        (get_local $7)
        (i32.const -24)
       )
      )
     )
    )
    (i32.store
     (get_local $7)
     (i32.const 0)
    )
    (block $label$9
     (br_if $label$9
      (i32.eqz
       (get_local $1)
      )
     )
     (call $_ZdlPv
      (get_local $1)
     )
    )
    (br_if $label$8
     (i32.ne
      (get_local $6)
      (get_local $7)
     )
    )
   )
  )
  (block $label$10
   (br_if $label$10
    (i32.eqz
     (get_local $6)
    )
   )
   (call $_ZdlPv
    (get_local $6)
   )
  )
 )
 (func $_ZrsIN5eosio10datastreamIPKcEEERT_S6_R15contract_config (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (call $eosio_assert
   (i32.gt_u
    (i32.sub
     (i32.load offset=8
      (get_local $0)
     )
     (i32.load offset=4
      (get_local $0)
     )
    )
    (i32.const 7)
   )
   (i32.const 576)
  )
  (drop
   (call $memcpy
    (get_local $1)
    (i32.load offset=4
     (get_local $0)
    )
    (i32.const 8)
   )
  )
  (i32.store offset=4
   (get_local $0)
   (tee_local $2
    (i32.add
     (i32.load offset=4
      (get_local $0)
     )
     (i32.const 8)
    )
   )
  )
  (call $eosio_assert
   (i32.gt_u
    (i32.sub
     (i32.load offset=8
      (get_local $0)
     )
     (get_local $2)
    )
    (i32.const 7)
   )
   (i32.const 576)
  )
  (drop
   (call $memcpy
    (i32.add
     (get_local $1)
     (i32.const 8)
    )
    (i32.load offset=4
     (get_local $0)
    )
    (i32.const 8)
   )
  )
  (i32.store offset=4
   (get_local $0)
   (tee_local $2
    (i32.add
     (i32.load offset=4
      (get_local $0)
     )
     (i32.const 8)
    )
   )
  )
  (call $eosio_assert
   (i32.ne
    (i32.load offset=8
     (get_local $0)
    )
    (get_local $2)
   )
   (i32.const 576)
  )
  (drop
   (call $memcpy
    (i32.add
     (get_local $1)
     (i32.const 16)
    )
    (i32.load offset=4
     (get_local $0)
    )
    (i32.const 1)
   )
  )
  (i32.store offset=4
   (get_local $0)
   (tee_local $2
    (i32.add
     (i32.load offset=4
      (get_local $0)
     )
     (i32.const 1)
    )
   )
  )
  (call $eosio_assert
   (i32.ne
    (i32.load offset=8
     (get_local $0)
    )
    (get_local $2)
   )
   (i32.const 576)
  )
  (drop
   (call $memcpy
    (i32.add
     (get_local $1)
     (i32.const 17)
    )
    (i32.load offset=4
     (get_local $0)
    )
    (i32.const 1)
   )
  )
  (i32.store offset=4
   (get_local $0)
   (i32.add
    (i32.load offset=4
     (get_local $0)
    )
    (i32.const 1)
   )
  )
  (get_local $0)
 )
 (func $_ZNK5eosio11multi_indexILy15938991147217584128E4voteJNS_10indexed_byILy4587895300147904512EN5boost11multi_index13const_mem_funIS1_yXadL_ZNKS1_8by_proxyEvEEEEEEEE5indexILy4587895300147904512ES6_Ly0ELb0EE11lower_boundERKy (param $0 i32) (param $1 i32) (param $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i64)
  (local $6 i32)
  (local $7 i32)
  (local $8 i32)
  (local $9 i32)
  (local $10 i32)
  (i32.store offset=4
   (i32.const 0)
   (tee_local $10
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 16)
    )
   )
  )
  (i64.store offset=8
   (get_local $10)
   (i64.const 0)
  )
  (i64.store
   (get_local $10)
   (i64.load
    (get_local $2)
   )
  )
  (set_local $2
   (i32.const 0)
  )
  (block $label$0
   (br_if $label$0
    (i32.lt_s
     (tee_local $3
      (call $db_idx64_lowerbound
       (i64.load
        (tee_local $8
         (i32.load
          (get_local $1)
         )
        )
       )
       (i64.load offset=8
        (get_local $8)
       )
       (i64.const -2507752926491967488)
       (get_local $10)
       (i32.add
        (get_local $10)
        (i32.const 8)
       )
      )
     )
     (i32.const 0)
    )
   )
   (set_local $5
    (i64.load offset=8
     (get_local $10)
    )
   )
   (block $label$1
    (br_if $label$1
     (i32.eq
      (tee_local $9
       (i32.load
        (i32.add
         (tee_local $4
          (i32.load
           (get_local $1)
          )
         )
         (i32.const 28)
        )
       )
      )
      (tee_local $6
       (i32.load offset=24
        (get_local $4)
       )
      )
     )
    )
    (set_local $2
     (i32.add
      (get_local $9)
      (i32.const -24)
     )
    )
    (set_local $7
     (i32.sub
      (i32.const 0)
      (get_local $6)
     )
    )
    (loop $label$2
     (br_if $label$1
      (i64.eq
       (i64.load
        (i32.load
         (get_local $2)
        )
       )
       (get_local $5)
      )
     )
     (set_local $9
      (get_local $2)
     )
     (set_local $2
      (tee_local $8
       (i32.add
        (get_local $2)
        (i32.const -24)
       )
      )
     )
     (br_if $label$2
      (i32.ne
       (i32.add
        (get_local $8)
        (get_local $7)
       )
       (i32.const -24)
      )
     )
    )
   )
   (block $label$3
    (block $label$4
     (br_if $label$4
      (i32.eq
       (get_local $9)
       (get_local $6)
      )
     )
     (call $eosio_assert
      (i32.eq
       (i32.load offset=36
        (tee_local $2
         (i32.load
          (i32.add
           (get_local $9)
           (i32.const -24)
          )
         )
        )
       )
       (get_local $4)
      )
      (i32.const 896)
     )
     (br $label$3)
    )
    (set_local $2
     (i32.const 0)
    )
    (br_if $label$3
     (i32.lt_s
      (tee_local $8
       (call $db_find_i64
        (i64.load
         (get_local $4)
        )
        (i64.load offset=8
         (get_local $4)
        )
        (i64.const -2507752926491967488)
        (get_local $5)
       )
      )
      (i32.const 0)
     )
    )
    (call $eosio_assert
     (i32.eq
      (i32.load offset=36
       (tee_local $2
        (call $_ZNK5eosio11multi_indexILy15938991147217584128E4voteJNS_10indexed_byILy4587895300147904512EN5boost11multi_index13const_mem_funIS1_yXadL_ZNKS1_8by_proxyEvEEEEEEEE31load_object_by_primary_iteratorEl
         (get_local $4)
         (get_local $8)
        )
       )
      )
      (get_local $4)
     )
     (i32.const 896)
    )
   )
   (i32.store offset=44
    (get_local $2)
    (get_local $3)
   )
  )
  (i32.store offset=4
   (get_local $0)
   (get_local $2)
  )
  (i32.store
   (get_local $0)
   (get_local $1)
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $10)
    (i32.const 16)
   )
  )
 )
 (func $_ZN5eosio11multi_indexILy15938991147217584128E4voteJNS_10indexed_byILy4587895300147904512EN5boost11multi_index13const_mem_funIS1_yXadL_ZNKS1_8by_proxyEvEEEEEEEE5indexILy4587895300147904512ES6_Ly0ELb0EE14const_iteratormmEv (param $0 i32) (result i32)
  (local $1 i32)
  (local $2 i64)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (local $8 i32)
  (local $9 i32)
  (i32.store offset=4
   (i32.const 0)
   (tee_local $9
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 16)
    )
   )
  )
  (i64.store offset=8
   (get_local $9)
   (i64.const 0)
  )
  (block $label$0
   (block $label$1
    (br_if $label$1
     (i32.eqz
      (tee_local $7
       (i32.load offset=4
        (get_local $0)
       )
      )
     )
    )
    (block $label$2
     (br_if $label$2
      (i32.ne
       (tee_local $5
        (i32.load offset=44
         (get_local $7)
        )
       )
       (i32.const -1)
      )
     )
     (set_local $5
      (call $db_idx64_find_primary
       (i64.load
        (tee_local $5
         (i32.load
          (i32.load
           (get_local $0)
          )
         )
        )
       )
       (i64.load offset=8
        (get_local $5)
       )
       (i64.const -2507752926491967488)
       (get_local $9)
       (i64.load
        (get_local $7)
       )
      )
     )
     (i32.store offset=44
      (i32.load
       (i32.add
        (get_local $0)
        (i32.const 4)
       )
      )
      (get_local $5)
     )
    )
    (call $eosio_assert
     (i32.xor
      (i32.shr_u
       (tee_local $6
        (call $db_idx64_previous
         (get_local $5)
         (i32.add
          (get_local $9)
          (i32.const 8)
         )
        )
       )
       (i32.const 31)
      )
      (i32.const 1)
     )
     (i32.const 848)
    )
    (br $label$0)
   )
   (call $eosio_assert
    (i32.ne
     (tee_local $7
      (call $db_idx64_end
       (i64.load
        (tee_local $7
         (i32.load
          (i32.load
           (get_local $0)
          )
         )
        )
       )
       (i64.load offset=8
        (get_local $7)
       )
       (i64.const -2507752926491967488)
      )
     )
     (i32.const -1)
    )
    (i32.const 784)
   )
   (call $eosio_assert
    (i32.xor
     (i32.shr_u
      (tee_local $6
       (call $db_idx64_previous
        (get_local $7)
        (i32.add
         (get_local $9)
         (i32.const 8)
        )
       )
      )
      (i32.const 31)
     )
     (i32.const 1)
    )
    (i32.const 784)
   )
  )
  (set_local $2
   (i64.load offset=8
    (get_local $9)
   )
  )
  (block $label$3
   (br_if $label$3
    (i32.eq
     (tee_local $8
      (i32.load
       (i32.add
        (tee_local $1
         (i32.load
          (i32.load
           (get_local $0)
          )
         )
        )
        (i32.const 28)
       )
      )
     )
     (tee_local $3
      (i32.load offset=24
       (get_local $1)
      )
     )
    )
   )
   (set_local $7
    (i32.add
     (get_local $8)
     (i32.const -24)
    )
   )
   (set_local $4
    (i32.sub
     (i32.const 0)
     (get_local $3)
    )
   )
   (loop $label$4
    (br_if $label$3
     (i64.eq
      (i64.load
       (i32.load
        (get_local $7)
       )
      )
      (get_local $2)
     )
    )
    (set_local $8
     (get_local $7)
    )
    (set_local $7
     (tee_local $5
      (i32.add
       (get_local $7)
       (i32.const -24)
      )
     )
    )
    (br_if $label$4
     (i32.ne
      (i32.add
       (get_local $5)
       (get_local $4)
      )
      (i32.const -24)
     )
    )
   )
  )
  (block $label$5
   (block $label$6
    (br_if $label$6
     (i32.eq
      (get_local $8)
      (get_local $3)
     )
    )
    (call $eosio_assert
     (i32.eq
      (i32.load offset=36
       (tee_local $7
        (i32.load
         (i32.add
          (get_local $8)
          (i32.const -24)
         )
        )
       )
      )
      (get_local $1)
     )
     (i32.const 896)
    )
    (br $label$5)
   )
   (call $eosio_assert
    (i32.eq
     (i32.load offset=36
      (tee_local $7
       (call $_ZNK5eosio11multi_indexILy15938991147217584128E4voteJNS_10indexed_byILy4587895300147904512EN5boost11multi_index13const_mem_funIS1_yXadL_ZNKS1_8by_proxyEvEEEEEEEE31load_object_by_primary_iteratorEl
        (get_local $1)
        (call $db_find_i64
         (i64.load
          (get_local $1)
         )
         (i64.load offset=8
          (get_local $1)
         )
         (i64.const -2507752926491967488)
         (get_local $2)
        )
       )
      )
     )
     (get_local $1)
    )
    (i32.const 896)
   )
  )
  (i32.store offset=44
   (get_local $7)
   (get_local $6)
  )
  (i32.store
   (i32.add
    (get_local $0)
    (i32.const 4)
   )
   (get_local $7)
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $9)
    (i32.const 16)
   )
  )
  (get_local $0)
 )
 (func $_ZNK5eosio11multi_indexILy3607749779137757184E7accountJEE31load_object_by_primary_iteratorEl (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i64)
  (local $6 i32)
  (local $7 i32)
  (local $8 i32)
  (local $9 i32)
  (i32.store offset=4
   (i32.const 0)
   (tee_local $9
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 48)
    )
   )
  )
  (i32.store offset=44
   (tee_local $8
    (get_local $9)
   )
   (get_local $1)
  )
  (block $label$0
   (br_if $label$0
    (i32.eq
     (tee_local $7
      (i32.load
       (i32.add
        (get_local $0)
        (i32.const 28)
       )
      )
     )
     (tee_local $2
      (i32.load offset=24
       (get_local $0)
      )
     )
    )
   )
   (set_local $3
    (i32.sub
     (i32.const 0)
     (get_local $2)
    )
   )
   (set_local $6
    (i32.add
     (get_local $7)
     (i32.const -24)
    )
   )
   (loop $label$1
    (br_if $label$0
     (i32.eq
      (i32.load
       (i32.add
        (get_local $6)
        (i32.const 16)
       )
      )
      (get_local $1)
     )
    )
    (set_local $7
     (get_local $6)
    )
    (set_local $6
     (tee_local $4
      (i32.add
       (get_local $6)
       (i32.const -24)
      )
     )
    )
    (br_if $label$1
     (i32.ne
      (i32.add
       (get_local $4)
       (get_local $3)
      )
      (i32.const -24)
     )
    )
   )
  )
  (block $label$2
   (block $label$3
    (br_if $label$3
     (i32.eq
      (get_local $7)
      (get_local $2)
     )
    )
    (set_local $6
     (i32.load
      (i32.add
       (get_local $7)
       (i32.const -24)
      )
     )
    )
    (br $label$2)
   )
   (call $eosio_assert
    (i32.xor
     (i32.shr_u
      (tee_local $6
       (call $db_get_i64
        (get_local $1)
        (i32.const 0)
        (i32.const 0)
       )
      )
      (i32.const 31)
     )
     (i32.const 1)
    )
    (i32.const 448)
   )
   (block $label$4
    (block $label$5
     (br_if $label$5
      (i32.lt_u
       (get_local $6)
       (i32.const 513)
      )
     )
     (set_local $4
      (call $malloc
       (get_local $6)
      )
     )
     (br $label$4)
    )
    (i32.store offset=4
     (i32.const 0)
     (tee_local $4
      (i32.sub
       (get_local $9)
       (i32.and
        (i32.add
         (get_local $6)
         (i32.const 15)
        )
        (i32.const -16)
       )
      )
     )
    )
   )
   (drop
    (call $db_get_i64
     (get_local $1)
     (get_local $4)
     (get_local $6)
    )
   )
   (i32.store offset=36
    (get_local $8)
    (get_local $4)
   )
   (i32.store offset=32
    (get_local $8)
    (get_local $4)
   )
   (i32.store offset=40
    (get_local $8)
    (i32.add
     (get_local $4)
     (get_local $6)
    )
   )
   (block $label$6
    (br_if $label$6
     (i32.lt_u
      (get_local $6)
      (i32.const 513)
     )
    )
    (call $free
     (get_local $4)
    )
   )
   (i32.store offset=12
    (get_local $8)
    (i32.add
     (get_local $8)
     (i32.const 32)
    )
   )
   (i32.store offset=16
    (get_local $8)
    (i32.add
     (get_local $8)
     (i32.const 44)
    )
   )
   (i32.store offset=8
    (get_local $8)
    (get_local $0)
   )
   (set_local $6
    (call $_ZN5eosio11multi_indexILy3607749779137757184E7accountJEE4itemC2IZNKS2_31load_object_by_primary_iteratorElEUlRT_E_EEPKS2_OS5_
     (tee_local $4
      (call $_Znwj
       (i32.const 32)
      )
     )
     (get_local $0)
     (i32.add
      (get_local $8)
      (i32.const 8)
     )
    )
   )
   (i32.store offset=24
    (get_local $8)
    (get_local $4)
   )
   (i64.store offset=8
    (get_local $8)
    (tee_local $5
     (i64.shr_u
      (i64.load offset=8
       (get_local $4)
      )
      (i64.const 8)
     )
    )
   )
   (i32.store offset=4
    (get_local $8)
    (tee_local $1
     (i32.load offset=20
      (get_local $4)
     )
    )
   )
   (block $label$7
    (block $label$8
     (br_if $label$8
      (i32.ge_u
       (tee_local $7
        (i32.load
         (tee_local $3
          (i32.add
           (get_local $0)
           (i32.const 28)
          )
         )
        )
       )
       (i32.load
        (i32.add
         (get_local $0)
         (i32.const 32)
        )
       )
      )
     )
     (i64.store offset=8
      (get_local $7)
      (get_local $5)
     )
     (i32.store offset=16
      (get_local $7)
      (get_local $1)
     )
     (i32.store offset=24
      (get_local $8)
      (i32.const 0)
     )
     (i32.store
      (get_local $7)
      (get_local $4)
     )
     (i32.store
      (get_local $3)
      (i32.add
       (get_local $7)
       (i32.const 24)
      )
     )
     (br $label$7)
    )
    (call $_ZNSt3__16vectorIN5eosio11multi_indexILy3607749779137757184E7accountJEE8item_ptrENS_9allocatorIS5_EEE24__emplace_back_slow_pathIJNS_10unique_ptrINS4_4itemENS_14default_deleteISB_EEEERyRlEEEvDpOT_
     (i32.add
      (get_local $0)
      (i32.const 24)
     )
     (i32.add
      (get_local $8)
      (i32.const 24)
     )
     (i32.add
      (get_local $8)
      (i32.const 8)
     )
     (i32.add
      (get_local $8)
      (i32.const 4)
     )
    )
   )
   (set_local $4
    (i32.load offset=24
     (get_local $8)
    )
   )
   (i32.store offset=24
    (get_local $8)
    (i32.const 0)
   )
   (br_if $label$2
    (i32.eqz
     (get_local $4)
    )
   )
   (call $_ZdlPv
    (get_local $4)
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $8)
    (i32.const 48)
   )
  )
  (get_local $6)
 )
 (func $_ZN5eosio11multi_indexILy15938991147217584128E4voteJNS_10indexed_byILy4587895300147904512EN5boost11multi_index13const_mem_funIS1_yXadL_ZNKS1_8by_proxyEvEEEEEEEE6modifyIZN12daccustodian13tallyNewVotesEvEUlRS1_E_EEvRKS1_yOT_ (param $0 i32) (param $1 i32) (param $2 i64) (param $3 i32)
  (local $4 i64)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (local $8 i32)
  (local $9 i32)
  (local $10 i64)
  (local $11 i32)
  (local $12 i32)
  (i32.store offset=4
   (i32.const 0)
   (tee_local $11
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 48)
    )
   )
  )
  (call $eosio_assert
   (i32.eq
    (i32.load offset=36
     (get_local $1)
    )
    (get_local $0)
   )
   (i32.const 608)
  )
  (call $eosio_assert
   (i64.eq
    (i64.load
     (get_local $0)
    )
    (call $current_receiver)
   )
   (i32.const 656)
  )
  (i64.store offset=24
   (tee_local $12
    (get_local $11)
   )
   (i64.load offset=8
    (get_local $1)
   )
  )
  (i64.store offset=16
   (get_local $1)
   (i64.add
    (i64.load offset=16
     (get_local $1)
    )
    (i64.load
     (i32.load
      (get_local $3)
     )
    )
   )
  )
  (set_local $4
   (i64.load
    (get_local $1)
   )
  )
  (call $eosio_assert
   (i32.const 1)
   (i32.const 720)
  )
  (set_local $3
   (i32.const 24)
  )
  (set_local $6
   (i32.add
    (get_local $1)
    (i32.const 24)
   )
  )
  (set_local $5
   (i32.add
    (get_local $1)
    (i32.const 16)
   )
  )
  (set_local $10
   (i64.extend_u/i32
    (i32.shr_s
     (tee_local $8
      (i32.sub
       (tee_local $9
        (i32.load
         (i32.add
          (get_local $1)
          (i32.const 28)
         )
        )
       )
       (tee_local $7
        (i32.load offset=24
         (get_local $1)
        )
       )
      )
     )
     (i32.const 3)
    )
   )
  )
  (loop $label$0
   (set_local $3
    (i32.add
     (get_local $3)
     (i32.const 1)
    )
   )
   (br_if $label$0
    (i64.ne
     (tee_local $10
      (i64.shr_u
       (get_local $10)
       (i64.const 7)
      )
     )
     (i64.const 0)
    )
   )
  )
  (block $label$1
   (br_if $label$1
    (i32.eq
     (get_local $7)
     (get_local $9)
    )
   )
   (set_local $3
    (i32.add
     (i32.and
      (get_local $8)
      (i32.const -8)
     )
     (get_local $3)
    )
   )
  )
  (block $label$2
   (block $label$3
    (br_if $label$3
     (i32.lt_u
      (get_local $3)
      (i32.const 513)
     )
    )
    (set_local $11
     (call $malloc
      (get_local $3)
     )
    )
    (br $label$2)
   )
   (i32.store offset=4
    (i32.const 0)
    (tee_local $11
     (i32.sub
      (get_local $11)
      (i32.and
       (i32.add
        (get_local $3)
        (i32.const 15)
       )
       (i32.const -16)
      )
     )
    )
   )
  )
  (i32.store offset=8
   (get_local $12)
   (get_local $11)
  )
  (i32.store offset=16
   (get_local $12)
   (tee_local $9
    (i32.add
     (get_local $11)
     (get_local $3)
    )
   )
  )
  (call $eosio_assert
   (i32.gt_s
    (get_local $3)
    (i32.const 7)
   )
   (i32.const 432)
  )
  (drop
   (call $memcpy
    (get_local $11)
    (get_local $1)
    (i32.const 8)
   )
  )
  (call $eosio_assert
   (i32.gt_s
    (i32.sub
     (get_local $9)
     (tee_local $7
      (i32.add
       (get_local $11)
       (i32.const 8)
      )
     )
    )
    (i32.const 7)
   )
   (i32.const 432)
  )
  (drop
   (call $memcpy
    (get_local $7)
    (i32.add
     (get_local $1)
     (i32.const 8)
    )
    (i32.const 8)
   )
  )
  (call $eosio_assert
   (i32.gt_s
    (i32.sub
     (get_local $9)
     (tee_local $7
      (i32.add
       (get_local $11)
       (i32.const 16)
      )
     )
    )
    (i32.const 7)
   )
   (i32.const 432)
  )
  (drop
   (call $memcpy
    (get_local $7)
    (get_local $5)
    (i32.const 8)
   )
  )
  (i32.store offset=12
   (get_local $12)
   (i32.add
    (get_local $11)
    (i32.const 24)
   )
  )
  (drop
   (call $_ZN5eosiolsINS_10datastreamIPcEENS_4nameEEERT_S6_RKNSt3__16vectorIT0_NS7_9allocatorIS9_EEEE
    (i32.add
     (get_local $12)
     (i32.const 8)
    )
    (get_local $6)
   )
  )
  (call $db_update_i64
   (i32.load offset=40
    (get_local $1)
   )
   (get_local $2)
   (get_local $11)
   (get_local $3)
  )
  (block $label$4
   (br_if $label$4
    (i32.lt_u
     (get_local $3)
     (i32.const 513)
    )
   )
   (call $free
    (get_local $11)
   )
  )
  (block $label$5
   (br_if $label$5
    (i64.lt_u
     (get_local $4)
     (i64.load offset=16
      (get_local $0)
     )
    )
   )
   (i64.store
    (i32.add
     (get_local $0)
     (i32.const 16)
    )
    (select
     (i64.const -2)
     (i64.add
      (get_local $4)
      (i64.const 1)
     )
     (i64.gt_u
      (get_local $4)
      (i64.const -3)
     )
    )
   )
  )
  (i64.store offset=40
   (get_local $12)
   (i64.load
    (i32.add
     (get_local $1)
     (i32.const 8)
    )
   )
  )
  (block $label$6
   (br_if $label$6
    (i32.eqz
     (call $memcmp
      (i32.add
       (get_local $12)
       (i32.const 24)
      )
      (i32.add
       (get_local $12)
       (i32.const 40)
      )
      (i32.const 8)
     )
    )
   )
   (block $label$7
    (br_if $label$7
     (i32.gt_s
      (tee_local $3
       (i32.load offset=44
        (get_local $1)
       )
      )
      (i32.const -1)
     )
    )
    (i32.store
     (i32.add
      (get_local $1)
      (i32.const 44)
     )
     (tee_local $3
      (call $db_idx64_find_primary
       (i64.load
        (get_local $0)
       )
       (i64.load offset=8
        (get_local $0)
       )
       (i64.const -2507752926491967488)
       (i32.add
        (get_local $12)
        (i32.const 32)
       )
       (get_local $4)
      )
     )
    )
   )
   (call $db_idx64_update
    (get_local $3)
    (get_local $2)
    (i32.add
     (get_local $12)
     (i32.const 40)
    )
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $12)
    (i32.const 48)
   )
  )
 )
 (func $_ZNK5eosio11multi_indexILy15938991147217584128E4voteJNS_10indexed_byILy4587895300147904512EN5boost11multi_index13const_mem_funIS1_yXadL_ZNKS1_8by_proxyEvEEEEEEEE31load_object_by_primary_iteratorEl (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i64)
  (local $6 i32)
  (local $7 i32)
  (local $8 i32)
  (local $9 i32)
  (i32.store offset=4
   (i32.const 0)
   (tee_local $9
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 48)
    )
   )
  )
  (i32.store offset=44
   (tee_local $8
    (get_local $9)
   )
   (get_local $1)
  )
  (block $label$0
   (br_if $label$0
    (i32.eq
     (tee_local $7
      (i32.load
       (i32.add
        (get_local $0)
        (i32.const 28)
       )
      )
     )
     (tee_local $2
      (i32.load offset=24
       (get_local $0)
      )
     )
    )
   )
   (set_local $3
    (i32.sub
     (i32.const 0)
     (get_local $2)
    )
   )
   (set_local $6
    (i32.add
     (get_local $7)
     (i32.const -24)
    )
   )
   (loop $label$1
    (br_if $label$0
     (i32.eq
      (i32.load
       (i32.add
        (get_local $6)
        (i32.const 16)
       )
      )
      (get_local $1)
     )
    )
    (set_local $7
     (get_local $6)
    )
    (set_local $6
     (tee_local $4
      (i32.add
       (get_local $6)
       (i32.const -24)
      )
     )
    )
    (br_if $label$1
     (i32.ne
      (i32.add
       (get_local $4)
       (get_local $3)
      )
      (i32.const -24)
     )
    )
   )
  )
  (block $label$2
   (block $label$3
    (br_if $label$3
     (i32.eq
      (get_local $7)
      (get_local $2)
     )
    )
    (set_local $6
     (i32.load
      (i32.add
       (get_local $7)
       (i32.const -24)
      )
     )
    )
    (br $label$2)
   )
   (call $eosio_assert
    (i32.xor
     (i32.shr_u
      (tee_local $6
       (call $db_get_i64
        (get_local $1)
        (i32.const 0)
        (i32.const 0)
       )
      )
      (i32.const 31)
     )
     (i32.const 1)
    )
    (i32.const 448)
   )
   (block $label$4
    (block $label$5
     (br_if $label$5
      (i32.lt_u
       (get_local $6)
       (i32.const 513)
      )
     )
     (set_local $4
      (call $malloc
       (get_local $6)
      )
     )
     (br $label$4)
    )
    (i32.store offset=4
     (i32.const 0)
     (tee_local $4
      (i32.sub
       (get_local $9)
       (i32.and
        (i32.add
         (get_local $6)
         (i32.const 15)
        )
        (i32.const -16)
       )
      )
     )
    )
   )
   (drop
    (call $db_get_i64
     (get_local $1)
     (get_local $4)
     (get_local $6)
    )
   )
   (i32.store offset=36
    (get_local $8)
    (get_local $4)
   )
   (i32.store offset=32
    (get_local $8)
    (get_local $4)
   )
   (i32.store offset=40
    (get_local $8)
    (i32.add
     (get_local $4)
     (get_local $6)
    )
   )
   (block $label$6
    (br_if $label$6
     (i32.lt_u
      (get_local $6)
      (i32.const 513)
     )
    )
    (call $free
     (get_local $4)
    )
   )
   (i32.store offset=12
    (get_local $8)
    (i32.add
     (get_local $8)
     (i32.const 32)
    )
   )
   (i32.store offset=16
    (get_local $8)
    (i32.add
     (get_local $8)
     (i32.const 44)
    )
   )
   (i32.store offset=8
    (get_local $8)
    (get_local $0)
   )
   (set_local $6
    (call $_ZN5eosio11multi_indexILy15938991147217584128E4voteJNS_10indexed_byILy4587895300147904512EN5boost11multi_index13const_mem_funIS1_yXadL_ZNKS1_8by_proxyEvEEEEEEEE4itemC2IZNKS8_31load_object_by_primary_iteratorElEUlRT_E_EEPKS8_OSB_
     (tee_local $4
      (call $_Znwj
       (i32.const 48)
      )
     )
     (get_local $0)
     (i32.add
      (get_local $8)
      (i32.const 8)
     )
    )
   )
   (i32.store offset=24
    (get_local $8)
    (get_local $4)
   )
   (i64.store offset=8
    (get_local $8)
    (tee_local $5
     (i64.load
      (get_local $4)
     )
    )
   )
   (i32.store offset=4
    (get_local $8)
    (tee_local $1
     (i32.load offset=40
      (get_local $4)
     )
    )
   )
   (block $label$7
    (block $label$8
     (br_if $label$8
      (i32.ge_u
       (tee_local $7
        (i32.load
         (tee_local $3
          (i32.add
           (get_local $0)
           (i32.const 28)
          )
         )
        )
       )
       (i32.load
        (i32.add
         (get_local $0)
         (i32.const 32)
        )
       )
      )
     )
     (i64.store offset=8
      (get_local $7)
      (get_local $5)
     )
     (i32.store offset=16
      (get_local $7)
      (get_local $1)
     )
     (i32.store offset=24
      (get_local $8)
      (i32.const 0)
     )
     (i32.store
      (get_local $7)
      (get_local $4)
     )
     (i32.store
      (get_local $3)
      (i32.add
       (get_local $7)
       (i32.const 24)
      )
     )
     (br $label$7)
    )
    (call $_ZNSt3__16vectorIN5eosio11multi_indexILy15938991147217584128E4voteJNS1_10indexed_byILy4587895300147904512EN5boost11multi_index13const_mem_funIS3_yXadL_ZNKS3_8by_proxyEvEEEEEEEE8item_ptrENS_9allocatorISB_EEE24__emplace_back_slow_pathIJNS_10unique_ptrINSA_4itemENS_14default_deleteISH_EEEERyRlEEEvDpOT_
     (i32.add
      (get_local $0)
      (i32.const 24)
     )
     (i32.add
      (get_local $8)
      (i32.const 24)
     )
     (i32.add
      (get_local $8)
      (i32.const 8)
     )
     (i32.add
      (get_local $8)
      (i32.const 4)
     )
    )
   )
   (set_local $4
    (i32.load offset=24
     (get_local $8)
    )
   )
   (i32.store offset=24
    (get_local $8)
    (i32.const 0)
   )
   (br_if $label$2
    (i32.eqz
     (get_local $4)
    )
   )
   (block $label$9
    (br_if $label$9
     (i32.eqz
      (tee_local $7
       (i32.load offset=24
        (get_local $4)
       )
      )
     )
    )
    (i32.store
     (i32.add
      (get_local $4)
      (i32.const 28)
     )
     (get_local $7)
    )
    (call $_ZdlPv
     (get_local $7)
    )
   )
   (call $_ZdlPv
    (get_local $4)
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $8)
    (i32.const 48)
   )
  )
  (get_local $6)
 )
 (func $_ZN5eosio11multi_indexILy15938991147217584128E4voteJNS_10indexed_byILy4587895300147904512EN5boost11multi_index13const_mem_funIS1_yXadL_ZNKS1_8by_proxyEvEEEEEEEE6modifyIZN12daccustodian13tallyNewVotesEvEUlRS1_E0_EEvRKS1_yOT_ (param $0 i32) (param $1 i32) (param $2 i64) (param $3 i32)
  (local $4 i64)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (local $8 i32)
  (local $9 i32)
  (local $10 i64)
  (local $11 i32)
  (local $12 i32)
  (i32.store offset=4
   (i32.const 0)
   (tee_local $11
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 48)
    )
   )
  )
  (call $eosio_assert
   (i32.eq
    (i32.load offset=36
     (get_local $1)
    )
    (get_local $0)
   )
   (i32.const 608)
  )
  (call $eosio_assert
   (i64.eq
    (i64.load
     (get_local $0)
    )
    (call $current_receiver)
   )
   (i32.const 656)
  )
  (i64.store offset=24
   (tee_local $12
    (get_local $11)
   )
   (i64.load offset=8
    (get_local $1)
   )
  )
  (i64.store offset=16
   (get_local $1)
   (i64.add
    (i64.load offset=16
     (get_local $1)
    )
    (i64.load
     (i32.load
      (get_local $3)
     )
    )
   )
  )
  (set_local $4
   (i64.load
    (get_local $1)
   )
  )
  (call $eosio_assert
   (i32.const 1)
   (i32.const 720)
  )
  (set_local $3
   (i32.const 24)
  )
  (set_local $6
   (i32.add
    (get_local $1)
    (i32.const 24)
   )
  )
  (set_local $5
   (i32.add
    (get_local $1)
    (i32.const 16)
   )
  )
  (set_local $10
   (i64.extend_u/i32
    (i32.shr_s
     (tee_local $8
      (i32.sub
       (tee_local $9
        (i32.load
         (i32.add
          (get_local $1)
          (i32.const 28)
         )
        )
       )
       (tee_local $7
        (i32.load offset=24
         (get_local $1)
        )
       )
      )
     )
     (i32.const 3)
    )
   )
  )
  (loop $label$0
   (set_local $3
    (i32.add
     (get_local $3)
     (i32.const 1)
    )
   )
   (br_if $label$0
    (i64.ne
     (tee_local $10
      (i64.shr_u
       (get_local $10)
       (i64.const 7)
      )
     )
     (i64.const 0)
    )
   )
  )
  (block $label$1
   (br_if $label$1
    (i32.eq
     (get_local $7)
     (get_local $9)
    )
   )
   (set_local $3
    (i32.add
     (i32.and
      (get_local $8)
      (i32.const -8)
     )
     (get_local $3)
    )
   )
  )
  (block $label$2
   (block $label$3
    (br_if $label$3
     (i32.lt_u
      (get_local $3)
      (i32.const 513)
     )
    )
    (set_local $11
     (call $malloc
      (get_local $3)
     )
    )
    (br $label$2)
   )
   (i32.store offset=4
    (i32.const 0)
    (tee_local $11
     (i32.sub
      (get_local $11)
      (i32.and
       (i32.add
        (get_local $3)
        (i32.const 15)
       )
       (i32.const -16)
      )
     )
    )
   )
  )
  (i32.store offset=8
   (get_local $12)
   (get_local $11)
  )
  (i32.store offset=16
   (get_local $12)
   (tee_local $9
    (i32.add
     (get_local $11)
     (get_local $3)
    )
   )
  )
  (call $eosio_assert
   (i32.gt_s
    (get_local $3)
    (i32.const 7)
   )
   (i32.const 432)
  )
  (drop
   (call $memcpy
    (get_local $11)
    (get_local $1)
    (i32.const 8)
   )
  )
  (call $eosio_assert
   (i32.gt_s
    (i32.sub
     (get_local $9)
     (tee_local $7
      (i32.add
       (get_local $11)
       (i32.const 8)
      )
     )
    )
    (i32.const 7)
   )
   (i32.const 432)
  )
  (drop
   (call $memcpy
    (get_local $7)
    (i32.add
     (get_local $1)
     (i32.const 8)
    )
    (i32.const 8)
   )
  )
  (call $eosio_assert
   (i32.gt_s
    (i32.sub
     (get_local $9)
     (tee_local $7
      (i32.add
       (get_local $11)
       (i32.const 16)
      )
     )
    )
    (i32.const 7)
   )
   (i32.const 432)
  )
  (drop
   (call $memcpy
    (get_local $7)
    (get_local $5)
    (i32.const 8)
   )
  )
  (i32.store offset=12
   (get_local $12)
   (i32.add
    (get_local $11)
    (i32.const 24)
   )
  )
  (drop
   (call $_ZN5eosiolsINS_10datastreamIPcEENS_4nameEEERT_S6_RKNSt3__16vectorIT0_NS7_9allocatorIS9_EEEE
    (i32.add
     (get_local $12)
     (i32.const 8)
    )
    (get_local $6)
   )
  )
  (call $db_update_i64
   (i32.load offset=40
    (get_local $1)
   )
   (get_local $2)
   (get_local $11)
   (get_local $3)
  )
  (block $label$4
   (br_if $label$4
    (i32.lt_u
     (get_local $3)
     (i32.const 513)
    )
   )
   (call $free
    (get_local $11)
   )
  )
  (block $label$5
   (br_if $label$5
    (i64.lt_u
     (get_local $4)
     (i64.load offset=16
      (get_local $0)
     )
    )
   )
   (i64.store
    (i32.add
     (get_local $0)
     (i32.const 16)
    )
    (select
     (i64.const -2)
     (i64.add
      (get_local $4)
      (i64.const 1)
     )
     (i64.gt_u
      (get_local $4)
      (i64.const -3)
     )
    )
   )
  )
  (i64.store offset=40
   (get_local $12)
   (i64.load
    (i32.add
     (get_local $1)
     (i32.const 8)
    )
   )
  )
  (block $label$6
   (br_if $label$6
    (i32.eqz
     (call $memcmp
      (i32.add
       (get_local $12)
       (i32.const 24)
      )
      (i32.add
       (get_local $12)
       (i32.const 40)
      )
      (i32.const 8)
     )
    )
   )
   (block $label$7
    (br_if $label$7
     (i32.gt_s
      (tee_local $3
       (i32.load offset=44
        (get_local $1)
       )
      )
      (i32.const -1)
     )
    )
    (i32.store
     (i32.add
      (get_local $1)
      (i32.const 44)
     )
     (tee_local $3
      (call $db_idx64_find_primary
       (i64.load
        (get_local $0)
       )
       (i64.load offset=8
        (get_local $0)
       )
       (i64.const -2507752926491967488)
       (i32.add
        (get_local $12)
        (i32.const 32)
       )
       (get_local $4)
      )
     )
    )
   )
   (call $db_idx64_update
    (get_local $3)
    (get_local $2)
    (i32.add
     (get_local $12)
     (i32.const 40)
    )
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $12)
    (i32.const 48)
   )
  )
 )
 (func $_ZN5eosio11multi_indexILy4730634643120193536E9candidateJNS_10indexed_byILy8518361509820596224EN5boost11multi_index13const_mem_funIS1_oXadL_ZNKS1_22get_by_is_cust_and_payEvEEEEEENS2_ILy4591222642450628608ENS5_IS1_yXadL_ZNKS1_15by_number_votesEvEEEEEEEE6modifyIZN12daccustodian13tallyNewVotesEvEUlRT_E_EEvRKS1_yOSD_ (param $0 i32) (param $1 i32) (param $2 i64) (param $3 i32)
  (local $4 i32)
  (local $5 i64)
  (local $6 i32)
  (local $7 i32)
  (i32.store offset=4
   (i32.const 0)
   (tee_local $6
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 96)
    )
   )
  )
  (i64.store offset=80
   (tee_local $7
    (get_local $6)
   )
   (get_local $2)
  )
  (call $eosio_assert
   (i32.eq
    (i32.load offset=88
     (get_local $1)
    )
    (get_local $0)
   )
   (i32.const 608)
  )
  (call $eosio_assert
   (i64.eq
    (i64.load
     (get_local $0)
    )
    (call $current_receiver)
   )
   (i32.const 656)
  )
  (i64.store offset=56
   (get_local $7)
   (i64.const 0)
  )
  (i64.store offset=64
   (get_local $7)
   (i64.load offset=80
    (get_local $1)
   )
  )
  (i64.store offset=48
   (get_local $7)
   (i64.or
    (i64.shl
     (i64.load8_u offset=56
      (get_local $1)
     )
     (i64.const 8)
    )
    (i64.load offset=24
     (get_local $1)
    )
   )
  )
  (i64.store offset=40
   (get_local $7)
   (tee_local $5
    (i64.load
     (get_local $1)
    )
   )
  )
  (i64.store
   (get_local $7)
   (i64.load offset=12 align=4
    (i32.load
     (get_local $3)
    )
   )
  )
  (set_local $3
   (call $_ZN5eosio11multi_indexILy15938991147217584128E4voteJNS_10indexed_byILy4587895300147904512EN5boost11multi_index13const_mem_funIS1_yXadL_ZNKS1_8by_proxyEvEEEEEEEE5indexILy4587895300147904512ES6_Ly0ELb0EE14const_iteratormmEv
    (get_local $7)
   )
  )
  (i64.store offset=80
   (get_local $1)
   (i64.add
    (i64.load offset=80
     (get_local $1)
    )
    (i64.load offset=16
     (i32.load offset=4
      (get_local $3)
     )
    )
   )
  )
  (call $eosio_assert
   (i64.eq
    (get_local $5)
    (i64.load
     (get_local $1)
    )
   )
   (i32.const 720)
  )
  (set_local $3
   (i32.add
    (tee_local $4
     (select
      (i32.load
       (i32.add
        (get_local $1)
        (i32.const 12)
       )
      )
      (i32.shr_u
       (tee_local $3
        (i32.load8_u offset=8
         (get_local $1)
        )
       )
       (i32.const 1)
      )
      (i32.and
       (get_local $3)
       (i32.const 1)
      )
     )
    )
    (i32.const 65)
   )
  )
  (set_local $5
   (i64.extend_u/i32
    (get_local $4)
   )
  )
  (loop $label$0
   (set_local $3
    (i32.add
     (get_local $3)
     (i32.const 1)
    )
   )
   (br_if $label$0
    (i64.ne
     (tee_local $5
      (i64.shr_u
       (get_local $5)
       (i64.const 7)
      )
     )
     (i64.const 0)
    )
   )
  )
  (block $label$1
   (block $label$2
    (br_if $label$2
     (i32.lt_u
      (get_local $3)
      (i32.const 513)
     )
    )
    (set_local $6
     (call $malloc
      (get_local $3)
     )
    )
    (set_local $2
     (i64.load offset=80
      (get_local $7)
     )
    )
    (br $label$1)
   )
   (i32.store offset=4
    (i32.const 0)
    (tee_local $6
     (i32.sub
      (get_local $6)
      (i32.and
       (i32.add
        (get_local $3)
        (i32.const 15)
       )
       (i32.const -16)
      )
     )
    )
   )
  )
  (i32.store offset=28
   (get_local $7)
   (get_local $6)
  )
  (i32.store offset=24
   (get_local $7)
   (get_local $6)
  )
  (i32.store offset=32
   (get_local $7)
   (i32.add
    (get_local $6)
    (get_local $3)
   )
  )
  (drop
   (call $_ZlsIN5eosio10datastreamIPcEEERT_S5_RK9candidate
    (i32.add
     (get_local $7)
     (i32.const 24)
    )
    (get_local $1)
   )
  )
  (call $db_update_i64
   (i32.load offset=92
    (get_local $1)
   )
   (get_local $2)
   (get_local $6)
   (get_local $3)
  )
  (block $label$3
   (br_if $label$3
    (i32.lt_u
     (get_local $3)
     (i32.const 513)
    )
   )
   (call $free
    (get_local $6)
   )
  )
  (set_local $3
   (i32.add
    (get_local $0)
    (i32.const 36)
   )
  )
  (block $label$4
   (br_if $label$4
    (i64.lt_u
     (tee_local $5
      (i64.load offset=40
       (get_local $7)
      )
     )
     (i64.load offset=16
      (get_local $0)
     )
    )
   )
   (i64.store
    (i32.add
     (get_local $0)
     (i32.const 16)
    )
    (select
     (i64.const -2)
     (i64.add
      (get_local $5)
      (i64.const 1)
     )
     (i64.gt_u
      (get_local $5)
      (i64.const -3)
     )
    )
   )
  )
  (i32.store offset=4
   (get_local $7)
   (get_local $1)
  )
  (i32.store
   (get_local $7)
   (get_local $0)
  )
  (i32.store offset=12
   (get_local $7)
   (get_local $1)
  )
  (i32.store offset=8
   (get_local $7)
   (i32.add
    (get_local $7)
    (i32.const 48)
   )
  )
  (i32.store offset=16
   (get_local $7)
   (i32.add
    (get_local $7)
    (i32.const 40)
   )
  )
  (i32.store offset=20
   (get_local $7)
   (i32.add
    (get_local $7)
    (i32.const 80)
   )
  )
  (i32.store offset=88
   (get_local $7)
   (get_local $7)
  )
  (call $_ZNK5boost4hana6detail7on_eachIPZN5eosio11multi_indexILy4730634643120193536E9candidateJNS3_10indexed_byILy8518361509820596224ENS_11multi_index13const_mem_funIS5_oXadL_ZNKS5_22get_by_is_cust_and_payEvEEEEEENS6_ILy4591222642450628608ENS8_IS5_yXadL_ZNKS5_15by_number_votesEvEEEEEEEE6modifyIZN12daccustodian13tallyNewVotesEvEUlRT_E_EEvRKS5_yOSG_EUlSH_E_EclIJRNS0_5tupleIJNS0_9type_implINSD_5indexILy8518361509820596224ES9_Ly0ELb0EEEE1_ENSR_INSS_ILy8518361509820596224ES9_Ly0ELb1EEEE1_EEEERNSQ_IJNSR_INSS_ILy4591222642450628608ESB_Ly1ELb0EEEE1_ENSR_INSS_ILy4591222642450628608ESB_Ly1ELb1EEEE1_EEEEEEEvDpOT_
   (i32.add
    (get_local $7)
    (i32.const 88)
   )
   (get_local $3)
   (i32.add
    (get_local $3)
    (i32.const 1)
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $7)
    (i32.const 96)
   )
  )
 )
 (func $_ZNK5boost4hana6detail7on_eachIPZN5eosio11multi_indexILy4730634643120193536E9candidateJNS3_10indexed_byILy8518361509820596224ENS_11multi_index13const_mem_funIS5_oXadL_ZNKS5_22get_by_is_cust_and_payEvEEEEEENS6_ILy4591222642450628608ENS8_IS5_yXadL_ZNKS5_15by_number_votesEvEEEEEEEE6modifyIZN12daccustodian13tallyNewVotesEvEUlRT_E_EEvRKS5_yOSG_EUlSH_E_EclIJRNS0_5tupleIJNS0_9type_implINSD_5indexILy8518361509820596224ES9_Ly0ELb0EEEE1_ENSR_INSS_ILy8518361509820596224ES9_Ly0ELb1EEEE1_EEEERNSQ_IJNSR_INSS_ILy4591222642450628608ESB_Ly1ELb0EEEE1_ENSR_INSS_ILy4591222642450628608ESB_Ly1ELb1EEEE1_EEEEEEEvDpOT_ (param $0 i32) (param $1 i32) (param $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (i32.store offset=4
   (i32.const 0)
   (tee_local $6
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 32)
    )
   )
  )
  (set_local $4
   (i32.load
    (tee_local $3
     (i32.load
      (get_local $0)
     )
    )
   )
  )
  (set_local $5
   (i32.load offset=4
    (get_local $3)
   )
  )
  (i64.store offset=24
   (get_local $6)
   (i64.const 0)
  )
  (i64.store offset=16
   (get_local $6)
   (i64.or
    (i64.shl
     (i64.load8_u offset=56
      (get_local $5)
     )
     (i64.const 8)
    )
    (i64.load offset=24
     (get_local $5)
    )
   )
  )
  (block $label$0
   (br_if $label$0
    (i32.eqz
     (call $memcmp
      (i32.load offset=8
       (get_local $3)
      )
      (i32.add
       (get_local $6)
       (i32.const 16)
      )
      (i32.const 16)
     )
    )
   )
   (block $label$1
    (br_if $label$1
     (i32.gt_s
      (tee_local $5
       (i32.load offset=96
        (i32.load offset=12
         (get_local $3)
        )
       )
      )
      (i32.const -1)
     )
    )
    (set_local $5
     (call $db_idx128_find_primary
      (i64.load
       (get_local $4)
      )
      (i64.load offset=8
       (get_local $4)
      )
      (i64.const 4730634643120193536)
      (get_local $6)
      (i64.load
       (i32.load offset=16
        (get_local $3)
       )
      )
     )
    )
    (i32.store offset=96
     (i32.load
      (i32.add
       (get_local $3)
       (i32.const 12)
      )
     )
     (get_local $5)
    )
   )
   (call $db_idx128_update
    (get_local $5)
    (i64.load
     (i32.load offset=20
      (get_local $3)
     )
    )
    (i32.add
     (get_local $6)
     (i32.const 16)
    )
   )
  )
  (set_local $5
   (i32.load
    (tee_local $3
     (i32.load
      (get_local $0)
     )
    )
   )
  )
  (i64.store offset=16
   (get_local $6)
   (i64.load offset=80
    (i32.load offset=4
     (get_local $3)
    )
   )
  )
  (block $label$2
   (br_if $label$2
    (i32.eqz
     (call $memcmp
      (i32.add
       (i32.load offset=8
        (get_local $3)
       )
       (i32.const 16)
      )
      (i32.add
       (get_local $6)
       (i32.const 16)
      )
      (i32.const 8)
     )
    )
   )
   (block $label$3
    (br_if $label$3
     (i32.gt_s
      (tee_local $0
       (i32.load
        (i32.add
         (i32.load offset=12
          (get_local $3)
         )
         (i32.const 100)
        )
       )
      )
      (i32.const -1)
     )
    )
    (set_local $0
     (call $db_idx64_find_primary
      (i64.load
       (get_local $5)
      )
      (i64.load offset=8
       (get_local $5)
      )
      (i64.const 4730634643120193537)
      (get_local $6)
      (i64.load
       (i32.load offset=16
        (get_local $3)
       )
      )
     )
    )
    (i32.store
     (i32.add
      (i32.load
       (i32.add
        (get_local $3)
        (i32.const 12)
       )
      )
      (i32.const 100)
     )
     (get_local $0)
    )
   )
   (call $db_idx64_update
    (get_local $0)
    (i64.load
     (i32.load offset=20
      (get_local $3)
     )
    )
    (i32.add
     (get_local $6)
     (i32.const 16)
    )
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $6)
    (i32.const 32)
   )
  )
 )
 (func $_ZN5eosiolsINS_10datastreamIPcEENS_4nameEEERT_S6_RKNSt3__16vectorIT0_NS7_9allocatorIS9_EEEE (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i64)
  (local $7 i32)
  (local $8 i32)
  (i32.store offset=4
   (i32.const 0)
   (tee_local $8
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 16)
    )
   )
  )
  (set_local $6
   (i64.extend_u/i32
    (i32.shr_s
     (i32.sub
      (i32.load offset=4
       (get_local $1)
      )
      (i32.load
       (get_local $1)
      )
     )
     (i32.const 3)
    )
   )
  )
  (set_local $7
   (i32.load offset=4
    (get_local $0)
   )
  )
  (set_local $4
   (i32.add
    (get_local $0)
    (i32.const 8)
   )
  )
  (set_local $5
   (i32.add
    (get_local $0)
    (i32.const 4)
   )
  )
  (loop $label$0
   (set_local $2
    (i32.wrap/i64
     (get_local $6)
    )
   )
   (i32.store8 offset=15
    (get_local $8)
    (i32.or
     (i32.shl
      (tee_local $3
       (i64.ne
        (tee_local $6
         (i64.shr_u
          (get_local $6)
          (i64.const 7)
         )
        )
        (i64.const 0)
       )
      )
      (i32.const 7)
     )
     (i32.and
      (get_local $2)
      (i32.const 127)
     )
    )
   )
   (call $eosio_assert
    (i32.gt_s
     (i32.sub
      (i32.load
       (get_local $4)
      )
      (get_local $7)
     )
     (i32.const 0)
    )
    (i32.const 432)
   )
   (drop
    (call $memcpy
     (i32.load
      (get_local $5)
     )
     (i32.add
      (get_local $8)
      (i32.const 15)
     )
     (i32.const 1)
    )
   )
   (i32.store
    (get_local $5)
    (tee_local $7
     (i32.add
      (i32.load
       (get_local $5)
      )
      (i32.const 1)
     )
    )
   )
   (br_if $label$0
    (get_local $3)
   )
  )
  (block $label$1
   (br_if $label$1
    (i32.eq
     (tee_local $5
      (i32.load
       (get_local $1)
      )
     )
     (tee_local $3
      (i32.load
       (i32.add
        (get_local $1)
        (i32.const 4)
       )
      )
     )
    )
   )
   (set_local $2
    (i32.add
     (get_local $0)
     (i32.const 4)
    )
   )
   (loop $label$2
    (call $eosio_assert
     (i32.gt_s
      (i32.sub
       (i32.load
        (i32.add
         (get_local $0)
         (i32.const 8)
        )
       )
       (get_local $7)
      )
      (i32.const 7)
     )
     (i32.const 432)
    )
    (drop
     (call $memcpy
      (i32.load
       (get_local $2)
      )
      (get_local $5)
      (i32.const 8)
     )
    )
    (i32.store
     (get_local $2)
     (tee_local $7
      (i32.add
       (i32.load
        (get_local $2)
       )
       (i32.const 8)
      )
     )
    )
    (br_if $label$2
     (i32.ne
      (get_local $3)
      (tee_local $5
       (i32.add
        (get_local $5)
        (i32.const 8)
       )
      )
     )
    )
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $8)
    (i32.const 16)
   )
  )
  (get_local $0)
 )
 (func $_ZN5eosio11multi_indexILy15938991147217584128E4voteJNS_10indexed_byILy4587895300147904512EN5boost11multi_index13const_mem_funIS1_yXadL_ZNKS1_8by_proxyEvEEEEEEEE4itemC2IZNKS8_31load_object_by_primary_iteratorElEUlRT_E_EEPKS8_OSB_ (param $0 i32) (param $1 i32) (param $2 i32) (result i32)
  (local $3 i32)
  (i64.store offset=8
   (get_local $0)
   (i64.const 0)
  )
  (i64.store
   (get_local $0)
   (i64.const 0)
  )
  (i64.store offset=24 align=4
   (get_local $0)
   (i64.const 0)
  )
  (i32.store offset=36
   (get_local $0)
   (get_local $1)
  )
  (i32.store
   (i32.add
    (get_local $0)
    (i32.const 32)
   )
   (i32.const 0)
  )
  (call $eosio_assert
   (i32.gt_u
    (i32.sub
     (i32.load offset=8
      (tee_local $1
       (i32.load offset=4
        (get_local $2)
       )
      )
     )
     (i32.load offset=4
      (get_local $1)
     )
    )
    (i32.const 7)
   )
   (i32.const 576)
  )
  (drop
   (call $memcpy
    (get_local $0)
    (i32.load offset=4
     (get_local $1)
    )
    (i32.const 8)
   )
  )
  (i32.store offset=4
   (get_local $1)
   (tee_local $3
    (i32.add
     (i32.load offset=4
      (get_local $1)
     )
     (i32.const 8)
    )
   )
  )
  (call $eosio_assert
   (i32.gt_u
    (i32.sub
     (i32.load offset=8
      (get_local $1)
     )
     (get_local $3)
    )
    (i32.const 7)
   )
   (i32.const 576)
  )
  (drop
   (call $memcpy
    (i32.add
     (get_local $0)
     (i32.const 8)
    )
    (i32.load offset=4
     (get_local $1)
    )
    (i32.const 8)
   )
  )
  (i32.store offset=4
   (get_local $1)
   (tee_local $3
    (i32.add
     (i32.load offset=4
      (get_local $1)
     )
     (i32.const 8)
    )
   )
  )
  (call $eosio_assert
   (i32.gt_u
    (i32.sub
     (i32.load offset=8
      (get_local $1)
     )
     (get_local $3)
    )
    (i32.const 7)
   )
   (i32.const 576)
  )
  (drop
   (call $memcpy
    (i32.add
     (get_local $0)
     (i32.const 16)
    )
    (i32.load offset=4
     (get_local $1)
    )
    (i32.const 8)
   )
  )
  (i32.store offset=4
   (get_local $1)
   (i32.add
    (i32.load offset=4
     (get_local $1)
    )
    (i32.const 8)
   )
  )
  (drop
   (call $_ZN5eosiorsINS_10datastreamIPKcEENS_4nameEEERT_S7_RNSt3__16vectorIT0_NS8_9allocatorISA_EEEE
    (get_local $1)
    (i32.add
     (get_local $0)
     (i32.const 24)
    )
   )
  )
  (set_local $1
   (i32.load
    (i32.load offset=8
     (get_local $2)
    )
   )
  )
  (i32.store offset=44
   (get_local $0)
   (i32.const -1)
  )
  (i32.store offset=40
   (get_local $0)
   (get_local $1)
  )
  (get_local $0)
 )
 (func $_ZNSt3__16vectorIN5eosio11multi_indexILy15938991147217584128E4voteJNS1_10indexed_byILy4587895300147904512EN5boost11multi_index13const_mem_funIS3_yXadL_ZNKS3_8by_proxyEvEEEEEEEE8item_ptrENS_9allocatorISB_EEE24__emplace_back_slow_pathIJNS_10unique_ptrINSA_4itemENS_14default_deleteISH_EEEERyRlEEEvDpOT_ (param $0 i32) (param $1 i32) (param $2 i32) (param $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (block $label$0
   (block $label$1
    (br_if $label$1
     (i32.ge_u
      (tee_local $5
       (i32.add
        (tee_local $4
         (i32.div_s
          (i32.sub
           (i32.load offset=4
            (get_local $0)
           )
           (tee_local $6
            (i32.load
             (get_local $0)
            )
           )
          )
          (i32.const 24)
         )
        )
        (i32.const 1)
       )
      )
      (i32.const 178956971)
     )
    )
    (set_local $7
     (i32.const 178956970)
    )
    (block $label$2
     (block $label$3
      (br_if $label$3
       (i32.gt_u
        (tee_local $6
         (i32.div_s
          (i32.sub
           (i32.load offset=8
            (get_local $0)
           )
           (get_local $6)
          )
          (i32.const 24)
         )
        )
        (i32.const 89478484)
       )
      )
      (br_if $label$2
       (i32.eqz
        (tee_local $7
         (select
          (get_local $5)
          (tee_local $7
           (i32.shl
            (get_local $6)
            (i32.const 1)
           )
          )
          (i32.lt_u
           (get_local $7)
           (get_local $5)
          )
         )
        )
       )
      )
     )
     (set_local $6
      (call $_Znwj
       (i32.mul
        (get_local $7)
        (i32.const 24)
       )
      )
     )
     (br $label$0)
    )
    (set_local $7
     (i32.const 0)
    )
    (set_local $6
     (i32.const 0)
    )
    (br $label$0)
   )
   (call $_ZNKSt3__120__vector_base_commonILb1EE20__throw_length_errorEv
    (get_local $0)
   )
   (unreachable)
  )
  (set_local $5
   (i32.load
    (get_local $1)
   )
  )
  (i32.store
   (get_local $1)
   (i32.const 0)
  )
  (i32.store
   (tee_local $1
    (i32.add
     (get_local $6)
     (i32.mul
      (get_local $4)
      (i32.const 24)
     )
    )
   )
   (get_local $5)
  )
  (i64.store offset=8
   (get_local $1)
   (i64.load
    (get_local $2)
   )
  )
  (i32.store offset=16
   (get_local $1)
   (i32.load
    (get_local $3)
   )
  )
  (set_local $4
   (i32.add
    (get_local $6)
    (i32.mul
     (get_local $7)
     (i32.const 24)
    )
   )
  )
  (set_local $5
   (i32.add
    (get_local $1)
    (i32.const 24)
   )
  )
  (block $label$4
   (block $label$5
    (br_if $label$5
     (i32.eq
      (tee_local $6
       (i32.load
        (i32.add
         (get_local $0)
         (i32.const 4)
        )
       )
      )
      (tee_local $7
       (i32.load
        (get_local $0)
       )
      )
     )
    )
    (loop $label$6
     (set_local $3
      (i32.load
       (tee_local $2
        (i32.add
         (get_local $6)
         (i32.const -24)
        )
       )
      )
     )
     (i32.store
      (get_local $2)
      (i32.const 0)
     )
     (i32.store
      (i32.add
       (get_local $1)
       (i32.const -24)
      )
      (get_local $3)
     )
     (i32.store
      (i32.add
       (get_local $1)
       (i32.const -8)
      )
      (i32.load
       (i32.add
        (get_local $6)
        (i32.const -8)
       )
      )
     )
     (i32.store
      (i32.add
       (get_local $1)
       (i32.const -12)
      )
      (i32.load
       (i32.add
        (get_local $6)
        (i32.const -12)
       )
      )
     )
     (i32.store
      (i32.add
       (get_local $1)
       (i32.const -16)
      )
      (i32.load
       (i32.add
        (get_local $6)
        (i32.const -16)
       )
      )
     )
     (set_local $1
      (i32.add
       (get_local $1)
       (i32.const -24)
      )
     )
     (set_local $6
      (get_local $2)
     )
     (br_if $label$6
      (i32.ne
       (get_local $7)
       (get_local $2)
      )
     )
    )
    (set_local $7
     (i32.load
      (i32.add
       (get_local $0)
       (i32.const 4)
      )
     )
    )
    (set_local $2
     (i32.load
      (get_local $0)
     )
    )
    (br $label$4)
   )
   (set_local $2
    (get_local $7)
   )
  )
  (i32.store
   (get_local $0)
   (get_local $1)
  )
  (i32.store
   (i32.add
    (get_local $0)
    (i32.const 4)
   )
   (get_local $5)
  )
  (i32.store
   (i32.add
    (get_local $0)
    (i32.const 8)
   )
   (get_local $4)
  )
  (block $label$7
   (br_if $label$7
    (i32.eq
     (get_local $7)
     (get_local $2)
    )
   )
   (loop $label$8
    (set_local $1
     (i32.load
      (tee_local $7
       (i32.add
        (get_local $7)
        (i32.const -24)
       )
      )
     )
    )
    (i32.store
     (get_local $7)
     (i32.const 0)
    )
    (block $label$9
     (br_if $label$9
      (i32.eqz
       (get_local $1)
      )
     )
     (block $label$10
      (br_if $label$10
       (i32.eqz
        (tee_local $6
         (i32.load offset=24
          (get_local $1)
         )
        )
       )
      )
      (i32.store
       (i32.add
        (get_local $1)
        (i32.const 28)
       )
       (get_local $6)
      )
      (call $_ZdlPv
       (get_local $6)
      )
     )
     (call $_ZdlPv
      (get_local $1)
     )
    )
    (br_if $label$8
     (i32.ne
      (get_local $2)
      (get_local $7)
     )
    )
   )
  )
  (block $label$11
   (br_if $label$11
    (i32.eqz
     (get_local $2)
    )
   )
   (call $_ZdlPv
    (get_local $2)
   )
  )
 )
 (func $_ZN5eosiorsINS_10datastreamIPKcEENS_4nameEEERT_S7_RNSt3__16vectorIT0_NS8_9allocatorISA_EEEE (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i64)
  (local $7 i32)
  (set_local $5
   (i32.load offset=4
    (get_local $0)
   )
  )
  (set_local $7
   (i32.const 0)
  )
  (set_local $6
   (i64.const 0)
  )
  (set_local $2
   (i32.add
    (get_local $0)
    (i32.const 8)
   )
  )
  (set_local $3
   (i32.add
    (get_local $0)
    (i32.const 4)
   )
  )
  (loop $label$0
   (call $eosio_assert
    (i32.lt_u
     (get_local $5)
     (i32.load
      (get_local $2)
     )
    )
    (i32.const 592)
   )
   (set_local $4
    (i32.load8_u
     (tee_local $5
      (i32.load
       (get_local $3)
      )
     )
    )
   )
   (i32.store
    (get_local $3)
    (tee_local $5
     (i32.add
      (get_local $5)
      (i32.const 1)
     )
    )
   )
   (set_local $6
    (i64.or
     (i64.extend_u/i32
      (i32.shl
       (i32.and
        (get_local $4)
        (i32.const 127)
       )
       (tee_local $7
        (i32.and
         (get_local $7)
         (i32.const 255)
        )
       )
      )
     )
     (get_local $6)
    )
   )
   (set_local $7
    (i32.add
     (get_local $7)
     (i32.const 7)
    )
   )
   (br_if $label$0
    (i32.shr_u
     (get_local $4)
     (i32.const 7)
    )
   )
  )
  (block $label$1
   (block $label$2
    (block $label$3
     (br_if $label$3
      (i32.le_u
       (tee_local $5
        (i32.wrap/i64
         (get_local $6)
        )
       )
       (tee_local $7
        (i32.shr_s
         (i32.sub
          (tee_local $3
           (i32.load offset=4
            (get_local $1)
           )
          )
          (tee_local $4
           (i32.load
            (get_local $1)
           )
          )
         )
         (i32.const 3)
        )
       )
      )
     )
     (call $_ZNSt3__16vectorIN5eosio4nameENS_9allocatorIS2_EEE8__appendEj
      (get_local $1)
      (i32.sub
       (get_local $5)
       (get_local $7)
      )
     )
     (br_if $label$2
      (i32.ne
       (tee_local $4
        (i32.load
         (get_local $1)
        )
       )
       (tee_local $3
        (i32.load
         (i32.add
          (get_local $1)
          (i32.const 4)
         )
        )
       )
      )
     )
     (br $label$1)
    )
    (block $label$4
     (br_if $label$4
      (i32.ge_u
       (get_local $5)
       (get_local $7)
      )
     )
     (i32.store
      (i32.add
       (get_local $1)
       (i32.const 4)
      )
      (tee_local $3
       (i32.add
        (get_local $4)
        (i32.shl
         (get_local $5)
         (i32.const 3)
        )
       )
      )
     )
    )
    (br_if $label$1
     (i32.eq
      (get_local $4)
      (get_local $3)
     )
    )
   )
   (set_local $7
    (i32.load
     (tee_local $5
      (i32.add
       (get_local $0)
       (i32.const 4)
      )
     )
    )
   )
   (loop $label$5
    (call $eosio_assert
     (i32.gt_u
      (i32.sub
       (i32.load
        (i32.add
         (get_local $0)
         (i32.const 8)
        )
       )
       (get_local $7)
      )
      (i32.const 7)
     )
     (i32.const 576)
    )
    (drop
     (call $memcpy
      (get_local $4)
      (i32.load
       (get_local $5)
      )
      (i32.const 8)
     )
    )
    (i32.store
     (get_local $5)
     (tee_local $7
      (i32.add
       (i32.load
        (get_local $5)
       )
       (i32.const 8)
      )
     )
    )
    (br_if $label$5
     (i32.ne
      (get_local $3)
      (tee_local $4
       (i32.add
        (get_local $4)
        (i32.const 8)
       )
      )
     )
    )
   )
  )
  (get_local $0)
 )
 (func $_ZNSt3__16vectorIN5eosio4nameENS_9allocatorIS2_EEE8__appendEj (param $0 i32) (param $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (block $label$0
   (block $label$1
    (block $label$2
     (block $label$3
      (block $label$4
       (br_if $label$4
        (i32.ge_u
         (i32.shr_s
          (i32.sub
           (tee_local $7
            (i32.load offset=8
             (get_local $0)
            )
           )
           (tee_local $2
            (i32.load offset=4
             (get_local $0)
            )
           )
          )
          (i32.const 3)
         )
         (get_local $1)
        )
       )
       (br_if $label$2
        (i32.ge_u
         (tee_local $2
          (i32.add
           (tee_local $4
            (i32.shr_s
             (i32.sub
              (get_local $2)
              (tee_local $3
               (i32.load
                (get_local $0)
               )
              )
             )
             (i32.const 3)
            )
           )
           (get_local $1)
          )
         )
         (i32.const 536870912)
        )
       )
       (set_local $6
        (i32.const 536870911)
       )
       (block $label$5
        (br_if $label$5
         (i32.gt_u
          (i32.shr_s
           (tee_local $7
            (i32.sub
             (get_local $7)
             (get_local $3)
            )
           )
           (i32.const 3)
          )
          (i32.const 268435454)
         )
        )
        (br_if $label$3
         (i32.eqz
          (tee_local $6
           (select
            (get_local $2)
            (tee_local $6
             (i32.shr_s
              (get_local $7)
              (i32.const 2)
             )
            )
            (i32.lt_u
             (get_local $6)
             (get_local $2)
            )
           )
          )
         )
        )
        (br_if $label$1
         (i32.ge_u
          (get_local $6)
          (i32.const 536870912)
         )
        )
       )
       (set_local $7
        (call $_Znwj
         (i32.shl
          (get_local $6)
          (i32.const 3)
         )
        )
       )
       (br $label$0)
      )
      (set_local $6
       (get_local $2)
      )
      (set_local $7
       (get_local $1)
      )
      (loop $label$6
       (i64.store
        (get_local $6)
        (i64.const 0)
       )
       (set_local $6
        (i32.add
         (get_local $6)
         (i32.const 8)
        )
       )
       (br_if $label$6
        (tee_local $7
         (i32.add
          (get_local $7)
          (i32.const -1)
         )
        )
       )
      )
      (i32.store
       (i32.add
        (get_local $0)
        (i32.const 4)
       )
       (i32.add
        (get_local $2)
        (i32.shl
         (get_local $1)
         (i32.const 3)
        )
       )
      )
      (return)
     )
     (set_local $6
      (i32.const 0)
     )
     (set_local $7
      (i32.const 0)
     )
     (br $label$0)
    )
    (call $_ZNKSt3__120__vector_base_commonILb1EE20__throw_length_errorEv
     (get_local $0)
    )
    (unreachable)
   )
   (call $abort)
   (unreachable)
  )
  (set_local $3
   (i32.add
    (get_local $7)
    (i32.shl
     (get_local $6)
     (i32.const 3)
    )
   )
  )
  (set_local $6
   (tee_local $2
    (i32.add
     (get_local $7)
     (i32.shl
      (get_local $4)
      (i32.const 3)
     )
    )
   )
  )
  (set_local $7
   (get_local $1)
  )
  (loop $label$7
   (i64.store
    (get_local $6)
    (i64.const 0)
   )
   (set_local $6
    (i32.add
     (get_local $6)
     (i32.const 8)
    )
   )
   (br_if $label$7
    (tee_local $7
     (i32.add
      (get_local $7)
      (i32.const -1)
     )
    )
   )
  )
  (set_local $4
   (i32.add
    (get_local $2)
    (i32.shl
     (get_local $1)
     (i32.const 3)
    )
   )
  )
  (set_local $1
   (i32.sub
    (get_local $2)
    (tee_local $7
     (i32.sub
      (i32.load
       (tee_local $5
        (i32.add
         (get_local $0)
         (i32.const 4)
        )
       )
      )
      (tee_local $6
       (i32.load
        (get_local $0)
       )
      )
     )
    )
   )
  )
  (block $label$8
   (br_if $label$8
    (i32.lt_s
     (get_local $7)
     (i32.const 1)
    )
   )
   (drop
    (call $memcpy
     (get_local $1)
     (get_local $6)
     (get_local $7)
    )
   )
   (set_local $6
    (i32.load
     (get_local $0)
    )
   )
  )
  (i32.store
   (get_local $0)
   (get_local $1)
  )
  (i32.store
   (get_local $5)
   (get_local $4)
  )
  (i32.store
   (i32.add
    (get_local $0)
    (i32.const 8)
   )
   (get_local $3)
  )
  (block $label$9
   (br_if $label$9
    (i32.eqz
     (get_local $6)
    )
   )
   (call $_ZdlPv
    (get_local $6)
   )
  )
 )
 (func $_ZN5eosio11multi_indexILy3607749779137757184E7accountJEE4itemC2IZNKS2_31load_object_by_primary_iteratorElEUlRT_E_EEPKS2_OS5_ (param $0 i32) (param $1 i32) (param $2 i32) (result i32)
  (local $3 i64)
  (local $4 i32)
  (local $5 i32)
  (i64.store offset=8
   (get_local $0)
   (i64.const 1398362884)
  )
  (i64.store
   (get_local $0)
   (i64.const 0)
  )
  (call $eosio_assert
   (i32.const 1)
   (i32.const 480)
  )
  (set_local $3
   (i64.shr_u
    (i64.load offset=8
     (get_local $0)
    )
    (i64.const 8)
   )
  )
  (set_local $4
   (i32.const 0)
  )
  (block $label$0
   (block $label$1
    (loop $label$2
     (br_if $label$1
      (i32.gt_u
       (i32.add
        (i32.shl
         (i32.wrap/i64
          (get_local $3)
         )
         (i32.const 24)
        )
        (i32.const -1073741825)
       )
       (i32.const 452984830)
      )
     )
     (block $label$3
      (br_if $label$3
       (i64.ne
        (i64.and
         (tee_local $3
          (i64.shr_u
           (get_local $3)
           (i64.const 8)
          )
         )
         (i64.const 255)
        )
        (i64.const 0)
       )
      )
      (loop $label$4
       (br_if $label$1
        (i64.ne
         (i64.and
          (tee_local $3
           (i64.shr_u
            (get_local $3)
            (i64.const 8)
           )
          )
          (i64.const 255)
         )
         (i64.const 0)
        )
       )
       (br_if $label$4
        (i32.lt_s
         (tee_local $4
          (i32.add
           (get_local $4)
           (i32.const 1)
          )
         )
         (i32.const 7)
        )
       )
      )
     )
     (set_local $5
      (i32.const 1)
     )
     (br_if $label$2
      (i32.lt_s
       (tee_local $4
        (i32.add
         (get_local $4)
         (i32.const 1)
        )
       )
       (i32.const 7)
      )
     )
     (br $label$0)
    )
   )
   (set_local $5
    (i32.const 0)
   )
  )
  (call $eosio_assert
   (get_local $5)
   (i32.const 544)
  )
  (i32.store offset=16
   (get_local $0)
   (get_local $1)
  )
  (call $eosio_assert
   (i32.gt_u
    (i32.sub
     (i32.load offset=8
      (tee_local $4
       (i32.load offset=4
        (get_local $2)
       )
      )
     )
     (i32.load offset=4
      (get_local $4)
     )
    )
    (i32.const 7)
   )
   (i32.const 576)
  )
  (drop
   (call $memcpy
    (get_local $0)
    (i32.load offset=4
     (get_local $4)
    )
    (i32.const 8)
   )
  )
  (i32.store offset=4
   (get_local $4)
   (tee_local $5
    (i32.add
     (i32.load offset=4
      (get_local $4)
     )
     (i32.const 8)
    )
   )
  )
  (call $eosio_assert
   (i32.gt_u
    (i32.sub
     (i32.load offset=8
      (get_local $4)
     )
     (get_local $5)
    )
    (i32.const 7)
   )
   (i32.const 576)
  )
  (drop
   (call $memcpy
    (i32.add
     (get_local $0)
     (i32.const 8)
    )
    (i32.load offset=4
     (get_local $4)
    )
    (i32.const 8)
   )
  )
  (i32.store offset=4
   (get_local $4)
   (i32.add
    (i32.load offset=4
     (get_local $4)
    )
    (i32.const 8)
   )
  )
  (i32.store offset=20
   (get_local $0)
   (i32.load
    (i32.load offset=8
     (get_local $2)
    )
   )
  )
  (get_local $0)
 )
 (func $_ZNSt3__16vectorIN5eosio11multi_indexILy3607749779137757184E7accountJEE8item_ptrENS_9allocatorIS5_EEE24__emplace_back_slow_pathIJNS_10unique_ptrINS4_4itemENS_14default_deleteISB_EEEERyRlEEEvDpOT_ (param $0 i32) (param $1 i32) (param $2 i32) (param $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (block $label$0
   (block $label$1
    (br_if $label$1
     (i32.ge_u
      (tee_local $5
       (i32.add
        (tee_local $4
         (i32.div_s
          (i32.sub
           (i32.load offset=4
            (get_local $0)
           )
           (tee_local $6
            (i32.load
             (get_local $0)
            )
           )
          )
          (i32.const 24)
         )
        )
        (i32.const 1)
       )
      )
      (i32.const 178956971)
     )
    )
    (set_local $7
     (i32.const 178956970)
    )
    (block $label$2
     (block $label$3
      (br_if $label$3
       (i32.gt_u
        (tee_local $6
         (i32.div_s
          (i32.sub
           (i32.load offset=8
            (get_local $0)
           )
           (get_local $6)
          )
          (i32.const 24)
         )
        )
        (i32.const 89478484)
       )
      )
      (br_if $label$2
       (i32.eqz
        (tee_local $7
         (select
          (get_local $5)
          (tee_local $7
           (i32.shl
            (get_local $6)
            (i32.const 1)
           )
          )
          (i32.lt_u
           (get_local $7)
           (get_local $5)
          )
         )
        )
       )
      )
     )
     (set_local $6
      (call $_Znwj
       (i32.mul
        (get_local $7)
        (i32.const 24)
       )
      )
     )
     (br $label$0)
    )
    (set_local $7
     (i32.const 0)
    )
    (set_local $6
     (i32.const 0)
    )
    (br $label$0)
   )
   (call $_ZNKSt3__120__vector_base_commonILb1EE20__throw_length_errorEv
    (get_local $0)
   )
   (unreachable)
  )
  (set_local $5
   (i32.load
    (get_local $1)
   )
  )
  (i32.store
   (get_local $1)
   (i32.const 0)
  )
  (i32.store
   (tee_local $1
    (i32.add
     (get_local $6)
     (i32.mul
      (get_local $4)
      (i32.const 24)
     )
    )
   )
   (get_local $5)
  )
  (i64.store offset=8
   (get_local $1)
   (i64.load
    (get_local $2)
   )
  )
  (i32.store offset=16
   (get_local $1)
   (i32.load
    (get_local $3)
   )
  )
  (set_local $4
   (i32.add
    (get_local $6)
    (i32.mul
     (get_local $7)
     (i32.const 24)
    )
   )
  )
  (set_local $5
   (i32.add
    (get_local $1)
    (i32.const 24)
   )
  )
  (block $label$4
   (block $label$5
    (br_if $label$5
     (i32.eq
      (tee_local $6
       (i32.load
        (i32.add
         (get_local $0)
         (i32.const 4)
        )
       )
      )
      (tee_local $7
       (i32.load
        (get_local $0)
       )
      )
     )
    )
    (loop $label$6
     (set_local $3
      (i32.load
       (tee_local $2
        (i32.add
         (get_local $6)
         (i32.const -24)
        )
       )
      )
     )
     (i32.store
      (get_local $2)
      (i32.const 0)
     )
     (i32.store
      (i32.add
       (get_local $1)
       (i32.const -24)
      )
      (get_local $3)
     )
     (i32.store
      (i32.add
       (get_local $1)
       (i32.const -8)
      )
      (i32.load
       (i32.add
        (get_local $6)
        (i32.const -8)
       )
      )
     )
     (i32.store
      (i32.add
       (get_local $1)
       (i32.const -12)
      )
      (i32.load
       (i32.add
        (get_local $6)
        (i32.const -12)
       )
      )
     )
     (i32.store
      (i32.add
       (get_local $1)
       (i32.const -16)
      )
      (i32.load
       (i32.add
        (get_local $6)
        (i32.const -16)
       )
      )
     )
     (set_local $1
      (i32.add
       (get_local $1)
       (i32.const -24)
      )
     )
     (set_local $6
      (get_local $2)
     )
     (br_if $label$6
      (i32.ne
       (get_local $7)
       (get_local $2)
      )
     )
    )
    (set_local $7
     (i32.load
      (i32.add
       (get_local $0)
       (i32.const 4)
      )
     )
    )
    (set_local $6
     (i32.load
      (get_local $0)
     )
    )
    (br $label$4)
   )
   (set_local $6
    (get_local $7)
   )
  )
  (i32.store
   (get_local $0)
   (get_local $1)
  )
  (i32.store
   (i32.add
    (get_local $0)
    (i32.const 4)
   )
   (get_local $5)
  )
  (i32.store
   (i32.add
    (get_local $0)
    (i32.const 8)
   )
   (get_local $4)
  )
  (block $label$7
   (br_if $label$7
    (i32.eq
     (get_local $7)
     (get_local $6)
    )
   )
   (loop $label$8
    (set_local $1
     (i32.load
      (tee_local $7
       (i32.add
        (get_local $7)
        (i32.const -24)
       )
      )
     )
    )
    (i32.store
     (get_local $7)
     (i32.const 0)
    )
    (block $label$9
     (br_if $label$9
      (i32.eqz
       (get_local $1)
      )
     )
     (call $_ZdlPv
      (get_local $1)
     )
    )
    (br_if $label$8
     (i32.ne
      (get_local $6)
      (get_local $7)
     )
    )
   )
  )
  (block $label$10
   (br_if $label$10
    (i32.eqz
     (get_local $6)
    )
   )
   (call $_ZdlPv
    (get_local $6)
   )
  )
 )
 (func $_ZN5eosio11multi_indexILy15938991147217584128E4voteJNS_10indexed_byILy4587895300147904512EN5boost11multi_index13const_mem_funIS1_yXadL_ZNKS1_8by_proxyEvEEEEEEEE6modifyIZN12daccustodian13clearOldVotesEvEUlRS1_E_EEvRKS1_yOT_ (param $0 i32) (param $1 i32) (param $2 i64) (param $3 i32)
  (local $4 i64)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (local $8 i32)
  (local $9 i32)
  (local $10 i32)
  (local $11 i64)
  (local $12 i32)
  (local $13 i32)
  (i32.store offset=4
   (i32.const 0)
   (tee_local $12
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 48)
    )
   )
  )
  (call $eosio_assert
   (i32.eq
    (i32.load offset=36
     (get_local $1)
    )
    (get_local $0)
   )
   (i32.const 608)
  )
  (call $eosio_assert
   (i64.eq
    (i64.load
     (get_local $0)
    )
    (call $current_receiver)
   )
   (i32.const 656)
  )
  (i64.store offset=16
   (get_local $1)
   (i64.const 0)
  )
  (i64.store offset=24
   (tee_local $13
    (get_local $12)
   )
   (i64.load offset=8
    (get_local $1)
   )
  )
  (set_local $4
   (i64.load
    (get_local $1)
   )
  )
  (call $eosio_assert
   (i32.const 1)
   (i32.const 720)
  )
  (set_local $10
   (i32.const 24)
  )
  (set_local $6
   (i32.add
    (get_local $1)
    (i32.const 24)
   )
  )
  (set_local $5
   (i32.add
    (get_local $1)
    (i32.const 16)
   )
  )
  (set_local $11
   (i64.extend_u/i32
    (i32.shr_s
     (tee_local $8
      (i32.sub
       (tee_local $9
        (i32.load
         (i32.add
          (get_local $1)
          (i32.const 28)
         )
        )
       )
       (tee_local $7
        (i32.load offset=24
         (get_local $1)
        )
       )
      )
     )
     (i32.const 3)
    )
   )
  )
  (loop $label$0
   (set_local $10
    (i32.add
     (get_local $10)
     (i32.const 1)
    )
   )
   (br_if $label$0
    (i64.ne
     (tee_local $11
      (i64.shr_u
       (get_local $11)
       (i64.const 7)
      )
     )
     (i64.const 0)
    )
   )
  )
  (block $label$1
   (br_if $label$1
    (i32.eq
     (get_local $7)
     (get_local $9)
    )
   )
   (set_local $10
    (i32.add
     (i32.and
      (get_local $8)
      (i32.const -8)
     )
     (get_local $10)
    )
   )
  )
  (block $label$2
   (block $label$3
    (br_if $label$3
     (i32.lt_u
      (get_local $10)
      (i32.const 513)
     )
    )
    (set_local $12
     (call $malloc
      (get_local $10)
     )
    )
    (br $label$2)
   )
   (i32.store offset=4
    (i32.const 0)
    (tee_local $12
     (i32.sub
      (get_local $12)
      (i32.and
       (i32.add
        (get_local $10)
        (i32.const 15)
       )
       (i32.const -16)
      )
     )
    )
   )
  )
  (i32.store offset=8
   (get_local $13)
   (get_local $12)
  )
  (i32.store offset=16
   (get_local $13)
   (tee_local $9
    (i32.add
     (get_local $12)
     (get_local $10)
    )
   )
  )
  (call $eosio_assert
   (i32.gt_s
    (get_local $10)
    (i32.const 7)
   )
   (i32.const 432)
  )
  (drop
   (call $memcpy
    (get_local $12)
    (get_local $1)
    (i32.const 8)
   )
  )
  (call $eosio_assert
   (i32.gt_s
    (i32.sub
     (get_local $9)
     (tee_local $7
      (i32.add
       (get_local $12)
       (i32.const 8)
      )
     )
    )
    (i32.const 7)
   )
   (i32.const 432)
  )
  (drop
   (call $memcpy
    (get_local $7)
    (i32.add
     (get_local $1)
     (i32.const 8)
    )
    (i32.const 8)
   )
  )
  (call $eosio_assert
   (i32.gt_s
    (i32.sub
     (get_local $9)
     (tee_local $7
      (i32.add
       (get_local $12)
       (i32.const 16)
      )
     )
    )
    (i32.const 7)
   )
   (i32.const 432)
  )
  (drop
   (call $memcpy
    (get_local $7)
    (get_local $5)
    (i32.const 8)
   )
  )
  (i32.store offset=12
   (get_local $13)
   (i32.add
    (get_local $12)
    (i32.const 24)
   )
  )
  (drop
   (call $_ZN5eosiolsINS_10datastreamIPcEENS_4nameEEERT_S6_RKNSt3__16vectorIT0_NS7_9allocatorIS9_EEEE
    (i32.add
     (get_local $13)
     (i32.const 8)
    )
    (get_local $6)
   )
  )
  (call $db_update_i64
   (i32.load offset=40
    (get_local $1)
   )
   (get_local $2)
   (get_local $12)
   (get_local $10)
  )
  (block $label$4
   (br_if $label$4
    (i32.lt_u
     (get_local $10)
     (i32.const 513)
    )
   )
   (call $free
    (get_local $12)
   )
  )
  (block $label$5
   (br_if $label$5
    (i64.lt_u
     (get_local $4)
     (i64.load offset=16
      (get_local $0)
     )
    )
   )
   (i64.store
    (i32.add
     (get_local $0)
     (i32.const 16)
    )
    (select
     (i64.const -2)
     (i64.add
      (get_local $4)
      (i64.const 1)
     )
     (i64.gt_u
      (get_local $4)
      (i64.const -3)
     )
    )
   )
  )
  (i64.store offset=40
   (get_local $13)
   (i64.load
    (i32.add
     (get_local $1)
     (i32.const 8)
    )
   )
  )
  (block $label$6
   (br_if $label$6
    (i32.eqz
     (call $memcmp
      (i32.add
       (get_local $13)
       (i32.const 24)
      )
      (i32.add
       (get_local $13)
       (i32.const 40)
      )
      (i32.const 8)
     )
    )
   )
   (block $label$7
    (br_if $label$7
     (i32.gt_s
      (tee_local $10
       (i32.load offset=44
        (get_local $1)
       )
      )
      (i32.const -1)
     )
    )
    (i32.store
     (i32.add
      (get_local $1)
      (i32.const 44)
     )
     (tee_local $10
      (call $db_idx64_find_primary
       (i64.load
        (get_local $0)
       )
       (i64.load offset=8
        (get_local $0)
       )
       (i64.const -2507752926491967488)
       (i32.add
        (get_local $13)
        (i32.const 32)
       )
       (get_local $4)
      )
     )
    )
   )
   (call $db_idx64_update
    (get_local $10)
    (get_local $2)
    (i32.add
     (get_local $13)
     (i32.const 40)
    )
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $13)
    (i32.const 48)
   )
  )
 )
 (func $_ZN5eosio11multi_indexILy4730634643120193536E9candidateJNS_10indexed_byILy8518361509820596224EN5boost11multi_index13const_mem_funIS1_oXadL_ZNKS1_22get_by_is_cust_and_payEvEEEEEENS2_ILy4591222642450628608ENS5_IS1_yXadL_ZNKS1_15by_number_votesEvEEEEEEEE6modifyIZN12daccustodian13clearOldVotesEvEUlRS1_E_EEvRKS1_yOT_ (param $0 i32) (param $1 i32) (param $2 i64) (param $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i64)
  (local $7 i32)
  (local $8 i64)
  (local $9 i32)
  (i32.store offset=4
   (i32.const 0)
   (tee_local $7
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 96)
    )
   )
  )
  (i64.store offset=80
   (tee_local $9
    (get_local $7)
   )
   (get_local $2)
  )
  (call $eosio_assert
   (i32.eq
    (i32.load offset=88
     (get_local $1)
    )
    (get_local $0)
   )
   (i32.const 608)
  )
  (call $eosio_assert
   (i64.eq
    (i64.load
     (get_local $0)
    )
    (call $current_receiver)
   )
   (i32.const 656)
  )
  (i64.store offset=56
   (get_local $9)
   (i64.const 0)
  )
  (i64.store offset=64
   (get_local $9)
   (i64.load offset=80
    (get_local $1)
   )
  )
  (i64.store offset=48
   (get_local $9)
   (i64.or
    (i64.shl
     (i64.load8_u offset=56
      (get_local $1)
     )
     (i64.const 8)
    )
    (i64.load offset=24
     (get_local $1)
    )
   )
  )
  (i64.store offset=80
   (get_local $1)
   (i64.const 0)
  )
  (i64.store offset=40
   (get_local $9)
   (tee_local $8
    (i64.load
     (get_local $1)
    )
   )
  )
  (call $eosio_assert
   (i32.const 1)
   (i32.const 720)
  )
  (set_local $5
   (i32.add
    (tee_local $4
     (select
      (i32.load
       (i32.add
        (get_local $1)
        (i32.const 12)
       )
      )
      (i32.shr_u
       (tee_local $5
        (i32.load8_u offset=8
         (get_local $1)
        )
       )
       (i32.const 1)
      )
      (i32.and
       (get_local $5)
       (i32.const 1)
      )
     )
    )
    (i32.const 65)
   )
  )
  (set_local $6
   (i64.extend_u/i32
    (get_local $4)
   )
  )
  (loop $label$0
   (set_local $5
    (i32.add
     (get_local $5)
     (i32.const 1)
    )
   )
   (br_if $label$0
    (i64.ne
     (tee_local $6
      (i64.shr_u
       (get_local $6)
       (i64.const 7)
      )
     )
     (i64.const 0)
    )
   )
  )
  (block $label$1
   (block $label$2
    (br_if $label$2
     (i32.lt_u
      (get_local $5)
      (i32.const 513)
     )
    )
    (set_local $7
     (call $malloc
      (get_local $5)
     )
    )
    (br $label$1)
   )
   (i32.store offset=4
    (i32.const 0)
    (tee_local $7
     (i32.sub
      (get_local $7)
      (i32.and
       (i32.add
        (get_local $5)
        (i32.const 15)
       )
       (i32.const -16)
      )
     )
    )
   )
  )
  (i32.store offset=28
   (get_local $9)
   (get_local $7)
  )
  (i32.store offset=24
   (get_local $9)
   (get_local $7)
  )
  (i32.store offset=32
   (get_local $9)
   (i32.add
    (get_local $7)
    (get_local $5)
   )
  )
  (drop
   (call $_ZlsIN5eosio10datastreamIPcEEERT_S5_RK9candidate
    (i32.add
     (get_local $9)
     (i32.const 24)
    )
    (get_local $1)
   )
  )
  (call $db_update_i64
   (i32.load offset=92
    (get_local $1)
   )
   (get_local $2)
   (get_local $7)
   (get_local $5)
  )
  (block $label$3
   (br_if $label$3
    (i32.lt_u
     (get_local $5)
     (i32.const 513)
    )
   )
   (call $free
    (get_local $7)
   )
   (set_local $8
    (i64.load offset=40
     (get_local $9)
    )
   )
  )
  (set_local $5
   (i32.add
    (get_local $0)
    (i32.const 36)
   )
  )
  (block $label$4
   (br_if $label$4
    (i64.lt_u
     (get_local $8)
     (i64.load offset=16
      (get_local $0)
     )
    )
   )
   (i64.store
    (i32.add
     (get_local $0)
     (i32.const 16)
    )
    (select
     (i64.const -2)
     (i64.add
      (get_local $8)
      (i64.const 1)
     )
     (i64.gt_u
      (get_local $8)
      (i64.const -3)
     )
    )
   )
  )
  (i32.store offset=4
   (get_local $9)
   (get_local $1)
  )
  (i32.store
   (get_local $9)
   (get_local $0)
  )
  (i32.store offset=12
   (get_local $9)
   (get_local $1)
  )
  (i32.store offset=8
   (get_local $9)
   (i32.add
    (get_local $9)
    (i32.const 48)
   )
  )
  (i32.store offset=16
   (get_local $9)
   (i32.add
    (get_local $9)
    (i32.const 40)
   )
  )
  (i32.store offset=20
   (get_local $9)
   (i32.add
    (get_local $9)
    (i32.const 80)
   )
  )
  (i32.store offset=88
   (get_local $9)
   (get_local $9)
  )
  (call $_ZNK5boost4hana6detail7on_eachIPZN5eosio11multi_indexILy4730634643120193536E9candidateJNS3_10indexed_byILy8518361509820596224ENS_11multi_index13const_mem_funIS5_oXadL_ZNKS5_22get_by_is_cust_and_payEvEEEEEENS6_ILy4591222642450628608ENS8_IS5_yXadL_ZNKS5_15by_number_votesEvEEEEEEEE6modifyIZN12daccustodian13clearOldVotesEvEUlRS5_E_EEvRKS5_yOT_EUlRSK_E_EclIJRNS0_5tupleIJNS0_9type_implINSD_5indexILy8518361509820596224ES9_Ly0ELb0EEEE1_ENSS_INST_ILy8518361509820596224ES9_Ly0ELb1EEEE1_EEEERNSR_IJNSS_INST_ILy4591222642450628608ESB_Ly1ELb0EEEE1_ENSS_INST_ILy4591222642450628608ESB_Ly1ELb1EEEE1_EEEEEEEvDpOT_
   (i32.add
    (get_local $9)
    (i32.const 88)
   )
   (get_local $5)
   (i32.add
    (get_local $5)
    (i32.const 1)
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $9)
    (i32.const 96)
   )
  )
 )
 (func $_ZNK5boost4hana6detail7on_eachIPZN5eosio11multi_indexILy4730634643120193536E9candidateJNS3_10indexed_byILy8518361509820596224ENS_11multi_index13const_mem_funIS5_oXadL_ZNKS5_22get_by_is_cust_and_payEvEEEEEENS6_ILy4591222642450628608ENS8_IS5_yXadL_ZNKS5_15by_number_votesEvEEEEEEEE6modifyIZN12daccustodian13clearOldVotesEvEUlRS5_E_EEvRKS5_yOT_EUlRSK_E_EclIJRNS0_5tupleIJNS0_9type_implINSD_5indexILy8518361509820596224ES9_Ly0ELb0EEEE1_ENSS_INST_ILy8518361509820596224ES9_Ly0ELb1EEEE1_EEEERNSR_IJNSS_INST_ILy4591222642450628608ESB_Ly1ELb0EEEE1_ENSS_INST_ILy4591222642450628608ESB_Ly1ELb1EEEE1_EEEEEEEvDpOT_ (param $0 i32) (param $1 i32) (param $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (i32.store offset=4
   (i32.const 0)
   (tee_local $6
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 32)
    )
   )
  )
  (set_local $4
   (i32.load
    (tee_local $3
     (i32.load
      (get_local $0)
     )
    )
   )
  )
  (set_local $5
   (i32.load offset=4
    (get_local $3)
   )
  )
  (i64.store offset=24
   (get_local $6)
   (i64.const 0)
  )
  (i64.store offset=16
   (get_local $6)
   (i64.or
    (i64.shl
     (i64.load8_u offset=56
      (get_local $5)
     )
     (i64.const 8)
    )
    (i64.load offset=24
     (get_local $5)
    )
   )
  )
  (block $label$0
   (br_if $label$0
    (i32.eqz
     (call $memcmp
      (i32.load offset=8
       (get_local $3)
      )
      (i32.add
       (get_local $6)
       (i32.const 16)
      )
      (i32.const 16)
     )
    )
   )
   (block $label$1
    (br_if $label$1
     (i32.gt_s
      (tee_local $5
       (i32.load offset=96
        (i32.load offset=12
         (get_local $3)
        )
       )
      )
      (i32.const -1)
     )
    )
    (set_local $5
     (call $db_idx128_find_primary
      (i64.load
       (get_local $4)
      )
      (i64.load offset=8
       (get_local $4)
      )
      (i64.const 4730634643120193536)
      (get_local $6)
      (i64.load
       (i32.load offset=16
        (get_local $3)
       )
      )
     )
    )
    (i32.store offset=96
     (i32.load
      (i32.add
       (get_local $3)
       (i32.const 12)
      )
     )
     (get_local $5)
    )
   )
   (call $db_idx128_update
    (get_local $5)
    (i64.load
     (i32.load offset=20
      (get_local $3)
     )
    )
    (i32.add
     (get_local $6)
     (i32.const 16)
    )
   )
  )
  (set_local $5
   (i32.load
    (tee_local $3
     (i32.load
      (get_local $0)
     )
    )
   )
  )
  (i64.store offset=16
   (get_local $6)
   (i64.load offset=80
    (i32.load offset=4
     (get_local $3)
    )
   )
  )
  (block $label$2
   (br_if $label$2
    (i32.eqz
     (call $memcmp
      (i32.add
       (i32.load offset=8
        (get_local $3)
       )
       (i32.const 16)
      )
      (i32.add
       (get_local $6)
       (i32.const 16)
      )
      (i32.const 8)
     )
    )
   )
   (block $label$3
    (br_if $label$3
     (i32.gt_s
      (tee_local $0
       (i32.load
        (i32.add
         (i32.load offset=12
          (get_local $3)
         )
         (i32.const 100)
        )
       )
      )
      (i32.const -1)
     )
    )
    (set_local $0
     (call $db_idx64_find_primary
      (i64.load
       (get_local $5)
      )
      (i64.load offset=8
       (get_local $5)
      )
      (i64.const 4730634643120193537)
      (get_local $6)
      (i64.load
       (i32.load offset=16
        (get_local $3)
       )
      )
     )
    )
    (i32.store
     (i32.add
      (i32.load
       (i32.add
        (get_local $3)
        (i32.const 12)
       )
      )
      (i32.const 100)
     )
     (get_local $0)
    )
   )
   (call $db_idx64_update
    (get_local $0)
    (i64.load
     (i32.load offset=20
      (get_local $3)
     )
    )
    (i32.add
     (get_local $6)
     (i32.const 16)
    )
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $6)
    (i32.const 32)
   )
  )
 )
 (func $_ZNK5eosio11multi_indexILy4730634643120193536E9candidateJNS_10indexed_byILy8518361509820596224EN5boost11multi_index13const_mem_funIS1_oXadL_ZNKS1_22get_by_is_cust_and_payEvEEEEEENS2_ILy4591222642450628608ENS5_IS1_yXadL_ZNKS1_15by_number_votesEvEEEEEEEE5indexILy8518361509820596224ES6_Ly0ELb0EE11lower_boundERKo (param $0 i32) (param $1 i32) (param $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i64)
  (local $6 i32)
  (local $7 i32)
  (local $8 i32)
  (local $9 i32)
  (local $10 i32)
  (i32.store offset=4
   (i32.const 0)
   (tee_local $10
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 32)
    )
   )
  )
  (i64.store offset=24
   (get_local $10)
   (i64.const 0)
  )
  (i64.store offset=8
   (get_local $10)
   (i64.load
    (i32.add
     (get_local $2)
     (i32.const 8)
    )
   )
  )
  (i64.store
   (get_local $10)
   (i64.load
    (get_local $2)
   )
  )
  (set_local $2
   (i32.const 0)
  )
  (block $label$0
   (br_if $label$0
    (i32.lt_s
     (tee_local $3
      (call $db_idx128_lowerbound
       (i64.load
        (tee_local $8
         (i32.load
          (get_local $1)
         )
        )
       )
       (i64.load offset=8
        (get_local $8)
       )
       (i64.const 4730634643120193536)
       (get_local $10)
       (i32.add
        (get_local $10)
        (i32.const 24)
       )
      )
     )
     (i32.const 0)
    )
   )
   (set_local $5
    (i64.load offset=24
     (get_local $10)
    )
   )
   (block $label$1
    (br_if $label$1
     (i32.eq
      (tee_local $9
       (i32.load
        (i32.add
         (tee_local $4
          (i32.load
           (get_local $1)
          )
         )
         (i32.const 28)
        )
       )
      )
      (tee_local $6
       (i32.load offset=24
        (get_local $4)
       )
      )
     )
    )
    (set_local $2
     (i32.add
      (get_local $9)
      (i32.const -24)
     )
    )
    (set_local $7
     (i32.sub
      (i32.const 0)
      (get_local $6)
     )
    )
    (loop $label$2
     (br_if $label$1
      (i64.eq
       (i64.load
        (i32.load
         (get_local $2)
        )
       )
       (get_local $5)
      )
     )
     (set_local $9
      (get_local $2)
     )
     (set_local $2
      (tee_local $8
       (i32.add
        (get_local $2)
        (i32.const -24)
       )
      )
     )
     (br_if $label$2
      (i32.ne
       (i32.add
        (get_local $8)
        (get_local $7)
       )
       (i32.const -24)
      )
     )
    )
   )
   (block $label$3
    (block $label$4
     (br_if $label$4
      (i32.eq
       (get_local $9)
       (get_local $6)
      )
     )
     (call $eosio_assert
      (i32.eq
       (i32.load offset=88
        (tee_local $2
         (i32.load
          (i32.add
           (get_local $9)
           (i32.const -24)
          )
         )
        )
       )
       (get_local $4)
      )
      (i32.const 896)
     )
     (br $label$3)
    )
    (call $eosio_assert
     (i32.eq
      (i32.load offset=88
       (tee_local $2
        (call $_ZNK5eosio11multi_indexILy4730634643120193536E9candidateJNS_10indexed_byILy8518361509820596224EN5boost11multi_index13const_mem_funIS1_oXadL_ZNKS1_22get_by_is_cust_and_payEvEEEEEENS2_ILy4591222642450628608ENS5_IS1_yXadL_ZNKS1_15by_number_votesEvEEEEEEEE31load_object_by_primary_iteratorEl
         (get_local $4)
         (call $db_find_i64
          (i64.load
           (get_local $4)
          )
          (i64.load offset=8
           (get_local $4)
          )
          (i64.const 4730634643120193536)
          (get_local $5)
         )
        )
       )
      )
      (get_local $4)
     )
     (i32.const 896)
    )
   )
   (i32.store
    (i32.add
     (get_local $2)
     (i32.const 96)
    )
    (get_local $3)
   )
  )
  (i32.store offset=4
   (get_local $0)
   (get_local $2)
  )
  (i32.store
   (get_local $0)
   (get_local $1)
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $10)
    (i32.const 32)
   )
  )
 )
 (func $_ZN5eosio11multi_indexILy4730634643120193536E9candidateJNS_10indexed_byILy8518361509820596224EN5boost11multi_index13const_mem_funIS1_oXadL_ZNKS1_22get_by_is_cust_and_payEvEEEEEENS2_ILy4591222642450628608ENS5_IS1_yXadL_ZNKS1_15by_number_votesEvEEEEEEEE5indexILy8518361509820596224ES6_Ly0ELb0EE14const_iteratormmEv (param $0 i32) (result i32)
  (local $1 i32)
  (local $2 i64)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (local $8 i32)
  (local $9 i32)
  (i32.store offset=4
   (i32.const 0)
   (tee_local $9
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 32)
    )
   )
  )
  (i64.store offset=24
   (get_local $9)
   (i64.const 0)
  )
  (block $label$0
   (block $label$1
    (br_if $label$1
     (i32.eqz
      (tee_local $7
       (i32.load offset=4
        (get_local $0)
       )
      )
     )
    )
    (block $label$2
     (br_if $label$2
      (i32.ne
       (tee_local $5
        (i32.load offset=96
         (get_local $7)
        )
       )
       (i32.const -1)
      )
     )
     (set_local $5
      (call $db_idx128_find_primary
       (i64.load
        (tee_local $5
         (i32.load
          (i32.load
           (get_local $0)
          )
         )
        )
       )
       (i64.load offset=8
        (get_local $5)
       )
       (i64.const 4730634643120193536)
       (get_local $9)
       (i64.load
        (get_local $7)
       )
      )
     )
     (i32.store offset=96
      (i32.load
       (i32.add
        (get_local $0)
        (i32.const 4)
       )
      )
      (get_local $5)
     )
    )
    (call $eosio_assert
     (i32.xor
      (i32.shr_u
       (tee_local $6
        (call $db_idx128_previous
         (get_local $5)
         (i32.add
          (get_local $9)
          (i32.const 24)
         )
        )
       )
       (i32.const 31)
      )
      (i32.const 1)
     )
     (i32.const 848)
    )
    (br $label$0)
   )
   (call $eosio_assert
    (i32.ne
     (tee_local $7
      (call $db_idx128_end
       (i64.load
        (tee_local $7
         (i32.load
          (i32.load
           (get_local $0)
          )
         )
        )
       )
       (i64.load offset=8
        (get_local $7)
       )
       (i64.const 4730634643120193536)
      )
     )
     (i32.const -1)
    )
    (i32.const 784)
   )
   (call $eosio_assert
    (i32.xor
     (i32.shr_u
      (tee_local $6
       (call $db_idx128_previous
        (get_local $7)
        (i32.add
         (get_local $9)
         (i32.const 24)
        )
       )
      )
      (i32.const 31)
     )
     (i32.const 1)
    )
    (i32.const 784)
   )
  )
  (set_local $2
   (i64.load offset=24
    (get_local $9)
   )
  )
  (block $label$3
   (br_if $label$3
    (i32.eq
     (tee_local $8
      (i32.load
       (i32.add
        (tee_local $1
         (i32.load
          (i32.load
           (get_local $0)
          )
         )
        )
        (i32.const 28)
       )
      )
     )
     (tee_local $3
      (i32.load offset=24
       (get_local $1)
      )
     )
    )
   )
   (set_local $7
    (i32.add
     (get_local $8)
     (i32.const -24)
    )
   )
   (set_local $4
    (i32.sub
     (i32.const 0)
     (get_local $3)
    )
   )
   (loop $label$4
    (br_if $label$3
     (i64.eq
      (i64.load
       (i32.load
        (get_local $7)
       )
      )
      (get_local $2)
     )
    )
    (set_local $8
     (get_local $7)
    )
    (set_local $7
     (tee_local $5
      (i32.add
       (get_local $7)
       (i32.const -24)
      )
     )
    )
    (br_if $label$4
     (i32.ne
      (i32.add
       (get_local $5)
       (get_local $4)
      )
      (i32.const -24)
     )
    )
   )
  )
  (block $label$5
   (block $label$6
    (br_if $label$6
     (i32.eq
      (get_local $8)
      (get_local $3)
     )
    )
    (call $eosio_assert
     (i32.eq
      (i32.load offset=88
       (tee_local $7
        (i32.load
         (i32.add
          (get_local $8)
          (i32.const -24)
         )
        )
       )
      )
      (get_local $1)
     )
     (i32.const 896)
    )
    (br $label$5)
   )
   (call $eosio_assert
    (i32.eq
     (i32.load offset=88
      (tee_local $7
       (call $_ZNK5eosio11multi_indexILy4730634643120193536E9candidateJNS_10indexed_byILy8518361509820596224EN5boost11multi_index13const_mem_funIS1_oXadL_ZNKS1_22get_by_is_cust_and_payEvEEEEEENS2_ILy4591222642450628608ENS5_IS1_yXadL_ZNKS1_15by_number_votesEvEEEEEEEE31load_object_by_primary_iteratorEl
        (get_local $1)
        (call $db_find_i64
         (i64.load
          (get_local $1)
         )
         (i64.load offset=8
          (get_local $1)
         )
         (i64.const 4730634643120193536)
         (get_local $2)
        )
       )
      )
     )
     (get_local $1)
    )
    (i32.const 896)
   )
  )
  (i32.store
   (i32.add
    (get_local $0)
    (i32.const 4)
   )
   (get_local $7)
  )
  (i32.store
   (i32.add
    (get_local $7)
    (i32.const 96)
   )
   (get_local $6)
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $9)
    (i32.const 32)
   )
  )
  (get_local $0)
 )
 (func $_ZNSt3__16vectorIxNS_9allocatorIxEEE21__push_back_slow_pathIRKxEEvOT_ (param $0 i32) (param $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (block $label$0
   (block $label$1
    (block $label$2
     (br_if $label$2
      (i32.ge_u
       (tee_local $7
        (i32.add
         (tee_local $3
          (i32.shr_s
           (i32.sub
            (tee_local $6
             (i32.load offset=4
              (get_local $0)
             )
            )
            (tee_local $5
             (i32.load
              (get_local $0)
             )
            )
           )
           (i32.const 3)
          )
         )
         (i32.const 1)
        )
       )
       (i32.const 536870912)
      )
     )
     (set_local $4
      (i32.const 536870911)
     )
     (block $label$3
      (block $label$4
       (br_if $label$4
        (i32.gt_u
         (i32.shr_s
          (tee_local $2
           (i32.sub
            (i32.load offset=8
             (get_local $0)
            )
            (get_local $5)
           )
          )
          (i32.const 3)
         )
         (i32.const 268435454)
        )
       )
       (br_if $label$3
        (i32.eqz
         (tee_local $4
          (select
           (get_local $7)
           (tee_local $4
            (i32.shr_s
             (get_local $2)
             (i32.const 2)
            )
           )
           (i32.lt_u
            (get_local $4)
            (get_local $7)
           )
          )
         )
        )
       )
       (br_if $label$1
        (i32.ge_u
         (get_local $4)
         (i32.const 536870912)
        )
       )
      )
      (set_local $7
       (call $_Znwj
        (i32.shl
         (get_local $4)
         (i32.const 3)
        )
       )
      )
      (set_local $6
       (i32.load
        (i32.add
         (get_local $0)
         (i32.const 4)
        )
       )
      )
      (set_local $5
       (i32.load
        (get_local $0)
       )
      )
      (br $label$0)
     )
     (set_local $4
      (i32.const 0)
     )
     (set_local $7
      (i32.const 0)
     )
     (br $label$0)
    )
    (call $_ZNKSt3__120__vector_base_commonILb1EE20__throw_length_errorEv
     (get_local $0)
    )
    (unreachable)
   )
   (call $abort)
   (unreachable)
  )
  (i64.store
   (tee_local $3
    (i32.add
     (get_local $7)
     (i32.shl
      (get_local $3)
      (i32.const 3)
     )
    )
   )
   (i64.load
    (get_local $1)
   )
  )
  (set_local $1
   (i32.sub
    (get_local $3)
    (tee_local $6
     (i32.sub
      (get_local $6)
      (get_local $5)
     )
    )
   )
  )
  (set_local $4
   (i32.add
    (get_local $7)
    (i32.shl
     (get_local $4)
     (i32.const 3)
    )
   )
  )
  (set_local $7
   (i32.add
    (get_local $3)
    (i32.const 8)
   )
  )
  (block $label$5
   (br_if $label$5
    (i32.lt_s
     (get_local $6)
     (i32.const 1)
    )
   )
   (drop
    (call $memcpy
     (get_local $1)
     (get_local $5)
     (get_local $6)
    )
   )
   (set_local $5
    (i32.load
     (get_local $0)
    )
   )
  )
  (i32.store
   (get_local $0)
   (get_local $1)
  )
  (i32.store
   (i32.add
    (get_local $0)
    (i32.const 4)
   )
   (get_local $7)
  )
  (i32.store
   (i32.add
    (get_local $0)
    (i32.const 8)
   )
   (get_local $4)
  )
  (block $label$6
   (br_if $label$6
    (i32.eqz
     (get_local $5)
    )
   )
   (call $_ZdlPv
    (get_local $5)
   )
  )
 )
 (func $_ZNSt3__113__nth_elementIRNS_6__lessIxxEENS_11__wrap_iterIPxEEEEvT0_S7_S7_T_ (param $0 i32) (param $1 i32) (param $2 i32) (param $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (local $8 i64)
  (local $9 i64)
  (local $10 i32)
  (local $11 i32)
  (local $12 i64)
  (local $13 i32)
  (local $14 i32)
  (local $15 i32)
  (i32.store offset=4
   (tee_local $15
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 16)
    )
   )
   (get_local $0)
  )
  (i32.store
   (get_local $15)
   (get_local $2)
  )
  (block $label$0
   (br_if $label$0
    (i32.eq
     (get_local $2)
     (get_local $1)
    )
   )
   (loop $label$1
    (set_local $5
     (i32.add
      (get_local $2)
      (i32.const -16)
     )
    )
    (set_local $4
     (i32.add
      (get_local $2)
      (i32.const -8)
     )
    )
    (set_local $6
     (i32.load offset=4
      (get_local $15)
     )
    )
    (set_local $7
     (get_local $0)
    )
    (block $label$2
     (block $label$3
      (block $label$4
       (block $label$5
        (block $label$6
         (block $label$7
          (block $label$8
           (block $label$9
            (loop $label$10
             (br_if $label$5
              (i32.lt_u
               (tee_local $13
                (i32.shr_s
                 (tee_local $14
                  (i32.sub
                   (get_local $2)
                   (get_local $7)
                  )
                 )
                 (i32.const 3)
                )
               )
               (i32.const 2)
              )
             )
             (br_if $label$7
              (i32.eq
               (get_local $13)
               (i32.const 3)
              )
             )
             (br_if $label$6
              (i32.eq
               (get_local $13)
               (i32.const 2)
              )
             )
             (br_if $label$8
              (i32.le_s
               (get_local $14)
               (i32.const 63)
              )
             )
             (i32.store offset=12
              (get_local $15)
              (tee_local $14
               (i32.add
                (get_local $0)
                (i32.and
                 (i32.shl
                  (get_local $13)
                  (i32.const 2)
                 )
                 (i32.const -8)
                )
               )
              )
             )
             (set_local $8
              (i64.load
               (get_local $4)
              )
             )
             (block $label$11
              (block $label$12
               (block $label$13
                (block $label$14
                 (br_if $label$14
                  (i64.ge_s
                   (tee_local $9
                    (i64.load
                     (get_local $14)
                    )
                   )
                   (tee_local $12
                    (i64.load
                     (get_local $0)
                    )
                   )
                  )
                 )
                 (br_if $label$13
                  (i64.ge_s
                   (get_local $8)
                   (get_local $9)
                  )
                 )
                 (i64.store
                  (get_local $0)
                  (get_local $8)
                 )
                 (i64.store
                  (get_local $4)
                  (get_local $12)
                 )
                 (set_local $11
                  (i32.const 1)
                 )
                 (br $label$11)
                )
                (set_local $11
                 (i32.const 0)
                )
                (br_if $label$11
                 (i64.ge_s
                  (get_local $8)
                  (get_local $9)
                 )
                )
                (i64.store
                 (get_local $14)
                 (get_local $8)
                )
                (i64.store
                 (get_local $4)
                 (get_local $9)
                )
                (set_local $11
                 (i32.const 1)
                )
                (br_if $label$11
                 (i64.ge_s
                  (tee_local $8
                   (i64.load
                    (get_local $14)
                   )
                  )
                  (tee_local $9
                   (i64.load
                    (get_local $0)
                   )
                  )
                 )
                )
                (i64.store
                 (get_local $0)
                 (get_local $8)
                )
                (i64.store
                 (get_local $14)
                 (get_local $9)
                )
                (br $label$12)
               )
               (i64.store
                (get_local $0)
                (get_local $9)
               )
               (i64.store
                (get_local $14)
                (get_local $12)
               )
               (set_local $11
                (i32.const 1)
               )
               (br_if $label$11
                (i64.ge_s
                 (tee_local $8
                  (i64.load
                   (get_local $4)
                  )
                 )
                 (get_local $12)
                )
               )
               (i64.store
                (get_local $14)
                (get_local $8)
               )
               (i64.store
                (get_local $4)
                (get_local $12)
               )
              )
              (set_local $11
               (i32.const 2)
              )
             )
             (i32.store offset=8
              (get_local $15)
              (get_local $4)
             )
             (br_if $label$3
              (i64.lt_s
               (tee_local $12
                (i64.load
                 (get_local $0)
                )
               )
               (tee_local $9
                (i64.load
                 (get_local $14)
                )
               )
              )
             )
             (set_local $13
              (get_local $5)
             )
             (block $label$15
              (block $label$16
               (loop $label$17
                (br_if $label$16
                 (i32.eq
                  (get_local $0)
                  (get_local $13)
                 )
                )
                (set_local $8
                 (i64.load
                  (get_local $13)
                 )
                )
                (set_local $13
                 (tee_local $10
                  (i32.add
                   (get_local $13)
                   (i32.const -8)
                  )
                 )
                )
                (br_if $label$17
                 (i64.ge_s
                  (get_local $8)
                  (get_local $9)
                 )
                )
                (br $label$15)
               )
              )
              (set_local $7
               (i32.add
                (get_local $0)
                (i32.const 8)
               )
              )
              (set_local $8
               (i64.load
                (get_local $0)
               )
              )
              (i32.store offset=8
               (get_local $15)
               (get_local $4)
              )
              (block $label$18
               (br_if $label$18
                (i64.lt_s
                 (get_local $8)
                 (tee_local $12
                  (i64.load
                   (get_local $4)
                  )
                 )
                )
               )
               (br_if $label$9
                (i32.eq
                 (get_local $7)
                 (get_local $4)
                )
               )
               (set_local $7
                (i32.add
                 (get_local $0)
                 (i32.const 16)
                )
               )
               (set_local $8
                (i64.load
                 (get_local $0)
                )
               )
               (block $label$19
                (loop $label$20
                 (br_if $label$19
                  (i64.lt_s
                   (get_local $8)
                   (tee_local $9
                    (i64.load
                     (tee_local $13
                      (i32.add
                       (get_local $7)
                       (i32.const -8)
                      )
                     )
                    )
                   )
                  )
                 )
                 (br_if $label$20
                  (i32.ne
                   (get_local $2)
                   (tee_local $7
                    (i32.add
                     (get_local $7)
                     (i32.const 8)
                    )
                   )
                  )
                 )
                 (br $label$9)
                )
               )
               (i64.store
                (get_local $13)
                (get_local $12)
               )
               (i64.store
                (get_local $4)
                (get_local $9)
               )
              )
              (br_if $label$9
               (i32.eq
                (get_local $7)
                (get_local $4)
               )
              )
              (set_local $13
               (get_local $4)
              )
              (loop $label$21
               (block $label$22
                (br_if $label$22
                 (i64.lt_s
                  (tee_local $8
                   (i64.load
                    (get_local $0)
                   )
                  )
                  (tee_local $12
                   (i64.load
                    (get_local $7)
                   )
                  )
                 )
                )
                (loop $label$23
                 (br_if $label$23
                  (i64.ge_s
                   (get_local $8)
                   (tee_local $12
                    (i64.load
                     (tee_local $7
                      (i32.add
                       (get_local $7)
                       (i32.const 8)
                      )
                     )
                    )
                   )
                  )
                 )
                )
               )
               (loop $label$24
                (br_if $label$24
                 (i64.lt_s
                  (get_local $8)
                  (tee_local $9
                   (i64.load
                    (tee_local $13
                     (i32.add
                      (get_local $13)
                      (i32.const -8)
                     )
                    )
                   )
                  )
                 )
                )
               )
               (block $label$25
                (br_if $label$25
                 (i32.ge_u
                  (get_local $7)
                  (get_local $13)
                 )
                )
                (i64.store
                 (get_local $7)
                 (get_local $9)
                )
                (i64.store
                 (get_local $13)
                 (get_local $12)
                )
                (set_local $7
                 (i32.add
                  (get_local $7)
                  (i32.const 8)
                 )
                )
                (br $label$21)
               )
              )
              (i32.store offset=8
               (get_local $15)
               (get_local $13)
              )
              (br_if $label$9
               (i32.gt_u
                (get_local $7)
                (get_local $1)
               )
              )
              (set_local $6
               (get_local $7)
              )
              (set_local $0
               (get_local $7)
              )
              (br_if $label$10
               (i32.ne
                (get_local $2)
                (get_local $1)
               )
              )
              (br $label$4)
             )
            )
            (i64.store
             (get_local $0)
             (get_local $8)
            )
            (i64.store
             (tee_local $4
              (i32.add
               (get_local $10)
               (i32.const 8)
              )
             )
             (get_local $12)
            )
            (i32.store offset=4
             (get_local $15)
             (get_local $6)
            )
            (i32.store offset=8
             (get_local $15)
             (get_local $4)
            )
            (set_local $11
             (i32.add
              (get_local $11)
              (i32.const 1)
             )
            )
            (br $label$2)
           )
           (i32.store offset=4
            (get_local $15)
            (get_local $6)
           )
           (return)
          )
          (i32.store offset=4
           (get_local $15)
           (get_local $6)
          )
          (br_if $label$0
           (i32.eq
            (tee_local $0
             (i32.add
              (get_local $2)
              (i32.const -8)
             )
            )
            (get_local $7)
           )
          )
          (loop $label$26
           (i32.store offset=12
            (get_local $15)
            (get_local $7)
           )
           (block $label$27
            (br_if $label$27
             (i32.eq
              (get_local $7)
              (get_local $2)
             )
            )
            (set_local $13
             (i32.add
              (get_local $15)
              (i32.const 12)
             )
            )
            (set_local $4
             (i32.add
              (get_local $15)
              (i32.const 8)
             )
            )
            (loop $label$28
             (i32.store
              (get_local $4)
              (i32.load
               (get_local $13)
              )
             )
             (set_local $13
              (i32.add
               (i32.load offset=8
                (get_local $15)
               )
               (i32.const 8)
              )
             )
             (set_local $4
              (i32.load offset=12
               (get_local $15)
              )
             )
             (block $label$29
              (block $label$30
               (loop $label$31
                (br_if $label$30
                 (i32.eq
                  (get_local $2)
                  (get_local $13)
                 )
                )
                (set_local $8
                 (i64.load
                  (get_local $13)
                 )
                )
                (set_local $13
                 (tee_local $14
                  (i32.add
                   (get_local $13)
                   (i32.const 8)
                  )
                 )
                )
                (br_if $label$31
                 (i64.ge_s
                  (get_local $8)
                  (i64.load
                   (get_local $4)
                  )
                 )
                )
                (br $label$29)
               )
              )
              (br_if $label$27
               (i32.eq
                (get_local $4)
                (get_local $7)
               )
              )
              (set_local $8
               (i64.load
                (get_local $7)
               )
              )
              (i64.store
               (get_local $7)
               (i64.load
                (get_local $4)
               )
              )
              (i64.store
               (get_local $4)
               (get_local $8)
              )
              (br $label$27)
             )
             (i32.store offset=8
              (get_local $15)
              (i32.add
               (get_local $14)
               (i32.const -8)
              )
             )
             (set_local $4
              (i32.add
               (get_local $15)
               (i32.const 12)
              )
             )
             (set_local $13
              (i32.add
               (get_local $15)
               (i32.const 8)
              )
             )
             (br $label$28)
            )
           )
           (br_if $label$26
            (i32.ne
             (tee_local $7
              (i32.add
               (get_local $7)
               (i32.const 8)
              )
             )
             (get_local $0)
            )
           )
           (br $label$0)
          )
         )
         (i32.store offset=4
          (get_local $15)
          (get_local $6)
         )
         (i32.store
          (get_local $15)
          (tee_local $13
           (i32.add
            (get_local $2)
            (i32.const -8)
           )
          )
         )
         (set_local $8
          (i64.load
           (get_local $13)
          )
         )
         (block $label$32
          (block $label$33
           (br_if $label$33
            (i64.ge_s
             (tee_local $9
              (i64.load offset=8
               (get_local $7)
              )
             )
             (tee_local $12
              (i64.load
               (get_local $7)
              )
             )
            )
           )
           (br_if $label$32
            (i64.ge_s
             (get_local $8)
             (get_local $9)
            )
           )
           (i64.store
            (get_local $7)
            (get_local $8)
           )
           (i64.store
            (get_local $13)
            (get_local $12)
           )
           (return)
          )
          (br_if $label$0
           (i64.ge_s
            (get_local $8)
            (get_local $9)
           )
          )
          (i64.store
           (tee_local $4
            (i32.add
             (get_local $7)
             (i32.const 8)
            )
           )
           (get_local $8)
          )
          (i64.store
           (get_local $13)
           (get_local $9)
          )
          (br_if $label$0
           (i64.ge_s
            (tee_local $8
             (i64.load
              (get_local $4)
             )
            )
            (tee_local $9
             (i64.load
              (get_local $7)
             )
            )
           )
          )
          (i64.store
           (get_local $7)
           (get_local $8)
          )
          (i64.store
           (get_local $4)
           (get_local $9)
          )
          (return)
         )
         (i64.store
          (get_local $7)
          (get_local $9)
         )
         (i64.store
          (tee_local $4
           (i32.add
            (get_local $7)
            (i32.const 8)
           )
          )
          (get_local $12)
         )
         (br_if $label$0
          (i64.ge_s
           (tee_local $8
            (i64.load
             (get_local $13)
            )
           )
           (get_local $12)
          )
         )
         (i64.store
          (get_local $4)
          (get_local $8)
         )
         (i64.store
          (get_local $13)
          (get_local $12)
         )
         (return)
        )
        (i32.store offset=4
         (get_local $15)
         (get_local $6)
        )
        (i32.store
         (get_local $15)
         (tee_local $13
          (i32.add
           (get_local $2)
           (i32.const -8)
          )
         )
        )
        (br_if $label$0
         (i64.ge_s
          (tee_local $8
           (i64.load
            (get_local $13)
           )
          )
          (tee_local $9
           (i64.load
            (get_local $0)
           )
          )
         )
        )
        (i64.store
         (get_local $0)
         (get_local $8)
        )
        (i64.store
         (get_local $13)
         (get_local $9)
        )
        (return)
       )
       (set_local $7
        (get_local $6)
       )
      )
      (i32.store offset=4
       (get_local $15)
       (get_local $7)
      )
      (br $label$0)
     )
     (i32.store offset=4
      (get_local $15)
      (get_local $6)
     )
    )
    (block $label$34
     (br_if $label$34
      (i32.ge_u
       (tee_local $13
        (i32.add
         (get_local $0)
         (i32.const 8)
        )
       )
       (get_local $4)
      )
     )
     (set_local $0
      (i32.load offset=12
       (get_local $15)
      )
     )
     (loop $label$35
      (block $label$36
       (br_if $label$36
        (i64.ge_s
         (tee_local $12
          (i64.load
           (get_local $13)
          )
         )
         (i64.load
          (get_local $14)
         )
        )
       )
       (set_local $8
        (i64.load
         (get_local $14)
        )
       )
       (loop $label$37
        (br_if $label$37
         (i64.lt_s
          (tee_local $12
           (i64.load
            (tee_local $13
             (i32.add
              (get_local $13)
              (i32.const 8)
             )
            )
           )
          )
          (get_local $8)
         )
        )
       )
      )
      (set_local $8
       (i64.load
        (get_local $14)
       )
      )
      (loop $label$38
       (br_if $label$38
        (i64.ge_s
         (tee_local $9
          (i64.load
           (tee_local $4
            (i32.add
             (get_local $4)
             (i32.const -8)
            )
           )
          )
         )
         (get_local $8)
        )
       )
      )
      (block $label$39
       (br_if $label$39
        (i32.ge_u
         (get_local $13)
         (get_local $4)
        )
       )
       (i64.store
        (get_local $13)
        (get_local $9)
       )
       (i64.store
        (get_local $4)
        (get_local $12)
       )
       (set_local $14
        (select
         (get_local $4)
         (get_local $14)
         (tee_local $10
          (i32.eq
           (get_local $14)
           (get_local $13)
          )
         )
        )
       )
       (set_local $0
        (select
         (get_local $4)
         (get_local $0)
         (get_local $10)
        )
       )
       (set_local $13
        (i32.add
         (get_local $13)
         (i32.const 8)
        )
       )
       (set_local $11
        (i32.add
         (get_local $11)
         (i32.const 1)
        )
       )
       (br $label$35)
      )
     )
     (i32.store offset=8
      (get_local $15)
      (get_local $4)
     )
     (i32.store offset=12
      (get_local $15)
      (get_local $0)
     )
    )
    (block $label$40
     (br_if $label$40
      (i32.eq
       (get_local $13)
       (get_local $14)
      )
     )
     (br_if $label$40
      (i64.ge_s
       (tee_local $8
        (i64.load
         (get_local $14)
        )
       )
       (tee_local $9
        (i64.load
         (get_local $13)
        )
       )
      )
     )
     (i64.store
      (get_local $13)
      (get_local $8)
     )
     (i64.store
      (get_local $14)
      (get_local $9)
     )
     (set_local $11
      (i32.add
       (get_local $11)
       (i32.const 1)
      )
     )
    )
    (br_if $label$0
     (i32.eq
      (get_local $13)
      (get_local $1)
     )
    )
    (block $label$41
     (br_if $label$41
      (get_local $11)
     )
     (block $label$42
      (br_if $label$42
       (i32.gt_u
        (get_local $13)
        (get_local $1)
       )
      )
      (i32.store offset=12
       (get_local $15)
       (get_local $13)
      )
      (set_local $7
       (i32.add
        (get_local $15)
        (i32.const 8)
       )
      )
      (set_local $4
       (get_local $13)
      )
      (loop $label$43
       (i32.store
        (get_local $7)
        (get_local $4)
       )
       (i32.store offset=8
        (get_local $15)
        (tee_local $4
         (i32.add
          (i32.load offset=8
           (get_local $15)
          )
          (i32.const 8)
         )
        )
       )
       (br_if $label$0
        (i32.eq
         (get_local $4)
         (get_local $2)
        )
       )
       (set_local $7
        (i32.add
         (get_local $15)
         (i32.const 12)
        )
       )
       (br_if $label$43
        (i64.ge_s
         (i64.load
          (get_local $4)
         )
         (i64.load
          (i32.load offset=12
           (get_local $15)
          )
         )
        )
       )
       (br $label$41)
      )
     )
     (i32.store offset=12
      (get_local $15)
      (get_local $7)
     )
     (set_local $4
      (i32.add
       (get_local $15)
       (i32.const 8)
      )
     )
     (loop $label$44
      (i32.store
       (get_local $4)
       (get_local $7)
      )
      (i32.store offset=8
       (get_local $15)
       (tee_local $7
        (i32.add
         (i32.load offset=8
          (get_local $15)
         )
         (i32.const 8)
        )
       )
      )
      (br_if $label$0
       (i32.eq
        (get_local $7)
        (get_local $13)
       )
      )
      (set_local $4
       (i32.add
        (get_local $15)
        (i32.const 12)
       )
      )
      (br_if $label$44
       (i64.ge_s
        (i64.load
         (get_local $7)
        )
        (i64.load
         (i32.load offset=12
          (get_local $15)
         )
        )
       )
      )
     )
    )
    (i32.store
     (select
      (get_local $15)
      (i32.add
       (get_local $15)
       (i32.const 4)
      )
      (tee_local $4
       (i32.gt_u
        (get_local $13)
        (get_local $1)
       )
      )
     )
     (select
      (get_local $13)
      (i32.add
       (get_local $13)
       (i32.const 8)
      )
      (get_local $4)
     )
    )
    (br_if $label$0
     (i32.eq
      (tee_local $2
       (i32.load
        (get_local $15)
       )
      )
      (get_local $1)
     )
    )
    (set_local $0
     (i32.load offset=4
      (get_local $15)
     )
    )
    (br $label$1)
   )
  )
 )
 (func $_ZN5eosio11multi_indexILy12296682192053436416E3payJEE6modifyIZN12daccustodian13distributepayEvEUlRS1_E_EEvRKS1_yOT_ (param $0 i32) (param $1 i32) (param $2 i64) (param $3 i32)
  (local $4 i64)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (local $8 i64)
  (local $9 i32)
  (local $10 i32)
  (set_local $10
   (tee_local $9
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 16)
    )
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (get_local $9)
  )
  (call $eosio_assert
   (i32.eq
    (i32.load offset=36
     (get_local $1)
    )
    (get_local $0)
   )
   (i32.const 608)
  )
  (call $eosio_assert
   (i64.eq
    (i64.load
     (get_local $0)
    )
    (call $current_receiver)
   )
   (i32.const 656)
  )
  (set_local $4
   (i64.load
    (get_local $1)
   )
  )
  (call $eosio_assert
   (i64.eq
    (i64.load offset=8
     (tee_local $3
      (i32.load
       (get_local $3)
      )
     )
    )
    (i64.load
     (i32.add
      (get_local $1)
      (i32.const 16)
     )
    )
   )
   (i32.const 1120)
  )
  (i64.store offset=8
   (get_local $1)
   (tee_local $8
    (i64.add
     (i64.load offset=8
      (get_local $1)
     )
     (i64.load
      (get_local $3)
     )
    )
   )
  )
  (call $eosio_assert
   (i64.gt_s
    (get_local $8)
    (i64.const -4611686018427387904)
   )
   (i32.const 1168)
  )
  (call $eosio_assert
   (i64.lt_s
    (i64.load offset=8
     (get_local $1)
    )
    (i64.const 4611686018427387904)
   )
   (i32.const 1200)
  )
  (call $eosio_assert
   (i64.eq
    (get_local $4)
    (i64.load
     (get_local $1)
    )
   )
   (i32.const 720)
  )
  (set_local $3
   (i32.add
    (tee_local $6
     (select
      (i32.load
       (i32.add
        (get_local $1)
        (i32.const 28)
       )
      )
      (i32.shr_u
       (tee_local $3
        (i32.load8_u offset=24
         (get_local $1)
        )
       )
       (i32.const 1)
      )
      (i32.and
       (get_local $3)
       (i32.const 1)
      )
     )
    )
    (i32.const 24)
   )
  )
  (set_local $8
   (i64.extend_u/i32
    (get_local $6)
   )
  )
  (set_local $5
   (i32.add
    (get_local $1)
    (i32.const 24)
   )
  )
  (loop $label$0
   (set_local $3
    (i32.add
     (get_local $3)
     (i32.const 1)
    )
   )
   (br_if $label$0
    (i64.ne
     (tee_local $8
      (i64.shr_u
       (get_local $8)
       (i64.const 7)
      )
     )
     (i64.const 0)
    )
   )
  )
  (block $label$1
   (block $label$2
    (br_if $label$2
     (i32.lt_u
      (get_local $3)
      (i32.const 513)
     )
    )
    (set_local $9
     (call $malloc
      (get_local $3)
     )
    )
    (br $label$1)
   )
   (i32.store offset=4
    (i32.const 0)
    (tee_local $9
     (i32.sub
      (get_local $9)
      (i32.and
       (i32.add
        (get_local $3)
        (i32.const 15)
       )
       (i32.const -16)
      )
     )
    )
   )
  )
  (i32.store
   (get_local $10)
   (get_local $9)
  )
  (i32.store offset=8
   (get_local $10)
   (tee_local $6
    (i32.add
     (get_local $9)
     (get_local $3)
    )
   )
  )
  (call $eosio_assert
   (i32.gt_s
    (get_local $3)
    (i32.const 7)
   )
   (i32.const 432)
  )
  (drop
   (call $memcpy
    (get_local $9)
    (get_local $1)
    (i32.const 8)
   )
  )
  (call $eosio_assert
   (i32.gt_s
    (i32.sub
     (get_local $6)
     (tee_local $7
      (i32.add
       (get_local $9)
       (i32.const 8)
      )
     )
    )
    (i32.const 7)
   )
   (i32.const 432)
  )
  (drop
   (call $memcpy
    (get_local $7)
    (i32.add
     (get_local $1)
     (i32.const 8)
    )
    (i32.const 8)
   )
  )
  (call $eosio_assert
   (i32.gt_s
    (i32.sub
     (get_local $6)
     (tee_local $7
      (i32.add
       (get_local $9)
       (i32.const 16)
      )
     )
    )
    (i32.const 7)
   )
   (i32.const 432)
  )
  (drop
   (call $memcpy
    (get_local $7)
    (i32.add
     (get_local $1)
     (i32.const 16)
    )
    (i32.const 8)
   )
  )
  (i32.store offset=4
   (get_local $10)
   (i32.add
    (get_local $9)
    (i32.const 24)
   )
  )
  (drop
   (call $_ZN5eosiolsINS_10datastreamIPcEEEERT_S5_RKNSt3__112basic_stringIcNS6_11char_traitsIcEENS6_9allocatorIcEEEE
    (get_local $10)
    (get_local $5)
   )
  )
  (call $db_update_i64
   (i32.load offset=40
    (get_local $1)
   )
   (get_local $2)
   (get_local $9)
   (get_local $3)
  )
  (block $label$3
   (br_if $label$3
    (i32.lt_u
     (get_local $3)
     (i32.const 513)
    )
   )
   (call $free
    (get_local $9)
   )
  )
  (block $label$4
   (br_if $label$4
    (i64.lt_u
     (get_local $4)
     (i64.load offset=16
      (get_local $0)
     )
    )
   )
   (i64.store
    (i32.add
     (get_local $0)
     (i32.const 16)
    )
    (select
     (i64.const -2)
     (i64.add
      (get_local $4)
      (i64.const 1)
     )
     (i64.gt_u
      (get_local $4)
      (i64.const -3)
     )
    )
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $10)
    (i32.const 16)
   )
  )
 )
 (func $_ZN5eosio11multi_indexILy12296682192053436416E3payJEE7emplaceIZN12daccustodian13distributepayEvEUlRS1_E0_EENS2_14const_iteratorEyOT_ (param $0 i32) (param $1 i32) (param $2 i64) (param $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (i32.store offset=4
   (i32.const 0)
   (tee_local $7
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 48)
    )
   )
  )
  (i64.store offset=40
   (get_local $7)
   (get_local $2)
  )
  (call $eosio_assert
   (i64.eq
    (i64.load
     (get_local $1)
    )
    (call $current_receiver)
   )
   (i32.const 1008)
  )
  (i32.store offset=20
   (get_local $7)
   (get_local $3)
  )
  (i32.store offset=16
   (get_local $7)
   (get_local $1)
  )
  (i32.store offset=24
   (get_local $7)
   (i32.add
    (get_local $7)
    (i32.const 40)
   )
  )
  (i64.store offset=8
   (tee_local $4
    (call $_Znwj
     (i32.const 48)
    )
   )
   (i64.const 0)
  )
  (i64.store
   (get_local $4)
   (i64.const 0)
  )
  (i64.store offset=16
   (get_local $4)
   (i64.const 1398362884)
  )
  (call $eosio_assert
   (i32.const 1)
   (i32.const 480)
  )
  (set_local $2
   (i64.const 5462355)
  )
  (set_local $3
   (i32.const 0)
  )
  (block $label$0
   (block $label$1
    (loop $label$2
     (br_if $label$1
      (i32.gt_u
       (i32.add
        (i32.shl
         (i32.wrap/i64
          (get_local $2)
         )
         (i32.const 24)
        )
        (i32.const -1073741825)
       )
       (i32.const 452984830)
      )
     )
     (block $label$3
      (br_if $label$3
       (i64.ne
        (i64.and
         (tee_local $2
          (i64.shr_u
           (get_local $2)
           (i64.const 8)
          )
         )
         (i64.const 255)
        )
        (i64.const 0)
       )
      )
      (loop $label$4
       (br_if $label$1
        (i64.ne
         (i64.and
          (tee_local $2
           (i64.shr_u
            (get_local $2)
            (i64.const 8)
           )
          )
          (i64.const 255)
         )
         (i64.const 0)
        )
       )
       (br_if $label$4
        (i32.lt_s
         (tee_local $3
          (i32.add
           (get_local $3)
           (i32.const 1)
          )
         )
         (i32.const 7)
        )
       )
      )
     )
     (set_local $6
      (i32.const 1)
     )
     (br_if $label$2
      (i32.lt_s
       (tee_local $3
        (i32.add
         (get_local $3)
         (i32.const 1)
        )
       )
       (i32.const 7)
      )
     )
     (br $label$0)
    )
   )
   (set_local $6
    (i32.const 0)
   )
  )
  (call $eosio_assert
   (get_local $6)
   (i32.const 544)
  )
  (i32.store offset=32
   (get_local $4)
   (i32.const 0)
  )
  (i64.store offset=24 align=4
   (get_local $4)
   (i64.const 0)
  )
  (i32.store offset=36
   (get_local $4)
   (get_local $1)
  )
  (call $_ZZN5eosio11multi_indexILy12296682192053436416E3payJEE7emplaceIZN12daccustodian13distributepayEvEUlRS1_E0_EENS2_14const_iteratorEyOT_ENKUlRS8_E_clINS2_4itemEEEDaSA_
   (i32.add
    (get_local $7)
    (i32.const 16)
   )
   (get_local $4)
  )
  (i32.store offset=32
   (get_local $7)
   (get_local $4)
  )
  (i64.store offset=16
   (get_local $7)
   (tee_local $2
    (i64.load
     (get_local $4)
    )
   )
  )
  (i32.store offset=12
   (get_local $7)
   (tee_local $6
    (i32.load offset=40
     (get_local $4)
    )
   )
  )
  (block $label$5
   (block $label$6
    (br_if $label$6
     (i32.ge_u
      (tee_local $3
       (i32.load
        (tee_local $5
         (i32.add
          (get_local $1)
          (i32.const 28)
         )
        )
       )
      )
      (i32.load
       (i32.add
        (get_local $1)
        (i32.const 32)
       )
      )
     )
    )
    (i64.store offset=8
     (get_local $3)
     (get_local $2)
    )
    (i32.store offset=16
     (get_local $3)
     (get_local $6)
    )
    (i32.store offset=32
     (get_local $7)
     (i32.const 0)
    )
    (i32.store
     (get_local $3)
     (get_local $4)
    )
    (i32.store
     (get_local $5)
     (i32.add
      (get_local $3)
      (i32.const 24)
     )
    )
    (br $label$5)
   )
   (call $_ZNSt3__16vectorIN5eosio11multi_indexILy12296682192053436416E3payJEE8item_ptrENS_9allocatorIS5_EEE24__emplace_back_slow_pathIJNS_10unique_ptrINS4_4itemENS_14default_deleteISB_EEEERyRlEEEvDpOT_
    (i32.add
     (get_local $1)
     (i32.const 24)
    )
    (i32.add
     (get_local $7)
     (i32.const 32)
    )
    (i32.add
     (get_local $7)
     (i32.const 16)
    )
    (i32.add
     (get_local $7)
     (i32.const 12)
    )
   )
  )
  (i32.store offset=4
   (get_local $0)
   (get_local $4)
  )
  (i32.store
   (get_local $0)
   (get_local $1)
  )
  (set_local $3
   (i32.load offset=32
    (get_local $7)
   )
  )
  (i32.store offset=32
   (get_local $7)
   (i32.const 0)
  )
  (block $label$7
   (br_if $label$7
    (i32.eqz
     (get_local $3)
    )
   )
   (block $label$8
    (br_if $label$8
     (i32.eqz
      (i32.and
       (i32.load8_u offset=24
        (get_local $3)
       )
       (i32.const 1)
      )
     )
    )
    (call $_ZdlPv
     (i32.load
      (i32.add
       (get_local $3)
       (i32.const 32)
      )
     )
    )
   )
   (call $_ZdlPv
    (get_local $3)
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $7)
    (i32.const 48)
   )
  )
 )
 (func $_ZZN5eosio11multi_indexILy12296682192053436416E3payJEE7emplaceIZN12daccustodian13distributepayEvEUlRS1_E0_EENS2_14const_iteratorEyOT_ENKUlRS8_E_clINS2_4itemEEEDaSA_ (param $0 i32) (param $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (local $8 i64)
  (local $9 i32)
  (local $10 i32)
  (i32.store offset=4
   (i32.const 0)
   (tee_local $9
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 16)
    )
   )
  )
  (set_local $2
   (i32.load
    (get_local $0)
   )
  )
  (i64.store
   (tee_local $10
    (get_local $9)
   )
   (i64.load offset=12 align=4
    (i32.load
     (tee_local $7
      (i32.load offset=4
       (get_local $0)
      )
     )
    )
   )
  )
  (i64.store
   (get_local $1)
   (i64.load
    (i32.load offset=4
     (call $_ZN5eosio11multi_indexILy4730634643120193536E9candidateJNS_10indexed_byILy8518361509820596224EN5boost11multi_index13const_mem_funIS1_oXadL_ZNKS1_22get_by_is_cust_and_payEvEEEEEENS2_ILy4591222642450628608ENS5_IS1_yXadL_ZNKS1_15by_number_votesEvEEEEEEEE5indexILy8518361509820596224ES6_Ly0ELb0EE14const_iteratormmEv
      (get_local $10)
     )
    )
   )
  )
  (i64.store offset=8
   (get_local $1)
   (i64.load
    (tee_local $7
     (i32.load offset=4
      (get_local $7)
     )
    )
   )
  )
  (i64.store
   (i32.add
    (get_local $1)
    (i32.const 16)
   )
   (i64.load
    (i32.add
     (get_local $7)
     (i32.const 8)
    )
   )
  )
  (drop
   (call $_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE6assignEPKc
    (tee_local $4
     (i32.add
      (get_local $1)
      (i32.const 24)
     )
    )
    (i32.const 1072)
   )
  )
  (set_local $7
   (i32.add
    (tee_local $5
     (select
      (i32.load
       (i32.add
        (get_local $1)
        (i32.const 28)
       )
      )
      (i32.shr_u
       (tee_local $7
        (i32.load8_u offset=24
         (get_local $1)
        )
       )
       (i32.const 1)
      )
      (i32.and
       (get_local $7)
       (i32.const 1)
      )
     )
    )
    (i32.const 24)
   )
  )
  (set_local $8
   (i64.extend_u/i32
    (get_local $5)
   )
  )
  (set_local $3
   (i32.add
    (get_local $1)
    (i32.const 8)
   )
  )
  (loop $label$0
   (set_local $7
    (i32.add
     (get_local $7)
     (i32.const 1)
    )
   )
   (br_if $label$0
    (i64.ne
     (tee_local $8
      (i64.shr_u
       (get_local $8)
       (i64.const 7)
      )
     )
     (i64.const 0)
    )
   )
  )
  (block $label$1
   (block $label$2
    (br_if $label$2
     (i32.lt_u
      (get_local $7)
      (i32.const 513)
     )
    )
    (set_local $9
     (call $malloc
      (get_local $7)
     )
    )
    (br $label$1)
   )
   (i32.store offset=4
    (i32.const 0)
    (tee_local $9
     (i32.sub
      (get_local $9)
      (i32.and
       (i32.add
        (get_local $7)
        (i32.const 15)
       )
       (i32.const -16)
      )
     )
    )
   )
  )
  (i32.store
   (get_local $10)
   (get_local $9)
  )
  (i32.store offset=8
   (get_local $10)
   (tee_local $5
    (i32.add
     (get_local $9)
     (get_local $7)
    )
   )
  )
  (call $eosio_assert
   (i32.gt_s
    (get_local $7)
    (i32.const 7)
   )
   (i32.const 432)
  )
  (drop
   (call $memcpy
    (get_local $9)
    (get_local $1)
    (i32.const 8)
   )
  )
  (call $eosio_assert
   (i32.gt_s
    (i32.sub
     (get_local $5)
     (tee_local $6
      (i32.add
       (get_local $9)
       (i32.const 8)
      )
     )
    )
    (i32.const 7)
   )
   (i32.const 432)
  )
  (drop
   (call $memcpy
    (get_local $6)
    (get_local $3)
    (i32.const 8)
   )
  )
  (call $eosio_assert
   (i32.gt_s
    (i32.sub
     (get_local $5)
     (tee_local $3
      (i32.add
       (get_local $9)
       (i32.const 16)
      )
     )
    )
    (i32.const 7)
   )
   (i32.const 432)
  )
  (drop
   (call $memcpy
    (get_local $3)
    (i32.add
     (get_local $1)
     (i32.const 16)
    )
    (i32.const 8)
   )
  )
  (i32.store offset=4
   (get_local $10)
   (i32.add
    (get_local $9)
    (i32.const 24)
   )
  )
  (drop
   (call $_ZN5eosiolsINS_10datastreamIPcEEEERT_S5_RKNSt3__112basic_stringIcNS6_11char_traitsIcEENS6_9allocatorIcEEEE
    (get_local $10)
    (get_local $4)
   )
  )
  (i32.store offset=40
   (get_local $1)
   (call $db_store_i64
    (i64.load offset=8
     (get_local $2)
    )
    (i64.const -6150061881656115200)
    (i64.load
     (i32.load offset=8
      (get_local $0)
     )
    )
    (tee_local $8
     (i64.load
      (get_local $1)
     )
    )
    (get_local $9)
    (get_local $7)
   )
  )
  (block $label$3
   (br_if $label$3
    (i32.lt_u
     (get_local $7)
     (i32.const 513)
    )
   )
   (call $free
    (get_local $9)
   )
  )
  (block $label$4
   (br_if $label$4
    (i64.lt_u
     (get_local $8)
     (i64.load offset=16
      (get_local $2)
     )
    )
   )
   (i64.store
    (i32.add
     (get_local $2)
     (i32.const 16)
    )
    (select
     (i64.const -2)
     (i64.add
      (get_local $8)
      (i64.const 1)
     )
     (i64.gt_u
      (get_local $8)
      (i64.const -3)
     )
    )
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $10)
    (i32.const 16)
   )
  )
 )
 (func $_ZNK5eosio11multi_indexILy10566699676600369152E6memberJEE3getEyPKc (param $0 i32) (param $1 i64) (param $2 i32) (result i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (block $label$0
   (br_if $label$0
    (i32.eq
     (tee_local $7
      (i32.load
       (i32.add
        (get_local $0)
        (i32.const 28)
       )
      )
     )
     (tee_local $3
      (i32.load offset=24
       (get_local $0)
      )
     )
    )
   )
   (set_local $6
    (i32.add
     (get_local $7)
     (i32.const -24)
    )
   )
   (set_local $4
    (i32.sub
     (i32.const 0)
     (get_local $3)
    )
   )
   (loop $label$1
    (br_if $label$0
     (i64.eq
      (i64.load
       (i32.load
        (get_local $6)
       )
      )
      (get_local $1)
     )
    )
    (set_local $7
     (get_local $6)
    )
    (set_local $6
     (tee_local $5
      (i32.add
       (get_local $6)
       (i32.const -24)
      )
     )
    )
    (br_if $label$1
     (i32.ne
      (i32.add
       (get_local $5)
       (get_local $4)
      )
      (i32.const -24)
     )
    )
   )
  )
  (block $label$2
   (block $label$3
    (br_if $label$3
     (i32.eq
      (get_local $7)
      (get_local $3)
     )
    )
    (call $eosio_assert
     (i32.eq
      (i32.load offset=16
       (tee_local $6
        (i32.load
         (i32.add
          (get_local $7)
          (i32.const -24)
         )
        )
       )
      )
      (get_local $0)
     )
     (i32.const 896)
    )
    (br $label$2)
   )
   (set_local $6
    (i32.const 0)
   )
   (br_if $label$2
    (i32.lt_s
     (tee_local $5
      (call $db_find_i64
       (i64.load
        (get_local $0)
       )
       (i64.load offset=8
        (get_local $0)
       )
       (i64.const -7880044397109182464)
       (get_local $1)
      )
     )
     (i32.const 0)
    )
   )
   (call $eosio_assert
    (i32.eq
     (i32.load offset=16
      (tee_local $6
       (call $_ZNK5eosio11multi_indexILy10566699676600369152E6memberJEE31load_object_by_primary_iteratorEl
        (get_local $0)
        (get_local $5)
       )
      )
     )
     (get_local $0)
    )
    (i32.const 896)
   )
  )
  (call $eosio_assert
   (i32.ne
    (get_local $6)
    (i32.const 0)
   )
   (get_local $2)
  )
  (get_local $6)
 )
 (func $_ZN5eosio11multi_indexILy10566699677317378048E9termsinfoJEE14const_iteratormmEv (param $0 i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  (i32.store offset=4
   (i32.const 0)
   (tee_local $2
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 16)
    )
   )
  )
  (block $label$0
   (block $label$1
    (br_if $label$1
     (i32.eqz
      (tee_local $1
       (i32.load offset=4
        (get_local $0)
       )
      )
     )
    )
    (call $eosio_assert
     (i32.xor
      (i32.shr_u
       (tee_local $1
        (call $db_previous_i64
         (i32.load offset=36
          (get_local $1)
         )
         (i32.add
          (get_local $2)
          (i32.const 8)
         )
        )
       )
       (i32.const 31)
      )
      (i32.const 1)
     )
     (i32.const 1584)
    )
    (br $label$0)
   )
   (call $eosio_assert
    (i32.ne
     (tee_local $1
      (call $db_end_i64
       (i64.load
        (tee_local $1
         (i32.load
          (get_local $0)
         )
        )
       )
       (i64.load offset=8
        (get_local $1)
       )
       (i64.const -7880044396392173568)
      )
     )
     (i32.const -1)
    )
    (i32.const 1520)
   )
   (call $eosio_assert
    (i32.xor
     (i32.shr_u
      (tee_local $1
       (call $db_previous_i64
        (get_local $1)
        (i32.add
         (get_local $2)
         (i32.const 8)
        )
       )
      )
      (i32.const 31)
     )
     (i32.const 1)
    )
    (i32.const 1520)
   )
  )
  (i32.store
   (i32.add
    (get_local $0)
    (i32.const 4)
   )
   (call $_ZNK5eosio11multi_indexILy10566699677317378048E9termsinfoJEE31load_object_by_primary_iteratorEl
    (i32.load
     (get_local $0)
    )
    (get_local $1)
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $2)
    (i32.const 16)
   )
  )
  (get_local $0)
 )
 (func $_ZNK5eosio4name9to_stringEv (param $0 i32) (param $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (local $8 i64)
  (local $9 i32)
  (i32.store offset=4
   (i32.const 0)
   (tee_local $9
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 16)
    )
   )
  )
  (i32.store offset=8
   (get_local $0)
   (tee_local $6
    (call $_Znwj
     (i32.const 16)
    )
   )
  )
  (i64.store align=4
   (get_local $0)
   (i64.const 55834574865)
  )
  (drop
   (call $memset
    (get_local $6)
    (i32.const 46)
    (i32.const 13)
   )
  )
  (i32.store8 offset=13
   (get_local $6)
   (i32.const 0)
  )
  (set_local $2
   (i32.add
    (get_local $0)
    (i32.const 1)
   )
  )
  (set_local $8
   (i64.load
    (get_local $1)
   )
  )
  (set_local $7
   (i32.const 17)
  )
  (set_local $5
   (i32.add
    (get_local $0)
    (i32.const 8)
   )
  )
  (set_local $6
   (i32.const 12)
  )
  (loop $label$0
   (set_local $3
    (i32.load8_u
     (i32.add
      (i32.load offset=1456
       (i32.const 0)
      )
      (i32.wrap/i64
       (i64.and
        (select
         (i64.const 15)
         (i64.const 31)
         (tee_local $4
          (i32.eq
           (get_local $6)
           (i32.const 12)
          )
         )
        )
        (get_local $8)
       )
      )
     )
    )
   )
   (set_local $1
    (get_local $2)
   )
   (block $label$1
    (br_if $label$1
     (i32.eqz
      (i32.and
       (get_local $7)
       (i32.const 1)
      )
     )
    )
    (set_local $1
     (i32.load
      (get_local $5)
     )
    )
   )
   (block $label$2
    (i32.store8
     (i32.add
      (get_local $1)
      (get_local $6)
     )
     (get_local $3)
    )
    (br_if $label$2
     (i32.eqz
      (get_local $6)
     )
    )
    (set_local $6
     (i32.add
      (get_local $6)
      (i32.const -1)
     )
    )
    (set_local $8
     (i64.shr_u
      (get_local $8)
      (select
       (i64.const 4)
       (i64.const 5)
       (get_local $4)
      )
     )
    )
    (set_local $7
     (i32.load8_u
      (get_local $0)
     )
    )
    (br $label$0)
   )
  )
  (set_local $6
   (select
    (i32.load
     (i32.add
      (get_local $0)
      (i32.const 4)
     )
    )
    (i32.shr_u
     (tee_local $6
      (i32.load8_u
       (get_local $0)
      )
     )
     (i32.const 1)
    )
    (tee_local $1
     (i32.and
      (get_local $6)
      (i32.const 1)
     )
    )
   )
  )
  (set_local $7
   (select
    (i32.load
     (i32.add
      (get_local $0)
      (i32.const 8)
     )
    )
    (get_local $2)
    (get_local $1)
   )
  )
  (block $label$3
   (loop $label$4
    (br_if $label$3
     (i32.eqz
      (get_local $6)
     )
    )
    (set_local $1
     (i32.add
      (get_local $7)
      (get_local $6)
     )
    )
    (set_local $6
     (tee_local $3
      (i32.add
       (get_local $6)
       (i32.const -1)
      )
     )
    )
    (br_if $label$4
     (i32.eq
      (i32.load8_u
       (i32.add
        (get_local $1)
        (i32.const -1)
       )
      )
      (i32.const 46)
     )
    )
   )
   (br_if $label$3
    (i32.eq
     (get_local $3)
     (i32.const -1)
    )
   )
   (drop
    (call $_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC2ERKS5_jjRKS4_
     (get_local $9)
     (get_local $0)
     (i32.const 0)
     (i32.add
      (get_local $3)
      (i32.const 1)
     )
     (get_local $0)
    )
   )
   (block $label$5
    (block $label$6
     (br_if $label$6
      (i32.and
       (i32.load8_u
        (get_local $0)
       )
       (i32.const 1)
      )
     )
     (i32.store16
      (get_local $0)
      (i32.const 0)
     )
     (br $label$5)
    )
    (i32.store8
     (i32.load
      (i32.add
       (get_local $0)
       (i32.const 8)
      )
     )
     (i32.const 0)
    )
    (i32.store
     (i32.add
      (get_local $0)
      (i32.const 4)
     )
     (i32.const 0)
    )
   )
   (call $_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE7reserveEj
    (get_local $0)
    (i32.const 0)
   )
   (i32.store
    (i32.add
     (get_local $0)
     (i32.const 8)
    )
    (i32.load
     (i32.add
      (get_local $9)
      (i32.const 8)
     )
    )
   )
   (i64.store align=4
    (get_local $0)
    (i64.load
     (get_local $9)
    )
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $9)
    (i32.const 16)
   )
  )
 )
 (func $_ZN5eosio11multi_indexILy15938991147217584128E4voteJNS_10indexed_byILy4587895300147904512EN5boost11multi_index13const_mem_funIS1_yXadL_ZNKS1_8by_proxyEvEEEEEEEE6modifyIZN12daccustodian9voteproxyENS_4nameESB_EUlRS1_E_EEvRKS1_yOT_ (param $0 i32) (param $1 i32) (param $2 i64) (param $3 i32)
  (local $4 i64)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (local $8 i32)
  (local $9 i64)
  (local $10 i32)
  (local $11 i32)
  (i32.store offset=4
   (i32.const 0)
   (tee_local $10
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 48)
    )
   )
  )
  (call $eosio_assert
   (i32.eq
    (i32.load offset=36
     (get_local $1)
    )
    (get_local $0)
   )
   (i32.const 608)
  )
  (call $eosio_assert
   (i64.eq
    (i64.load
     (get_local $0)
    )
    (call $current_receiver)
   )
   (i32.const 656)
  )
  (i32.store
   (tee_local $8
    (i32.add
     (get_local $1)
     (i32.const 28)
    )
   )
   (i32.load offset=24
    (get_local $1)
   )
  )
  (set_local $9
   (i64.load offset=8
    (get_local $1)
   )
  )
  (i64.store offset=8
   (get_local $1)
   (i64.load
    (i32.load
     (get_local $3)
    )
   )
  )
  (i64.store offset=24
   (tee_local $11
    (get_local $10)
   )
   (get_local $9)
  )
  (set_local $4
   (i64.load
    (get_local $1)
   )
  )
  (call $eosio_assert
   (i32.const 1)
   (i32.const 720)
  )
  (set_local $3
   (i32.const 24)
  )
  (set_local $5
   (i32.add
    (get_local $1)
    (i32.const 24)
   )
  )
  (set_local $9
   (i64.extend_u/i32
    (i32.shr_s
     (tee_local $7
      (i32.sub
       (tee_local $8
        (i32.load
         (get_local $8)
        )
       )
       (tee_local $6
        (i32.load offset=24
         (get_local $1)
        )
       )
      )
     )
     (i32.const 3)
    )
   )
  )
  (loop $label$0
   (set_local $3
    (i32.add
     (get_local $3)
     (i32.const 1)
    )
   )
   (br_if $label$0
    (i64.ne
     (tee_local $9
      (i64.shr_u
       (get_local $9)
       (i64.const 7)
      )
     )
     (i64.const 0)
    )
   )
  )
  (block $label$1
   (br_if $label$1
    (i32.eq
     (get_local $6)
     (get_local $8)
    )
   )
   (set_local $3
    (i32.add
     (i32.and
      (get_local $7)
      (i32.const -8)
     )
     (get_local $3)
    )
   )
  )
  (block $label$2
   (block $label$3
    (br_if $label$3
     (i32.lt_u
      (get_local $3)
      (i32.const 513)
     )
    )
    (set_local $10
     (call $malloc
      (get_local $3)
     )
    )
    (br $label$2)
   )
   (i32.store offset=4
    (i32.const 0)
    (tee_local $10
     (i32.sub
      (get_local $10)
      (i32.and
       (i32.add
        (get_local $3)
        (i32.const 15)
       )
       (i32.const -16)
      )
     )
    )
   )
  )
  (i32.store offset=8
   (get_local $11)
   (get_local $10)
  )
  (i32.store offset=16
   (get_local $11)
   (tee_local $8
    (i32.add
     (get_local $10)
     (get_local $3)
    )
   )
  )
  (call $eosio_assert
   (i32.gt_s
    (get_local $3)
    (i32.const 7)
   )
   (i32.const 432)
  )
  (drop
   (call $memcpy
    (get_local $10)
    (get_local $1)
    (i32.const 8)
   )
  )
  (call $eosio_assert
   (i32.gt_s
    (i32.sub
     (get_local $8)
     (tee_local $6
      (i32.add
       (get_local $10)
       (i32.const 8)
      )
     )
    )
    (i32.const 7)
   )
   (i32.const 432)
  )
  (drop
   (call $memcpy
    (get_local $6)
    (i32.add
     (get_local $1)
     (i32.const 8)
    )
    (i32.const 8)
   )
  )
  (call $eosio_assert
   (i32.gt_s
    (i32.sub
     (get_local $8)
     (tee_local $6
      (i32.add
       (get_local $10)
       (i32.const 16)
      )
     )
    )
    (i32.const 7)
   )
   (i32.const 432)
  )
  (drop
   (call $memcpy
    (get_local $6)
    (i32.add
     (get_local $1)
     (i32.const 16)
    )
    (i32.const 8)
   )
  )
  (i32.store offset=12
   (get_local $11)
   (i32.add
    (get_local $10)
    (i32.const 24)
   )
  )
  (drop
   (call $_ZN5eosiolsINS_10datastreamIPcEENS_4nameEEERT_S6_RKNSt3__16vectorIT0_NS7_9allocatorIS9_EEEE
    (i32.add
     (get_local $11)
     (i32.const 8)
    )
    (get_local $5)
   )
  )
  (call $db_update_i64
   (i32.load offset=40
    (get_local $1)
   )
   (get_local $2)
   (get_local $10)
   (get_local $3)
  )
  (block $label$4
   (br_if $label$4
    (i32.lt_u
     (get_local $3)
     (i32.const 513)
    )
   )
   (call $free
    (get_local $10)
   )
  )
  (block $label$5
   (br_if $label$5
    (i64.lt_u
     (get_local $4)
     (i64.load offset=16
      (get_local $0)
     )
    )
   )
   (i64.store
    (i32.add
     (get_local $0)
     (i32.const 16)
    )
    (select
     (i64.const -2)
     (i64.add
      (get_local $4)
      (i64.const 1)
     )
     (i64.gt_u
      (get_local $4)
      (i64.const -3)
     )
    )
   )
  )
  (i64.store offset=40
   (get_local $11)
   (i64.load
    (i32.add
     (get_local $1)
     (i32.const 8)
    )
   )
  )
  (block $label$6
   (br_if $label$6
    (i32.eqz
     (call $memcmp
      (i32.add
       (get_local $11)
       (i32.const 24)
      )
      (i32.add
       (get_local $11)
       (i32.const 40)
      )
      (i32.const 8)
     )
    )
   )
   (block $label$7
    (br_if $label$7
     (i32.gt_s
      (tee_local $3
       (i32.load offset=44
        (get_local $1)
       )
      )
      (i32.const -1)
     )
    )
    (i32.store
     (i32.add
      (get_local $1)
      (i32.const 44)
     )
     (tee_local $3
      (call $db_idx64_find_primary
       (i64.load
        (get_local $0)
       )
       (i64.load offset=8
        (get_local $0)
       )
       (i64.const -2507752926491967488)
       (i32.add
        (get_local $11)
        (i32.const 32)
       )
       (get_local $4)
      )
     )
    )
   )
   (call $db_idx64_update
    (get_local $3)
    (get_local $2)
    (i32.add
     (get_local $11)
     (i32.const 40)
    )
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $11)
    (i32.const 48)
   )
  )
 )
 (func $_ZN5eosio11multi_indexILy15938991147217584128E4voteJNS_10indexed_byILy4587895300147904512EN5boost11multi_index13const_mem_funIS1_yXadL_ZNKS1_8by_proxyEvEEEEEEEE7emplaceIZN12daccustodian9voteproxyENS_4nameESB_EUlRS1_E0_EENS8_14const_iteratorEyOT_ (param $0 i32) (param $1 i32) (param $2 i64) (param $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (i32.store offset=4
   (i32.const 0)
   (tee_local $7
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 48)
    )
   )
  )
  (i64.store offset=40
   (get_local $7)
   (get_local $2)
  )
  (call $eosio_assert
   (i64.eq
    (i64.load
     (get_local $1)
    )
    (call $current_receiver)
   )
   (i32.const 1008)
  )
  (i32.store offset=20
   (get_local $7)
   (get_local $3)
  )
  (i32.store offset=16
   (get_local $7)
   (get_local $1)
  )
  (i32.store offset=24
   (get_local $7)
   (i32.add
    (get_local $7)
    (i32.const 40)
   )
  )
  (i64.store offset=8
   (tee_local $3
    (call $_Znwj
     (i32.const 48)
    )
   )
   (i64.const 0)
  )
  (i64.store
   (get_local $3)
   (i64.const 0)
  )
  (i64.store offset=24 align=4
   (get_local $3)
   (i64.const 0)
  )
  (i32.store offset=32
   (get_local $3)
   (i32.const 0)
  )
  (i32.store offset=36
   (get_local $3)
   (get_local $1)
  )
  (call $_ZZN5eosio11multi_indexILy15938991147217584128E4voteJNS_10indexed_byILy4587895300147904512EN5boost11multi_index13const_mem_funIS1_yXadL_ZNKS1_8by_proxyEvEEEEEEEE7emplaceIZN12daccustodian9voteproxyENS_4nameESB_EUlRS1_E0_EENS8_14const_iteratorEyOT_ENKUlRSF_E_clINS8_4itemEEEDaSH_
   (i32.add
    (get_local $7)
    (i32.const 16)
   )
   (get_local $3)
  )
  (i32.store offset=32
   (get_local $7)
   (get_local $3)
  )
  (i64.store offset=16
   (get_local $7)
   (tee_local $2
    (i64.load
     (get_local $3)
    )
   )
  )
  (i32.store offset=12
   (get_local $7)
   (tee_local $4
    (i32.load offset=40
     (get_local $3)
    )
   )
  )
  (block $label$0
   (block $label$1
    (br_if $label$1
     (i32.ge_u
      (tee_local $5
       (i32.load
        (tee_local $6
         (i32.add
          (get_local $1)
          (i32.const 28)
         )
        )
       )
      )
      (i32.load
       (i32.add
        (get_local $1)
        (i32.const 32)
       )
      )
     )
    )
    (i64.store offset=8
     (get_local $5)
     (get_local $2)
    )
    (i32.store offset=16
     (get_local $5)
     (get_local $4)
    )
    (i32.store offset=32
     (get_local $7)
     (i32.const 0)
    )
    (i32.store
     (get_local $5)
     (get_local $3)
    )
    (i32.store
     (get_local $6)
     (i32.add
      (get_local $5)
      (i32.const 24)
     )
    )
    (br $label$0)
   )
   (call $_ZNSt3__16vectorIN5eosio11multi_indexILy15938991147217584128E4voteJNS1_10indexed_byILy4587895300147904512EN5boost11multi_index13const_mem_funIS3_yXadL_ZNKS3_8by_proxyEvEEEEEEEE8item_ptrENS_9allocatorISB_EEE24__emplace_back_slow_pathIJNS_10unique_ptrINSA_4itemENS_14default_deleteISH_EEEERyRlEEEvDpOT_
    (i32.add
     (get_local $1)
     (i32.const 24)
    )
    (i32.add
     (get_local $7)
     (i32.const 32)
    )
    (i32.add
     (get_local $7)
     (i32.const 16)
    )
    (i32.add
     (get_local $7)
     (i32.const 12)
    )
   )
  )
  (i32.store offset=4
   (get_local $0)
   (get_local $3)
  )
  (i32.store
   (get_local $0)
   (get_local $1)
  )
  (set_local $3
   (i32.load offset=32
    (get_local $7)
   )
  )
  (i32.store offset=32
   (get_local $7)
   (i32.const 0)
  )
  (block $label$2
   (br_if $label$2
    (i32.eqz
     (get_local $3)
    )
   )
   (block $label$3
    (br_if $label$3
     (i32.eqz
      (tee_local $1
       (i32.load offset=24
        (get_local $3)
       )
      )
     )
    )
    (i32.store
     (i32.add
      (get_local $3)
      (i32.const 28)
     )
     (get_local $1)
    )
    (call $_ZdlPv
     (get_local $1)
    )
   )
   (call $_ZdlPv
    (get_local $3)
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $7)
    (i32.const 48)
   )
  )
 )
 (func $_ZZN5eosio11multi_indexILy15938991147217584128E4voteJNS_10indexed_byILy4587895300147904512EN5boost11multi_index13const_mem_funIS1_yXadL_ZNKS1_8by_proxyEvEEEEEEEE7emplaceIZN12daccustodian9voteproxyENS_4nameESB_EUlRS1_E0_EENS8_14const_iteratorEyOT_ENKUlRSF_E_clINS8_4itemEEEDaSH_ (param $0 i32) (param $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i64)
  (local $8 i64)
  (local $9 i32)
  (local $10 i64)
  (local $11 i32)
  (local $12 i32)
  (set_local $12
   (tee_local $11
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 32)
    )
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (get_local $11)
  )
  (set_local $2
   (i32.load
    (get_local $0)
   )
  )
  (i64.store
   (get_local $1)
   (i64.load
    (i32.load
     (tee_local $9
      (i32.load offset=4
       (get_local $0)
      )
     )
    )
   )
  )
  (i64.store offset=8
   (get_local $1)
   (i64.load
    (i32.load offset=4
     (get_local $9)
    )
   )
  )
  (set_local $9
   (i32.const 24)
  )
  (set_local $3
   (i32.add
    (get_local $1)
    (i32.const 24)
   )
  )
  (set_local $10
   (i64.extend_u/i32
    (i32.shr_s
     (tee_local $5
      (i32.sub
       (tee_local $6
        (i32.load
         (i32.add
          (get_local $1)
          (i32.const 28)
         )
        )
       )
       (tee_local $4
        (i32.load offset=24
         (get_local $1)
        )
       )
      )
     )
     (i32.const 3)
    )
   )
  )
  (loop $label$0
   (set_local $9
    (i32.add
     (get_local $9)
     (i32.const 1)
    )
   )
   (br_if $label$0
    (i64.ne
     (tee_local $10
      (i64.shr_u
       (get_local $10)
       (i64.const 7)
      )
     )
     (i64.const 0)
    )
   )
  )
  (block $label$1
   (br_if $label$1
    (i32.eq
     (get_local $4)
     (get_local $6)
    )
   )
   (set_local $9
    (i32.add
     (i32.and
      (get_local $5)
      (i32.const -8)
     )
     (get_local $9)
    )
   )
  )
  (block $label$2
   (block $label$3
    (br_if $label$3
     (i32.lt_u
      (get_local $9)
      (i32.const 513)
     )
    )
    (set_local $11
     (call $malloc
      (get_local $9)
     )
    )
    (br $label$2)
   )
   (i32.store offset=4
    (i32.const 0)
    (tee_local $11
     (i32.sub
      (get_local $11)
      (i32.and
       (i32.add
        (get_local $9)
        (i32.const 15)
       )
       (i32.const -16)
      )
     )
    )
   )
  )
  (i32.store offset=8
   (get_local $12)
   (get_local $11)
  )
  (i32.store offset=16
   (get_local $12)
   (tee_local $6
    (i32.add
     (get_local $11)
     (get_local $9)
    )
   )
  )
  (call $eosio_assert
   (i32.gt_s
    (get_local $9)
    (i32.const 7)
   )
   (i32.const 432)
  )
  (drop
   (call $memcpy
    (get_local $11)
    (get_local $1)
    (i32.const 8)
   )
  )
  (call $eosio_assert
   (i32.gt_s
    (i32.sub
     (get_local $6)
     (tee_local $4
      (i32.add
       (get_local $11)
       (i32.const 8)
      )
     )
    )
    (i32.const 7)
   )
   (i32.const 432)
  )
  (drop
   (call $memcpy
    (get_local $4)
    (i32.add
     (get_local $1)
     (i32.const 8)
    )
    (i32.const 8)
   )
  )
  (call $eosio_assert
   (i32.gt_s
    (i32.sub
     (get_local $6)
     (tee_local $4
      (i32.add
       (get_local $11)
       (i32.const 16)
      )
     )
    )
    (i32.const 7)
   )
   (i32.const 432)
  )
  (drop
   (call $memcpy
    (get_local $4)
    (i32.add
     (get_local $1)
     (i32.const 16)
    )
    (i32.const 8)
   )
  )
  (i32.store offset=12
   (get_local $12)
   (i32.add
    (get_local $11)
    (i32.const 24)
   )
  )
  (drop
   (call $_ZN5eosiolsINS_10datastreamIPcEENS_4nameEEERT_S6_RKNSt3__16vectorIT0_NS7_9allocatorIS9_EEEE
    (i32.add
     (get_local $12)
     (i32.const 8)
    )
    (get_local $3)
   )
  )
  (i32.store offset=40
   (get_local $1)
   (call $db_store_i64
    (i64.load offset=8
     (get_local $2)
    )
    (i64.const -2507752926491967488)
    (i64.load
     (i32.load offset=8
      (get_local $0)
     )
    )
    (tee_local $10
     (i64.load
      (get_local $1)
     )
    )
    (get_local $11)
    (get_local $9)
   )
  )
  (block $label$4
   (br_if $label$4
    (i32.lt_u
     (get_local $9)
     (i32.const 513)
    )
   )
   (call $free
    (get_local $11)
   )
  )
  (block $label$5
   (br_if $label$5
    (i64.lt_u
     (get_local $10)
     (i64.load offset=16
      (get_local $2)
     )
    )
   )
   (i64.store
    (i32.add
     (get_local $2)
     (i32.const 16)
    )
    (select
     (i64.const -2)
     (i64.add
      (get_local $10)
      (i64.const 1)
     )
     (i64.gt_u
      (get_local $10)
      (i64.const -3)
     )
    )
   )
  )
  (set_local $10
   (i64.load
    (i32.add
     (get_local $2)
     (i32.const 8)
    )
   )
  )
  (set_local $7
   (i64.load
    (i32.load
     (i32.add
      (get_local $0)
      (i32.const 8)
     )
    )
   )
  )
  (set_local $8
   (i64.load
    (get_local $1)
   )
  )
  (i64.store offset=24
   (get_local $12)
   (i64.load
    (i32.add
     (get_local $1)
     (i32.const 8)
    )
   )
  )
  (i32.store offset=44
   (get_local $1)
   (call $db_idx64_store
    (get_local $10)
    (i64.const -2507752926491967488)
    (get_local $7)
    (get_local $8)
    (i32.add
     (get_local $12)
     (i32.const 24)
    )
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $12)
    (i32.const 32)
   )
  )
 )
 (func $_ZNK5eosio11multi_indexILy10566699677317378048E9termsinfoJEE31load_object_by_primary_iteratorEl (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i64)
  (local $6 i32)
  (local $7 i32)
  (local $8 i32)
  (local $9 i32)
  (set_local $8
   (tee_local $9
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 48)
    )
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (get_local $9)
  )
  (block $label$0
   (br_if $label$0
    (i32.eq
     (tee_local $7
      (i32.load
       (i32.add
        (get_local $0)
        (i32.const 28)
       )
      )
     )
     (tee_local $2
      (i32.load offset=24
       (get_local $0)
      )
     )
    )
   )
   (set_local $3
    (i32.sub
     (i32.const 0)
     (get_local $2)
    )
   )
   (set_local $6
    (i32.add
     (get_local $7)
     (i32.const -24)
    )
   )
   (loop $label$1
    (br_if $label$0
     (i32.eq
      (i32.load
       (i32.add
        (get_local $6)
        (i32.const 16)
       )
      )
      (get_local $1)
     )
    )
    (set_local $7
     (get_local $6)
    )
    (set_local $6
     (tee_local $4
      (i32.add
       (get_local $6)
       (i32.const -24)
      )
     )
    )
    (br_if $label$1
     (i32.ne
      (i32.add
       (get_local $4)
       (get_local $3)
      )
      (i32.const -24)
     )
    )
   )
  )
  (block $label$2
   (block $label$3
    (br_if $label$3
     (i32.eq
      (get_local $7)
      (get_local $2)
     )
    )
    (set_local $6
     (i32.load
      (i32.add
       (get_local $7)
       (i32.const -24)
      )
     )
    )
    (br $label$2)
   )
   (call $eosio_assert
    (i32.xor
     (i32.shr_u
      (tee_local $6
       (call $db_get_i64
        (get_local $1)
        (i32.const 0)
        (i32.const 0)
       )
      )
      (i32.const 31)
     )
     (i32.const 1)
    )
    (i32.const 448)
   )
   (block $label$4
    (block $label$5
     (br_if $label$5
      (i32.lt_u
       (get_local $6)
       (i32.const 513)
      )
     )
     (set_local $4
      (call $malloc
       (get_local $6)
      )
     )
     (br $label$4)
    )
    (i32.store offset=4
     (i32.const 0)
     (tee_local $4
      (i32.sub
       (get_local $9)
       (i32.and
        (i32.add
         (get_local $6)
         (i32.const 15)
        )
        (i32.const -16)
       )
      )
     )
    )
   )
   (drop
    (call $db_get_i64
     (get_local $1)
     (get_local $4)
     (get_local $6)
    )
   )
   (i32.store offset=36
    (get_local $8)
    (get_local $4)
   )
   (i32.store offset=32
    (get_local $8)
    (get_local $4)
   )
   (i32.store offset=40
    (get_local $8)
    (i32.add
     (get_local $4)
     (get_local $6)
    )
   )
   (block $label$6
    (br_if $label$6
     (i32.lt_u
      (get_local $6)
      (i32.const 513)
     )
    )
    (call $free
     (get_local $4)
    )
   )
   (drop
    (call $_ZN9termsinfoC2Ev
     (tee_local $6
      (call $_Znwj
       (i32.const 48)
      )
     )
    )
   )
   (i32.store offset=32
    (get_local $6)
    (get_local $0)
   )
   (call $eosio_assert
    (i32.gt_u
     (i32.sub
      (i32.load offset=8
       (tee_local $4
        (call $_ZN5eosiorsINS_10datastreamIPKcEEEERT_S6_RNSt3__112basic_stringIcNS7_11char_traitsIcEENS7_9allocatorIcEEEE
         (call $_ZN5eosiorsINS_10datastreamIPKcEEEERT_S6_RNSt3__112basic_stringIcNS7_11char_traitsIcEENS7_9allocatorIcEEEE
          (i32.add
           (get_local $8)
           (i32.const 32)
          )
          (get_local $6)
         )
         (i32.add
          (get_local $6)
          (i32.const 12)
         )
        )
       )
      )
      (i32.load offset=4
       (get_local $4)
      )
     )
     (i32.const 7)
    )
    (i32.const 576)
   )
   (drop
    (call $memcpy
     (i32.add
      (get_local $6)
      (i32.const 24)
     )
     (i32.load offset=4
      (get_local $4)
     )
     (i32.const 8)
    )
   )
   (i32.store offset=36
    (get_local $6)
    (get_local $1)
   )
   (i32.store offset=4
    (get_local $4)
    (i32.add
     (i32.load offset=4
      (get_local $4)
     )
     (i32.const 8)
    )
   )
   (i32.store offset=24
    (get_local $8)
    (get_local $6)
   )
   (i64.store offset=16
    (get_local $8)
    (tee_local $5
     (i64.load offset=24
      (get_local $6)
     )
    )
   )
   (i32.store offset=12
    (get_local $8)
    (tee_local $7
     (i32.load offset=36
      (get_local $6)
     )
    )
   )
   (block $label$7
    (block $label$8
     (br_if $label$8
      (i32.ge_u
       (tee_local $4
        (i32.load
         (tee_local $1
          (i32.add
           (get_local $0)
           (i32.const 28)
          )
         )
        )
       )
       (i32.load
        (i32.add
         (get_local $0)
         (i32.const 32)
        )
       )
      )
     )
     (i64.store offset=8
      (get_local $4)
      (get_local $5)
     )
     (i32.store offset=16
      (get_local $4)
      (get_local $7)
     )
     (i32.store offset=24
      (get_local $8)
      (i32.const 0)
     )
     (i32.store
      (get_local $4)
      (get_local $6)
     )
     (i32.store
      (get_local $1)
      (i32.add
       (get_local $4)
       (i32.const 24)
      )
     )
     (br $label$7)
    )
    (call $_ZNSt3__16vectorIN5eosio11multi_indexILy10566699677317378048E9termsinfoJEE8item_ptrENS_9allocatorIS5_EEE24__emplace_back_slow_pathIJNS_10unique_ptrINS4_4itemENS_14default_deleteISB_EEEERyRlEEEvDpOT_
     (i32.add
      (get_local $0)
      (i32.const 24)
     )
     (i32.add
      (get_local $8)
      (i32.const 24)
     )
     (i32.add
      (get_local $8)
      (i32.const 16)
     )
     (i32.add
      (get_local $8)
      (i32.const 12)
     )
    )
   )
   (set_local $4
    (i32.load offset=24
     (get_local $8)
    )
   )
   (i32.store offset=24
    (get_local $8)
    (i32.const 0)
   )
   (br_if $label$2
    (i32.eqz
     (get_local $4)
    )
   )
   (block $label$9
    (br_if $label$9
     (i32.eqz
      (i32.and
       (i32.load8_u offset=12
        (get_local $4)
       )
       (i32.const 1)
      )
     )
    )
    (call $_ZdlPv
     (i32.load
      (i32.add
       (get_local $4)
       (i32.const 20)
      )
     )
    )
   )
   (block $label$10
    (br_if $label$10
     (i32.eqz
      (i32.and
       (i32.load8_u
        (get_local $4)
       )
       (i32.const 1)
      )
     )
    )
    (call $_ZdlPv
     (i32.load offset=8
      (get_local $4)
     )
    )
   )
   (call $_ZdlPv
    (get_local $4)
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $8)
    (i32.const 48)
   )
  )
  (get_local $6)
 )
 (func $_ZN9termsinfoC2Ev (param $0 i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  (i64.store align=4
   (get_local $0)
   (i64.const 0)
  )
  (i32.store
   (i32.add
    (get_local $0)
    (i32.const 8)
   )
   (i32.const 0)
  )
  (block $label$0
   (block $label$1
    (br_if $label$1
     (i32.ge_u
      (tee_local $1
       (call $strlen
        (i32.const 1632)
       )
      )
      (i32.const -16)
     )
    )
    (block $label$2
     (block $label$3
      (block $label$4
       (br_if $label$4
        (i32.ge_u
         (get_local $1)
         (i32.const 11)
        )
       )
       (i32.store8
        (get_local $0)
        (i32.shl
         (get_local $1)
         (i32.const 1)
        )
       )
       (set_local $3
        (i32.add
         (get_local $0)
         (i32.const 1)
        )
       )
       (br_if $label$3
        (get_local $1)
       )
       (br $label$2)
      )
      (set_local $3
       (call $_Znwj
        (tee_local $2
         (i32.and
          (i32.add
           (get_local $1)
           (i32.const 16)
          )
          (i32.const -16)
         )
        )
       )
      )
      (i32.store
       (get_local $0)
       (i32.or
        (get_local $2)
        (i32.const 1)
       )
      )
      (i32.store offset=8
       (get_local $0)
       (get_local $3)
      )
      (i32.store offset=4
       (get_local $0)
       (get_local $1)
      )
     )
     (drop
      (call $memcpy
       (get_local $3)
       (i32.const 1632)
       (get_local $1)
      )
     )
    )
    (i32.store8
     (i32.add
      (get_local $3)
      (get_local $1)
     )
     (i32.const 0)
    )
    (i32.store
     (i32.add
      (get_local $0)
      (i32.const 20)
     )
     (i32.const 0)
    )
    (i64.store offset=12 align=4
     (get_local $0)
     (i64.const 0)
    )
    (set_local $3
     (i32.add
      (get_local $0)
      (i32.const 12)
     )
    )
    (br_if $label$0
     (i32.ge_u
      (tee_local $1
       (call $strlen
        (i32.const 1632)
       )
      )
      (i32.const -16)
     )
    )
    (block $label$5
     (block $label$6
      (block $label$7
       (br_if $label$7
        (i32.ge_u
         (get_local $1)
         (i32.const 11)
        )
       )
       (i32.store8
        (get_local $3)
        (i32.shl
         (get_local $1)
         (i32.const 1)
        )
       )
       (set_local $3
        (i32.add
         (get_local $3)
         (i32.const 1)
        )
       )
       (br_if $label$6
        (get_local $1)
       )
       (br $label$5)
      )
      (set_local $3
       (call $_Znwj
        (tee_local $2
         (i32.and
          (i32.add
           (get_local $1)
           (i32.const 16)
          )
          (i32.const -16)
         )
        )
       )
      )
      (i32.store
       (i32.add
        (get_local $0)
        (i32.const 12)
       )
       (i32.or
        (get_local $2)
        (i32.const 1)
       )
      )
      (i32.store
       (i32.add
        (get_local $0)
        (i32.const 20)
       )
       (get_local $3)
      )
      (i32.store
       (i32.add
        (get_local $0)
        (i32.const 16)
       )
       (get_local $1)
      )
     )
     (drop
      (call $memcpy
       (get_local $3)
       (i32.const 1632)
       (get_local $1)
      )
     )
    )
    (i32.store8
     (i32.add
      (get_local $3)
      (get_local $1)
     )
     (i32.const 0)
    )
    (i64.store offset=24
     (get_local $0)
     (i64.const 0)
    )
    (return
     (get_local $0)
    )
   )
   (call $_ZNKSt3__121__basic_string_commonILb1EE20__throw_length_errorEv
    (get_local $0)
   )
   (unreachable)
  )
  (call $_ZNKSt3__121__basic_string_commonILb1EE20__throw_length_errorEv
   (get_local $3)
  )
  (unreachable)
 )
 (func $_ZNSt3__16vectorIN5eosio11multi_indexILy10566699677317378048E9termsinfoJEE8item_ptrENS_9allocatorIS5_EEE24__emplace_back_slow_pathIJNS_10unique_ptrINS4_4itemENS_14default_deleteISB_EEEERyRlEEEvDpOT_ (param $0 i32) (param $1 i32) (param $2 i32) (param $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (block $label$0
   (block $label$1
    (br_if $label$1
     (i32.ge_u
      (tee_local $5
       (i32.add
        (tee_local $4
         (i32.div_s
          (i32.sub
           (i32.load offset=4
            (get_local $0)
           )
           (tee_local $6
            (i32.load
             (get_local $0)
            )
           )
          )
          (i32.const 24)
         )
        )
        (i32.const 1)
       )
      )
      (i32.const 178956971)
     )
    )
    (set_local $7
     (i32.const 178956970)
    )
    (block $label$2
     (block $label$3
      (br_if $label$3
       (i32.gt_u
        (tee_local $6
         (i32.div_s
          (i32.sub
           (i32.load offset=8
            (get_local $0)
           )
           (get_local $6)
          )
          (i32.const 24)
         )
        )
        (i32.const 89478484)
       )
      )
      (br_if $label$2
       (i32.eqz
        (tee_local $7
         (select
          (get_local $5)
          (tee_local $7
           (i32.shl
            (get_local $6)
            (i32.const 1)
           )
          )
          (i32.lt_u
           (get_local $7)
           (get_local $5)
          )
         )
        )
       )
      )
     )
     (set_local $6
      (call $_Znwj
       (i32.mul
        (get_local $7)
        (i32.const 24)
       )
      )
     )
     (br $label$0)
    )
    (set_local $7
     (i32.const 0)
    )
    (set_local $6
     (i32.const 0)
    )
    (br $label$0)
   )
   (call $_ZNKSt3__120__vector_base_commonILb1EE20__throw_length_errorEv
    (get_local $0)
   )
   (unreachable)
  )
  (set_local $5
   (i32.load
    (get_local $1)
   )
  )
  (i32.store
   (get_local $1)
   (i32.const 0)
  )
  (i32.store
   (tee_local $1
    (i32.add
     (get_local $6)
     (i32.mul
      (get_local $4)
      (i32.const 24)
     )
    )
   )
   (get_local $5)
  )
  (i64.store offset=8
   (get_local $1)
   (i64.load
    (get_local $2)
   )
  )
  (i32.store offset=16
   (get_local $1)
   (i32.load
    (get_local $3)
   )
  )
  (set_local $4
   (i32.add
    (get_local $6)
    (i32.mul
     (get_local $7)
     (i32.const 24)
    )
   )
  )
  (set_local $5
   (i32.add
    (get_local $1)
    (i32.const 24)
   )
  )
  (block $label$4
   (block $label$5
    (br_if $label$5
     (i32.eq
      (tee_local $6
       (i32.load
        (i32.add
         (get_local $0)
         (i32.const 4)
        )
       )
      )
      (tee_local $7
       (i32.load
        (get_local $0)
       )
      )
     )
    )
    (loop $label$6
     (set_local $3
      (i32.load
       (tee_local $2
        (i32.add
         (get_local $6)
         (i32.const -24)
        )
       )
      )
     )
     (i32.store
      (get_local $2)
      (i32.const 0)
     )
     (i32.store
      (i32.add
       (get_local $1)
       (i32.const -24)
      )
      (get_local $3)
     )
     (i32.store
      (i32.add
       (get_local $1)
       (i32.const -8)
      )
      (i32.load
       (i32.add
        (get_local $6)
        (i32.const -8)
       )
      )
     )
     (i32.store
      (i32.add
       (get_local $1)
       (i32.const -12)
      )
      (i32.load
       (i32.add
        (get_local $6)
        (i32.const -12)
       )
      )
     )
     (i32.store
      (i32.add
       (get_local $1)
       (i32.const -16)
      )
      (i32.load
       (i32.add
        (get_local $6)
        (i32.const -16)
       )
      )
     )
     (set_local $1
      (i32.add
       (get_local $1)
       (i32.const -24)
      )
     )
     (set_local $6
      (get_local $2)
     )
     (br_if $label$6
      (i32.ne
       (get_local $7)
       (get_local $2)
      )
     )
    )
    (set_local $7
     (i32.load
      (i32.add
       (get_local $0)
       (i32.const 4)
      )
     )
    )
    (set_local $6
     (i32.load
      (get_local $0)
     )
    )
    (br $label$4)
   )
   (set_local $6
    (get_local $7)
   )
  )
  (i32.store
   (get_local $0)
   (get_local $1)
  )
  (i32.store
   (i32.add
    (get_local $0)
    (i32.const 4)
   )
   (get_local $5)
  )
  (i32.store
   (i32.add
    (get_local $0)
    (i32.const 8)
   )
   (get_local $4)
  )
  (block $label$7
   (br_if $label$7
    (i32.eq
     (get_local $7)
     (get_local $6)
    )
   )
   (loop $label$8
    (set_local $1
     (i32.load
      (tee_local $7
       (i32.add
        (get_local $7)
        (i32.const -24)
       )
      )
     )
    )
    (i32.store
     (get_local $7)
     (i32.const 0)
    )
    (block $label$9
     (br_if $label$9
      (i32.eqz
       (get_local $1)
      )
     )
     (block $label$10
      (br_if $label$10
       (i32.eqz
        (i32.and
         (i32.load8_u offset=12
          (get_local $1)
         )
         (i32.const 1)
        )
       )
      )
      (call $_ZdlPv
       (i32.load
        (i32.add
         (get_local $1)
         (i32.const 20)
        )
       )
      )
     )
     (block $label$11
      (br_if $label$11
       (i32.eqz
        (i32.and
         (i32.load8_u
          (get_local $1)
         )
         (i32.const 1)
        )
       )
      )
      (call $_ZdlPv
       (i32.load offset=8
        (get_local $1)
       )
      )
     )
     (call $_ZdlPv
      (get_local $1)
     )
    )
    (br_if $label$8
     (i32.ne
      (get_local $6)
      (get_local $7)
     )
    )
   )
  )
  (block $label$12
   (br_if $label$12
    (i32.eqz
     (get_local $6)
    )
   )
   (call $_ZdlPv
    (get_local $6)
   )
  )
 )
 (func $_ZNK5eosio11multi_indexILy10566699676600369152E6memberJEE31load_object_by_primary_iteratorEl (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i64)
  (local $6 i32)
  (local $7 i32)
  (local $8 i32)
  (local $9 i32)
  (set_local $8
   (tee_local $9
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 32)
    )
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (get_local $9)
  )
  (block $label$0
   (br_if $label$0
    (i32.eq
     (tee_local $7
      (i32.load
       (i32.add
        (get_local $0)
        (i32.const 28)
       )
      )
     )
     (tee_local $2
      (i32.load offset=24
       (get_local $0)
      )
     )
    )
   )
   (set_local $3
    (i32.sub
     (i32.const 0)
     (get_local $2)
    )
   )
   (set_local $6
    (i32.add
     (get_local $7)
     (i32.const -24)
    )
   )
   (loop $label$1
    (br_if $label$0
     (i32.eq
      (i32.load
       (i32.add
        (get_local $6)
        (i32.const 16)
       )
      )
      (get_local $1)
     )
    )
    (set_local $7
     (get_local $6)
    )
    (set_local $6
     (tee_local $4
      (i32.add
       (get_local $6)
       (i32.const -24)
      )
     )
    )
    (br_if $label$1
     (i32.ne
      (i32.add
       (get_local $4)
       (get_local $3)
      )
      (i32.const -24)
     )
    )
   )
  )
  (block $label$2
   (block $label$3
    (br_if $label$3
     (i32.eq
      (get_local $7)
      (get_local $2)
     )
    )
    (set_local $6
     (i32.load
      (i32.add
       (get_local $7)
       (i32.const -24)
      )
     )
    )
    (br $label$2)
   )
   (call $eosio_assert
    (i32.xor
     (i32.shr_u
      (tee_local $4
       (call $db_get_i64
        (get_local $1)
        (i32.const 0)
        (i32.const 0)
       )
      )
      (i32.const 31)
     )
     (i32.const 1)
    )
    (i32.const 448)
   )
   (block $label$4
    (block $label$5
     (br_if $label$5
      (i32.le_u
       (get_local $4)
       (i32.const 512)
      )
     )
     (drop
      (call $db_get_i64
       (get_local $1)
       (tee_local $7
        (call $malloc
         (get_local $4)
        )
       )
       (get_local $4)
      )
     )
     (call $free
      (get_local $7)
     )
     (br $label$4)
    )
    (i32.store offset=4
     (i32.const 0)
     (tee_local $7
      (i32.sub
       (get_local $9)
       (i32.and
        (i32.add
         (get_local $4)
         (i32.const 15)
        )
        (i32.const -16)
       )
      )
     )
    )
    (drop
     (call $db_get_i64
      (get_local $1)
      (get_local $7)
      (get_local $4)
     )
    )
   )
   (i32.store offset=16
    (tee_local $6
     (call $_Znwj
      (i32.const 32)
     )
    )
    (get_local $0)
   )
   (i64.store
    (get_local $6)
    (i64.const 0)
   )
   (call $eosio_assert
    (i32.gt_u
     (get_local $4)
     (i32.const 7)
    )
    (i32.const 576)
   )
   (drop
    (call $memcpy
     (get_local $6)
     (get_local $7)
     (i32.const 8)
    )
   )
   (call $eosio_assert
    (i32.ne
     (i32.and
      (get_local $4)
      (i32.const -8)
     )
     (i32.const 8)
    )
    (i32.const 576)
   )
   (drop
    (call $memcpy
     (i32.add
      (get_local $6)
      (i32.const 8)
     )
     (i32.add
      (get_local $7)
      (i32.const 8)
     )
     (i32.const 8)
    )
   )
   (i32.store offset=20
    (get_local $6)
    (get_local $1)
   )
   (i32.store offset=24
    (get_local $8)
    (get_local $6)
   )
   (i64.store offset=16
    (get_local $8)
    (tee_local $5
     (i64.load
      (get_local $6)
     )
    )
   )
   (i32.store offset=12
    (get_local $8)
    (tee_local $7
     (i32.load offset=20
      (get_local $6)
     )
    )
   )
   (block $label$6
    (block $label$7
     (br_if $label$7
      (i32.ge_u
       (tee_local $4
        (i32.load
         (tee_local $1
          (i32.add
           (get_local $0)
           (i32.const 28)
          )
         )
        )
       )
       (i32.load
        (i32.add
         (get_local $0)
         (i32.const 32)
        )
       )
      )
     )
     (i64.store offset=8
      (get_local $4)
      (get_local $5)
     )
     (i32.store offset=16
      (get_local $4)
      (get_local $7)
     )
     (i32.store offset=24
      (get_local $8)
      (i32.const 0)
     )
     (i32.store
      (get_local $4)
      (get_local $6)
     )
     (i32.store
      (get_local $1)
      (i32.add
       (get_local $4)
       (i32.const 24)
      )
     )
     (br $label$6)
    )
    (call $_ZNSt3__16vectorIN5eosio11multi_indexILy10566699676600369152E6memberJEE8item_ptrENS_9allocatorIS5_EEE24__emplace_back_slow_pathIJNS_10unique_ptrINS4_4itemENS_14default_deleteISB_EEEERNS1_4nameERlEEEvDpOT_
     (i32.add
      (get_local $0)
      (i32.const 24)
     )
     (i32.add
      (get_local $8)
      (i32.const 24)
     )
     (i32.add
      (get_local $8)
      (i32.const 16)
     )
     (i32.add
      (get_local $8)
      (i32.const 12)
     )
    )
   )
   (set_local $4
    (i32.load offset=24
     (get_local $8)
    )
   )
   (i32.store offset=24
    (get_local $8)
    (i32.const 0)
   )
   (br_if $label$2
    (i32.eqz
     (get_local $4)
    )
   )
   (call $_ZdlPv
    (get_local $4)
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $8)
    (i32.const 32)
   )
  )
  (get_local $6)
 )
 (func $_ZNSt3__16vectorIN5eosio11multi_indexILy10566699676600369152E6memberJEE8item_ptrENS_9allocatorIS5_EEE24__emplace_back_slow_pathIJNS_10unique_ptrINS4_4itemENS_14default_deleteISB_EEEERNS1_4nameERlEEEvDpOT_ (param $0 i32) (param $1 i32) (param $2 i32) (param $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (block $label$0
   (block $label$1
    (br_if $label$1
     (i32.ge_u
      (tee_local $5
       (i32.add
        (tee_local $4
         (i32.div_s
          (i32.sub
           (i32.load offset=4
            (get_local $0)
           )
           (tee_local $6
            (i32.load
             (get_local $0)
            )
           )
          )
          (i32.const 24)
         )
        )
        (i32.const 1)
       )
      )
      (i32.const 178956971)
     )
    )
    (set_local $7
     (i32.const 178956970)
    )
    (block $label$2
     (block $label$3
      (br_if $label$3
       (i32.gt_u
        (tee_local $6
         (i32.div_s
          (i32.sub
           (i32.load offset=8
            (get_local $0)
           )
           (get_local $6)
          )
          (i32.const 24)
         )
        )
        (i32.const 89478484)
       )
      )
      (br_if $label$2
       (i32.eqz
        (tee_local $7
         (select
          (get_local $5)
          (tee_local $7
           (i32.shl
            (get_local $6)
            (i32.const 1)
           )
          )
          (i32.lt_u
           (get_local $7)
           (get_local $5)
          )
         )
        )
       )
      )
     )
     (set_local $6
      (call $_Znwj
       (i32.mul
        (get_local $7)
        (i32.const 24)
       )
      )
     )
     (br $label$0)
    )
    (set_local $7
     (i32.const 0)
    )
    (set_local $6
     (i32.const 0)
    )
    (br $label$0)
   )
   (call $_ZNKSt3__120__vector_base_commonILb1EE20__throw_length_errorEv
    (get_local $0)
   )
   (unreachable)
  )
  (set_local $5
   (i32.load
    (get_local $1)
   )
  )
  (i32.store
   (get_local $1)
   (i32.const 0)
  )
  (i32.store
   (tee_local $1
    (i32.add
     (get_local $6)
     (i32.mul
      (get_local $4)
      (i32.const 24)
     )
    )
   )
   (get_local $5)
  )
  (i64.store offset=8
   (get_local $1)
   (i64.load
    (get_local $2)
   )
  )
  (i32.store offset=16
   (get_local $1)
   (i32.load
    (get_local $3)
   )
  )
  (set_local $4
   (i32.add
    (get_local $6)
    (i32.mul
     (get_local $7)
     (i32.const 24)
    )
   )
  )
  (set_local $5
   (i32.add
    (get_local $1)
    (i32.const 24)
   )
  )
  (block $label$4
   (block $label$5
    (br_if $label$5
     (i32.eq
      (tee_local $6
       (i32.load
        (i32.add
         (get_local $0)
         (i32.const 4)
        )
       )
      )
      (tee_local $7
       (i32.load
        (get_local $0)
       )
      )
     )
    )
    (loop $label$6
     (set_local $3
      (i32.load
       (tee_local $2
        (i32.add
         (get_local $6)
         (i32.const -24)
        )
       )
      )
     )
     (i32.store
      (get_local $2)
      (i32.const 0)
     )
     (i32.store
      (i32.add
       (get_local $1)
       (i32.const -24)
      )
      (get_local $3)
     )
     (i32.store
      (i32.add
       (get_local $1)
       (i32.const -8)
      )
      (i32.load
       (i32.add
        (get_local $6)
        (i32.const -8)
       )
      )
     )
     (i32.store
      (i32.add
       (get_local $1)
       (i32.const -12)
      )
      (i32.load
       (i32.add
        (get_local $6)
        (i32.const -12)
       )
      )
     )
     (i32.store
      (i32.add
       (get_local $1)
       (i32.const -16)
      )
      (i32.load
       (i32.add
        (get_local $6)
        (i32.const -16)
       )
      )
     )
     (set_local $1
      (i32.add
       (get_local $1)
       (i32.const -24)
      )
     )
     (set_local $6
      (get_local $2)
     )
     (br_if $label$6
      (i32.ne
       (get_local $7)
       (get_local $2)
      )
     )
    )
    (set_local $7
     (i32.load
      (i32.add
       (get_local $0)
       (i32.const 4)
      )
     )
    )
    (set_local $6
     (i32.load
      (get_local $0)
     )
    )
    (br $label$4)
   )
   (set_local $6
    (get_local $7)
   )
  )
  (i32.store
   (get_local $0)
   (get_local $1)
  )
  (i32.store
   (i32.add
    (get_local $0)
    (i32.const 4)
   )
   (get_local $5)
  )
  (i32.store
   (i32.add
    (get_local $0)
    (i32.const 8)
   )
   (get_local $4)
  )
  (block $label$7
   (br_if $label$7
    (i32.eq
     (get_local $7)
     (get_local $6)
    )
   )
   (loop $label$8
    (set_local $1
     (i32.load
      (tee_local $7
       (i32.add
        (get_local $7)
        (i32.const -24)
       )
      )
     )
    )
    (i32.store
     (get_local $7)
     (i32.const 0)
    )
    (block $label$9
     (br_if $label$9
      (i32.eqz
       (get_local $1)
      )
     )
     (call $_ZdlPv
      (get_local $1)
     )
    )
    (br_if $label$8
     (i32.ne
      (get_local $6)
      (get_local $7)
     )
    )
   )
  )
  (block $label$10
   (br_if $label$10
    (i32.eqz
     (get_local $6)
    )
   )
   (call $_ZdlPv
    (get_local $6)
   )
  )
 )
 (func $_ZN5eosio11multi_indexILy15938991147217584128E4voteJNS_10indexed_byILy4587895300147904512EN5boost11multi_index13const_mem_funIS1_yXadL_ZNKS1_8by_proxyEvEEEEEEEE6modifyIZN12daccustodian8votecustENS_4nameENSt3__16vectorISB_NSC_9allocatorISB_EEEEEUlRS1_E_EEvRKS1_yOT_ (param $0 i32) (param $1 i32) (param $2 i64) (param $3 i32)
  (local $4 i64)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (local $8 i32)
  (local $9 i64)
  (local $10 i32)
  (local $11 i32)
  (i32.store offset=4
   (i32.const 0)
   (tee_local $10
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 48)
    )
   )
  )
  (call $eosio_assert
   (i32.eq
    (i32.load offset=36
     (get_local $1)
    )
    (get_local $0)
   )
   (i32.const 608)
  )
  (call $eosio_assert
   (i64.eq
    (i64.load
     (get_local $0)
    )
    (call $current_receiver)
   )
   (i32.const 656)
  )
  (i64.store offset=24
   (tee_local $11
    (get_local $10)
   )
   (i64.load offset=8
    (get_local $1)
   )
  )
  (set_local $8
   (i32.const 24)
  )
  (set_local $9
   (tee_local $4
    (i64.load
     (get_local $1)
    )
   )
  )
  (block $label$0
   (br_if $label$0
    (i32.eq
     (tee_local $5
      (i32.add
       (get_local $1)
       (i32.const 24)
      )
     )
     (tee_local $3
      (i32.load
       (get_local $3)
      )
     )
    )
   )
   (call $_ZNSt3__16vectorIN5eosio4nameENS_9allocatorIS2_EEE6assignIPS2_EENS_9enable_ifIXaasr21__is_forward_iteratorIT_EE5valuesr16is_constructibleIS2_NS_15iterator_traitsIS9_E9referenceEEE5valueEvE4typeES9_S9_
    (get_local $5)
    (i32.load
     (get_local $3)
    )
    (i32.load offset=4
     (get_local $3)
    )
   )
   (set_local $9
    (i64.load
     (get_local $1)
    )
   )
  )
  (i64.store
   (i32.add
    (get_local $1)
    (i32.const 8)
   )
   (i64.const 0)
  )
  (call $eosio_assert
   (i64.eq
    (get_local $4)
    (get_local $9)
   )
   (i32.const 720)
  )
  (set_local $9
   (i64.extend_u/i32
    (i32.shr_s
     (tee_local $7
      (i32.sub
       (tee_local $3
        (i32.load
         (i32.add
          (get_local $1)
          (i32.const 28)
         )
        )
       )
       (tee_local $6
        (i32.load
         (get_local $5)
        )
       )
      )
     )
     (i32.const 3)
    )
   )
  )
  (loop $label$1
   (set_local $8
    (i32.add
     (get_local $8)
     (i32.const 1)
    )
   )
   (br_if $label$1
    (i64.ne
     (tee_local $9
      (i64.shr_u
       (get_local $9)
       (i64.const 7)
      )
     )
     (i64.const 0)
    )
   )
  )
  (block $label$2
   (br_if $label$2
    (i32.eq
     (get_local $6)
     (get_local $3)
    )
   )
   (set_local $8
    (i32.add
     (i32.and
      (get_local $7)
      (i32.const -8)
     )
     (get_local $8)
    )
   )
  )
  (block $label$3
   (block $label$4
    (br_if $label$4
     (i32.lt_u
      (get_local $8)
      (i32.const 513)
     )
    )
    (set_local $10
     (call $malloc
      (get_local $8)
     )
    )
    (br $label$3)
   )
   (i32.store offset=4
    (i32.const 0)
    (tee_local $10
     (i32.sub
      (get_local $10)
      (i32.and
       (i32.add
        (get_local $8)
        (i32.const 15)
       )
       (i32.const -16)
      )
     )
    )
   )
  )
  (i32.store offset=8
   (get_local $11)
   (get_local $10)
  )
  (i32.store offset=16
   (get_local $11)
   (tee_local $3
    (i32.add
     (get_local $10)
     (get_local $8)
    )
   )
  )
  (call $eosio_assert
   (i32.gt_s
    (get_local $8)
    (i32.const 7)
   )
   (i32.const 432)
  )
  (drop
   (call $memcpy
    (get_local $10)
    (get_local $1)
    (i32.const 8)
   )
  )
  (call $eosio_assert
   (i32.gt_s
    (i32.sub
     (get_local $3)
     (tee_local $6
      (i32.add
       (get_local $10)
       (i32.const 8)
      )
     )
    )
    (i32.const 7)
   )
   (i32.const 432)
  )
  (drop
   (call $memcpy
    (get_local $6)
    (i32.add
     (get_local $1)
     (i32.const 8)
    )
    (i32.const 8)
   )
  )
  (call $eosio_assert
   (i32.gt_s
    (i32.sub
     (get_local $3)
     (tee_local $6
      (i32.add
       (get_local $10)
       (i32.const 16)
      )
     )
    )
    (i32.const 7)
   )
   (i32.const 432)
  )
  (drop
   (call $memcpy
    (get_local $6)
    (i32.add
     (get_local $1)
     (i32.const 16)
    )
    (i32.const 8)
   )
  )
  (i32.store offset=12
   (get_local $11)
   (i32.add
    (get_local $10)
    (i32.const 24)
   )
  )
  (drop
   (call $_ZN5eosiolsINS_10datastreamIPcEENS_4nameEEERT_S6_RKNSt3__16vectorIT0_NS7_9allocatorIS9_EEEE
    (i32.add
     (get_local $11)
     (i32.const 8)
    )
    (get_local $5)
   )
  )
  (call $db_update_i64
   (i32.load offset=40
    (get_local $1)
   )
   (get_local $2)
   (get_local $10)
   (get_local $8)
  )
  (block $label$5
   (br_if $label$5
    (i32.lt_u
     (get_local $8)
     (i32.const 513)
    )
   )
   (call $free
    (get_local $10)
   )
  )
  (block $label$6
   (br_if $label$6
    (i64.lt_u
     (get_local $4)
     (i64.load offset=16
      (get_local $0)
     )
    )
   )
   (i64.store
    (i32.add
     (get_local $0)
     (i32.const 16)
    )
    (select
     (i64.const -2)
     (i64.add
      (get_local $4)
      (i64.const 1)
     )
     (i64.gt_u
      (get_local $4)
      (i64.const -3)
     )
    )
   )
  )
  (i64.store offset=40
   (get_local $11)
   (i64.load
    (i32.add
     (get_local $1)
     (i32.const 8)
    )
   )
  )
  (block $label$7
   (br_if $label$7
    (i32.eqz
     (call $memcmp
      (i32.add
       (get_local $11)
       (i32.const 24)
      )
      (i32.add
       (get_local $11)
       (i32.const 40)
      )
      (i32.const 8)
     )
    )
   )
   (block $label$8
    (br_if $label$8
     (i32.gt_s
      (tee_local $8
       (i32.load offset=44
        (get_local $1)
       )
      )
      (i32.const -1)
     )
    )
    (i32.store
     (i32.add
      (get_local $1)
      (i32.const 44)
     )
     (tee_local $8
      (call $db_idx64_find_primary
       (i64.load
        (get_local $0)
       )
       (i64.load offset=8
        (get_local $0)
       )
       (i64.const -2507752926491967488)
       (i32.add
        (get_local $11)
        (i32.const 32)
       )
       (get_local $4)
      )
     )
    )
   )
   (call $db_idx64_update
    (get_local $8)
    (get_local $2)
    (i32.add
     (get_local $11)
     (i32.const 40)
    )
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $11)
    (i32.const 48)
   )
  )
 )
 (func $_ZN5eosio11multi_indexILy15938991147217584128E4voteJNS_10indexed_byILy4587895300147904512EN5boost11multi_index13const_mem_funIS1_yXadL_ZNKS1_8by_proxyEvEEEEEEEE7emplaceIZN12daccustodian8votecustENS_4nameENSt3__16vectorISB_NSC_9allocatorISB_EEEEEUlRS1_E0_EENS8_14const_iteratorEyOT_ (param $0 i32) (param $1 i32) (param $2 i64) (param $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (i32.store offset=4
   (i32.const 0)
   (tee_local $7
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 48)
    )
   )
  )
  (i64.store offset=40
   (get_local $7)
   (get_local $2)
  )
  (call $eosio_assert
   (i64.eq
    (i64.load
     (get_local $1)
    )
    (call $current_receiver)
   )
   (i32.const 1008)
  )
  (i32.store offset=20
   (get_local $7)
   (get_local $3)
  )
  (i32.store offset=16
   (get_local $7)
   (get_local $1)
  )
  (i32.store offset=24
   (get_local $7)
   (i32.add
    (get_local $7)
    (i32.const 40)
   )
  )
  (i64.store offset=8
   (tee_local $3
    (call $_Znwj
     (i32.const 48)
    )
   )
   (i64.const 0)
  )
  (i64.store
   (get_local $3)
   (i64.const 0)
  )
  (i64.store offset=24 align=4
   (get_local $3)
   (i64.const 0)
  )
  (i32.store offset=32
   (get_local $3)
   (i32.const 0)
  )
  (i32.store offset=36
   (get_local $3)
   (get_local $1)
  )
  (call $_ZZN5eosio11multi_indexILy15938991147217584128E4voteJNS_10indexed_byILy4587895300147904512EN5boost11multi_index13const_mem_funIS1_yXadL_ZNKS1_8by_proxyEvEEEEEEEE7emplaceIZN12daccustodian8votecustENS_4nameENSt3__16vectorISB_NSC_9allocatorISB_EEEEEUlRS1_E0_EENS8_14const_iteratorEyOT_ENKUlRSK_E_clINS8_4itemEEEDaSM_
   (i32.add
    (get_local $7)
    (i32.const 16)
   )
   (get_local $3)
  )
  (i32.store offset=32
   (get_local $7)
   (get_local $3)
  )
  (i64.store offset=16
   (get_local $7)
   (tee_local $2
    (i64.load
     (get_local $3)
    )
   )
  )
  (i32.store offset=12
   (get_local $7)
   (tee_local $4
    (i32.load offset=40
     (get_local $3)
    )
   )
  )
  (block $label$0
   (block $label$1
    (br_if $label$1
     (i32.ge_u
      (tee_local $5
       (i32.load
        (tee_local $6
         (i32.add
          (get_local $1)
          (i32.const 28)
         )
        )
       )
      )
      (i32.load
       (i32.add
        (get_local $1)
        (i32.const 32)
       )
      )
     )
    )
    (i64.store offset=8
     (get_local $5)
     (get_local $2)
    )
    (i32.store offset=16
     (get_local $5)
     (get_local $4)
    )
    (i32.store offset=32
     (get_local $7)
     (i32.const 0)
    )
    (i32.store
     (get_local $5)
     (get_local $3)
    )
    (i32.store
     (get_local $6)
     (i32.add
      (get_local $5)
      (i32.const 24)
     )
    )
    (br $label$0)
   )
   (call $_ZNSt3__16vectorIN5eosio11multi_indexILy15938991147217584128E4voteJNS1_10indexed_byILy4587895300147904512EN5boost11multi_index13const_mem_funIS3_yXadL_ZNKS3_8by_proxyEvEEEEEEEE8item_ptrENS_9allocatorISB_EEE24__emplace_back_slow_pathIJNS_10unique_ptrINSA_4itemENS_14default_deleteISH_EEEERyRlEEEvDpOT_
    (i32.add
     (get_local $1)
     (i32.const 24)
    )
    (i32.add
     (get_local $7)
     (i32.const 32)
    )
    (i32.add
     (get_local $7)
     (i32.const 16)
    )
    (i32.add
     (get_local $7)
     (i32.const 12)
    )
   )
  )
  (i32.store offset=4
   (get_local $0)
   (get_local $3)
  )
  (i32.store
   (get_local $0)
   (get_local $1)
  )
  (set_local $3
   (i32.load offset=32
    (get_local $7)
   )
  )
  (i32.store offset=32
   (get_local $7)
   (i32.const 0)
  )
  (block $label$2
   (br_if $label$2
    (i32.eqz
     (get_local $3)
    )
   )
   (block $label$3
    (br_if $label$3
     (i32.eqz
      (tee_local $1
       (i32.load offset=24
        (get_local $3)
       )
      )
     )
    )
    (i32.store
     (i32.add
      (get_local $3)
      (i32.const 28)
     )
     (get_local $1)
    )
    (call $_ZdlPv
     (get_local $1)
    )
   )
   (call $_ZdlPv
    (get_local $3)
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $7)
    (i32.const 48)
   )
  )
 )
 (func $_ZZN5eosio11multi_indexILy15938991147217584128E4voteJNS_10indexed_byILy4587895300147904512EN5boost11multi_index13const_mem_funIS1_yXadL_ZNKS1_8by_proxyEvEEEEEEEE7emplaceIZN12daccustodian8votecustENS_4nameENSt3__16vectorISB_NSC_9allocatorISB_EEEEEUlRS1_E0_EENS8_14const_iteratorEyOT_ENKUlRSK_E_clINS8_4itemEEEDaSM_ (param $0 i32) (param $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i64)
  (local $8 i64)
  (local $9 i32)
  (local $10 i64)
  (local $11 i32)
  (local $12 i32)
  (set_local $12
   (tee_local $11
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 32)
    )
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (get_local $11)
  )
  (set_local $2
   (i32.load
    (get_local $0)
   )
  )
  (i64.store
   (get_local $1)
   (i64.load
    (i32.load
     (tee_local $6
      (i32.load offset=4
       (get_local $0)
      )
     )
    )
   )
  )
  (set_local $9
   (i32.const 24)
  )
  (block $label$0
   (br_if $label$0
    (i32.eq
     (tee_local $3
      (i32.add
       (get_local $1)
       (i32.const 24)
      )
     )
     (tee_local $6
      (i32.load offset=4
       (get_local $6)
      )
     )
    )
   )
   (call $_ZNSt3__16vectorIN5eosio4nameENS_9allocatorIS2_EEE6assignIPS2_EENS_9enable_ifIXaasr21__is_forward_iteratorIT_EE5valuesr16is_constructibleIS2_NS_15iterator_traitsIS9_E9referenceEEE5valueEvE4typeES9_S9_
    (get_local $3)
    (i32.load
     (get_local $6)
    )
    (i32.load offset=4
     (get_local $6)
    )
   )
  )
  (set_local $10
   (i64.extend_u/i32
    (i32.shr_s
     (tee_local $5
      (i32.sub
       (tee_local $6
        (i32.load
         (i32.add
          (get_local $1)
          (i32.const 28)
         )
        )
       )
       (tee_local $4
        (i32.load
         (get_local $3)
        )
       )
      )
     )
     (i32.const 3)
    )
   )
  )
  (loop $label$1
   (set_local $9
    (i32.add
     (get_local $9)
     (i32.const 1)
    )
   )
   (br_if $label$1
    (i64.ne
     (tee_local $10
      (i64.shr_u
       (get_local $10)
       (i64.const 7)
      )
     )
     (i64.const 0)
    )
   )
  )
  (block $label$2
   (br_if $label$2
    (i32.eq
     (get_local $4)
     (get_local $6)
    )
   )
   (set_local $9
    (i32.add
     (i32.and
      (get_local $5)
      (i32.const -8)
     )
     (get_local $9)
    )
   )
  )
  (block $label$3
   (block $label$4
    (br_if $label$4
     (i32.lt_u
      (get_local $9)
      (i32.const 513)
     )
    )
    (set_local $11
     (call $malloc
      (get_local $9)
     )
    )
    (br $label$3)
   )
   (i32.store offset=4
    (i32.const 0)
    (tee_local $11
     (i32.sub
      (get_local $11)
      (i32.and
       (i32.add
        (get_local $9)
        (i32.const 15)
       )
       (i32.const -16)
      )
     )
    )
   )
  )
  (i32.store offset=8
   (get_local $12)
   (get_local $11)
  )
  (i32.store offset=16
   (get_local $12)
   (tee_local $6
    (i32.add
     (get_local $11)
     (get_local $9)
    )
   )
  )
  (call $eosio_assert
   (i32.gt_s
    (get_local $9)
    (i32.const 7)
   )
   (i32.const 432)
  )
  (drop
   (call $memcpy
    (get_local $11)
    (get_local $1)
    (i32.const 8)
   )
  )
  (call $eosio_assert
   (i32.gt_s
    (i32.sub
     (get_local $6)
     (tee_local $4
      (i32.add
       (get_local $11)
       (i32.const 8)
      )
     )
    )
    (i32.const 7)
   )
   (i32.const 432)
  )
  (drop
   (call $memcpy
    (get_local $4)
    (i32.add
     (get_local $1)
     (i32.const 8)
    )
    (i32.const 8)
   )
  )
  (call $eosio_assert
   (i32.gt_s
    (i32.sub
     (get_local $6)
     (tee_local $4
      (i32.add
       (get_local $11)
       (i32.const 16)
      )
     )
    )
    (i32.const 7)
   )
   (i32.const 432)
  )
  (drop
   (call $memcpy
    (get_local $4)
    (i32.add
     (get_local $1)
     (i32.const 16)
    )
    (i32.const 8)
   )
  )
  (i32.store offset=12
   (get_local $12)
   (i32.add
    (get_local $11)
    (i32.const 24)
   )
  )
  (drop
   (call $_ZN5eosiolsINS_10datastreamIPcEENS_4nameEEERT_S6_RKNSt3__16vectorIT0_NS7_9allocatorIS9_EEEE
    (i32.add
     (get_local $12)
     (i32.const 8)
    )
    (get_local $3)
   )
  )
  (i32.store offset=40
   (get_local $1)
   (call $db_store_i64
    (i64.load offset=8
     (get_local $2)
    )
    (i64.const -2507752926491967488)
    (i64.load
     (i32.load offset=8
      (get_local $0)
     )
    )
    (tee_local $10
     (i64.load
      (get_local $1)
     )
    )
    (get_local $11)
    (get_local $9)
   )
  )
  (block $label$5
   (br_if $label$5
    (i32.lt_u
     (get_local $9)
     (i32.const 513)
    )
   )
   (call $free
    (get_local $11)
   )
  )
  (block $label$6
   (br_if $label$6
    (i64.lt_u
     (get_local $10)
     (i64.load offset=16
      (get_local $2)
     )
    )
   )
   (i64.store
    (i32.add
     (get_local $2)
     (i32.const 16)
    )
    (select
     (i64.const -2)
     (i64.add
      (get_local $10)
      (i64.const 1)
     )
     (i64.gt_u
      (get_local $10)
      (i64.const -3)
     )
    )
   )
  )
  (set_local $10
   (i64.load
    (i32.add
     (get_local $2)
     (i32.const 8)
    )
   )
  )
  (set_local $7
   (i64.load
    (i32.load
     (i32.add
      (get_local $0)
      (i32.const 8)
     )
    )
   )
  )
  (set_local $8
   (i64.load
    (get_local $1)
   )
  )
  (i64.store offset=24
   (get_local $12)
   (i64.load offset=8
    (get_local $1)
   )
  )
  (i32.store offset=44
   (get_local $1)
   (call $db_idx64_store
    (get_local $10)
    (i64.const -2507752926491967488)
    (get_local $7)
    (get_local $8)
    (i32.add
     (get_local $12)
     (i32.const 24)
    )
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $12)
    (i32.const 32)
   )
  )
 )
 (func $_ZNSt3__16vectorIN5eosio4nameENS_9allocatorIS2_EEE6assignIPS2_EENS_9enable_ifIXaasr21__is_forward_iteratorIT_EE5valuesr16is_constructibleIS2_NS_15iterator_traitsIS9_E9referenceEEE5valueEvE4typeES9_S9_ (param $0 i32) (param $1 i32) (param $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (local $8 i32)
  (block $label$0
   (block $label$1
    (block $label$2
     (block $label$3
      (br_if $label$3
       (i32.le_u
        (tee_local $4
         (i32.shr_s
          (tee_local $3
           (i32.sub
            (get_local $2)
            (get_local $1)
           )
          )
          (i32.const 3)
         )
        )
        (i32.shr_s
         (i32.sub
          (tee_local $8
           (i32.load offset=8
            (get_local $0)
           )
          )
          (tee_local $5
           (i32.load
            (get_local $0)
           )
          )
         )
         (i32.const 3)
        )
       )
      )
      (block $label$4
       (br_if $label$4
        (i32.eqz
         (get_local $5)
        )
       )
       (i32.store offset=4
        (get_local $0)
        (get_local $5)
       )
       (call $_ZdlPv
        (get_local $5)
       )
       (set_local $8
        (i32.const 0)
       )
       (i32.store
        (i32.add
         (get_local $0)
         (i32.const 8)
        )
        (i32.const 0)
       )
       (i64.store align=4
        (get_local $0)
        (i64.const 0)
       )
      )
      (br_if $label$0
       (i32.ge_u
        (get_local $4)
        (i32.const 536870912)
       )
      )
      (set_local $5
       (i32.const 536870911)
      )
      (block $label$5
       (br_if $label$5
        (i32.gt_u
         (i32.shr_s
          (get_local $8)
          (i32.const 3)
         )
         (i32.const 268435454)
        )
       )
       (set_local $5
        (get_local $4)
       )
       (br_if $label$5
        (i32.lt_u
         (tee_local $2
          (i32.shr_s
           (get_local $8)
           (i32.const 2)
          )
         )
         (get_local $4)
        )
       )
       (set_local $5
        (get_local $2)
       )
       (br_if $label$0
        (i32.ge_u
         (get_local $2)
         (i32.const 536870912)
        )
       )
      )
      (i32.store
       (get_local $0)
       (tee_local $5
        (call $_Znwj
         (tee_local $4
          (i32.shl
           (get_local $5)
           (i32.const 3)
          )
         )
        )
       )
      )
      (i32.store offset=4
       (get_local $0)
       (get_local $5)
      )
      (i32.store
       (i32.add
        (get_local $0)
        (i32.const 8)
       )
       (i32.add
        (get_local $5)
        (get_local $4)
       )
      )
      (br_if $label$2
       (i32.lt_s
        (get_local $3)
        (i32.const 1)
       )
      )
      (drop
       (call $memcpy
        (get_local $5)
        (get_local $1)
        (get_local $3)
       )
      )
      (i32.store
       (tee_local $0
        (i32.add
         (get_local $0)
         (i32.const 4)
        )
       )
       (i32.add
        (i32.load
         (get_local $0)
        )
        (get_local $3)
       )
      )
      (return)
     )
     (block $label$6
      (br_if $label$6
       (i32.eqz
        (tee_local $7
         (i32.shr_s
          (tee_local $6
           (i32.sub
            (tee_local $8
             (select
              (i32.add
               (get_local $1)
               (tee_local $3
                (i32.sub
                 (i32.load offset=4
                  (get_local $0)
                 )
                 (get_local $5)
                )
               )
              )
              (get_local $2)
              (i32.gt_u
               (get_local $4)
               (tee_local $3
                (i32.shr_s
                 (get_local $3)
                 (i32.const 3)
                )
               )
              )
             )
            )
            (get_local $1)
           )
          )
          (i32.const 3)
         )
        )
       )
      )
      (drop
       (call $memmove
        (get_local $5)
        (get_local $1)
        (get_local $6)
       )
      )
     )
     (br_if $label$1
      (i32.le_u
       (get_local $4)
       (get_local $3)
      )
     )
     (br_if $label$2
      (i32.lt_s
       (tee_local $1
        (i32.sub
         (get_local $2)
         (get_local $8)
        )
       )
       (i32.const 1)
      )
     )
     (drop
      (call $memcpy
       (i32.load
        (tee_local $0
         (i32.add
          (get_local $0)
          (i32.const 4)
         )
        )
       )
       (get_local $8)
       (get_local $1)
      )
     )
     (i32.store
      (get_local $0)
      (i32.add
       (i32.load
        (get_local $0)
       )
       (get_local $1)
      )
     )
     (return)
    )
    (return)
   )
   (i32.store
    (i32.add
     (get_local $0)
     (i32.const 4)
    )
    (i32.add
     (get_local $5)
     (i32.shl
      (get_local $7)
      (i32.const 3)
     )
    )
   )
   (return)
  )
  (call $_ZNKSt3__120__vector_base_commonILb1EE20__throw_length_errorEv
   (get_local $0)
  )
  (unreachable)
 )
 (func $_ZNK5eosio11multi_indexILy4730634643120193536E9candidateJNS_10indexed_byILy8518361509820596224EN5boost11multi_index13const_mem_funIS1_oXadL_ZNKS1_22get_by_is_cust_and_payEvEEEEEENS2_ILy4591222642450628608ENS5_IS1_yXadL_ZNKS1_15by_number_votesEvEEEEEEEE3getEyPKc (param $0 i32) (param $1 i64) (param $2 i32) (result i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (block $label$0
   (br_if $label$0
    (i32.eq
     (tee_local $7
      (i32.load
       (i32.add
        (get_local $0)
        (i32.const 28)
       )
      )
     )
     (tee_local $3
      (i32.load offset=24
       (get_local $0)
      )
     )
    )
   )
   (set_local $6
    (i32.add
     (get_local $7)
     (i32.const -24)
    )
   )
   (set_local $4
    (i32.sub
     (i32.const 0)
     (get_local $3)
    )
   )
   (loop $label$1
    (br_if $label$0
     (i64.eq
      (i64.load
       (i32.load
        (get_local $6)
       )
      )
      (get_local $1)
     )
    )
    (set_local $7
     (get_local $6)
    )
    (set_local $6
     (tee_local $5
      (i32.add
       (get_local $6)
       (i32.const -24)
      )
     )
    )
    (br_if $label$1
     (i32.ne
      (i32.add
       (get_local $5)
       (get_local $4)
      )
      (i32.const -24)
     )
    )
   )
  )
  (block $label$2
   (block $label$3
    (br_if $label$3
     (i32.eq
      (get_local $7)
      (get_local $3)
     )
    )
    (call $eosio_assert
     (i32.eq
      (i32.load offset=88
       (tee_local $6
        (i32.load
         (i32.add
          (get_local $7)
          (i32.const -24)
         )
        )
       )
      )
      (get_local $0)
     )
     (i32.const 896)
    )
    (br $label$2)
   )
   (set_local $6
    (i32.const 0)
   )
   (br_if $label$2
    (i32.lt_s
     (tee_local $5
      (call $db_find_i64
       (i64.load
        (get_local $0)
       )
       (i64.load offset=8
        (get_local $0)
       )
       (i64.const 4730634643120193536)
       (get_local $1)
      )
     )
     (i32.const 0)
    )
   )
   (call $eosio_assert
    (i32.eq
     (i32.load offset=88
      (tee_local $6
       (call $_ZNK5eosio11multi_indexILy4730634643120193536E9candidateJNS_10indexed_byILy8518361509820596224EN5boost11multi_index13const_mem_funIS1_oXadL_ZNKS1_22get_by_is_cust_and_payEvEEEEEENS2_ILy4591222642450628608ENS5_IS1_yXadL_ZNKS1_15by_number_votesEvEEEEEEEE31load_object_by_primary_iteratorEl
        (get_local $0)
        (get_local $5)
       )
      )
     )
     (get_local $0)
    )
    (i32.const 896)
   )
  )
  (call $eosio_assert
   (i32.ne
    (get_local $6)
    (i32.const 0)
   )
   (get_local $2)
  )
  (get_local $6)
 )
 (func $_ZN5eosio11multi_indexILy4730634643120193536E9candidateJNS_10indexed_byILy8518361509820596224EN5boost11multi_index13const_mem_funIS1_oXadL_ZNKS1_22get_by_is_cust_and_payEvEEEEEENS2_ILy4591222642450628608ENS5_IS1_yXadL_ZNKS1_15by_number_votesEvEEEEEEEE6modifyIZN12daccustodian12updatereqpayENS_4nameENS_5assetEEUlRS1_E_EEvRKS1_yOT_ (param $0 i32) (param $1 i32) (param $2 i64) (param $3 i32)
  (local $4 i32)
  (local $5 i64)
  (local $6 i32)
  (local $7 i64)
  (local $8 i32)
  (i32.store offset=4
   (i32.const 0)
   (tee_local $6
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 96)
    )
   )
  )
  (i64.store offset=80
   (tee_local $8
    (get_local $6)
   )
   (get_local $2)
  )
  (call $eosio_assert
   (i32.eq
    (i32.load offset=88
     (get_local $1)
    )
    (get_local $0)
   )
   (i32.const 608)
  )
  (call $eosio_assert
   (i64.eq
    (i64.load
     (get_local $0)
    )
    (call $current_receiver)
   )
   (i32.const 656)
  )
  (i64.store offset=56
   (get_local $8)
   (i64.const 0)
  )
  (i64.store offset=64
   (get_local $8)
   (i64.load offset=80
    (get_local $1)
   )
  )
  (i64.store offset=48
   (get_local $8)
   (i64.or
    (i64.shl
     (i64.load8_u offset=56
      (get_local $1)
     )
     (i64.const 8)
    )
    (i64.load offset=24
     (get_local $1)
    )
   )
  )
  (i64.store
   (i32.add
    (get_local $1)
    (i32.const 48)
   )
   (i64.load
    (i32.add
     (tee_local $3
      (i32.load
       (get_local $3)
      )
     )
     (i32.const 8)
    )
   )
  )
  (i64.store offset=40
   (get_local $8)
   (tee_local $7
    (i64.load
     (get_local $1)
    )
   )
  )
  (i64.store offset=40
   (get_local $1)
   (i64.load
    (get_local $3)
   )
  )
  (call $eosio_assert
   (i32.const 1)
   (i32.const 720)
  )
  (set_local $3
   (i32.add
    (tee_local $4
     (select
      (i32.load
       (i32.add
        (get_local $1)
        (i32.const 12)
       )
      )
      (i32.shr_u
       (tee_local $3
        (i32.load8_u offset=8
         (get_local $1)
        )
       )
       (i32.const 1)
      )
      (i32.and
       (get_local $3)
       (i32.const 1)
      )
     )
    )
    (i32.const 65)
   )
  )
  (set_local $5
   (i64.extend_u/i32
    (get_local $4)
   )
  )
  (loop $label$0
   (set_local $3
    (i32.add
     (get_local $3)
     (i32.const 1)
    )
   )
   (br_if $label$0
    (i64.ne
     (tee_local $5
      (i64.shr_u
       (get_local $5)
       (i64.const 7)
      )
     )
     (i64.const 0)
    )
   )
  )
  (block $label$1
   (block $label$2
    (br_if $label$2
     (i32.lt_u
      (get_local $3)
      (i32.const 513)
     )
    )
    (set_local $6
     (call $malloc
      (get_local $3)
     )
    )
    (br $label$1)
   )
   (i32.store offset=4
    (i32.const 0)
    (tee_local $6
     (i32.sub
      (get_local $6)
      (i32.and
       (i32.add
        (get_local $3)
        (i32.const 15)
       )
       (i32.const -16)
      )
     )
    )
   )
  )
  (i32.store offset=28
   (get_local $8)
   (get_local $6)
  )
  (i32.store offset=24
   (get_local $8)
   (get_local $6)
  )
  (i32.store offset=32
   (get_local $8)
   (i32.add
    (get_local $6)
    (get_local $3)
   )
  )
  (drop
   (call $_ZlsIN5eosio10datastreamIPcEEERT_S5_RK9candidate
    (i32.add
     (get_local $8)
     (i32.const 24)
    )
    (get_local $1)
   )
  )
  (call $db_update_i64
   (i32.load offset=92
    (get_local $1)
   )
   (get_local $2)
   (get_local $6)
   (get_local $3)
  )
  (block $label$3
   (br_if $label$3
    (i32.lt_u
     (get_local $3)
     (i32.const 513)
    )
   )
   (call $free
    (get_local $6)
   )
   (set_local $7
    (i64.load offset=40
     (get_local $8)
    )
   )
  )
  (set_local $3
   (i32.add
    (get_local $0)
    (i32.const 36)
   )
  )
  (block $label$4
   (br_if $label$4
    (i64.lt_u
     (get_local $7)
     (i64.load offset=16
      (get_local $0)
     )
    )
   )
   (i64.store
    (i32.add
     (get_local $0)
     (i32.const 16)
    )
    (select
     (i64.const -2)
     (i64.add
      (get_local $7)
      (i64.const 1)
     )
     (i64.gt_u
      (get_local $7)
      (i64.const -3)
     )
    )
   )
  )
  (i32.store offset=4
   (get_local $8)
   (get_local $1)
  )
  (i32.store
   (get_local $8)
   (get_local $0)
  )
  (i32.store offset=12
   (get_local $8)
   (get_local $1)
  )
  (i32.store offset=8
   (get_local $8)
   (i32.add
    (get_local $8)
    (i32.const 48)
   )
  )
  (i32.store offset=16
   (get_local $8)
   (i32.add
    (get_local $8)
    (i32.const 40)
   )
  )
  (i32.store offset=20
   (get_local $8)
   (i32.add
    (get_local $8)
    (i32.const 80)
   )
  )
  (i32.store offset=88
   (get_local $8)
   (get_local $8)
  )
  (call $_ZNK5boost4hana6detail7on_eachIPZN5eosio11multi_indexILy4730634643120193536E9candidateJNS3_10indexed_byILy8518361509820596224ENS_11multi_index13const_mem_funIS5_oXadL_ZNKS5_22get_by_is_cust_and_payEvEEEEEENS6_ILy4591222642450628608ENS8_IS5_yXadL_ZNKS5_15by_number_votesEvEEEEEEEE6modifyIZN12daccustodian12updatereqpayENS3_4nameENS3_5assetEEUlRS5_E_EEvRKS5_yOT_EUlRSM_E_EclIJRNS0_5tupleIJNS0_9type_implINSD_5indexILy8518361509820596224ES9_Ly0ELb0EEEE1_ENSU_INSV_ILy8518361509820596224ES9_Ly0ELb1EEEE1_EEEERNST_IJNSU_INSV_ILy4591222642450628608ESB_Ly1ELb0EEEE1_ENSU_INSV_ILy4591222642450628608ESB_Ly1ELb1EEEE1_EEEEEEEvDpOT_
   (i32.add
    (get_local $8)
    (i32.const 88)
   )
   (get_local $3)
   (i32.add
    (get_local $3)
    (i32.const 1)
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $8)
    (i32.const 96)
   )
  )
 )
 (func $_ZNK5boost4hana6detail7on_eachIPZN5eosio11multi_indexILy4730634643120193536E9candidateJNS3_10indexed_byILy8518361509820596224ENS_11multi_index13const_mem_funIS5_oXadL_ZNKS5_22get_by_is_cust_and_payEvEEEEEENS6_ILy4591222642450628608ENS8_IS5_yXadL_ZNKS5_15by_number_votesEvEEEEEEEE6modifyIZN12daccustodian12updatereqpayENS3_4nameENS3_5assetEEUlRS5_E_EEvRKS5_yOT_EUlRSM_E_EclIJRNS0_5tupleIJNS0_9type_implINSD_5indexILy8518361509820596224ES9_Ly0ELb0EEEE1_ENSU_INSV_ILy8518361509820596224ES9_Ly0ELb1EEEE1_EEEERNST_IJNSU_INSV_ILy4591222642450628608ESB_Ly1ELb0EEEE1_ENSU_INSV_ILy4591222642450628608ESB_Ly1ELb1EEEE1_EEEEEEEvDpOT_ (param $0 i32) (param $1 i32) (param $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (i32.store offset=4
   (i32.const 0)
   (tee_local $6
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 32)
    )
   )
  )
  (set_local $4
   (i32.load
    (tee_local $3
     (i32.load
      (get_local $0)
     )
    )
   )
  )
  (set_local $5
   (i32.load offset=4
    (get_local $3)
   )
  )
  (i64.store offset=24
   (get_local $6)
   (i64.const 0)
  )
  (i64.store offset=16
   (get_local $6)
   (i64.or
    (i64.shl
     (i64.load8_u offset=56
      (get_local $5)
     )
     (i64.const 8)
    )
    (i64.load offset=24
     (get_local $5)
    )
   )
  )
  (block $label$0
   (br_if $label$0
    (i32.eqz
     (call $memcmp
      (i32.load offset=8
       (get_local $3)
      )
      (i32.add
       (get_local $6)
       (i32.const 16)
      )
      (i32.const 16)
     )
    )
   )
   (block $label$1
    (br_if $label$1
     (i32.gt_s
      (tee_local $5
       (i32.load offset=96
        (i32.load offset=12
         (get_local $3)
        )
       )
      )
      (i32.const -1)
     )
    )
    (set_local $5
     (call $db_idx128_find_primary
      (i64.load
       (get_local $4)
      )
      (i64.load offset=8
       (get_local $4)
      )
      (i64.const 4730634643120193536)
      (get_local $6)
      (i64.load
       (i32.load offset=16
        (get_local $3)
       )
      )
     )
    )
    (i32.store offset=96
     (i32.load
      (i32.add
       (get_local $3)
       (i32.const 12)
      )
     )
     (get_local $5)
    )
   )
   (call $db_idx128_update
    (get_local $5)
    (i64.load
     (i32.load offset=20
      (get_local $3)
     )
    )
    (i32.add
     (get_local $6)
     (i32.const 16)
    )
   )
  )
  (set_local $5
   (i32.load
    (tee_local $3
     (i32.load
      (get_local $0)
     )
    )
   )
  )
  (i64.store offset=16
   (get_local $6)
   (i64.load offset=80
    (i32.load offset=4
     (get_local $3)
    )
   )
  )
  (block $label$2
   (br_if $label$2
    (i32.eqz
     (call $memcmp
      (i32.add
       (i32.load offset=8
        (get_local $3)
       )
       (i32.const 16)
      )
      (i32.add
       (get_local $6)
       (i32.const 16)
      )
      (i32.const 8)
     )
    )
   )
   (block $label$3
    (br_if $label$3
     (i32.gt_s
      (tee_local $0
       (i32.load
        (i32.add
         (i32.load offset=12
          (get_local $3)
         )
         (i32.const 100)
        )
       )
      )
      (i32.const -1)
     )
    )
    (set_local $0
     (call $db_idx64_find_primary
      (i64.load
       (get_local $5)
      )
      (i64.load offset=8
       (get_local $5)
      )
      (i64.const 4730634643120193537)
      (get_local $6)
      (i64.load
       (i32.load offset=16
        (get_local $3)
       )
      )
     )
    )
    (i32.store
     (i32.add
      (i32.load
       (i32.add
        (get_local $3)
        (i32.const 12)
       )
      )
      (i32.const 100)
     )
     (get_local $0)
    )
   )
   (call $db_idx64_update
    (get_local $0)
    (i64.load
     (i32.load offset=20
      (get_local $3)
     )
    )
    (i32.add
     (get_local $6)
     (i32.const 16)
    )
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $6)
    (i32.const 32)
   )
  )
 )
 (func $_ZN5boost4mp116detail16tuple_apply_implIRZN5eosio14execute_actionI12daccustodianS5_JNS3_4nameENSt3__112basic_stringIcNS7_11char_traitsIcEENS7_9allocatorIcEEEEEEEbPT_MT0_FvDpT1_EEUlDpT_E_RNS7_5tupleIJS6_SD_EEEJLj0ELj1EEEEDTclclsr3stdE7forwardISE_Efp_Espclsr3stdE3getIXT1_EEclsr3stdE7forwardISG_Efp0_EEEEOSE_OSG_NS0_16integer_sequenceIjJXspT1_EEEE (param $0 i32) (param $1 i32)
  (local $2 i64)
  (local $3 i32)
  (local $4 i32)
  (i32.store offset=4
   (i32.const 0)
   (tee_local $4
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 32)
    )
   )
  )
  (set_local $2
   (i64.load
    (get_local $1)
   )
  )
  (drop
   (call $_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC2ERKS5_
    (get_local $4)
    (i32.add
     (get_local $1)
     (i32.const 8)
    )
   )
  )
  (set_local $1
   (i32.add
    (i32.load
     (i32.load
      (get_local $0)
     )
    )
    (i32.shr_s
     (tee_local $3
      (i32.load offset=4
       (tee_local $0
        (i32.load offset=4
         (get_local $0)
        )
       )
      )
     )
     (i32.const 1)
    )
   )
  )
  (set_local $0
   (i32.load
    (get_local $0)
   )
  )
  (block $label$0
   (br_if $label$0
    (i32.eqz
     (i32.and
      (get_local $3)
      (i32.const 1)
     )
    )
   )
   (set_local $0
    (i32.load
     (i32.add
      (i32.load
       (get_local $1)
      )
      (get_local $0)
     )
    )
   )
  )
  (drop
   (call $_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC2ERKS5_
    (i32.add
     (get_local $4)
     (i32.const 16)
    )
    (get_local $4)
   )
  )
  (call_indirect (type $FUNCSIG$viji)
   (get_local $1)
   (get_local $2)
   (i32.add
    (get_local $4)
    (i32.const 16)
   )
   (get_local $0)
  )
  (block $label$1
   (br_if $label$1
    (i32.eqz
     (i32.and
      (i32.load8_u offset=16
       (get_local $4)
      )
      (i32.const 1)
     )
    )
   )
   (call $_ZdlPv
    (i32.load offset=24
     (get_local $4)
    )
   )
  )
  (block $label$2
   (br_if $label$2
    (i32.eqz
     (i32.and
      (i32.load8_u
       (get_local $4)
      )
      (i32.const 1)
     )
    )
   )
   (call $_ZdlPv
    (i32.load offset=8
     (get_local $4)
    )
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $4)
    (i32.const 32)
   )
  )
 )
 (func $_ZN5eosio11multi_indexILy4730634643120193536E9candidateJNS_10indexed_byILy8518361509820596224EN5boost11multi_index13const_mem_funIS1_oXadL_ZNKS1_22get_by_is_cust_and_payEvEEEEEENS2_ILy4591222642450628608ENS5_IS1_yXadL_ZNKS1_15by_number_votesEvEEEEEEEE6modifyIZN12daccustodian9updatebioENS_4nameENSt3__112basic_stringIcNSE_11char_traitsIcEENSE_9allocatorIcEEEEEUlRS1_E_EEvRKS1_yOT_ (param $0 i32) (param $1 i32) (param $2 i64) (param $3 i32)
  (local $4 i32)
  (local $5 i64)
  (local $6 i32)
  (local $7 i64)
  (local $8 i32)
  (i32.store offset=4
   (i32.const 0)
   (tee_local $6
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 96)
    )
   )
  )
  (i64.store offset=80
   (tee_local $8
    (get_local $6)
   )
   (get_local $2)
  )
  (call $eosio_assert
   (i32.eq
    (i32.load offset=88
     (get_local $1)
    )
    (get_local $0)
   )
   (i32.const 608)
  )
  (call $eosio_assert
   (i64.eq
    (i64.load
     (get_local $0)
    )
    (call $current_receiver)
   )
   (i32.const 656)
  )
  (i64.store offset=56
   (get_local $8)
   (i64.const 0)
  )
  (i64.store offset=64
   (get_local $8)
   (i64.load offset=80
    (get_local $1)
   )
  )
  (i64.store offset=48
   (get_local $8)
   (i64.or
    (i64.shl
     (i64.load8_u offset=56
      (get_local $1)
     )
     (i64.const 8)
    )
    (i64.load offset=24
     (get_local $1)
    )
   )
  )
  (i64.store offset=40
   (get_local $8)
   (tee_local $7
    (i64.load
     (get_local $1)
    )
   )
  )
  (drop
   (call $_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEaSERKS5_
    (i32.add
     (get_local $1)
     (i32.const 8)
    )
    (i32.load
     (get_local $3)
    )
   )
  )
  (call $eosio_assert
   (i64.eq
    (get_local $7)
    (i64.load
     (get_local $1)
    )
   )
   (i32.const 720)
  )
  (set_local $3
   (i32.add
    (tee_local $4
     (select
      (i32.load
       (i32.add
        (get_local $1)
        (i32.const 12)
       )
      )
      (i32.shr_u
       (tee_local $3
        (i32.load8_u offset=8
         (get_local $1)
        )
       )
       (i32.const 1)
      )
      (i32.and
       (get_local $3)
       (i32.const 1)
      )
     )
    )
    (i32.const 65)
   )
  )
  (set_local $5
   (i64.extend_u/i32
    (get_local $4)
   )
  )
  (loop $label$0
   (set_local $3
    (i32.add
     (get_local $3)
     (i32.const 1)
    )
   )
   (br_if $label$0
    (i64.ne
     (tee_local $5
      (i64.shr_u
       (get_local $5)
       (i64.const 7)
      )
     )
     (i64.const 0)
    )
   )
  )
  (block $label$1
   (block $label$2
    (br_if $label$2
     (i32.lt_u
      (get_local $3)
      (i32.const 513)
     )
    )
    (set_local $6
     (call $malloc
      (get_local $3)
     )
    )
    (br $label$1)
   )
   (i32.store offset=4
    (i32.const 0)
    (tee_local $6
     (i32.sub
      (get_local $6)
      (i32.and
       (i32.add
        (get_local $3)
        (i32.const 15)
       )
       (i32.const -16)
      )
     )
    )
   )
  )
  (i32.store offset=28
   (get_local $8)
   (get_local $6)
  )
  (i32.store offset=24
   (get_local $8)
   (get_local $6)
  )
  (i32.store offset=32
   (get_local $8)
   (i32.add
    (get_local $6)
    (get_local $3)
   )
  )
  (drop
   (call $_ZlsIN5eosio10datastreamIPcEEERT_S5_RK9candidate
    (i32.add
     (get_local $8)
     (i32.const 24)
    )
    (get_local $1)
   )
  )
  (call $db_update_i64
   (i32.load offset=92
    (get_local $1)
   )
   (get_local $2)
   (get_local $6)
   (get_local $3)
  )
  (block $label$3
   (br_if $label$3
    (i32.lt_u
     (get_local $3)
     (i32.const 513)
    )
   )
   (call $free
    (get_local $6)
   )
   (set_local $7
    (i64.load offset=40
     (get_local $8)
    )
   )
  )
  (set_local $3
   (i32.add
    (get_local $0)
    (i32.const 36)
   )
  )
  (block $label$4
   (br_if $label$4
    (i64.lt_u
     (get_local $7)
     (i64.load offset=16
      (get_local $0)
     )
    )
   )
   (i64.store
    (i32.add
     (get_local $0)
     (i32.const 16)
    )
    (select
     (i64.const -2)
     (i64.add
      (get_local $7)
      (i64.const 1)
     )
     (i64.gt_u
      (get_local $7)
      (i64.const -3)
     )
    )
   )
  )
  (i32.store offset=4
   (get_local $8)
   (get_local $1)
  )
  (i32.store
   (get_local $8)
   (get_local $0)
  )
  (i32.store offset=12
   (get_local $8)
   (get_local $1)
  )
  (i32.store offset=8
   (get_local $8)
   (i32.add
    (get_local $8)
    (i32.const 48)
   )
  )
  (i32.store offset=16
   (get_local $8)
   (i32.add
    (get_local $8)
    (i32.const 40)
   )
  )
  (i32.store offset=20
   (get_local $8)
   (i32.add
    (get_local $8)
    (i32.const 80)
   )
  )
  (i32.store offset=88
   (get_local $8)
   (get_local $8)
  )
  (call $_ZNK5boost4hana6detail7on_eachIPZN5eosio11multi_indexILy4730634643120193536E9candidateJNS3_10indexed_byILy8518361509820596224ENS_11multi_index13const_mem_funIS5_oXadL_ZNKS5_22get_by_is_cust_and_payEvEEEEEENS6_ILy4591222642450628608ENS8_IS5_yXadL_ZNKS5_15by_number_votesEvEEEEEEEE6modifyIZN12daccustodian9updatebioENS3_4nameENSt3__112basic_stringIcNSH_11char_traitsIcEENSH_9allocatorIcEEEEEUlRS5_E_EEvRKS5_yOT_EUlRSS_E_EclIJRNS0_5tupleIJNS0_9type_implINSD_5indexILy8518361509820596224ES9_Ly0ELb0EEEE1_ENS10_INS11_ILy8518361509820596224ES9_Ly0ELb1EEEE1_EEEERNSZ_IJNS10_INS11_ILy4591222642450628608ESB_Ly1ELb0EEEE1_ENS10_INS11_ILy4591222642450628608ESB_Ly1ELb1EEEE1_EEEEEEEvDpOT_
   (i32.add
    (get_local $8)
    (i32.const 88)
   )
   (get_local $3)
   (i32.add
    (get_local $3)
    (i32.const 1)
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $8)
    (i32.const 96)
   )
  )
 )
 (func $_ZNK5boost4hana6detail7on_eachIPZN5eosio11multi_indexILy4730634643120193536E9candidateJNS3_10indexed_byILy8518361509820596224ENS_11multi_index13const_mem_funIS5_oXadL_ZNKS5_22get_by_is_cust_and_payEvEEEEEENS6_ILy4591222642450628608ENS8_IS5_yXadL_ZNKS5_15by_number_votesEvEEEEEEEE6modifyIZN12daccustodian9updatebioENS3_4nameENSt3__112basic_stringIcNSH_11char_traitsIcEENSH_9allocatorIcEEEEEUlRS5_E_EEvRKS5_yOT_EUlRSS_E_EclIJRNS0_5tupleIJNS0_9type_implINSD_5indexILy8518361509820596224ES9_Ly0ELb0EEEE1_ENS10_INS11_ILy8518361509820596224ES9_Ly0ELb1EEEE1_EEEERNSZ_IJNS10_INS11_ILy4591222642450628608ESB_Ly1ELb0EEEE1_ENS10_INS11_ILy4591222642450628608ESB_Ly1ELb1EEEE1_EEEEEEEvDpOT_ (param $0 i32) (param $1 i32) (param $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (i32.store offset=4
   (i32.const 0)
   (tee_local $6
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 32)
    )
   )
  )
  (set_local $4
   (i32.load
    (tee_local $3
     (i32.load
      (get_local $0)
     )
    )
   )
  )
  (set_local $5
   (i32.load offset=4
    (get_local $3)
   )
  )
  (i64.store offset=24
   (get_local $6)
   (i64.const 0)
  )
  (i64.store offset=16
   (get_local $6)
   (i64.or
    (i64.shl
     (i64.load8_u offset=56
      (get_local $5)
     )
     (i64.const 8)
    )
    (i64.load offset=24
     (get_local $5)
    )
   )
  )
  (block $label$0
   (br_if $label$0
    (i32.eqz
     (call $memcmp
      (i32.load offset=8
       (get_local $3)
      )
      (i32.add
       (get_local $6)
       (i32.const 16)
      )
      (i32.const 16)
     )
    )
   )
   (block $label$1
    (br_if $label$1
     (i32.gt_s
      (tee_local $5
       (i32.load offset=96
        (i32.load offset=12
         (get_local $3)
        )
       )
      )
      (i32.const -1)
     )
    )
    (set_local $5
     (call $db_idx128_find_primary
      (i64.load
       (get_local $4)
      )
      (i64.load offset=8
       (get_local $4)
      )
      (i64.const 4730634643120193536)
      (get_local $6)
      (i64.load
       (i32.load offset=16
        (get_local $3)
       )
      )
     )
    )
    (i32.store offset=96
     (i32.load
      (i32.add
       (get_local $3)
       (i32.const 12)
      )
     )
     (get_local $5)
    )
   )
   (call $db_idx128_update
    (get_local $5)
    (i64.load
     (i32.load offset=20
      (get_local $3)
     )
    )
    (i32.add
     (get_local $6)
     (i32.const 16)
    )
   )
  )
  (set_local $5
   (i32.load
    (tee_local $3
     (i32.load
      (get_local $0)
     )
    )
   )
  )
  (i64.store offset=16
   (get_local $6)
   (i64.load offset=80
    (i32.load offset=4
     (get_local $3)
    )
   )
  )
  (block $label$2
   (br_if $label$2
    (i32.eqz
     (call $memcmp
      (i32.add
       (i32.load offset=8
        (get_local $3)
       )
       (i32.const 16)
      )
      (i32.add
       (get_local $6)
       (i32.const 16)
      )
      (i32.const 8)
     )
    )
   )
   (block $label$3
    (br_if $label$3
     (i32.gt_s
      (tee_local $0
       (i32.load
        (i32.add
         (i32.load offset=12
          (get_local $3)
         )
         (i32.const 100)
        )
       )
      )
      (i32.const -1)
     )
    )
    (set_local $0
     (call $db_idx64_find_primary
      (i64.load
       (get_local $5)
      )
      (i64.load offset=8
       (get_local $5)
      )
      (i64.const 4730634643120193537)
      (get_local $6)
      (i64.load
       (i32.load offset=16
        (get_local $3)
       )
      )
     )
    )
    (i32.store
     (i32.add
      (i32.load
       (i32.add
        (get_local $3)
        (i32.const 12)
       )
      )
      (i32.const 100)
     )
     (get_local $0)
    )
   )
   (call $db_idx64_update
    (get_local $0)
    (i64.load
     (i32.load offset=20
      (get_local $3)
     )
    )
    (i32.add
     (get_local $6)
     (i32.const 16)
    )
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $6)
    (i32.const 32)
   )
  )
 )
 (func $_ZN5eosio11multi_indexILy4730634643120193536E9candidateJNS_10indexed_byILy8518361509820596224EN5boost11multi_index13const_mem_funIS1_oXadL_ZNKS1_22get_by_is_cust_and_payEvEEEEEENS2_ILy4591222642450628608ENS5_IS1_yXadL_ZNKS1_15by_number_votesEvEEEEEEEE5eraseERKS1_ (param $0 i32) (param $1 i32)
  (local $2 i64)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (local $8 i32)
  (local $9 i32)
  (i32.store offset=4
   (i32.const 0)
   (tee_local $9
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 16)
    )
   )
  )
  (call $eosio_assert
   (i32.eq
    (i32.load offset=88
     (get_local $1)
    )
    (get_local $0)
   )
   (i32.const 256)
  )
  (call $eosio_assert
   (i64.eq
    (i64.load
     (get_local $0)
    )
    (call $current_receiver)
   )
   (i32.const 304)
  )
  (block $label$0
   (br_if $label$0
    (i32.eq
     (tee_local $7
      (i32.load
       (tee_local $5
        (i32.add
         (get_local $0)
         (i32.const 28)
        )
       )
      )
     )
     (tee_local $3
      (i32.load offset=24
       (get_local $0)
      )
     )
    )
   )
   (set_local $2
    (i64.load
     (get_local $1)
    )
   )
   (set_local $6
    (i32.sub
     (i32.const 0)
     (get_local $3)
    )
   )
   (set_local $8
    (i32.add
     (get_local $7)
     (i32.const -24)
    )
   )
   (loop $label$1
    (br_if $label$0
     (i64.eq
      (i64.load
       (i32.load
        (get_local $8)
       )
      )
      (get_local $2)
     )
    )
    (set_local $7
     (get_local $8)
    )
    (set_local $8
     (tee_local $4
      (i32.add
       (get_local $8)
       (i32.const -24)
      )
     )
    )
    (br_if $label$1
     (i32.ne
      (i32.add
       (get_local $4)
       (get_local $6)
      )
      (i32.const -24)
     )
    )
   )
  )
  (call $eosio_assert
   (i32.ne
    (get_local $7)
    (get_local $3)
   )
   (i32.const 368)
  )
  (set_local $8
   (i32.add
    (get_local $7)
    (i32.const -24)
   )
  )
  (block $label$2
   (block $label$3
    (br_if $label$3
     (i32.eq
      (get_local $7)
      (tee_local $4
       (i32.load
        (get_local $5)
       )
      )
     )
    )
    (set_local $3
     (i32.sub
      (i32.const 0)
      (get_local $4)
     )
    )
    (set_local $7
     (get_local $8)
    )
    (loop $label$4
     (set_local $6
      (i32.load
       (tee_local $8
        (i32.add
         (get_local $7)
         (i32.const 24)
        )
       )
      )
     )
     (i32.store
      (get_local $8)
      (i32.const 0)
     )
     (set_local $4
      (i32.load
       (get_local $7)
      )
     )
     (i32.store
      (get_local $7)
      (get_local $6)
     )
     (block $label$5
      (br_if $label$5
       (i32.eqz
        (get_local $4)
       )
      )
      (block $label$6
       (br_if $label$6
        (i32.eqz
         (i32.and
          (i32.load8_u offset=8
           (get_local $4)
          )
          (i32.const 1)
         )
        )
       )
       (call $_ZdlPv
        (i32.load
         (i32.add
          (get_local $4)
          (i32.const 16)
         )
        )
       )
      )
      (call $_ZdlPv
       (get_local $4)
      )
     )
     (i32.store
      (i32.add
       (get_local $7)
       (i32.const 16)
      )
      (i32.load
       (i32.add
        (get_local $7)
        (i32.const 40)
       )
      )
     )
     (i64.store
      (i32.add
       (get_local $7)
       (i32.const 8)
      )
      (i64.load
       (i32.add
        (get_local $7)
        (i32.const 32)
       )
      )
     )
     (set_local $7
      (get_local $8)
     )
     (br_if $label$4
      (i32.ne
       (i32.add
        (get_local $8)
        (get_local $3)
       )
       (i32.const -24)
      )
     )
    )
    (br_if $label$2
     (i32.eq
      (tee_local $7
       (i32.load
        (i32.add
         (get_local $0)
         (i32.const 28)
        )
       )
      )
      (get_local $8)
     )
    )
   )
   (loop $label$7
    (set_local $4
     (i32.load
      (tee_local $7
       (i32.add
        (get_local $7)
        (i32.const -24)
       )
      )
     )
    )
    (i32.store
     (get_local $7)
     (i32.const 0)
    )
    (block $label$8
     (br_if $label$8
      (i32.eqz
       (get_local $4)
      )
     )
     (block $label$9
      (br_if $label$9
       (i32.eqz
        (i32.and
         (i32.load8_u offset=8
          (get_local $4)
         )
         (i32.const 1)
        )
       )
      )
      (call $_ZdlPv
       (i32.load
        (i32.add
         (get_local $4)
         (i32.const 16)
        )
       )
      )
     )
     (call $_ZdlPv
      (get_local $4)
     )
    )
    (br_if $label$7
     (i32.ne
      (get_local $8)
      (get_local $7)
     )
    )
   )
  )
  (i32.store
   (i32.add
    (get_local $0)
    (i32.const 28)
   )
   (get_local $8)
  )
  (call $db_remove_i64
   (i32.load offset=92
    (get_local $1)
   )
  )
  (block $label$10
   (block $label$11
    (br_if $label$11
     (i32.gt_s
      (tee_local $7
       (i32.load
        (i32.add
         (get_local $1)
         (i32.const 96)
        )
       )
      )
      (i32.const -1)
     )
    )
    (br_if $label$10
     (i32.lt_s
      (tee_local $7
       (call $db_idx128_find_primary
        (i64.load
         (get_local $0)
        )
        (i64.load offset=8
         (get_local $0)
        )
        (i64.const 4730634643120193536)
        (get_local $9)
        (i64.load
         (get_local $1)
        )
       )
      )
      (i32.const 0)
     )
    )
   )
   (call $db_idx128_remove
    (get_local $7)
   )
  )
  (block $label$12
   (block $label$13
    (br_if $label$13
     (i32.gt_s
      (tee_local $7
       (i32.load
        (i32.add
         (get_local $1)
         (i32.const 100)
        )
       )
      )
      (i32.const -1)
     )
    )
    (br_if $label$12
     (i32.lt_s
      (tee_local $7
       (call $db_idx64_find_primary
        (i64.load
         (get_local $0)
        )
        (i64.load offset=8
         (get_local $0)
        )
        (i64.const 4730634643120193537)
        (get_local $9)
        (i64.load
         (get_local $1)
        )
       )
      )
      (i32.const 0)
     )
    )
   )
   (call $db_idx64_remove
    (get_local $7)
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $9)
    (i32.const 16)
   )
  )
 )
 (func $_ZN5eosio11multi_indexILy12296682192053436416E3payJEE7emplaceIZN12daccustodian9unregcandENS_4nameEEUlRS1_E_EENS2_14const_iteratorEyOT_ (param $0 i32) (param $1 i32) (param $2 i64) (param $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (i32.store offset=4
   (i32.const 0)
   (tee_local $7
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 48)
    )
   )
  )
  (i64.store offset=40
   (get_local $7)
   (get_local $2)
  )
  (call $eosio_assert
   (i64.eq
    (i64.load
     (get_local $1)
    )
    (call $current_receiver)
   )
   (i32.const 1008)
  )
  (i32.store offset=20
   (get_local $7)
   (get_local $3)
  )
  (i32.store offset=16
   (get_local $7)
   (get_local $1)
  )
  (i32.store offset=24
   (get_local $7)
   (i32.add
    (get_local $7)
    (i32.const 40)
   )
  )
  (i64.store offset=8
   (tee_local $4
    (call $_Znwj
     (i32.const 48)
    )
   )
   (i64.const 0)
  )
  (i64.store
   (get_local $4)
   (i64.const 0)
  )
  (i64.store offset=16
   (get_local $4)
   (i64.const 1398362884)
  )
  (call $eosio_assert
   (i32.const 1)
   (i32.const 480)
  )
  (set_local $2
   (i64.const 5462355)
  )
  (set_local $3
   (i32.const 0)
  )
  (block $label$0
   (block $label$1
    (loop $label$2
     (br_if $label$1
      (i32.gt_u
       (i32.add
        (i32.shl
         (i32.wrap/i64
          (get_local $2)
         )
         (i32.const 24)
        )
        (i32.const -1073741825)
       )
       (i32.const 452984830)
      )
     )
     (block $label$3
      (br_if $label$3
       (i64.ne
        (i64.and
         (tee_local $2
          (i64.shr_u
           (get_local $2)
           (i64.const 8)
          )
         )
         (i64.const 255)
        )
        (i64.const 0)
       )
      )
      (loop $label$4
       (br_if $label$1
        (i64.ne
         (i64.and
          (tee_local $2
           (i64.shr_u
            (get_local $2)
            (i64.const 8)
           )
          )
          (i64.const 255)
         )
         (i64.const 0)
        )
       )
       (br_if $label$4
        (i32.lt_s
         (tee_local $3
          (i32.add
           (get_local $3)
           (i32.const 1)
          )
         )
         (i32.const 7)
        )
       )
      )
     )
     (set_local $6
      (i32.const 1)
     )
     (br_if $label$2
      (i32.lt_s
       (tee_local $3
        (i32.add
         (get_local $3)
         (i32.const 1)
        )
       )
       (i32.const 7)
      )
     )
     (br $label$0)
    )
   )
   (set_local $6
    (i32.const 0)
   )
  )
  (call $eosio_assert
   (get_local $6)
   (i32.const 544)
  )
  (i32.store offset=32
   (get_local $4)
   (i32.const 0)
  )
  (i64.store offset=24 align=4
   (get_local $4)
   (i64.const 0)
  )
  (i32.store offset=36
   (get_local $4)
   (get_local $1)
  )
  (call $_ZZN5eosio11multi_indexILy12296682192053436416E3payJEE7emplaceIZN12daccustodian9unregcandENS_4nameEEUlRS1_E_EENS2_14const_iteratorEyOT_ENKUlRS9_E_clINS2_4itemEEEDaSB_
   (i32.add
    (get_local $7)
    (i32.const 16)
   )
   (get_local $4)
  )
  (i32.store offset=32
   (get_local $7)
   (get_local $4)
  )
  (i64.store offset=16
   (get_local $7)
   (tee_local $2
    (i64.load
     (get_local $4)
    )
   )
  )
  (i32.store offset=12
   (get_local $7)
   (tee_local $6
    (i32.load offset=40
     (get_local $4)
    )
   )
  )
  (block $label$5
   (block $label$6
    (br_if $label$6
     (i32.ge_u
      (tee_local $3
       (i32.load
        (tee_local $5
         (i32.add
          (get_local $1)
          (i32.const 28)
         )
        )
       )
      )
      (i32.load
       (i32.add
        (get_local $1)
        (i32.const 32)
       )
      )
     )
    )
    (i64.store offset=8
     (get_local $3)
     (get_local $2)
    )
    (i32.store offset=16
     (get_local $3)
     (get_local $6)
    )
    (i32.store offset=32
     (get_local $7)
     (i32.const 0)
    )
    (i32.store
     (get_local $3)
     (get_local $4)
    )
    (i32.store
     (get_local $5)
     (i32.add
      (get_local $3)
      (i32.const 24)
     )
    )
    (br $label$5)
   )
   (call $_ZNSt3__16vectorIN5eosio11multi_indexILy12296682192053436416E3payJEE8item_ptrENS_9allocatorIS5_EEE24__emplace_back_slow_pathIJNS_10unique_ptrINS4_4itemENS_14default_deleteISB_EEEERyRlEEEvDpOT_
    (i32.add
     (get_local $1)
     (i32.const 24)
    )
    (i32.add
     (get_local $7)
     (i32.const 32)
    )
    (i32.add
     (get_local $7)
     (i32.const 16)
    )
    (i32.add
     (get_local $7)
     (i32.const 12)
    )
   )
  )
  (i32.store offset=4
   (get_local $0)
   (get_local $4)
  )
  (i32.store
   (get_local $0)
   (get_local $1)
  )
  (set_local $3
   (i32.load offset=32
    (get_local $7)
   )
  )
  (i32.store offset=32
   (get_local $7)
   (i32.const 0)
  )
  (block $label$7
   (br_if $label$7
    (i32.eqz
     (get_local $3)
    )
   )
   (block $label$8
    (br_if $label$8
     (i32.eqz
      (i32.and
       (i32.load8_u offset=24
        (get_local $3)
       )
       (i32.const 1)
      )
     )
    )
    (call $_ZdlPv
     (i32.load
      (i32.add
       (get_local $3)
       (i32.const 32)
      )
     )
    )
   )
   (call $_ZdlPv
    (get_local $3)
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $7)
    (i32.const 48)
   )
  )
 )
 (func $_ZZN5eosio11multi_indexILy12296682192053436416E3payJEE7emplaceIZN12daccustodian9unregcandENS_4nameEEUlRS1_E_EENS2_14const_iteratorEyOT_ENKUlRS9_E_clINS2_4itemEEEDaSB_ (param $0 i32) (param $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (local $8 i64)
  (local $9 i32)
  (local $10 i32)
  (set_local $10
   (tee_local $9
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 16)
    )
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (get_local $9)
  )
  (set_local $2
   (i32.load
    (get_local $0)
   )
  )
  (i64.store
   (get_local $1)
   (i64.load
    (i32.load
     (tee_local $7
      (i32.load offset=4
       (get_local $0)
      )
     )
    )
   )
  )
  (i64.store offset=8
   (get_local $1)
   (i64.load offset=64
    (tee_local $7
     (i32.load offset=4
      (get_local $7)
     )
    )
   )
  )
  (i64.store
   (i32.add
    (get_local $1)
    (i32.const 16)
   )
   (i64.load
    (i32.add
     (get_local $7)
     (i32.const 72)
    )
   )
  )
  (drop
   (call $_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE6assignEPKc
    (tee_local $4
     (i32.add
      (get_local $1)
      (i32.const 24)
     )
    )
    (i32.const 1744)
   )
  )
  (set_local $7
   (i32.add
    (tee_local $5
     (select
      (i32.load
       (i32.add
        (get_local $1)
        (i32.const 28)
       )
      )
      (i32.shr_u
       (tee_local $7
        (i32.load8_u offset=24
         (get_local $1)
        )
       )
       (i32.const 1)
      )
      (i32.and
       (get_local $7)
       (i32.const 1)
      )
     )
    )
    (i32.const 24)
   )
  )
  (set_local $8
   (i64.extend_u/i32
    (get_local $5)
   )
  )
  (set_local $3
   (i32.add
    (get_local $1)
    (i32.const 8)
   )
  )
  (loop $label$0
   (set_local $7
    (i32.add
     (get_local $7)
     (i32.const 1)
    )
   )
   (br_if $label$0
    (i64.ne
     (tee_local $8
      (i64.shr_u
       (get_local $8)
       (i64.const 7)
      )
     )
     (i64.const 0)
    )
   )
  )
  (block $label$1
   (block $label$2
    (br_if $label$2
     (i32.lt_u
      (get_local $7)
      (i32.const 513)
     )
    )
    (set_local $9
     (call $malloc
      (get_local $7)
     )
    )
    (br $label$1)
   )
   (i32.store offset=4
    (i32.const 0)
    (tee_local $9
     (i32.sub
      (get_local $9)
      (i32.and
       (i32.add
        (get_local $7)
        (i32.const 15)
       )
       (i32.const -16)
      )
     )
    )
   )
  )
  (i32.store
   (get_local $10)
   (get_local $9)
  )
  (i32.store offset=8
   (get_local $10)
   (tee_local $5
    (i32.add
     (get_local $9)
     (get_local $7)
    )
   )
  )
  (call $eosio_assert
   (i32.gt_s
    (get_local $7)
    (i32.const 7)
   )
   (i32.const 432)
  )
  (drop
   (call $memcpy
    (get_local $9)
    (get_local $1)
    (i32.const 8)
   )
  )
  (call $eosio_assert
   (i32.gt_s
    (i32.sub
     (get_local $5)
     (tee_local $6
      (i32.add
       (get_local $9)
       (i32.const 8)
      )
     )
    )
    (i32.const 7)
   )
   (i32.const 432)
  )
  (drop
   (call $memcpy
    (get_local $6)
    (get_local $3)
    (i32.const 8)
   )
  )
  (call $eosio_assert
   (i32.gt_s
    (i32.sub
     (get_local $5)
     (tee_local $3
      (i32.add
       (get_local $9)
       (i32.const 16)
      )
     )
    )
    (i32.const 7)
   )
   (i32.const 432)
  )
  (drop
   (call $memcpy
    (get_local $3)
    (i32.add
     (get_local $1)
     (i32.const 16)
    )
    (i32.const 8)
   )
  )
  (i32.store offset=4
   (get_local $10)
   (i32.add
    (get_local $9)
    (i32.const 24)
   )
  )
  (drop
   (call $_ZN5eosiolsINS_10datastreamIPcEEEERT_S5_RKNSt3__112basic_stringIcNS6_11char_traitsIcEENS6_9allocatorIcEEEE
    (get_local $10)
    (get_local $4)
   )
  )
  (i32.store offset=40
   (get_local $1)
   (call $db_store_i64
    (i64.load offset=8
     (get_local $2)
    )
    (i64.const -6150061881656115200)
    (i64.load
     (i32.load offset=8
      (get_local $0)
     )
    )
    (tee_local $8
     (i64.load
      (get_local $1)
     )
    )
    (get_local $9)
    (get_local $7)
   )
  )
  (block $label$3
   (br_if $label$3
    (i32.lt_u
     (get_local $7)
     (i32.const 513)
    )
   )
   (call $free
    (get_local $9)
   )
  )
  (block $label$4
   (br_if $label$4
    (i64.lt_u
     (get_local $8)
     (i64.load offset=16
      (get_local $2)
     )
    )
   )
   (i64.store
    (i32.add
     (get_local $2)
     (i32.const 16)
    )
    (select
     (i64.const -2)
     (i64.add
      (get_local $8)
      (i64.const 1)
     )
     (i64.gt_u
      (get_local $8)
      (i64.const -3)
     )
    )
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $10)
    (i32.const 16)
   )
  )
 )
 (func $_ZN5boost4mp116detail16tuple_apply_implIRZN5eosio14execute_actionI12daccustodianS5_JNS3_4nameENSt3__112basic_stringIcNS7_11char_traitsIcEENS7_9allocatorIcEEEENS3_5assetEEEEbPT_MT0_FvDpT1_EEUlDpT_E_RNS7_5tupleIJS6_SD_SE_EEEJLj0ELj1ELj2EEEEDTclclsr3stdE7forwardISF_Efp_Espclsr3stdE3getIXT1_EEclsr3stdE7forwardISH_Efp0_EEEEOSF_OSH_NS0_16integer_sequenceIjJXspT1_EEEE (param $0 i32) (param $1 i32)
  (local $2 i64)
  (local $3 i32)
  (local $4 i64)
  (local $5 i32)
  (i32.store offset=4
   (i32.const 0)
   (tee_local $5
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 96)
    )
   )
  )
  (set_local $2
   (i64.load
    (get_local $1)
   )
  )
  (drop
   (call $_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC2ERKS5_
    (i32.add
     (get_local $5)
     (i32.const 32)
    )
    (i32.add
     (get_local $1)
     (i32.const 8)
    )
   )
  )
  (i64.store
   (tee_local $3
    (i32.add
     (i32.add
      (get_local $5)
      (i32.const 16)
     )
     (i32.const 8)
    )
   )
   (i64.load
    (i32.add
     (get_local $1)
     (i32.const 32)
    )
   )
  )
  (i64.store offset=16
   (get_local $5)
   (i64.load offset=24
    (get_local $1)
   )
  )
  (i64.store
   (i32.add
    (i32.add
     (get_local $5)
     (i32.const 48)
    )
    (i32.const 8)
   )
   (i64.load
    (get_local $3)
   )
  )
  (i64.store offset=48
   (get_local $5)
   (i64.load offset=16
    (get_local $5)
   )
  )
  (set_local $0
   (i32.add
    (i32.load
     (i32.load
      (get_local $0)
     )
    )
    (i32.shr_s
     (tee_local $3
      (i32.load offset=4
       (tee_local $1
        (i32.load offset=4
         (get_local $0)
        )
       )
      )
     )
     (i32.const 1)
    )
   )
  )
  (set_local $1
   (i32.load
    (get_local $1)
   )
  )
  (block $label$0
   (br_if $label$0
    (i32.eqz
     (i32.and
      (get_local $3)
      (i32.const 1)
     )
    )
   )
   (set_local $1
    (i32.load
     (i32.add
      (i32.load
       (get_local $0)
      )
      (get_local $1)
     )
    )
   )
  )
  (drop
   (call $_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC2ERKS5_
    (i32.add
     (get_local $5)
     (i32.const 80)
    )
    (i32.add
     (get_local $5)
     (i32.const 32)
    )
   )
  )
  (i64.store
   (i32.add
    (i32.add
     (get_local $5)
     (i32.const 64)
    )
    (i32.const 8)
   )
   (tee_local $4
    (i64.load
     (i32.add
      (i32.add
       (get_local $5)
       (i32.const 48)
      )
      (i32.const 8)
     )
    )
   )
  )
  (i64.store
   (i32.add
    (get_local $5)
    (i32.const 8)
   )
   (get_local $4)
  )
  (i64.store offset=64
   (get_local $5)
   (tee_local $4
    (i64.load offset=48
     (get_local $5)
    )
   )
  )
  (i64.store
   (get_local $5)
   (get_local $4)
  )
  (call_indirect (type $FUNCSIG$vijii)
   (get_local $0)
   (get_local $2)
   (i32.add
    (get_local $5)
    (i32.const 80)
   )
   (get_local $5)
   (get_local $1)
  )
  (block $label$1
   (br_if $label$1
    (i32.eqz
     (i32.and
      (i32.load8_u offset=80
       (get_local $5)
      )
      (i32.const 1)
     )
    )
   )
   (call $_ZdlPv
    (i32.load offset=88
     (get_local $5)
    )
   )
  )
  (block $label$2
   (br_if $label$2
    (i32.eqz
     (i32.and
      (i32.load8_u offset=32
       (get_local $5)
      )
      (i32.const 1)
     )
    )
   )
   (call $_ZdlPv
    (i32.load offset=40
     (get_local $5)
    )
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $5)
    (i32.const 96)
   )
  )
 )
 (func $_ZN5boost6fusion6detail17for_each_unrolledILi4EE4callINS0_18std_tuple_iteratorIKNSt3__15tupleIJN5eosio4nameEyNS8_5assetENS6_12basic_stringIcNS6_11char_traitsIcEENS6_9allocatorIcEEEEEEELi0EEEZNS8_lsINS8_10datastreamIPcEEJS9_ySA_SG_EEERT_SP_RKNS7_IJDpT0_EEEEUlRKSO_E_EEvSW_RKT0_ (param $0 i32) (param $1 i32)
  (local $2 i32)
  (local $3 i32)
  (set_local $2
   (i32.load
    (get_local $0)
   )
  )
  (call $eosio_assert
   (i32.gt_s
    (i32.sub
     (i32.load offset=8
      (tee_local $3
       (i32.load
        (get_local $1)
       )
      )
     )
     (i32.load offset=4
      (get_local $3)
     )
    )
    (i32.const 7)
   )
   (i32.const 432)
  )
  (drop
   (call $memcpy
    (i32.load offset=4
     (get_local $3)
    )
    (get_local $2)
    (i32.const 8)
   )
  )
  (i32.store offset=4
   (get_local $3)
   (i32.add
    (i32.load offset=4
     (get_local $3)
    )
    (i32.const 8)
   )
  )
  (set_local $0
   (i32.load
    (get_local $0)
   )
  )
  (call $eosio_assert
   (i32.gt_s
    (i32.sub
     (i32.load offset=8
      (tee_local $3
       (i32.load
        (get_local $1)
       )
      )
     )
     (i32.load offset=4
      (get_local $3)
     )
    )
    (i32.const 7)
   )
   (i32.const 432)
  )
  (drop
   (call $memcpy
    (i32.load offset=4
     (get_local $3)
    )
    (i32.add
     (get_local $0)
     (i32.const 8)
    )
    (i32.const 8)
   )
  )
  (i32.store offset=4
   (get_local $3)
   (i32.add
    (i32.load offset=4
     (get_local $3)
    )
    (i32.const 8)
   )
  )
  (call $eosio_assert
   (i32.gt_s
    (i32.sub
     (i32.load offset=8
      (tee_local $3
       (i32.load
        (get_local $1)
       )
      )
     )
     (i32.load offset=4
      (get_local $3)
     )
    )
    (i32.const 7)
   )
   (i32.const 432)
  )
  (drop
   (call $memcpy
    (i32.load offset=4
     (get_local $3)
    )
    (i32.add
     (get_local $0)
     (i32.const 16)
    )
    (i32.const 8)
   )
  )
  (i32.store offset=4
   (get_local $3)
   (tee_local $2
    (i32.add
     (i32.load offset=4
      (get_local $3)
     )
     (i32.const 8)
    )
   )
  )
  (call $eosio_assert
   (i32.gt_s
    (i32.sub
     (i32.load offset=8
      (get_local $3)
     )
     (get_local $2)
    )
    (i32.const 7)
   )
   (i32.const 432)
  )
  (drop
   (call $memcpy
    (i32.load offset=4
     (get_local $3)
    )
    (i32.add
     (get_local $0)
     (i32.const 24)
    )
    (i32.const 8)
   )
  )
  (i32.store offset=4
   (get_local $3)
   (i32.add
    (i32.load offset=4
     (get_local $3)
    )
    (i32.const 8)
   )
  )
  (drop
   (call $_ZN5eosiolsINS_10datastreamIPcEEEERT_S5_RKNSt3__112basic_stringIcNS6_11char_traitsIcEENS6_9allocatorIcEEEE
    (i32.load
     (get_local $1)
    )
    (i32.add
     (get_local $0)
     (i32.const 32)
    )
   )
  )
 )
 (func $_ZN5eosio11multi_indexILy4730634643120193536E9candidateJNS_10indexed_byILy8518361509820596224EN5boost11multi_index13const_mem_funIS1_oXadL_ZNKS1_22get_by_is_cust_and_payEvEEEEEENS2_ILy4591222642450628608ENS5_IS1_yXadL_ZNKS1_15by_number_votesEvEEEEEEEE7emplaceIZN12daccustodian12regcandidateENS_4nameENSt3__112basic_stringIcNSE_11char_traitsIcEENSE_9allocatorIcEEEENS_5assetEEUlRS1_E_EENSA_14const_iteratorEyOT_ (param $0 i32) (param $1 i32) (param $2 i64) (param $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (i32.store offset=4
   (i32.const 0)
   (tee_local $7
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 48)
    )
   )
  )
  (i64.store offset=40
   (get_local $7)
   (get_local $2)
  )
  (call $eosio_assert
   (i64.eq
    (i64.load
     (get_local $1)
    )
    (call $current_receiver)
   )
   (i32.const 1008)
  )
  (i32.store offset=20
   (get_local $7)
   (get_local $3)
  )
  (i32.store offset=16
   (get_local $7)
   (get_local $1)
  )
  (i32.store offset=24
   (get_local $7)
   (i32.add
    (get_local $7)
    (i32.const 40)
   )
  )
  (drop
   (call $_ZN9candidateC2Ev
    (tee_local $3
     (call $_Znwj
      (i32.const 104)
     )
    )
   )
  )
  (i32.store offset=88
   (get_local $3)
   (get_local $1)
  )
  (call $_ZZN5eosio11multi_indexILy4730634643120193536E9candidateJNS_10indexed_byILy8518361509820596224EN5boost11multi_index13const_mem_funIS1_oXadL_ZNKS1_22get_by_is_cust_and_payEvEEEEEENS2_ILy4591222642450628608ENS5_IS1_yXadL_ZNKS1_15by_number_votesEvEEEEEEEE7emplaceIZN12daccustodian12regcandidateENS_4nameENSt3__112basic_stringIcNSE_11char_traitsIcEENSE_9allocatorIcEEEENS_5assetEEUlRS1_E_EENSA_14const_iteratorEyOT_ENKUlRSP_E_clINSA_4itemEEEDaSR_
   (i32.add
    (get_local $7)
    (i32.const 16)
   )
   (get_local $3)
  )
  (i32.store offset=32
   (get_local $7)
   (get_local $3)
  )
  (i64.store offset=16
   (get_local $7)
   (tee_local $2
    (i64.load
     (get_local $3)
    )
   )
  )
  (i32.store offset=12
   (get_local $7)
   (tee_local $4
    (i32.load offset=92
     (get_local $3)
    )
   )
  )
  (block $label$0
   (block $label$1
    (br_if $label$1
     (i32.ge_u
      (tee_local $5
       (i32.load
        (tee_local $6
         (i32.add
          (get_local $1)
          (i32.const 28)
         )
        )
       )
      )
      (i32.load
       (i32.add
        (get_local $1)
        (i32.const 32)
       )
      )
     )
    )
    (i64.store offset=8
     (get_local $5)
     (get_local $2)
    )
    (i32.store offset=16
     (get_local $5)
     (get_local $4)
    )
    (i32.store offset=32
     (get_local $7)
     (i32.const 0)
    )
    (i32.store
     (get_local $5)
     (get_local $3)
    )
    (i32.store
     (get_local $6)
     (i32.add
      (get_local $5)
      (i32.const 24)
     )
    )
    (br $label$0)
   )
   (call $_ZNSt3__16vectorIN5eosio11multi_indexILy4730634643120193536E9candidateJNS1_10indexed_byILy8518361509820596224EN5boost11multi_index13const_mem_funIS3_oXadL_ZNKS3_22get_by_is_cust_and_payEvEEEEEENS4_ILy4591222642450628608ENS7_IS3_yXadL_ZNKS3_15by_number_votesEvEEEEEEEE8item_ptrENS_9allocatorISD_EEE24__emplace_back_slow_pathIJNS_10unique_ptrINSC_4itemENS_14default_deleteISJ_EEEERNS1_4nameERlEEEvDpOT_
    (i32.add
     (get_local $1)
     (i32.const 24)
    )
    (i32.add
     (get_local $7)
     (i32.const 32)
    )
    (i32.add
     (get_local $7)
     (i32.const 16)
    )
    (i32.add
     (get_local $7)
     (i32.const 12)
    )
   )
  )
  (i32.store offset=4
   (get_local $0)
   (get_local $3)
  )
  (i32.store
   (get_local $0)
   (get_local $1)
  )
  (set_local $1
   (i32.load offset=32
    (get_local $7)
   )
  )
  (i32.store offset=32
   (get_local $7)
   (i32.const 0)
  )
  (block $label$2
   (br_if $label$2
    (i32.eqz
     (get_local $1)
    )
   )
   (block $label$3
    (br_if $label$3
     (i32.eqz
      (i32.and
       (i32.load8_u offset=8
        (get_local $1)
       )
       (i32.const 1)
      )
     )
    )
    (call $_ZdlPv
     (i32.load
      (i32.add
       (get_local $1)
       (i32.const 16)
      )
     )
    )
   )
   (call $_ZdlPv
    (get_local $1)
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $7)
    (i32.const 48)
   )
  )
 )
 (func $_ZZN5eosio11multi_indexILy4730634643120193536E9candidateJNS_10indexed_byILy8518361509820596224EN5boost11multi_index13const_mem_funIS1_oXadL_ZNKS1_22get_by_is_cust_and_payEvEEEEEENS2_ILy4591222642450628608ENS5_IS1_yXadL_ZNKS1_15by_number_votesEvEEEEEEEE7emplaceIZN12daccustodian12regcandidateENS_4nameENSt3__112basic_stringIcNSE_11char_traitsIcEENSE_9allocatorIcEEEENS_5assetEEUlRS1_E_EENSA_14const_iteratorEyOT_ENKUlRSP_E_clINSA_4itemEEEDaSR_ (param $0 i32) (param $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i64)
  (local $5 i64)
  (local $6 i32)
  (local $7 i64)
  (local $8 i32)
  (local $9 i32)
  (local $10 i32)
  (set_local $9
   (tee_local $10
    (i32.sub
     (i32.load offset=4
      (i32.const 0)
     )
     (i32.const 48)
    )
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (get_local $10)
  )
  (set_local $2
   (i32.load
    (get_local $0)
   )
  )
  (set_local $3
   (i32.load offset=12
    (tee_local $6
     (i32.load offset=4
      (get_local $0)
     )
    )
   )
  )
  (i64.store
   (get_local $1)
   (i64.load
    (i32.load
     (get_local $6)
    )
   )
  )
  (drop
   (call $_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEaSERKS5_
    (i32.add
     (get_local $1)
     (i32.const 8)
    )
    (i32.load offset=4
     (get_local $6)
    )
   )
  )
  (i64.store offset=24
   (get_local $1)
   (i64.load
    (tee_local $6
     (i32.load offset=8
      (get_local $6)
     )
    )
   )
  )
  (i64.store
   (i32.add
    (get_local $1)
    (i32.const 32)
   )
   (i64.load
    (i32.add
     (get_local $6)
     (i32.const 8)
    )
   )
  )
  (set_local $4
   (i64.load offset=256
    (get_local $3)
   )
  )
  (call $eosio_assert
   (i32.const 1)
   (i32.const 480)
  )
  (set_local $7
   (i64.shr_u
    (get_local $4)
    (i64.const 8)
   )
  )
  (set_local $6
   (i32.const 0)
  )
  (block $label$0
   (block $label$1
    (loop $label$2
     (br_if $label$1
      (i32.gt_u
       (i32.add
        (i32.shl
         (i32.wrap/i64
          (get_local $7)
         )
         (i32.const 24)
        )
        (i32.const -1073741825)
       )
       (i32.const 452984830)
      )
     )
     (block $label$3
      (br_if $label$3
       (i64.ne
        (i64.and
         (tee_local $7
          (i64.shr_u
           (get_local $7)
           (i64.const 8)
          )
         )
         (i64.const 255)
        )
        (i64.const 0)
       )
      )
      (loop $label$4
       (br_if $label$1
        (i64.ne
         (i64.and
          (tee_local $7
           (i64.shr_u
            (get_local $7)
            (i64.const 8)
           )
          )
          (i64.const 255)
         )
         (i64.const 0)
        )
       )
       (br_if $label$4
        (i32.lt_s
         (tee_local $6
          (i32.add
           (get_local $6)
           (i32.const 1)
          )
         )
         (i32.const 7)
        )
       )
      )
     )
     (set_local $8
      (i32.const 1)
     )
     (br_if $label$2
      (i32.lt_s
       (tee_local $6
        (i32.add
         (get_local $6)
         (i32.const 1)
        )
       )
       (i32.const 7)
      )
     )
     (br $label$0)
    )
   )
   (set_local $8
    (i32.const 0)
   )
  )
  (call $eosio_assert
   (get_local $8)
   (i32.const 544)
  )
  (i64.store
   (i32.add
    (get_local $1)
    (i32.const 48)
   )
   (get_local $4)
  )
  (i64.store offset=40
   (get_local $1)
   (i64.const 0)
  )
  (i32.store8 offset=56
   (get_local $1)
   (i32.const 0)
  )
  (call $_ZN12daccustodian7configsEv
   (i32.add
    (get_local $9)
    (i32.const 16)
   )
   (get_local $3)
  )
  (i64.store
   (i32.add
    (get_local $1)
    (i32.const 72)
   )
   (i64.load
    (i32.add
     (i32.add
      (get_local $9)
      (i32.const 16)
     )
     (i32.const 8)
    )
   )
  )
  (i64.store offset=64
   (get_local $1)
   (i64.load offset=16
    (get_local $9)
   )
  )
  (i64.store offset=80
   (get_local $1)
   (i64.const 0)
  )
  (set_local $6
   (i32.add
    (tee_local $8
     (select
      (i32.load
       (i32.add
        (get_local $1)
        (i32.const 12)
       )
      )
      (i32.shr_u
       (tee_local $6
        (i32.load8_u
         (i32.add
          (get_local $1)
          (i32.const 8)
         )
        )
       )
       (i32.const 1)
      )
      (i32.and
       (get_local $6)
       (i32.const 1)
      )
     )
    )
    (i32.const 65)
   )
  )
  (set_local $7
   (i64.extend_u/i32
    (get_local $8)
   )
  )
  (loop $label$5
   (set_local $6
    (i32.add
     (get_local $6)
     (i32.const 1)
    )
   )
   (br_if $label$5
    (i64.ne
     (tee_local $7
      (i64.shr_u
       (get_local $7)
       (i64.const 7)
      )
     )
     (i64.const 0)
    )
   )
  )
  (block $label$6
   (block $label$7
    (br_if $label$7
     (i32.lt_u
      (get_local $6)
      (i32.const 513)
     )
    )
    (set_local $8
     (call $malloc
      (get_local $6)
     )
    )
    (br $label$6)
   )
   (i32.store offset=4
    (i32.const 0)
    (tee_local $8
     (i32.sub
      (get_local $10)
      (i32.and
       (i32.add
        (get_local $6)
        (i32.const 15)
       )
       (i32.const -16)
      )
     )
    )
   )
  )
  (i32.store offset=4
   (get_local $9)
   (get_local $8)
  )
  (i32.store
   (get_local $9)
   (get_local $8)
  )
  (i32.store offset=8
   (get_local $9)
   (i32.add
    (get_local $8)
    (get_local $6)
   )
  )
  (drop
   (call $_ZlsIN5eosio10datastreamIPcEEERT_S5_RK9candidate
    (get_local $9)
    (get_local $1)
   )
  )
  (i32.store offset=92
   (get_local $1)
   (call $db_store_i64
    (i64.load offset=8
     (get_local $2)
    )
    (i64.const 4730634643120193536)
    (i64.load
     (i32.load offset=8
      (get_local $0)
     )
    )
    (tee_local $7
     (i64.load
      (get_local $1)
     )
    )
    (get_local $8)
    (get_local $6)
   )
  )
  (block $label$8
   (br_if $label$8
    (i32.lt_u
     (get_local $6)
     (i32.const 513)
    )
   )
   (call $free
    (get_local $8)
   )
  )
  (block $label$9
   (br_if $label$9
    (i64.lt_u
     (get_local $7)
     (i64.load offset=16
      (get_local $2)
     )
    )
   )
   (i64.store
    (i32.add
     (get_local $2)
     (i32.const 16)
    )
    (select
     (i64.const -2)
     (i64.add
      (get_local $7)
      (i64.const 1)
     )
     (i64.gt_u
      (get_local $7)
      (i64.const -3)
     )
    )
   )
  )
  (set_local $7
   (i64.load
    (tee_local $6
     (i32.add
      (get_local $2)
      (i32.const 8)
     )
    )
   )
  )
  (set_local $4
   (i64.load
    (tee_local $8
     (i32.load
      (i32.add
       (get_local $0)
       (i32.const 8)
      )
     )
    )
   )
  )
  (set_local $5
   (i64.load
    (get_local $1)
   )
  )
  (i64.store offset=24
   (get_local $9)
   (i64.const 0)
  )
  (i64.store offset=16
   (get_local $9)
   (i64.or
    (i64.shl
     (i64.load8_u
      (i32.add
       (get_local $1)
       (i32.const 56)
      )
     )
     (i64.const 8)
    )
    (i64.load offset=24
     (get_local $1)
    )
   )
  )
  (i32.store offset=96
   (get_local $1)
   (call $db_idx128_store
    (get_local $7)
    (i64.const 4730634643120193536)
    (get_local $4)
    (get_local $5)
    (i32.add
     (get_local $9)
     (i32.const 16)
    )
   )
  )
  (set_local $7
   (i64.load
    (get_local $8)
   )
  )
  (set_local $4
   (i64.load
    (get_local $6)
   )
  )
  (set_local $5
   (i64.load
    (get_local $1)
   )
  )
  (i64.store offset=16
   (get_local $9)
   (i64.load
    (i32.add
     (get_local $1)
     (i32.const 80)
    )
   )
  )
  (i32.store
   (i32.add
    (get_local $1)
    (i32.const 100)
   )
   (call $db_idx64_store
    (get_local $4)
    (i64.const 4730634643120193537)
    (get_local $7)
    (get_local $5)
    (i32.add
     (get_local $9)
     (i32.const 16)
    )
   )
  )
  (i32.store offset=4
   (i32.const 0)
   (i32.add
    (get_local $9)
    (i32.const 48)
   )
  )
 )
 (func $_ZN5boost6fusion6detail17for_each_unrolledILi3EE4callINS0_18std_tuple_iteratorINSt3__15tupleIJN5eosio5assetEhmEEELi0EEEZNS8_rsINS8_10datastreamIPKcEEJS9_hmEEERT_SI_RNS7_IJDpT0_EEEEUlSI_E_EEvRKSH_RKT0_ (param $0 i32) (param $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (set_local $3
   (i32.load
    (get_local $0)
   )
  )
  (call $eosio_assert
   (i32.gt_u
    (i32.sub
     (i32.load offset=8
      (tee_local $2
       (i32.load
        (get_local $1)
       )
      )
     )
     (i32.load offset=4
      (get_local $2)
     )
    )
    (i32.const 7)
   )
   (i32.const 576)
  )
  (drop
   (call $memcpy
    (get_local $3)
    (i32.load offset=4
     (get_local $2)
    )
    (i32.const 8)
   )
  )
  (i32.store offset=4
   (get_local $2)
   (tee_local $4
    (i32.add
     (i32.load offset=4
      (get_local $2)
     )
     (i32.const 8)
    )
   )
  )
  (call $eosio_assert
   (i32.gt_u
    (i32.sub
     (i32.load offset=8
      (get_local $2)
     )
     (get_local $4)
    )
    (i32.const 7)
   )
   (i32.const 576)
  )
  (drop
   (call $memcpy
    (i32.add
     (get_local $3)
     (i32.const 8)
    )
    (i32.load offset=4
     (get_local $2)
    )
    (i32.const 8)
   )
  )
  (i32.store offset=4
   (get_local $2)
   (i32.add
    (i32.load offset=4
     (get_local $2)
    )
    (i32.const 8)
   )
  )
  (set_local $0
   (i32.load
    (get_local $0)
   )
  )
  (call $eosio_assert
   (i32.ne
    (i32.load offset=8
     (tee_local $2
      (i32.load
       (get_local $1)
      )
     )
    )
    (i32.load offset=4
     (get_local $2)
    )
   )
   (i32.const 576)
  )
  (drop
   (call $memcpy
    (i32.add
     (get_local $0)
     (i32.const 16)
    )
    (i32.load offset=4
     (get_local $2)
    )
    (i32.const 1)
   )
  )
  (i32.store offset=4
   (get_local $2)
   (i32.add
    (i32.load offset=4
     (get_local $2)
    )
    (i32.const 1)
   )
  )
  (call $eosio_assert
   (i32.gt_u
    (i32.sub
     (i32.load offset=8
      (tee_local $2
       (i32.load
        (get_local $1)
       )
      )
     )
     (i32.load offset=4
      (get_local $2)
     )
    )
    (i32.const 3)
   )
   (i32.const 576)
  )
  (drop
   (call $memcpy
    (i32.add
     (get_local $0)
     (i32.const 20)
    )
    (i32.load offset=4
     (get_local $2)
    )
    (i32.const 4)
   )
  )
  (i32.store offset=4
   (get_local $2)
   (i32.add
    (i32.load offset=4
     (get_local $2)
    )
    (i32.const 4)
   )
  )
 )
 (func $malloc (param $0 i32) (result i32)
  (call $_ZN5eosio14memory_manager6mallocEm
   (i32.const 1940)
   (get_local $0)
  )
 )
 (func $_ZN5eosio14memory_manager6mallocEm (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (local $8 i32)
  (local $9 i32)
  (local $10 i32)
  (local $11 i32)
  (local $12 i32)
  (local $13 i32)
  (block $label$0
   (br_if $label$0
    (i32.eqz
     (get_local $1)
    )
   )
   (block $label$1
    (br_if $label$1
     (tee_local $13
      (i32.load offset=8384
       (get_local $0)
      )
     )
    )
    (set_local $13
     (i32.const 16)
    )
    (i32.store
     (i32.add
      (get_local $0)
      (i32.const 8384)
     )
     (i32.const 16)
    )
   )
   (set_local $2
    (select
     (i32.sub
      (i32.add
       (get_local $1)
       (i32.const 8)
      )
      (tee_local $2
       (i32.and
        (i32.add
         (get_local $1)
         (i32.const 4)
        )
        (i32.const 7)
       )
      )
     )
     (get_local $1)
     (get_local $2)
    )
   )
   (block $label$2
    (block $label$3
     (block $label$4
      (br_if $label$4
       (i32.ge_u
        (tee_local $10
         (i32.load offset=8388
          (get_local $0)
         )
        )
        (get_local $13)
       )
      )
      (set_local $1
       (i32.add
        (i32.add
         (get_local $0)
         (i32.mul
          (get_local $10)
          (i32.const 12)
         )
        )
        (i32.const 8192)
       )
      )
      (block $label$5
       (br_if $label$5
        (get_local $10)
       )
       (br_if $label$5
        (i32.load
         (tee_local $13
          (i32.add
           (get_local $0)
           (i32.const 8196)
          )
         )
        )
       )
       (i32.store
        (get_local $1)
        (i32.const 8192)
       )
       (i32.store
        (get_local $13)
        (get_local $0)
       )
      )
      (set_local $10
       (i32.add
        (get_local $2)
        (i32.const 4)
       )
      )
      (loop $label$6
       (block $label$7
        (br_if $label$7
         (i32.gt_u
          (i32.add
           (tee_local $13
            (i32.load offset=8
             (get_local $1)
            )
           )
           (get_local $10)
          )
          (i32.load
           (get_local $1)
          )
         )
        )
        (i32.store
         (tee_local $13
          (i32.add
           (i32.load offset=4
            (get_local $1)
           )
           (get_local $13)
          )
         )
         (i32.or
          (i32.and
           (i32.load
            (get_local $13)
           )
           (i32.const -2147483648)
          )
          (get_local $2)
         )
        )
        (i32.store
         (tee_local $1
          (i32.add
           (get_local $1)
           (i32.const 8)
          )
         )
         (i32.add
          (i32.load
           (get_local $1)
          )
          (get_local $10)
         )
        )
        (i32.store
         (get_local $13)
         (i32.or
          (i32.load
           (get_local $13)
          )
          (i32.const -2147483648)
         )
        )
        (br_if $label$3
         (tee_local $1
          (i32.add
           (get_local $13)
           (i32.const 4)
          )
         )
        )
       )
       (br_if $label$6
        (tee_local $1
         (call $_ZN5eosio14memory_manager16next_active_heapEv
          (get_local $0)
         )
        )
       )
      )
     )
     (set_local $4
      (i32.sub
       (i32.const 2147483644)
       (get_local $2)
      )
     )
     (set_local $11
      (i32.add
       (get_local $0)
       (i32.const 8392)
      )
     )
     (set_local $12
      (i32.add
       (get_local $0)
       (i32.const 8384)
      )
     )
     (set_local $13
      (tee_local $3
       (i32.load offset=8392
        (get_local $0)
       )
      )
     )
     (loop $label$8
      (call $eosio_assert
       (i32.eq
        (i32.load
         (i32.add
          (tee_local $1
           (i32.add
            (get_local $0)
            (i32.mul
             (get_local $13)
             (i32.const 12)
            )
           )
          )
          (i32.const 8200)
         )
        )
        (i32.load
         (tee_local $5
          (i32.add
           (get_local $1)
           (i32.const 8192)
          )
         )
        )
       )
       (i32.const 10336)
      )
      (set_local $13
       (i32.add
        (tee_local $6
         (i32.load
          (i32.add
           (get_local $1)
           (i32.const 8196)
          )
         )
        )
        (i32.const 4)
       )
      )
      (loop $label$9
       (set_local $7
        (i32.add
         (get_local $6)
         (i32.load
          (get_local $5)
         )
        )
       )
       (set_local $1
        (i32.and
         (tee_local $9
          (i32.load
           (tee_local $8
            (i32.add
             (get_local $13)
             (i32.const -4)
            )
           )
          )
         )
         (i32.const 2147483647)
        )
       )
       (block $label$10
        (br_if $label$10
         (i32.lt_s
          (get_local $9)
          (i32.const 0)
         )
        )
        (block $label$11
         (br_if $label$11
          (i32.ge_u
           (get_local $1)
           (get_local $2)
          )
         )
         (loop $label$12
          (br_if $label$11
           (i32.ge_u
            (tee_local $10
             (i32.add
              (get_local $13)
              (get_local $1)
             )
            )
            (get_local $7)
           )
          )
          (br_if $label$11
           (i32.lt_s
            (tee_local $10
             (i32.load
              (get_local $10)
             )
            )
            (i32.const 0)
           )
          )
          (br_if $label$12
           (i32.lt_u
            (tee_local $1
             (i32.add
              (i32.add
               (get_local $1)
               (i32.and
                (get_local $10)
                (i32.const 2147483647)
               )
              )
              (i32.const 4)
             )
            )
            (get_local $2)
           )
          )
         )
        )
        (i32.store
         (get_local $8)
         (i32.or
          (select
           (get_local $1)
           (get_local $2)
           (i32.lt_u
            (get_local $1)
            (get_local $2)
           )
          )
          (i32.and
           (get_local $9)
           (i32.const -2147483648)
          )
         )
        )
        (block $label$13
         (br_if $label$13
          (i32.le_u
           (get_local $1)
           (get_local $2)
          )
         )
         (i32.store
          (i32.add
           (get_local $13)
           (get_local $2)
          )
          (i32.and
           (i32.add
            (get_local $4)
            (get_local $1)
           )
           (i32.const 2147483647)
          )
         )
        )
        (br_if $label$2
         (i32.ge_u
          (get_local $1)
          (get_local $2)
         )
        )
       )
       (br_if $label$9
        (i32.lt_u
         (tee_local $13
          (i32.add
           (i32.add
            (get_local $13)
            (get_local $1)
           )
           (i32.const 4)
          )
         )
         (get_local $7)
        )
       )
      )
      (set_local $1
       (i32.const 0)
      )
      (i32.store
       (get_local $11)
       (tee_local $13
        (select
         (i32.const 0)
         (tee_local $13
          (i32.add
           (i32.load
            (get_local $11)
           )
           (i32.const 1)
          )
         )
         (i32.eq
          (get_local $13)
          (i32.load
           (get_local $12)
          )
         )
        )
       )
      )
      (br_if $label$8
       (i32.ne
        (get_local $13)
        (get_local $3)
       )
      )
     )
    )
    (return
     (get_local $1)
    )
   )
   (i32.store
    (get_local $8)
    (i32.or
     (i32.load
      (get_local $8)
     )
     (i32.const -2147483648)
    )
   )
   (return
    (get_local $13)
   )
  )
  (i32.const 0)
 )
 (func $_ZN5eosio14memory_manager16next_active_heapEv (param $0 i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (local $8 i32)
  (set_local $1
   (i32.load offset=8388
    (get_local $0)
   )
  )
  (block $label$0
   (block $label$1
    (br_if $label$1
     (i32.eqz
      (i32.load8_u offset=10422
       (i32.const 0)
      )
     )
    )
    (set_local $7
     (i32.load offset=10424
      (i32.const 0)
     )
    )
    (br $label$0)
   )
   (set_local $7
    (current_memory)
   )
   (i32.store8 offset=10422
    (i32.const 0)
    (i32.const 1)
   )
   (i32.store offset=10424
    (i32.const 0)
    (tee_local $7
     (i32.shl
      (get_local $7)
      (i32.const 16)
     )
    )
   )
  )
  (set_local $3
   (get_local $7)
  )
  (block $label$2
   (block $label$3
    (block $label$4
     (block $label$5
      (br_if $label$5
       (i32.le_u
        (tee_local $2
         (i32.shr_u
          (i32.add
           (get_local $7)
           (i32.const 65535)
          )
          (i32.const 16)
         )
        )
        (tee_local $8
         (current_memory)
        )
       )
      )
      (drop
       (grow_memory
        (i32.sub
         (get_local $2)
         (get_local $8)
        )
       )
      )
      (set_local $8
       (i32.const 0)
      )
      (br_if $label$4
       (i32.ne
        (get_local $2)
        (current_memory)
       )
      )
      (set_local $3
       (i32.load offset=10424
        (i32.const 0)
       )
      )
     )
     (set_local $8
      (i32.const 0)
     )
     (i32.store offset=10424
      (i32.const 0)
      (get_local $3)
     )
     (br_if $label$4
      (i32.lt_s
       (get_local $7)
       (i32.const 0)
      )
     )
     (set_local $2
      (i32.add
       (get_local $0)
       (i32.mul
        (get_local $1)
        (i32.const 12)
       )
      )
     )
     (set_local $7
      (i32.sub
       (i32.sub
        (i32.add
         (get_local $7)
         (select
          (i32.const 65536)
          (i32.const 131072)
          (tee_local $6
           (i32.lt_u
            (tee_local $8
             (i32.and
              (get_local $7)
              (i32.const 65535)
             )
            )
            (i32.const 64513)
           )
          )
         )
        )
        (select
         (get_local $8)
         (i32.and
          (get_local $7)
          (i32.const 131071)
         )
         (get_local $6)
        )
       )
       (get_local $7)
      )
     )
     (block $label$6
      (br_if $label$6
       (i32.load8_u offset=10422
        (i32.const 0)
       )
      )
      (set_local $3
       (current_memory)
      )
      (i32.store8 offset=10422
       (i32.const 0)
       (i32.const 1)
      )
      (i32.store offset=10424
       (i32.const 0)
       (tee_local $3
        (i32.shl
         (get_local $3)
         (i32.const 16)
        )
       )
      )
     )
     (set_local $2
      (i32.add
       (get_local $2)
       (i32.const 8192)
      )
     )
     (br_if $label$3
      (i32.lt_s
       (get_local $7)
       (i32.const 0)
      )
     )
     (set_local $6
      (get_local $3)
     )
     (block $label$7
      (br_if $label$7
       (i32.le_u
        (tee_local $8
         (i32.shr_u
          (i32.add
           (i32.add
            (tee_local $5
             (i32.and
              (i32.add
               (get_local $7)
               (i32.const 7)
              )
              (i32.const -8)
             )
            )
            (get_local $3)
           )
           (i32.const 65535)
          )
          (i32.const 16)
         )
        )
        (tee_local $4
         (current_memory)
        )
       )
      )
      (drop
       (grow_memory
        (i32.sub
         (get_local $8)
         (get_local $4)
        )
       )
      )
      (br_if $label$3
       (i32.ne
        (get_local $8)
        (current_memory)
       )
      )
      (set_local $6
       (i32.load offset=10424
        (i32.const 0)
       )
      )
     )
     (i32.store offset=10424
      (i32.const 0)
      (i32.add
       (get_local $6)
       (get_local $5)
      )
     )
     (br_if $label$3
      (i32.eq
       (get_local $3)
       (i32.const -1)
      )
     )
     (br_if $label$2
      (i32.eq
       (i32.add
        (tee_local $6
         (i32.load
          (i32.add
           (tee_local $1
            (i32.add
             (get_local $0)
             (i32.mul
              (get_local $1)
              (i32.const 12)
             )
            )
           )
           (i32.const 8196)
          )
         )
        )
        (tee_local $8
         (i32.load
          (get_local $2)
         )
        )
       )
       (get_local $3)
      )
     )
     (block $label$8
      (br_if $label$8
       (i32.eq
        (get_local $8)
        (tee_local $1
         (i32.load
          (tee_local $5
           (i32.add
            (get_local $1)
            (i32.const 8200)
           )
          )
         )
        )
       )
      )
      (i32.store
       (tee_local $6
        (i32.add
         (get_local $6)
         (get_local $1)
        )
       )
       (i32.or
        (i32.and
         (i32.load
          (get_local $6)
         )
         (i32.const -2147483648)
        )
        (i32.add
         (i32.sub
          (i32.const -4)
          (get_local $1)
         )
         (get_local $8)
        )
       )
      )
      (i32.store
       (get_local $5)
       (i32.load
        (get_local $2)
       )
      )
      (i32.store
       (get_local $6)
       (i32.and
        (i32.load
         (get_local $6)
        )
        (i32.const 2147483647)
       )
      )
     )
     (i32.store
      (tee_local $2
       (i32.add
        (get_local $0)
        (i32.const 8388)
       )
      )
      (tee_local $2
       (i32.add
        (i32.load
         (get_local $2)
        )
        (i32.const 1)
       )
      )
     )
     (i32.store
      (i32.add
       (tee_local $0
        (i32.add
         (get_local $0)
         (i32.mul
          (get_local $2)
          (i32.const 12)
         )
        )
       )
       (i32.const 8196)
      )
      (get_local $3)
     )
     (i32.store
      (tee_local $8
       (i32.add
        (get_local $0)
        (i32.const 8192)
       )
      )
      (get_local $7)
     )
    )
    (return
     (get_local $8)
    )
   )
   (block $label$9
    (br_if $label$9
     (i32.eq
      (tee_local $8
       (i32.load
        (get_local $2)
       )
      )
      (tee_local $7
       (i32.load
        (tee_local $1
         (i32.add
          (tee_local $3
           (i32.add
            (get_local $0)
            (i32.mul
             (get_local $1)
             (i32.const 12)
            )
           )
          )
          (i32.const 8200)
         )
        )
       )
      )
     )
    )
    (i32.store
     (tee_local $3
      (i32.add
       (i32.load
        (i32.add
         (get_local $3)
         (i32.const 8196)
        )
       )
       (get_local $7)
      )
     )
     (i32.or
      (i32.and
       (i32.load
        (get_local $3)
       )
       (i32.const -2147483648)
      )
      (i32.add
       (i32.sub
        (i32.const -4)
        (get_local $7)
       )
       (get_local $8)
      )
     )
    )
    (i32.store
     (get_local $1)
     (i32.load
      (get_local $2)
     )
    )
    (i32.store
     (get_local $3)
     (i32.and
      (i32.load
       (get_local $3)
      )
      (i32.const 2147483647)
     )
    )
   )
   (i32.store offset=8384
    (get_local $0)
    (tee_local $3
     (i32.add
      (i32.load
       (tee_local $7
        (i32.add
         (get_local $0)
         (i32.const 8388)
        )
       )
      )
      (i32.const 1)
     )
    )
   )
   (i32.store
    (get_local $7)
    (get_local $3)
   )
   (return
    (i32.const 0)
   )
  )
  (i32.store
   (get_local $2)
   (i32.add
    (get_local $8)
    (get_local $7)
   )
  )
  (get_local $2)
 )
 (func $free (param $0 i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  (block $label$0
   (block $label$1
    (br_if $label$1
     (i32.eqz
      (get_local $0)
     )
    )
    (br_if $label$1
     (i32.lt_s
      (tee_local $2
       (i32.load offset=10324
        (i32.const 0)
       )
      )
      (i32.const 1)
     )
    )
    (set_local $3
     (i32.const 10132)
    )
    (set_local $1
     (i32.add
      (i32.mul
       (get_local $2)
       (i32.const 12)
      )
      (i32.const 10132)
     )
    )
    (loop $label$2
     (br_if $label$1
      (i32.eqz
       (tee_local $2
        (i32.load
         (i32.add
          (get_local $3)
          (i32.const 4)
         )
        )
       )
      )
     )
     (block $label$3
      (br_if $label$3
       (i32.gt_u
        (i32.add
         (get_local $2)
         (i32.const 4)
        )
        (get_local $0)
       )
      )
      (br_if $label$0
       (i32.gt_u
        (i32.add
         (get_local $2)
         (i32.load
          (get_local $3)
         )
        )
        (get_local $0)
       )
      )
     )
     (br_if $label$2
      (i32.lt_u
       (tee_local $3
        (i32.add
         (get_local $3)
         (i32.const 12)
        )
       )
       (get_local $1)
      )
     )
    )
   )
   (return)
  )
  (i32.store
   (tee_local $3
    (i32.add
     (get_local $0)
     (i32.const -4)
    )
   )
   (i32.and
    (i32.load
     (get_local $3)
    )
    (i32.const 2147483647)
   )
  )
 )
 (func $_Znwj (param $0 i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  (block $label$0
   (br_if $label$0
    (tee_local $0
     (call $malloc
      (tee_local $1
       (select
        (get_local $0)
        (i32.const 1)
        (get_local $0)
       )
      )
     )
    )
   )
   (loop $label$1
    (set_local $0
     (i32.const 0)
    )
    (br_if $label$0
     (i32.eqz
      (tee_local $2
       (i32.load offset=10428
        (i32.const 0)
       )
      )
     )
    )
    (call_indirect (type $FUNCSIG$v)
     (get_local $2)
    )
    (br_if $label$1
     (i32.eqz
      (tee_local $0
       (call $malloc
        (get_local $1)
       )
      )
     )
    )
   )
  )
  (get_local $0)
 )
 (func $_ZdlPv (param $0 i32)
  (block $label$0
   (br_if $label$0
    (i32.eqz
     (get_local $0)
    )
   )
   (call $free
    (get_local $0)
   )
  )
 )
 (func $_ZNKSt3__121__basic_string_commonILb1EE20__throw_length_errorEv (param $0 i32)
  (call $abort)
  (unreachable)
 )
 (func $_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEaSERKS5_ (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (block $label$0
   (block $label$1
    (block $label$2
     (block $label$3
      (br_if $label$3
       (i32.eq
        (get_local $0)
        (get_local $1)
       )
      )
      (set_local $2
       (select
        (i32.load offset=4
         (get_local $1)
        )
        (i32.shr_u
         (tee_local $2
          (i32.load8_u
           (get_local $1)
          )
         )
         (i32.const 1)
        )
        (tee_local $4
         (i32.and
          (get_local $2)
          (i32.const 1)
         )
        )
       )
      )
      (set_local $5
       (i32.add
        (get_local $1)
        (i32.const 1)
       )
      )
      (set_local $6
       (i32.load offset=8
        (get_local $1)
       )
      )
      (set_local $1
       (i32.const 10)
      )
      (block $label$4
       (br_if $label$4
        (i32.eqz
         (i32.and
          (tee_local $3
           (i32.load8_u
            (get_local $0)
           )
          )
          (i32.const 1)
         )
        )
       )
       (set_local $1
        (i32.add
         (i32.and
          (tee_local $3
           (i32.load
            (get_local $0)
           )
          )
          (i32.const -2)
         )
         (i32.const -1)
        )
       )
      )
      (set_local $5
       (select
        (get_local $6)
        (get_local $5)
        (get_local $4)
       )
      )
      (set_local $4
       (i32.and
        (get_local $3)
        (i32.const 1)
       )
      )
      (block $label$5
       (block $label$6
        (block $label$7
         (br_if $label$7
          (i32.le_u
           (get_local $2)
           (get_local $1)
          )
         )
         (br_if $label$6
          (get_local $4)
         )
         (set_local $3
          (i32.shr_u
           (i32.and
            (get_local $3)
            (i32.const 254)
           )
           (i32.const 1)
          )
         )
         (br $label$5)
        )
        (br_if $label$2
         (get_local $4)
        )
        (set_local $1
         (i32.add
          (get_local $0)
          (i32.const 1)
         )
        )
        (br_if $label$1
         (get_local $2)
        )
        (br $label$0)
       )
       (set_local $3
        (i32.load offset=4
         (get_local $0)
        )
       )
      )
      (call $_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE21__grow_by_and_replaceEjjjjjjPKc
       (get_local $0)
       (get_local $1)
       (i32.sub
        (get_local $2)
        (get_local $1)
       )
       (get_local $3)
       (i32.const 0)
       (get_local $3)
       (get_local $2)
       (get_local $5)
      )
     )
     (return
      (get_local $0)
     )
    )
    (set_local $1
     (i32.load offset=8
      (get_local $0)
     )
    )
    (br_if $label$0
     (i32.eqz
      (get_local $2)
     )
    )
   )
   (drop
    (call $memmove
     (get_local $1)
     (get_local $5)
     (get_local $2)
    )
   )
  )
  (i32.store8
   (i32.add
    (get_local $1)
    (get_local $2)
   )
   (i32.const 0)
  )
  (block $label$8
   (br_if $label$8
    (i32.and
     (i32.load8_u
      (get_local $0)
     )
     (i32.const 1)
    )
   )
   (i32.store8
    (get_local $0)
    (i32.shl
     (get_local $2)
     (i32.const 1)
    )
   )
   (return
    (get_local $0)
   )
  )
  (i32.store offset=4
   (get_local $0)
   (get_local $2)
  )
  (get_local $0)
 )
 (func $_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE21__grow_by_and_replaceEjjjjjjPKc (param $0 i32) (param $1 i32) (param $2 i32) (param $3 i32) (param $4 i32) (param $5 i32) (param $6 i32) (param $7 i32)
  (local $8 i32)
  (local $9 i32)
  (local $10 i32)
  (block $label$0
   (br_if $label$0
    (i32.lt_u
     (i32.sub
      (i32.const -18)
      (get_local $1)
     )
     (get_local $2)
    )
   )
   (block $label$1
    (block $label$2
     (br_if $label$2
      (i32.and
       (i32.load8_u
        (get_local $0)
       )
       (i32.const 1)
      )
     )
     (set_local $9
      (i32.add
       (get_local $0)
       (i32.const 1)
      )
     )
     (br $label$1)
    )
    (set_local $9
     (i32.load offset=8
      (get_local $0)
     )
    )
   )
   (set_local $10
    (i32.const -17)
   )
   (block $label$3
    (br_if $label$3
     (i32.gt_u
      (get_local $1)
      (i32.const 2147483622)
     )
    )
    (set_local $10
     (i32.const 11)
    )
    (br_if $label$3
     (i32.lt_u
      (tee_local $2
       (select
        (tee_local $8
         (i32.shl
          (get_local $1)
          (i32.const 1)
         )
        )
        (tee_local $2
         (i32.add
          (get_local $2)
          (get_local $1)
         )
        )
        (i32.lt_u
         (get_local $2)
         (get_local $8)
        )
       )
      )
      (i32.const 11)
     )
    )
    (set_local $10
     (i32.and
      (i32.add
       (get_local $2)
       (i32.const 16)
      )
      (i32.const -16)
     )
    )
   )
   (set_local $2
    (call $_Znwj
     (get_local $10)
    )
   )
   (block $label$4
    (br_if $label$4
     (i32.eqz
      (get_local $4)
     )
    )
    (drop
     (call $memcpy
      (get_local $2)
      (get_local $9)
      (get_local $4)
     )
    )
   )
   (block $label$5
    (br_if $label$5
     (i32.eqz
      (get_local $6)
     )
    )
    (drop
     (call $memcpy
      (i32.add
       (get_local $2)
       (get_local $4)
      )
      (get_local $7)
      (get_local $6)
     )
    )
   )
   (block $label$6
    (br_if $label$6
     (i32.eqz
      (tee_local $7
       (i32.sub
        (tee_local $3
         (i32.sub
          (get_local $3)
          (get_local $5)
         )
        )
        (get_local $4)
       )
      )
     )
    )
    (drop
     (call $memcpy
      (i32.add
       (i32.add
        (get_local $2)
        (get_local $4)
       )
       (get_local $6)
      )
      (i32.add
       (i32.add
        (get_local $9)
        (get_local $4)
       )
       (get_local $5)
      )
      (get_local $7)
     )
    )
   )
   (block $label$7
    (br_if $label$7
     (i32.eq
      (get_local $1)
      (i32.const 10)
     )
    )
    (call $_ZdlPv
     (get_local $9)
    )
   )
   (i32.store offset=8
    (get_local $0)
    (get_local $2)
   )
   (i32.store
    (get_local $0)
    (i32.or
     (get_local $10)
     (i32.const 1)
    )
   )
   (i32.store offset=4
    (get_local $0)
    (tee_local $4
     (i32.add
      (get_local $3)
      (get_local $6)
     )
    )
   )
   (i32.store8
    (i32.add
     (get_local $2)
     (get_local $4)
    )
    (i32.const 0)
   )
   (return)
  )
  (call $abort)
  (unreachable)
 )
 (func $_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE7reserveEj (param $0 i32) (param $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (block $label$0
   (br_if $label$0
    (i32.ge_u
     (get_local $1)
     (i32.const -16)
    )
   )
   (set_local $2
    (i32.const 10)
   )
   (block $label$1
    (br_if $label$1
     (i32.eqz
      (i32.and
       (tee_local $5
        (i32.load8_u
         (get_local $0)
        )
       )
       (i32.const 1)
      )
     )
    )
    (set_local $2
     (i32.add
      (i32.and
       (tee_local $5
        (i32.load
         (get_local $0)
        )
       )
       (i32.const -2)
      )
      (i32.const -1)
     )
    )
   )
   (block $label$2
    (block $label$3
     (br_if $label$3
      (i32.and
       (get_local $5)
       (i32.const 1)
      )
     )
     (set_local $3
      (i32.shr_u
       (i32.and
        (get_local $5)
        (i32.const 254)
       )
       (i32.const 1)
      )
     )
     (br $label$2)
    )
    (set_local $3
     (i32.load offset=4
      (get_local $0)
     )
    )
   )
   (set_local $4
    (i32.const 10)
   )
   (block $label$4
    (br_if $label$4
     (i32.lt_u
      (tee_local $1
       (select
        (get_local $3)
        (get_local $1)
        (i32.gt_u
         (get_local $3)
         (get_local $1)
        )
       )
      )
      (i32.const 11)
     )
    )
    (set_local $4
     (i32.add
      (i32.and
       (i32.add
        (get_local $1)
        (i32.const 16)
       )
       (i32.const -16)
      )
      (i32.const -1)
     )
    )
   )
   (block $label$5
    (br_if $label$5
     (i32.eq
      (get_local $4)
      (get_local $2)
     )
    )
    (block $label$6
     (block $label$7
      (br_if $label$7
       (i32.ne
        (get_local $4)
        (i32.const 10)
       )
      )
      (set_local $6
       (i32.const 1)
      )
      (set_local $1
       (i32.add
        (get_local $0)
        (i32.const 1)
       )
      )
      (set_local $2
       (i32.load offset=8
        (get_local $0)
       )
      )
      (set_local $7
       (i32.const 0)
      )
      (br $label$6)
     )
     (set_local $1
      (call $_Znwj
       (i32.add
        (get_local $4)
        (i32.const 1)
       )
      )
     )
     (block $label$8
      (br_if $label$8
       (i32.gt_u
        (get_local $4)
        (get_local $2)
       )
      )
      (br_if $label$5
       (i32.eqz
        (get_local $1)
       )
      )
     )
     (block $label$9
      (br_if $label$9
       (i32.and
        (tee_local $5
         (i32.load8_u
          (get_local $0)
         )
        )
        (i32.const 1)
       )
      )
      (set_local $7
       (i32.const 1)
      )
      (set_local $2
       (i32.add
        (get_local $0)
        (i32.const 1)
       )
      )
      (set_local $6
       (i32.const 0)
      )
      (br $label$6)
     )
     (set_local $2
      (i32.load offset=8
       (get_local $0)
      )
     )
     (set_local $6
      (i32.const 1)
     )
     (set_local $7
      (i32.const 1)
     )
    )
    (block $label$10
     (block $label$11
      (br_if $label$11
       (i32.and
        (get_local $5)
        (i32.const 1)
       )
      )
      (set_local $5
       (i32.shr_u
        (i32.and
         (get_local $5)
         (i32.const 254)
        )
        (i32.const 1)
       )
      )
      (br $label$10)
     )
     (set_local $5
      (i32.load offset=4
       (get_local $0)
      )
     )
    )
    (block $label$12
     (br_if $label$12
      (i32.eqz
       (tee_local $5
        (i32.add
         (get_local $5)
         (i32.const 1)
        )
       )
      )
     )
     (drop
      (call $memcpy
       (get_local $1)
       (get_local $2)
       (get_local $5)
      )
     )
    )
    (block $label$13
     (br_if $label$13
      (i32.eqz
       (get_local $6)
      )
     )
     (call $_ZdlPv
      (get_local $2)
     )
    )
    (block $label$14
     (br_if $label$14
      (i32.eqz
       (get_local $7)
      )
     )
     (i32.store offset=4
      (get_local $0)
      (get_local $3)
     )
     (i32.store offset=8
      (get_local $0)
      (get_local $1)
     )
     (i32.store
      (get_local $0)
      (i32.or
       (i32.add
        (get_local $4)
        (i32.const 1)
       )
       (i32.const 1)
      )
     )
     (return)
    )
    (i32.store8
     (get_local $0)
     (i32.shl
      (get_local $3)
      (i32.const 1)
     )
    )
   )
   (return)
  )
  (call $abort)
  (unreachable)
 )
 (func $_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE6assignEPKc (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (set_local $2
   (call $strlen
    (get_local $1)
   )
  )
  (set_local $5
   (i32.const 10)
  )
  (block $label$0
   (br_if $label$0
    (i32.eqz
     (i32.and
      (tee_local $3
       (i32.load8_u
        (get_local $0)
       )
      )
      (i32.const 1)
     )
    )
   )
   (set_local $5
    (i32.add
     (i32.and
      (tee_local $3
       (i32.load
        (get_local $0)
       )
      )
      (i32.const -2)
     )
     (i32.const -1)
    )
   )
  )
  (set_local $4
   (i32.and
    (get_local $3)
    (i32.const 1)
   )
  )
  (block $label$1
   (block $label$2
    (block $label$3
     (block $label$4
      (block $label$5
       (block $label$6
        (br_if $label$6
         (i32.le_u
          (get_local $2)
          (get_local $5)
         )
        )
        (br_if $label$5
         (get_local $4)
        )
        (set_local $3
         (i32.shr_u
          (i32.and
           (get_local $3)
           (i32.const 254)
          )
          (i32.const 1)
         )
        )
        (br $label$4)
       )
       (br_if $label$3
        (get_local $4)
       )
       (set_local $5
        (i32.add
         (get_local $0)
         (i32.const 1)
        )
       )
       (br_if $label$2
        (get_local $2)
       )
       (br $label$1)
      )
      (set_local $3
       (i32.load offset=4
        (get_local $0)
       )
      )
     )
     (call $_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE21__grow_by_and_replaceEjjjjjjPKc
      (get_local $0)
      (get_local $5)
      (i32.sub
       (get_local $2)
       (get_local $5)
      )
      (get_local $3)
      (i32.const 0)
      (get_local $3)
      (get_local $2)
      (get_local $1)
     )
     (return
      (get_local $0)
     )
    )
    (set_local $5
     (i32.load offset=8
      (get_local $0)
     )
    )
    (br_if $label$1
     (i32.eqz
      (get_local $2)
     )
    )
   )
   (drop
    (call $memmove
     (get_local $5)
     (get_local $1)
     (get_local $2)
    )
   )
  )
  (i32.store8
   (i32.add
    (get_local $5)
    (get_local $2)
   )
   (i32.const 0)
  )
  (block $label$7
   (br_if $label$7
    (i32.and
     (i32.load8_u
      (get_local $0)
     )
     (i32.const 1)
    )
   )
   (i32.store8
    (get_local $0)
    (i32.shl
     (get_local $2)
     (i32.const 1)
    )
   )
   (return
    (get_local $0)
   )
  )
  (i32.store offset=4
   (get_local $0)
   (get_local $2)
  )
  (get_local $0)
 )
 (func $_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE6insertEjPKc (param $0 i32) (param $1 i32) (param $2 i32) (result i32)
  (call $_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE6insertEjPKcj
   (get_local $0)
   (get_local $1)
   (get_local $2)
   (call $strlen
    (get_local $2)
   )
  )
 )
 (func $_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE6insertEjPKcj (param $0 i32) (param $1 i32) (param $2 i32) (param $3 i32) (result i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (block $label$0
   (block $label$1
    (block $label$2
     (br_if $label$2
      (tee_local $6
       (i32.and
        (tee_local $5
         (i32.load8_u
          (get_local $0)
         )
        )
        (i32.const 1)
       )
      )
     )
     (br_if $label$1
      (i32.ge_u
       (tee_local $4
        (i32.shr_u
         (get_local $5)
         (i32.const 1)
        )
       )
       (get_local $1)
      )
     )
     (br $label$0)
    )
    (br_if $label$0
     (i32.lt_u
      (tee_local $4
       (i32.load offset=4
        (get_local $0)
       )
      )
      (get_local $1)
     )
    )
   )
   (block $label$3
    (block $label$4
     (br_if $label$4
      (get_local $6)
     )
     (set_local $6
      (i32.const 10)
     )
     (br $label$3)
    )
    (set_local $6
     (i32.add
      (i32.and
       (tee_local $5
        (i32.load
         (get_local $0)
        )
       )
       (i32.const -2)
      )
      (i32.const -1)
     )
    )
   )
   (block $label$5
    (br_if $label$5
     (i32.ge_u
      (i32.sub
       (get_local $6)
       (get_local $4)
      )
      (get_local $3)
     )
    )
    (call $_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE21__grow_by_and_replaceEjjjjjjPKc
     (get_local $0)
     (get_local $6)
     (i32.sub
      (i32.add
       (get_local $4)
       (get_local $3)
      )
      (get_local $6)
     )
     (get_local $4)
     (get_local $1)
     (i32.const 0)
     (get_local $3)
     (get_local $2)
    )
    (return
     (get_local $0)
    )
   )
   (block $label$6
    (block $label$7
     (block $label$8
      (br_if $label$8
       (i32.eqz
        (get_local $3)
       )
      )
      (br_if $label$7
       (i32.and
        (get_local $5)
        (i32.const 1)
       )
      )
      (set_local $5
       (i32.add
        (get_local $0)
        (i32.const 1)
       )
      )
      (br $label$6)
     )
     (return
      (get_local $0)
     )
    )
    (set_local $5
     (i32.load offset=8
      (get_local $0)
     )
    )
   )
   (set_local $6
    (i32.add
     (get_local $5)
     (get_local $1)
    )
   )
   (block $label$9
    (br_if $label$9
     (i32.eqz
      (tee_local $1
       (i32.sub
        (get_local $4)
        (get_local $1)
       )
      )
     )
    )
    (drop
     (call $memmove
      (i32.add
       (get_local $6)
       (get_local $3)
      )
      (get_local $6)
      (get_local $1)
     )
    )
    (set_local $2
     (select
      (select
       (i32.add
        (get_local $2)
        (get_local $3)
       )
       (get_local $2)
       (i32.gt_u
        (i32.add
         (get_local $5)
         (get_local $4)
        )
        (get_local $2)
       )
      )
      (get_local $2)
      (i32.le_u
       (get_local $6)
       (get_local $2)
      )
     )
    )
   )
   (drop
    (call $memmove
     (get_local $6)
     (get_local $2)
     (get_local $3)
    )
   )
   (set_local $3
    (i32.add
     (get_local $4)
     (get_local $3)
    )
   )
   (block $label$10
    (block $label$11
     (br_if $label$11
      (i32.and
       (i32.load8_u
        (get_local $0)
       )
       (i32.const 1)
      )
     )
     (i32.store8
      (get_local $0)
      (i32.shl
       (get_local $3)
       (i32.const 1)
      )
     )
     (br $label$10)
    )
    (i32.store offset=4
     (get_local $0)
     (get_local $3)
    )
   )
   (i32.store8
    (i32.add
     (get_local $5)
     (get_local $3)
    )
    (i32.const 0)
   )
   (return
    (get_local $0)
   )
  )
  (call $abort)
  (unreachable)
 )
 (func $_ZNKSt3__120__vector_base_commonILb1EE20__throw_length_errorEv (param $0 i32)
  (call $abort)
  (unreachable)
 )
 (func $_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC2ERKS5_ (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (i64.store align=4
   (get_local $0)
   (i64.const 0)
  )
  (i32.store
   (tee_local $3
    (i32.add
     (get_local $0)
     (i32.const 8)
    )
   )
   (i32.const 0)
  )
  (block $label$0
   (br_if $label$0
    (i32.and
     (i32.load8_u
      (get_local $1)
     )
     (i32.const 1)
    )
   )
   (i64.store align=4
    (get_local $0)
    (i64.load align=4
     (get_local $1)
    )
   )
   (i32.store
    (get_local $3)
    (i32.load
     (i32.add
      (get_local $1)
      (i32.const 8)
     )
    )
   )
   (return
    (get_local $0)
   )
  )
  (block $label$1
   (br_if $label$1
    (i32.ge_u
     (tee_local $3
      (i32.load offset=4
       (get_local $1)
      )
     )
     (i32.const -16)
    )
   )
   (set_local $2
    (i32.load offset=8
     (get_local $1)
    )
   )
   (block $label$2
    (block $label$3
     (block $label$4
      (br_if $label$4
       (i32.ge_u
        (get_local $3)
        (i32.const 11)
       )
      )
      (i32.store8
       (get_local $0)
       (i32.shl
        (get_local $3)
        (i32.const 1)
       )
      )
      (set_local $1
       (i32.add
        (get_local $0)
        (i32.const 1)
       )
      )
      (br_if $label$3
       (get_local $3)
      )
      (br $label$2)
     )
     (set_local $1
      (call $_Znwj
       (tee_local $4
        (i32.and
         (i32.add
          (get_local $3)
          (i32.const 16)
         )
         (i32.const -16)
        )
       )
      )
     )
     (i32.store
      (get_local $0)
      (i32.or
       (get_local $4)
       (i32.const 1)
      )
     )
     (i32.store offset=8
      (get_local $0)
      (get_local $1)
     )
     (i32.store offset=4
      (get_local $0)
      (get_local $3)
     )
    )
    (drop
     (call $memcpy
      (get_local $1)
      (get_local $2)
      (get_local $3)
     )
    )
   )
   (i32.store8
    (i32.add
     (get_local $1)
     (get_local $3)
    )
    (i32.const 0)
   )
   (return
    (get_local $0)
   )
  )
  (call $abort)
  (unreachable)
 )
 (func $_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC2ERKS5_jjRKS4_ (param $0 i32) (param $1 i32) (param $2 i32) (param $3 i32) (param $4 i32) (result i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (local $8 i32)
  (i64.store align=4
   (get_local $0)
   (i64.const 0)
  )
  (i32.store
   (i32.add
    (get_local $0)
    (i32.const 8)
   )
   (i32.const 0)
  )
  (block $label$0
   (br_if $label$0
    (i32.lt_u
     (tee_local $8
      (select
       (i32.load offset=4
        (get_local $1)
       )
       (i32.shr_u
        (tee_local $8
         (i32.load8_u
          (get_local $1)
         )
        )
        (i32.const 1)
       )
       (tee_local $5
        (i32.and
         (get_local $8)
         (i32.const 1)
        )
       )
      )
     )
     (get_local $2)
    )
   )
   (br_if $label$0
    (i32.ge_u
     (tee_local $3
      (select
       (tee_local $8
        (i32.sub
         (get_local $8)
         (get_local $2)
        )
       )
       (get_local $3)
       (i32.lt_u
        (get_local $8)
        (get_local $3)
       )
      )
     )
     (i32.const -16)
    )
   )
   (set_local $6
    (i32.load offset=8
     (get_local $1)
    )
   )
   (block $label$1
    (block $label$2
     (block $label$3
      (br_if $label$3
       (i32.ge_u
        (get_local $3)
        (i32.const 11)
       )
      )
      (i32.store8
       (get_local $0)
       (i32.shl
        (get_local $3)
        (i32.const 1)
       )
      )
      (set_local $8
       (i32.add
        (get_local $0)
        (i32.const 1)
       )
      )
      (br_if $label$2
       (get_local $3)
      )
      (br $label$1)
     )
     (set_local $8
      (call $_Znwj
       (tee_local $7
        (i32.and
         (i32.add
          (get_local $3)
          (i32.const 16)
         )
         (i32.const -16)
        )
       )
      )
     )
     (i32.store
      (get_local $0)
      (i32.or
       (get_local $7)
       (i32.const 1)
      )
     )
     (i32.store offset=8
      (get_local $0)
      (get_local $8)
     )
     (i32.store offset=4
      (get_local $0)
      (get_local $3)
     )
    )
    (drop
     (call $memcpy
      (get_local $8)
      (i32.add
       (select
        (get_local $6)
        (i32.add
         (get_local $1)
         (i32.const 1)
        )
        (get_local $5)
       )
       (get_local $2)
      )
      (get_local $3)
     )
    )
   )
   (i32.store8
    (i32.add
     (get_local $8)
     (get_local $3)
    )
    (i32.const 0)
   )
   (return
    (get_local $0)
   )
  )
  (call $abort)
  (unreachable)
 )
 (func $memcmp (param $0 i32) (param $1 i32) (param $2 i32) (result i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (set_local $5
   (i32.const 0)
  )
  (block $label$0
   (br_if $label$0
    (i32.eqz
     (get_local $2)
    )
   )
   (block $label$1
    (loop $label$2
     (br_if $label$1
      (i32.ne
       (tee_local $3
        (i32.load8_u
         (get_local $0)
        )
       )
       (tee_local $4
        (i32.load8_u
         (get_local $1)
        )
       )
      )
     )
     (set_local $1
      (i32.add
       (get_local $1)
       (i32.const 1)
      )
     )
     (set_local $0
      (i32.add
       (get_local $0)
       (i32.const 1)
      )
     )
     (br_if $label$2
      (tee_local $2
       (i32.add
        (get_local $2)
        (i32.const -1)
       )
      )
     )
     (br $label$0)
    )
   )
   (set_local $5
    (i32.sub
     (get_local $3)
     (get_local $4)
    )
   )
  )
  (get_local $5)
 )
 (func $strlen (param $0 i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  (set_local $2
   (get_local $0)
  )
  (block $label$0
   (block $label$1
    (br_if $label$1
     (i32.eqz
      (i32.and
       (get_local $0)
       (i32.const 3)
      )
     )
    )
    (set_local $2
     (get_local $0)
    )
    (loop $label$2
     (br_if $label$0
      (i32.eqz
       (i32.load8_u
        (get_local $2)
       )
      )
     )
     (br_if $label$2
      (i32.and
       (tee_local $2
        (i32.add
         (get_local $2)
         (i32.const 1)
        )
       )
       (i32.const 3)
      )
     )
    )
   )
   (set_local $2
    (i32.add
     (get_local $2)
     (i32.const -4)
    )
   )
   (loop $label$3
    (br_if $label$3
     (i32.eqz
      (i32.and
       (i32.and
        (i32.xor
         (tee_local $1
          (i32.load
           (tee_local $2
            (i32.add
             (get_local $2)
             (i32.const 4)
            )
           )
          )
         )
         (i32.const -1)
        )
        (i32.add
         (get_local $1)
         (i32.const -16843009)
        )
       )
       (i32.const -2139062144)
      )
     )
    )
   )
   (br_if $label$0
    (i32.eqz
     (i32.and
      (get_local $1)
      (i32.const 255)
     )
    )
   )
   (loop $label$4
    (br_if $label$4
     (i32.load8_u
      (tee_local $2
       (i32.add
        (get_local $2)
        (i32.const 1)
       )
      )
     )
    )
   )
  )
  (i32.sub
   (get_local $2)
   (get_local $0)
  )
 )
 (func $__wasm_nullptr (type $FUNCSIG$v)
  (unreachable)
 )
)
