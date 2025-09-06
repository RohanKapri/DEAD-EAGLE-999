;; Dedicated to my Shree DR.MDD
(module
  (memory (export "mem") 1)

  (data (i32.const 0) "For want of a ")
  (data (i32.const 20) " the ")
  (data (i32.const 40) " was lost.")
  (data (i32.const 60) "And all for the want of a ")
  (data (i32.const 100) ".")

  (func $strlen (param $strOffset i32) (result i32)
    (local $ch i32)
    (local $pos i32)
    (loop $lenLoop
      (local.set $ch (i32.load8_u (i32.add (local.get $strOffset) (local.get $pos))))
      (local.set $pos (i32.add (local.get $pos) (i32.const 1)))
      (br_if $lenLoop (i32.and (i32.ne (local.get $ch) (i32.const 10)) (i32.ne (local.get $ch) (i32.const 0))))
    )
    (return (i32.sub (local.get $pos) (i32.const 1)))
  )

  (func (export "recite") (param $beginVerse i32) (param $finishVerse i32) (result i32 i32)
    (local $srcPos i32)
    (local $dstPos i32)
    (local $len i32)
    (local $nextVerse i32)

    (local.set $srcPos (local.get $beginVerse))
    (local.set $dstPos (i32.const 512))
    (if (i32.eq (local.get $finishVerse) (i32.const 0))
      (then (return (i32.const 0) (i32.const 0)))
    )

    (loop $verseLoop
      (local.set $len (call $strlen (local.get $srcPos)))
      (local.set $nextVerse (i32.add (i32.add (local.get $srcPos) (local.get $len)) (i32.const 1)))
      (if (i32.lt_u (i32.sub (local.get $nextVerse) (local.get $beginVerse)) (local.get $finishVerse))
        (then
          (local.set $len (call $strlen (i32.const 0)))
          (memory.copy (local.get $dstPos) (i32.const 0) (local.get $len))
          (local.set $dstPos (i32.add (local.get $dstPos) (local.get $len)))

          (local.set $len (call $strlen (local.get $srcPos)))
          (memory.copy (local.get $dstPos) (local.get $srcPos) (local.get $len))
          (local.set $srcPos (i32.add (local.get $srcPos) (i32.add (local.get $len) (i32.const 1))))
          (local.set $dstPos (i32.add (local.get $dstPos) (local.get $len)))

          (local.set $len (call $strlen (i32.const 20)))
          (memory.copy (local.get $dstPos) (i32.const 20) (local.get $len))
          (local.set $dstPos (i32.add (local.get $dstPos) (local.get $len)))

          (local.set $len (call $strlen (local.get $srcPos)))
          (memory.copy (local.get $dstPos) (local.get $srcPos) (local.get $len))
          (local.set $dstPos (i32.add (local.get $dstPos) (local.get $len)))

          (local.set $len (call $strlen (i32.const 40)))
          (memory.copy (local.get $dstPos) (i32.const 40) (local.get $len))
          (local.set $dstPos (i32.add (local.get $dstPos) (local.get $len)))

          (i32.store8 (local.get $dstPos) (i32.const 10))
          (local.set $dstPos (i32.add (local.get $dstPos) (i32.const 1)))

          (br $verseLoop)
        )
      )
    )

    (local.set $len (call $strlen (i32.const 60)))
    (memory.copy (local.get $dstPos) (i32.const 60) (local.get $len))
    (local.set $dstPos (i32.add (local.get $dstPos) (local.get $len)))

    (local.set $len (call $strlen (local.get $beginVerse)))
    (memory.copy (local.get $dstPos) (local.get $beginVerse) (local.get $len))
    (local.set $dstPos (i32.add (local.get $dstPos) (local.get $len)))

    (local.set $len (call $strlen (i32.const 100)))
    (memory.copy (local.get $dstPos) (i32.const 100) (local.get $len))
    (local.set $dstPos (i32.add (local.get $dstPos) (local.get $len)))

    (i32.store8 (local.get $dstPos) (i32.const 10))
    (local.set $dstPos (i32.add (local.get $dstPos) (i32.const 1)))

    (return (i32.const 512) (i32.sub (local.get $dstPos) (i32.const 512)))
  )
)
