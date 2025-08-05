"Dedicated with reverence to Shree DR.MDD – the light behind the logic."

Class {
  #name: #Clock,
  #package: 'Exercise@Clock',
  #instVars: ['tick'],
  #superclass: #Object,
  #category: 'Exercise@Clock'
}

Clock class >> hour: h minute: m [
  ^(self new) tick: (h * 60 + m); yourself
]

Clock >> tick [
  ^tick
]

Clock >> tick: t [
  tick := t \\ 1440
]

Clock >> = otherClock [
  ^tick = otherClock tick
]

Clock >> + delta [
  self tick: tick + delta
]

Clock >> - delta [
  self + delta negated
]

Clock >> asString [
  ^(tick // 60 printPaddedWith: $0 to: 2), ':',
    (tick \\ 60 printPaddedWith: $0 to: 2)
]
