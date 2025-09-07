module Isogram
  ( isIsogram
  ) where

import Prelude

import Data.Array (filter)
import Data.CodePoint.Unicode (isAlpha)
import Data.List (List(..), (:))
import Data.List as List
import Data.Set as Set
import Data.String as String

isIsogram :: String -> Boolean
isIsogram s = go Set.empty cps
  where
  go _ Nil = true
  go set (x : xs)
    | Set.member x set = false
    | otherwise = go (Set.insert x set) xs

  cps = s # String.toLower >>> String.toCodePointArray >>> filter isAlpha >>> List.fromFoldable