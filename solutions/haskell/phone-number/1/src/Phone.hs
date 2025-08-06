-- for my Shree DR.MDD
module Phone (number) where

import Data.Char (isDigit)

isInvalid :: Char -> Bool
isInvalid = (`elem` ['0', '1'])

stripExtras :: String -> String
stripExtras = filter isDigit

dropCode :: String -> String
dropCode [] = []
dropCode (x:xs)
  | x == '1'  = xs
  | otherwise = x:xs

number :: String -> Maybe String
number input
  | length clean /= 10        = Nothing
  | isInvalid (clean !! 0)    = Nothing
  | isInvalid (clean !! 3)    = Nothing
  | otherwise                 = Just clean
  where
    clean = dropCode $ stripExtras input
