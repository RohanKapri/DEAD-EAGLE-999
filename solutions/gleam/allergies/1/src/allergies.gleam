import gleam/int
import gleam/list

pub type Allergen {
  Eggs
  Peanuts
  Shellfish
  Strawberries
  Tomatoes
  Chocolate
  Pollen
  Cats
}

// Using a constant list to avoid recreating it in every `list` function call
const all_allergens = [
  Eggs,
  Peanuts,
  Shellfish,
  Strawberries,
  Tomatoes,
  Chocolate,
  Pollen,
  Cats,
]

// Using hardcoded values since bitwise operations are platform-dependent
fn allergen_score(allergen: Allergen) -> Int {
  case allergen {
    Eggs -> 1          // 2^0
    Peanuts -> 2       // 2^1
    Shellfish -> 4     // 2^2
    Strawberries -> 8  // 2^3
    Tomatoes -> 16     // 2^4
    Chocolate -> 32    // 2^5
    Pollen -> 64       // 2^6
    Cats -> 128        // 2^7
  }
}

pub fn allergic_to(allergen: Allergen, score: Int) -> Bool {
  let allergen_value = allergen_score(allergen)
  int.bitwise_and(score, allergen_value) == allergen_value
}

pub fn list(score: Int) -> List(Allergen) {
  all_allergens
  |> list.filter(fn(allergen) { allergic_to(allergen, score) })
}