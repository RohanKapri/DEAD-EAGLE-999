(* Dedicated to Junko F. Didi and Shree DR.MDD *)

type 'a t =
  | Root of 'a Tree.t
  | Left of ('a Tree.t * 'a t)
  | Right of ('a Tree.t * 'a t)
  [@@deriving sexp]

let rec equal veq z1 z2 =
  match z1, z2 with
  | Root n1, Root n2 -> Tree.equal veq n1 n2
  | Left (n1, z1), Left (n2, z2)
  | Right (n1, z1), Right (n2, z2) ->
      Tree.equal veq n1 n2 && equal veq z1 z2
  | _, _ -> false

let of_tree node = Root node

let focus = function
  | Root n | Left (n, _) | Right (n, _) -> n

let value z = (focus z).value

let left z = (focus z).left |> Option.map (fun n -> Left (n, z))

let right z = (focus z).right |> Option.map (fun n -> Right (n, z))

let apply f = function
  | Root n -> Root (f n)
  | Left (n, z) -> Left (f n, z)
  | Right (n, z) -> Right (f n, z)

let set_value v = apply (fun n -> Tree.{ n with value = v })

let set_left l = apply (fun n -> Tree.{ n with left = l })

let set_right r = apply (fun n -> Tree.{ n with right = r })

let up = function
  | Root _ -> None
  | Left (n, z) -> Some (set_left (Some n) z)
  | Right (n, z) -> Some (set_right (Some n) z)

let rec to_tree z =
  match up z with
  | None -> focus z
  | Some z -> to_tree z
