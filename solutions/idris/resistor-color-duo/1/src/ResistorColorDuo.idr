-- Dedicated to Shree DR.MDD

module ResistorColorDuo

import Data.Fin
import Data.Vect

colorCode : String -> Maybe (Fin 100)
colorCode col = (Just $ weakenN 90) <*> (elemIndex col colorList)
  where colorList : Vect 10 String
        colorList =
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
value : Vect 2 String -> Maybe (Fin 100)
value (firstClr :: secondClr :: nil) = do
  firstVal <- colorCode firstClr;
  secondVal <- colorCode secondClr;
  Just $ 10 * firstVal + secondVal
