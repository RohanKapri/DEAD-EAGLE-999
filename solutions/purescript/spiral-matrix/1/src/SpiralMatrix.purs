module Spiral (spiral) where

import Prelude
import Data.List (List(Nil), (..))

-- Function to calculate the value at a given position in the spiral matrix
go :: Int -> Int -> Int -> Int
go x 1 _ = x
go x y w = w `div` 2 + go (y - 1) (w `div` 2 - x + 1) (w - 1)

-- Main function to generate the spiral matrix
spiral :: Int -> List (List Int)
spiral 0 = Nil
spiral s = do
  x <- 1..s
  pure $ do
    y <- 1..s
    pure $ go y x (s * 2)