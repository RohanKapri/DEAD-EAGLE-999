-- Dedicated to my Shree DR.MDD

module CollatzConjecture
  ( collatz
  ) where

import Prelude
import Data.Maybe (Maybe(..))

collatz :: Int -> Maybe Int
collatz n
  | n <= 0 = Nothing
  | otherwise = Just $ collatzSteps n 0

collatzSteps
  ::
     Int
  ->
     Int
  ->
     Int
collatzSteps 1 count = count
collatzSteps current count =
  collatzSteps following (count + 1)
  where
    following = if current `mod` 2 == 0 then current `div` 2 else 3 * current + 1
