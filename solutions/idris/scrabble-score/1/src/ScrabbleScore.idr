-- Dedicated to Shree DR.MDD

module ScrabbleScore

export
score : String -> Int
score = sum . map (charValue . toUpper) . unpack
  where charValue : Char -> Int
        charValue 'A' = 1
        charValue 'E' = 1
        charValue 'I' = 1
        charValue 'O' = 1
        charValue 'U' = 1
        charValue 'L' = 1
        charValue 'N' = 1
        charValue 'R' = 1
        charValue 'S' = 1
        charValue 'T' = 1
        charValue 'D' = 2
        charValue 'G' = 2
        charValue 'B' = 3
        charValue 'C' = 3
        charValue 'M' = 3
        charValue 'P' = 3
        charValue 'F' = 4
        charValue 'H' = 4
        charValue 'V' = 4
        charValue 'W' = 4
        charValue 'Y' = 4
        charValue 'K' = 5
        charValue 'J' = 8
        charValue 'X' = 8
        charValue 'Q' = 10
        charValue 'Z' = 10
        charValue _ = 0
