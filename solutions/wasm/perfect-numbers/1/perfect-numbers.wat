;; For Shree DR.MDD
(module
  (global $nonPositive i32 (i32.const 0))
  (global $deficient i32 (i32.const 1))
  (global $perfect i32 (i32.const 2))
  (global $abundant i32 (i32.const 3))

  (func (export "classify") (param $num i32) (result i32)
    (local $divisor i32) (local $total i32)
    (if (i32.lt_s (local.get $num) (i32.const 1)) (then (return (global.get $nonPositive))))
    (local.set $divisor (i32.shr_u (local.get $num) (i32.const 1))) (local.set $total (i32.const 0))
    (if (i32.gt_u (local.get $num) (i32.const 1)) (then (loop $loopDiv
      (if (i32.eqz (i32.rem_u (local.get $num) (local.get $divisor)))
        (then (local.set $total (i32.add (local.get $total) (local.get $divisor)))))
      (local.set $divisor (i32.sub (local.get $divisor) (i32.const 1)))
      (br_if $loopDiv (local.get $divisor))
    )))
    (if (i32.lt_u (local.get $total) (local.get $num)) (then (return (global.get $deficient))))
    (if (i32.gt_u (local.get $total) (local.get $num)) (then (return (global.get $abundant))))
    (return (global.get $perfect))
  )
)
