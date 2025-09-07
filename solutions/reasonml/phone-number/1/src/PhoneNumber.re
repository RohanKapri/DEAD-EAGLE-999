let phoneNumber = n =>
  Js.String.replaceByRe([%re "/[^0-9]/g"], "", n)
  |> Js.String.match([%re "/^1?([2-9]\d{2}[2-9]\d{6})$/"])
  |> Belt.Option.map(_, Array.get(_, 1));