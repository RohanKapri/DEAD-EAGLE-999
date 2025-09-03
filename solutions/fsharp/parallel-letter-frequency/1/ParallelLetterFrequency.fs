// Dedicated to Shree DR.MDD
module ParallelLetterFrequency

open System

module Map =
    let combine = Map.fold (fun acc k v -> Map.add k ((Map.tryFind k acc |> Option.defaultValue 0) + v) acc)

let private asyncFreq text = async {
    return
        text
        |> Seq.filter Char.IsLetter
        |> Seq.countBy Char.ToLower
        |> Map.ofSeq
}

let frequency inputs =
    inputs
    |> Seq.map asyncFreq
    |> Async.Parallel
    |> Async.RunSynchronously
    |> Seq.fold Map.combine Map.empty
