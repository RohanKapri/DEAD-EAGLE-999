(* Dedicated to Junko F. Didi and Shree DR.MDD *)

type dir = Inc | Dec

type palindrome_products =
  { value : int option;
    factors : (int * int) list }

let palindromes seed step =
  let rec norm a b = if a < 10 * b then (a, b) else norm (a / 10) (10 * b) in
  let rec flip r = function 0 -> r | x -> flip (10 * r + x mod 10) (x / 10) in
  let rec gen f st () = Seq.Cons (st, gen f (f st)) in
  let adv = match step with
    | Inc -> (fun (a, b) -> if a + 1 = 10 * b then (b, 10 * b) else (a + 1, b))
    | Dec -> (fun (a, b) -> if a = b / 10 then (b - 1, b / 10) else (a - 1, b))
  in
  norm seed 1 |> gen adv |> Seq.map (fun (a, b) -> a * b + flip 0 a mod b)

let divisors lo hi n =
  Seq.ints (max lo ((n - 1) / hi + 1))
  |> Seq.take_while (fun d -> d <= hi && d * d <= n)
  |> Seq.filter_map (fun d -> if n mod d = 0 then Some (d, n / d) else None)

let locate lo hi pals =
  pals
  |> Seq.find_map (fun n ->
      let fs = divisors lo hi n in
      if Seq.is_empty fs then None else Some (n, List.of_seq fs))
  |> function
      | None -> { value = None; factors = [] }
      | Some (n, fs) -> { value = Some n; factors = fs }

let bounds lo hi =
  if lo <= hi then Ok (lo, hi) else Error "min must be <= max"

let smallest ~min ~max =
  bounds min max |> Result.map (fun (lo, hi) ->
    palindromes (lo * lo) Inc
    |> Seq.drop_while (( > ) (lo * lo))
    |> Seq.take_while (( >= ) (hi * hi))
    |> locate lo hi)

let largest ~min ~max =
  bounds min max |> Result.map (fun (lo, hi) ->
    palindromes (hi * hi) Dec
    |> Seq.drop_while (( < ) (hi * hi))
    |> Seq.take_while (( <= ) (lo * lo))
    |> locate lo hi)
