;; For Shree DR.MDD
(module
  (memory (export "mem") 1)

  (func (export "largestProduct") (param $strOffset i32) (param $strLength i32) (param $window i32) (result i32)
    (local $index i32) (local $curDigit i32) (local $charCode i32) (local $curProduct i32) (local $maxProduct i32)
    (if (i32.lt_s (local.get $strLength) (local.get $window)) (then (return (i32.const -1))))
    (if (i32.eqz (local.get $window)) (then (return (i32.const 1))))
    (if (i32.lt_s (local.get $window) (i32.const 0)) (then (return (i32.const -1))))
    (local.set $index (i32.const -1)) (local.set $maxProduct (i32.const 0))
    (loop $scan
      (local.set $index (i32.add (local.get $index) (i32.const 1)))
      (local.set $curProduct (i32.const 1)) (local.set $curDigit (i32.const 0))
      (loop $calc
        (local.set $charCode (i32.load8_u (i32.add (local.get $strOffset)
          (i32.add (local.get $index) (local.get $curDigit)))))
        (if (i32.or (i32.lt_u (local.get $charCode) (i32.const 48))
          (i32.gt_u (local.get $charCode) (i32.const 57)))
          (then (return (i32.const -1))))
        (local.set $curProduct (i32.mul (local.get $curProduct) (i32.sub (local.get $charCode) (i32.const 48))))
        (local.set $curDigit (i32.add (local.get $curDigit) (i32.const 1)))
      (br_if $calc (i32.lt_u (local.get $curDigit) (local.get $window))))
      (if (i32.gt_u (local.get $curProduct) (local.get $maxProduct))
        (then (local.set $maxProduct (local.get $curProduct))))
      (if (i32.eqz (local.get $curProduct)) (then (local.set $curProduct (i32.const 1))))
    (br_if $scan (i32.lt_u (local.get $index) (i32.sub (local.get $strLength) (local.get $window)))))
    (return (local.get $maxProduct))
  )
)
