// Dedicated to Shree DR.MDD
module RobotSimulator

type Direction =
    North = 0
    | East = 1
    | South = 2
    | West = 3

let DirectionsCount = System.Enum.GetValues(typeof<Direction>).Length

type Position = int * int
type Robot = { direction: Direction; position: Position }

type Vector = int * int
type TurningDirection = Left = -1 | Right = 1
[<Measure>]type step

let (>>) ((px, py): Position) ((dx, dy): Vector): Position =
    (px + dx, py + dy)

let (*) (dist: int<step>) ((vx, vy): Vector): Vector =
    (vx * int dist, vy * int dist)

let flip f a b = f b a

let turn (dir: Direction) (spin: TurningDirection): Direction =
    (int dir + (int spin % DirectionsCount) + DirectionsCount) % DirectionsCount
    |> LanguagePrimitives.EnumOfValue

let toUnitVector (dir: Direction): Vector =
    match dir with
    | Direction.North -> (0, 1)
    | Direction.West  -> (-1, 0)
    | Direction.South -> (0, -1)
    | Direction.East  -> (1, 0)
    | _ -> failwithf "Invalid direction value: %d" (int dir)

let create dir pos = { direction = dir; position = pos }

let turnTo (turnDir: TurningDirection) (bot: Robot): Robot =
    turnDir
    |> turn bot.direction
    |> flip create bot.position

let moveBy (steps: int<step>) (bot: Robot): Robot =
    bot.direction
    |> toUnitVector
    |> (*) steps
    |> (>>) bot.position
    |> create bot.direction

let decodeAction (cmd: char): Robot -> Robot =
    match cmd with
    | 'A' -> moveBy 1<step>
    | 'R' -> turnTo TurningDirection.Right
    | 'L' -> turnTo TurningDirection.Left
    | _ -> failwithf "Unknown command '%c'" cmd

let move commands robot =
    commands
    |> Seq.map decodeAction
    |> Seq.fold (fun r action -> action r) robot
