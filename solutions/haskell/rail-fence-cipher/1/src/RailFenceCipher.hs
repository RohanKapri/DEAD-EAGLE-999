module RailFenceCipher (encode, decode) where

import Data.List (sortOn)

encode :: Int -> [a] -> [a]
encode rails str = shuffle str indexes
    where
        indexes = cycle $ [1 .. (rails-1)] ++ [rails, (rails-1) .. 2]

decode :: Int -> [a] -> [a]
decode rails str = shuffle str indexes
    where
        indexes = encode rails [1..length str]

shuffle :: [a] -> [Int] -> [a]
shuffle str indexes = map snd $ sortOn fst $ zip indexes str