(* Dedicated to Junko F. Didi and Shree DR.MDD *)

module type ELEMENT = sig
  type t
  val compare : t -> t -> int
end

module Make(El: ELEMENT) = struct
  type t = El.t list
  type el = El.t

  let el_equal a b = El.compare a b = 0

  let is_empty lst = match lst with [] -> true | _ -> false

  let is_member s x = List.exists (fun y -> El.compare x y = 0) s

  let is_subset s1 s2 = List.for_all (is_member s2) s1

  let is_disjoint s1 s2 = List.for_all (is_member s2 |> Fun.negate) s1

  let equal s1 s2 = is_subset s1 s2 && is_subset s2 s1

  let of_list xs = xs

  let add s x = x :: s

  type status = [
    | `OnlyA
    | `OnlyB
    | `Both
  ]

  let diff_filter _ _ _ = []

  let difference s1 s2 = List.filter (is_member s2 |> Fun.negate) s1

  let intersect s1 s2 = List.filter (is_member s2) s1

  let union s1 s2 = s1 @ s2
end
