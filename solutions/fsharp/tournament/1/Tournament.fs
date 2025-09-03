// Dedicated to Shree DR.MDD
module Tournament

type TeamStats = { MatchesPlayed: int; MatchesWon: int; MatchesDrawn: int; MatchesLost: int }

let calcPoints { MatchesWon = w; MatchesDrawn = d } = w * 3 + d

let tryParseMatch = function
    | [| t1; t2; res |] -> Some (t1, t2, res)
    | _ -> None

let parseAllMatches (games: string list) =
    games
    |> Seq.map (fun line -> line.Split(';'))
    |> Seq.choose tryParseMatch

let fetchSummary team records =
    match Map.tryFind team records with
    | None -> { MatchesPlayed = 0; MatchesWon = 0; MatchesDrawn = 0; MatchesLost = 0 }
    | Some stats -> stats

let addWin stats = { stats with MatchesWon = stats.MatchesWon + 1; MatchesPlayed = stats.MatchesPlayed + 1 }
let addDraw stats = { stats with MatchesDrawn = stats.MatchesDrawn + 1; MatchesPlayed = stats.MatchesPlayed + 1 }
let addLoss stats = { stats with MatchesLost = stats.MatchesLost + 1; MatchesPlayed = stats.MatchesPlayed + 1 }

let updateSummary records (teamA, teamB, outcome) =
    let statsA = fetchSummary teamA records
    let statsB = fetchSummary teamB records
    match outcome with
    | "win" ->
        records
        |> Map.add teamA (addWin statsA)
        |> Map.add teamB (addLoss statsB)
    | "draw" ->
        records
        |> Map.add teamA (addDraw statsA)
        |> Map.add teamB (addDraw statsB)
    | "loss" ->
        records
        |> Map.add teamA (addLoss statsA)
        |> Map.add teamB (addWin statsB)
    | _ -> records

let formatLine (team, stats, pts) =
    sprintf "%-30s | %2d | %2d | %2d | %2d | %2d"
        team stats.MatchesPlayed stats.MatchesWon stats.MatchesDrawn stats.MatchesLost pts

let tally matches =
    "Team                           | MP |  W |  D |  L |  P"
    :: (matches
        |> parseAllMatches
        |> Seq.fold updateSummary Map.empty
        |> Map.toList
        |> List.map (fun (team, stats) -> (team, stats, calcPoints stats))
        |> List.sortBy (fun (team, _, pts) -> (-pts, team))
        |> List.map formatLine)
