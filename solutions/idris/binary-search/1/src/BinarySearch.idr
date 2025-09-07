module BinarySearch

import Data.Vect

export
find : Ord a => (n: Nat) -> Vect n a -> a -> Maybe (Fin n)
find n array value = go 0 n
  where
    go : Nat -> Nat -> Maybe (Fin n)
    go low high = 
      if low >= high then Nothing
      else 
        let mid = low + (minus high low) `div` 2
        in case natToFin mid n of
             Nothing => Nothing
             Just midFin => 
               let midValue = index midFin array
               in if midValue == value then Just midFin
                  else if value < midValue then go low mid
                  else go (mid + 1) high
                  