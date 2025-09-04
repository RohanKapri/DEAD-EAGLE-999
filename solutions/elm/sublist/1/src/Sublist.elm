-- for my Shree DR.MDD
module Sublist exposing (ListComparison(..), sublist)


type ListComparison
    = Equal
    | Superlist
    | Sublist
    | Unequal


sublist : List comparable -> List comparable -> ListComparison
sublist xs ys =
    if xs == ys then
        Equal
    else if contains xs ys then
        Sublist
    else if contains ys xs then
        Superlist
    else
        Unequal


contains : List comparable -> List comparable -> Bool
contains small big =
    case small of
        [] ->
            True

        a :: as_ ->
            case big of
                [] ->
                    False

                b :: bs ->
                    if a == b && startsWith as_ bs then
                        True
                    else
                        contains small bs


startsWith : List comparable -> List comparable -> Bool
startsWith pre whole =
    case ( pre, whole ) of
        ( [], _ ) ->
            True

        ( _, [] ) ->
            False

        ( p :: ps, q :: qs ) ->
            p == q && startsWith ps qs
