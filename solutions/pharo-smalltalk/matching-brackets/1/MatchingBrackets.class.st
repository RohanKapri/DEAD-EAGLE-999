Class {#name: #MatchingBrackets, #package: 'Exercise@MatchingBrackets',
       #superclass: #Object, #category: 'Exercise@MatchingBrackets',
       #classVars: ['pairs']}

MatchingBrackets class>>initialize [ pairs := #('()' '[]' '{}') asSet]

MatchingBrackets>>isPaired: s [|t|
  t := Stack new.
  s do: [:c|c isOpenPunctuation ifTrue: [t push: c] ifFalse: [
    c isClosePunctuation ifTrue: [
      t ifEmpty: [^false].
      (pairs includes: ({t pop. c} joinUsing: '')) ifFalse: [^false]]]].
  ^t isEmpty]