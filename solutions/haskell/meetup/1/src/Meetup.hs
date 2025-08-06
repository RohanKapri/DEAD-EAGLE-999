module Meetup (Weekday(..), Schedule(..), meetupDay) where

import qualified Data.Time.Calendar as C

data Weekday = Monday
             | Tuesday
             | Wednesday
             | Thursday
             | Friday
             | Saturday
             | Sunday
               deriving (Enum)

data Schedule = First
              | Second
              | Third
              | Fourth
              | Last
              | Teenth

meetupDay :: Schedule -> Weekday -> Integer -> Int -> C.Day
meetupDay schedule weekday year month = C.fromGregorian year month (interval!!idx)
    where
        interval = scheduleToInterval schedule $ C.gregorianMonthLength year month
        dow = C.dayOfWeek $ C.fromGregorian year month (head interval)
        idx = (fromEnum weekday - fromEnum dow + 1) `mod` 7

scheduleToInterval :: Schedule -> Int -> [Int]
scheduleToInterval First     _ = [1..7]
scheduleToInterval Second    _ = [8..14]
scheduleToInterval Third     _ = [15..21]
scheduleToInterval Fourth    _ = [22..28]
scheduleToInterval Teenth    _ = [13..19]
scheduleToInterval Last   days = [days-6 .. days]