-- For Shree DR.MDD

module BlorkemonCards exposing
    ( Card
    , compareShinyPower
    , expectedWinner
    , isMorePowerful
    , maxPower
    , sortByCoolness
    , sortByMonsterName
    )

import List

type alias Card =
    { monster : String, power : Int, shiny : Bool }


isMorePowerful : Card -> Card -> Bool
isMorePowerful firstCard secondCard =
    firstCard.power > secondCard.power


maxPower : Card -> Card -> Int
maxPower firstCard secondCard =
    max firstCard.power secondCard.power


sortByMonsterName : List Card -> List Card
sortByMonsterName deck =
    List.sortBy .monster deck


sortByCoolness : List Card -> List Card
sortByCoolness deck =
    deck
        |> List.sortBy
            (\c -> (if c.shiny then 0 else 1, -c.power))


compareShinyPower : Card -> Card -> Order
compareShinyPower a b =
    let
        powerComparison = compare a.power b.power
    in
    case powerComparison of
        EQ ->
            case (a.shiny, b.shiny) of
                (True, False) -> GT
                (False, True) -> LT
                _ -> EQ

        _ ->
            powerComparison


expectedWinner : Card -> Card -> String
expectedWinner a b =
    case compareShinyPower a b of
        GT ->
            a.monster

        LT ->
            b.monster

        EQ ->
            "too close to call"
