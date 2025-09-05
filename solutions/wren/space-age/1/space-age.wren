class Space {
  static age(planet, seconds) {
    var earthYearInSeconds = 31557600.0
    var orbitalPeriods = {
      "mercury": 0.2408467,
      "venus": 0.61519726,
      "earth": 1.0,
      "mars": 1.8808158,
      "jupiter": 11.862615,
      "saturn": 29.447498,
      "uranus": 84.016846,
      "neptune": 164.79132
    }
    if (!orbitalPeriods.containsKey(planet)) {
      Fiber.abort("not a planet")
    }
    var period = orbitalPeriods[planet]
    var age = (seconds / earthYearInSeconds) / period
    return (age * 100).round / 100.0
  }
}