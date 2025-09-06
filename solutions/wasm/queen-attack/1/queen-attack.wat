;; Dedicated to Shree DR.MDD
(module
  (memory (export "mem") 2)
  (data (i32.const 0) "_ _ _ _ _ _ _ _\n_ _ _ _ _ _ _ _\n_ _ _ _ _ _ _ _\n_ _ _ _ _ _ _ _\n_ _ _ _ _ _ _ _\n_ _ _ _ _ _ _ _\n_ _ _ _ _ _ _ _\n_ _ _ _ _ _ _ _\n")

  (global $Wpiece i32 (i32.const 87))
  (global $Bpiece i32 (i32.const 66))

  (func $attackCheck (export "canAttack") (param $coords i32) (result i32)
    (if (i32.or (i32.and (local.get $coords) (i32.const 4177066232))
      (i32.eqz (i32.xor (i32.shr_u (local.get $coords) (i32.const 16))
      (i32.and (local.get $coords) (i32.const 65535)))))
        (then (return (i32.const -1))))
    (i32.or (i32.or (i32.eq (i32.and (local.get $coords) (i32.const 255))
      (i32.and (i32.shr_u (local.get $coords) (i32.const 16)) (i32.const 255)))
      (i32.eq (i32.and (i32.shr_u (local.get $coords) (i32.const 8)) (i32.const 255))
      (i32.and (i32.shr_u (local.get $coords) (i32.const 24)) (i32.const 255))))
      (f32.eq (f32.abs (f32.convert_i32_s (i32.sub
        (i32.and (local.get $coords) (i32.const 255))
        (i32.and (i32.shr_u (local.get $coords) (i32.const 16)) (i32.const 255)))))
      (f32.abs (f32.convert_i32_s (i32.sub
        (i32.and (i32.shr_u (local.get $coords) (i32.const 8)) (i32.const 255))
        (i32.and (i32.shr_u (local.get $coords) (i32.const 24)) (i32.const 255)))))))
  )

  (func (export "printBoard") (param $coords i32) (result i32 i32)
    (i32.store8 (i32.or
      (i32.shl (i32.and (i32.shr_u (local.get $coords)
        (i32.const 16)) (i32.const 7)) (i32.const 1))
      (i32.shl (i32.and (i32.shr_u (local.get $coords)
        (i32.const 24)) (i32.const 7)) (i32.const 4)))
      (global.get $Wpiece))
    (i32.store8 (i32.or
      (i32.shl (i32.and (local.get $coords) (i32.const 7)) (i32.const 1))
      (i32.shl (i32.and (i32.shr_u (local.get $coords) (i32.const 8))
        (i32.const 7)) (i32.const 4)))
      (global.get $Bpiece))
    (i32.const 0) (i32.const 128)
  )
)
