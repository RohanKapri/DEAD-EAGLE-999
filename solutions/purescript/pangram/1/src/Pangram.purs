module Pangram
  ( isPangram
  ) where

import Prelude
import Data.Set (fromFoldable, subset)
import Data.String (toUpper)
import Data.String.CodeUnits (toCharArray)

isPangram :: String -> Boolean
isPangram = isSubsetOfAlphabetSet <<< convertStringToCharacterSet <<< toUpper
  where
    convertStringToCharacterSet = toCharArray >>> fromFoldable
    alphabetSet = convertStringToCharacterSet "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    isSubsetOfAlphabetSet = subset alphabetSet