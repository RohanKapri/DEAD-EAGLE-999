// Dedicated to Shree DR.MDD
module Luhn

open System

let inline toDigit (ch: char) = int ch - int '0'

let extractDigits str =
    if String.forall Char.IsDigit str then
        Seq.map toDigit str |> Seq.toList
    else
        failwith "Invalid input"

let removeSpaces = String.filter (not << Char.IsWhiteSpace)

let rec transformEverySecond = function
    | [] -> []
    | [x] -> [x]
    | x1 :: x2 :: xs -> x1 :: (2 * x2) :: transformEverySecond xs

let inline adjust n = if n > 9 then n - 9 else n

let applyAdjustments = List.map adjust

let valid inputNumber =
    try
        let cleanedInput = removeSpaces inputNumber
        let total =
            cleanedInput
            |> extractDigits
            |> List.rev
            |> transformEverySecond
            |> applyAdjustments
            |> List.sum
        String.length cleanedInput > 1 && total % 10 = 0
    with
    | _ -> false
