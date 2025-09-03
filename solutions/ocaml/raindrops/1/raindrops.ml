let prime_factor num factor word =
  if num mod factor = 0 then word else ""

let raindrop num =
  let drop = Printf.sprintf "%s%s%s"
      (prime_factor num 3 "Pling")
      (prime_factor num 5 "Plang")
      (prime_factor num 7 "Plong") in
  if drop = "" then string_of_int num else drop