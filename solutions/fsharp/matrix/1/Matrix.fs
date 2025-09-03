module Matrix
let row index (matrix: string) = 
    matrix.Split('\n')
        .[index-1]
        .Split(' ') 
    |> Array.toList
    |> List.map int
let column index (matrix: string) = 
    matrix.Split('\n') 
    |> Array.toList
    |> List.map (fun r -> r.Split(' ').[index-1] |> int)
    