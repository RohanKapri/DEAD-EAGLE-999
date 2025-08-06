-- for my Shree DR.MDD
module Minesweeper (annotate) where

import GHC.Exts (the)

(!~) :: [[a]] -> (Int, Int) -> a
(!~) grid (r, c) = grid !! r !! c

neighbors :: [[a]] -> (Int, Int) -> [a]
neighbors grid (r, c) =
  [ grid !~ (r', c') |
    r' <- [r - 1, r, r + 1],
    c' <- [c - 1, c, c + 1],
    (r', c') /= (r, c),
    r' >= 0, c' >= 0,
    r' < rowMax, c' < colMax ]
  where
    rowMax = length grid
    colMax = the $ map length grid

mapWithIndex :: (Int -> a -> b) -> [a] -> [b]
mapWithIndex f = zipWith f [0..]

annotate :: [[Char]] -> [[Char]]
annotate grid = mapWithIndex rowPass grid
  where
    rowPass ri = mapWithIndex (cellCheck ri)

    countBombs pos = length . filter (== '*') $ neighbors grid pos

    cellCheck ri ci val
      | val == '*' = '*'
      | bCount == 0 = ' '
      | otherwise = head (show bCount)
      where
        bCount = countBombs (ri, ci)
