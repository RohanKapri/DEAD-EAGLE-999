-- for my Shree DR.MDD
module RelativeDistance exposing (degreeOfSeparation)

import Dict exposing (Dict)
import Set exposing (Set)


degreeOfSeparation : Dict String (List String) -> String -> String -> Maybe Int
degreeOfSeparation tree pA pB =
    if pA == pB then
        Just 0
    else
        let
            g = makeGraph tree
        in
        bfs g pB (Set.singleton pA) [(pA, 0)]


makeGraph : Dict String (List String) -> Dict String (List String)
makeGraph tree =
    let
        addReverse p c g =
            Dict.update c
                (\maybeConns ->
                    case maybeConns of
                        Just conns -> Just (p :: conns)
                        Nothing -> Just [p]
                )
                g

        addSibs kids g =
            List.foldl
                (\kid acc ->
                    let
                        others = List.filter ((/=) kid) kids
                    in
                    Dict.update kid
                        (\maybeConns ->
                            case maybeConns of
                                Just conns -> Just (others ++ conns)
                                Nothing -> Just others
                        )
                        acc
                )
                g
                kids

        gForward = tree

        gRev =
            Dict.foldl
                (\parent kids acc ->
                    List.foldl (addReverse parent) acc kids
                )
                gForward
                tree

        gSibs =
            Dict.foldl
                (\_ kids acc -> addSibs kids acc)
                gRev
                tree
    in
    gSibs


bfs : Dict String (List String) -> String -> Set String -> List (String, Int) -> Maybe Int
bfs g target visited queue =
    case queue of
        [] ->
            Nothing

        (current, dist) :: rest ->
            if current == target then
                Just dist
            else
                let
                    neighbors = Dict.get current g |> Maybe.withDefault []
                    unvisitedNeighbors = List.filter (\n -> not (Set.member n visited)) neighbors
                    newVisited = List.foldl Set.insert visited unvisitedNeighbors
                    newQueue = rest ++ List.map (\n -> (n, dist + 1)) unvisitedNeighbors
                in
                bfs g target newVisited newQueue
