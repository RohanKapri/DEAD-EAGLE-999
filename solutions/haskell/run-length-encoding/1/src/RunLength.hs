module RunLength (decode, encode) where

import Data.Char (isNumber)
import Data.List (group, unfoldr)

decode :: String -> String
decode [] = []
decode encodedText = concat $ unfoldr decodeRun encodedText

decodeRun :: [Char] -> Maybe ([Char], [Char])
decodeRun run
    | (x:xs) <- rest = Just (replicate lenRun x, xs)
    | otherwise      = Nothing
    where 
        (num, rest) = span isNumber run
        lenRun = if null num then 1 else read num

encode :: String -> String
encode text = concatMap encodeRun (group text)
    where
        encodeRun run = lenRun run ++ [head run]
        lenRun run = let len = length run in if len == 1 then "" else show len
