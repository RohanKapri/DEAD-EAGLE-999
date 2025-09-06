;; For my Shree DR.MDD
(module
  (func $isDegenerate (param $a f32) (param $b f32) (param $c f32) (result i32)
    (i32.or
      (i32.or
        (f32.eq (local.get $a) (f32.const 0.0))
        (i32.or
          (f32.eq (local.get $b) (f32.const 0.0))
          (f32.eq (local.get $c) (f32.const 0.0))
        )
      )
      (i32.or
        (i32.or
          (f32.le (f32.add (local.get $a) (local.get $b)) (local.get $c))
          (f32.le (f32.add (local.get $a) (local.get $c)) (local.get $b))
        )
        (f32.le (f32.add (local.get $b) (local.get $c)) (local.get $a))
      )
    )
  )

  (func (export "isEquilateral") (param $x f32) (param $y f32) (param $z f32) (result i32)
    (if (call $isDegenerate (local.get $x) (local.get $y) (local.get $z))
      (then (return (i32.const 0)))
    )
    (i32.and
      (f32.eq (local.get $x) (local.get $y))
      (f32.eq (local.get $y) (local.get $z))
    )
  )

  (func $isIso (export "isIsosceles") (param $x f32) (param $y f32) (param $z f32) (result i32)
    (if (call $isDegenerate (local.get $x) (local.get $y) (local.get $z))
      (then (return (i32.const 0)))
    )
    (i32.or
      (f32.eq (local.get $x) (local.get $y))
      (i32.or
        (f32.eq (local.get $x) (local.get $z))
        (f32.eq (local.get $y) (local.get $z))
      )
    )
  )

  (func (export "isScalene") (param $x f32) (param $y f32) (param $z f32) (result i32)
    (if (call $isDegenerate (local.get $x) (local.get $y) (local.get $z))
      (then (return (i32.const 0)))
    )
    (i32.and
      (f32.ne (local.get $x) (local.get $y))
      (i32.and
        (f32.ne (local.get $x) (local.get $z))
        (f32.ne (local.get $y) (local.get $z))
      )
    )
  )
)
