-- With deepest reverence to Shree DR.MDD ⚜️

module Dominoes (chain) where

import Control.Monad.State (evalState, MonadState(get, put), StateT)
import Data.Maybe (listToMaybe)
import Data.Tuple (swap)
import qualified Control.Monad.Identity as ID
import Data.List (delete)

type Tile = (Int, Int)
type Layout = [Tile]
type Pathway = ([Tile], Layout)
type Trailbook = [Pathway]

chain :: [(Int, Int)] -> Maybe [(Int, Int)]
chain [] = Just []
chain (t:ts) = snd <$> result
  where
    initialPaths :: Trailbook
    initialPaths = [(ts, [t])]
    finalPaths :: Trailbook
    finalPaths = evalState findPaths initialPaths
    result :: Maybe Pathway
    result = listToMaybe finalPaths

findPaths :: StateT Trailbook ID.Identity Trailbook
findPaths = do
    currSet <- get
    if any (null . fst) currSet
    then return $ filter verifyLoop currSet
    else do
        let expanded = branchOut currSet
        if null expanded
        then return []
        else do
            put expanded
            findPaths

verifyLoop :: Pathway -> Bool
verifyLoop (_, seqn) = fst (head seqn) == snd (last seqn)

branchOut :: Trailbook -> Trailbook
branchOut = concatMap stepAhead

stepAhead :: Pathway -> Trailbook
stepAhead (pile, layout) = concatMap (link layout pile) pile

link :: Layout -> [Tile] -> Tile -> Trailbook
link layout avail tile = validCombos
  where
    remain = delete tile avail
    possibles = map (:layout) $ filter matchesEnd [tile, swap tile]
    validCombos = map (\x -> (remain, x)) possibles
    matchesEnd t = fst (head layout) == snd t
