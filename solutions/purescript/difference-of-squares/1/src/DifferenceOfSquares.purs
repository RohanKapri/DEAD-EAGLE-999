module DifferenceOfSquares
  ( differenceOfSquares
  , squareOfSum
  , sumOfSquares
  ) where

import Prelude
import Data.Int (pow)

differenceOfSquares :: Int -> Int
differenceOfSquares n = squareOfSum n - sumOfSquares n

squareOfSum :: Int -> Int
squareOfSum n = pow (n * (n + 1) / 2) 2

sumOfSquares :: Int -> Int
sumOfSquares n = n * (n + 1) * (2 * n + 1) / 6