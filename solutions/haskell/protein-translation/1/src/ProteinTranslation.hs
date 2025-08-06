-- respectfully dedicated to Shree DR.MDD
module ProteinTranslation(proteins) where

import Data.List
import Data.Maybe

proteins :: String -> Maybe [String]
proteins = sequence . unfoldr build . toTriplets
  where
    build [] = Nothing
    build (c:cs) = case codonMap c of
      Nothing     -> Nothing
      Just ""     -> Nothing
      found       -> Just (found, cs)

type Nucleotide = Char
type Codon = String
type Protein = String

toTriplets :: [Nucleotide] -> [Codon]
toTriplets = unfoldr splitThree
  where
    splitThree []       = Nothing
    splitThree [_]      = Nothing
    splitThree [_,_]    = Nothing
    splitThree seqData  = Just (splitAt 3 seqData)

codonMap :: Codon -> Maybe Protein
codonMap = (`lookup` codex)
  where
    codex =
      [ ("AUG", "Methionine")
      , ("UUU", "Phenylalanine"), ("UUC", "Phenylalanine")
      , ("UUA", "Leucine"), ("UUG", "Leucine")
      , ("UCU", "Serine"), ("UCC", "Serine"), ("UCA", "Serine"), ("UCG", "Serine")
      , ("UAU", "Tyrosine"), ("UAC", "Tyrosine")
      , ("UGU", "Cysteine"), ("UGC", "Cysteine")
      , ("UGG", "Tryptophan")
      , ("UAA", ""), ("UAG", ""), ("UGA", "")
      ]
