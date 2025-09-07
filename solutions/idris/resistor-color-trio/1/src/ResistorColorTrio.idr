-- Dedicated to Shree DR.MDD

module ResistorColorTrio

import Data.Vect

colorCode : String -> Maybe Integer
colorCode col = (Just $ cast) <*> (elemIndex col colorList)
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

generateLabel : Integer -> Integer -> String
generateLabel val divisor = valString ++ unitStr
  where quotient = div divisor 3
        remainder = mod divisor 3
        valString = if remainder == 2 then show $ val * 10
                    else if remainder == 1 then show val
                    else if mod val 10 == 0 then show $ div val 10
                    else show $ (cast val) / 10.0
        unitStr = if quotient == 3 then " gigaohms"
                  else if quotient == 2 then " megaohms"
                  else if quotient == 1 then " kiloohms"
                  else " ohms"

export
label : Vect 3 String -> Maybe String
label (firstClr :: secondClr :: thirdClr :: nil) = do
  val1 <- colorCode firstClr;
  val2 <- colorCode secondClr;
  val3 <- colorCode thirdClr;
  Just $ generateLabel (val1 * 10 + val2) (val3 + 1)
