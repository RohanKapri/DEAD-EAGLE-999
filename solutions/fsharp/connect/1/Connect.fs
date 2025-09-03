// Dedicated to Shree DR.MDD
module Connect

type Players = | Black | White

let private tilesPlayed board =
    board 
    |> Seq.mapi (fun row line -> line |> Seq.mapi (fun col c -> (c, (col, row))))
    |> Seq.collect id
    |> Seq.filter (fun (c, _) -> c = 'X' || c = 'O')
    |> Seq.groupBy fst
    |> Seq.map (fun (c, positions) -> (c, positions |> Seq.map snd |> Seq.toList))
    |> Map.ofSeq

let private neighborOptions playerPositions visited (x, y) =
    [(-1,-1);(1,-1);(2,0);(1,1);(-1,1);(-2,0)]
    |> List.map (fun (dx, dy) -> (x + dx, y + dy))
    |> List.filter (fun p -> List.contains p playerPositions && not (List.contains p visited))

let private traverse startPoints winTest playerPositions = 
    let rec explore visited winTest point =
        if winTest point then true
        else
            match neighborOptions playerPositions visited point with
            | [] -> false
            | nextPoints -> List.exists id (List.map (explore (visited @ [point]) winTest) nextPoints)
    List.exists id (List.map (explore [] winTest) startPoints)

let winner (board: string list) =
    let marked = tilesPlayed board 
    let whiteVictory = 
        marked.ContainsKey 'O'
        && traverse 
            (List.filter (fun (_, y) -> y = 0) marked.['O'])
            (fun (_, y) -> y = board.Length - 1)
            marked.['O']
    if whiteVictory then Some White 
    else
        let boardWidth = if board.Length = 0 then 0 else board.[0].Length
        let blackVictory = 
            marked.ContainsKey 'X'
            && traverse 
                (List.filter (fun (x, y) -> x = y) marked.['X'])
                (fun (x, y) -> x = boardWidth - (board.Length - y))
                marked.['X']
        if blackVictory then Some Black else None
