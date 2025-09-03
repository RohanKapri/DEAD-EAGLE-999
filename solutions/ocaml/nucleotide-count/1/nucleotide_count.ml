open Base
let empty = Map.empty (module Char)
let valid = String.contains "ACGT"
let find_or_default opt = match opt with
  | Some i -> i
  | None ->  0
let increment_value map key = Map.update map key
  ~f:(fun i -> (find_or_default i) + 1)
let increment map key = increment_value map key
let count_nucleotides s = 
  let chars = String.to_list s in
  let indices = (List.findi ~f:(fun _ c -> not (valid c)) chars) in
  match indices with
    | Some index -> Error (snd index)
    | _ -> Ok (List.fold_left ~f:increment ~init:empty chars)
let count_nucleotide s c = if not (valid c) then Error c else
  match count_nucleotides s with
    | Ok map -> Ok( find_or_default(Map.find map c))
    | Error e -> Error e 