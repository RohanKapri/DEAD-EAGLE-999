;; Dedicated to my Shree DR.MDD
(module
  (import "math" "random" (func $random (result f64)))
  (memory (export "mem") 96)

  (global $length (mut i32) (i32.const 0))
  (global $outputOffset i32 (i32.const 2704384))
  (global $outputLength i32 (i32.const 5))
  (global $letterBase i32 (i32.const 65))
  (global $digitBase i32 (i32.const 48))

  (func (export "generateName") (result i32 i32)
    (local $index i32)
    (local $value i32)

    (if (i32.eqz (global.get $length)) 
      (then (return (i32.const 0) (i32.const 0)))
    )

    (local.set $index (i32.shl (i32.trunc_f64_u 
      (f64.mul (call $random) 
        (f64.convert_i32_u (global.get $length))
      )
    ) (i32.const 2)))
    (local.set $value (i32.load (local.get $index)))
    (global.set $length (i32.sub (global.get $length) (i32.const 1)))
    (i32.store (local.get $index) (i32.load (i32.shl (global.get $length) (i32.const 2))))

    (i32.store8 (global.get $outputOffset)
      (i32.add (i32.div_u (local.get $value) (i32.const 26000)) (global.get $letterBase)))
    (i32.store8 (i32.add (global.get $outputOffset) (i32.const 1))
      (i32.add (i32.rem_u (i32.div_u (local.get $value) (i32.const 1000)) (i32.const 26)) (global.get $letterBase)))
    (i32.store8 (i32.add (global.get $outputOffset) (i32.const 2))
      (i32.add (i32.rem_u (i32.div_u (local.get $value) (i32.const 100)) (i32.const 10)) (global.get $digitBase)))
    (i32.store8 (i32.add (global.get $outputOffset) (i32.const 3))
      (i32.add (i32.rem_u (i32.div_u (local.get $value) (i32.const 10)) (i32.const 10)) (global.get $digitBase)))
    (i32.store8 (i32.add (global.get $outputOffset) (i32.const 4))
      (i32.add (i32.rem_u (local.get $value) (i32.const 10)) (global.get $digitBase)))

    (global.get $outputOffset) (global.get $outputLength)
  )

  (func $resetNames (export "releaseNames")
    (global.set $length (i32.const 0))
    (loop $loopReset
      (i32.store (i32.shl (global.get $length) (i32.const 2)) (global.get $length))
      (global.set $length (i32.add (global.get $length) (i32.const 1)))
      (br_if $loopReset (i32.lt_u (global.get $length) (i32.const 676000)))
    )
  )
)
