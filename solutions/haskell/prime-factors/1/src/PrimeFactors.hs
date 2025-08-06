module PrimeFactors (primeFactors) where

primeFactors :: Integer -> [Integer]
primeFactors n = primeFactors' n (2 : [3, 5 ..])

primeFactors' :: Integer -> [Integer] -> [Integer]
primeFactors' n factors
    | n <= 1    = []
    | m == 0    = f : primeFactors' d factors
    | otherwise = primeFactors' n $ tail factors
    where
        f = head factors
        (d, m) = n `divMod` f