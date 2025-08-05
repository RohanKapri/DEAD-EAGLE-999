Class {#name: #Pangram, #category: 'Exercise@Pangram',
       #superclass: #Object, #package: 'Exercise@Pangram'}

Pangram>>isPangramSentence: s [|d c|
  d := Set new.
  s do: [:x|x isLetter ifTrue: [
    c := x asLowercase.
    (d includes: c) ifFalse: [d add: c. d size >= 26 ifTrue: [^true]]]].
  ^false]