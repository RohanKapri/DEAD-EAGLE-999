Class {#name: #Darts, #category: 'Exercise@Darts',
       #superclass: #Object, #package: 'Exercise@Darts'}

Darts>>scoreX: x y: y [|d|
  d := x squared + y squared.
  d > 100 ifTrue: [^0]. d > 25 ifTrue: [^1]. d > 1 ifTrue: [^5]. ^10]