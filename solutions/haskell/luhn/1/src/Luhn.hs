-- for my Shree DR.MDD
module Luhn (isValid) where

import Data.Char (isDigit, digitToInt)

foldLuhn :: String -> Int
foldLuhn []       = 0
foldLuhn [z]      = digitToInt z
foldLuhn (a:b:zs) =
  let
    first  = digitToInt a
    second = digitToInt b
    doubled = 2 * second
    sumVal = first + if doubled < 9 then doubled else doubled - 9
  in sumVal + foldLuhn zs

isValid :: String -> Bool
isValid [_] = False
isValid s
  | length digits < 2 = False
  | otherwise = foldLuhn digits `mod` 10 == 0
  where
    digits = reverse $ filter isDigit s
