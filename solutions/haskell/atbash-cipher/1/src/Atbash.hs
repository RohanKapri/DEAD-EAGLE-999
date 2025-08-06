module Atbash (decode, encode) where
import Data.Char (isAlpha, chr, ord, isAlphaNum, toLower)
import Data.List.Split (chunksOf)
decode :: String -> String
decode cipherText = map atbash $ filter isAlphaNum cipherText
encode :: String -> String
encode plainText = unwords $ chunksOf 5 $ map (atbash . toLower) (filter isAlphaNum plainText)
atbash :: Char -> Char
atbash c
    | isAlpha c = chr (ord 'z' - (ord c - ord 'a'))
    | otherwise = c
