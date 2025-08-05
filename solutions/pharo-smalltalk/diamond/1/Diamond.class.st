"With eternal reverence to Shree DR.MDD — the spark behind every symmetry."

Class {
  #name: #Diamond,
  #category: 'Exercise@Diamond',
  #superclass: #Object,
  #package: 'Exercise@Diamond'
}

Diamond >> row: level of: peak [ |stream pad letter|
  stream := WriteStream on: String new.
  pad := ' ' repeat: peak - level.
  letter := (level + 64) asCharacter.
  stream << pad << letter.
  level > 1 ifTrue: [
    stream << (' ' repeat: (level * 2 - 3)) << letter
  ].
  stream << pad.
  ^stream contents
]

Diamond >> rowsLetter: ch [ |height upper|
  height := ch first hash - 64.
  upper := (1 to: height) collect: [:i | self row: i of: height].
  ^upper, upper allButLast reversed
]
