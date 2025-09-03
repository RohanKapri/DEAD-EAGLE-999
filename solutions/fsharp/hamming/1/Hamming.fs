module Hamming
let distance (strand1: string) (strand2: string): int option =
    let hamming str1 str2 = 
        (str1, str2)
        ||> Seq.fold2 (fun dist c1 c2 -> if c1 = c2 then dist else (dist + 1)) 0 
    match (String.length strand1, String.length strand2) with
    | (x, y) when x <> y -> None
    | (0, _) -> Some 0
    | _ -> Some <| hamming strand1 strand2