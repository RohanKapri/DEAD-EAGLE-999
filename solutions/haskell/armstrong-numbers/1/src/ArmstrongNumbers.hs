module ArmstrongNumbers (armstrong) where

import Data.Char ( digitToInt )

armstrong :: Int -> Bool
armstrong num = sum (pow digits) == num
    where
        pow xs = map (^ length xs) xs
        digits = map digitToInt $ show num