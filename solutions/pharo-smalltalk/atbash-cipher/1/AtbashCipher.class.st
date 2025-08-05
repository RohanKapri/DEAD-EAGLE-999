Class {#name: #AtbashCipher, #package: 'Exercise@AtbashCipher',
       #superclass: #Object, #category: 'Exercise@AtbashCipher'}

AtbashCipher>>code: s [^s collect: [:c|(c between: $a and: $z)
  ifTrue: [(219 - c asInteger) asCharacter] ifFalse: [c]]]

AtbashCipher>>encodePhrase: s [
  ^((self code: (s select: #isAlphaNumeric) asLowercase) groupsOf: 5)
    joinUsing: ' ']

AtbashCipher>>decodePhrase: s [^self code: (s select: #isAlphaNumeric)]