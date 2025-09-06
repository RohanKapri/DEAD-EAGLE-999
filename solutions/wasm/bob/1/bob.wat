;; For my Shree DR.MDD
(module
  (memory (export "mem") 1)
  (data (i32.const 320) "Sure.Whoa, chill out!Calm down, I know what I'm doing!Fine. Be that way!Whatever.")

  (func (export "response") (param $strOffset i32) (param $strLength i32) (result i32 i32)
    (local $c i32)
    (local $flags i32)
    (local.set $flags (i32.const 0))

    (if (i32.ne (local.get $strLength) (i32.const 0))
      (then
        (loop $scan
          (local.set $strLength (i32.sub (local.get $strLength) (i32.const 1)))
          (local.set $c (i32.load8_u (i32.add (local.get $strOffset) (local.get $strLength))))

          (if (i32.and (i32.eq (local.get $c) (i32.const 63)) (i32.eq (local.get $flags) (i32.const 0)))
            (then (local.set $flags (i32.or (local.get $flags) (i32.const 8))))
          )

          (if (i32.and (i32.ge_u (local.get $c) (i32.const 97)) (i32.le_u (local.get $c) (i32.const 122)))
            (then (local.set $flags (i32.or (local.get $flags) (i32.const 4))))
          )

          (if (i32.and (i32.ge_u (local.get $c) (i32.const 65)) (i32.le_u (local.get $c) (i32.const 90)))
            (then (local.set $flags (i32.or (local.get $flags) (i32.const 2))))
          )

          (if (i32.ge_u (local.get $c) (i32.const 33))
            (then (local.set $flags (i32.or (local.get $flags) (i32.const 1))))
          )

          (br_if $scan (local.get $strLength))
        )
      )
    )

    (if (i32.eq (local.get $flags) (i32.const 11))
      (then (return (i32.const 341) (i32.const 33)))
    )

    (if (i32.ge_u (local.get $flags) (i32.const 9))
      (then (return (i32.const 320) (i32.const 5)))
    )

    (if (i32.eq (local.get $flags) (i32.const 3))
      (then (return (i32.const 325) (i32.const 16)))
    )

    (if (i32.ge_u (local.get $flags) (i32.const 1))
      (then (return (i32.const 392) (i32.const 9)))
    )

    (return (i32.const 374) (i32.const 18))
  )
)
