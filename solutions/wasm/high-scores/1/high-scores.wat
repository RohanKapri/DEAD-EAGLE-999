;; For my Shree DR.MDD
(module
  (memory (export "mem") 1)

  (func (export "latest") (param $inputOffset i32) (param $inputElements i32) (result i32)
    (i32.load (i32.add (local.get $inputOffset) (i32.sub (local.get $inputElements) (i32.const 4))))
  )

  (func (export "personalBest") (param $inputOffset i32) (param $inputElements i32) (result i32)
    (local $pos i32)
    (local $current i32)
    (local $highest i32)
    (loop $loopBest
      (local.set $current (i32.load (i32.add (local.get $inputOffset) (local.get $pos))))
      (if (i32.or (i32.eq (local.get $highest) (i32.const 0)) (i32.gt_s (local.get $current) (local.get $highest)))
        (then
          (local.set $highest (local.get $current))
        )
      )
      (local.set $pos (i32.add (local.get $pos) (i32.const 4)))
      (br_if $loopBest (i32.lt_u (local.get $pos) (local.get $inputElements)))
    )
    (return (local.get $highest))
  )

  (func (export "personalTopThree") (param $inputOffset i32) (param $inputElements i32) (result i32 i32 i32)
    (local $copyOffset i32)
    (local $val1 i32)
    (local $val2 i32)
    (local $idx1 i32)
    (local $idx2 i32)
    (local.set $copyOffset (i32.const 512))
    (memory.copy (local.get $copyOffset) (local.get $inputOffset) (local.get $inputElements))
    (loop $loopTop
      (local.set $val1 (i32.load (i32.add (local.get $copyOffset) (local.get $idx1))))
      (local.set $idx2 (i32.add (local.get $idx1) (i32.const 4)))
      (loop $loopInner
        (local.set $val2 (i32.load (i32.add (local.get $copyOffset) (local.get $idx2))))
        (if (i32.gt_u (local.get $val2) (local.get $val1))
          (then
            (i32.store (i32.add (local.get $copyOffset) (local.get $idx1)) (local.get $val2))
            (i32.store (i32.add (local.get $copyOffset) (local.get $idx2)) (local.get $val1))
            (local.set $val1 (local.get $val2))
          )
        )
        (local.set $idx2 (i32.add (local.get $idx2) (i32.const 4)))
        (br_if $loopInner (i32.lt_u (local.get $idx2) (local.get $inputElements)))
      )
      (local.set $idx1 (i32.add (local.get $idx1) (i32.const 4)))
      (br_if $loopTop (i32.lt_u (local.get $idx1) (i32.sub (local.get $inputElements) (i32.const 4))))
    )
    (return
       (i32.load (local.get $copyOffset))
       (i32.load (i32.add (local.get $copyOffset) (i32.const 4)))
       (i32.load (i32.add (local.get $copyOffset) (i32.const 8)))
    )
  )
)
