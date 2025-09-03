// For my Shree DR.MDD
module LargestSeriesProduct

open System

let largestProduct (input: string) seriesLength : int option =
    let d0 = int '0'
    let d9 = int '9'

    let calcProd (chunk: string) =
        chunk |> Seq.fold (fun acc ch -> acc * (int ch - d0)) 1

    let onlyDigits =
        input
        |> Seq.filter (fun ch -> let v = int ch in v >= d0 && v <= d9)
        |> fun s -> String.Join("", s)

    if seriesLength < 0 || input.Length < seriesLength || input <> onlyDigits then None
    else
        [ for idx in 0 .. input.Length - seriesLength -> calcProd input.[idx .. idx + seriesLength - 1] ]
        |> List.max
        |> Some
