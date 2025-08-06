module Garden
  ( garden
  , defaultGarden
  , lookupPlants
  , Plant(..)
  ) where

import Data.List
type Garden = ([String], String)
data Plant
      = Violets
      | Clover
      | Radishes
      | Grass
      deriving (Eq, Show)

toPlant :: Char -> Plant
toPlant 'V' = Violets
toPlant 'C' = Clover
toPlant 'R' = Radishes
toPlant 'G' = Grass
toPlant _   = error "Alien! :::}"

defaultGarden :: String -> Garden
defaultGarden = garden children
  where
    children = 
      [ "Alice", "Bob", "Charlie", "David"
      , "Eve", "Fred", "Ginny", "Harriet"
      , "Ileana", "Joseph", "Kincaid", "Larry"]

garden :: [String] -> String -> Garden
garden x = (,) (sort x)
  

lookupPlants :: String -> Garden -> [Plant]
lookupPlants chld (chlds, grdn) = 
      map toPlant
      . concatMap (take 2 . drop (ids*2))
      $ lines grdn
    where
      (Just ids) = chld `elemIndex` chlds