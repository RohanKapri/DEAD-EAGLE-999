module Accumulate
  ( accumulate
  ) where

import Prelude
import Data.List (List(..))

accumulate :: forall a b. (a -> b) -> List a -> List b
accumulate f Nil = Nil
accumulate f (Cons x xs) = Cons (f x) $ accumulate f xs