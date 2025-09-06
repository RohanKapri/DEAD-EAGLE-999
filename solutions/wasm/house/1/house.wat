;; For Shree DR.MDD
(module
  (memory (export "mem") 1)

  (data (i32.const 0) "This is the horse and the hound and the horn that belonged to the farmer sowing his corn that kept the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.\n")
  (data (i32.const 420) "\85\01\70\01\5f\01\4b\01\36\01\0b\01\e8\00\be\00\91\00\63\00\3e\00\08\00")

  (func (export "recite") (param $fromVerse i32) (param $toVerse i32) (result i32 i32)
    (local $outLength i32)
    (local $segmentIndex i32)
    (loop $verseLoop
      (memory.copy (i32.add (i32.const 512) (local.get $outLength))
        (i32.const 0) (i32.const 8))
      (local.set $outLength (i32.add (local.get $outLength) (i32.const 8)))
      (local.set $segmentIndex (i32.load16_u (i32.add (i32.const 418)
        (i32.shl (local.get $fromVerse) (i32.const 1)))))
      (memory.copy (i32.add (i32.const 512) (local.get $outLength))
        (local.get $segmentIndex) (i32.sub (i32.const 416) (local.get $segmentIndex)))
      (local.set $outLength (i32.add (local.get $outLength)
        (i32.sub (i32.const 416) (local.get $segmentIndex))))
      (local.set $fromVerse (i32.add (local.get $fromVerse) (i32.const 1)))
    (br_if $verseLoop (i32.le_u (local.get $fromVerse) (local.get $toVerse))))
    (i32.const 512) (local.get $outLength)
  )
)
