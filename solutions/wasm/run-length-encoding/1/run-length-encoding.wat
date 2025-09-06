;; For my Shree DR.MDD
(module
  (memory (export "mem") 1)

  (func $numWriter (param $pos i32) (param $val i32) (result i32)
    (local $digitsCount i32) (local $tmpVal i32)
    (local.set $digitsCount (i32.const 0))
    (local.set $tmpVal (local.get $val))
    (loop $calcDigits
      (local.set $tmpVal (i32.div_u (local.get $tmpVal) (i32.const 10)))
      (local.set $digitsCount (i32.add (local.get $digitsCount) (i32.const 1)))
      (br_if $calcDigits (local.get $tmpVal))
    )
    (local.set $tmpVal (i32.sub (local.get $digitsCount) (i32.const 1)))
    (loop $writeDigits
      (i32.store8 (i32.add (local.get $pos) (local.get $tmpVal))
        (i32.add (i32.rem_u (local.get $val) (i32.const 10)) (i32.const 48)))
      (local.set $val (i32.div_u (local.get $val) (i32.const 10)))
      (local.set $tmpVal (i32.sub (local.get $tmpVal) (i32.const 1)))
      (br_if $writeDigits (local.get $val))
    )
    (local.get $digitsCount)
  )

  (func (export "encode") (param $pos i32) (param $len i32) (result i32 i32)
    (local $currByte i32) (local $prevByte i32) (local $repeatCount i32)
    (local $inIdx i32) (local $outIdx i32)
    (local.set $outIdx (i32.const 0))
    (local.set $inIdx (i32.const 0))
    (local.set $prevByte (i32.const -1))
    (if (i32.gt_u (local.get $len) (i32.const 0)) (then
      (loop $loopEncode
        (local.set $currByte (i32.load8_u (i32.add (local.get $pos) (local.get $inIdx))))
        (if (i32.eq (local.get $prevByte) (i32.const -1))
          (then
            (local.set $prevByte (local.get $currByte))
            (local.set $repeatCount (i32.const 1))
          )
          (else
            (if (i32.ne (local.get $prevByte) (local.get $currByte))
              (then
                (if (i32.ne (local.get $repeatCount) (i32.const 1))
                  (then
                    (local.set $outIdx
                      (i32.add (local.get $outIdx)
                        (call $numWriter (i32.add (local.get $pos) (local.get $outIdx)) (local.get $repeatCount))
                      )
                    )
                  )
                )
                (i32.store8 (i32.add (local.get $pos) (local.get $outIdx)) (local.get $prevByte))
                (local.set $outIdx (i32.add (local.get $outIdx) (i32.const 1)))
                (local.set $prevByte (local.get $currByte))
                (local.set $repeatCount (i32.const 1))
              )
              (else
                (local.set $repeatCount (i32.add (local.get $repeatCount) (i32.const 1)))
              )
            )
          )
        )
        (local.set $inIdx (i32.add (local.get $inIdx) (i32.const 1)))
        (br_if $loopEncode (i32.le_u (local.get $inIdx) (local.get $len)))
      )
    ))
    (return (local.get $pos) (local.get $outIdx))
  )

  (func (export "decode") (param $pos i32) (param $len i32) (result i32 i32)
    (local $inIdx i32) (local $outIdx i32) (local $currByte i32) (local $repeatAmt i32)
    (if (i32.eqz (local.get $len)) (then (return (local.get $pos) (i32.const 0))))
    (local.set $inIdx (i32.const 0))
    (local.set $outIdx (i32.const 0))
    (local.set $repeatAmt (i32.const 0))
    (loop $loopDecode
      (local.set $currByte (i32.load8_u (i32.add (local.get $pos) (local.get $inIdx))))
      (local.set $inIdx (i32.add (local.get $inIdx) (i32.const 1)))
      (if (i32.and (i32.ge_u (local.get $currByte) (i32.const 48)) (i32.le_u (local.get $currByte) (i32.const 57)))
        (then
          (local.set $repeatAmt
            (i32.add (i32.mul (local.get $repeatAmt) (i32.const 10))
              (i32.sub (local.get $currByte) (i32.const 48))
            )
          )
        )
        (else
          (loop $repeatWrite
            (i32.store8 (i32.add (i32.const 300) (local.get $outIdx)) (local.get $currByte))
            (local.set $outIdx (i32.add (local.get $outIdx) (i32.const 1)))
            (local.set $repeatAmt (i32.sub (local.get $repeatAmt) (i32.const 1)))
            (br_if $repeatWrite (i32.ge_s (local.get $repeatAmt) (i32.const 1)))
          )
          (local.set $repeatAmt (i32.const 0))
        )
      )
      (br_if $loopDecode (i32.lt_u (local.get $inIdx) (local.get $len)))
    )
    (return (i32.const 300) (local.get $outIdx))
  )
)
