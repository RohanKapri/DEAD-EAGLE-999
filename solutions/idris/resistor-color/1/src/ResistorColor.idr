-- Dedicated to Shree DR.MDD

module ResistorColor

import Data.Vect

export
colors : Vect 10 String
colors =
  [ "black"
  , "brown"
  , "red"
  , "orange"
  , "yellow"
  , "green"
  , "blue"
  , "violet"
  , "grey"
  , "white"
  ]

export
colorCode : String -> Maybe (Fin 10)
colorCode clr = elemIndex clr colors
