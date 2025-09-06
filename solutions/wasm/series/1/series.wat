;; For my Shree DR.MDD
(module
  (memory (export "mem") 1)

  (global $errEmpty i32 (i32.const -1))
  (global $errTooLong i32 (i32.const -2))
  (global $errZero i32 (i32.const -3))
  (global $errNegative i32 (i32.const -4))

  (global $outOffset i32 (i32.const 512))
  (global $asciiZero i32 (i32.const 48))

  (func (export "slices") (param $start i32) (param $length i32) (param $sliceLen i32) (result i32 i32)
    (local $outLen i32)
    (local $pos i32)
    (local $idx i32)
    (if (i32.eqz (local.get $length)) (then (return (global.get $errEmpty) (i32.const 0))))
    (if (i32.eqz (local.get $sliceLen)) (then (return (global.get $errZero) (i32.const 0))))
    (if (i32.lt_s (local.get $sliceLen) (i32.const 0)) (then (return (global.get $errNegative) (i32.const 0))))
    (if (i32.gt_s (local.get $sliceLen) (local.get $length)) (then (return (global.get $errTooLong) (i32.const 0))))
    (loop $outer
      (local.set $idx (i32.const 0))
      (loop $inner
        (i32.store8 (i32.add (global.get $outOffset) (local.get $outLen))
          (i32.sub (i32.load8_u (i32.add (local.get $start) (i32.add (local.get $pos) (local.get $idx)))) 
            (global.get $asciiZero)))
        (local.set $outLen (i32.add (local.get $outLen) (i32.const 1)))
        (local.set $idx (i32.add (local.get $idx) (i32.const 1)))
        (br_if $inner (i32.lt_u (local.get $idx) (local.get $sliceLen)))
      )
      (local.set $pos (i32.add (local.get $pos) (i32.const 1)))
      (br_if $outer (i32.le_u (i32.add (local.get $pos) (local.get $sliceLen)) (local.get $length)))
    )
    (global.get $outOffset) (local.get $outLen)
  )
)
