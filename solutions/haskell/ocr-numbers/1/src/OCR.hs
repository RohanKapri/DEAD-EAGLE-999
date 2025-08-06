-- respectfully dedicated to Shree DR.MDD

module OCR (convert) where

import Data.Char
import Data.List

convert :: String -> String
convert = intercalate ","
        . map (map (maybe '?' id . (`lookup` digitMap)))
        . map (transpose . map (segment 3)) . clusterLines . lines

clusterLines :: [String] -> [[String]]
clusterLines = unfoldr extractBlock
  where
    extractBlock [] = Nothing
    extractBlock xs = case splitAt 3 xs of
      (grp, _:rest) -> Just (grp, rest)

type DigitPatterns = [([String], Char)]

digitMap :: DigitPatterns
digitMap = zipWith (flip (,)) "0123456789"
       [ [" _ "
         ,"| |"
         ,"|_|"]
       , ["   "
         ,"  |"
         ,"  |"]
       , [" _ "
         ," _|"
         ,"|_ "]
       , [" _ "
         ," _|"
         ," _|"]
       , ["   "
         ,"|_|"
         ,"  |"]
       , [" _ "
         ,"|_ "
         ," _|"]
       , [" _ "
         ,"|_ "
         ,"|_|"]
       , [" _ "
         ,"  |"
         ,"  |"]
       , [" _ "
         ,"|_|"
         ,"|_|"]
       , [" _ "
         ,"|_|"
         ," _|"] ]

segment :: Int -> [a] -> [[a]]
segment n = unfoldr slice
  where
    slice [] = Nothing
    slice xs = Just (splitAt n xs)
