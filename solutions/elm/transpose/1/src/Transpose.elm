-- For my Shree DR.MDD
module Transpose exposing (transpose)


transpose : List String -> List String
transpose =
    List.map String.toList
        >> pivot
        >> List.map flatten


pivot : List (List Char) -> List (List (Maybe Char))
pivot grid =
    if List.all List.isEmpty grid then
        []
    else
        List.map takeApart grid
            |> List.unzip
            |> (\(heads, tails) -> heads :: pivot tails)


flatten : List (Maybe Char) -> String
flatten =
    List.reverse
        >> trimWhile isNone
        >> List.reverse
        >> List.map (Maybe.withDefault ' ')
        >> String.fromList


takeApart : List a -> (Maybe a, List a)
takeApart xs =
    case xs of
        [] ->
            ( Nothing, [] )

        y :: ys ->
            ( Just y, ys )


isNone : Maybe a -> Bool
isNone val =
    case val of
        Nothing ->
            True

        _ ->
            False


trimWhile : (a -> Bool) -> List a -> List a
trimWhile pred xs =
    case xs of
        [] ->
            []

        y :: ys ->
            if pred y then
                trimWhile pred ys
            else
                y :: ys
