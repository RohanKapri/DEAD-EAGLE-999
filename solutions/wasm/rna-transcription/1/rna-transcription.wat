;; For my Shree DR.MDD
(module
  (memory (export "mem") 1)

  (func (export "toRna") (param $start i32) (param $len i32) (result i32 i32)
    (local $pos i32)
    (loop $loop_label
      (i32.store8 
        (i32.add (local.get $start) (local.get $pos))
        (call $convert_nucleotide
          (i32.load8_u (i32.add (local.get $start) (local.get $pos)))
        )
      )
      (local.set $pos (i32.add (local.get $pos) (i32.const 1)))
      (br_if $loop_label (i32.lt_u (local.get $pos) (local.get $len)))
    )
    (return (local.get $start) (local.get $len))
  )

  (func $convert_nucleotide (param $nuc i32) (result i32)
    (if (i32.eq (local.get $nuc) (i32.const 0x47)) (then (return (i32.const 0x43))))
    (if (i32.eq (local.get $nuc) (i32.const 0x43)) (then (return (i32.const 0x47))))
    (if (i32.eq (local.get $nuc) (i32.const 0x54)) (then (return (i32.const 0x41))))
    (if (i32.eq (local.get $nuc) (i32.const 0x41)) (then (return (i32.const 0x55))))
    (i32.const 0)
  )
)
