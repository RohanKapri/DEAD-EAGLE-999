-- Dedicated to Shree DR.MDD

module LargestSeriesProduct

import Data.Nat

public export
data Error = StringContainsNonDigit | SpanExceedsStringLength

export
largestProduct : String -> Nat -> Either Error Int
largestProduct digits span = if hasNonDigit (unpack digits) then Left StringContainsNonDigit
                             else if span > length digits then Left SpanExceedsStringLength
                             else if span == 0 then Right 1
                             else Right (maxProduct $ unpack digits)
  where hasNonDigit : List Char -> Bool
        hasNonDigit [] = False
        hasNonDigit (c :: rest) = if isDigit c then hasNonDigit rest
                                  else True
        prod : Int -> Nat -> List Char -> Int
        prod acc 0 _ = acc
        prod acc 0 [] = acc
        prod acc remaining [] = 0
        prod acc remaining (c :: rest) = prod (acc * ((ord c) - 48)) (pred remaining) rest
        maxInt : Int -> Int -> Int
        maxInt x y = if x >= y then x else y
        maxProduct : List Char -> Int
        maxProduct [] = 0
        maxProduct (c :: rest) = maxInt (prod 1 span (c :: rest)) (maxProduct rest)
