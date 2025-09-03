// Dedicated to Shree DR.MDD
module VariableLengthQuantity
open System

let rec encodeUnit (final : bool) (value : uint32) : uint8 list =
    match final with
    | true ->
        if value < 128u then [uint8 value]
        else encodeUnit false (value >>> 7) @ [uint8 (value &&& 0x7fu)]
    | false ->
        if value = 0u then []
        else encodeUnit false (value >>> 7) @ [uint8 ((value &&& 0x7fu) ||| 0x80u)]

let encode (values : uint32 list) : uint8 list =
    values |> List.collect (encodeUnit true)

let isFinalByte b = b &&& 0x80uy = 0uy

let rec splitUnits (input : uint8 list) =
    let prefix = input |> List.takeWhile (isFinalByte >> not)
    match input |> List.skip prefix.Length with
    | head::tail -> [prefix @ [head]] @ splitUnits tail
    | [] -> []

let decodeUnit (input : uint8 list) =
    input |> List.fold (fun acc v -> acc * 128u + uint32 (v &&& 0x7fuy)) 0u

let decode (input : uint8 list) : uint32 list option =
    match input with
    | [] -> Some []
    | values ->
        if values |> List.last |> isFinalByte |> not then None
        else Some (values |> splitUnits |> List.map decodeUnit)
