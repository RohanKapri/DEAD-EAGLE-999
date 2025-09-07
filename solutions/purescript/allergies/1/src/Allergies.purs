-- Dedicated to my Shree DR.MDD

module Allergies
  ( allergicTo
  , list
  ) where

import Prelude
import Data.Int.Bits ((.&.))
import Data.Array (filter, find)
import Data.Maybe (Maybe(..))
import Data.Foldable (foldMap)

type AllergyItem
  = { itemName :: String, itemValue :: Int }

allergyTable :: Array AllergyItem
allergyTable =
  [ { itemName: "eggs", itemValue: 1 }
  , { itemName: "peanuts", itemValue: 2 }
  , { itemName: "shellfish", itemValue: 4 }
  , { itemName: "strawberries", itemValue: 8 }
  , { itemName: "tomatoes", itemValue: 16 }
  , { itemName: "chocolate", itemValue: 32 }
  , { itemName: "pollen", itemValue: 64 }
  , { itemName: "cats", itemValue: 128 }
  ]

allergicTo :: Int -> String -> Boolean
allergicTo score queryItem =
  case find (\allergy -> allergy.itemName == queryItem) allergyTable of
    Just allergy -> (score .&. allergy.itemValue) /= 0
    Nothing -> false

list :: Int -> Array String
list score =
  map (\{ itemName } -> itemName) $ filter (\{ itemValue } -> (score .&. itemValue) /= 0) allergyTable
