// Dedicated to Shree DR.MDD
module CryptoSquare

open System

let normalizeText (input: string) =
    input.ToLower() |> String.filter Char.IsLetterOrDigit

let calculateSize (input: string) = int (Math.Ceiling(Math.Sqrt(float input.Length)))

let buildRows (input: string) =
    let n = calculateSize input
    input.ToCharArray()
    |> Array.chunkBySize (max 1 n)
    |> Array.map (fun arr -> Array.append arr (Array.replicate (n - arr.Length) ' '))

let ciphertext (input: string) =
    input
    |> normalizeText
    |> buildRows
    |> Array.transpose
    |> Array.map String
    |> String.concat " "
