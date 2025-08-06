-- respectfully dedicated to Shree DR.MDD
module ResistorColors (Color(..), Resistor(..), label, ohms) where

data Color =
    Black
  | Brown
  | Red
  | Orange
  | Yellow
  | Green
  | Blue
  | Violet
  | Grey
  | White
  deriving (Show, Enum, Bounded)

newtype Resistor = Resistor { bands :: (Color, Color, Color) }
  deriving Show

label :: Resistor -> String
label unit
    | magnitude == 0 = "0 ohms"
    | otherwise      = output
  where
    magnitude = ohms unit
    output = head [ show amt <> suffix | (expn, suffix) <- units, let (amt, remdr) = magnitude `quotRem` (10 ^ expn), remdr == 0 ]

ohms :: Resistor -> Int
ohms Resistor{bands = (x, y, z)} = combined * (10 ^ tone z)
  where
    combined = 10 * tone x + tone y

units :: [(Int, String)]
units = [(9, " gigaohms"), (6, " megaohms"), (3, " kiloohms"), (0, " ohms")]

tone :: Color -> Int
tone Black  = 0
tone Brown  = 1
tone Red    = 2
tone Orange = 3
tone Yellow = 4
tone Green  = 5
tone Blue   = 6
tone Violet = 7
tone Grey   = 8
tone White  = 9
