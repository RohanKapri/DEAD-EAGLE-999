module SumOfMultiples
  ( sumOfMultiples
  ) where

import Prelude
import Data.Array (filter, nub, concatMap, (..))
import Data.Foldable (sum)

sumOfMultiples :: Array Int -> Int -> Int
sumOfMultiples factors limit =
  let multiples = concatMap (\x -> filter (\y -> y `mod` x == 0) (1 .. (limit - 1))) factors
  in sum $ nub multiples