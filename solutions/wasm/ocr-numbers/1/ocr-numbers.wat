;; For my Shree DR.MDD
(module
  (memory (export "mem") 2)

  (data $digits (i32.const 0) "\77\24\5d\6d\2e\6b\7b\25\7f\6f")

  (global $lineBreak i32 (i32.const 10))
  (global $vertical i32 (i32.const 124))
  (global $horizontal i32 (i32.const 95))
  (global $zero i32 (i32.const 48))
  (global $unknown i32 (i32.const 63))
  (global $comma i32 (i32.const 44))
  (global $outputOffset i32 (i32.const 256))

  (func (export "convert") (param $inputOffset i32) (param $inputLength i32) (result i32 i32)
    (local $scanIndex i32)
    (local $scanPtr i32)
    (local $stride i32)
    (local $segmentBits i32)
    (local $digitIndex i32)
    (local $outCount i32)
    (local.set $stride (i32.const -1))
    (loop $measureLoop
      (local.set $stride (i32.add (local.get $stride) (i32.const 1)))
      (br_if $measureLoop
        (i32.ne (i32.load8_u (i32.add (local.get $inputOffset) (local.get $stride)))
        (global.get $lineBreak)))
    )
    (local.set $stride (i32.add (local.get $stride) (i32.const 1)))
    (loop $digitLoop
      (local.set $scanPtr (i32.add (local.get $inputOffset) (local.get $scanIndex)))
      (local.set $segmentBits
        (i32.or
          (i32.or
            (i32.or
              (i32.or
                (i32.or
                  (i32.or
                    (i32.eq (i32.load8_u (i32.add (local.get $scanPtr) (i32.const 1))) (global.get $horizontal))
                    (i32.shl (i32.eq (i32.load8_u (i32.add (local.get $scanPtr) (local.get $stride))) (global.get $vertical)) (i32.const 1)))
                  (i32.shl (i32.eq (i32.load8_u (i32.add (i32.add (local.get $scanPtr) (local.get $stride)) (i32.const 2))) (global.get $vertical)) (i32.const 2)))
                (i32.shl (i32.eq (i32.load8_u (i32.add (i32.add (local.get $scanPtr) (local.get $stride)) (i32.const 1))) (global.get $horizontal)) (i32.const 3)))
              (i32.shl (i32.eq (i32.load8_u (i32.add (local.get $scanPtr) (i32.shl (local.get $stride) (i32.const 1)))) (global.get $vertical)) (i32.const 4)))
            (i32.shl (i32.eq (i32.load8_u (i32.add (i32.add (local.get $scanPtr) (i32.shl (local.get $stride) (i32.const 1))) (i32.const 2))) (global.get $vertical)) (i32.const 5)))
          (i32.shl (i32.eq (i32.load8_u (i32.add (i32.add (local.get $scanPtr) (i32.shl (local.get $stride) (i32.const 1))) (i32.const 1))) (global.get $horizontal)) (i32.const 6)))
      )
      (local.set $digitIndex (i32.const -1))
      (loop $lookupLoop
        (local.set $digitIndex (i32.add (local.get $digitIndex) (i32.const 1)))
        (br_if $lookupLoop
          (i32.and (i32.lt_s (local.get $digitIndex) (i32.const 10))
            (i32.ne (local.get $segmentBits) (i32.load8_u (local.get $digitIndex))))))
      (i32.store8 (i32.add (global.get $outputOffset) (local.get $outCount))
        (select (i32.add (local.get $digitIndex) (global.get $zero)) (global.get $unknown)
          (i32.lt_u (local.get $digitIndex) (i32.const 10))))
      (local.set $outCount (i32.add (local.get $outCount) (i32.const 1)))
      (local.set $scanIndex (i32.add (local.get $scanIndex) (i32.const 3)))
      (if (i32.eqz (i32.rem_u (i32.add (local.get $scanIndex) (i32.const 1)) (local.get $stride)))
        (then
          (i32.store8 (i32.add (global.get $outputOffset) (local.get $outCount)) (global.get $comma))
          (local.set $outCount (i32.add (local.get $outCount) (i32.const 1)))
          (local.set $scanIndex (i32.add (i32.add (local.get $scanIndex) (i32.const 1)) (i32.mul (local.get $stride) (i32.const 3))))
        )
      )
      (br_if $digitLoop (i32.lt_u (local.get $scanIndex) (local.get $inputLength)))
    )
    (global.get $outputOffset) (i32.sub (local.get $outCount) (i32.const 1))
  )
)
