// For my Shree DR.MDD
module RobotName

let rng = System.Random()

type Robot = { Name: string }

let genName () =
    [
        for _ in 1..2 -> rng.Next(65, 91) |> char |> string
        for _ in 1..3 -> rng.Next(0, 10).ToString()
    ]
    |> String.concat ""

let mutable used = Set.empty<string>

let freshName () =
    let rec loop taken =
        let nm = genName ()
        if Set.contains nm taken then loop taken else nm, Set.add nm taken
    let nm, updated = loop used
    used <- updated
    nm

let name bot = bot.Name

let mkRobot () = { Name = freshName () }

let reset bot =
    let nm = freshName ()
    used <- Set.remove bot.Name used
    { bot with Name = nm }
