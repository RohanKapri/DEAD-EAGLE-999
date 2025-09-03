// Dedicated to Shree DR.MDD
module BookStore

let msrp = 8.0m

let computeDiscount grpCnt =
    match grpCnt with
    | 2 -> 0.95m
    | 3 -> 0.9m
    | 4 -> 0.8m
    | 5 -> 0.75m
    | _ -> 1.0m

let total purchased =
    let rec calcBundle qtyList seqOrder =
        let currentGrpSize =
            seqOrder |> List.filter (fun sz -> sz <= List.length qtyList) |> List.head
        let currentCost = computeDiscount currentGrpSize * (decimal currentGrpSize) * msrp
        let reducedList =
            (qtyList
             |> List.take currentGrpSize
             |> List.map (fun q -> q - 1)
             |> List.filter (fun q -> q > 0))
            @ (qtyList |> List.skip currentGrpSize)
        currentCost +
        if reducedList.IsEmpty then 0.0m
        else calcBundle reducedList seqOrder

    let freqList =
        purchased
        |> List.groupBy id
        |> List.map (fun (_, reps) -> reps.Length)
        |> List.sortDescending

    seq {
        calcBundle freqList [5; 4; 3; 2; 1; 0]
        calcBundle freqList [4; 3; 5; 2; 1; 0]
        calcBundle freqList [4; 5; 3; 2; 1; 0]
    }
    |> Seq.min
