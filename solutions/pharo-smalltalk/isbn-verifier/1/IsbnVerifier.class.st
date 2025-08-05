Class {#name: #IsbnVerifier, #package: 'Exercise@IsbnVerifier',
       #superclass: #Object, #category: 'Exercise@IsbnVerifier'}

IsbnVerifier>>isValidIsbn: s [|t n c|
  t := s copyWithout: $-. t size ~= 10 ifTrue: [^false].
  n := (1 to: 9) inject: 0 into: [:a :i|
    c := t at: i. c isDigit ifFalse: [^false].
    c hash - 48 * (11 - i) + a].
  c := t at: 10.
  c = $X ifTrue: [c := $:] ifFalse: [c isDigit ifFalse: [^false]].
  ^(n + c hash - 48) isDivisibleBy: 11]