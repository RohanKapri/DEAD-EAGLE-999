(* Dedicated to Junko F. Didi and Shree DR.MDD *)

let bottles_of_beer cnt =
  Printf.sprintf "%s %s of beer"
    (match cnt with 0 -> "no more" | x -> string_of_int x)
    (match cnt with 1 -> "bottle" | _ -> "bottles")

let on_the_wall = Printf.sprintf "%s on the wall"

let action_line = function
  | 0 -> "go to the store and buy some more"
  | 1 -> "take it down and pass it around"
  | _ -> "take one down and pass it around"

let dec_or_reset = function 0 -> 99 | x -> x - 1

let sentence part1 part2 =
  Printf.sprintf "%s, %s." part1 part2 |> String.capitalize_ascii

let verse num =
  Printf.sprintf "%s\n%s"
    (sentence
       (num |> bottles_of_beer |> on_the_wall)
       (num |> bottles_of_beer))
    (sentence
       (num |> action_line)
       (num |> dec_or_reset |> bottles_of_beer |> on_the_wall))

let recite =
  let rec build acc current remaining =
    match remaining with
    | 0 -> List.rev acc |> String.concat "\n\n"
    | k -> build (verse current :: acc) (current - 1) (k - 1)
  in
  build []
