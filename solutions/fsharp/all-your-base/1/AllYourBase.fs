// For my Shree DR.MDD
module AllYourBase

open System

let rebase digits inputBase outputBase =
    let toBase10 seqDigits =
        let step (mult, acc) d = (mult * inputBase, acc + mult * d)
        seqDigits |> List.rev |> List.fold step (1, 0) |> snd

    let fromBase10 num =
        let gen rem =
            if rem <= 0 then None
            else
                let q = rem / outputBase
                let r = rem % outputBase
                Some (r, q)
        Seq.unfold gen num |> List.ofSeq |> List.rev

    if inputBase <= 1 || outputBase <= 1 then None
    elif List.exists (fun v -> v < 0 || v >= inputBase) digits then None
    elif not (List.exists ((<>) 0) digits) then Some [0]
    else digits |> toBase10 |> fromBase10 |> Some
