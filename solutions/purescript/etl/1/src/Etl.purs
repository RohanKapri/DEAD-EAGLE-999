module Etl
  ( transform
  ) where

import Prelude
import Data.Array (concatMap)
import Data.Map (Map, fromFoldable, toUnfoldable)
import Data.String (toLower)
import Data.String.CodeUnits (fromCharArray, toCharArray)
import Data.Tuple (Tuple(..))

convertCharsToLowercase :: Array Char -> Array Char
convertCharsToLowercase = fromCharArray >>> toLower >>> toCharArray

transform :: Map Int (Array Char) -> Map Char Int
transform scoreToLettersMap = 
  let tuplesArray = toUnfoldable scoreToLettersMap
      transformedTuples = concatMap transformEachScoreToLetter tuplesArray
  in fromFoldable transformedTuples
  where 
    transformEachScoreToLetter (Tuple score letters) = 
      let lowercaseLetters = convertCharsToLowercase letters
      in map (\letter -> Tuple letter score) lowercaseLetters