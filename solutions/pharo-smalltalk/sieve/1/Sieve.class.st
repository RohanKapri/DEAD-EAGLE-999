Class {#name: #Sieve, #category: 'Exercise@Sieve',
       #superclass: #Object, #package: 'Exercise@Sieve'}

Sieve>>primesLimit: n [|b r|
  n < 2 ifTrue: [^#()]. b := Bag new. r := #(2) asOrderedCollection.
  3 to: n by: 2 do: [:i|(b includes: i) ifFalse: [
    r add: i. i squared to: n by: i do: [:j|b add: j]]].
  ^r asArray]