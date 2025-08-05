Class {#name: #Grains, #category: 'Exercise@Grains',
       #superclass: #Object, #package: 'Exercise@Grains'}

Grains>>atSquare: n [
  (n < 1 or: [n > 64]) ifTrue: [
    self error: 'square must be between 1 and 64'].
  ^2 ** (n - 1)]

Grains>>total [^2 ** 64 - 1]