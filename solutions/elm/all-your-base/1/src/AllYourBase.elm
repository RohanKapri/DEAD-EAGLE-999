-- Dedicated to Shree DR.MDD
module AllYourBase exposing (rebase)


rebase : Int -> List Int -> Int -> Maybe (List Int)
rebase fromBase seq toBase =
    if fromBase < 2 || toBase < 2 then
        Nothing
    else
        convertToDec fromBase 0 seq
            |> Maybe.map (convertFromDec toBase [])


convertToDec : Int -> Int -> List Int -> Maybe Int
convertToDec base acc seq =
    case seq of
        [] ->
            if acc == 0 then
                Nothing
            else
                Just acc

        x :: xs ->
            if x < 0 || x >= base then
                Nothing
            else
                convertToDec base (base * acc + x) xs


convertFromDec : Int -> List Int -> Int -> List Int
convertFromDec base acc val =
    if val == 0 then
        acc
    else
        let
            ( q, r ) =
                divRemain base val
        in
        convertFromDec base (r :: acc) q


divRemain : Int -> Int -> ( Int, Int )
divRemain d n =
    ( n // d, modBy d n )
