module Raindrops (convert) where

convert :: Int -> String
convert n
    | null sounds = show n
    | otherwise   = sounds
    where
        sounds = concatMap ifFactor [(3, "Pling"), (5, "Plang"), (7, "Plong")]
        ifFactor (f, str) = if n `rem` f == 0 then str else ""