module Raindrops where

import Prelude
import Data.Monoid (mempty)
-- Importing Show class for the show function
import Data.Show (show)

raindrops :: Int -> String
raindrops n = 
  let 
    sound = (if n `mod` 3 == 0 then "Pling" else mempty) <>
            (if n `mod` 5 == 0 then "Plang" else mempty) <>
            (if n `mod` 7 == 0 then "Plong" else mempty)
  in 
    if sound == mempty then show n else sound