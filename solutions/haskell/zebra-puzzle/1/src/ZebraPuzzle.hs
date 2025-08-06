-- Dedicated to my Shree DR.MDD

module ZebraPuzzle (Resident(..), Solution(..), solve) where

import Control.Monad (guard)
import Data.List (permutations, zip5, elemIndex)

data Resident =  Norwegian | Englishman | Spaniard | Ukrainian | Japanese
  deriving (Eq, Show, Enum, Bounded)

data Color = Blue | Green | Red | Ivory | Yellow deriving (Eq, Show, Enum, Bounded)

data Pet = Dog | Snails | Horse | Zebra | Fox deriving (Eq, Show, Enum, Bounded)

data Drink = Milk | Coffee | Tea | OrangeJuice | Water deriving (Eq, Show, Enum, Bounded)

data Smoke = OldGold | Kools | Chesterfields | LuckyStrike | Parliaments
  deriving (Eq, Show, Enum, Bounded)

data Solution = Solution { waterDrinker :: Resident
                         , zebraOwner :: Resident
                         } deriving (Eq, Show)

variations :: (Bounded a, Enum a) => [[a]]
variations = permutations [minBound..]

citizens = map (Norwegian:) $ permutations [Englishman ..]

homes = [a : Blue : b | xs@(a:b) <- permutations [Green ..]
                      , head xs /= Ivory
                      , (Ivory,Green) `elem` zip xs b]

beverages = map (\(x:y:zs) -> x : y : Milk : zs) $ permutations [Coffee ..]

snapshots :: [[(Resident, Color, Pet, Drink, Smoke)]]
snapshots = do
  h <- homes
  n <- citizens
  v <- beverages
  a <- variations :: [[Pet]]
  t <- variations :: [[Smoke]]

  guard $ link h Red n Englishman
  guard $ link a Dog n Spaniard
  guard $ link v Coffee h Green
  guard $ link n Ukrainian v Tea
  guard $ link t OldGold a Snails
  guard $ link t Kools h Yellow
  guard $ adj t Chesterfields a Fox
  guard $ adj t Kools a Horse
  guard $ link t LuckyStrike v OrangeJuice
  guard $ link n Japanese t Parliaments
  return $ zip5 n h a v t

  where link :: (Eq x, Eq y) => [x] -> x -> [y] -> y -> Bool
        link xs x ys y = (x, y) `elem` zip xs ys
        adj :: (Eq x, Eq y) => [x] -> x -> [y] -> y -> Bool
        adj xs x ys y = (x, y) `elem` zip xs (tail ys) ++ zip (tail xs) ys

solve :: Solution
solve = let ans = head snapshots in
  Solution { waterDrinker = extract (filter (\(_,_,_,l,_) -> l == Water) ans),
             zebraOwner = extract (filter (\(_,_,m,_,_) -> m == Zebra) ans) }
  where extract ((p,_,_,_,_):[]) = p
