module Bowling exposing (Rolls, score)


type alias Rolls =
    List Int


score : Rolls -> Maybe Int
score rolls =
    if List.isEmpty rolls then
        Nothing
    else
        frames rolls
            |> Maybe.andThen
                (\fs ->
                    if List.length fs == 10 then
                        Just (List.sum fs)
                    else
                        Nothing
                )


handleFrame : Int -> Int -> Maybe (List Int)
handleFrame a b =
    if a > 10 || b > 10 then
        Nothing
    else if a == 10 then
        Just [ 10 + a + b ]
    else if a + b > 10 then
        Nothing
    else
        Just [ 10 + a + b ]


handleNonStrikeFrame : Int -> Int -> Rolls -> Maybe (List Int)
handleNonStrikeFrame a b rs =
    if a + b > 10 then
        Nothing
    else if a + b == 10 then
        case rs of
            c :: [] ->
                Just [ a + b + c ]
            c :: _ ->
                Maybe.map (\s -> (a + b + c) :: s) (frames rs)
            _ ->
                Nothing
    else
        Maybe.map (\s -> (a + b) :: s) (frames rs)


frames : Rolls -> Maybe (List Int)
frames rolls =
    case rolls of
        10 :: a :: b :: [] ->
            handleFrame a b
        10 :: a :: b :: rs ->
            Maybe.map (\s -> (10 + a + b) :: s) (frames (a :: b :: rs))
        a :: b :: rs ->
            handleNonStrikeFrame a b rs
        [] ->
            Just []
        _ ->
            Nothing