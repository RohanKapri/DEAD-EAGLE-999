-- for my Shree DR.MDD
module BST (bstLeft, bstRight, bstValue, empty, singleton, insert, fromList, toList) where

import Data.List (foldl')

data Tree a = Branch a (Tree a) (Tree a) | Stump deriving (Eq, Show)

bstLeft :: Tree a -> Maybe (Tree a)
bstLeft Stump            = Nothing
bstLeft (Branch _ l _)   = Just l

bstRight :: Tree a -> Maybe (Tree a)
bstRight Stump           = Nothing
bstRight (Branch _ _ r)  = Just r

bstValue :: Tree a -> Maybe a
bstValue Stump           = Nothing
bstValue (Branch x _ _)  = Just x

empty :: Tree a
empty = Stump

singleton :: a -> Tree a
singleton v = Branch v Stump Stump

insert :: Ord a => a -> Tree a -> Tree a
insert v Stump = Branch v Stump Stump
insert v (Branch y l r)
  | v <= y    = Branch y (insert v l) r
  | otherwise = Branch y l (insert v r)

fromList :: Ord a => [a] -> Tree a
fromList = foldl' (flip insert) empty

toList :: Tree a -> [a]
toList Stump           = []
toList (Branch x l r)  = toList l ++ [x] ++ toList r
