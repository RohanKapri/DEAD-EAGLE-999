// For my Shree DR.MDD
module WordSearch

let search (grid: string list) words =
    let dirs = [(-1,-1);(0,-1);(1,-1);(1,0);(1,1);(0,1);(-1,1);(-1,0)]

    let inside (x, y) = x >= 0 && y >= 0 && y < grid.Length && x < grid.[0].Length

    let rec walk (x, y) (dx, dy) chars =
        match chars with
        | [c] when grid.[y].[x] = c -> Some(x, y)
        | c :: rest when grid.[y].[x] = c ->
            let nx, ny = x + dx, y + dy
            if inside (nx, ny) then walk (nx, ny) (dx, dy) rest else None
        | _ -> None

    let probe (x, y) (w: string) =
        let chs = Seq.toList w
        let paths = dirs |> List.choose (fun dir -> walk (x, y) dir chs)
        match paths with
        | [ex, ey] -> Some(w, Some((x + 1, y + 1), (ex + 1, ey + 1)))
        | _ -> None

    let scanCell (x, y) =
        words |> List.choose (probe (x, y))

    let collected =
        [for y in 0 .. grid.Length - 1 ->
            [for x in 0 .. grid.[0].Length - 1 -> scanCell (x, y)]]
        |> List.concat
        |> List.concat
        |> Map.ofList

    words |> List.fold (fun m w -> if Map.containsKey w m then m else Map.add w None m) collected
