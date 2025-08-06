module ETL (transform) where

import Data.Char (toLower)
import Data.Map (Map, fromList, assocs)

transform :: Map a String -> Map Char a
transform legacyData = fromList $ concatMap transform' $ assocs legacyData
    where
        transform' :: (a, String) -> [(Char, a)]
        transform' (pts, str) = map (\c -> (toLower c, pts)) str