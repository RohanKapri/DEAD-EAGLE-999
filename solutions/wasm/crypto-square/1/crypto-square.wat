(module
  (import "console" "log_i32_u" (func $log_i32_u (param i32)))
  (memory (export "mem") 1)

  (global $normalizeOffset i32 (i32.const 1024))
  (global $outputOffset i32 (i32.const 2048))
  (global $lower i32 (i32.const 32))
  (global $zero i32 (i32.const 48))
  (global $a i32 (i32.const 97))

  ;;
  ;; Encode a string
  ;;
  ;; @param {i32} offset - The offset of the input string in linear memory
  ;; @param {i32} length - The length of the input string in linear memory
  ;;
  ;; @returns {(i32,i32)} - The offset and length of the encoded string in linear memory
  ;;
  (func (export "ciphertext") (param $offset i32) (param $length i32) (result i32 i32)
    (local $x i32)
    (local $y i32)
    (local $w i32)
    (local $h i32)
    (local $outputLength i32)
    (local $char i32)

    (if (i32.eqz (local.get $length)) (then (return (global.get $outputOffset) (local.get $length))))

    (loop $normalize
      (local.set $char (i32.or (i32.load8_u (i32.add (local.get $offset) (local.get $y))) (global.get $lower)))
      (if (i32.or (i32.lt_u (i32.sub (local.get $char) (global.get $zero)) (i32.const 10))
        (i32.lt_u (i32.sub (local.get $char) (global.get $a)) (i32.const 26))) (then
          (i32.store8 (i32.add (global.get $normalizeOffset) (local.get $outputLength)) (local.get $char))
          (local.set $outputLength (i32.add (local.get $outputLength) (i32.const 1)))))
      (local.set $y (i32.add (local.get $y) (i32.const 1)))
    (br_if $normalize (i32.lt_u (local.get $y) (local.get $length))))

    (if (i32.eqz (local.get $outputLength)) (then (return (global.get $outputOffset) (local.get $outputLength))))

    (loop $sqrt (local.set $w (i32.add (local.get $w) (i32.const 1)))
    (br_if $sqrt (i32.lt_u (i32.mul (local.get $w) (local.get $w)) (local.get $outputLength))))

    (local.set $h (i32.add (i32.div_u (local.get $outputLength) (local.get $w))
      (i32.ne (i32.rem_u (local.get $outputLength) (local.get $w)) (i32.const 0))))

    (loop $pad
      (i32.store8 (i32.add (global.get $normalizeOffset) (local.get $outputLength)) (global.get $lower))
      (local.set $outputLength (i32.add (local.get $outputLength) (i32.const 1)))
    (br_if $pad (i32.lt_u (local.get $outputLength) (i32.mul (local.get $w) (local.get $h)))))

    (local.set $outputLength (i32.const 0))
    (loop $col
      (local.set $y (i32.const 0))
      (loop $row
        (i32.store8 (i32.add (global.get $outputOffset) (local.get $outputLength))
          (i32.load8_u (i32.add (global.get $normalizeOffset)
            (i32.add (i32.mul (local.get $y) (local.get $w)) (local.get $x)))))
        (local.set $outputLength (i32.add (local.get $outputLength) (i32.const 1)))
        (local.set $y (i32.add (local.get $y) (i32.const 1)))
      (br_if $row (i32.lt_u (local.get $y) (local.get $h))))
      (i32.store8 (i32.add (global.get $outputOffset) (local.get $outputLength)) (global.get $lower))
      (local.set $outputLength (i32.add (local.get $outputLength) (i32.const 1)))
      (local.set $x (i32.add (local.get $x) (i32.const 1)))
    (br_if $col (i32.lt_u (local.get $x) (local.get $w))))

    (global.get $outputOffset) (i32.sub (local.get $outputLength) (i32.const 1))
  )
)