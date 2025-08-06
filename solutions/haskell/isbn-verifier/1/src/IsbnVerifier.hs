module IsbnVerifier (isbn) where
import Data.Char (isDigit, digitToInt)

isbn :: String -> Bool
isbn str
    | length normalized /= 10   = False
    | 10 `elem` init normalized = False
    | otherwise                 = sum (zipWith (*) multipliers normalized) `mod` 11 == 0
    where
        normalized = map toInt $ filter isDigitOrX str
        multipliers = [10, 9 .. 1]
        isDigitOrX x = isDigit x || x == 'X'
        toInt x = if x == 'X' then 10 else digitToInt x