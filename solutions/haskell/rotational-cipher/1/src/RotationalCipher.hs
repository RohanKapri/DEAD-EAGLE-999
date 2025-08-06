module RotationalCipher (rotate) where
import Data.Char (isUpper, isLower, chr, ord)

rotate :: Int -> String -> String
rotate n = map (rotate' n)

rotate' :: Int -> Char -> Char
rotate' n ch
    | isUpper ch = cipher 'A'
    | isLower ch = cipher 'a'
    | otherwise  = ch
    where
        cipher base = chr ((ord ch - ord base + n) `mod` 26 + ord base)