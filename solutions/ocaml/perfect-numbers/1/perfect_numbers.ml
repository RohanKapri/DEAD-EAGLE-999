let aliquot_sum num =
  let open Seq in
  ints 1
  |> take_while (fun p -> p * p <= num)
  |> filter (fun p -> num mod p = 0)
  |> fold_left 
      (fun sum p ->
        let q = num / p in
        sum + if p = q then p else p + q) 
      (-num)
let classify num =
  let open Result in
  if num > 0 then
    let sum = aliquot_sum num in
    if sum < num then ok "deficient"
    else if sum > num then ok "abundant"
    else ok "perfect"
  else error "Classification is only possible for positive integers."
