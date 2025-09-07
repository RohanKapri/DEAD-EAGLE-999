-- Dedicated to my Shree DR.MDD

module AtbashCipher
  ( encode
  , decode
  ) where

import Prelude

import Partial.Unsafe (unsafePartial)
import Data.Enum (fromEnum, toEnum)
import Data.String (fromCodePointArray)
import Data.String.CodePoints (CodePoint, codePointFromChar, uncons)
import Data.Maybe (Maybe(..), fromJust)
import Data.List (List(..), (:), reverse, toUnfoldable)

lowerA :: CodePoint
lowerA = codePointFromChar 'a'

lowerZ :: CodePoint
lowerZ = codePointFromChar 'z'

upperA :: CodePoint
upperA = codePointFromChar 'A'

upperZ :: CodePoint
upperZ = codePointFromChar 'Z'

zeroDigit :: CodePoint
zeroDigit = codePointFromChar '0'

nineDigit :: CodePoint
nineDigit = codePointFromChar '9'

isLowerLetter :: CodePoint -> Boolean
isLowerLetter cp = cp >= lowerA && cp <= lowerZ

isUpperLetter :: CodePoint -> Boolean
isUpperLetter cp = cp >= upperA && cp <= upperZ

isDigitChar :: CodePoint -> Boolean
isDigitChar cp = cp >= zeroDigit && cp <= nineDigit

convertToLower :: CodePoint -> CodePoint
convertToLower cp =
  if isUpperLetter cp
    then unsafePartial (fromJust (toEnum (fromEnum cp + 32)))
    else cp

reverseAtbash :: CodePoint -> CodePoint
reverseAtbash cp =
  unsafePartial (fromJust (toEnum (fromEnum lowerA + fromEnum lowerZ - fromEnum cp)))

trimTrailingSpace :: List CodePoint -> List CodePoint
trimTrailingSpace Nil = Nil
trimTrailingSpace cps =
  case reverse cps of
    (sp : rest) | sp == codePointFromChar ' ' -> reverse rest
    _ -> cps

encode :: String -> Maybe String
encode input =
  let
    loopEncode :: String -> Int -> List CodePoint -> List CodePoint
    loopEncode str idx acc = case uncons str of
      Nothing -> reverse acc
      Just { head: cp, tail } 
        | isLowerLetter cp ->
            let cp' = reverseAtbash cp
                acc' = if idx > 0 && idx `mod` 5 == 0
                         then cp' : codePointFromChar ' ' : acc
                         else cp' : acc
            in loopEncode tail (idx + 1) acc'
        | isUpperLetter cp ->
            let lc = convertToLower cp
                cp' = reverseAtbash lc
                acc' = if idx > 0 && idx `mod` 5 == 0
                         then cp' : codePointFromChar ' ' : acc
                         else cp' : acc
            in loopEncode tail (idx + 1) acc'
        | isDigitChar cp ->
            let acc' = if idx > 0 && idx `mod` 5 == 0
                         then cp : codePointFromChar ' ' : acc
                         else cp : acc
            in loopEncode tail (idx + 1) acc'
        | otherwise -> loopEncode tail idx acc
    result = trimTrailingSpace (loopEncode input 0 Nil)
  in Just (fromCodePointArray (toUnfoldable result :: Array CodePoint))

decode :: String -> Maybe String
decode input =
  let
    loopDecode :: String -> List CodePoint -> List CodePoint
    loopDecode str acc = case uncons str of
      Nothing -> reverse acc
      Just { head: cp, tail }
        | isLowerLetter cp -> loopDecode tail (reverseAtbash cp : acc)
        | isDigitChar cp -> loopDecode tail (cp : acc)
        | otherwise -> loopDecode tail acc
    result = loopDecode input Nil
  in Just (fromCodePointArray (toUnfoldable result :: Array CodePoint))
