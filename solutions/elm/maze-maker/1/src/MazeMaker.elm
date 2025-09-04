module MazeMaker exposing (..)
import Random exposing (Generator)
type Maze
    = DeadEnd
    | Room Treasure
    | Branch (List Maze)
type Treasure
    = Gold
    | Diamond
    | Friendship
deadend : Generator Maze
deadend =
    Random.constant DeadEnd
treasure : Generator Treasure
treasure =
    Random.uniform Gold [Diamond, Friendship]
room : Generator Maze
room =
    Random.map Room treasure
branch : Generator Maze -> Generator Maze
branch mazeGenerator =
    Random.int 2 4
        |> Random.andThen
            (\n -> Random.list n mazeGenerator |> Random.map Branch)
maze : Generator Maze
maze =
    Random.weighted
        ( 12, deadend )
        [ ( 3, room )
        , ( 5, (\_ -> maze) |> Random.lazy |> branch )
        ]
        |> Random.andThen identity
mazeOfDepth : Int -> Generator Maze
mazeOfDepth depth =
    case depth of
        0 ->
            Random.uniform
                deadend
                [ room ]
                |> Random.andThen identity
        _ ->
            mazeOfDepth (depth - 1)
                |> branch
