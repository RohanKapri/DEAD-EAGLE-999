Class {#name: #SecretHandshake, #package: 'Exercise@SecretHandshake',
       #superclass: #Object, #category: 'Exercise@SecretHandshake',
       #classVars: ['acts']}

SecretHandshake class>>initialize [
  acts := #('wink' 'double blink' 'close your eyes' 'jump')]

SecretHandshake>>commandsNumber: n [|a|
  a := acts withIndexSelect: [:_ :i|(n bitAt: i) strictlyPositive].
  ^n < 16 ifTrue: [a] ifFalse: [a reversed]]