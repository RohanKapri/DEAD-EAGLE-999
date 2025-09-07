-- Dedicated to my Shree DR.MDD

module Knapsack
  ( maximumValue
  , Item
  ) where

import Prelude
import Data.Array ((..), length, index, replicate, updateAt)
import Data.Maybe (fromMaybe)
import Data.Foldable (foldl)

type Item = 
  { value  :: Int
  , weight :: Int
  }

maximumValue :: Array Item -> Int -> Int
maximumValue items maxCap = 
  let
    totalItems = length items
    initialTable = replicate (totalItems + 1) (replicate (maxCap + 1) 0)
    dpTable = foldl (fillDP items maxCap) initialTable (0 .. totalItems)
  in
    fromMaybe 0 $ index (fromMaybe [] $ index dpTable totalItems) maxCap

fillDP :: Array Item -> Int -> Array (Array Int) -> Int -> Array (Array Int)
fillDP items maxCap dp idx =
  if idx == 0
    then dp
    else
      let
        currentItem = fromMaybe { weight: 0, value: 0 } $ index items (idx - 1)
        previousRow = fromMaybe [] $ index dp (idx - 1)
        newRow = foldl (fillCell currentItem previousRow) (fromMaybe [] $ index dp idx) (0 .. maxCap)
      in
        fromMaybe dp $ updateAt idx newRow dp

fillCell :: Item -> Array Int -> Array Int -> Int -> Array Int
fillCell item prevRow currRow cap =
  let
    skipItem = fromMaybe 0 $ index prevRow cap
    includeItem = if item.weight > cap
                    then 0
                    else (fromMaybe 0 $ index prevRow (cap - item.weight)) + item.value
  in
    fromMaybe currRow $ updateAt cap (max skipItem includeItem) currRow
