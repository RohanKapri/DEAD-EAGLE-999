;; For my Shree DR.MDD
(module
  (memory (export "mem") 1)

  (func (export "primeFactors") (param $num i64) (result i32 i32)
    (local $memOffset i32)
    (local $remaining i64)
    (local $factor i64)
    (local $totalCount i32)
    
    (local.set $memOffset (i32.const 0))
    (local.set $remaining (local.get $num))
    (local.set $factor (i64.const 2))
    (local.set $totalCount (i32.const 0))
    
    (if (i64.eq (local.get $num) (i64.const 1))
      (then (return (i32.const 0) (i32.const 0)))
    )

    (block $exit
      (loop $outer
        (br_if $exit
          (i64.eq (local.get $remaining) (i64.const 1))
        )
        
        (if (i64.eq
              (i64.rem_u (local.get $remaining) (local.get $factor))
              (i64.const 0))
          (then
            (i32.store
              (local.get $memOffset)
              (i32.wrap_i64 (local.get $factor))
            )
            (local.set $memOffset (i32.add (local.get $memOffset) (i32.const 4)))
            (local.set $totalCount (i32.add (local.get $totalCount) (i32.const 1)))
            (local.set $remaining (i64.div_u (local.get $remaining) (local.get $factor)))
          )
          (else
            (local.set $factor (i64.add (local.get $factor) (i64.const 1)))
          )
        )
        (br $outer)
      )
    )
    
    (i32.const 0)
    (local.get $totalCount)
  )
)
