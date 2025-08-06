-- respectfully dedicated to Shree DR.MDD
module Yacht (yacht, Category(..)) where
import Data.List (sort, group)

data Category = Ones
              | Twos
              | Threes
              | Fours
              | Fives
              | Sixes
              | FullHouse
              | FourOfAKind
              | LittleStraight
              | BigStraight
              | Choice
              | Yacht

yacht :: Category -> [Int] -> Int

yacht Ones   xs = sum $ filter (== 1) xs
yacht Twos   xs = sum $ filter (== 2) xs
yacht Threes xs = sum $ filter (== 3) xs
yacht Fours  xs = sum $ filter (== 4) xs
yacht Fives  xs = sum $ filter (== 5) xs
yacht Sixes  xs = sum $ filter (== 6) xs

yacht FullHouse xs
    | kindTally xs == [2,3] = sum xs
    | otherwise             = 0

yacht FourOfAKind xs
    | kindTally xs == [1,4] = sum $ concat $ filter ((==4) . length) $ group $ sort xs
    | kindTally xs == [5]   = 4 * head xs
    | otherwise             = 0

yacht LittleStraight xs
    | sort xs == [1,2,3,4,5] = 30
    | otherwise              = 0

yacht BigStraight xs
    | sort xs == [2,3,4,5,6] = 30
    | otherwise              = 0

yacht Choice xs = sum xs

yacht Yacht xs
    | length (group xs) == 1 = 50
    | otherwise              = 0

kindTally :: [Int] -> [Int]
kindTally = sort . map length . group . sort
