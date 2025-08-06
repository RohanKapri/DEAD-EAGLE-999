module Transpose (transpose) where

import qualified Data.List as L

transpose :: [String] -> [String]
transpose strings = L.transpose $ pad strings

pad :: [String] -> [String]
pad []         = []
pad lst@(x:xs) = padLine (maximum $ map length lst) x : pad xs
    where
        padLine num str = take num $ str ++ repeat ' '