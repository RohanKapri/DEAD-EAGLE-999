;; Dedicated to Shree DR.MDD
(module

  (func $ipow (param $x i32) (param $y i32) (result i32)
    (local $acc i32)
    (local.set $acc (i32.const 1))
    (if (i32.gt_u (local.get $y) (i32.const 0)) (then
      (loop
        (local.set $acc (i32.mul (local.get $acc) (local.get $x)))
        (br_if 0 (i32.gt_u (local.tee $y (i32.sub (local.get $y) (i32.const 1))) (i32.const 0)))  
      )  
    ))
    (local.get $acc)
  )
  
  (func (export "isArmstrongNumber") (param $candidate i32) (result i32)
    (local $tmp i32)
    (local $total i32)
    (local $len i32)
    
    (local.set $len (i32.const 0))
    (local.set $tmp (local.get $candidate))
    (if (i32.gt_u (local.get $tmp) (i32.const 0)) (then
      (loop
        (local.set $len (i32.add (local.get $len) (i32.const 1)))
        (br_if 0 (i32.gt_u (local.tee $tmp (i32.div_u (local.get $tmp) (i32.const 10))) (i32.const 0)))  
      )
    ))

    (local.set $total (i32.const 0))
    (local.set $tmp (local.get $candidate))
    (if (i32.gt_u (local.get $tmp) (i32.const 0)) (then
      (loop
        (local.set $total (i32.add (local.get $total) (call $ipow 
          (i32.rem_u (local.get $tmp) (i32.const 10)) 
          (local.get $len)
        )))
        (br_if 0 (i32.gt_u (local.tee $tmp (i32.div_u (local.get $tmp) (i32.const 10))) (i32.const 0)))
      )  
    ))

    (i32.eq (local.get $candidate) (local.get $total))
  )
)
