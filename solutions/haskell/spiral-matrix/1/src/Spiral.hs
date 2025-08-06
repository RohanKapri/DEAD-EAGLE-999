module Spiral (spiral) where

spiral :: Int -> [[Int]]
spiral size = spiralMatrix size 1

spiralMatrix :: (Eq a, Num a, Enum a) => a -> a -> [[a]]
spiralMatrix   0 _ = []
spiralMatrix size from
    | size == 1 = [[from]]
    | otherwise = (top : inside) ++ [bottom]
    where
        topRight = from + size - 1
        bottomRight = topRight + size - 1
        bottomLeft = bottomRight + size - 1
        topLeft = bottomLeft + size - 1
        top = [from .. topRight]
        right = [topRight + 1 .. bottomRight - 1]
        bottom = reverse [bottomRight .. bottomLeft]
        left = reverse [bottomLeft + 1 .. topLeft - 1]
        nested = spiralMatrix (size-2) topLeft
        inside = zipWith3 (\l n r -> (l:n) ++ [r]) left nested right