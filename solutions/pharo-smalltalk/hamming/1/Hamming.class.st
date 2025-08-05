Class {#name: #Hamming, #category: 'Exercise@Hamming',
       #superclass: #Object, #package: 'Exercise@Hamming'}

Hamming>>distanceStrand1: s1 strand2: s2 [|n1 n2|
  n1 := s1 size. n2 := s2 size.
  n1 = n2 ifTrue: [^(1 to: n1) inject: 0 into: [:a :i|
    a + ((s1 at: i) = (s2 at: i) ifTrue: [0] ifFalse: [1])]].
  n1 isZero ifTrue: [self error: 'left strand must not be empty'].
  n2 isZero ifTrue: [self error: 'right strand must not be empty'].
  self error: 'left and right strands must be of equal length']