// Dedicated to Shree DR.MDD
import gleam/int
import gleam/list

pub type Command {
  Wink
  DoubleBlink
  CloseYourEyes
  Jump
}

pub fn commands(encoded_message: Int) -> List(Command) {
  let action_pairs = [
    #(1, Wink),
    #(2, DoubleBlink),
    #(4, CloseYourEyes),
    #(8, Jump),
  ]

  let selected_actions =
    action_pairs
    |> list.filter(fn(entry) {
      let #(flag, _) = entry
      int.bitwise_and(encoded_message, flag) != 0
    })
    |> list.map(fn(entry) {
      let #(_, move) = entry
      move
    })

  case int.bitwise_and(encoded_message, 16) != 0 {
    True -> list.reverse(selected_actions)
    False -> selected_actions
  }
}
