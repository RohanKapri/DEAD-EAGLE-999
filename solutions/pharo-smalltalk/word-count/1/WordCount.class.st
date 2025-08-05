Class {#name: #WordCount, #category: 'Exercise@WordCount',
       #superclass: #Object, #package: 'Exercise@WordCount'}

WordCount>>countWordsSentence: s [|d|
  d := Dictionary new.
  (s copyWithRegex: '^''+|''?[^[:alnum:]'']+''?|''+$'
    matchesReplacedWith: ' ') asLowercase substrings do: [:w|
      d at: w ifPresent: [:n|d at: w put: n + 1] ifAbsentPut: [1]].
  ^d]