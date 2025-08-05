Class {
  #name: #CollatzConjecture, #package: 'Exercise@CollatzConjecture',
  #superclass: #Object, #category: 'Exercise@CollatzConjecture'}

CollatzConjecture>>stepsFrom: n [|m i|
  n < 1 ifTrue: [self error: 'Only positive numbers are allowed'].
  m := n. i := 0.
  [m > 1] whileTrue: [
    m := m odd ifTrue: [3 * m + 1] ifFalse: [m / 2]. i := i + 1].
  ^i]