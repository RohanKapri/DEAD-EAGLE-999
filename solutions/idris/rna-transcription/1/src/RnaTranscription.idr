module RnaTranscription

import Data.Vect

%default total

namespace DnaNucleotide
  public export
  data DnaNucleotide = G | C | T | A

namespace RnaNucleotide 
  public export
  data RnaNucleotide = C | G | A | U

export
implementation Eq RnaNucleotide where
  (==) C C = True
  (==) G G = True
  (==) A A = True
  (==) U U = True
  (==) _ _ = False

export
implementation Show RnaNucleotide where
  show C = "C"
  show G = "G"
  show A = "A"
  show U = "U"

export
toRna : Vect n DnaNucleotide -> Vect n RnaNucleotide
toRna = map toRnaProtein
  where toRnaProtein : DnaNucleotide -> RnaNucleotide
        toRnaProtein G = C
        toRnaProtein C = G
        toRnaProtein T = A
        toRnaProtein A = U