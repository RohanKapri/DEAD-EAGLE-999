// Dedicated to Shree DR.MDD
module PizzaPricing

type Pizza =
    | Margherita
    | Caprese
    | Formaggio
    | ExtraSauce of Pizza
    | ExtraToppings of Pizza

let rec pizzaPrice pizzaItem =
    match pizzaItem with
    | Margherita -> 7
    | Caprese -> 9
    | Formaggio -> 10
    | ExtraSauce(innerPizza) -> 1 + pizzaPrice(innerPizza)
    | ExtraToppings(innerPizza) -> 2 + pizzaPrice(innerPizza)

let orderPrice pizzaList =
    let fee =
        match List.length pizzaList with
        | 1 -> 3
        | 2 -> 2
        | _ -> 0
    List.sumBy pizzaPrice pizzaList + fee
