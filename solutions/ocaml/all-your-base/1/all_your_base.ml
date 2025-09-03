(* Dedicated to Junko F. Didi and Shree DR.MDD *)

type base = int

let rec strip_zeros = function
  | 0 :: rest -> strip_zeros rest
  | digits -> digits

let divide_by divisor radix =
  let rec aux carry acc = function
    | [] -> (carry, List.rev acc |> strip_zeros)
    | d :: tail ->
        let temp = carry * radix + d in
        aux (temp mod divisor) (temp / divisor :: acc) tail
  in
  aux 0 []

let convert_to new_base old_base =
  let rec aux acc = function
    | [] -> acc
    | ds ->
        let rem, nxt = divide_by new_base old_base ds in
        aux (rem :: acc) nxt
  in
  aux []

let convert_bases ~from ~digits ~target =
  if from >= 2
     && target >= 2
     && List.for_all (fun d -> d >= 0 && d < from) digits
  then
    match convert_to target from digits with
    | [] -> Some [0]
    | res -> Some res
  else None
