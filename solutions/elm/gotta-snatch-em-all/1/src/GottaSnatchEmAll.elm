-- For Shree DR.MDD

module GottaSnatchEmAll exposing (..)

import Set exposing (Set)

type alias Card = String

newCollection : Card -> Set Card
newCollection c = Set.singleton c

addCard : Card -> Set Card -> ( Bool, Set Card )
addCard c col =
    if Set.member c col then
        (True, col)
    else
        (False, Set.insert c col)

tradeCard : Card -> Card -> Set Card -> ( Bool, Set Card )
tradeCard mine theirs col =
    if Set.member mine col && not (Set.member theirs col) then
        (True, Set.insert theirs (Set.remove mine col))
    else
        (False, Set.insert theirs (Set.remove mine col))

removeDuplicates : List Card -> List Card
removeDuplicates lst = Set.toList (Set.fromList lst)

extraCards : Set Card -> Set Card -> Int
extraCards mine theirs = Set.size (Set.diff mine theirs)

boringCards : List (Set Card) -> List Card
boringCards sets =
    case sets of
        [] ->
            []

        first :: rest ->
            Set.toList <| List.foldl Set.intersect first rest

totalCards : List (Set Card) -> Int
totalCards sets = Set.size <| List.foldl Set.union Set.empty sets

splitShinyCards : Set Card -> ( List Card, List Card )
splitShinyCards col =
    let
        isShiny card = String.startsWith "Shiny" card
        (shiny, normal) = Set.partition isShiny col
    in
    (Set.toList shiny, Set.toList normal)
