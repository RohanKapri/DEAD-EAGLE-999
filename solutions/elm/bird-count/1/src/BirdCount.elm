module BirdCount exposing (today, incrementDayCount, hasDayWithoutBirds, total, busyDays)


today : List Int -> Maybe Int
today counts =
    case counts of
        [] ->
            Nothing
        x :: _ ->
            Just x


incrementDayCount : List Int -> List Int
incrementDayCount counts =
    case counts of
        [] ->
            [ 1 ]
        x :: xs ->
            (x + 1) :: xs


hasDayWithoutBirds : List Int -> Bool
hasDayWithoutBirds counts =
    case counts of
        [] ->
            False
        x :: xs ->
            if x == 0 then
                True
            else
                hasDayWithoutBirds xs


total : List Int -> Int
total counts =
    case counts of
        [] ->
            0
        x :: xs ->
            x + total xs


busyDays : List Int -> Int
busyDays counts =
    case counts of
        [] ->
            0
        x :: xs ->
            if x >= 5 then
                1 + busyDays xs
            else
                busyDays xs
