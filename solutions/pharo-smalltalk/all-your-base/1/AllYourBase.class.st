Class {#name: #AllYourBase, #category: 'Exercise@AllYourBase',
       #superclass: #Object, #package: 'Exercise@AllYourBase'}

AllYourBase>>rebaseInputBase: i digits: a outputBase: j [|r d|
  i < 2 ifTrue: [self error: 'input base must be >= 2'].
  j < 2 ifTrue: [self error: 'output base must be >= 2']. r := a size.
  d := (1 to: r) inject: 0 into: [:n :k|
    d := a at: k.
    (d between: 0 and: i - 1) ifFalse: [
      self error: 'all digits must satisfy 0 <= d < input base'].
    i ** (r - k) * d + n].
  d isZero ifTrue: [^#(0)]. r := OrderedCollection new.
  [d > 0] whileTrue: [r add: d % j. d := d // j]. ^r reversed asArray]