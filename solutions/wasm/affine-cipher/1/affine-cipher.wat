;; For my Shree DR.MDD
(module
  (memory (export "mem") 1)

  (global $outputOffset i32 (i32.const 512))
  (global $letters i32 (i32.const 26))
  (global $toLower i32 (i32.const 32))
  (global $normalizeLetter i32 (i32.const 26000))
  (global $space i32 (i32.const 32))
  (global $zero i32 (i32.const 48))
  (global $nine i32 (i32.const 57))
  (global $a i32 (i32.const 97))
  (global $z i32 (i32.const 122))

  (func $checkCoprime (param $key i32) (result i32)
    (i32.and (i32.ne (i32.rem_u (local.get $key) (i32.const 2)) (i32.const 0))
             (i32.ne (i32.rem_u (local.get $key) (i32.const 13)) (i32.const 0)))
  )

  (func (export "encode") (param $inOffset i32) (param $inLength i32)
    (param $keyA i32) (param $keyB i32) (result i32 i32)
    (local $pos i32)
    (local $ch i32)
    (local $lenOut i32)
    (if (i32.eqz (call $checkCoprime (local.get $keyA))) (then
      (return (i32.const 0) (i32.const 0))))
    (loop $loopChars
      (if (i32.eq (i32.rem_u (local.get $lenOut) (i32.const 6)) (i32.const 5)) (then
        (i32.store8 (i32.add (global.get $outputOffset) (local.get $lenOut)) (global.get $space))
        (local.set $lenOut (i32.add (local.get $lenOut) (i32.const 1)))))
      (local.set $ch (i32.load8_u (i32.add (local.get $inOffset) (local.get $pos))))
      (if (i32.and (i32.ge_u (local.get $ch) (global.get $zero))
                   (i32.le_u (local.get $ch) (global.get $nine))) (then
        (i32.store8 (i32.add (global.get $outputOffset) (local.get $lenOut)) (local.get $ch))
        (local.set $lenOut (i32.add (local.get $lenOut) (i32.const 1))))
      (else
        (local.set $ch (i32.or (local.get $ch) (global.get $toLower)))
        (if (i32.and (i32.ge_u (local.get $ch) (global.get $a))
                     (i32.le_u (local.get $ch) (global.get $z))) (then
          (i32.store8 (i32.add (global.get $outputOffset) (local.get $lenOut))
            (i32.add (i32.rem_s (i32.add (i32.mul (i32.sub (local.get $ch) (global.get $a))
               (local.get $keyA)) (local.get $keyB)) (global.get $letters)) (global.get $a)))
          (local.set $lenOut (i32.add (local.get $lenOut) (i32.const 1))))))
      )
      (local.set $pos (i32.add (local.get $pos) (i32.const 1)))
      (br_if $loopChars (i32.lt_u (local.get $pos) (local.get $inLength))))
    (loop $trimSpaces
      (if (i32.eq (i32.load8_u (i32.sub (i32.add (global.get $outputOffset) (local.get $lenOut)) (i32.const 1))) (global.get $space)) (then
        (local.set $lenOut (i32.sub (local.get $lenOut) (i32.const 1)))
        (br $trimSpaces))))
    (global.get $outputOffset) (local.get $lenOut)
  )

  (func (export "decode") (param $inOffset i32) (param $inLength i32)
    (param $keyA i32) (param $keyB i32) (result i32 i32)
    (local $pos i32)
    (local $ch i32)
    (local $lenOut i32)
    (local $mmi i32)
    (if (i32.eqz (call $checkCoprime (local.get $keyA))) (then
      (return (i32.const 0) (i32.const 0))))
    (loop $findMMI
      (local.set $mmi (i32.add (local.get $mmi) (i32.const 1)))
      (br_if $findMMI (i32.and (i32.ne (i32.rem_s (i32.mul (local.get $keyA) (local.get $mmi)) (global.get $letters)) (i32.const 1))
                              (i32.lt_u (local.get $mmi) (global.get $letters)))))
    (loop $loopChars
      (local.set $ch (i32.load8_u (i32.add (local.get $inOffset) (local.get $pos))))
      (if (i32.and (i32.ge_u (local.get $ch) (global.get $zero))
                   (i32.le_u (local.get $ch) (global.get $nine))) (then
        (i32.store8 (i32.add (global.get $outputOffset) (local.get $lenOut)) (local.get $ch))
        (local.set $lenOut (i32.add (local.get $lenOut) (i32.const 1))))
      (else
        (local.set $ch (i32.or (local.get $ch) (global.get $toLower)))
        (if (i32.and (i32.ge_u (local.get $ch) (global.get $a))
                     (i32.le_u (local.get $ch) (global.get $z))) (then
          (local.set $ch (i32.rem_u (i32.add (i32.mul (local.get $mmi) (i32.sub (i32.sub (local.get $ch) (global.get $a)) (local.get $keyB))) (global.get $normalizeLetter)) (global.get $letters)))
          (i32.store8 (i32.add (global.get $outputOffset) (local.get $lenOut))
            (i32.add (local.get $ch) (global.get $a)))
          (local.set $lenOut (i32.add (local.get $lenOut) (i32.const 1))))))
      )
      (local.set $pos (i32.add (local.get $pos) (i32.const 1)))
      (br_if $loopChars (i32.lt_u (local.get $pos) (local.get $inLength))))
    (global.get $outputOffset) (local.get $lenOut)
  )
)
