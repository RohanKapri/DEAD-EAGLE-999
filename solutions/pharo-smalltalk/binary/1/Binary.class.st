Class {#name: #Binary, #category: 'Exercise@Binary',
       #superclass: #Object, #package: 'Exercise@Binary'}

Binary>>decimalFromBinary: s [|n len|
  n := 0. len := s size.
  s withIndexDo: [:c :i|
    c = $1 ifTrue: [n := n bitAt: len - i + 1 put: 1]
	   ifFalse: [c ~= $0 ifTrue: [^nil]]].
  ^n]