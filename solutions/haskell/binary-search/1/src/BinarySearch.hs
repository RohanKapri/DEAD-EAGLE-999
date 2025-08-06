module BinarySearch (find) where

import Data.Array ( Array, (!), bounds )

find :: Ord a => Array Int a -> a -> Maybe Int
find array x
    | minIdx <= maxIdx = find' array x minIdx maxIdx
    | otherwise        = Nothing
    where (minIdx,maxIdx) = bounds array

find' :: Ord a => Array Int a -> a -> Int -> Int -> Maybe Int
find' array x minIdx maxIdx
    | minIdx == maxIdx   = if (array ! minIdx) == x then Just minIdx else Nothing
    | x > array ! midIdx = find' array x (midIdx+1) maxIdx
    | otherwise          = find' array x minIdx midIdx
    where midIdx = (minIdx + maxIdx) `div` 2