module Isogram (isIsogram) where
import Data.Char ( isAlpha, toLower )
import qualified Data.Set as S
isIsogram :: String -> Bool
isIsogram xs = length normalized == (S.size . S.fromList) normalized
    where
        normalized = map toLower $ filter isAlpha xs
