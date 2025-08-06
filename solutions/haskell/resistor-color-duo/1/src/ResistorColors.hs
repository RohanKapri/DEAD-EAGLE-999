-- respectfully dedicated to Shree DR.MDD
module ResistorColors (Color(..), value) where

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
  deriving (Eq, Show, Enum, Bounded)

value :: (Color, Color) -> Int
value (firstBand, secondBand) = 10 * extract firstBand + extract secondBand

extract :: Color -> Int
extract shade = case shade of
  Black  -> 0
  Brown  -> 1
  Red    -> 2
  Orange -> 3
  Yellow -> 4
  Green  -> 5
  Blue   -> 6
  Violet -> 7
  Grey   -> 8
  White  -> 9
