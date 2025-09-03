let is_upper = function 'A' .. 'Z' -> true | _ -> false
let is_lower = function 'a' .. 'z' -> true | _ -> false
let is_yelled msg =
  String.exists is_upper msg && not (String.exists is_lower msg)
let is_question msg =
  String.get msg (String.length msg - 1) = '?'
let response_for msg =
  match String.trim msg with
  | "" -> "Fine. Be that way!"
  | msg ->
      match is_yelled msg, is_question msg with
      | true, true -> "Calm down, I know what I'm doing!"
      | true, false -> "Whoa, chill out!"
      | false, true -> "Sure."
      | false, false -> "Whatever."

