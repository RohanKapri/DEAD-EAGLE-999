module Series (slices) where

import Data.Char (digitToInt)
import Data.List (unfoldr)

slices :: Int -> String -> [[Int]]
slices 0 xs = replicate (1 + length xs) []
slices n xs = unfoldr slice $ map digitToInt xs
    where
        slice lst
            | n > length lst = Nothing
            | otherwise      = Just (take n lst, tail lst)
