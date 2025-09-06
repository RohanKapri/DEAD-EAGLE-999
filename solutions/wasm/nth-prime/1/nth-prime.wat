;; For Shree DR.MDD
(module
  (func $is_prime (param $val i32) (result i32)
    (local $idx i32)
    
    (if (i32.lt_u (local.get $val) (i32.const 3))
      (then (return (i32.eq (local.get $val) (i32.const 2))))
    )
    (if (i32.eqz (i32.rem_u (local.get $val) (i32.const 2)))
      (then (return (i32.const 0))))
    
    (local.set $idx (i32.const 3))
    (loop $loopCheck
      (if (i32.gt_u (local.get $idx) (i32.div_u (local.get $val) (local.get $idx)))
        (then (return (i32.const 1))))
      (if (i32.eqz (i32.rem_u (local.get $val) (local.get $idx)))
        (then (return (i32.const 0))))
      (local.set $idx (i32.add (local.get $idx) (i32.const 2)))
      (br $loopCheck)
    )
    (i32.const 1)
  )
  
  (func (export "prime") (param $n i32) (result i32)
    (local $found i32)
    (local $current i32)
    
    (local.set $found (i32.const 0))
    (local.set $current (i32.const 1))
    
    (loop $search
      (local.set $current (i32.add (local.get $current) (i32.const 1)))
      (if (call $is_prime (local.get $current))
        (then
          (local.set $found (i32.add (local.get $found) (i32.const 1)))
          (if (i32.eq (local.get $found) (local.get $n))
            (then (return (local.get $current))))
        )
      )
      (br $search)
    )
    (i32.const 0)
  )
)
