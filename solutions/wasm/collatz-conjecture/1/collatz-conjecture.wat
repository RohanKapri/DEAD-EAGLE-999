(module
  (export "steps" (func $steps))
  (func $steps (param $number i32) (param $stepcount i32) (result i32)
    (if (i32.eq (local.get $number) (i32.const 1))
      (return (local.get $stepcount)))
    
    (if (i32.le_s (local.get $number) (i32.const 0))
      (return (i32.const -1)))
    
    (local.set $stepcount (i32.add (local.get $stepcount) (i32.const 1)))
    
    (i32.and (local.get $number) (i32.const 1))
    if ;; number is odd
      (local.set $number (i32.add (i32.mul (local.get $number) (i32.const 3)) (i32.const 1)))
    else
      (local.set $number (i32.shr_u (local.get $number) (i32.const 1)))
    end
    
    local.get $number
    local.get $stepcount
    call $steps))