;; For Shree DR.MDD
(module
  (memory (export "mem") 2)

  (data (i32.const 0) "\22\02\24\03\27\03\2a\05\2f\04\33\04\37\03\3a\05\3f\05\44\04\48\03\4b\0d\58\01\59\16\6f\32\a1\0c\ad\03noOneTwoThreeFourFiveSixSevenEightNineTen green bottles hanging on the wall,\nAnd if one green bottle should accidentally fall,\nThere'll be .\n\n")

  (global $resOffset i32 (i32.const 256))
  (global $lowerMask i32 (i32.const 32))

  (func $appendPart (param $partId i32) (param $resLength i32) (result i32)
    (local $partLen i32)
    (local.set $partLen (i32.load8_u (i32.add (i32.shl (local.get $partId) (i32.const 1)) (i32.const 1))))
    (memory.copy
      (i32.add (global.get $resOffset) (local.get $resLength))
      (i32.load8_u (i32.shl (local.get $partId) (i32.const 1)))
      (local.get $partLen))
    (i32.add (local.get $resLength) (local.get $partLen))
  )

  (func (export "recite") (param $startBottles i32) (param $count i32) (result i32 i32)
    (local $resLen i32)
    (local $lowerAddr i32)
    (loop $singVerse
      (local.set $resLen (call $appendPart (local.get $startBottles) (local.get $resLen)))
      (local.set $resLen (call $appendPart (i32.const 11) (local.get $resLen)))
      (if (i32.ne (local.get $startBottles) (i32.const 1)) (then
        (local.set $resLen (call $appendPart (i32.const 12) (local.get $resLen)))))
      (local.set $resLen (call $appendPart (i32.const 13) (local.get $resLen)))

      (local.set $resLen (call $appendPart (local.get $startBottles) (local.get $resLen)))
      (local.set $resLen (call $appendPart (i32.const 11) (local.get $resLen)))
      (if (i32.ne (local.get $startBottles) (i32.const 1)) (then
        (local.set $resLen (call $appendPart (i32.const 12) (local.get $resLen)))))
      (local.set $resLen (call $appendPart (i32.const 13) (local.get $resLen)))

      (local.set $resLen (call $appendPart (i32.const 14) (local.get $resLen)))

      (local.set $resLen (call $appendPart (i32.const 15) (local.get $resLen)))
      (local.set $lowerAddr (i32.add (global.get $resOffset) (local.get $resLen)))
      (local.set $resLen (call $appendPart
        (i32.sub (local.get $startBottles) (i32.const 1)) (local.get $resLen)))
      (i32.store8 (local.get $lowerAddr)
        (i32.or (i32.load8_u (local.get $lowerAddr)) (global.get $lowerMask)))
      (local.set $resLen (call $appendPart (i32.const 11) (local.get $resLen)))
      (if (i32.ne (local.get $startBottles) (i32.const 2)) (then
        (local.set $resLen (call $appendPart (i32.const 12) (local.get $resLen)))))
      (local.set $resLen (call $appendPart (i32.const 13) (local.get $resLen)))
      (local.set $resLen (i32.sub (local.get $resLen) (i32.const 2)))
      (local.set $resLen (call $appendPart (i32.const 16) (local.get $resLen)))

      (local.set $startBottles (i32.sub (local.get $startBottles) (i32.const 1)))
      (local.set $count (i32.sub (local.get $count) (i32.const 1)))
      (br_if $singVerse (local.get $count)))
    (global.get $resOffset) (i32.sub (local.get $resLen) (i32.const 1))
  )
)
