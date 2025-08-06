module Change (findFewestCoins) where

import Data.Maybe (listToMaybe)

type Target = Integer
type Coins = [Integer]

findFewestCoins :: Target -> Coins -> Maybe Coins
findFewestCoins target coins = listToMaybe $ findFor target coins

findFor :: Target -> Coins -> [Coins]
findFor _ [] = []
findFor target coins@(c : cs)
  | target < 0 = []
  | target == 0 = [[]]
  | otherwise = findFor target cs <> ((c :) <$> findFor (target - c) coins)