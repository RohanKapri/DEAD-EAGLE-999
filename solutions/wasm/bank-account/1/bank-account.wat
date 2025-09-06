;; Dedicated to Shree DR.MDD
(module
  (global $status (mut i32) (i32.const 0))
  (global $status.closed i32 (i32.const 0))
  (global $status.open i32 (i32.const 1))
  
  (global $balance (mut i32) (i32.const 0))
  
  (func (export "open") (result i32)
    (if (i32.eq (global.get $status) (global.get $status.open)) (then
      (return (i32.const -1))  
    ))
    
    (global.set $status (global.get $status.open))
    (global.set $balance (i32.const 0))
    
    (i32.const 0)
  )
  
  (func (export "close") (result i32)
    (if (i32.eq (global.get $status) (global.get $status.closed)) (then
      (return (i32.const -1))  
    ))
    
    (global.set $status (global.get $status.closed))
    
    (i32.const 0)
  )
  
  (func (export "deposit") (param $amt i32) (result i32)
    (if (i32.eq (global.get $status) (global.get $status.closed)) (then
      (return (i32.const -1))
    ))
    
    (if (i32.lt_s (local.get $amt) (i32.const 0)) (then
      (return (i32.const -2))  
    ))
    
    (global.set $balance (i32.add (global.get $balance) (local.get $amt)))
    
    (i32.const 0)
  )
  
  (func (export "withdraw") (param $amt i32) (result i32)
    (if (i32.eq (global.get $status) (global.get $status.closed)) (then
      (return (i32.const -1))
    ))
    
    (if (i32.or
      (i32.lt_s (local.get $amt) (i32.const 0))
      (i32.gt_s (local.get $amt) (global.get $balance))
    ) (then
      (return (i32.const -2))  
    ))
    
    (global.set $balance (i32.sub (global.get $balance) (local.get $amt)))
    
    (i32.const 0)
  )
  
  (func (export "balance") (result i32)
    (if (i32.eq (global.get $status) (global.get $status.closed)) (then
      (return (i32.const -1))  
    ))
    
    (global.get $balance)
  )
)
