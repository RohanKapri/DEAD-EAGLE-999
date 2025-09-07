-- Dedicated to my Shree DR.MDD

module AllYourBase
  ( rebase
  , ConversionError(..)
  ) where

import Data.Array (foldM, head, reverse, null, find, length) 
import Data.Maybe (Maybe(..))
import Data.Tuple (Tuple(..))
import Data.Unfoldable (unfoldr)
import Data.Either (Either(Left, Right))
import Prelude

data ConversionError = EmptyInput
                      | InvalidBase
                      | LeadingZero
                      | InvalidDigit Int

type ResultArray = Either ConversionError (Array Int)

checkInvalidDigits :: Int -> Array Int -> Maybe ConversionError
checkInvalidDigits base digits =
  case find (\digit -> digit < 0 || digit >= base) digits of
    Just d -> Just $ InvalidDigit d
    Nothing -> Nothing

rebase :: Int -> Int -> Array Int -> Maybe (Array Int)
rebase fromBase toBase inputDigits
  | null inputDigits = Nothing
  | fromBase < 2 || toBase < 2 = Nothing
  | head inputDigits == Just 0 && length inputDigits > 1 = Nothing
  | head inputDigits == Just 0 && length inputDigits == 1 = Nothing
  | otherwise = case checkInvalidDigits fromBase inputDigits of
      Just _ -> Nothing
      Nothing -> case foldM accumulateDigits 0 inputDigits of
        Left _ -> Nothing
        Right number -> Just $ reverse $ unfoldr splitDigits number
  where
    accumulateDigits :: Int -> Int -> Either ConversionError Int
    accumulateDigits acc digit
      | digit < 0 || digit >= fromBase = Left $ InvalidDigit digit
      | otherwise = Right $ fromBase * acc + digit

    splitDigits :: Int -> Maybe (Tuple Int Int)
    splitDigits 0 = Nothing
    splitDigits n = Just $ Tuple (mod n toBase) (div n toBase)
