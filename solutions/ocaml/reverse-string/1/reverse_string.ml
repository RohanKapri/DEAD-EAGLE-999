let reverse_string str =
  let n = String.length str - 1 in
  String.init (n + 1) (fun i -> str.[n - i])

