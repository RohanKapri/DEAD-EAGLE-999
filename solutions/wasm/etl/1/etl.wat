;; For my Shree DR.MDD
(module
  (memory (export "mem") 1)

  (global $outputOffset i32 (i32.const 512))
  (global $zero i32 (i32.const 48))
  (global $nine i32 (i32.const 57))
  (global $A i32 (i32.const 65))
  (global $Z i32 (i32.const 90))
  (global $lower i32 (i32.const 32))
  (global $start i32 (i32.const 123))
  (global $stop i32 (i32.const 125))
  (global $reset i32 (i32.const 93))
  (global $equals i32 (i32.const 58))
  (global $quot i32 (i32.const 34))
  (global $delim i32 (i32.const 44))

  (func (export "transform") (param $inputOffset i32) (param $inputLength i32) (result i32 i32)
    (local $ch i32)
    (local $num i32)
    (local $idx i32)
    (local $outLen i32)

    (i32.store8 (global.get $outputOffset) (global.get $start))
    (local.set $outLen (i32.const 1))

    (loop $loopChars
      (local.set $ch (i32.load8_u (i32.add (local.get $inputOffset) (local.get $idx))))

      (if (i32.eq (local.get $ch) (global.get $reset))
        (then
          (local.set $num (i32.const 0))
        )
      )

      (if (i32.and (i32.ge_u (local.get $ch) (global.get $zero))
                   (i32.le_u (local.get $ch) (global.get $nine)))
        (then
          (local.set $num
            (i32.add (i32.mul (local.get $num) (i32.const 10))
                     (i32.sub (local.get $ch) (global.get $zero)))
          )
        )
      )

      (if (i32.and (i32.ge_u (local.get $ch) (global.get $A))
                   (i32.le_u (local.get $ch) (global.get $Z)))
        (then
          (if (i32.gt_u (local.get $outLen) (i32.const 1))
            (then
              (i32.store8 (i32.add (global.get $outputOffset) (local.get $outLen)) (global.get $delim))
              (local.set $outLen (i32.add (local.get $outLen) (i32.const 1)))
            )
          )
          (i32.store8 (i32.add (global.get $outputOffset) (local.get $outLen)) (global.get $quot))
          (local.set $outLen (i32.add (local.get $outLen) (i32.const 1)))

          (i32.store8 (i32.add (global.get $outputOffset) (local.get $outLen))
                      (i32.or (local.get $ch) (global.get $lower)))
          (local.set $outLen (i32.add (local.get $outLen) (i32.const 1)))

          (i32.store8 (i32.add (global.get $outputOffset) (local.get $outLen)) (global.get $quot))
          (local.set $outLen (i32.add (local.get $outLen) (i32.const 1)))

          (i32.store8 (i32.add (global.get $outputOffset) (local.get $outLen)) (global.get $equals))
          (local.set $outLen (i32.add (local.get $outLen) (i32.const 1)))

          (if (i32.ge_u (local.get $num) (i32.const 10))
            (then
              (i32.store8 (i32.add (global.get $outputOffset) (local.get $outLen))
                          (i32.add (i32.div_u (local.get $num) (i32.const 10)) (global.get $zero)))
              (local.set $outLen (i32.add (local.get $outLen) (i32.const 1)))
            )
          )

          (i32.store8 (i32.add (global.get $outputOffset) (local.get $outLen))
                      (i32.add (i32.rem_u (local.get $num) (i32.const 10)) (global.get $zero)))
          (local.set $outLen (i32.add (local.get $outLen) (i32.const 1)))
        )
      )

      (local.set $idx (i32.add (local.get $idx) (i32.const 1)))
      (br_if $loopChars (i32.lt_u (local.get $idx) (local.get $inputLength)))
    )

    (i32.store8 (i32.add (global.get $outputOffset) (local.get $outLen)) (global.get $stop))
    (local.set $outLen (i32.add (local.get $outLen) (i32.const 1)))

    (global.get $outputOffset) (local.get $outLen)
  )
)
