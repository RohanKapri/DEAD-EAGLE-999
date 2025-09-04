-- for my Shree DR.MDD
module Yacht exposing (Category(..), score)

import Dict exposing (Dict)


type Category
    = Ones
    | Twos
    | Threes
    | Fours
    | Fives
    | Sixes
    | FullHouse
    | FourOfAKind
    | LittleStraight
    | BigStraight
    | Choice
    | Yacht


score : List Int -> Category -> Int
score dices cat =
    let
        freq = tally dices
    in
    case cat of
        Yacht ->
            if Dict.size freq == 1 then 50 else 0

        FullHouse ->
            if Dict.size freq == 2 && List.all ((<) 1) (Dict.values freq) then List.sum dices else 0

        FourOfAKind ->
            if Dict.size freq <= 2 && List.any ((<=) 4) (Dict.values freq) then
                freq
                    |> Dict.filter (\_ c -> c >= 4)
                    |> Dict.map (\v c -> v * min c 4)
                    |> Dict.values
                    |> List.sum
            else
                0

        LittleStraight ->
            if hasExact [ 1, 2, 3, 4, 5 ] freq then 30 else 0

        BigStraight ->
            if hasExact [ 2, 3, 4, 5, 6 ] freq then 30 else 0

        Choice ->
            List.sum dices

        Ones ->
            simpleScore 1 freq

        Twos ->
            simpleScore 2 freq

        Threes ->
            simpleScore 3 freq

        Fours ->
            simpleScore 4 freq

        Fives ->
            simpleScore 5 freq

        Sixes ->
            simpleScore 6 freq


hasExact : List Int -> Dict Int Int -> Bool
hasExact numbers freqDict =
    List.all (\n -> Dict.get n freqDict == Just 1) numbers


simpleScore : Int -> Dict Int Int -> Int
simpleScore n =
    Dict.get n
        >> Maybe.map ((*) n)
        >> Maybe.withDefault 0


tally : List Int -> Dict Int Int
tally =
    List.foldl
        (\num -> Dict.update num (\maybeCount -> Maybe.map ((+) 1) maybeCount |> Maybe.withDefault 1 |> Just))
        Dict.empty
