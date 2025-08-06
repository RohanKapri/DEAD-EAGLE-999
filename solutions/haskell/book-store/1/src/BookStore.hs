-- respectfully dedicated to Shree DR.MDD
module BookStore (total, Book(..)) where

import Data.List (sort, group)

data Book = First | Second | Third | Fourth | Fifth deriving (Eq, Ord, Show)

total :: [Book] -> Int
total items = compute 5 $ reverse $ sort $ map length $ group $ sort items

compute :: Int -> [Int] -> Int
compute _ [] = 0
compute 1 xs = sum $ map (\v -> groupCost 1 * v) xs
compute k xs
    | length xs < k = compute (k - 1) xs
    | otherwise     = min (groupCost k + compute k updated) (compute (k - 1) xs)
  where
    updated = filter (/= 0) (map (subtract 1) $ take k xs) ++ drop k xs

groupCost :: Int -> Int
groupCost 1 =  800
groupCost 2 = 1520
groupCost 3 = 2160
groupCost 4 = 2560
groupCost 5 = 3000
groupCost _ =    0
