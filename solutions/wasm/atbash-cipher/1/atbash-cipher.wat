;; For my Shree DR.MDD

(module
  (memory (export "mem") 1)

  (func (export "encode") (param $inputOffset i32) (param $inputLength i32) (result i32 i32)
    (local $readPos i32) (local $writePos i32) (local $curChar i32)
    (loop $loopEncode
      (local.set $curChar (i32.or (i32.load8_u (i32.add (local.get $inputOffset) (local.get $readPos))) (i32.const 32)))
      (if (i32.and (i32.ge_u (local.get $curChar) (i32.const 48)) (i32.le_u (local.get $curChar) (i32.const 57)))
        (then
          (i32.store8 (i32.add (i32.const 200) (local.get $writePos)) (local.get $curChar))
          (local.set $writePos (i32.add (local.get $writePos) (i32.const 1)))))
      (if (i32.and (i32.ge_u (local.get $curChar) (i32.const 97)) (i32.le_u (local.get $curChar) (i32.const 122)))
        (then
          (i32.store8 (i32.add (i32.const 200) (local.get $writePos)) (i32.sub (i32.const 219) (local.get $curChar)))
          (local.set $writePos (i32.add (local.get $writePos) (i32.const 1)))))
      (if (i32.eqz (i32.rem_s (i32.add (local.get $writePos) (i32.const 1)) (i32.const 6)))
        (then
          (i32.store8 (i32.add (i32.const 200) (local.get $writePos)) (i32.const 32))
          (local.set $writePos (i32.add (local.get $writePos) (i32.const 1)))))
      (local.set $readPos (i32.add (local.get $readPos) (i32.const 1)))
      (br_if $loopEncode (i32.lt_u (local.get $readPos) (local.get $inputLength))))
    (loop $trimSpace
      (if (i32.eq (i32.load8_u (i32.add (i32.const 199) (local.get $writePos))) (i32.const 32))
        (then (local.set $writePos (i32.sub (local.get $writePos) (i32.const 1))) (br $trimSpace))))
    (return (i32.const 200) (local.get $writePos))
  )

  (func (export "decode") (param $inputOffset i32) (param $inputLength i32) (result i32 i32)
    (local $readPos i32) (local $writePos i32) (local $curChar i32)
    (loop $loopDecode
      (local.set $curChar (i32.load8_u (i32.add (local.get $inputOffset) (local.get $readPos))))
      (if (i32.and (i32.ge_u (local.get $curChar) (i32.const 48)) (i32.le_u (local.get $curChar) (i32.const 57)))
        (then
          (i32.store8 (i32.add (i32.const 200) (local.get $writePos)) (local.get $curChar))
          (local.set $writePos (i32.add (local.get $writePos) (i32.const 1)))))
      (if (i32.and (i32.ge_u (local.get $curChar) (i32.const 97)) (i32.le_u (local.get $curChar) (i32.const 122)))
        (then
          (i32.store8 (i32.add (i32.const 200) (local.get $writePos)) (i32.sub (i32.const 219) (local.get $curChar)))
          (local.set $writePos (i32.add (local.get $writePos) (i32.const 1)))))
      (local.set $readPos (i32.add (local.get $readPos) (i32.const 1)))
      (br_if $loopDecode (i32.lt_u (local.get $readPos) (local.get $inputLength))))
    (return (i32.const 200) (local.get $writePos))
  )
)
