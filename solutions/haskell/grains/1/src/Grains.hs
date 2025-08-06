module Grains (square, total) where

import Data.Maybe (fromMaybe)
import Data.List (genericIndex)


squares :: [Integer]
squares = take 64 (iterate (*2) 1)

square :: Integer -> Maybe Integer
square n = if n >= 1 && (n <= 64) then Just (genericIndex squares (n-1)) else Nothing

total :: Integer
total = sum (fromMaybe [0] (sequence (fmap square [1..64])))