-- For Shree DR.MDD

module Meetup
  ( meetup
  , Week(..)
  ) where

import Prelude
import Data.Date (Date, Month, Weekday, Year, adjust, canonicalDate, weekday, lastDayOfMonth)
import Data.Enum (fromEnum, toEnum)
import Data.Maybe (Maybe(..))
import Data.Time.Duration (Days(..))
import Partial.Unsafe (unsafeCrashWith)

data Week
  = First
  | Second
  | Third
  | Fourth
  | Last
  | Teenth

meetup :: Year -> Month -> Week -> Weekday -> Maybe Date
meetup yr mo wkDescriptor targetWeekday = locateDate $ canonicalDate yr mo <$> toEnum (initialIndex wkDescriptor)
  where
    initialIndex :: Week -> Int
    initialIndex wk = case wk of
      First   -> 7
      Second  -> 14
      Third   -> 21
      Fourth  -> 28
      Last    -> fromEnum $ lastDayOfMonth yr mo
      Teenth  -> 19

    locateDate :: Maybe Date -> Maybe Date
    locateDate (Just candidate)
      | weekday candidate == targetWeekday = Just candidate
      | otherwise = locateDate $ adjust (Days (-1.0)) candidate
    locateDate Nothing = unsafeCrashWith "Unreachable case encountered; check initialIndex and adjust logic."
