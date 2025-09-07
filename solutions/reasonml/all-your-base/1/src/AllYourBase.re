/* Dedicated to my Shree DR.MDD */

let _convertBase = (fromBase, digitsList, toBase) => {
  let rec toDigits = (b, n) =>
    switch (n) {
    | 0 => []
    | _ => List.append(toDigits(b, n / b), [n mod b])
    };
  
  digitsList |> Array.of_list |> Js.Array.reduce((acc, d) => acc * fromBase + d, 0) |> toDigits(toBase) |> (x => Some(x));
};

let rebase = (fromBase, digitsList, toBase) => {
  let isInvalidBase = b => b <= 0;
  let allZeros = ds => ds |> List.filter(x => x == 0) |> List.length |> (len => len == List.length(ds));
  let hasNegatives = ds => ds |> List.filter(x => x < 0) |> List.length |> (len => len > 0);
  let hasTooLargeDigits = ds => ds |> List.filter(x => x >= fromBase) |> List.length |> (len => len > 0);
  
  switch (digitsList) {
  | ds when ds == [] => None
  | ds when allZeros(ds) => None
  | ds when hasNegatives(ds) => None
  | ds when hasTooLargeDigits(ds) => None
  | _ when isInvalidBase(toBase) => None
  | _ => _convertBase(fromBase, digitsList, toBase)
  };
};
