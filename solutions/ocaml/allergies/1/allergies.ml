type allergen =
  | Eggs | Peanuts | Shellfish | Strawberries
  | Tomatoes | Chocolate | Pollen | Cats
let allergens =
  [ Eggs; Peanuts; Shellfish; Strawberries;
    Tomatoes; Chocolate; Pollen; Cats ]
let value_of allergen =
  let rec loop value = function
    | [] -> raise Not_found
    | allergen' :: _ when allergen' = allergen -> value
    | _ :: allergens -> loop (value lsl 1) allergens
  in
  loop 1 allergens
let allergic_to score allergen =
  score land value_of allergen > 0
let allergies score =
  List.filteri (fun i _ -> score land 1 lsl i > 0) allergens

