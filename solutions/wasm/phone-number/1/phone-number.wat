(module
  (memory (export "mem") 1)
  ;;
  ;; Returns a cleaned valid phone number or an empty string if invalid
  ;;
  ;; @param {i32} offset - The offset of the phone number in linear memory.
  ;; @param {i32} length - The length of the phone number in linear memory.
  ;;
  ;; @returns {(i32,i32)} - Offset and length of cleaned phone number or empty string
  ;;                        in linear memory.
  ;;
  (func (export "clean") (param $offset i32) (param $length i32) (result i32 i32)
    (local $ipos i32) (local $opos i32) (local $char i32)
    (loop $digits
      (local.set $char (i32.load8_u (i32.add (local.get $offset) (local.get $ipos))))
      (if (i32.and (i32.ge_u (local.get $char) (i32.const 48)) (i32.le_u (local.get $char) (i32.const 57)))
        (then (if (i32.or (i32.ne (local.get $opos) (i32.const 0)) (i32.ne (i32.or (local.get $char) (i32.const 1)) (i32.const 49))) (then (i32.store8 (i32.add (i32.const 200) (local.get $opos)) (local.get $char)) (local.set $opos (i32.add (local.get $opos) (i32.const 1))))))
        (else (if (i32.and (i32.or (i32.lt_u (local.get $char) (i32.const 40)) (i32.gt_u (local.get $char) (i32.const 46))) (i32.ne (local.get $char) (i32.const 32))) (then (return (i32.const 0) (i32.const 0))))))
      (local.set $ipos (i32.add (local.get $ipos) (i32.const 1)))
    (br_if $digits (i32.lt_u (local.get $ipos) (local.get $length))))
    (if (i32.or (i32.ne (local.get $opos) (i32.const 10))
      (i32.eq (i32.or (i32.load8_u (i32.const 203)) (i32.const 1)) (i32.const 49)))
      (then (return (i32.const 0) (i32.const 0))))
    (return (i32.const 200) (local.get $opos))
  )
)