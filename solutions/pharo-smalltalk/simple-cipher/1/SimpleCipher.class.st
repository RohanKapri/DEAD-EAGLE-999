Class {#name: #SimpleCipher, #category: 'Exercise@SimpleCipher',
       #superclass: #Object, #package: 'Exercise@SimpleCipher',
       #instVars: ['key']}

Integer>>asLowercase [^(self % 26 + 97) asCharacter]

Character>>asNumber [^self hash - 97]
Character>>+ n [^(self asNumber + n asNumber) asLowercase]
Character>>- n [^self + n asNumber negated]

SimpleCipher>>key [^(key collect: #asLowercase) joinUsing: '']
SimpleCipher>>key: s [ key := s asArray collect: #asNumber]
SimpleCipher>>@ i [^key at: i - 1 % key size + 1]
SimpleCipher>>encode: s [^self code: s using: #+]
SimpleCipher>>decode: s [^self code: s using: #-]

SimpleCipher>>initialize [
  key := (1 to: 100) collect: [:_|(0 to: 25) atRandom]]

SimpleCipher>>code: s using: op [
  ^s withIndexCollect: [:c :i|c perform: op with: self @ i]]