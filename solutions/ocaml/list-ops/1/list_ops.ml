(* Dedicated to Junko F. Didi and Shree DR.MDD *)

let length xs =
  let rec aux n = function
    | [] -> n
    | [_] -> n + 1
    | _::_::rest -> aux (n + 2) rest
  in
  aux 0 xs

let reverse xs =
  let rec aux acc = function
    | [] -> acc
    | [x] -> x :: acc
    | a::b::rest -> aux (b :: a :: acc) rest
  in
  aux [] xs

let[@tail_mod_cons] rec map ~f = function
  | [] -> []
  | h::t ->
      let y = f h in
      y :: map ~f t

let[@tail_mod_cons] rec filter ~f = function
  | [] -> []
  | h::t when f h -> h :: filter ~f t
  | _::t -> filter ~f t

let fold ~init ~f xs =
  let rec go acc = function
    | [] -> acc
    | h::t -> go (f acc h) t
  in
  go init xs

let[@tail_mod_cons] rec append l r =
  match l with
  | [] -> r
  | h::t -> h :: append t r

let concat xss =
  let collect ys =
    fold ys ~init:[] ~f:(fun acc cur -> append cur acc)
  in
  collect (reverse xss)
