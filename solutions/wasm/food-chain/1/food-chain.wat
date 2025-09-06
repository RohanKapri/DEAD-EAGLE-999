;; For Shree DR.MDD
(module
  (memory (export "mem") 1)

  (data (i32.const 0) "\3f\00\23\62\00\03\65\00\06\6b\00\04\6f\00\03\72\00\03\75\00\04\79\00\03\7c\00\05\81\00\02\83\00\3d\c0\00\30\f0\00\1e\0e\01\20\2e\01\1e\4c\01\2d\79\01\26\9f\01\18\b7\01\12\c9\01\0e\d7\01\31I know an old lady who swallowed a flyspiderbirdcatdoggoatcowhorse.\nI don't know why she swallowed the fly. Perhaps she'll die.\n\nIt wriggled and jiggled and tickled inside her.\nHow absurd to swallow a bird!\nImagine that, to swallow a cat!\nWhat a hog, to swallow a dog!\nJust opened her throat and swallowed a goat!\nI don't know how she swallowed a cow!\nShe's dead, of course!\n\nShe swallowed the  to catch the  that wriggled and jiggled and tickled inside her")

  (global $outputOffset i32 (i32.const 1024))

  (func $appendPart (param $idx i32) (param $currLen i32) (result i32)
    (local $len i32)
    (local $k i32)
    (local.set $len (i32.load8_u (i32.add (i32.mul (local.get $idx) (i32.const 3)) (i32.const 2))))
    (local.set $k (i32.const 0))
    (loop $copyLoop
      (i32.store8
        (i32.add (global.get $outputOffset) (i32.add (local.get $currLen) (local.get $k)))
        (i32.load8_u (i32.add (i32.load16_u (i32.mul (local.get $idx) (i32.const 3))) (local.get $k))))
      (local.set $k (i32.add (local.get $k) (i32.const 1)))
      (br_if $copyLoop (i32.lt_u (local.get $k) (local.get $len))))
    (i32.add (local.get $currLen) (local.get $len))
  )

  (func (export "recite") (param $start i32) (param $end i32) (result i32 i32)
    (local $outLen i32)
    (local $animal i32)
    (loop $verseLoop
      (local.set $outLen (call $appendPart (i32.const 0) (local.get $outLen)))
      (local.set $outLen (call $appendPart (local.get $start) (local.get $outLen)))
      (local.set $outLen (call $appendPart (i32.const 9) (local.get $outLen)))
      (local.set $outLen (call $appendPart (i32.add (local.get $start) (i32.const 9)) (local.get $outLen)))
      (if (i32.and (i32.gt_u (local.get $start) (i32.const 1))
                   (i32.lt_u (local.get $start) (i32.const 8))) (then
        (local.set $animal (local.get $start))
        (loop $swallowLoop
          (local.set $outLen (call $appendPart (i32.const 18) (local.get $outLen)))
          (local.set $outLen (call $appendPart (local.get $animal) (local.get $outLen)))
          (local.set $outLen (call $appendPart (i32.const 19) (local.get $outLen)))
          (local.set $animal (i32.sub (local.get $animal) (i32.const 1)))
          (local.set $outLen (call $appendPart (local.get $animal) (local.get $outLen)))
          (if (i32.eq (local.get $animal) (i32.const 2)) (then
            (local.set $outLen (call $appendPart (i32.const 20) (local.get $outLen)))))
          (local.set $outLen (call $appendPart (i32.const 9) (local.get $outLen)))
        (br_if $swallowLoop (i32.gt_u (local.get $animal) (i32.const 1))))
        (local.set $outLen (call $appendPart (i32.const 10) (local.get $outLen)))
      ))
      (local.set $start (i32.add (local.get $start) (i32.const 1)))
    (br_if $verseLoop (i32.le_u (local.get $start) (local.get $end))))
    (global.get $outputOffset) (i32.sub (local.get $outLen) (i32.const 1))
  )
)
