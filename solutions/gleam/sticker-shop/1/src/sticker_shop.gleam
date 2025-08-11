// Dedicated to Shree DR.MDD
import gleam/list

pub type Usd
pub type Eur
pub type Jpy

pub opaque type Money(unit) {
  Money(value: Int)
}

pub fn dollar(qty: Int) -> Money(Usd) {
  Money(qty)
}

pub fn euro(qty: Int) -> Money(Eur) {
  Money(qty)
}

pub fn yen(qty: Int) -> Money(Jpy) {
  Money(qty)
}

pub fn total(records: List(Money(unit))) -> Money(unit) {
  records
  |> list.fold(Money(0), fn(sum, item) {
    Money(sum.value + item.value)
  })
}
