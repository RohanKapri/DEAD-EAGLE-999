module KurokosClock exposing (Locale(..), showDateTime, showLocalDate, showLocalTime)

import Time exposing (Month(..), Posix, Zone, toDay, toHour, toMinute, toMonth, toYear)


type Locale
    = US
    | JP


monthToInt : Month -> Int
monthToInt month =
    case month of
        Jan -> 1
        Feb -> 2
        Mar -> 3
        Apr -> 4
        May -> 5
        Jun -> 6
        Jul -> 7
        Aug -> 8
        Sep -> 9
        Oct -> 10
        Nov -> 11
        Dec -> 12


showLocalDate : Locale -> Int -> Month -> Int -> String
showLocalDate locale year month day =
    let
        monthInt = monthToInt month
    in
    case locale of
        US ->
            String.fromInt monthInt ++ "/" ++ String.fromInt day ++ "/" ++ String.fromInt year

        JP ->
            String.fromInt year ++ "年" ++ String.fromInt monthInt ++ "月" ++ String.fromInt day ++ "日"


showLocalTime : Locale -> Int -> Int -> String
showLocalTime locale hour minute =
    case locale of
        US ->
            let
                (displayHour, period) =
                    if hour == 0 then
                        (12, "AM")
                    else if hour < 12 then
                        (hour, "AM")
                    else if hour == 12 then
                        (12, "PM")
                    else
                        (hour - 12, "PM")

                minuteStr =
                    if minute < 10 then
                        "0" ++ String.fromInt minute
                    else
                        String.fromInt minute
            in
            String.fromInt displayHour ++ ":" ++ minuteStr ++ " " ++ period

        JP ->
            String.fromInt hour ++ "時" ++ String.fromInt minute ++ "分"


showDateTime : Locale -> Zone -> Posix -> String
showDateTime loc zone pos =
    let
        yr = toYear zone pos
        mon = toMonth zone pos
        day = toDay zone pos
        hr = toHour zone pos
        min = toMinute zone pos

        dateStr = showLocalDate loc yr mon day
        timeStr = showLocalTime loc hr min

        sep =
            case loc of
                US -> " "
                JP -> ""
    in
    dateStr ++ sep ++ timeStr
