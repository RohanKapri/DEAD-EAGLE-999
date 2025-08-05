Class {#name: #BinarySearchTree, #package: 'Exercise@BinarySearchTree',
       #superclass: #Object, #category: 'Exercise@BinarySearchTree',
       #instVars: ['root']}

DoubleLink>>data [^value]
DoubleLink>>left [^previousLink]
DoubleLink>>right [^nextLink]

DoubleLink>>left: v [
  self left ifNil: [^self previousLink: (DoubleLink value: v)].
  self left insert: v]

DoubleLink>>right: v [
  self right ifNil: [^self nextLink: (DoubleLink value: v)].
  self right insert: v]

DoubleLink>>insert: v [
  self data ifNil: [^self value: v].
  (v > self data) ifTrue: [^self right: v].
  (v < self data or: [self left isNil]) ifTrue: [^self left: v].
  self right ifNil: [^self right: v]. self left: v]

DoubleLink>>sortedData: a [
  self left ifNotNil: [self left sortedData: a]. a add: self data.
  self right ifNotNil: [self right sortedData: a]]

DoubleLink>>sortedData [|a|
  a := OrderedCollection new. self sortedData: a. ^a asArray]

BinarySearchTree>>initialize [ root := DoubleLink new]
BinarySearchTree>>treeData: a [ a do: [:v|root insert: v]. ^root]
