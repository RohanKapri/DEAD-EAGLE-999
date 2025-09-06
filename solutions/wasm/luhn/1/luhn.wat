;; For Shree DR.MDD
(module
  (memory (export "mem") 1)

  (func (export "valid") (param $strOffset i32) (param $strLength i32) (result i32)
    (local $idx i32) (local $num i32) (local $ch i32) (local $total i32)
    (local.set $idx (local.get $strLength)) (local.set $num (i32.const 0)) (local.set $total (i32.const 0))
    (loop $iterate
      (local.set $idx (i32.sub (local.get $idx) (i32.const 1)))
      (local.set $ch (i32.load8_u (i32.add (local.get $strOffset) (local.get $idx))))
      (if (i32.and (i32.ge_u (local.get $ch) (i32.const 48))
        (i32.le_u (local.get $ch) (i32.const 57)))
        (then (local.set $ch (i32.and (local.get $ch) (i32.const 15)))
          (local.set $total (i32.add (local.get $total) (select 
            (i32.sub (i32.shl (local.get $ch) (i32.const 1))
              (select (i32.const 0) (i32.const 9) (i32.le_u (local.get $ch) (i32.const 4)) ))
            (local.get $ch)
            (i32.and (local.get $num) (i32.const 1)))))
          (local.set $num (i32.add (local.get $num) (i32.const 1))))
        (else (if (i32.ne (local.get $ch) (i32.const 32)) (then (return (i32.const 0)))))) 
    (br_if $iterate (i32.gt_u (local.get $idx) (i32.const 0))))
    (return (i32.and (i32.gt_u (local.get $num) (i32.const 1))
      (i32.eqz (i32.rem_u (local.get $total) (i32.const 10))))) 
  )
)
