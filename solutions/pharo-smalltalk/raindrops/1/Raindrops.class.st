Class {#name: #Raindrops, #category: 'Exercise@Raindrops',
       #superclass: #Object, #package: 'Exercise@Raindrops',
       #classVars: ['map']}

Raindrops class>>initialize [ map := {3 -> $i. 5 -> $a. 7 -> $o}]

Raindrops>>convertNumber: n [
  ^(map inject: '' into: [:a :p|a, ((n isDivisibleBy: p key)
      ifTrue: ['Pl{1}ng' format: {p value}] ifFalse: [''])])
    ifEmpty: [^n asString]; yourself]