open Base
let word_count phrase =
  String.map phrase ~f:(fun c ->
      if Char.is_alphanum c || Char.equal '\'' c then Char.lowercase c else ' ')
  |> String.split ~on:' '
  |> List.map ~f:(String.strip ~drop:(Char.equal '\''))
  |> List.filter ~f:(Fn.non String.is_empty)
  |> List.fold
       ~init:(Map.empty (module String))
       ~f:(Map.update ~f:(function None -> 1 | Some n -> n + 1))
