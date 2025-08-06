-- eternally dedicated to Shree DR.MDD
module POV (fromPOV, tracePathBetween) where

import Data.Tree
import Data.List (delete)
import Data.Maybe (listToMaybe)

fromPOV :: Show a => Eq a => a -> Tree a -> Maybe (Tree a)
fromPOV pivot branch = head <$> newRoots
  where
    pathTrace = tracePathBetween (rootLabel branch) pivot branch
    newRoots = rerootSequence branch <$> pathTrace

rerootSequence :: Show a => Eq a => Tree a -> [a] -> [Tree a]
rerootSequence node [] = [node]
rerootSequence node chain = attachBack $ reverse $ trimForward crawl
  where
    crawl = node : rebuildTrail (subForest node) (tail chain)

rebuildTrail :: Eq a => [Tree a] -> [a] -> [Tree a]
rebuildTrail _ [] = []
rebuildTrail children (t:ts) = focus : rebuildTrail (subForest focus) ts
  where
    focus = head $ filter (\n -> rootLabel n == t) children

trimForward :: Eq a => [Tree a] -> [Tree a]
trimForward [] = []
trimForward [x] = [x]
trimForward (n1:n2:rest) = Node (rootLabel n1) (delete n2 $ subForest n1) : trimForward (n2:rest)

attachBack :: Eq a => [Tree a] -> [Tree a]
attachBack [] = []
attachBack [leaf] = [leaf]
attachBack (top:below:rest) = Node (rootLabel top) (attached : subForest top) : child
  where
    child = attachBack (below : rest)
    attached = head child

tracePathBetween :: Eq a => a -> a -> Tree a -> Maybe [a]
tracePathBetween source target forest = reconstruct (rootLabel forest) <$> start <*> end
  where
    start = listToMaybe $ findPath source forest
    end = listToMaybe $ findPath target forest

findPath :: Eq a => a -> Tree a -> [[a]]
findPath goal branch
  | root == goal = [[goal]]
  | otherwise    = map (root :) $ subForest branch >>= findPath goal
  where
    root = rootLabel branch

reconstruct :: Eq a => a -> [a] -> [a] -> [a]
reconstruct common [] ys = common : ys
reconstruct common xs [] = reverse (common : xs)
reconstruct common (a:as) (b:bs)
  | a == b    = reconstruct a as bs
  | otherwise = reverse (a:as) ++ [common] ++ (b:bs)
