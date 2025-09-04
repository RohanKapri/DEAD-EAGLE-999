module SwiftScheduling exposing (deliveryDate)

import Time exposing (Posix)

getWeekdayNumber: Time.Weekday -> Int
getWeekdayNumber weekday =
    case weekday of
        Time.Mon -> 0
        Time.Tue -> 1
        Time.Wed -> 2
        Time.Thu -> 3
        Time.Fri -> 4
        Time.Sat -> 5
        Time.Sun -> 6


getMonthNumber: Time.Month -> Int
getMonthNumber month =
    case month of
        Time.Jan -> 1
        Time.Feb -> 2
        Time.Mar -> 3
        Time.Apr -> 4
        Time.May -> 5
        Time.Jun -> 6
        Time.Jul -> 7
        Time.Aug -> 8
        Time.Sep -> 9
        Time.Oct -> 10
        Time.Nov -> 11
        Time.Dec -> 12


millisecondsInHours: Int -> Int
millisecondsInHours hours =
    hours * 60 * 60 * 1000


getStartOfDay: Posix -> Posix
getStartOfDay time =
    time
        |> Time.posixToMillis
        |> (\millis -> millis - (millisecondsInHours (Time.toHour Time.utc time)))
        |> (\millis -> millis - (Time.toMinute Time.utc time) * 60 * 1000)
        |> (\millis -> millis - (Time.toSecond Time.utc time) * 1000)
        |> (\millis -> millis - (Time.toMillis Time.utc time))
        |> Time.millisToPosix


getStartOfWeek: Posix -> Posix
getStartOfWeek time =
    let
        startOfDay = getStartOfDay time
        weekdayNumber = getWeekdayNumber (Time.toWeekday Time.utc time)
    in
        startOfDay
            |> Time.posixToMillis
            |> (\millis -> millis - weekdayNumber * 24 * 60 * 60 * 1000)
            |> Time.millisToPosix


addHours: Posix -> Int -> Posix
addHours time hoursToAdd =
    time
        |> Time.posixToMillis
        |> (\millis -> millis + (millisecondsInHours hoursToAdd))
        |> Time.millisToPosix


calculateAsapDelivery: Posix -> Posix
calculateAsapDelivery time =
    let
        startOfDay = getStartOfDay time
    in
        if (Time.toHour Time.utc time) < 13 then
            addHours startOfDay 17
        else
            addHours startOfDay (24 + 13)


calculateEndOfWeekDelivery: Posix -> Posix
calculateEndOfWeekDelivery time =
    let
        startOfWeek = getStartOfWeek time
    in
        if List.member (Time.toWeekday Time.utc time) [Time.Mon, Time.Tue, Time.Wed] then
            addHours startOfWeek (17 + 24 * 4)
        else
            addHours startOfWeek (20 + 24 * 6)


parseDeliveryDescription: String -> (Int, Int, Bool)
parseDeliveryDescription description =
    let
        quarterNumber = String.dropLeft 1 description |> String.toInt |> Maybe.withDefault 0
        monthNumber = String.dropRight 1 description |> String.toInt |> Maybe.withDefault 0
    in
        if String.startsWith "Q" description then
            (quarterNumber * 3 + 1, quarterNumber * 3, False)
        else
            (monthNumber, monthNumber, True)


findNextWorkday: Posix -> Int -> Int -> Int -> Posix
findNextWorkday time targetYear targetMonth dayOffset =
    let
        currentYear = Time.toYear Time.utc time
        currentMonth = getMonthNumber (Time.toMonth Time.utc time)
        currentWeekday = getWeekdayNumber (Time.toWeekday Time.utc time)
    in
        if currentYear == targetYear && currentMonth == targetMonth && currentWeekday < 5 then
            time
        else
            findNextWorkday (addHours time (dayOffset * 24)) targetYear targetMonth dayOffset


calculateVariableDelivery: Posix -> String -> Posix
calculateVariableDelivery time description =
    let
        (targetMonthLimit, targetMonth, isMonthDescription) = parseDeliveryDescription description
        currentMonth = getMonthNumber (Time.toMonth Time.utc time)
        currentYear = Time.toYear Time.utc time
        targetYear = if currentMonth < targetMonthLimit then currentYear else currentYear + 1
        startOfDay = getStartOfDay time
        searchStartPoint = if isMonthDescription then startOfDay else addHours startOfDay (24 * 366 * 2)
    in
        findNextWorkday searchStartPoint targetYear targetMonth (if isMonthDescription then 1 else -1)
            |> (\deliveryTime -> addHours deliveryTime 8)


deliveryDate : Posix -> String -> Posix
deliveryDate meetingStart description =
    case description of
        "NOW" ->
            addHours meetingStart 2
        "ASAP" ->
            calculateAsapDelivery meetingStart
        "EOW" ->
            calculateEndOfWeekDelivery meetingStart
        _ ->
            calculateVariableDelivery meetingStart description
            