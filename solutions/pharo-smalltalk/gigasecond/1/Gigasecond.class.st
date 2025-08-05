Class {#name: 'Gigasecond', #category: 'Exercise@Gigasecond',
       #superclass: 'Object', #package: 'Exercise@Gigasecond'}

Gigasecond>>addMoment: s [|d|
  d := s asDateAndTime + (10 raisedTo: 9) seconds.
  ^d asDate yyyymmdd, 'T', d asTime print24]