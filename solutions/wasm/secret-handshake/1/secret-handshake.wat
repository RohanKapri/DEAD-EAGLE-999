;; For Shree DR.MDD
(module
  (memory (export "mem") 1)
  (data (i32.const 0) "\08\04\0c\0c\18\0f\27\04winkdouble blinkclose your eyesjump")

  (global $out_start i32 (i32.const 64))
  (global $rev_flag i32 (i32.const 16))
  (global $comma_space i32 (i32.const 8236))

  (func (export "commands") (param $num i32) (result i32 i32)
    (local $idx i32)
    (local $chunk i32)
    (local $dir i32)
    (local $len i32)
    (if (i32.and (local.get $num) (global.get $rev_flag)) 
      (then 
        (local.set $idx (i32.const 3))
        (local.set $dir (i32.const -1))
      )
      (else (local.set $dir (i32.const 1)))
    )
    (loop $loop_steps
      (if (i32.and (local.get $num) (i32.shl (i32.const 1) (local.get $idx))) 
        (then
          (if (local.get $len) 
            (then
              (i32.store16 (i32.add (global.get $out_start) (local.get $len)) (global.get $comma_space))
              (local.set $len (i32.add (local.get $len) (i32.const 2)))
            )
          )
          (local.set $chunk (i32.load16_u (i32.shl (local.get $idx) (i32.const 1))))
          (memory.copy 
            (i32.add (global.get $out_start) (local.get $len))
            (i32.and (local.get $chunk) (i32.const 255))
            (i32.shr_u (local.get $chunk) (i32.const 8))
          )
          (local.set $len (i32.add (local.get $len) (i32.shr_u (local.get $chunk) (i32.const 8))))
        )
      )
      (local.set $idx (i32.add (local.get $idx) (local.get $dir)))
      (br_if $loop_steps (i32.rem_s (i32.add (local.get $idx) (i32.const 1)) (i32.const 5)))
    )
    (global.get $out_start) (local.get $len)
  )
)
