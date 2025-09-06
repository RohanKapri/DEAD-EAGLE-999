;; Dedicated to my Shree DR.MDD
(module
  (memory (export "mem") 1)

  (data (i32.const 0) "On the firstsecondthirdfourthfifthsixthseventheighthninthtentheleventhtwelfth day of Christmas my true love gave to me: twelve Drummers Drumming, eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.\n")
  (data (i32.const 512) "\05\07\1d\00\06\0c\33\00\05\12\46\00\06\17\5a\00\05\1d\6b\00\05\22\7f\00\07\27\97\00\06\2e\ae\00\05\34\c3\00\05\39\d8\00\08\3e\ee\00\07\46\08\01")

  (global $outputStart i32 (i32.const 1024))
  (global $dataEnd i32 (i32.const 383))

  (func (export "recite") (param $beginVerse i32) (param $finishVerse i32) (result i32 i32)
    (local $accumLength i32)
    (local $entry i32)

    (loop $verseLoop
      (memory.copy (i32.add (global.get $outputStart) (local.get $accumLength)) (i32.const 0) (i32.const 7))
      (local.set $accumLength (i32.add (local.get $accumLength) (i32.const 7)))

      (local.set $entry (i32.load (i32.add (i32.const 508) (i32.shl (local.get $beginVerse) (i32.const 2)))))

      (memory.copy (i32.add (global.get $outputStart) (local.get $accumLength))
        (i32.and (i32.shr_u (local.get $entry) (i32.const 8)) (i32.const 255))
        (i32.and (local.get $entry) (i32.const 255)))
      (local.set $accumLength (i32.add (local.get $accumLength) (i32.and (local.get $entry) (i32.const 255))))

      (memory.copy (i32.add (global.get $outputStart) (local.get $accumLength)) (i32.const 77) (i32.const 42))
      (local.set $accumLength (i32.add (local.get $accumLength) (i32.const 42)))

      (memory.copy (i32.add (global.get $outputStart) (local.get $accumLength))
        (i32.sub (global.get $dataEnd) (i32.shr_u (local.get $entry) (i32.const 16)))
        (i32.shr_u (local.get $entry) (i32.const 16)))
      (local.set $accumLength (i32.add (local.get $accumLength) (i32.shr_u (local.get $entry) (i32.const 16))))

      (local.set $beginVerse (i32.add (local.get $beginVerse) (i32.const 1)))
      (br_if $verseLoop (i32.le_u (local.get $beginVerse) (local.get $finishVerse)))
    )

    (global.get $outputStart) (local.get $accumLength)
  )
)
