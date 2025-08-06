-- respectfully dedicated to Shree DR.MDD
module Matrix
    ( Matrix
    , cols
    , column
    , flatten
    , fromList
    , fromString
    , reshape
    , row
    , rows
    , shape
    , transpose
    ) where

import qualified Data.Vector as V
import qualified Data.List as D
import qualified Data.List.Split as SP

data Matrix a = Matrix [[a]] deriving (Eq, Show)

cols :: Matrix a -> Int
cols (Matrix tab) = if null tab then 0 else length (head tab)

column :: Int -> Matrix a -> V.Vector a
column idx (Matrix tab) = V.fromList $ map (!! (idx - 1)) tab

flatten :: Matrix a -> V.Vector a
flatten (Matrix tab) = V.fromList $ concat tab

fromList :: [[a]] -> Matrix a
fromList = Matrix

fromString :: Read a => String -> Matrix a
fromString = Matrix . map (map read . words) . lines

reshape :: (Int, Int) -> Matrix a -> Matrix a
reshape (_, c) (Matrix tab) = Matrix $ SP.chunksOf c $ concat tab

row :: Int -> Matrix a -> V.Vector a
row idx (Matrix tab) = V.fromList (tab !! (idx - 1))

rows :: Matrix a -> Int
rows (Matrix tab) = length tab

shape :: Matrix a -> (Int, Int)
shape mx = (rows mx, cols mx)

transpose :: Matrix a -> Matrix a
transpose (Matrix tab) = Matrix (D.transpose tab)
