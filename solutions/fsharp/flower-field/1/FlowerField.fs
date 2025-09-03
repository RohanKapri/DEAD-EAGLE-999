module FlowerField

let annotate (input: string list) = [
    for j, line in input |> Seq.indexed do
        String.concat "" [
            for i, cell in line |> Seq.indexed do
                if cell = '*' then "*"
                else
                    let neighboringFlowersCount = 
                        [   i-1, j-1; i, j-1; i+1, j-1
                            i-1, j;           i+1, j
                            i-1, j+1; i, j+1; i+1, j+1  ]
                        |> Seq.filter (fun (i, j) -> 
                            i >= 0 && i < input[0].Length &&
                            j >= 0 && j < input.Length &&
                            input[j][i] = '*')
                        |> Seq.length
                    if neighboringFlowersCount = 0 then " " 
                    else string neighboringFlowersCount
        ]
]