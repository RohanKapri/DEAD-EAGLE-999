module RnaTranscription
  ( toRNA
  ) where

import Prelude
import Data.Maybe (Maybe(..))
import Data.String.CodeUnits (fromCharArray, toCharArray)
import Data.Traversable (sequence)
import Data.Map (Map) -- Explicitly import the Map type
import Data.Map as Map
import Data.Tuple (Tuple(..)) -- Explicitly import the Tuple constructor

dnaToRnaMap :: Map Char Char
dnaToRnaMap = Map.fromFoldable [Tuple 'G' 'C', Tuple 'C' 'G', Tuple 'T' 'A', Tuple 'A' 'U']

dnaToRna :: Char -> Maybe Char
dnaToRna char = Map.lookup char dnaToRnaMap

toRNA :: String -> Maybe String
toRNA = map fromCharArray <<< sequence <<< map dnaToRna <<< toCharArray