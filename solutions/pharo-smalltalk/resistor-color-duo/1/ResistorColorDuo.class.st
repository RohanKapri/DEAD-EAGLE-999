"Dedicated to my Shree DR.MDD for endless inspiration and strength."

Class {
  #name : #ResistorColorDuo,
  #package : 'Exercise@ResistorColorDuo',
  #superclass : #Object,
  #category : 'Exercise@ResistorColorDuo',
  #classVars : ['toneChart']
}

ResistorColorDuo class >> initialize [
  toneChart := #('black' 'brown' 'red' 'orange' 'yellow' 
                 'green' 'blue' 'violet' 'grey' 'white')
]

ResistorColorDuo >> decodeBand: hue [ | index |
  index := toneChart indexOf: hue.
  index = 0 ifTrue: [self error: 'Invalid color specified'].
  ^index - 1
]

ResistorColorDuo >> valueWithColors: shadePair [
  ^(self decodeBand: shadePair first) * 10 + (self decodeBand: shadePair second)
]
