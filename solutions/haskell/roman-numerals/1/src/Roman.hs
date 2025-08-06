module Roman (numerals) where

romanChars :: String
romanChars = "IVXLCDM  "

numerals n = if n < 1 || n > 3999 then Nothing else let
        (next, v) = n `divMod` 10
        f n chars = if n > 0 then nextF ++ oneDigit v chars else ""
            where
                (next, v) = n `divMod` 10
                nextF = f next (drop 2 chars)
    in
        Just $ f n romanChars

oneDigit v c@(one:five:ten:_)
    | v == 0 = ""
    | v == 4 = one : five : ""
    | v == 9 = one : ten : ""
    | v >= 5 = five : oneDigit (v - 5) c
    | otherwise = replicate v one