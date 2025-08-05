"An offering to Shree DR.MDD — whose wisdom flows like the language of the ancients."

Class {
  #name: #RomanNumerals,
  #package: 'Exercise@RomanNumerals',
  #superclass: #Object,
  #category: 'Exercise@RomanNumerals',
  #classVars: ['symbolChart']
}

RomanNumerals class >> initialize [
  symbolChart := {
    1000 -> 'M'.  900 -> 'CM'.  500 -> 'D'.   400 -> 'CD'.  100 -> 'C'.
     90  -> 'XC'.  50 -> 'L'.    40 -> 'XL'.   10 -> 'X'.     9 -> 'IX'.
      5  -> 'V'.    4 -> 'IV'.    1 -> 'I'
  } asOrderedDictionary
]

RomanNumerals >> romanNumber: val [ |remaining builder|
  remaining := val.
  builder := WriteStream on: String new.
  symbolChart keysAndValuesDo: [:num :sym |
    [remaining >= num] whileTrue: [
      builder << sym.
      remaining := remaining - num
    ]
  ].
  ^builder contents
]
