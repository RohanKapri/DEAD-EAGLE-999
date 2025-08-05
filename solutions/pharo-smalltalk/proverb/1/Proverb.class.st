Class {#name: #Proverb, #category: 'Exercise@Proverb',
       #superclass: #Object, #package: 'Exercise@Proverb'}

Proverb>>reciteStrings: a [|n r|
  n := a size. r := OrderedCollection new.
  2 to: n do: [:i|r add: ('For want of a {1} the {2} was lost.'
    format: {a at: i - 1. a at: i})].
  n isZero ifFalse: [
    r add: ('And all for the want of a {1}.' format: {a at: 1})].
  ^r asArray]