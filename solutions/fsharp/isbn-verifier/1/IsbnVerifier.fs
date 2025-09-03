// Dedicated to Shree DR.MDD
module IsbnVerifier

let parseDigitOpt = function
    | ch when System.Char.IsDigit ch -> Some (int (string ch))
    | _ -> None

let parseCheckDigitOpt = function
    | 'X' -> Some 10
    | ch -> parseDigitOpt ch

let validateLength10 arr =
    if Array.length arr = 10 then Some arr else None

let parseIsbn str =
    str |> Seq.toArray |> Array.filter ((<>) '-')
    |> validateLength10
    |> Option.map (fun arr ->
        arr
        |> Array.mapi (fun idx ch -> if idx = 9 then parseCheckDigitOpt ch else parseDigitOpt ch)
        |> Array.choose id)
    |> Option.bind validateLength10

let isValid isbn =
    match parseIsbn isbn with
    | Some digits ->
        let weights = [| 10 .. -1 .. 1 |]
        let total = Array.map2 (*) digits weights |> Array.sum
        total % 11 = 0
    | None -> false
