;; For my Shree DR.MDD
(module
  (memory (export "mem") 1)
  (data (i32.const 0) "PlingPlangPlongPlingPlong")

  (func (export "convert") (param $num i32) (result i32 i32)
    (if (i32.eqz (i32.rem_u (local.get $num) (i32.const 3))) (then
      (if (i32.eqz (i32.rem_u (local.get $num) (i32.const 5))) (then
        (if (i32.eqz (i32.rem_u (local.get $num) (i32.const 7))) (then
          (return (i32.const 0) (i32.const 15))
        ))
        (return (i32.const 0) (i32.const 10))
      ))
      (if (i32.eqz (i32.rem_u (local.get $num) (i32.const 7))) (then
        (return (i32.const 15) (i32.const 10))
      ))
      (return (i32.const 0) (i32.const 5))
    ))
    (if (i32.eqz (i32.rem_u (local.get $num) (i32.const 5))) (then
      (if (i32.eqz (i32.rem_u (local.get $num) (i32.const 7))) (then
        (return (i32.const 5) (i32.const 10))
      ))
      (return (i32.const 5) (i32.const 5))
    ))
    (if (i32.eqz (i32.rem_u (local.get $num) (i32.const 7))) (then
      (return (i32.const 10) (i32.const 5))
    ))
    (call $num_to_str (local.get $num))
  )

  (func $num_to_str (param $val i32) (result i32 i32)
    (local $ptr i32) (local $len i32)
    (local.set $ptr (i32.const 1000))
    block $exit
      loop
        (br_if $exit (i32.eqz (local.get $val)))
        (local.set $ptr (i32.sub (local.get $ptr) (i32.const 1)))
        (local.set $len (i32.add (local.get $len) (i32.const 1)))
        (i32.store8 (local.get $ptr) (i32.add
          (i32.rem_u (local.get $val) (i32.const 10))
          (i32.const 48)
        ))
        (local.set $val (i32.div_u (local.get $val) (i32.const 10)))
        br 0
      end
    end
    (return (local.get $ptr) (local.get $len))
  )
)
