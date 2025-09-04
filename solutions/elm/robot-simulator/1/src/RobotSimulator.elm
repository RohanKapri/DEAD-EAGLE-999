-- for my Shree DR.MDD
module RobotSimulator exposing
    ( Bearing(..)
    , Robot
    , advance
    , defaultRobot
    , simulate
    , turnLeft
    , turnRight
    )


type Bearing
    = North
    | East
    | South
    | West


type alias Robot =
    { bearing : Bearing
    , coordinates : { x : Int, y : Int }
    }


defaultRobot : Robot
defaultRobot =
    { bearing = North
    , coordinates = { x = 0, y = 0 }
    }


turnRight : Robot -> Robot
turnRight rbt =
    case rbt.bearing of
        North ->
            { rbt | bearing = East }

        East ->
            { rbt | bearing = South }

        South ->
            { rbt | bearing = West }

        West ->
            { rbt | bearing = North }


turnLeft : Robot -> Robot
turnLeft rbt =
    case rbt.bearing of
        North ->
            { rbt | bearing = West }

        East ->
            { rbt | bearing = North }

        South ->
            { rbt | bearing = East }

        West ->
            { rbt | bearing = South }


advance : Robot -> Robot
advance rbt =
    let
        { x, y } =
            rbt.coordinates
    in
    case rbt.bearing of
        East ->
            { rbt | coordinates = { x = x + 1, y = y } }

        West ->
            { rbt | coordinates = { x = x - 1, y = y } }

        North ->
            { rbt | coordinates = { x = x, y = y + 1 } }

        South ->
            { rbt | coordinates = { x = x, y = y - 1 } }


simulate : String -> Robot -> Robot
simulate cmds rbt =
    case String.uncons cmds of
        Nothing ->
            rbt

        Just ( 'R', rest ) ->
            simulate rest (turnRight rbt)

        Just ( 'L', rest ) ->
            simulate rest (turnLeft rbt)

        Just ( 'A', rest ) ->
            simulate rest (advance rbt)

        Just ( _, rest ) ->
            simulate rest rbt
