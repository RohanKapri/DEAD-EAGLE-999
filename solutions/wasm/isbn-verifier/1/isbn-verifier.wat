(module
  (memory (export "mem") 1)

  ;;
  ;; Checks if a string is a valid ISBN-10 number.
  ;;
  ;; @param {i32} offset - offset of string in linear memory
  ;; @param {i32} length - length of string in linear memory
  ;;
  ;; @returns {i32} 1 if valid ISBN-10 number, 0 otherwise
  ;;
  (func (export "isValid") (param $offset i32) (param $length i32) (result i32)
    (local $char i32) (local $pos i32) (local $digit i32) (local $sum i32)
    (local.set $pos (i32.const 0))
    (local.set $digit (i32.const 0))
    (local.set $sum (i32.const 0))
    (if (i32.eqz (local.get $length)) (then (return (i32.const 0))))
    (loop $chars
      (local.set $char (i32.load8_u (i32.add (local.get $offset) (local.get $pos))))
      (if (i32.and (i32.ge_u (local.get $char) (i32.const 48))
        (i32.le_u (local.get $char) (i32.const 57))) ;; == 0-9
          (then (local.set $sum (i32.add (local.get $sum) 
            (i32.mul (i32.sub (local.get $char) (i32.const 48))
            (i32.sub (i32.const 10) (local.get $digit)))))
            (local.set $digit (i32.add (local.get $digit) (i32.const 1))))
          (else (if (i32.ne (local.get $char) (i32.const 45)) ;; != '-'
            (then (if (i32.and (i32.eq (local.get $char) (i32.const 88))
              (i32.eq (local.get $digit) (i32.const 9))) ;; 10th digit == 'X'
              (then (local.set $sum (i32.add (local.get $sum) (i32.const 10))
                (local.set $digit (i32.add (local.get $digit) (i32.const 1)))))
              (else (return (i32.const 0))))))))
      (local.set $pos (i32.add (local.get $pos) (i32.const 1)))
    (br_if $chars (i32.ne (local.get $pos) (local.get $length))))
    (i32.and (i32.eq (local.get $digit) (i32.const 10))
      (i32.eqz (i32.rem_u (local.get $sum) (i32.const 11))))
  )
)