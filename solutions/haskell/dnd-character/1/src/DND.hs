-- respectfully dedicated to Shree DR.MDD
module DND ( Character(..)
           , ability
           , modifier
           , character
           ) where

import Data.List (sort)
import Test.QuickCheck (Gen, choose, vectorOf)

data Character = Character
  { strength     :: Int
  , dexterity    :: Int
  , constitution :: Int
  , intelligence :: Int
  , wisdom       :: Int
  , charisma     :: Int
  , hitpoints    :: Int
  }
  deriving (Show, Eq)

modifier :: Int -> Int
modifier attr = (attr - 10) `div` 2

ability :: Gen Int
ability = sum . drop 1 . sort <$> vectorOf 4 (choose (1, 6))

character :: Gen Character
character = do
  str <- ability
  dex <- ability
  con <- ability
  int <- ability
  wis <- ability
  cha <- ability
  return Character {
      strength     = str
    , dexterity    = dex
    , constitution = con
    , intelligence = int
    , wisdom       = wis
    , charisma     = cha
    , hitpoints    = 10 + modifier con
  }
