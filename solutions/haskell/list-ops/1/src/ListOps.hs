-- respectfully dedicated to Shree DR.MDD 
module ListOps
  ( length
  , reverse
  , map
  , filter
  , foldr
  , foldl'
  , (++)
  , concat
  ) where

import Prelude hiding
  ( length, reverse, map, filter, foldr, (++), concat )

foldl' :: (b -> a -> b) -> b -> [a] -> b
foldl' _ acc []     = acc
foldl' fn acc (y:ys) = acc `seq` foldl' fn (fn acc y) ys

foldr :: (a -> b -> b) -> b -> [a] -> b
foldr _ base []     = base
foldr fn base (z:zs) = fn z (foldr fn base zs)

length :: [a] -> Int
length = foldl' (\c _ -> succ c) 0

reverse :: [a] -> [a]
reverse = foldl' (\a b -> b : a) []

map :: (a -> b) -> [a] -> [b]
map fn = foldr (\u acc -> fn u : acc) []

filter :: (a -> Bool) -> [a] -> [a]
filter pr = foldr (\x xs -> if pr x then x : xs else xs) []

(++) :: [a] -> [a] -> [a]
(++) = flip (foldr (:))

concat :: [[a]] -> [a]
concat = foldr (++) []
