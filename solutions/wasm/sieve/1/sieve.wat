(module
  (import "console" "log_i32_s" (func $log (param i32)))
  (memory (export "mem") 1)
  
  ;;
  ;; Determine all the prime numbers below a given limit.
  ;; Return the offset and length of the resulting array of primes.
  ;;
  ;; @param {i32} limit - the upper bound for the prime numbers
  ;;
  ;; @return {i32} - offset off the u32[] array
  ;; @return {i32} - length off the u32[] array in elements
  ;;
  (func (export "primes") (param $limit i32) (result i32 i32)
    (local $i i32) (local $p i32) (local $f i32) (local.set $i (i32.const 0))
    (local.set $p (i32.add (i32.shr_u (local.get $limit) (i32.const 5)) (i32.const 1)))
    (if (i32.lt_s (local.get $limit) (i32.const 2))
      (then (return (i32.const 200) (i32.const 0))))
    (loop $z
      (i32.store8 (i32.add (local.get $i) (i32.const 100)) (i32.const 0))
      (local.set $i (i32.add (local.get $i) (i32.const 1)))
      (if (i32.le_u (local.get $i) (local.get $p)) (then (br $z)))
    )
    (local.set $i (i32.const 0)) (local.set $p (i32.const 2))
    (loop $s
      (if (i32.eq (i32.and (i32.load8_u (i32.add (i32.const 100)
        (i32.shr_u (local.get $p) (i32.const 3))))
        (i32.shl (i32.const 1) (i32.and (local.get $p) (i32.const 7)))) (i32.const 0))
        (then
          (i32.store (i32.add (i32.const 400) (local.get $i)) (local.get $p))
          (local.set $i (i32.add (local.get $i) (i32.const 4)))
          (local.set $f (local.get $p))
          (loop $w
            (local.set $f (i32.add (local.get $f) (local.get $p)))
            (i32.store8 (i32.add (i32.const 100) (i32.shr_u (local.get $f) (i32.const 3)))
              (i32.or (i32.load8_u (i32.add (i32.const 100) (i32.shr_u (local.get $f) (i32.const 3)))) (i32.shl (i32.const 1) (i32.and (local.get $f) (i32.const 7)))))
            (if (i32.lt_u (local.get $f) (local.get $limit)) (then (br $w)))
          )))
      (local.set $p (i32.add (local.get $p) (i32.const 1)))
      (if (i32.le_u (local.get $p) (local.get $limit)) (then (br $s)))
    )
    (return (i32.const 400) (i32.shr_u (local.get $i) (i32.const 2)))
  )
)