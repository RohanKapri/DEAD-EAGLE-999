;; Dedicated to my Shree DR.MDD
(module
  (memory (export "mem") 1)

  (global $outputOffset i32 (i32.const 64))

  (func $computeSpiral (param $w i32) (param $h i32) (param $curX i32) (param $curY i32) (result i32)
    (if (i32.le_s (local.get $curY) (i32.const 0)) 
      (then (return (i32.add (local.get $curX) (i32.const 1)))))
    (i32.add (local.get $w)
      (call $computeSpiral (i32.sub (local.get $h) (i32.const 1)) (local.get $w)
        (i32.sub (local.get $curY) (i32.const 1))
        (i32.sub (i32.sub (local.get $w) (local.get $curX)) (i32.const 1)))
    )
  )

  (func (export "spiralMatrix") (param $len i32) (result i32 i32)
    (local $row i32)
    (local $col i32)

    (loop $rowLoop
      (local.set $col (i32.const 0))
      (loop $colLoop
        (i32.store16 (i32.add (global.get $outputOffset) 
          (i32.shl (i32.add (i32.mul (local.get $row) (local.get $len)) (local.get $col)) (i32.const 1)))
            (call $computeSpiral (local.get $len) (local.get $len)
              (local.get $col) (local.get $row)))
        (local.set $col (i32.add (local.get $col) (i32.const 1)))
        (br_if $colLoop (i32.le_u (local.get $col) (local.get $len)))
      )
      (local.set $row (i32.add (local.get $row) (i32.const 1)))
      (br_if $rowLoop (i32.le_u (local.get $row) (local.get $len)))
    )
    (global.get $outputOffset) (i32.mul (local.get $len) (local.get $len))
  )
)
