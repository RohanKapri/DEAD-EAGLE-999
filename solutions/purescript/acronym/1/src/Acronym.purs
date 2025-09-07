module Acronym
  ( abbreviate
  ) where

import Prelude
import Data.String (toUpper)
import Data.String.CodeUnits (fromCharArray, toCharArray)
import Data.String.Regex (split)
import Data.String.Regex.Flags (noFlags)
import Data.String.Regex.Unsafe (unsafeRegex)
import Data.Array (head, mapMaybe)

abbreviate :: String -> String
abbreviate str = fromCharArray $ mapMaybe (head <<< toCharArray <<< toUpper) words
  where
    words = split (unsafeRegex "[ -]|(?<=[a-z])(?=[A-Z])" noFlags) str