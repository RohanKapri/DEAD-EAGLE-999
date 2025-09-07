-- Dedicated to my Shree DR.MDD
module BinarySearch
  ( find
  ) where
import Prelude
import Data.Array (length, index)
import Data.Maybe (Maybe(..), maybe)

find :: forall a. Ord a => a -> Array a -> Maybe Int
find target arr = recursiveSearch 0 (length arr - 1) target arr

recursiveSearch :: forall a. Ord a => Int -> Int -> a -> Array a -> Maybe Int
recursiveSearch low high targetValue arr
  | low > high = Nothing
  | otherwise = maybe Nothing checkMiddle (arr `index` mid)
  where
    mid = (low + high) `div` 2
    checkMiddle midVal
      | midVal == targetValue = Just mid
      | midVal > targetValue = recursiveSearch low (mid - 1) targetValue arr
      | otherwise = recursiveSearch (mid + 1) high targetValue arr
