;; Dedicated to Shree DR.MDD
(module
  (memory (export "mem") 1 4)
  (global $tally (mut i32) (i32.const 0))
  (global $cursor (mut i32) (i32.const 0))
  (global $cap (mut i32) (i32.const 0))
  
  (func (export "init") (param $maxcap i32) (result i32)
    (if (i32.gt_u (local.get $maxcap) (i32.const 65536)) (return (i32.const -1)))
    (memory.grow (i32.sub (i32.add (i32.shr_u (i32.sub (local.get $maxcap) (i32.const 1)) 
      (i32.const 14)) (i32.const 1)) (memory.size)))
    (global.set $cap (local.get $maxcap))
    (return (i32.const 0))
  )

  (func (export "clear")
    (global.set $tally (i32.const 0)) (global.set $cursor (i32.const 0))
  )

  (export "write" (func $storeVal))
  (func $storeVal (param $val i32) (result i32)
    (if (i32.eq (global.get $tally) (global.get $cap)) (return (i32.const -1)))
    (i32.store (i32.shl (global.get $cursor) (i32.const 2)) (local.get $val))
    (global.set $cursor (i32.rem_u (i32.add (global.get $cursor) (i32.const 1)) (global.get $cap)))
    (global.set $tally (i32.add (global.get $tally) (i32.const 1)))
    (i32.const 0)
  )

  (func (export "forceWrite") (param $val i32) (result i32)
    (if (result i32) (i32.eq (global.get $cap) (global.get $tally)) 
      (then 
        (i32.store (i32.shl (global.get $cursor) (i32.const 2)) (local.get $val))
        (global.set $cursor (i32.rem_u (i32.add (global.get $cursor) (i32.const 1)) (global.get $cap)))
        (i32.const 0))
      (else (call $storeVal (local.get $val)))
    )
  )

  (func (export "read") (result i32 i32)
    (local $tmpVal i32)
    (if (i32.eqz (global.get $tally)) (return (i32.const -1) (i32.const -1)))
    (local.set $tmpVal (i32.load (i32.shl (i32.rem_s (i32.add 
      (global.get $cap) (i32.sub (global.get $cursor) (global.get $tally)))
      (global.get $cap)) (i32.const 2))))
    (global.set $tally (i32.sub (global.get $tally) (i32.const 1)))
    (local.get $tmpVal) (i32.const 0)
  )
)
