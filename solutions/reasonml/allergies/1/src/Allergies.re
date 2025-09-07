let allergies = [|"eggs", "peanuts", "shellfish", "strawberries", "tomatoes", "chocolate", "pollen", "cats"|];

let rec scoreToAllergies = s =>
  switch (s) {
  | 0 => []
  | _ => List.append([s mod 2], scoreToAllergies(s / 2))
  };

let toList = s =>
  s mod 256 |> scoreToAllergies |> List.mapi((i, x) => x == 1 ? allergies[i] : "") |> List.filter(x => x != "");

let isAllergicTo = (x, score) => score |> toList |> List.exists(y => y == x);