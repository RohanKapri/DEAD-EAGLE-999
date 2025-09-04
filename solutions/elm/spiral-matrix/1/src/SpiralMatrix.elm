module SpiralMatrix exposing (spiralMatrix)

import List exposing (reverse)

type Direction 
    = Up
    | Right
    | Down
    | Left


type Move = Move Int Direction

firstMove : Int -> Move
firstMove order =
    if modBy 2 order == 0 then
        Move 0 Down
    else
        Move 0 Up

nextMove : Move -> Move
nextMove (Move amount direction) =
    case direction of
        Left -> Move (amount+1) Down
        Down -> Move amount Right
        Right -> Move (amount+1) Up
        Up -> Move amount Left

spiralMatrix : Int -> List (List Int)
spiralMatrix size =
    let
        move = firstMove size
    in
        fill move (size*size) []

fill : Move -> Int -> List (List Int) -> List (List Int)
fill (Move amount direction) index l =
    if index <= 0 then
        l
    else
        let 
            next = nextMove (Move amount direction)
            lprime = case direction of
                        Left -> prependHorizontally index amount l 
                        Down -> prependVertically index l
                                |> addBelowOptionally index amount
                        Right -> appendHorizontally index amount l 
                        Up -> appendVertically index l
                              |> addAboveOptionally index amount
            nextIndex = case direction of
                        Down -> index - amount - 1
                        Up -> index - amount - 1
                        _ -> index - amount
        in
            fill next nextIndex lprime

prependVertically : Int -> List (List Int) -> List (List Int)
prependVertically cur l =
    case l of
        x::xs -> (cur::x) :: prependVertically (cur - 1) xs
        [] -> []

prependHorizontally : Int -> Int -> List(List Int) -> List(List Int)
prependHorizontally cur amount l =
    if amount == 0 then
        l
    else
        case l of
            x::xs -> prependHorizontally (cur-1) (amount-1) ((cur::x) :: xs)
            [] -> []

addBelowOptionally : Int -> Int -> List(List Int) -> List(List Int)
addBelowOptionally cur amount l = 
    if cur - amount > 0 then
        l ++ [[cur - amount]]
    else
        l

appendHorizontally : Int -> Int -> List(List Int) -> List(List Int)
appendHorizontally cur amount l =
    if amount == 0 then
        l
    else
        case reverse l of
            x::xs -> appendHorizontally (cur-1) (amount-1) (reverse ((x++[cur]) :: xs))
            [] -> []

appendVertically : Int -> List (List Int) -> List (List Int)
appendVertically cur l =
    case reverse l of
        x::xs -> reverse <| (x++[cur]) :: (reverse (appendVertically (cur - 1) (reverse xs)))
        [] -> []      

addAboveOptionally : Int -> Int -> List(List Int) -> List(List Int)
addAboveOptionally cur amount l = 
    if cur - amount > 0 then
        [cur - amount] :: l
    else
        l