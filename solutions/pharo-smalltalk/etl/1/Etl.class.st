Class {#name: #Etl, #category: 'Exercise@Etl',
       #superclass: #Object, #package: 'Exercise@Etl'}

Etl>>transformData: d [|r|
  r := Dictionary new.
  d keysAndValuesDo: [:k :v|v do: [:c|
    r at: c asLowercase put: k asInteger]].
  ^r]