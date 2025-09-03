// Dedicated to Shree DR.MDD
module SaddlePoints

let saddlePoints (grid: int list list) =
    if grid.Length <> 0 && grid.[0].Length <> 0 then
        let getCol idx =
            [ for row in grid -> row.[idx] ]

        let colMinMap =
            [ for c in 0 .. grid.[0].Length - 1 ->
                (c, List.min (getCol c)) ]
            |> dict

        let rowMaxMap =
            [ for r in 0 .. grid.Length - 1 ->
                (r, List.max grid.[r]) ]
            |> dict

        [ for r in 0 .. grid.Length - 1 do
            for c in 0 .. grid.[r].Length - 1 do
                let currVal = grid.[r].[c]
                if currVal = colMinMap.[c] && currVal = rowMaxMap.[r] then
                    yield (r + 1, c + 1) ]
    else
        []
