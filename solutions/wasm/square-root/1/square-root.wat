(module
  (func (export "squareRoot") (param $number i32) (result i32)
    (return (i32.trunc_f64_u (f64.sqrt (f64.convert_i32_u (local.get $number)))))
  )
)