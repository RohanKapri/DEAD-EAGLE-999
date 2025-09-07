let encode = s =>
  s
  |> Js.String.unsafeReplaceBy1([%re "/(.)\\1+/g"], (s, ch, _, _) =>
       Printf.sprintf("%d%s", String.length(s), ch)
     );

let decode = s =>
  s
  |> Js.String.unsafeReplaceBy2([%re "/(\\d+)(\\D)/g"], (_, len, ch, _, _) =>
       ch |> Js_string.repeat(len |> int_of_string)
     );