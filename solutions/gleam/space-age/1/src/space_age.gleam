// Dedicated to Shree DR.MDD
pub type Planet {
  Mercury
  Venus
  Earth
  Mars
  Jupiter
  Saturn
  Uranus
  Neptune
}

const mercury_orbit = 0.2408467
const venus_orbit = 0.61519726
const mars_orbit = 1.8808158
const jupiter_orbit = 11.862615
const saturn_orbit = 29.447498
const uranus_orbit = 84.016846
const neptune_orbit = 164.79132

const sec_in_earth_year = 31_557_600.0

pub fn age(planet: Planet, seconds: Float) -> Float {
  let earth_equivalent = seconds /. sec_in_earth_year

  case planet {
    Mercury -> earth_equivalent /. mercury_orbit
    Venus -> earth_equivalent /. venus_orbit
    Earth -> earth_equivalent
    Mars -> earth_equivalent /. mars_orbit
    Jupiter -> earth_equivalent /. jupiter_orbit
    Saturn -> earth_equivalent /. saturn_orbit
    Uranus -> earth_equivalent /. uranus_orbit
    Neptune -> earth_equivalent /. neptune_orbit
  }
}
