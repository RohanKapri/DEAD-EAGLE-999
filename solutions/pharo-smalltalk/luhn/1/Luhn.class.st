Class {#name: #Luhn, #category: 'Exercise@Luhn',
       #superclass: #Object, #package: 'Exercise@Luhn'}

Luhn>>validValue: n [|s m v|
  s := n asString copyWithout: $ . m := s size. m < 2 ifTrue: [^false].
  ^((1 to: m) inject: 0 into: [:a :i|
    v := s at: i.
    v isDigit ifTrue: [v := v hash - 48] ifFalse: [^false].
    a + 1 + ((m - i) % 2 + 1 * v - 1 rem: 9)]) isDivisibleBy: 10]