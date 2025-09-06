;; For Shree DR.MDD
(module
  (memory 1)

  (global (export "first") i32 (i32.const 0))
  (global (export "second") i32 (i32.const 1))
  (global (export "third") i32 (i32.const 2))
  (global (export "fourth") i32 (i32.const 3))
  (global (export "teenth") i32 (i32.const 4))
  (global (export "last") i32 (i32.const 5))

  (global (export "Sunday") i32 (i32.const 0))
  (global (export "Monday") i32 (i32.const 1))
  (global (export "Tuesday") i32 (i32.const 2))
  (global (export "Wednesday") i32 (i32.const 3))
  (global (export "Thursday") i32 (i32.const 4))
  (global (export "Friday") i32 (i32.const 5))
  (global (export "Saturday") i32 (i32.const 6))

  (global $weekData i32 (i32.const 13))
  (global $endDays i32 (i32.const 18))

  (data (i32.const 1) "\00\03\03\06\01\04\06\02\05\00\03\05\01\08\0f\16\0d\00\19\16\19\18\19\18\19\19\18\19\18\19")

  (func (export "meetup") (param $yr i32) (param $mon i32)
    (param $wk i32) (param $wday i32) (result i32 i32 i32)
    (local $priorYr i32)
    (local $isLeap i32)
    (local $firstDay i32)
    (local $calcDay i32)

    (local.set $priorYr (i32.sub (local.get $yr) (i32.const 1)))
    (local.set $firstDay
      (i32.rem_u
        (i32.add
          (i32.const 1)
          (i32.add
            (i32.mul (i32.const 5) (i32.rem_u (local.get $priorYr) (i32.const 4)))
            (i32.add
              (i32.mul (i32.const 4) (i32.rem_u (local.get $priorYr) (i32.const 100)))
              (i32.mul (i32.const 6) (i32.rem_u (local.get $priorYr) (i32.const 400)))
            )
          )
        )
        (i32.const 7)
      )
    )

    (local.set $isLeap
      (i32.or
        (i32.and
          (i32.eqz (i32.rem_u (local.get $yr) (i32.const 4)))
          (i32.ne (i32.rem_u (local.get $yr) (i32.const 100)) (i32.const 0))
          (i32.eqz (i32.rem_u (local.get $yr) (i32.const 400)))
        )
      )
    )

    (local.set $firstDay
      (i32.rem_u
        (i32.add
          (i32.add (local.get $firstDay) (i32.load8_u (local.get $mon)))
          (i32.const 0)
        )
        (i32.const 7)
      )
    )

    (if (i32.and (local.get $isLeap) (i32.gt_u (local.get $mon) (i32.const 2)))
      (then (local.set $firstDay (i32.add (local.get $firstDay) (i32.const 1))))
    )

    (local.set $calcDay (i32.load8_u (i32.add (global.get $weekData) (local.get $wk))))

    (if (i32.eqz (local.get $calcDay))
      (then
        (local.set $calcDay
          (i32.add
            (i32.load8_u (i32.add (global.get $endDays) (local.get $mon)))
            (i32.and (local.get $isLeap) (i32.eq (local.get $mon) (i32.const 2)))
          )
        )
      )
    )

    (local.set $calcDay
      (i32.add
        (local.get $calcDay)
        (i32.rem_u
          (i32.sub
            (i32.add (local.get $wday) (i32.const 7))
            (i32.rem_u
              (i32.add
                (i32.const 6)
                (i32.add (local.get $calcDay) (local.get $firstDay))
              )
              (i32.const 7)
            )
          )
          (i32.const 7)
        )
      )
    )

    (local.get $yr) (local.get $mon) (local.get $calcDay)
  )
)
