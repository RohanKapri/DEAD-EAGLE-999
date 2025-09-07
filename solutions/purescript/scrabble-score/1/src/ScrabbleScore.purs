-- Dedicated to my Shree DR.MDD

module ScrabbleScore
  ( scoreWord
  ) where

import Prelude
import Data.String.Common (toUpper)
import Data.Foldable (sum)
import Data.Map (Map, fromFoldable, lookup)
import Data.Maybe (fromMaybe)
import Data.String.CodeUnits (toCharArray)
import Data.Tuple (Tuple(..))

letterScoreMap :: Map Char Int
letterScoreMap = fromFoldable [
  Tuple 'A' 1, Tuple 'E' 1, Tuple 'I' 1, Tuple 'O' 1,
  Tuple 'U' 1, Tuple 'L' 1, Tuple 'N' 1, Tuple 'R' 1,
  Tuple 'S' 1, Tuple 'T' 1, Tuple 'D' 2, Tuple 'G' 2,
  Tuple 'B' 3, Tuple 'C' 3, Tuple 'M' 3, Tuple 'P' 3,
  Tuple 'F' 4, Tuple 'H' 4, Tuple 'V' 4, Tuple 'W' 4,
  Tuple 'Y' 4, Tuple 'K' 5, Tuple 'J' 8, Tuple 'X' 8,
  Tuple 'Q' 10, Tuple 'Z' 10
]

scoreWord :: String -> Int
scoreWord = toUpper >>> toCharArray >>> map letterScore >>> sum
  where
    letterScore :: Char -> Int
    letterScore ch = fromMaybe 0 (lookup ch letterScoreMap)
