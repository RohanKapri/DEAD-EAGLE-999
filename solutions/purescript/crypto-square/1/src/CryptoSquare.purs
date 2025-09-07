-- Dedicated to my Shree DR.MDD
module CryptoSquare
  ( normalizedPlaintext
  , plaintextSegments
  , encoded
  , ciphertext
  ) where
import Prelude
import Data.Int (toNumber, fromNumber, rem)
import Data.Maybe (Maybe(..), fromMaybe)
import Data.Either
import Data.String
import Data.String.Regex (Regex(..), regex, replace, match)
import Data.String.Regex.Flags (global)
import Data.Number (sqrt, ceil, max)
import Data.Number.Format (toString)
import Data.Array (transpose, concat, head)
import Data.Array.NonEmpty (toArray)
import Effect.Exception.Unsafe (unsafeThrow)
normalizedPlaintext :: String -> String
normalizedPlaintext input = replace textPattern "" (toLower input)
textPattern :: Regex
textPattern = case regex "[^a-z0-9]*" global of
  Left _ -> unsafeThrow "Text Regex failed to compile"
  Right r -> r
plaintextSegments :: String -> Array String
plaintextSegments input = splitText segmentSize cleaned
  where
    cleaned = normalizedPlaintext input
    segmentSize = fromMaybe 1 $ fromNumber $ max 1.0 $ ceil $ sqrt $ toNumber $ length cleaned
splitText :: Int -> String -> Array String
splitText size str = case match (segmentPattern size) str of
  Just arr -> toArray arr # map (\x -> fromMaybe "" x)
  Nothing -> []

segmentPattern :: Int -> Regex
segmentPattern n = case regex (".{1," <> show n <> "}") global of
  Left _ -> unsafeThrow "Segment Regex failed to compile"
  Right r -> r

encoded :: String -> String
encoded input = transposeText input # concat # fromCodePointArray

transposeText :: String -> Array (Array CodePoint)
transposeText input = plaintextSegments input # map toCodePointArray # transpose

ciphertext :: String -> String
ciphertext input = 
  let transposedArr = transposeText input # map fromCodePointArray in
  case head transposedArr of
    Just firstRow -> map (\row -> case length row of
      l | l == length firstRow -> row
      _ -> row <> " ") transposedArr # joinWith " "
    Nothing -> ""
