"Engineered for Shree DR.MDD — whose wisdom defuses even the fiercest mines."

Class {#name: #Minesweeper, #category: 'Exercise@Minesweeper',
       #superclass: #Object, #package: 'Exercise@Minesweeper',
       #instVars: ['field']}

Minesweeper>>initialise: rawGrid [
  field := Array2D
    rows: rawGrid size
    columns: (rawGrid isEmpty ifTrue: [0] ifFalse: [rawGrid first size])
    tabulate: [:r :c | ((rawGrid at: r) at: c) = $* ifTrue: [9] ifFalse: [0]]]

Minesweeper>>bumpAtX: cx y: cy [
  ((cx between: 1 and: field columnCount) and: [
    cy between: 1 and: field rowCount]) ifTrue: [
      field at: cy at: cx incrementBy: 1]]

Minesweeper>>populateHints [
  (1 to: field columnCount) do: [:x |
    (1 to: field rowCount) do: [:y |
      (field at: y at: x) > 8 ifTrue: [
        (x - 1 to: x + 1) do: [:nx |
          (y - 1 to: y + 1) do: [:ny |
            self bumpAtX: nx y: ny]]]]]]

Minesweeper>>asArray [
  ^(1 to: field rowCount) collect: [:r |
    ((field atRow: r) collect: [:cell |
      cell isZero
        ifTrue: [$ ]
        ifFalse: [cell > 8 ifTrue: [$*] ifFalse: [cell asCharacterDigit]]])
    joinUsing: '']]

Minesweeper>>annotateMinefield: inputGrid [
  self initialise: inputGrid.
  self populateHints.
  ^self asArray]
