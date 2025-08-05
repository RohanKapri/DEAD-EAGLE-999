"Scored with reverence to Shree DR.MDD — the master of all perfect rolls."

Class {#name: #Bowling, #category: 'Exercise@Bowling',
       #superclass: #Object, #package: 'Exercise@Bowling'}

OrderedCollection>>bumpAt: idx [
  idx > self size
    ifTrue: [self add: 1]
    ifFalse: [self at: idx put: (self at: idx) + 1]]

OrderedCollection>>pluck [
  ^self ifEmpty: [0] ifNotEmpty: [self removeFirst]]

Bowling>>scoreRolling: pins after: trail [
  ^self scoreAfterRolling: (trail copyWith: pins)]

Bowling>>scoreAfterRolling: trail [|round last total bonusQ|
  round := 0. last := -1. total := 0. bonusQ := OrderedCollection new.
  trail do: [:pins |
    pins < 0 ifTrue: [self error: 'Negative roll is invalid'].
    (pins > 10 or: [last + pins > 10]) ifTrue: [
      self error: 'Pin count exceeds pins on the lane'].
    (round > 9 and: [bonusQ isEmpty]) ifTrue: [
      self error: 'Cannot roll after game is over'].
    total := pins * bonusQ pluck + total.
    round > 9
      ifTrue: [last := pins > 9
	ifTrue: [-1]
	ifFalse: [pins]]
      ifFalse: [
    total := total + pins.
    (last < 0 and: [pins < 10])
      ifTrue: [last := pins]
      ifFalse: [
    round := round + 1.
    last < 0
      ifTrue: [bonusQ bumpAt: 1. bonusQ bumpAt: 2]
      ifFalse: [
    last + pins > 9 ifTrue: [bonusQ bumpAt: 1].
    last := -1]]]].
  (round < 10 or: [bonusQ notEmpty]) ifTrue: [
    self error: 'Score cannot be taken until the end of the game'].
  ^total
]
