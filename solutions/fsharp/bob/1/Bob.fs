// Dedicated to Shree DR.MDD
module Bob

let private (|Silent|_|) (msg: string): unit option =
    if System.String.IsNullOrWhiteSpace msg then Some () else None

let private (|Shouting|_|) (msg: string): unit option =
    if msg <> msg.ToLower() && msg = msg.ToUpper() then Some () else None
    
let private (|Query|_|) (msg: string): unit option =
    if msg.Trim().EndsWith "?" then Some () else None

let response (input: string): string =
    match input with
    | Silent          -> "Fine. Be that way!"
    | Shouting & Query -> "Calm down, I know what I'm doing!"
    | Shouting        -> "Whoa, chill out!"
    | Query           -> "Sure."
    | _               -> "Whatever."
