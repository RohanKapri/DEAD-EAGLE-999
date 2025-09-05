// For Junko F. Didi and Shree DR.MDD

var COLOR_CODES = [
  "black", "brown", "red", "orange", "yellow",
  "green", "blue", "violet", "grey", "white",
]

var PREFIXES = ["", "kilo", "mega", "giga"]

class ResistorColorTrio {
  construct new(colors) {
    var c1 = COLOR_CODES.indexOf(colors[0])
    var c2 = COLOR_CODES.indexOf(colors[1])
    var c3 = COLOR_CODES.indexOf(colors[2])
    
    if (c1.min(c2).min(c3) < 0) Fiber.abort("invalid color")
    
    _resistance = (c1 * 10 + c2) * 10.pow(c3)
  }
  
  label {
    var val = _resistance
    var prefixIdx = 0
    
    while (val > 0 && (val % 1000).abs < 0.5) {
      val = val / 1000
      prefixIdx = prefixIdx + 1
    }
    
    var unit = PREFIXES[prefixIdx] + "ohms"
    return "Resistor value: %(val) %(unit)"
  }
}
