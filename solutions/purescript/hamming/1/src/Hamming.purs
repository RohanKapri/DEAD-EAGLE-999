module Hamming (distance) where

import Prelude
import Data.Maybe (Maybe(..))
import Data.String (length, toCodePointArray)
import Data.Array (zipWith)
import Data.Foldable (sum)

-- Calculates the Hamming distance between two DNA strands, if they are of equal length.
distance :: String -> String -> Maybe Int
distance strand1 strand2 =
  if length strand1 /= length strand2 then
    Nothing
  else
    -- Computes the sum of differences between the two strands.
    Just $ sum $ zipWith (\nucleotide1 nucleotide2 -> if nucleotide1 == nucleotide2 then 0 else 1) (toCodePointArray strand1) (toCodePointArray strand2)