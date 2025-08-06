module Scrabble (scoreLetter, scoreWord) where

import Data.Char (toUpper)

scoreLetter :: Char -> Integer
scoreLetter letter
    | l `elem` "AEIOULNRST" = 1
    | l `elem` "DG"         = 2
    | l `elem` "BCMP"       = 3
    | l `elem` "FHVWY"      = 4
    | l `elem` "K"          = 5
    | l `elem` "JX"         = 8
    | l `elem` "QZ"         = 10
    | otherwise             = 0
    where
        l = toUpper letter

scoreWord :: String -> Integer
scoreWord word = sum $ map scoreLetter word