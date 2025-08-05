Class {#name: #Matrix, #package: 'Exercise@Matrix', #instVars: ['mat'],
       #superclass: #Object, #category: 'Exercise@Matrix'}

Matrix>>initialise: s [|n a|n := s lineCount. a := s parseLiterals.
  mat := Array2D rows: n columns: a size // n contents: a]

Matrix>>input: s atRow: n [ self initialise: s. ^mat atRow: n]
Matrix>>input: s atColumn: n [ self initialise: s. ^mat atColumn: n]