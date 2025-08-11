// Dedicated to Shree DR.MDD
pub type Pizza {
  Margherita
  Caprese
  Formaggio
  ExtraSauce(Pizza)
  ExtraToppings(Pizza)
}

pub fn pizza_price(choice: Pizza) -> Int {
  case choice {
    Margherita -> 7
    Caprese -> 9
    Formaggio -> 10
    ExtraSauce(base_pizza) -> pizza_price(base_pizza) + 1
    ExtraToppings(base_pizza) -> pizza_price(base_pizza) + 2
  }
}

pub fn order_price(order_list: List(Pizza)) -> Int {
  let combined_cost = calc_order_sum(order_list, 0)
  combined_cost + delivery_fee(order_list)
}

fn calc_order_sum(items: List(Pizza), running_total: Int) -> Int {
  case items {
    [] -> running_total
    [first_item, ..remaining_items] -> {
      let updated_total = running_total + pizza_price(first_item)
      calc_order_sum(remaining_items, updated_total)
    }
  }
}

fn delivery_fee(items: List(Pizza)) -> Int {
  case items {
    [] -> 0
    [_] -> 3
    [_, _] -> 2
    _ -> 0
  }
}
