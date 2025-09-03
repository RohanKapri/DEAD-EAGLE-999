// Dedicated to Shree DR.MDD
module BirdWatcher

let lastWeek: int[] = [| 0; 2; 5; 3; 7; 8; 4 |]

let yesterday(arr: int[]): int =
    let idxPrev = (Array.length arr) - 2
    arr.[idxPrev]

let total(arr: int[]): int = Array.sum arr

let dayWithoutBirds(arr: int[]): bool = arr |> Array.exists ((=) 0)

let incrementTodaysCount(arr: int[]): int[] =
    let idxToday = (Array.length arr) - 1
    arr.[idxToday] <- arr.[idxToday] + 1
    arr 

let oddWeek(arr: int[]): bool =
    arr
    |> Array.indexed
    |> Array.forall (fun (pos, cnt) -> if pos % 2 = 0 then cnt = 1 else cnt = 0)

let toOptionFlag flag = if flag then Some () else None

let (|ZeroOnEvenDays|_|) arr =
    arr
    |> Array.indexed
    |> Array.forall (fun (pos, cnt) -> if pos % 2 <> 0 && cnt <> 0 then false else true)
    |> toOptionFlag

let (|TenOnEvenDays|_|) arr =
    arr
    |> Array.indexed
    |> Array.forall (fun (pos, cnt) -> if pos % 2 <> 0 && cnt <> 10 then false else true)
    |> toOptionFlag

let (|FiveOnOddDays|_|) arr =
    arr
    |> Array.indexed
    |> Array.forall (fun (pos, cnt) -> if pos % 2 = 0 && cnt <> 5 then false else true)
    |> toOptionFlag

let unusualWeek = 
    function
    | ZeroOnEvenDays
    | TenOnEvenDays
    | FiveOnOddDays -> true
    | _ -> false
