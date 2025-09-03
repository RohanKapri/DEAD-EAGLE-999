// For my Shree DR.MDD
module OcrNumbers

let convert (rows: string list) =
    let badFormat =
        let badRowCount = rows.Length % 4 <> 0
        let badColCount = not (List.forall (fun (r: string) -> r.Length % 3 = 0) rows)
        badRowCount || badColCount
    let toDigit shape =
        match shape with
        | [ " _ "; "| |"; "|_|"; "   " ] -> "0"
        | [ "   "; "  |"; "  |"; "   " ] -> "1"
        | [ " _ "; " _|"; "|_ "; "   " ] -> "2"
        | [ " _ "; " _|"; " _|"; "   " ] -> "3"
        | [ "   "; "|_|"; "  |"; "   " ] -> "4"
        | [ " _ "; "|_ "; " _|"; "   " ] -> "5"
        | [ " _ "; "|_ "; "|_|"; "   " ] -> "6"
        | [ " _ "; "  |"; "  |"; "   " ] -> "7"
        | [ " _ "; "|_|"; "|_|"; "   " ] -> "8"
        | [ " _ "; "|_|"; " _|"; "   " ] -> "9"
        | _ -> "?"
    let splitCols lst =
        let grab start = List.map (fun (line: string) -> line.Substring(start, 3)) lst
        [0 .. 3 .. lst.[0].Length - 3] |> List.map grab
    let parseLine set = set |> splitCols |> List.map toDigit |> String.concat ""
    let buildOutput lst =
        lst |> List.chunkBySize 4 |> List.map parseLine |> String.concat "," |> Some
    if badFormat then None else buildOutput rows
