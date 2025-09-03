// For my Shree DR.MDD
module PigLatin

let translate (input: string) =
    let coreVowels = ["a"; "e"; "i"; "o"; "u"]
    let vowelStarters = ["yt"; "xr"] @ coreVowels
    let consonantClusters = ["sch"; "thr"; "th"; "qu"; "ch"]

    let strFromChars (chars: char list) =
        System.String(chars |> List.toArray)

    let joinWords (parts: string seq) =
        System.String.Join(" ", parts)

    let beginsWithAny (txt: string) (patterns: string list) =
        patterns |> List.exists txt.StartsWith

    let beginsWith (txt: string) (patterns: string list) =
        patterns |> List.tryFind txt.StartsWith

    let rec countConsonantsBeforeY (txt: string) (n: int) =
        match txt.[0..0] with
        | "y" -> n
        | ch when not (List.contains ch coreVowels) -> countConsonantsBeforeY txt.[1..] (n + 1)
        | _ -> 0

    let pigifyWord (w: string) =
        if beginsWithAny w vowelStarters then
            w + "ay"
        else
            match beginsWith w consonantClusters with
            | Some cluster -> w.Substring(cluster.Length) + cluster + "ay"
            | None ->
                let letters = w |> Seq.toList
                match letters with
                | first :: 'q' :: 'u' :: rest ->
                    strFromChars (rest @ [first; 'q'; 'u']) + "ay"
                | first :: rest ->
                    match countConsonantsBeforeY w 0 with
                    | cnt when cnt > 0 -> w.[cnt..] + w.[0..cnt-1] + "ay"
                    | _ -> strFromChars (rest @ [first]) + "ay"
                | [] -> failwith "Invalid word"

    input.Split(' ')
    |> Array.map pigifyWord
    |> joinWords
