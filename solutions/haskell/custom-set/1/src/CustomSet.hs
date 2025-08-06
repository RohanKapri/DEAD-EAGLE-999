module CustomSet
  ( delete
  , difference
  , empty
  , fromList
  , insert
  , intersection
  , isDisjointFrom
  , isSubsetOf
  , member
  , null
  , size
  , toList
  , union
  ) where

import Prelude hiding (null)
import Data.List (group, sort)

data CustomSet a = MkCustomSet [a] deriving (Eq, Show)

delete :: Eq a => a -> CustomSet a -> CustomSet a
delete x (MkCustomSet l) = MkCustomSet (filter (/= x) l)

difference :: Eq a => CustomSet a -> CustomSet a -> CustomSet a
difference (MkCustomSet l) s = MkCustomSet ll
  where
    ll = filter (not . mem) l
    mem = (`member` s)

empty :: CustomSet a
empty = MkCustomSet []

fromList :: Ord a => [a] -> CustomSet a
fromList l = MkCustomSet (unique l)

insert :: (Ord a) => a -> CustomSet a -> CustomSet a
insert x (MkCustomSet l) = fromList (x : l)

intersection :: Eq a => CustomSet a -> CustomSet a -> CustomSet a
intersection (MkCustomSet l1) s2 = MkCustomSet l
  where
    l = filter (`member` s2) l1

isDisjointFrom :: Eq a => CustomSet a -> CustomSet a -> Bool
isDisjointFrom (MkCustomSet l) s = all (not . (`member` s)) l

isSubsetOf :: Eq a => CustomSet a -> CustomSet a -> Bool
isSubsetOf (MkCustomSet l) s = all (`member` s) l

member :: Eq a => a -> CustomSet a -> Bool
member x (MkCustomSet l) = x `elem` l

null :: CustomSet a -> Bool
null (MkCustomSet l) = case l of
   [] -> True
   (_:_) -> False

size :: CustomSet a -> Int
size (MkCustomSet l) = length l

toList :: CustomSet a -> [a]
toList (MkCustomSet l) = l

union :: Ord a => CustomSet a -> CustomSet a -> CustomSet a
union (MkCustomSet l1) (MkCustomSet l2) = fromList (l1 ++ l2)

unique :: Ord a => [a] -> [a]
unique l = fmap head gl
  where
    gl = group ll
    ll = sort l