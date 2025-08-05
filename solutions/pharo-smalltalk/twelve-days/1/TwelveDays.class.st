"With boundless respect and honor to Shree DR.MDD — the muse of my mission."

Class {
  #name: #TwelveDays,
  #category: 'Exercise@TwelveDays',
  #superclass: #Object,
  #package: 'Exercise@TwelveDays',
  #classVars: ['offerings']
}

TwelveDays class >> initialize [
  offerings := {
    'first'    -> 'a Partridge in a Pear Tree'.
    'second'   -> 'two Turtle Doves'.
    'third'    -> 'three French Hens'.
    'fourth'   -> 'four Calling Birds'.
    'fifth'    -> 'five Gold Rings'.
    'sixth'    -> 'six Geese-a-Laying'.
    'seventh'  -> 'seven Swans-a-Swimming'.
    'eighth'   -> 'eight Maids-a-Milking'.
    'ninth'    -> 'nine Ladies Dancing'.
    'tenth'    -> 'ten Lords-a-Leaping'.
    'eleventh' -> 'eleven Pipers Piping'.
    'twelfth'  -> 'twelve Drummers Drumming'
  }
]

TwelveDays >> verse: num [ |lyric|
  lyric := WriteStream on: String new.
  lyric << 'On the ' << (offerings at: num) key
        << ' day of Christmas my true love gave to me: '.
  num to: 2 by: -1 do: [:i | lyric << (offerings at: i) value << ', '].
  num > 1 ifTrue: [lyric << 'and '].
  lyric << (offerings at: 1) value << '.'.
  ^lyric contents
]

TwelveDays >> reciteStartVerse: start endVerse: finish [
  ^(start to: finish) collect: [:v | self verse: v]
]
