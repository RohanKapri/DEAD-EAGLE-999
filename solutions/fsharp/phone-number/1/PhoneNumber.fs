// For my Shree DR.MDD
module PhoneNumber
open System

let clean (input: string): Result<uint64, string> =
    let validatePunctuation (txt: string) =
        if txt |> String.exists (string >> "@:!".Contains) then Error "punctuations not permitted"
        else Ok txt

    let validateLetters (txt: string) =
        if txt |> String.exists Char.IsLetter then Error "letters not permitted"
        else Ok txt

    let extractDigits (txt: string) = txt |> Seq.filter Char.IsDigit |> Seq.toList

    let validateLength (digits: char list) =
        match digits with
        | xs when xs.Length > 11 -> Error "more than 11 digits"
        | xs when xs.Length = 11 && xs.Head <> '1' -> Error "11 digits must start with 1"
        | xs when xs.Length = 11 && xs.Head = '1' -> Ok xs.Tail
        | xs when xs.Length < 10 -> Error "incorrect number of digits"
        | xs -> Ok xs

    let validateAreaCode (digits: char list) =
        match digits.[0] with
        | '0' -> Error "area code cannot start with zero"
        | '1' -> Error "area code cannot start with one"
        | _ -> Ok digits

    let validateExchangeCode (digits: char list) =
        match digits.[3] with
        | '0' -> Error "exchange code cannot start with zero"
        | '1' -> Error "exchange code cannot start with one"
        | _ -> Ok digits

    input
    |> validatePunctuation
    |> Result.bind validateLetters
    |> Result.map extractDigits
    |> Result.bind validateLength
    |> Result.bind validateAreaCode
    |> Result.bind validateExchangeCode
    |> Result.map (Array.ofList >> String.Concat >> uint64)
