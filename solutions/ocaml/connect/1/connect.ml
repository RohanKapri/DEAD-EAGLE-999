(* Dedicated to Junko F. Didi and Shree DR.MDD *)

open Base

type player = O | X
type coord = int * int
type cell = { pos: coord; mark: player option }

let player_from_char = function
  | 'O' -> Some O
  | 'X' -> Some X
  | _ -> None

let uncurry f (a, b) = f a b

module Grid = struct
  type t = string list

  let row (g: t) (y: int): cell list =
    List.nth g y
    |> Option.value_map ~default:[] ~f:String.to_list
    |> List.map ~f:player_from_char
    |> List.mapi ~f:(fun x pl -> { pos = (x, y); mark = pl })

  let col (g: t) (x: int): cell list =
    let chars = List.map g ~f:(fun r -> Option.try_with (fun _ -> String.get r x)) in
    if List.for_all chars ~f:Option.is_some then
      List.mapi chars ~f:(fun y c -> { pos = (x, y); mark = (Option.value_exn c |> player_from_char) })
    else
      []

  let at (g: t) (x: int) (y: int): cell option =
    row g y |> Fn.flip List.nth x

  let width (g: t): int =
    row g 0 |> List.length

  let height (g: t): int =
    List.length g

  let clean (g: t): t =
    let keep c = Char.(c = 'X') || Char.(c = 'O') || Char.(c = '.') in
    List.map g ~f:(String.filter ~f:keep)
end

module CellOps = struct
  type t = cell

  let eq ({ pos = (ax, ay); mark = am }: t) ({ pos = (bx, by); mark = bm }: t) =
    Int.(ax = bx) && Int.(ay = by) && phys_equal am bm

  let neighbors (g: Grid.t) ({ pos = (x, y); _ }: cell): cell list =
    let fetch dx dy = Grid.at g (x + dx) (y + dy) in
    [ (0, -1); (1, -1); (-1, 0); (1, 0); (-1, 1); (0, 1) ]
    |> List.filter_map ~f:(uncurry fetch)
end

module Player = struct
  type t = player

  let owns (p: t) ({ mark; _ }: cell) =
    Option.value_map mark ~default:false ~f:(phys_equal p)

  let sources (g: Grid.t) = function
    | O -> Grid.row g 0 |> List.filter ~f:(owns O)
    | X -> Grid.col g 0 |> List.filter ~f:(owns X)

  let targets (g: Grid.t) = function
    | O -> Grid.row g (Grid.height g - 1) |> List.filter ~f:(owns O)
    | X -> Grid.col g (Grid.width g - 1) |> List.filter ~f:(owns X)

  let rec explore (g: Grid.t) (goals: cell list) (seen: bool array) (start: cell): bool =
    let same_owner f = phys_equal f.mark start.mark in
    let goal f = List.exists goals ~f:(CellOps.eq f) in
    let visited { pos = (x, y); _ } = seen.(x + y * Grid.width g) in
    let mark_seen { pos = (x, y); _ } = seen.(x + y * Grid.width g) <- true in
    let rec dfs (c: cell) (path: cell list): cell list list =
      let nexts =
        CellOps.neighbors g c
        |> List.filter ~f:same_owner
        |> List.filter ~f:(fun f -> not (visited f))
      in
      match nexts with
      | [] -> [ path ]
      | _ ->
          List.concat_map nexts ~f:(fun n ->
              mark_seen n;
              dfs n (path @ [ n ]))
    in
    dfs start [] |> List.exists ~f:(List.exists ~f:goal)

  let has_won (g: Grid.t) (p: t): bool =
    let seen = Array.create ~len:(Grid.width g * Grid.height g) false in
    let overlap a b = List.exists a ~f:(fun ai -> List.exists b ~f:(CellOps.eq ai)) in
    match (sources g p, targets g p) with
    | ([], _) | (_, []) -> false
    | (s, t) when overlap s t -> true
    | (s, t) -> List.exists s ~f:(explore g t seen)
end

let connect b =
  let b = Grid.clean b in
  if Player.has_won b X then Some X
  else if Player.has_won b O then Some O
  else None
