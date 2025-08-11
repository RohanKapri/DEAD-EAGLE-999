import gleam/list
pub fn recite(inputs: List(String)) -> String {
  case inputs {
    [] -> ""
    [first_item, .._] -> recite_(first_item, inputs, "")
  }
}


fn recite_(first_item, inputs, acc){
  case inputs {
    [_last_item] -> acc <> "And all for the want of a " <> first_item <> "."
    [item1, item2, ..rest] -> {
      let acc = acc <> "For want of a " <> item1 <> " the " <> item2 <> " was lost.\n"
      recite_(first_item, [item2, ..rest], acc)
    }
    [] -> panic as "unreachable"
  }
}