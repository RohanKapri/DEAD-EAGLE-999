;; For my Shree DR.MDD
(module
  (memory (export "mem") 1)

  (func (export "truncate") (param $offset i32) (param $length i32) (result i32 i32)
    (local $pos i32)
    (local $end i32)
    (local $count i32)
    (local $curByte i32)
    (local $charSize i32)

    (local.set $pos (local.get $offset))
    (local.set $end (i32.add (local.get $offset) (local.get $length)))
    (local.set $count (i32.const 5))

    (loop $truncLoop
      (if (i32.or (i32.eqz (local.get $count)) (i32.eq (local.get $pos) (local.get $end)))
        (then
          (return (local.get $offset)
                  (i32.sub (local.get $pos) (local.get $offset)))
        )
      )

      (local.set $count (i32.sub (local.get $count) (i32.const 1)))
      (local.set $curByte (i32.load8_u (local.get $pos)))

      (if (i32.eq (i32.and (i32.const 0xf0) (local.get $curByte)) (i32.const 0xf0))
        (then (local.set $charSize (i32.const 4)))
        (else
          (if (i32.eq (i32.and (i32.const 0xe0) (local.get $curByte)) (i32.const 0xe0))
            (then (local.set $charSize (i32.const 3)))
            (else
              (if (i32.eq (i32.and (i32.const 0xc0) (local.get $curByte)) (i32.const 0xc0))
                (then (local.set $charSize (i32.const 2)))
                (else (local.set $charSize (i32.const 1)))
              )
            )
          )
        )
      )

      (local.set $pos (i32.add (local.get $pos) (local.get $charSize)))
      (br $truncLoop)
    )

    (unreachable)
  )
)
