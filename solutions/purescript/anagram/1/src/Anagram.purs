module Anagram
  ( anagramsFor
  ) where

import Prelude
import Data.String (toLower)
import Data.String.CodeUnits (fromCharArray, toCharArray)
import Data.Array (sort, filter)

anagramsFor :: String -> Array String -> Array String
anagramsFor word candidates = filter isAnagram candidates
  where
    lowerWord = toLower word
    sortedWord = sort $ toCharArray lowerWord
    isAnagram candidate
      | lowerWord == toLower candidate = false
      | otherwise = sortedWord == sort (toCharArray $ toLower candidate)