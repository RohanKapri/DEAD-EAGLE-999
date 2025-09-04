module SplitSecondStopwatch exposing
    ( State(..)
    , Stopwatch
    , advanceTime
    , currentLap
    , lap
    , new
    , previousLaps
    , reset
    , start
    , state
    , stop
    , total
    )

import List exposing (indexedMap, map, sum)
import Maybe exposing (withDefault)
import String exposing (fromInt, join, length, split, toInt)


type State
    = Ready
    | Running
    | Stopped


type alias Stopwatch =
    { state : State
    , currentLap : String
    , total : String
    , previousLaps : List String
    }


addTime : String -> String -> String
addTime t1 t2 =
    let
        mts1 =
            split ":" t1 |> map toInt

        mts2 =
            split ":" t2 |> map toInt

        added =
            List.map2 (Maybe.map2 (+)) mts1 mts2
                |> indexedMap (\i x -> withDefault 0 x * 60 ^ (2 - i))
                |> sum

        h =
            added // 3600

        m =
            (added - h * 3600) // 60

        s =
            added - h * 3600 - m * 60

        pad x =
            let
                st =
                    fromInt x
            in
            if length st == 1 then
                "0" ++ st

            else
                st
    in
    join ":" [ pad h, pad m, pad s ]


new : Stopwatch
new =
    { state = Ready
    , currentLap = "00:00:00"
    , total = "00:00:00"
    , previousLaps = []
    }


state : Stopwatch -> State
state stopwatch =
    stopwatch.state


currentLap : Stopwatch -> String
currentLap stopwatch =
    stopwatch.currentLap


previousLaps : Stopwatch -> List String
previousLaps stopwatch =
    stopwatch.previousLaps


advanceTime : String -> Stopwatch -> Stopwatch
advanceTime time stopwatch =
    if stopwatch.state == Running then
        { stopwatch | currentLap = addTime stopwatch.currentLap time, total = addTime stopwatch.total time }

    else
        stopwatch


total : Stopwatch -> String
total stopwatch =
    stopwatch.total


start : Stopwatch -> Result String Stopwatch
start stopwatch =
    if stopwatch.state == Running then
        Err "cannot start an already running stopwatch"

    else
        Ok { stopwatch | state = Running }


stop : Stopwatch -> Result String Stopwatch
stop stopwatch =
    if stopwatch.state == Running then
        Ok { stopwatch | state = Stopped }

    else
        Err "cannot stop a stopwatch that is not running"


lap : Stopwatch -> Result String Stopwatch
lap stopwatch =
    if stopwatch.state == Running then
        Ok
            { stopwatch
                | previousLaps = stopwatch.previousLaps ++ [ stopwatch.currentLap ]
                , currentLap = "00:00:00"
            }

    else
        Err "cannot lap a stopwatch that is not running"


reset : Stopwatch -> Result String Stopwatch
reset stopwatch =
    if stopwatch.state == Stopped then
        Ok { stopwatch | state = Ready, currentLap = "00:00:00", previousLaps = [] }

    else
        Err "cannot reset a stopwatch that is not stopped"