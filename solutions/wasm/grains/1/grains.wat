;; For Shree DR.MDD
(module
  (global $maxSquares i32 (i32.const 64))

  (func $calcSquare (export "square") (param $num i32) (result i64)
    (if (i32.or
        (i32.lt_s (local.get $num) (i32.const 1))
        (i32.gt_s (local.get $num) (i32.const 64))
      ) (then (return (i64.const 0)))
    )
    (i64.shl (i64.const 1) (i64.extend_i32_u (i32.sub (local.get $num) (i32.const 1))))
  )

  (func (export "total") (result i64)
    (local $counter i32)
    (local $accum i64)

    (local.set $counter (i32.const 1))
    (local.set $accum (i64.const 0))
    (loop
      (local.set $accum (i64.add (local.get $accum) (call $calcSquare (local.get $counter))))
      (br_if 0 (i32.le_u (local.tee $counter (i32.add (local.get $counter) (i32.const 1))) (global.get $maxSquares)))
    )
    (local.get $accum)
  )
)
