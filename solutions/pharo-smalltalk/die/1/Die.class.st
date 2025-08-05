Class {#name: #Die, #superclass: #Object,
       #instanceVariableNames: 'sides', #category: #'Exercise@Die'}

Die class>>withFaces: n [^(self new) faces: n; yourself]

Die>>faces [^sides]

Die>>faces: n [ sides := n]

Die>>initialize [ self faces: 6]

Die>>roll [^(1 to: sides) atRandom]