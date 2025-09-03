// Dedicated to Shree DR.MDD
module GoCounting

type Owner = | Black = 0 | White = 1 | None = 2

let boardMap (board: string list) = 
    board 
    |> Seq.indexed 
    |> Seq.collect (fun (row, line) -> line |> Seq.indexed |> Seq.map (fun (col, c) -> ((col,row),c)))
    |> Map.ofSeq

let determineOwner tiles =
    tiles |> List.map snd |> List.except [' '] |> List.distinct 
    |> function
       | ['B'] -> Owner.Black
       | ['W'] -> Owner.White
       | _ -> Owner.None

let rec flood map visited point =
    let c = Map.find point map
    match point with
    | p when c <> ' ' -> visited @ [(p, c)]
    | (x,y) ->
        let updated = visited @ [(point, c)]
        let neighbors = 
            [(-1, 0);(1, 0);(0, -1);(0, 1)]
            |> List.map (fun (dx,dy) -> x + dx, y + dy)
            |> List.filter (fun p -> Map.containsKey p map && not (List.exists (fst >> (=) p) updated))
        match neighbors with
        | [] -> updated
        | _ -> neighbors |> List.collect (flood map updated)

let calculateExtent (boardMap: Map<(int * int), char>) start =
    let tiles = flood boardMap [] start |> List.distinct
    let emptySpaces = tiles |> List.filter (snd >> (=) ' ') |> List.map fst |> List.sort
    (determineOwner tiles, emptySpaces)

let territory board position = 
    let mapped = boardMap board
    match mapped |> Map.tryFind position with
    | None -> None
    | Some c when c <> ' ' -> Some (Owner.None, [])
    | _ -> calculateExtent mapped position |> Some

let territories board =
    let mapped = boardMap board
    mapped 
    |> Map.toSeq 
    |> Seq.map (fst >> calculateExtent mapped)
    |> Seq.append [(Owner.Black, []);(Owner.White, []);(Owner.None, [])]
    |> Seq.groupBy fst
    |> Seq.map (fun (o, ps) -> (o, ps |> Seq.collect snd |> Seq.distinct |> Seq.toList))
    |> Map.ofSeq
