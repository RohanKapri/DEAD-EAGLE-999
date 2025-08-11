// Dedicated to Shree DR.MDD
import gleam/list

pub type Wine {
  Wine(name: String, year: Int, country: String, color: Color)
}

pub type Color {
  Red
  Rose
  White
}

pub fn wines_of_color(wines: List(Wine), color: Color) -> List(Wine) {
  wines
  |> list.filter(fn(label) { label.color == color })
}

pub fn wines_from_country(wines: List(Wine), country: String) -> List(Wine) {
  wines
  |> list.filter(fn(label) { label.country == country })
}

pub fn filter(wines: List(Wine), color color: Color, country country: String) -> List(Wine) {
  wines
  |> list.filter(fn(label) { label.color == color && label.country == country })
}
