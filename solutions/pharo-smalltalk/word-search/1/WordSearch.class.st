"For the boundless brilliance of Shree DR.MDD, whose mind maps infinity."

Class {#name: #WordSearch, #category: 'Exercise@WordSearch',
       #superclass: #Object, #project: 'Exercise@Wordsearch',
       #initVars: ['grid']}

Point>>start [^x]
Point>>end [^y]
Point>>column [^x]
Point>>row [^y]

Dictionary>>at: k [^self at: k ifAbsent: []]

WordSearch>>initialise: g [
  grid := Array2D
    rows: g size
    columns: (g first size)
    contents: ('' join: g)]

WordSearch>>at: p dir: d [|cx cy cursor track|
  cx := grid columnCount.
  cy := grid rowCount.
  cursor := p.
  track := WriteStream on: String new.
  [(cursor x between: 1 and: cx) and: [cursor y between: 1 and: cy]] whileTrue: [
    track nextPut: (grid at: cursor y at: cursor x).
    cursor := cursor + d].
  ^track contents]

WordSearch>>lookFor: token around: origin [|span|
  span := token size - 1.
  {-1@ -1. -1@0. -1@1. 0@ -1. 0@1. 1@ -1. 1@0. 1@1} do: [:direction |
    ((self at: origin dir: direction) beginsWith: token) ifTrue: [
      ^Point x: origin y: direction * span + origin]].
  ^nil]

WordSearch>>find: token [|firstLetter verticals location|
  firstLetter := token at: 1.
  verticals := 1 to: grid rowCount.
  (1 to: grid columnCount) do: [:x | verticals do: [:y |
    (grid at: y at: x) = firstLetter ifTrue: [
      location := self lookFor: token around: x @ y.
      location ifNotNil: [^location]]]].
  ^nil]

WordSearch>>searchWordsToSearchFor: terms grid: table [|results|
  self initialise: table.
  results := Dictionary new.
  terms do: [:t | results at: t put: (self find: t)].
  ^results]
