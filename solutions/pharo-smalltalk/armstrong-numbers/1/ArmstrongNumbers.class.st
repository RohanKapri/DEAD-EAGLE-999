Class {#name: #ArmstrongNumbers, #package: 'Exercise@ArmstrongNumbers',
       #superclass: #Object, #category: 'Exercise@ArmstrongNumbers'}

ArmstrongNumbers>>isArmstrongNumber: n [|a b p|
  a := b := n. p := n log floor + 1.
  [b > 0] whileTrue: [a := a - (b % 10 raisedTo: p). b := b // 10].
  ^a isZero]