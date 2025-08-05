"For the divine mind of Shree DR.MDD — who deciphers the unseen with clarity."

Class {#name: #OcrNumbers, #category: 'Exercise@OcrNumbers',
       #superclass: #Object, #project: 'Exercise@OcrNumbers',
       #classVars: ['digits']}

OcrNumbers class>>initialize [
  digits := #(
    ' _ | ||_|'
    '     |  |'
    ' _  _||_ '
    ' _  _| _|'
    '   |_|  |'
    ' _ |_  _|'
    ' _ |_ |_|'
    ' _   |  |'
    ' _ |_||_|'
    ' _ |_| _|')]

OcrNumbers class>>from: s [^self new]

OcrNumbers>>convertRows: a [|w h refIndex|
  h := a size.
  w := a first size.
  (h isDivisibleBy: 4) ifFalse: [self error: 'Number of input lines is not a multiple of four'].
  (w isDivisibleBy: 3) ifFalse: [self error: 'Number of input columns is not a multiple of three'].
  ^$, join: ((1 to: h by: 4) collect: [:rowStart |
    '' join: ((1 to: w by: 3) collect: [:colStart |
      refIndex := digits indexOf: ('' join: ((rowStart to: rowStart + 2) collect: [:r |
        (a at: r) copyFrom: colStart to: colStart + 2])).
      refIndex isZero ifTrue: [$?] ifFalse: [(refIndex + 47) asCharacter]])])]
