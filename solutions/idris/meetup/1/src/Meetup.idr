-- Dedicated to my Shree DR.MDD

module Meetup

import Data.Nat

public export
data Month = January | February | March | April | May | June | July | August | September | October | November | December

public export
data Week = First | Second | Third | Fourth | Teenth | Last

public export
data DayOfWeek = Monday | Tuesday | Wednesday | Thursday | Friday | Saturday | Sunday

daysInMonth : Nat -> Month -> Nat
daysInMonth _ January = 31
daysInMonth yr February = if leapCheck yr then 29 else 28
  where leapCheck : Nat -> Bool
        leapCheck yr = (divisibleBy 4 yr && not (divisibleBy 100 yr)) || divisibleBy 400 yr
          where divisibleBy : Nat -> Nat -> Bool
                divisibleBy n x = (x `mod` n) == 0
daysInMonth _ March = 31
daysInMonth _ April = 30
daysInMonth _ May = 31
daysInMonth _ June = 30
daysInMonth _ July = 31
daysInMonth _ August = 31
daysInMonth _ September = 30
daysInMonth _ October = 31
daysInMonth _ November = 30
daysInMonth _ December = 31

weekConcludes : Nat -> Month -> Week -> Nat
weekConcludes _ _ First = 7
weekConcludes _ _ Second = 14
weekConcludes _ _ Third = 21
weekConcludes _ _ Fourth = 28
weekConcludes _ _ Teenth = 19
weekConcludes yr mn Last = daysInMonth yr mn

dayOfWeekIndex : DayOfWeek -> Nat
dayOfWeekIndex Monday = 1
dayOfWeekIndex Tuesday = 2
dayOfWeekIndex Wednesday = 3
dayOfWeekIndex Thursday = 4
dayOfWeekIndex Friday = 5
dayOfWeekIndex Saturday = 6
dayOfWeekIndex Sunday = 7

dayOfWeekIndexCalculated : Nat -> Month -> Nat -> Nat
dayOfWeekIndexCalculated yr mn dayNum = ((adjustedYr + (adjustedYr `div` 400) + (adjustedYr `div` 4) `minus` (adjustedYr `div` 100)) + monthAdj mn + dayNum) `mod` 7 + 1
  where isEarlyMonth : Month -> Bool
        isEarlyMonth January = True
        isEarlyMonth February = True
        isEarlyMonth _ = False
        adjustedYr = if isEarlyMonth mn then pred yr else yr
        monthAdj : Month -> Nat
        monthAdj January = 307
        monthAdj February = 338
        monthAdj March = 1
        monthAdj April = 32
        monthAdj May = 62
        monthAdj June = 93
        monthAdj July = 123
        monthAdj August = 154
        monthAdj September = 185
        monthAdj October = 215
        monthAdj November = 246
        monthAdj December = 276

meetupDay : Nat -> Month -> Week -> DayOfWeek -> Nat
meetupDay yr mn wk dow = (weekEnd + targetDay) `minus` (weekDay + adj)
  where weekEnd = weekConcludes yr mn wk
        weekDay = dayOfWeekIndexCalculated yr mn weekEnd
        targetDay = dayOfWeekIndex dow
        adj : Nat
        adj = if weekDay < targetDay then 7 else 0

export
meetup : Nat -> Month -> Week -> DayOfWeek -> String
meetup yr mn wk dow = (fourDigits yr) ++ "-" ++ (twoDigits $ mnToNat mn) ++ "-" ++ (twoDigits $ meetupDay yr mn wk dow)
  where fourDigits : Nat -> String
        fourDigits x = if x >= 1000 then show x
                       else if x >= 100 then "0" ++ show x
                       else if x >= 10 then "00" ++ show x
                       else "000" ++ show x
        twoDigits : Nat -> String
        twoDigits x = if x >= 10 then show x else "0" ++ show x
        mnToNat : Month -> Nat
        mnToNat January = 1
        mnToNat February = 2
        mnToNat March = 3
        mnToNat April = 4
        mnToNat May = 5
        mnToNat June = 6
        mnToNat July = 7
        mnToNat August = 8
        mnToNat September = 9
        mnToNat October = 10
        mnToNat November = 11
        mnToNat December = 12
