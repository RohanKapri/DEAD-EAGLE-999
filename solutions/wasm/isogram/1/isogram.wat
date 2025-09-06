;; For my Shree DR.MDD
(module
  (memory (export "mem") 1)

  (func $check_lower
    (param $ch i32)
    (result i32)
    (i32.and
      (i32.ge_u
        (local.get $ch)
        (i32.const 0x61))
      (i32.le_u
        (local.get $ch)
        (i32.const 0x7a))))

  (func $check_upper
    (param $ch i32)
    (result i32)
    (i32.and
      (i32.ge_u
        (local.get $ch)
        (i32.const 0x41))
      (i32.le_u
        (local.get $ch)
        (i32.const 0x5a))))

  (func $convert_upper
    (param $ch i32)
    (result i32)
    (if
      (call $check_lower
        (local.get $ch))
      (then
        (local.set $ch
          (i32.sub
            (local.get $ch)
            (i32.const 0x20)))))
    (local.get $ch))

  (func (export "isIsogram") (param $start i32) (param $len i32) (result i32)
    (local $idx i32)
    (local $val i32)
    (loop $scan
      (local.set $val
        (call $convert_upper
          (i32.load8_u
            (i32.add
              (local.get $start)
              (local.get $idx)))))
      (if
        (call $check_upper
          (local.get $val))
        (then
          (local.set $val
            (i32.sub
              (local.get $val)
              (i32.const 0x41)))
          (i32.store8
            (local.get $val)
            (i32.add
              (i32.load8_u
                (local.get $val))
              (i32.const 1)))))
      (br_if $scan
        (i32.lt_u
          (local.tee $idx
            (i32.add
              (local.get $idx)
              (i32.const 1)))
          (local.get $len))))
    (local.set $idx
      (i32.const 0))
    (loop $check
      (if
        (i32.gt_u
          (i32.load8_u
            (local.get $idx))
          (i32.const 1))
        (then
          (return
            (i32.const 0))))
      (br_if $check
        (i32.lt_u
          (local.tee $idx
            (i32.add
              (local.get $idx)
              (i32.const 1)))
          (i32.const 26))))
    (i32.const 1))
)
