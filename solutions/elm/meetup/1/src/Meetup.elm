module Meetup exposing (..)


type Month
    = January
    | February
    | March
    | April
    | May
    | June
    | July
    | August
    | September
    | October
    | November
    | December


type Weekday
    = Sunday
    | Monday
    | Tuesday
    | Wednesday
    | Thursday
    | Friday
    | Saturday


type Week
    = First
    | Second
    | Third
    | Fourth
    | Last
    | Teenth


monthDays : List Int
monthDays =
    [ 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 ]


dow : Weekday -> Int
dow day =
    case day of
        Sunday ->
            0
        Monday ->
            1
        Tuesday ->
            2
        Wednesday ->
            3
        Thursday ->
            4
        Friday ->
            5
        Saturday ->
            6


monthNumber : Month -> Int
monthNumber m =
    case m of
        January ->
            1
        February ->
            2
        March ->
            3
        April ->
            4
        May ->
            5
        June ->
            6
        July ->
            7
        August ->
            8
        September ->
            9
        October ->
            10
        November ->
            11
        December ->
            12


anchorDay : Int -> Int
anchorDay year =
    (dow Tuesday
        + 5 * modBy 4 year
        + 4 * modBy 100 year
        + 6 * modBy 400 year
    )
        |> (\x -> modBy 7 x)


isLeapYear : Int -> Bool
isLeapYear year =
    modBy 4 year == 0 && (modBy 100 year /= 0 || modBy 400 year == 0)


leapDayAdjustment : Int -> Int -> Int
leapDayAdjustment year month =
    if isLeapYear year && month > 2 then
        1
    else
        0


dayOfYear : Int -> Int -> Int -> Int
dayOfYear year month day =
    List.sum (List.take (month - 1) monthDays) + day + leapDayAdjustment year month


daysInMonth : Int -> Int -> Int
daysInMonth year month =
    dayOfYear year (month + 1) 1 - dayOfYear year month 1


meetup : Int -> Month -> Week -> Weekday -> String
meetup year monthName week weekday =
    let
        month =
            monthNumber monthName

        firstDayOfMonth =
            let
                day1 =
                    dayOfYear year month 1

                anchor =
                    anchorDay year

                doomsday =
                    dayOfYear year 3 14
            in
            (anchor + day1 - doomsday) |> modBy 7

        firstMatchingDay =
            1 + modBy 7 (dow weekday - firstDayOfMonth)

        daysInCurrentMonth =
            daysInMonth year month

        weekOffset =
            case week of
                First ->
                    0

                Second ->
                    1

                Third ->
                    2

                Fourth ->
                    3

                Last ->
                    (daysInCurrentMonth - firstMatchingDay) // 7

                Teenth ->
                    (19 - firstMatchingDay) // 7

        day =
            firstMatchingDay + 7 * weekOffset
    in
    [ year, month, day ]
        |> List.map (String.pad 2 '0' << String.fromInt)
        |> String.join "-"