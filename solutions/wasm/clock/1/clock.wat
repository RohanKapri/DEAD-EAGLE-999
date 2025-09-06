(module
  (memory (export "mem") 1)
  (func $calchandm (param $hour i32) (param $minute i32) (result i32 i32)
    (local $h i32) (local $m i32)
    (local.set $h (local.get $hour))
    (local.set $m (local.get $minute))
    (loop $minute1
      (if (i32.lt_s (local.get $m) (i32.const 0))
      (then 
        (local.set $m (i32.add (local.get $m) (i32.const 60)))
        (local.set $h (i32.sub (local.get $h) (i32.const 1)))
        br $minute1
      ))
    )
    (loop $minute2
      (if (i32.ge_s (local.get $m) (i32.const 60))
      (then 
        (local.set $m (i32.sub (local.get $m) (i32.const 60)))
        (local.set $h (i32.add (local.get $h) (i32.const 1)))
        br $minute2
      ))
    )
    (loop $hour1
      (if (i32.lt_s (local.get $h) (i32.const 0))
      (then 
        (local.set $h (i32.add (local.get $h) (i32.const 24)))
        br $hour1
      ))
    )
    (loop $hour2
      (if (i32.ge_s (local.get $h) (i32.const 24))
      (then 
        (local.set $h (i32.sub (local.get $h) (i32.const 24)))
        br $hour2
      ))
    )
    (return
      (local.get $h)
      (local.get $m)
    )
  )
  ;;
  ;; add minutes to a clock's time
  ;;
  ;; @param {i32} $hour - the hours on the clock
  ;; @param {i32} $minute - the minutes on the clock
  ;; @param {i32} $increase - the minutes to add
  ;;
  ;; @returns {(i32,i32)} - the hours and minutes shown on the clock
  ;;
  (func (export "plus") (param $hour i32) (param $minute i32) (param $increase i32) (result i32 i32)
    (call $calchandm (local.get $hour) (i32.add(local.get $minute) (local.get $increase)))
  )
  ;;
  ;; remove minutes from a clock's time
  ;;
  ;; @param {i32} $hour - the hours on the clock
  ;; @param {i32} $minute - the minutes on the clock
  ;; @param {i32} $decrease - the minutes to add
  ;;
  ;; @returns {(i32,i32)} - the hours and minutes shown on the clock
  ;;
  (func (export "minus") (param $hour i32) (param $minute i32) (param $decrease i32) (result i32 i32)
     (call $calchandm (local.get $hour) (i32.sub(local.get $minute) (local.get $decrease)))
  )

  ;;
  ;; formats the clock as "HH:MM" string
  ;;
  ;; @param {i32} $hour - the hours on the clock
  ;; @param {i32} $minute - the minutes on the clock
  ;;
  ;; @returns {(i32,i32)} - the offset and length of the output string in linear memory
  ;;
  (func (export "toString") (param $hour i32) (param $minute i32) (result i32 i32)
    (local $h i32) (local $m i32)
    (call $calchandm (local.get $hour) (local.get $minute))
    (local.set $m)
    (local.set $h)
    (i32.store8 (i32.const 0) (i32.add (i32.div_u (local.get $h) (i32.const 10)) (i32.const 48)))
    (i32.store8 (i32.const 1) (i32.add (i32.rem_u (local.get $h) (i32.const 10)) (i32.const 48)))
    (i32.store8 (i32.const 2) (i32.const 58))
    (i32.store8 (i32.const 3) (i32.add (i32.div_u (local.get $m) (i32.const 10)) (i32.const 48)))
    (i32.store8 (i32.const 4) (i32.add (i32.rem_u (local.get $m) (i32.const 10)) (i32.const 48)))
    (return (i32.const 0) (i32.const 5))
  )

  ;;
  ;; checks if two clocks show the same time
  ;;
  ;; @param {i32} $hourA - the hours on the first clock
  ;; @param {i32} $minuteA - the minutes on the first clock
  ;; @param {i32} $hourB - the hours on the second clock
  ;; @param {i32} $minuteB - the minutes on the second clock
  ;;
  ;; @returns {i32} - 1 if they are equal, 0 if not
  ;;
  (func (export "equals") (param $hourA i32) (param $minuteA i32)
    (param $hourB i32) (param $minuteB i32) (result i32)
    (local $hA i32) (local $mA i32) (local $hB i32) (local $mB i32)
    (call $calchandm (local.get $hourA) (local.get $minuteA))
    (local.set $hA)
    (local.set $mA)
    (call $calchandm (local.get $hourB) (local.get $minuteB))
    (local.set $hB)
    (local.set $mB)
    (i32.and (i32.eq (local.get $hA) (local.get $hB)) (i32.eq (local.get $mA) (local.get $mB)))
  )
)