module BinarySearch
let crack (input: 'T list) =
    let split = input.Length/2
    input.[..split-1],input.[split],input.[split+1..]
let rec findRec input value =
    match input with
    | [i,x] when x = value -> Some i
    | [_,x] when x <> value -> None
    | [] -> None
    | several when several.Length > 1 ->
        let left,center,right = crack several
        match left,center,right with
        | _,(i,x),_ when x = value -> Some i
        | left,(_,x),_ when value < x -> findRec left value
        | _,(_,x),right when value > x -> findRec right value
        | _ -> failwith "oops: unexpected crack"
    | _ -> failwith "oops: unexpected input"
let find input value =
    let numbered = input |> Array.mapi (fun i x -> i,x) |> List.ofSeq
    findRec numbered value