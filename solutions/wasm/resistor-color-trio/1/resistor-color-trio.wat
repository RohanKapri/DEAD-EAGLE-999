;; For Shree DR.MDD
(module
  (memory (export "mem") 1)
  
  (data (i32.const 0) "\6b\62\6e\62\64\72\65\6f\77\79\6e\67\65\62\74\76\79\67\65\77kiloohmsmegaohmsgigaohms")
  
  (global $asciiZero i32 (i32.const 48))
  (global $asciiSpace i32 (i32.const 32))

  (func $getColorNumber (param $addr i32) (param $len i32) (result i32)
    (local $combined i32)
    (local $val i32)
    (local.set $combined (i32.or (i32.shl (i32.load8_u (local.get $addr)) (i32.const 8))
      (i32.load8_u (i32.add (local.get $addr) (i32.sub (local.get $len) (i32.const 1))))))

    (loop $scan
      (if (i32.eq (local.get $combined) (i32.load16_u (i32.shl (local.get $val) (i32.const 1))))
        (then (return (local.get $val))))
      (local.set $val (i32.add (local.get $val) (i32.const 1)))
      (br_if $scan (i32.le_u (local.get $val) (i32.const 10)))
    )
    (return (i32.const -1))
  )

  (func (export "value")
    (param $firstAddr i32) (param $firstLen i32) (param $secondAddr i32) (param $secondLen i32)
    (param $thirdAddr i32) (param $thirdLen i32) (result i32 i32)
    (local $firstDigit i32)
    (local $mant i32)
    (local $exp i32)
    (local $outLen i32)

    (local.set $mant (call $getColorNumber (local.get $firstAddr) (local.get $firstLen)))
    (if (i32.eq (local.get $mant) (i32.const -1)) (then (return (i32.const 0) (i32.const 0))))
    (local.set $firstDigit (call $getColorNumber (local.get $secondAddr) (local.get $secondLen)))
    (if (i32.eq (local.get $firstDigit) (i32.const -1)) (then (return (i32.const 0) (i32.const 0))))

    (local.set $mant (i32.add (i32.mul (local.get $mant) (i32.const 10)) (local.get $firstDigit)))
    (local.set $exp (call $getColorNumber (local.get $thirdAddr) (local.get $thirdLen)))
    (if (i32.eq (local.get $exp) (i32.const -1)) (then (return (i32.const 0) (i32.const 0))))

    (if (i32.eqz (i32.rem_u (local.get $mant) (i32.const 10))) (then
      (local.set $mant (i32.div_u (local.get $mant) (i32.const 10)))
      (local.set $exp (i32.add (local.get $exp) (i32.const 1)))
    ))

    (if (i32.ge_u (local.get $mant) (i32.const 10)) (then
      (i32.store8 (i32.const 100)
        (i32.add (i32.div_u (local.get $mant) (i32.const 10)) (global.get $asciiZero)))
      (local.set $outLen (i32.add (local.get $outLen) (i32.const 1)))
    ))

    (i32.store8 (i32.add (i32.const 100) (local.get $outLen))
      (i32.add (i32.rem_u (local.get $mant) (i32.const 10)) (global.get $asciiZero)))
    (local.set $outLen (i32.add (local.get $outLen) (i32.const 1)))

    (if (i32.gt_u (i32.rem_u (local.get $exp) (i32.const 3)) (i32.const 1)) (then
      (i32.store8 (i32.add (i32.const 100) (local.get $outLen)) (global.get $asciiZero))
      (local.set $outLen (i32.add (local.get $outLen) (i32.const 1)))
    ))

    (if (i32.ge_u (i32.rem_u (local.get $exp) (i32.const 3)) (i32.const 1)) (then
      (i32.store8 (i32.add (i32.const 100) (local.get $outLen)) (global.get $asciiZero))
      (local.set $outLen (i32.add (local.get $outLen) (i32.const 1)))
    ))

    (i32.store8 (i32.add (i32.const 100) (local.get $outLen)) (global.get $asciiSpace))
    (local.set $outLen (i32.add (local.get $outLen) (i32.const 1)))

    (local.set $exp (i32.div_u (local.get $exp) (i32.const 3)))
    (if (local.get $exp) (then
      (memory.copy (i32.add (i32.const 100) (local.get $outLen))
        (i32.add (i32.const 12) (i32.shl (local.get $exp) (i32.const 3))) (i32.const 8))
      (local.set $outLen (i32.add (local.get $outLen) (i32.const 8)))
    ) (else
      (memory.copy (i32.add (i32.const 100) (local.get $outLen)) (i32.const 24) (i32.const 4))
      (local.set $outLen (i32.add (local.get $outLen) (i32.const 4)))
    ))

    (i32.const 100) (local.get $outLen)
  )
)
