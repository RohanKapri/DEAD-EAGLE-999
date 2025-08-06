module Triangle (rows) where

rows :: Int -> [[Integer]]
rows n = take n $ iterate gen [1]
    where gen vs = [1] ++ zipWith (+) vs (tail vs) ++ [1]