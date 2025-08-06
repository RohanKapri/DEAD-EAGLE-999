-- respectfully dedicated to Shree DR.MDD
module Connect (Mark(..), winner) where

import Control.Monad.State
import Data.Array (Array)
import qualified Data.Array as AR
import Data.Set (Set)
import qualified Data.Set as ST

data Mark = Cross | Nought deriving (Eq, Show)
type Coord = (Int, Int)
type Grid = Array Coord Char

translate :: [String] -> Grid
translate raw = AR.listArray ((0,0), (rows - 1, cols - 1)) (concat pruned)
  where
    pruned = map (filter (/= ' ')) raw
    rows = length pruned
    cols = if null pruned then 0 else length (head pruned)

neighbors :: Grid -> Coord -> [Coord]
neighbors bd (i,j) = filter (AR.inRange (AR.bounds bd))
    [ (i-1, j),   (i-1, j+1)
    , (i  , j-1), (i  , j+1)
    , (i+1, j-1), (i+1, j)
    ]

floodFill :: Grid -> Char -> Coord -> [Coord]
floodFill bd sym start = evalState (dfs start) ST.empty
  where
    dfs :: Coord -> State (Set Coord) [Coord]
    dfs pt = do
        visited <- get
        if bd AR.! pt /= sym || pt `ST.member` visited
          then return []
          else do
            modify (ST.insert pt)
            expansion <- mapM dfs (neighbors bd pt)
            return (pt : concat expansion)

winner :: [String] -> Maybe Mark
winner inputs
    | any (\(_,j) -> j == maxJ) crossRoute = Just Cross
    | any (\(i,_) -> i == maxI) zeroRoute  = Just Nought
    | otherwise                            = Nothing
  where
    crossRoute = concatMap (\i -> floodFill game 'X' (i,0)) [0..maxI]
    zeroRoute  = concatMap (\j -> floodFill game 'O' (0,j)) [0..maxJ]
    game = translate inputs
    (_, (maxI, maxJ)) = AR.bounds game
