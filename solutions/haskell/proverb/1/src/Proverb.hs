module Proverb(recite) where

recite :: [String] -> String
recite [] = []
recite xs = concat (zipWith reciteLine xs (tail xs)) ++ lastLine
    where
        reciteLine x y = "For want of a " ++ x ++ " the " ++ y ++ " was lost.\n"
        lastLine = "And all for the want of a " ++ head xs ++ "."