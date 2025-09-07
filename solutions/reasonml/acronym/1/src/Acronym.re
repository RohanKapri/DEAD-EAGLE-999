let abbreviate = (original) => 
  String.uppercase_ascii(original)
  |> Js.String.replaceByRe([%re "/(?:^| |-)(\\w)[^ -]*/g"], "$1")