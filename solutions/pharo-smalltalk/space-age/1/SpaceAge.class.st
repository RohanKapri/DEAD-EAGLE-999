Class {#name: #SpaceAge, #package: 'Exercise@SpaceAge',
       #superclass: #Object, #category: 'Exercise@SpaceAge',
       #classVars: ['periods']}

SpaceAge class>>initialize [ periods := {
  'Mercury' -> 0.2408467. 'Venus' -> 0.61519726. 'Earth' -> 1.
  'Mars' -> 1.8808158. 'Jupiter' -> 11.862615. 'Saturn' -> 29.447498.
  'Uranus' -> 84.016846. 'Neptune' -> 164.79132} asDictionary]

SpaceAge>>ageOnPlanet: k at: n [^n / 31557600 / (periods at: k)]