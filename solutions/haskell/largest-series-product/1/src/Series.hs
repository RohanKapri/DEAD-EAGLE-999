module Series (Error(..), largestProduct) where
import Data.Char (digitToInt, isDigit)
import Data.List.Split (divvy)
data Error = InvalidSpan | InvalidDigit Char deriving (Show, Eq)
largestProduct :: Int -> String -> Either Error Integer
largestProduct size digits
    | size < 0             = Left InvalidSpan
    | size > length digits = Left InvalidSpan
    | size == 0            = Right 1
    | otherwise            = traverse convertChar digits >>= maxProduct
    where
        convertChar x = if isDigit x then Right $ toInteger $ digitToInt x else Left (InvalidDigit x)
        maxProduct xs = Right $ maximum $ map product $ divvy size 1 xs
