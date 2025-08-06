module Diamond (diamond) where

import Data.Char (isAsciiUpper)

diamond :: Char -> Maybe [String]
diamond c
    | isAsciiUpper c = Just $ map (row numSpaces) letters
    | otherwise = Nothing
    where
        halfLetters = zip [0..] ['A'..c]
        letters = halfLetters ++ (tail . reverse) halfLetters
        numSpaces = length halfLetters - 1

row :: Int -> (Int, Char) -> String
row numSpaces (idx, val) = halfRow ++ (tail . reverse) halfRow
    where
        halfRow = spaces (numSpaces-idx) ++ [val] ++ spaces idx
        spaces n = replicate n ' '