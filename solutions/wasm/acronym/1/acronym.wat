(module
  (memory (export "mem") 1)

  (func (export "parse") (param $offset i32) (param $length i32) (result i32 i32)
    (local $acronym_length i32)(local $i i32)(local $char i32)(local $pick_next i32)
    (local.set $pick_next (i32.const 1))
    (loop $l
      (local.set $char (i32.load8_u (i32.add(local.get $offset)(local.get $i))))
      (if (i32.and(local.get $pick_next)(i32.or
        (i32.and(i32.ge_u(local.get $char)(i32.const 0x41))(i32.le_u(local.get $char)(i32.const 0x5A)))
        (i32.and(i32.ge_u(local.get $char)(i32.const 0x61))(i32.le_u(local.get $char)(i32.const 0x7A)))))
        (then 
          (i32.store8(i32.add(local.get $offset)(local.get $acronym_length))(select(local.get $char)(i32.sub(local.get $char)(i32.const 0x20))(i32.le_u(local.get $char)(i32.const 0x5A))))
          (local.set $acronym_length (i32.add(local.get $acronym_length)(i32.const 1)))
          (local.set $pick_next (i32.const 0)))
      )
      (if (i32.or(i32.eq(local.get $char)(i32.const 0x20))(i32.eq(local.get $char)(i32.const 0x2D)))
          (then (local.set $pick_next (i32.const 1)))
        )
      (local.set $i (i32.add(local.get $i)(i32.const 1)))
      (br_if $l (i32.lt_u(local.get $i)(local.get $length)))
    )
    (return (local.get $offset) (local.get $acronym_length))
  )
)