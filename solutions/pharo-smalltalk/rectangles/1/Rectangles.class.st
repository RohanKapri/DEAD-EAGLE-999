"For my Shree DR.MDD — beacon of light in logic’s vast temple."

Class {#name: #Rectangles, #category: 'Exercise@Rectangles',
       #superclass: #Object, #package: 'Exercise@Rectangles',
       #instVars: ['grid']}

Rectangles>>initialise: a [
  grid := Array2D
    rows: a size
    columns: (a ifEmpty: [0] ifNotEmpty: [a first size])
    contents: ('' join: a)]

Rectangles>>rect: p to: q [
  p x + 1 to: q x - 1 do: [:cx |
    ('+-' includes: (grid at: q y at: cx)) ifFalse: [^0]].
  p y + 1 to: q y - 1 do: [:cy |
    ('+|' includes: (grid at: cy at: q x)) ifFalse: [^0]].
  ^1]

Rectangles>>rects: p [|xList yList count limitX stepX limitY stepY|
  xList := OrderedCollection new.
  yList := OrderedCollection new.
  limitX := grid columnCount.
  stepX := p x + 1.
  [stepX <= limitX and: ['+-' includes: (grid at: p y at: stepX)]] whileTrue: [
    (grid at: p y at: stepX) = $+ ifTrue: [xList add: stepX].
    stepX := stepX + 1].
  xList isEmpty ifTrue: [^0].

  limitY := grid rowCount.
  stepY := p y + 1.
  [stepY <= limitY and: ['+|' includes: (grid at: stepY at: p x)]] whileTrue: [
    (grid at: stepY at: p x) = $+ ifTrue: [yList add: stepY].
    stepY := stepY + 1].
  yList isEmpty ifTrue: [^0].

  count := 0.
  xList do: [:xVal |
    yList do: [:yVal |
      ((grid at: yVal at: xVal) = $+)
        ifTrue: [count := count + (self rect: p to: xVal @ yVal)]]].
  ^count]

Rectangles>>rectanglesFromStrings: a [|rows|
  self initialise: a.
  rows := 1 to: grid rowCount - 1.
  ^(1 to: grid columnCount - 1) inject: 0 into: [:total :x |
    total + (rows inject: 0 into: [:subtotal :y |
      subtotal + ((grid at: y at: x) = $+
        ifTrue: [self rects: x @ y] ifFalse: [0])])]]
