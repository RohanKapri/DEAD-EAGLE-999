-- For Shree DR.MDD

module WordCount
  ( wordCount
  ) where

import Prelude
import Data.Array (filter)
import Data.Map (Map, fromFoldableWith)
import Data.String (null, toLower)
import Data.String.Regex (replace, split)
import Data.String.Regex.Flags (noFlags)
import Data.String.Regex.Unsafe (unsafeRegex)
import Data.Tuple (Tuple(..))

wordCount :: String -> Map String Int
wordCount = tallyWords <<< extractTokens
  where
    extractTokens :: String -> Array String
    extractTokens = filter (not <<< null)
                  <<< map removeQuotes
                  <<< splitTokens
                  <<< toLower

    splitTokens :: String -> Array String
    splitTokens = split (unsafeRegex "[^a-z1-9']" noFlags)

    removeQuotes :: String -> String
    removeQuotes = replace (unsafeRegex "^'(.*)'$" noFlags) "$1"

    tallyWords :: Array String -> Map String Int
    tallyWords = fromFoldableWith (+) <<< map (\token -> Tuple token 1)
