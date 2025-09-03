let is_pangram str =
  let str = String.lowercase_ascii str in
  Seq.init 26 Char.(fun i -> code 'a' + i |> chr)
  |> Seq.for_all (String.contains str)
