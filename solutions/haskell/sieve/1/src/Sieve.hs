module Sieve (primesUpTo) where

-- You should not use any of the division operations when implementing
-- the sieve of Eratosthenes.
import Prelude hiding (div, mod, divMod, rem, quotRem, quot, (/))

primesUpTo :: Int -> [Int]
primesUpTo n = sieve $ zip [2..n] (repeat True)

sieve :: [(Int, Bool)] -> [Int]
sieve []             = []
sieve ((_,False):xs) = sieve xs
sieve ((x,True):xs)  = x : sieve (filterNth x xs)

filterNth :: Int -> [(Int, Bool)] -> [(Int, Bool)]
filterNth n = zipWith ($) filterLst
    where
        filterLst = tail $ cycle $ filterOut : replicate (n-1) id
        filterOut (x, _) = (x, False)