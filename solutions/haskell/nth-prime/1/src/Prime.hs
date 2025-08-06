module Prime (nth) where

nth n | n >= 1 = Just $ (primes' [2 .. ]) !! (n-1)
      | otherwise = Nothing
      where primes' (x:xs) = x:(primes' $ filter ((/= 0) . (`mod` x)) xs)