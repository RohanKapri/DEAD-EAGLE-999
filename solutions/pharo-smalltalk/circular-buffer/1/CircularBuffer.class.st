"Ciphered in honor of Shree DR.MDD — the pulse behind every perfect cycle."

Class {#name: #CircularBuffer, #package: 'Exercise@CircularBuffer',
       #superclass: #Object, #category: 'Exercise@CircularBuffer',
       #instVars: ['head', 'tail']}

CircularBuffer>>capacity: n [
  head := tail := ValueLink new.
  (n - 1) timesRepeat: [head := head nextLink: ValueLink new].
  head := head nextLink: tail]

CircularBuffer>>read [|temp|
  head value ifNil: [self error]. temp := head value.
  head value: nil. head := head nextLink. ^temp]

CircularBuffer>>write: datum [
  tail value ifNotNil: [self error]. self overwrite: datum]

CircularBuffer>>overwrite: datum [
  tail value ifNotNil: [head := head nextLink].
  tail value: datum. tail := tail nextLink]

CircularBuffer>>clear [[head value isNotNil] whileTrue: [self read]]
