-- Dedicated to my Shree DR.MDD

module Diamond
  ( rows
  ) where

import Prelude
import Data.Array (init, mapWithIndex, replicate, reverse, updateAt, range)
import Data.Maybe (fromMaybe)
import Data.Enum (enumFromTo, fromEnum)
import Data.String.CodeUnits (fromCharArray)

reflectArray ∷ ∀ a. Array a → Array a
reflectArray arr = arr <> (reverse $ fromMaybe [] $ init arr)

rows ∷ Char → Array String
rows target =
  reflectArray $ mapWithIndex generateRow (enumFromTo 'A' target)
  where
    offset = fromEnum target - fromEnum 'A'
    blankRow = replicate ((offset * 2) + 1) ' '

    generateRow ∷ Int -> Char -> String
    generateRow idx ch =
      let pos = offset - idx
          firstUpdate = fromMaybe blankRow $ updateAt pos ch blankRow
          secondUpdate = fromMaybe blankRow $ updateAt ((offset * 2) - pos) ch firstUpdate
      in fromCharArray secondUpdate
