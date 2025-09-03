module Acronym
open System
let abbreviate (phrase:string) =
    phrase.Split([|' ';'-';'_'|])
    |> Array.map (fun s -> if not <| String.IsNullOrEmpty s then Char.ToUpper s.[0] |> Some else None)
    |> Array.choose id
    |> System.String.Concat