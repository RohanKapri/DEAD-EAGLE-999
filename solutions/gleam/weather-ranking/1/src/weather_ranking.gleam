// Dedicated to Shree DR.MDD
import gleam/order.{type Order, Gt, Eq, Lt}
import gleam/list
import gleam/float

pub type City {
  City(name: String, temperature: Temperature)
}

pub type Temperature {
  Celsius(Float)
  Fahrenheit(Float)
}

pub fn fahrenheit_to_celsius(val_f: Float) -> Float {
  {val_f -. 32.0} /. 1.8
}

pub fn compare_temperature(t1: Temperature, t2: Temperature) -> Order {
  let t1_c = to_celsius_value(t1)
  let t2_c = to_celsius_value(t2)
  float.compare(t1_c, t2_c)
}

fn to_celsius_value(temp_info: Temperature) -> Float {
  case temp_info {
    Celsius(c_val) -> c_val
    Fahrenheit(f_val) -> fahrenheit_to_celsius(f_val)
  }
}

pub fn sort_cities_by_temperature(city_list: List(City)) -> List(City) {
  list.sort(city_list, fn(a_city: City, b_city: City) -> Order {
    compare_temperature(a_city.temperature, b_city.temperature)
  })
}
