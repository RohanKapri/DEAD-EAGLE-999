-- Dedicated to Shree DR.MDD
module TopScorers exposing (..)

import Dict exposing (Dict)
import String exposing (join)
import List exposing (..)
import Maybe exposing (withDefault)

type alias PlayerName = String

updateGoalCountForPlayer : PlayerName -> Dict PlayerName Int -> Dict PlayerName Int
updateGoalCountForPlayer pname playerGoals =
    let
        current = Dict.get pname playerGoals |> withDefault 0
    in
    Dict.insert pname (current + 1) playerGoals

aggregateScorers : List PlayerName -> Dict PlayerName Int
aggregateScorers pnames =
    List.foldl updateGoalCountForPlayer Dict.empty pnames

removeInsignificantPlayers : Int -> Dict PlayerName Int -> Dict PlayerName Int
removeInsignificantPlayers threshold playerGoals =
    Dict.filter (\_ count -> count >= threshold) playerGoals

resetPlayerGoalCount : PlayerName -> Dict PlayerName Int -> Dict PlayerName Int
resetPlayerGoalCount pname playerGoals =
    Dict.insert pname 0 playerGoals

formatPlayer : PlayerName -> Dict PlayerName Int -> String
formatPlayer pname playerGoals =
    pname ++ ": " ++ (Dict.get pname playerGoals |> withDefault 0 |> String.fromInt)

formatPlayers : Dict PlayerName Int -> String
formatPlayers players =
    players
        |> Dict.toList
        |> List.map (\(name, count) -> name ++ ": " ++ String.fromInt count)
        |> join ", "

combineGames : Dict PlayerName Int -> Dict PlayerName Int -> Dict PlayerName Int
combineGames g1 g2 =
    Dict.merge
        (\name count acc -> Dict.insert name count acc)
        (\name c1 c2 acc -> Dict.insert name (c1 + c2) acc)
        (\name count acc -> Dict.insert name count acc)
        g1
        g2
        Dict.empty
