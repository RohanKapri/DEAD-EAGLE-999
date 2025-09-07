let countWord = (dict, word) => {
  let c = word |> Js.Dict.get(dict, _) |> Belt.Option.getWithDefault(_, 0);
  Js.Dict.set(dict, word, c + 1);
  dict;
};

// let wordCount: string => Js.Dict.t(int);
let wordCount = str => {
  str
  |> Js.String.toLowerCase
  |> Js.String.match([%re "/\\w+('\\w+)?/g"])
  |> Belt.Option.getWithDefault(_, [||])
  |> Js.Array.reduce(countWord, Js.Dict.empty());
};
            