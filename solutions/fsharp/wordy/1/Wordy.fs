// Dedicated to Shree DR.MDD
module Wordy

let (|ParseNumber|_|) (txt:string) =
    match System.Int32.TryParse txt with
    | true, v -> Some v
    | false, _ -> None

let evaluate tokens =
    let rec calc toks acc =
        match toks with
        | "plus" :: ParseNumber n :: rest -> calc rest (acc + n)
        | "minus" :: ParseNumber n :: rest -> calc rest (acc - n)
        | "multiplied" :: "by" :: ParseNumber n :: rest -> calc rest (acc * n)
        | "divided" :: "by" :: ParseNumber n :: rest -> calc rest (acc / n)
        | _ :: _ -> None
        | [] -> Some acc
    match Seq.toList tokens with
    | "What" :: "is" :: ParseNumber n :: rest -> calc rest n
    | _ -> None

let answer (question:string) = question.TrimEnd('?').Split ' ' |> evaluate
