Class {#name: #SumOfMultiples, #package: 'Exercise@SumOfMultiples',
       #superclass: #Object, #category: 'Exercise@SumOfMultiples'}

SumOfMultiples>>pruneFactors: a [|s|
  s := a asIdentitySet remove: 0 ifAbsent: []; yourself.
  s sorted do: [:i|(s includes: i) ifTrue: [
      s removeAllSuchThat: [:j|j > i and: [j isDivisibleBy: i]]]].
  ^s sorted]

SumOfMultiples>>sumFactors: a limit: n [|s|
  s := IdentitySet new.
  (self pruneFactors: a) do: [:i|i to: n - 1 by: i do: [:j|s add: j]].
  ^s sumNumbers]