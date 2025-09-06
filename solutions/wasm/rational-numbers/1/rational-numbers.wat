(module
  ;; GCD using Euclidean algorithm
  (func $gcd (param $a i32) (param $b i32) (result i32)
    ;; Get absolute values
    (local.set $a (select (i32.sub (i32.const 0) (local.get $a)) (local.get $a) (i32.lt_s (local.get $a) (i32.const 0))))
    (local.set $b (select (i32.sub (i32.const 0) (local.get $b)) (local.get $b) (i32.lt_s (local.get $b) (i32.const 0))))
    
    ;; Special cases
    (if (i32.eqz (local.get $a)) (then (return (select (i32.const 1) (local.get $b) (i32.eqz (local.get $b))))))
    (if (i32.eqz (local.get $b)) (then (return (local.get $a))))
    
    ;; Euclidean algorithm
    (loop $gcd_loop
      (if (i32.eqz (local.get $b))
        (then (return (local.get $a)))
        (else
          (local.set $a (i32.rem_s (local.get $a) (local.get $b)))
          (local.set $b (i32.xor (local.get $a) (local.get $b)))
          (local.set $a (i32.xor (local.get $a) (local.get $b)))
          (local.set $b (i32.xor (local.get $a) (local.get $b)))
          (br $gcd_loop)
        )
      )
    )
    (i32.const 1) ;; Unreachable
  )

  ;; Reduce rational number
  (func $reduce (param $num i32) (param $den i32) (result i32 i32)
    (local $gcd i32)
    (local $new_num i32)
    (local $new_den i32)
    
    ;; Handle zero numerator
    (if (i32.eqz (local.get $num))
      (then (return (i32.const 0) (i32.const 1)))
    )
    
    ;; Ensure positive denominator
    (if (i32.lt_s (local.get $den) (i32.const 0))
      (then
        (local.set $num (i32.sub (i32.const 0) (local.get $num)))
        (local.set $den (i32.sub (i32.const 0) (local.get $den)))
      )
    )
    
    ;; Reduce with GCD
    (local.set $gcd (call $gcd (local.get $num) (local.get $den)))
    (local.set $new_num (i32.div_s (local.get $num) (local.get $gcd)))
    (local.set $new_den (i32.div_s (local.get $den) (local.get $gcd)))
    
    (local.get $new_num)
    (local.get $new_den)
  )

  ;; Add two rational numbers
  (func (export "add") (param $numA i32) (param $denA i32) (param $numB i32) (param $denB i32) (result i32 i32)
    (local $result_num i32)
    (local $result_den i32)
    
    ;; Calculate (a1*b2 + a2*b1)/(b1*b2)
    (local.set $result_num 
      (i32.add 
        (i32.mul (local.get $numA) (local.get $denB))
        (i32.mul (local.get $numB) (local.get $denA))
      )
    )
    (local.set $result_den (i32.mul (local.get $denA) (local.get $denB)))
    
    (call $reduce (local.get $result_num) (local.get $result_den))
  )

  ;; Subtract two rational numbers
  (func (export "sub") (param $numA i32) (param $denA i32) (param $numB i32) (param $denB i32) (result i32 i32)
    (local $result_num i32)
    (local $result_den i32)
    
    ;; Calculate (a1*b2 - a2*b1)/(b1*b2)
    (local.set $result_num 
      (i32.sub 
        (i32.mul (local.get $numA) (local.get $denB))
        (i32.mul (local.get $numB) (local.get $denA))
      )
    )
    (local.set $result_den (i32.mul (local.get $denA) (local.get $denB)))
    
    (call $reduce (local.get $result_num) (local.get $result_den))
  )

  ;; Multiply two rational numbers
  (func (export "mul") (param $numA i32) (param $denA i32) (param $numB i32) (param $denB i32) (result i32 i32)
    (local $result_num i32)
    (local $result_den i32)
    
    ;; Calculate (a1*a2)/(b1*b2)
    (local.set $result_num (i32.mul (local.get $numA) (local.get $numB)))
    (local.set $result_den (i32.mul (local.get $denA) (local.get $denB)))
    
    (call $reduce (local.get $result_num) (local.get $result_den))
  )

  ;; Divide two rational numbers
  (func (export "div") (param $numA i32) (param $denA i32) (param $numB i32) (param $denB i32) (result i32 i32)
    (local $result_num i32)
    (local $result_den i32)
    
    ;; Calculate (a1*b2)/(b1*a2)
    (local.set $result_num (i32.mul (local.get $numA) (local.get $denB)))
    (local.set $result_den (i32.mul (local.get $denA) (local.get $numB)))
    
    (call $reduce (local.get $result_num) (local.get $result_den))
  )

  ;; Absolute value of a rational number
  (func (export "abs") (param $num i32) (param $den i32) (result i32 i32)
    (local $abs_num i32)
    (local $abs_den i32)
    
    ;; Take absolute value
    (local.set $abs_num (select (i32.sub (i32.const 0) (local.get $num)) (local.get $num) (i32.lt_s (local.get $num) (i32.const 0))))
    (local.set $abs_den (select (i32.sub (i32.const 0) (local.get $den)) (local.get $den) (i32.lt_s (local.get $den) (i32.const 0))))
    
    (call $reduce (local.get $abs_num) (local.get $abs_den))
  )

  ;; Binary exponentiation for integer power
  (func $pow (param $base i32) (param $exp i32) (result i32)
    (local $result i32)
    
    (local.set $result (i32.const 1))
    
    (block $done
      (loop $loop
        (if (i32.eqz (local.get $exp)) (br $done))
        
        ;; If exp is odd, multiply result by base
        (if (i32.and (local.get $exp) (i32.const 1))
          (then (local.set $result (i32.mul (local.get $result) (local.get $base))))
        )
        
        ;; Divide exp by 2
        (local.set $exp (i32.shr_u (local.get $exp) (i32.const 1)))
        
        ;; If exp is zero, we're done
        (if (i32.eqz (local.get $exp)) (br $done))
        
        ;; Square the base
        (local.set $base (i32.mul (local.get $base) (local.get $base)))
        
        (br $loop)
      )
    )
    
    (local.get $result)
  )

  ;; Exponentiate a rational number to an integer power
  (func (export "exprational") (param $num i32) (param $den i32) (param $exp i32) (result i32 i32)
    (local $result_num i32)
    (local $result_den i32)
    
    ;; Handle special cases
    (if (i32.eqz (local.get $exp)) (return (i32.const 1) (i32.const 1)))
    (if (i32.eqz (local.get $num)) (return (i32.const 0) (i32.const 1)))
    
    (if (i32.lt_s (local.get $exp) (i32.const 0))
      (then
        ;; Negative exponent: swap numerator and denominator, use positive exponent
        (local.set $result_num (call $pow (local.get $den) (i32.sub (i32.const 0) (local.get $exp))))
        (local.set $result_den (call $pow (local.get $num) (i32.sub (i32.const 0) (local.get $exp))))
      )
      (else
        ;; Positive exponent
        (local.set $result_num (call $pow (local.get $num) (local.get $exp)))
        (local.set $result_den (call $pow (local.get $den) (local.get $exp)))
      )
    )
    
    (call $reduce (local.get $result_num) (local.get $result_den))
  )

  ;; Export the reduce function
  (func (export "reduce") (param $num i32) (param $den i32) (result i32 i32)
    (call $reduce (local.get $num) (local.get $den))
  )

  ;; Exponential function using Taylor series (optimized)
  (func $exp (param $x f64) (result f64)
    (local $result f64)
    (local $term f64)
    (local $n i32)
    
    (local.set $result (f64.const 1.0))
    (local.set $term (f64.const 1.0))
    
    ;; Calculate exp(x) ≈ 1 + x + x²/2! + x³/3! + ...
    (loop $exp_loop
      (local.set $n (i32.add (local.get $n) (i32.const 1)))
      (local.set $term (f64.div (f64.mul (local.get $term) (local.get $x)) (f64.convert_i32_s (local.get $n))))
      (local.set $result (f64.add (local.get $result) (local.get $term)))
      
      ;; Continue until term is very small or we've done 15 iterations
      (br_if $exp_loop 
        (i32.and
          (f64.gt (f64.abs (local.get $term)) (f64.const 1e-10))
          (i32.lt_s (local.get $n) (i32.const 15))
        )
      )
    )
    
    (local.get $result)
  )
  
  ;; Natural logarithm using series
  (func $ln (param $x f64) (result f64)
    (local $y f64)
    (local $result f64)
    (local $term f64)
    (local $n i32)
    
    ;; Handle special cases
    (if (f64.le (local.get $x) (f64.const 0.0)) (return (f64.const nan)))
    (if (f64.eq (local.get $x) (f64.const 1.0)) (return (f64.const 0.0)))
    
    ;; Use ln(x) = -ln(1/x) for x > 2
    (if (f64.gt (local.get $x) (f64.const 2.0))
      (return (f64.neg (call $ln (f64.div (f64.const 1.0) (local.get $x)))))
    )
    
    ;; Use y = (x-1)/(x+1) and ln(x) = 2 * [y + y³/3 + y⁵/5 + ...]
    (local.set $y (f64.div (f64.sub (local.get $x) (f64.const 1.0)) (f64.add (local.get $x) (f64.const 1.0))))
    (local.set $term (local.get $y))
    
    (loop $ln_loop
      ;; Add term/(2*n+1)
      (local.set $result 
        (f64.add (local.get $result) 
          (f64.div (local.get $term) 
            (f64.convert_i32_s (i32.add (i32.mul (i32.const 2) (local.get $n)) (i32.const 1)))
          )
        )
      )
      
      ;; Next term
      (local.set $n (i32.add (local.get $n) (i32.const 1)))
      (local.set $term (f64.mul (local.get $term) (f64.mul (local.get $y) (local.get $y))))
      
      ;; Continue until convergence or 15 iterations
      (br_if $ln_loop 
        (i32.and
          (f64.gt (f64.abs (local.get $term)) (f64.const 1e-10))
          (i32.lt_s (local.get $n) (i32.const 15))
        )
      )
    )
    
    (f64.mul (f64.const 2.0) (local.get $result))
  )

  ;; Exponentiate a real number to a rational power
  (func (export "expreal") (param $num i32) (param $den i32) (param $base f64) (result f64)
    ;; Handle special cases
    (if (i32.eqz (local.get $num)) (return (f64.const 1.0)))
    (if (f64.eq (local.get $base) (f64.const 0.0)) (return (f64.const 0.0)))
    
    ;; Calculate base^(num/den) = exp((num/den) * ln(|base|))
    (call $exp 
      (f64.mul 
        (f64.div (f64.convert_i32_s (local.get $num)) (f64.convert_i32_s (local.get $den)))
        (call $ln (f64.abs (local.get $base)))
      )
    )
  )
)