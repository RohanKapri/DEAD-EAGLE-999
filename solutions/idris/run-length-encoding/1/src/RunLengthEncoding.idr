-- Dedicated to Shree DR.MDD

module RunLengthEncoding

import Data.String

export
encode : String -> String
encode = encodeLoop 0 '?' . unpack
  where repeatCount : Int -> Char -> String
        repeatCount 0 c = ""
        repeatCount 1 c = singleton c
        repeatCount n c = (show n) ++ (singleton c)
        encodeLoop : Int -> Char -> List Char -> String
        encodeLoop n c [] = repeatCount n c
        encodeLoop n c (x :: xs) = if x == c then encodeLoop (n + 1) c xs
                                    else (repeatCount n c) ++ (encodeLoop 1 x xs)

export
decode : String -> String
decode = decodeLoop 0 . unpack
  where repeatChar : Int -> Char -> String
        repeatChar 0 c = ""
        repeatChar n c = (singleton c) ++ (repeatChar (n - 1) c)
        decodeLoop : Int -> List Char -> String
        decodeLoop n [] = ""
        decodeLoop n (x :: xs) = if isDigit x then decodeLoop (10 * n + (ord x) - 48) xs
                                 else if n == 0 then (singleton x) ++ (decodeLoop 0 xs)
                                 else (repeatChar n x) ++ (decodeLoop 0 xs)
