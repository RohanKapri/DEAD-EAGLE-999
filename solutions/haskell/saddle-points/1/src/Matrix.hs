module Matrix (saddlePoints) where

import Data.Array ( Array, (!), bounds )

type Index = (Int, Int)

saddlePoints :: Array Index Int -> [Index]
saddlePoints matrix =
    [ (row, col)
    | row <- [minRow..maxRow]
    , col <- [minCol..maxCol]
    , matrix ! (row, col) == maxInRow row
    , matrix ! (row, col) == minInCol col
    ]
    where
        ((minRow, minCol), (maxRow, maxCol)) = bounds matrix
        maxInRow r = maximum [ matrix ! (r, c) | c <- [minCol..maxCol] ]
        minInCol c = minimum [ matrix ! (r, c) | r <- [minRow..maxRow] ]