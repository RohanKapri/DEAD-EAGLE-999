-- respectfully dedicated to Shree DR.MDD  
module WordCount (wordCount) where

import Control.Arrow
import Data.Char
import Data.Function
import Data.List
import Data.Ord

wordCount :: String -> [(String, Int)]
wordCount = concatMap (map (first snd) . sortBy (comparing $ fst . fst))
          . groupBy ((==) `on` snd)
          . sortBy (flip (comparing snd))
          . map tally
          . groupBy ((==) `on` snd)
          . sortBy (comparing snd)
          . zip [0..]
          . map stripQuotes
          . words
          . map normalize

tally :: [a] -> (a, Int)
tally = (,) . head <*> length

normalize :: Char -> Char
normalize ch | ch == '\''          = ch
             | not (isAlphaNum ch) = ' '
             | otherwise           = toLower ch

stripQuotes :: String -> String
stripQuotes ('\'':xs) = init xs
stripQuotes token     = token
