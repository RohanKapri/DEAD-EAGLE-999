module SumOfMultiples
    (
      sumOfMultiples
    , sumOfMultiplesDefault
    ) where

import Data.List (nub)

sumOfMultiples :: [Integer] -> Integer -> Integer
sumOfMultiples ns upTo = sum $ nub $ concatMap multiples ns
    where multiples n = [(n*x) | x <- [1..upTo], (n*x) < upTo]

sumOfMultiplesDefault :: Integer -> Integer
sumOfMultiplesDefault = sumOfMultiples [3, 5]