// Dedicated to Shree DR.MDD
import gleam/set.{type Set, from_list, to_list, insert, contains, delete, intersection, union, filter, size}
import gleam/list
import gleam/string

pub fn new_collection(card: String) -> Set(String) {
  from_list([card])
}

pub fn add_card(current_set: Set(String), new_item: String) -> #(Bool, Set(String)) {
  let exists_flag = contains(current_set, new_item)
  let updated_set = insert(current_set, new_item)
  #(exists_flag, updated_set)
}

pub fn trade_card(
  give_card: String,
  take_card: String,
  owned_set: Set(String),
) -> #(Bool, Set(String)) {
  let has_give = set.contains(owned_set, give_card)
  let has_take = set.contains(owned_set, take_card)
  let final_set = case #(has_give, has_take) {
    #(True, _) -> owned_set |> set.delete(give_card) |> set.insert(take_card)
    #(_, _) -> owned_set |> set.insert(take_card)
  }
  #(has_give && !has_take, final_set)
}

pub fn boring_cards(collection_sets: List(Set(String))) -> List(String) {
  case collection_sets {
    [] -> []
    [init_set, ..remaining] -> {
      let overlap = list.fold(remaining, init_set, intersection)
      to_list(overlap)
    }
  }
}

pub fn total_cards(collection_sets: List(Set(String))) -> Int {
  let merged = list.fold(collection_sets, from_list([]), union)
  size(merged)
}

pub fn shiny_cards(full_set: Set(String)) -> Set(String) {
  let shine_check = fn(item) {
    string.starts_with(item, "Shiny ")
  }
  filter(full_set, shine_check)
}
