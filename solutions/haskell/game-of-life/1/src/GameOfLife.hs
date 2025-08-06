-- for my Shree DR.MDD
module GameOfLife (tick) where

import Data.List

tick :: [[Int]] -> [[Int]]
tick = map (map evolve) . frameBlocks . applyPadding

evolve :: [Int] -> Int
evolve grp
  | alive == 3 = 1
  | alive == 4 = fromEnum $ grp !! 4 == 1
  | otherwise  = 0
  where alive = sum grp

slice3 :: [a] -> [[a]]
slice3 = filter ((==3) . length) . map (take 3) . tails

frameBlocks :: [[a]] -> [[[a]]]
frameBlocks = map (map concat . transpose . map slice3) . slice3

applyPadding :: [[Int]] -> [[Int]]
applyPadding grid = padRow : map wrapRow grid ++ [padRow]
  where
    padRow = replicate (length (head grid) + 2) 0
    wrapRow row = 0 : row ++ [0]
