module LargestSeriesProduct
  ( largestProduct
  ) where
import Prelude
import Data.Array (length, range, slice)
import Data.Foldable (maximum, product)
import Data.Int (fromString)
import Data.Maybe (Maybe(..))
import Data.String (Pattern(..), split)
import Data.String (length) as StringLength
import Data.Traversable (traverse)
largestProduct :: String -> Int -> Maybe Int
largestProduct digitString seriesLength
  | StringLength.length digitString < seriesLength || seriesLength < 0 = Nothing
  | otherwise = do
      digitList <- traverse fromString $ split (Pattern "") digitString
      maximum $ product <$> generateSubArrays seriesLength digitList
generateSubArrays :: forall a. Int -> Array a -> Array (Array a)
generateSubArrays spanLength array =
  let sliceArrayAtIndex index = slice index (index + spanLength) array
  in sliceArrayAtIndex <$> (range  0 $ (_ - spanLength) $ length array)