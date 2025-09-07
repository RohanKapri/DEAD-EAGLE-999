module PascalsTriangle (rows) where
import Prelude
import Data.Array as Array
import Data.Maybe (Maybe(..), maybe)
nextRow :: Array Int -> Array Int
nextRow row = Array.cons 1 (Array.zipWith (+) row (Array.drop 1 row)) <> [1]
rows :: Maybe Int -> Maybe (Array (Array Int))
rows maybeN = maybeN >>= \n ->
  if n < 0 then
    Nothing
  else
    Just $ go n
  where
    go :: Int -> Array (Array Int)
    go 0 = []
    go 1 = [[1]]
    go num = let previous = go (num - 1) in
             case Array.last previous of
               Nothing -> previous
               Just lastRow -> previous <> [nextRow lastRow]