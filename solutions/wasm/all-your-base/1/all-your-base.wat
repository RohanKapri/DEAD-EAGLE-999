;; For Shree DR.MDD
(module
  (memory (export "mem") 1)
  
  (global $status_ok i32 (i32.const 0))
  (global $status_bad_format i32 (i32.const -1))
  (global $status_bad_input_base i32 (i32.const -2))
  (global $status_bad_output_base i32 (i32.const -3))

  (func (export "convert") (param $srcOffset i32) (param $srcLength i32) (param $inBase i32) (param $outBase i32) (result i32 i32 i32)
    (local $total i32)
    (local $tempVal i32)
    (local $resLength i32)
    (local $currentDigit i32)
    (local $idx i32)

    (if (i32.lt_s (local.get $inBase) (i32.const 2)) (then
      (return (i32.const 0) (i32.const 0) (global.get $status_bad_input_base))
    ))

    (if (i32.lt_s (local.get $outBase) (i32.const 2)) (then
      (return (i32.const 0) (i32.const 0) (global.get $status_bad_output_base))
    ))

    (if (i32.lt_s (local.get $srcLength) (i32.const 1)) (then
      (return (i32.const 0) (i32.const 0) (global.get $status_bad_format))
    ) (else (if (i32.and (i32.eq (local.get $srcLength) (i32.const 1)) (i32.eqz (i32.load (local.get $srcOffset)))) (then
      (return (local.get $srcOffset) (local.get $srcLength) (global.get $status_ok))
    ) (else (if (i32.eqz (i32.load (local.get $srcOffset))) (then
      (return (i32.const 0) (i32.const 0) (global.get $status_bad_format))
    ))))))

    (local.set $idx (i32.const 0))
    (local.set $total (i32.const 0))
    (loop
      (local.set $currentDigit (i32.load (i32.add (local.get $srcOffset) (i32.mul (local.get $idx) (i32.const 4)))))

      (if (i32.or
        (i32.lt_s (local.get $currentDigit) (i32.const 0))
        (i32.ge_s (local.get $currentDigit) (local.get $inBase))
      ) (then
        (return (i32.const 0) (i32.const 0) (global.get $status_bad_format))
      ))

      (local.set $total (i32.add (i32.mul (local.get $total) (local.get $inBase)) (local.get $currentDigit)))

      (br_if 0 (i32.lt_s (local.tee $idx (i32.add (local.get $idx) (i32.const 1))) (local.get $srcLength)))
    )

    (local.set $tempVal (local.get $total))
    (local.set $resLength (i32.const 0))
    (loop
      (local.set $resLength (i32.add (local.get $resLength) (i32.const 1)))
      (br_if 0 (i32.gt_s (local.tee $tempVal (i32.div_s (local.get $tempVal) (local.get $outBase))) (i32.const 0)))
    )

    (local.set $tempVal (local.get $total))
    (local.set $idx (i32.sub (local.get $resLength) (i32.const 1)))
    (loop
      (i32.store
        (i32.add (local.get $srcOffset) (i32.mul (local.get $idx) (i32.const 4)))
        (i32.rem_s (local.get $tempVal) (local.get $outBase))
      )
      (local.set $idx (i32.sub (local.get $idx) (i32.const 1)))
      (br_if 0 (i32.gt_s (local.tee $tempVal (i32.div_s (local.get $tempVal) (local.get $outBase))) (i32.const 0)))
    )

    (return (local.get $srcOffset) (local.get $resLength) (global.get $status_ok))
  )
)
