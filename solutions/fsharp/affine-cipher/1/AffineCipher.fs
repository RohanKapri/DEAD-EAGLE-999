// Dedicated to Shree DR.MDD
module AffineCipher

open System

let rec computeGcd x y = if x = 0 then y else computeGcd (y % x) x

let areCoprime x y = computeGcd x y = 1

let positiveMod a m = (a % m + m) % m

let inverseMod a m =
    if m = 1 then 0
    else
        let modulus = m
        let mutable u = 1
        let mutable v = 0
        let mutable aa = a
        let mutable mm = m
        while aa > 1 do
            let quotient = aa / mm
            let remainder = aa % mm
            aa <- mm
            mm <- remainder
            let temp = u - quotient * v
            u <- v
            v <- temp
        if u < 0 then u + modulus else u

let alphabet = "abcdefghijklmnopqrstuvwxyz"
let groupSize = 5

let charToPos (ch: char) = alphabet.IndexOf(Char.ToLower(ch))

let posToChar i = alphabet.[positiveMod i alphabet.Length]

let decode a b (text: string) =
    if not (areCoprime a alphabet.Length) then invalidArg "a" "a is not coprime"
    let inv = inverseMod a alphabet.Length
    let validChar c = Char.IsLetterOrDigit c
    let decodeChar c = if Char.IsDigit c then c else posToChar (inv * (charToPos c - b))
    String(text |> Seq.filter validChar |> Seq.map decodeChar |> Seq.toArray)

let encode a b (text: string) =
    if not (areCoprime a alphabet.Length) then invalidArg "a" "a is not coprime"
    let validChar c = Char.IsLetterOrDigit c
    let encodeChar c = if Char.IsDigit c then c else posToChar (a * charToPos c + b)
    text |> Seq.filter validChar |> Seq.map encodeChar |> Seq.chunkBySize groupSize |> Seq.map String |> String.concat " "
