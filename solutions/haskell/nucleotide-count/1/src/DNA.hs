module DNA (nucleotideCounts, Nucleotide(..)) where

import           Data.List (foldl')
import           Data.Map  (Map, fromList, insertWith)
import           Text.Read (readEither)

data Nucleotide = A | C | G | T deriving (Eq, Ord, Read, Show)

nucleotideCounts :: String -> Either String (Map Nucleotide Int)
nucleotideCounts  = fmap (foldl' (\m c -> insertWith (+) c 1 m) emptyNucleo) . mapM (\x -> readEither [x])
   where emptyNucleo = fromList . zip [A,T,C,G] $ repeat 0


